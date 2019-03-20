PIPELINEROOT := ../
DIR_NAME := bgeeCalls/
include $(PIPELINEROOT)Makefile.common

TRANSCRIPTOME_FILE_SUFFIX 		:= transcriptome.fa
TRANSCRIPTOME_FILE_EXT    		:= .xz
REF_INTERGENIC_FOLDER			:= $(OUTPUT_DIR)ref_intergenic/
REF_INTERGENIC_FILE_NAME		:= intergenic_reference_SPECIES_ID.tsv
# use $(TMPDIR) because not enough free space on home partition
FASTA_INTERGENIC_FOLDER			:= $(TMPDIR)$(DIR_NAME)fasta_intergenic/
SUM_ABUNDANCE_FILE_NAME			:= sum_abundance_gene_level+fpkm+intergenic+classification_SPECIES_ID.tsv
SUM_ABUNDANCE_FILE_PATTERN		:= sum_abundance_gene_level*.tsv
RNASEQ_GAUSSIAN_CHOICE 			:= $(GENERATED_FILES_DIR)$(RNASEQPATH)gaussian_choice_by_species.txt


all: copy_intergenic_files

create_fasta_intergenic: create_reference_intergenic
	# Copy all transcriptome fasta files
	@scp $(VITLOGIN)@$(VITHOST):$(RNASEQ_VITALIT_GTF)*$(ENSRELEASE).$(TRANSCRIPTOME_FILE_SUFFIX)$(TRANSCRIPTOME_FILE_EXT) $(FASTA_INTERGENIC_FOLDER) >> $@.tmp 2> $@.warn
	@scp $(VITLOGIN)@$(VITHOST):$(RNASEQ_VITALIT_GTF)*$(ENSMETAZOARELEASE).$(TRANSCRIPTOME_FILE_SUFFIX)$(TRANSCRIPTOME_FILE_EXT) $(FASTA_INTERGENIC_FOLDER) >> $@.tmp 2> $@.warn
	
	# create intergenic fasta files
	@perl create_intergenic_fasta.pl -bgee=$(BGEECMD) -ens_release=$(ENSRELEASE) -transcriptomes_folder=$(FASTA_INTERGENIC_FOLDER) -transcriptome_suffix=$(TRANSCRIPTOME_FILE_SUFFIX) -transcriptome_archive_ext=$(TRANSCRIPTOME_FILE_EXT) -ref_intergenic_dir=$(REF_INTERGENIC_FOLDER) >> $@.tmp 2> $@.warn
	@perl create_intergenic_fasta.pl -bgee=$(BGEECMD) -ens_release=$(ENSMETAZOARELEASE) -transcriptomes_folder=$(FASTA_INTERGENIC_FOLDER) -transcriptome_suffix=$(TRANSCRIPTOME_FILE_SUFFIX) -transcriptome_archive_ext=$(TRANSCRIPTOME_FILE_EXT) -ref_intergenic_dir=$(REF_INTERGENIC_FOLDER) >> $@.tmp 2> $@.warn
	
	# compress intergenic fasta files
	@find $(FASTA_INTERGENIC_FOLDER) -type f -name '*_intergenic.fa' -exec gzip --verbose --best {} \; >> $@.tmp 2> $@.warn
	@find $(FASTA_INTERGENIC_FOLDER) -type f -name '*_intergenic.fa' -exec gzip --verbose --best {} \; >> $@.tmp 2> $@.warn
	
	@$(MV) $@.tmp $@
	
create_reference_intergenic:
	# retrieve sum_abundance files
	@scp $(VITLOGIN)@$(VITHOST):$(RNASEQ_VITALIT_SUM_RES)$(SUM_ABUNDANCE_FILE_PATTERN) $(REF_INTERGENIC_FOLDER) > $@.tmp 2> $@.warn
	
	# retrieve gaussian_choice file
	@cp $(RNASEQ_VITALIT_GAUSSIAN_CHOICE) $(REF_INTERGENIC_FOLDER) > $@.tmp 2> $@.warn
	
	# for each sum_abundance file create reference intergenic text file
	@R CMD BATCH --no-save --no-restore '--args output_dir="$(REF_INTERGENIC_FOLDER)" sum_abundance_file_pattern="$(SUM_ABUNDANCE_FILE_NAME)" sum_abundance_dir="$(REF_INTERGENIC_FOLDER)" gaussian_file_path="$(RNASEQ_GAUSSIAN_CHOICE)" reference_intergenic_file_pattern="$(REF_INTERGENIC_FILE_NAME)"' create_intergenic_reference.R create_intergenic_reference.Rout > $@.tmp 2> $@.warn
	
	# delete local version of sum_abundance files
	@rm -rf $(REF_INTERGENIC_FOLDER)$(SUM_ABUNDANCE_FILE_PATTERN) > $@.tmp 2> $@.warn
	
	@$(MV) $@.tmp $@
	
# Copy intergenic files (fasta and reference) to ftp server
copy_intergenic_files: create_fasta_intergenic create_reference_intergenic
	# copy intergenic fasta files to the ftp
	@scp $(FASTA_INTERGENIC_FOLDER)*$(ENSRELEASE).intergenic.fa.gz $(FTPUSER)@$(FTPHOST):$(FTPFASTAINTERGENIC)  > $@.tmp 2> $@.warn
	@scp $(FASTA_INTERGENIC_FOLDER)*$(ENSMETAZOARELEASE).intergenic.fa.gz $(FTPUSER)@$(FTPHOST):$(FTPFASTAINTERGENIC) > $@.tmp 2> $@.warn

	@$(MV) $@.tmp $@
	

clean:
	@rm -rf $(REF_INTERGENIC_FOLDER)
	@rm -rf $(FASTA_INTERGENIC_FOLDER)
	@mkdir -p $(REF_INTERGENIC_FOLDER)
	@mkdir -p $(FASTA_INTERGENIC_FOLDER)
