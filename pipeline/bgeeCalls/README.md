# Create reference intergenic fasta files needed to generate present/absent calls using the BgeeCall R package

* **Requirements**: having successfully run the step RNA-Seq.
* **Goal**:         generate reference intergenic fasta files for the BgeeCall R package and made them accessible in the FTP.

## Details

The BgeeCall R package allows to generate present/absent calls using the reference intergenic regions generated during the RNA-RSEQ part of the pipeline.
This script will 
* Create a text file containing IDs of reference intergenic region per species using the RNA-Seq part of the pipeline.
* Create one reference intergenic fasta file per species from the transcriptome fasta files created during the RNA-Seq part of the pipeline.
* Copy all generated files to the ftp.

## Data generation
* If it is the first time you execute this step in this pipeline run:
```
make clean
```
* Run Makefile:
```
make 
```

## Data verification

## Error handling

## Other notable Makefile targets

* `make create_fasta_intergenic` creates one intergenic fasta file per species from the transcriptome fasta files created during the RNA-Seq part of the pipeline.
* `make create_reference_intergenic` create one txt file per species containing all reference intergenic regions.
* `make copy_intergenic_files`copy previously generated files to the ftp

