#!/usr/bin/env perl

# Perl core modules
use strict;
use warnings;
use diagnostics;

use File::Path qw(make_path);
use Getopt::Long;
use Bio::SeqIO;
use Data::Dumper;



## Julien Wollbrett 11/10/2018
## This script allows creation of intergenic only fasta files. These files are used in the R package (name?) allowing user
## to define present/absent expression calls in his own RNA-Seq libraries.
## Basically, this script will :
##	1. Uncompress files
##	2. Parse transcriptome file and keep only intergenic region
##	3. create intergenic fasta file and copy them to the ftp
##	4. remove uncompressed transcriptome fasta files


# Define arguments & their default value
my ($ens_release, $transcriptomes_folder, $transcriptome_suffix, $transcriptome_archive_ext, $intergenic_pattern) = ('', '', '', '', '');
my %opts = ('ens_release=s'      				=> \$ens_release,
            'transcriptomes_folder=s'  			=> \$transcriptomes_folder, 
            'transcriptome_suffix=s'  			=> \$transcriptome_suffix, 
            'transcriptome_archive_ext=s'  		=> \$transcriptome_archive_ext, 
            'intergenic_pattern=s'   			=> \$intergenic_pattern, #regex matching all transcript IDs corresponding to intergenic regions in transcriptome fasta file
           );


# Check arguments
my $test_options = Getopt::Long::GetOptions(%opts);
if ( !$test_options || $ens_release eq '' || $transcriptomes_folder eq '' || $transcriptome_suffix eq '' || $transcriptome_archive_ext eq '' || $intergenic_pattern eq '') {
    print "\n\tInvalid or missing argument:
\te.g. $0 -ens_release=... -transcriptomes_folder=\$(OUTPUT_DIR) -transcriptome_suffix=\$(TRANSCRIPTOME_FILE_SUFFIX)  -transcriptome_archive_ext=\$(TRANSCRIPTOME_FILE_EXT) -intergenic_pattern=\$(INTERGENIC_PATTERN)
\t-ens_release=s          			Release version of ensembl (e.g 84).
\t-transcriptomes_folder=s     		Folder where transcriptome fasta files are stored.
\t-transcriptome_suffix=s       	End of the name common for all transcriptome fasta files (e.g transcriptome).
\t-transcriptome_ext=s       		Extension of sequence transcriptome files.  (e.g .fa).
\t-transcriptome_archive_ext=s   	Extension of compressed transcriptome files. (e.g .xz)
\t-intergenic_pattern=s  			Regex matching all transcript IDs corresponding to intergenic regions in transcriptome fasta files.
\n";
    exit 1;
}

# retrieve name of all files in transcriptomes folder
#  for each file
	# - uncompress
	# - parse file and keep only intergenic sequences
	# - write intergenic fasta file (compress?)
	# - delete transcriptome file
	
	
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
		}
		
		# Create intergenic file
		print "Start creation of : $intergenic_file\n";
		my $intergenic_file = $uncompressed_file;
		$intergenic_file =~ s/$transcriptome_suffix/intergenic\.fa/;
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
