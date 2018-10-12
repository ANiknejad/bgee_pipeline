# Create all data needed to run the RNA-Seq Calls paper

* **Requirements**: having successfully run the step RNA-Seq.
* **Goal**:         extract data needed by the RNA-Seq calls R package and made them accessible in the FTP.

## Details
* This script will create one intergenic fasta file per species from the transcriptome fasta files created during the RNA-Seq part of the pipeline.
* It will create a text file containing reference intergenic region per species using the RNA-Seq part of the pipeline.
* It will copy all generated files to the ftp.
* It will copy to the ftp both gene2transcript and gene2biotype files created during the RNA-Seq part of the pipeline.

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

* `make create_fasta_intergenic` will only create one intergenic fasta file per species from the transcriptome fasta files created during the RNA-Seq part of the pipeline. Then it will copy these files to the FTP

