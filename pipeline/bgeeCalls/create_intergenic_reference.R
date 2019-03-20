## Julien Wollbrett 12/10/2018
## This script allows creation of reference intergenic text files. These files are used in the bgeeCalls R package. 
## Reference intergenic text files contain identifier of all intergenic regions considered as true intergenic regions
## These reference intergenic regions are the result of the expertise of Bgee team 
## Basically, this script will for each species:
##	1. use sum_by_species_abundance file and gaussian_choice file to retrieve identifier of reference intergenic regions
##	2. create a text file containing the identifier of all reference intergenic regions
##	3. compress the file (useful?)


## Usage:
## R CMD BATCH --no-save --no-restore '--args output_dir="$(OUTPUT_DIR)" sum_abundance_file_pattern="$(SUM_FILE_PATTERN)" sum_abundance_dir="$(SUM_ABUNDANCE_DIR)" gaussian_file_path="$(GAUSSIAN_FILE_PATH)" reference_intergenic_file_pattern="$(INTERGENIC_REF_PATTERN)"' create_intergenic_reference.R create_intergenic_reference.Rout
## output_dir                        	- Directory where all files are written
## sum_abundance_file_pattern        	- Name of the abundance files created during the sum_by_species step of the RNA-Seq Bgee pipeline
## sum_abundance_dir				 	- Directory where all sum abundance files are stored (usually on vital-it)
## gaussian_file_path                	- Path to the gaussian file manually edited to run the presence_absence part of the RNA-Seq Bgee pipeline
## reference_intergenic_file_pattern 	- Pattern of the name of files that will contain identifier of all intergenic region defined in the RNA-Seq Bgee pipeline


## Session info
print(sessionInfo())

## reading in arguments provided in command line
cmd_args = commandArgs(TRUE);
print(cmd_args)
if( length(cmd_args) == 0 ){ stop("no arguments provided\n") } else {
  for( i in 1:length(cmd_args) ){
    eval(parse(text=cmd_args[i]))
  }
}

## checking if all necessary arguments were passed in command line
command_arg <- c("output_dir", "sum_abundance_file_pattern", "sum_abundance_dir", "gaussian_file_path", "reference_intergenic_file_pattern")
for( c_arg in command_arg ){
  if( !exists(c_arg) ){
    stop( paste(c_arg,"command line argument not provided\n") )
  }
}

#################################

## Read gaussian_choice file. If file not exists, script stops
if (file.exists(gaussian_file_path)){
  gaussian <- read.table(gaussian_file_path, h=T, sep="\t", comment.char="")
} else {
  stop( paste("Gaussian file not found [", gaussian_file_path, "]\n"))
}
for (species in gaussian$speciesId) {
  sum_abundance_file_name <- gsub("SPECIES_ID", species, sum_abundance_file_pattern)
  sum_abundance_file_path <- file.path(sum_abundance_dir,sum_abundance_file_name)
  if (!file.exists(sum_abundance_file_path) ) {
  	exit(paste0("file : ", sum_abundance_file_path, " does not exist."))
  }
  sum_by_species <- read.table(sum_abundance_file_path, h=T, sep="\t", comment.char="")
  gaussian_number <- gaussian$selectedGaussianIntergenic[gaussian$speciesId == species]
  if (gaussian$selectionSideIntergenic[gaussian$speciesId == species] == "Left"){
    max_intergenic <- max(sum_by_species$tpm[
        sum_by_species$classification %in% paste0("intergenic_", gaussian_number)
      ])
  } else if (gaussian$selectionSideIntergenic[gaussian$speciesId == species] == "Right") {
    ## In some case it is tricky to define the gaussians in the conventional way, so it is possible to select all regions that (in summed data) have TPM below threshold defined by selected gaussian, BUT taking min TPM of regions from this gaussian, the gaussian is on the right of the threshold!
    max_intergenic <- min(sum_by_species$tpm[
        sum_by_species$classification %in% paste0("intergenic_", gaussian_number)
      ])
  }
  cat(paste0("max intergenic for species ", species, " is : ", max_intergenic))

  selected_intergenic <- as.data.frame(sum_by_species$gene_id[sum_by_species$type == "intergenic"
      & sum_by_species$tpm <= max_intergenic])
  write.table(selected_intergenic, file=file.path(output_dir,gsub("SPECIES_ID", species, reference_intergenic_file_pattern)), quote=FALSE, sep='\t', col.names = FALSE, row.names = FALSE)
                              
      
}
  

		
