# Create all data needed to run the RNA-Seq Calls package (called bgeeCalls)

* **Requirements**: having successfully run the step RNA-Seq.
* **Goal**:         extract data needed by the bgeeCalls R package and made them accessible in the FTP.

## Details
* This script will create one intergenic fasta file per species from the transcriptome fasta files created during the RNA-Seq part of the pipeline.
* It will create a text file containing reference intergenic region per species using the RNA-Seq part of the pipeline.
* It will copy all generated files to the ftp.

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

* `make create_fasta_intergenic` will only create one intergenic fasta file per species from the transcriptome fasta files created during the RNA-Seq part of the pipeline.

* `make create_reference_intergenic` will only create one txt file per species containing all reference intergenic regions.

* `make create_fasta_intergenic` will only copy both reference and fasta files to the FTP.
