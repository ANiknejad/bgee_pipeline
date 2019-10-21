# Create reference intergenic fasta files needed to generate present/absent calls using the BgeeCall R package

* **Requirements**: having successfully run the step RNA-Seq.
* **Goal**:         generate reference and/or non reference intergenic fasta files and copy them to the FTP. Reference intergenic fasta files are mandatory to run the BgeeCall R package.

## Details

Intergenic regions are defined when the RNA-Seq pipeline is run.
The creation of present/absent expression calls only used a subpart of these intergenic regions called reference intergenic regions.
creation of fasta files containing these reference intergenic regions is mandatory to run the BgeeCall R package.
It can also interesting to understand what are intergenic regions not considered as reference by the pipeline. Files containing these regions called non reference intergenic
regions can also be generated.
This script can 
* Create a text file containing IDs of reference intergenic region per species using the RNA-Seq part of the pipeline.
* Create a text file containing IDs of non reference intergenic regions per species using the RNA-Seq part of the pipeline.
* Create one reference intergenic fasta file per species from the transcriptome fasta files created during the RNA-Seq part of the pipeline.
* Create one non reference intergenic fasta file per species from the transcriptome fasta files created during the RNA-Seq part of the pipeline.
* Copy all reference intergenic files to the ftp.

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

Not currently compatible with non ensembl species

## Other notable Makefile targets

* `make create_ref_intergenic` creates one reference intergenic fasta file per species from the transcriptome fasta files created during the RNA-Seq part of the pipeline.
* `make create_non_ref_intergenic` creates one non reference intergenic fasta file per species from the transcriptome fasta files created during the RNA-Seq part of the pipeline.
* `make copy_ref_intergenic_files` copy previously generated reference intergenic files to the ftp
