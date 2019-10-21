PIPELINEROOT := ../
DIR_NAME := bgeeCalls/
include $(PIPELINEROOT)Makefile.common

TRANSCRIPTOME_FILE_SUFFIX 		:= transcriptome.fa
TRANSCRIPTOME_FILE_EXT    		:= .xz
REF_INTERGENIC_FOLDER			:= $(OUTPUT_DIR)ref_intergenic/
REF_INTERGENIC_FILE_NAME		:= reference_intergenic_SPECIES_ID.tsv
NON_REF_INTERGENIC_FOLDER		:= $(OUTPUT_DIR)non_ref_intergenic/
NON_REF_INTERGENIC_FILE_NAME    := non_reference_intergenic_SPECIES_ID.tsv
# use $(TMPDIR) because not enough free space on home partition
FASTA_INTERGENIC_FOLDER			:= $(TMPDIR)$(DIR_NAME)fasta_intergenic/
SUM_ABUNDANCE_FILE_NAME			:= sum_abundance_gene_level+fpkm+intergenic+classification_SPECIES_ID.tsv
SUM_ABUNDANCE_FILE_PATTERN		:= sum_abundance_gene_level*.tsv
RNASEQ_GAUSSIAN_CHOICE 			:= $(GENERATED_FILES_DIR)$(RNASEQPATH)gaussian_choice_by_species.txt

all: 
	@echo "Which intergenic regions do you want to generate?"
	@echo "For reference intergenic run the command : make reference_intergenic"
	@echo "For non reference intergenic run the command : make non_reference_intergenic"

retrieve_sum_and_gaussian:
    # retrieve sum_abundance files
	@scp $(VITLOGIN)@$(VITHOST):$(RNASEQ_VITALIT_SUM_RES)$(SUM_ABUNDANCE_FILE_PATTERN) $(REF_INTERGENIC_FOLDER) > $@.tmp 2> $@.warn
	
	# retrieve gaussian_choice file
	@cp $(RNASEQ_VITALIT_GAUSSIAN_CHOICE) $(REF_INTERGENIC_FOLDER) > $@.tmp 2> $@.warn

create_text_ref_intergenic: retrieve_sum_and_gaussian
	# for each sum_abundance file create reference intergenic text file
	@R CMD BATCH --no-save --no-restore '--args output_dir="$(REF_INTERGENIC_FOLDER)" sum_abundance_file_pattern="$(SUM_ABUNDANCE_FILE_NAME)" sum_abundance_dir="$(REF_INTERGENIC_FOLDER)" gaussian_file_path="$(RNASEQ_GAUSSIAN_CHOICE)" reference_intergenic_file_pattern="$(REF_INTERGENIC_FILE_NAME)" type_of_intergenic="ref"' create_intergenic_reference.R create_intergenic_reference.Rout > $@.tmp 2> $@.warn
	
	# delete local version of sum_abundance files
	@rm -rf $(REF_INTERGENIC_FOLDER)$(SUM_ABUNDANCE_FILE_PATTERN) > $@.tmp 2> $@.warn
	
	@$(MV) $@.tmp $@
	
create_text_non_ref_intergenic: retrieve_sum_and_gaussian	
	# for each sum_abundance file create non reference intergenic text file
	@R CMD BATCH --no-save --no-restore '--args output_dir="$(REF_INTERGENIC_FOLDER)" sum_abundance_file_pattern="$(SUM_ABUNDANCE_FILE_NAME)" sum_abundance_dir="$(REF_INTERGENIC_FOLDER)" gaussian_file_path="$(RNASEQ_GAUSSIAN_CHOICE)" reference_intergenic_file_pattern="$(NON_REF_INTERGENIC_FILE_NAME)" type_of_intergenic="nonRef"' create_intergenic_reference.R create_intergenic_non_reference.Rout > $@.tmp 2> $@.warn
	
	# delete local version of sum_abundance files
	@rm -rf $(REF_INTERGENIC_FOLDER)$(SUM_ABUNDANCE_FILE_PATTERN) > $@.tmp 2> $@.warn
	
	@$(MV) $@.tmp $@

retrieve_transcriptomes:
	# Copy all transcriptome fasta files
	@scp $(VITLOGIN)@$(VITHOST):$(RNASEQ_VITALIT_GTF)*$(ENSRELEASE).$(TRANSCRIPTOME_FILE_SUFFIX)$(TRANSCRIPTOME_FILE_EXT) $(FASTA_INTERGENIC_FOLDER) >> $@.tmp 2> $@.warn
	@scp $(VITLOGIN)@$(VITHOST):$(RNASEQ_VITALIT_GTF)*$(ENSMETAZOARELEASE).$(TRANSCRIPTOME_FILE_SUFFIX)$(TRANSCRIPTOME_FILE_EXT) $(FASTA_INTERGENIC_FOLDER) >> $@.tmp 2> $@.warn
		
