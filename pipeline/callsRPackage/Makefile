PIPELINEROOT := ../
DIR_NAME := callsRPackage/
include $(PIPELINEROOT)Makefile.common

TRANSCRIPTOME_FILE_SUFFIX 		:= transcriptome
TRANSCRIPTOME_FILE_EXT    		:= .fa.xz
INTERGENIC_PATTERN		    	:= .*_[0-9]+_[0-9]+$

all: create_fasta_intergenic

create_fasta_intergenic:
	# Copy all transcriptome fasta files
	@scp $(VITLOGIN)@$(VITHOST):$(RNASEQ_VITALIT_GTF)*$(ENSRELEASE).$(TRANSCRIPTOME_FILE_SUFFIX)$(TRANSCRIPTOME_FILE_EXT) $(OUTPUT_DIR)
	# create intergenic fasta files
	@perl create_intergenic_fasta.pl -ens_release=$(ENSRELEASE) -transcriptome_folder=$(OUTPUT_DIR) -transcriptome_suffix=$(TRANSCRIPTOME_FILE_SUFFIX) -transcriptome_file_extension=$(TRANSCRIPTOME_FILE_EXT) -intergenic_pattern=$(INTERGENIC_PATTERN)
	# compress intergenic fasta files
	@find $(OUTPUT_DIR) -type f -name '$(ENSRELEASE).intergenic.fa' -exec gzip --verbose --best {} \;
	# copy intergenic fasta files to the ftp
	@scp $(OUTPUT_DIR)*intergenic.fa $(FTPPASS)@$(FTPUSER):$(FTPFASTAINTERGENIC) 

	
	