## Julien Wollbrett 12/10/2018
## This script allows creation of reference intergenic or non reference intergenic text files.
## Reference intergenic text files contain identifier of all intergenic regions less expressed than protein coding genes
## Non reference intergenic text files contain identifier of all intergenic regions expressed at a level comparable to protein coding genes
## These intergenic regions are the result of the expertise of Bgee team 
## Basically, this script will for each species:
##	1. use sum_by_species_abundance file and the gaussian_choice file to define a threshold of reference / non reference intergenic regions to retrieve identifier of wanted intergenic regions
##	2. create a text file containing the identifier of all ref. or non ref. intergenic regions
##	3. compress the file (useful?)


## Usage:
## R CMD BATCH --no-save --no-restore '--args output_dir="$(OUTPUT_DIR)" sum_abundance_file_pattern="$(SUM_FILE_PATTERN)" sum_abundance_dir="$(SUM_ABUNDANCE_DIR)" gaussian_file_path="$(GAUSSIAN_FILE_PATH)" reference_intergenic_file_pattern="$(INTERGENIC_REF_PATTERN)"' create_intergenic_reference.R create_intergenic_reference.Rout
## output_dir                        	- Directory where all files are written
## sum_abundance_file_pattern        	- Name of the abundance files created during the sum_by_species step of the RNA-Seq Bgee pipeline
## sum_abundance_dir				 	- Directory where all sum abundance files are stored (usually on vital-it)
## gaussian_file_path                	- Path to the gaussian file manually edited to run the presence_absence part of the RNA-Seq Bgee pipeline
## intergenic_file_pattern 	            - Pattern of the name of files that will contain identifier of all reference or non reference intergenic region defined in the RNA-Seq Bgee pipeline
## type_of_intergenic                   - "ref" or "nonRef" depending on the type of intergenic regions you want to generate

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
command_arg <- c("output_dir", "sum_abundance_file_pattern", "sum_abundance_dir", 
  "gaussian_file_path", "intergenic_file_pattern", "type_of_intergenic")
for( c_arg in command_arg ){
  if( !exists(c_arg) ){
    stop( paste(c_arg,"command line argument not provided\n") )
  }
}

#################################

## Check type_of_intergenic value. If not "ref or "nonRef" script stop.
if (type_of_intergenic ne "ref" && type_of_intergenic ne "nonRef"){
  stop( paste("Argument \"type_of_intergenic\" should have values \"ref\" or \"nonRef\"\n"))
}

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
    intergenic_threshold <- max(sum_by_species$tpm[
        sum_by_species$classification %in% paste0("intergenic_", gaussian_number)
      ])
  } else if (gaussian$selectionSideIntergenic[gaussian$speciesId == species] == "Right") {
    ## In some case it is tricky to define the gaussians in the conventional way, so it 
    ## is possible to select all regions that (in summed data) have TPM below threshold 
    ## defined by selected gaussian, BUT taking min TPM of regions from this gaussian, 
    ## the gaussian is on the right of the threshold!
    intergenic_threshold <- min(sum_by_species$tpm[
        sum_by_species$classification %in% paste0("intergenic_", gaussian_number)
      ])
  }
  
  cat(paste0("intergenic threshold for species ", species, " is : ", intergenic_threshold))
  if ( type_of_intergenic eq "ref" ) {
    intergenic <- as.data.frame(sum_by_species$gene_id[sum_by_species$type == "intergenic"
      & sum_by_species$tpm <= intergenic_threshold])

  } else {
    intergenic <- as.data.frame(sum_by_species$gene_id[sum_by_species$type == "intergenic"
      & sum_by_species$tpm > intergenic_threshold])
  }
  
  write.table(intergenic, file=file.path(output_dir,gsub(
      "SPECIES_ID", species, intergenic_file_pattern)), 
    quote=FALSE, sep='\t', col.names = FALSE, row.names = FALSE)
                              
      
}
  

		
