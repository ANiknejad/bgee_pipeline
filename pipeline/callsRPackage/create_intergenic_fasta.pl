#!/usr/bin/env perl

# Perl core modules
use strict;
use warnings;
use diagnostics;

use File::Path qw(make_path);
use Getopt::Long;
use Bio::SeqIO;
use FindBin;
use lib "$FindBin::Bin/.."; # Get lib path for Utils.pm
use Utils;
use Data::Dumper;



## Julien Wollbrett 11/10/2018
## This script allows creation of intergenic only fasta files. These files are used in the R package (name?) allowing user
## to define present/absent expression calls in his own RNA-Seq libraries.
## Basically, this script will :
##	1. Uncompress files
##	2. Parse transcriptome file and keep only intergenic region
##	3. create intergenic fasta file
##	4. remove uncompressed transcriptome fasta files


# Define arguments & their default value
my ($bgee_connector, $ens_release, $transcriptomes_folder, $transcriptome_suffix, $transcriptome_archive_ext, $intergenic_pattern) = ('', '', '', '', '');
my %opts = ('bgee=s'       						=> \$bgee_connector,     # Bgee connector string
			'ens_release=s'      				=> \$ens_release,
            'transcriptomes_folder=s'  			=> \$transcriptomes_folder, 
            'transcriptome_suffix=s'  			=> \$transcriptome_suffix, 
            'transcriptome_archive_ext=s'  		=> \$transcriptome_archive_ext, 
            'intergenic_pattern=s'   			=> \$intergenic_pattern, #regex matching all transcript IDs corresponding to intergenic regions in transcriptome fasta file
           );


# Check arguments
my $test_options = Getopt::Long::GetOptions(%opts);
if ( !$test_options || $bgee_connector eq '' || $ens_release eq '' || $transcriptomes_folder eq '' || $transcriptome_suffix eq '' || $transcriptome_archive_ext eq '' || $intergenic_pattern eq '') {
    print "\n\tInvalid or missing argument:
\te.g. $0 -ens_release=... -transcriptomes_folder=\$(OUTPUT_DIR) -transcriptome_suffix=\$(TRANSCRIPTOME_FILE_SUFFIX)  -transcriptome_archive_ext=\$(TRANSCRIPTOME_FILE_EXT) -intergenic_pattern=\$(INTERGENIC_PATTERN)
\t-bgee      						Bgee connector string
\t-ens_release=s          			Release version of ensembl (e.g 84).
\t-transcriptomes_folder=s     		Folder where transcriptome fasta files are stored.
\t-transcriptome_suffix=s       	End of the name common for all transcriptome fasta files (e.g transcriptome).
\t-transcriptome_archive_ext=s   	Extension of compressed transcriptome files. (e.g .xz)
\t-intergenic_pattern=s  			Regex matching all transcript IDs corresponding to intergenic regions in transcriptome fasta files.
\n";
    exit 1;
}

# Bgee db connection
my $dbh = Utils::connect_bgee_db($bgee_connector);

# retrieve a map where key correspond to species and genus of species (e.g Homo_sapiens) and value correspond to ensembl id of the species
my $bgeeSpecies = $dbh->prepare('SELECT genus, species, speciesId FROM species');
$bgeeSpecies->execute()  or die $bgeeSpecies->errstr;
my %speNameToSpeId;
while(my @row = $bgeeSpecies->fetchrow_array()){
	# Some species names in bgee db contain more than one word (e.g lupus familiaris). 
	# For bgee transcriptome files, the species name always correspond to the last word of the name (e.g familiaris)
	# That's why we only keep the last word of species name
	my @speciesNames = split(/ /,$row[1]);
	my $species = $speciesNames[(scalar @speciesNames)-1];
	my $speciesFileName = "$row[0]_$species";
	$speNameToSpeId {$speciesFileName} = $row[2];
}

	
die "Invalid or missing [$transcriptomes_folder]: $?\n"  if ( !-e $transcriptomes_folder || !-d $transcriptomes_folder );

# open directory containing all compressed transcriptome fasta files
opendir (DIR, $transcriptomes_folder) or die $!;

# for each compressed transcriptome fasta file
while (my $file = readdir(DIR)) {
	if ($file =~ /.+$ens_release\.$transcriptome_suffix$transcriptome_archive_ext$/) {
		my $file_path = "$transcriptomes_folder$file";
		
		# remove archive extension to file name
		my $uncompressed_file = substr($file_path, 0, length($file_path) - length($transcriptome_archive_ext));
		# if file already exist we remove it
		if (-e $uncompressed_file) {  
			unlink $uncompressed_file;
		}
		
		# uncompress xz archive
		if ($transcriptome_archive_ext =~ /\.xz/) {
			print("Uncompress .xz file : $file_path\n");
			# uncompress
				if (system("unxz $file_path") != 0) {
				exit "Can not uncompress xz file : $file_path";
			}
		} else {
			exit("Can not uncompress $transcriptome_archive_ext archives");
		}
		
		# Create intergenic file
		$file =~ /^([^_]+_[a-zA-Z]+).*/;
		
		my $speciesId = $speNameToSpeId{$1};
		my $intergenic_file = "$transcriptomes_folder$speciesId\_intergenic.fa";
		print "Start creation of : $intergenic_file\n";
		my $seq_in  = Bio::SeqIO->new(-file => "$uncompressed_file", -format => "fasta");
		my $seq_out = Bio::SeqIO->new(-file => ">$intergenic_file", -format => "fasta");
		while(my $seq = $seq_in->next_seq) {
			my $transcript_id = $seq->primary_id;
			# keep only intergenic regions
 			if($transcript_id =~ /$intergenic_pattern/) {
				$seq_out->write_seq($seq);
  			}
 		}
  		print "$intergenic_file file has been created successfully\n";
  		# remove uncompressed transcriptomic file
  		unlink $uncompressed_file;
  		
	}
}