create_ref_intergenic: create_text_ref_intergenic retrieve_transcriptomes
	# create reference intergenic fasta files
	@perl create_intergenic_fasta.pl -bgee=$(BGEECMD) -ens_release=$(ENSRELEASE) -transcriptomes_folder=$(FASTA_INTERGENIC_FOLDER) -transcriptome_suffix=$(TRANSCRIPTOME_FILE_SUFFIX) -transcriptome_archive_ext=$(TRANSCRIPTOME_FILE_EXT) -ref_intergenic_dir=$(REF_INTERGENIC_FOLDER) >> $@.tmp 2> $@.warn
	@perl create_intergenic_fasta.pl -bgee=$(BGEECMD) -ens_release=$(ENSMETAZOARELEASE) -transcriptomes_folder=$(FASTA_INTERGENIC_FOLDER) -transcriptome_suffix=$(TRANSCRIPTOME_FILE_SUFFIX) -transcriptome_archive_ext=$(TRANSCRIPTOME_FILE_EXT) -ref_intergenic_dir=$(REF_INTERGENIC_FOLDER) >> $@.tmp 2> $@.warn
	
	# compress intergenic fasta files
	@find $(FASTA_INTERGENIC_FOLDER) -type f -name '*_intergenic.fa' -exec gzip --verbose --best {} \; >> $@.tmp 2> $@.warn
	@find $(FASTA_INTERGENIC_FOLDER) -type f -name '*_intergenic.fa' -exec gzip --verbose --best {} \; >> $@.tmp 2> $@.warn
	
	@$(MV) $@.tmp $@

create_non_ref_intergenic: create_text_ref_intergenic retrieve_transcriptomes
	# create non reference intergenic fasta files
	# TODO: modify to be compatible with non ensembl species
	@perl create_intergenic_fasta.pl -bgee=$(BGEECMD) -ens_release=$(ENSRELEASE) -transcriptomes_folder=$(FASTA_INTERGENIC_FOLDER) -transcriptome_suffix=$(TRANSCRIPTOME_FILE_SUFFIX) -transcriptome_archive_ext=$(TRANSCRIPTOME_FILE_EXT) -ref_intergenic_dir=$(NON_REF_INTERGENIC_FOLDER) >> $@.tmp 2> $@.warn
	@perl create_intergenic_fasta.pl -bgee=$(BGEECMD) -ens_release=$(ENSMETAZOARELEASE) -transcriptomes_folder=$(FASTA_INTERGENIC_FOLDER) -transcriptome_suffix=$(TRANSCRIPTOME_FILE_SUFFIX) -transcriptome_archive_ext=$(TRANSCRIPTOME_FILE_EXT) -ref_intergenic_dir=$(NON_REF_INTERGENIC_FOLDER) >> $@.tmp 2> $@.warn
	
	# compress intergenic fasta files
	@find $(FASTA_INTERGENIC_FOLDER) -type f -name '*_intergenic.fa' -exec gzip --verbose --best {} \; >> $@.tmp 2> $@.warn
	@find $(FASTA_INTERGENIC_FOLDER) -type f -name '*_intergenic.fa' -exec gzip --verbose --best {} \; >> $@.tmp 2> $@.warn
	
	@$(MV) $@.tmp $@
	
reference_intergenic: create_ref_intergenic
	@echo "The next step of the pipeline will copy reference intergenic files to the FTP"
	@echo "WARNING : Before continuing please be sure you bumped the reference intergenic version (INTERGENICVERSION in the file $(PIPELINEROOT)Makefile.common)."
	@echo "Otherwise reference intergenic files present in the FTP will be overwritten."
	@echo "Then run the command :"
	@echo "make copy_ref_intergenic_files"
	
non_reference_intergenic: create_non_ref_intergenic
	@echo "non reference intergenic fasta files were created successfully."
	@echo "For the moment non reference intergenic files are not copied to the FTP."
	@echo "They are available here : $(NON_REF_INTERGENIC_FOLDER)"

# Copy ref intergenic files to ftp server
copy_ref_intergenic_files: 
	# create directory $(FTPINTERGENICVERSION) on the ftp
	@ssh $(FTPUSER)@$(FTPHOST) 'mkdir -p $(FTPINTERGENICVERSION)'
	# copy intergenic for species from ensembl metazoa
	@scp $(FASTA_INTERGENIC_FOLDER)*$(ENSMETAZOARELEASE).intergenic.fa.gz $(FTPUSER)@$(FTPHOST):$(FTPINTERGENIC) > $@.tmp 2> $@.warn
	# copy intergenic for species from ensembl
	@scp $(FASTA_INTERGENIC_FOLDER)*$(ENSRELEASE).intergenic.fa.gz $(FTPUSER)@$(FTPHOST):$(FTPINTERGENIC)  > $@.tmp 2> $@.warn
	@echo 'Reference intergenic files have been copied to the ftp.'
	@echo 'In order to allow them to be used by the BgeeCall R package you should add one line to the file $(FTPINTERGENIC)intergenic_release.tsv'
	@echo 'Please also document how this version of intergenic regions has been created in the file $(FTPINTERGENIC)README'
	@$(MV) $@.tmp $@

clean:
	@rm -f retrieve_sum_and_gaussian
	@rm -f create_text_ref_intergenic
	@rm -f create_text_non_ref_intergenic
	@rm -f retrieve_transcriptomes
	@rm -f create_ref_intergenic
	@rm -f create_non_ref_intergenic
	@rm -f copy_ref_intergenic_files
	@rm -rf $(REF_INTERGENIC_FOLDER)
	@rm -rf $(NON_REF_INTERGENIC_FOLDER)
	@rm -rf $(FASTA_INTERGENIC_FOLDER)
	@mkdir -p $(REF_INTERGENIC_FOLDER)
	@mkdir -p $(NON_REF_INTERGENIC_FOLDER)
	@mkdir -p $(FASTA_INTERGENIC_FOLDER)
