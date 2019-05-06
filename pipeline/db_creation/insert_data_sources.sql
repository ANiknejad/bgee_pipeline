INSERT INTO dataSource (dataSourceId, dataSourceName, XRefUrl, experimentUrl, evidenceUrl,
                        baseUrl, dataSourceDescription, toDisplay, category) VALUES
-- [species_ensembl_link]: e.g., Drosophila_melanogaster
(1, 'NCBI Taxonomy', '', '', '',
    'https://www.ncbi.nlm.nih.gov/taxonomy', 'Source taxonomy used in Bgee', 1, ''),
(2, 'Ensembl', 'http://dec2015.archive.ensembl.org/[species_ensembl_link]/Gene/Summary?g=[gene_id];gene_summary=das:http://bgee.unil.ch/das/bgee=label', '', '',
    'http://dec2015.archive.ensembl.org/',
    'Source for gene annotations, mappings to the Gene Ontology, mappings to Affymetrix probeset IDs, and cross-references to other databases',
    1, 'Genomics database'),
(3, 'EMBL', 'https://www.ebi.ac.uk/ena/data/view/[xref_id]', '', '',
    'https://www.ebi.ac.uk/', 'European Nucleotide Archive', 0, ''),
(4, 'UniProtKB/TrEMBL', 'https://www.uniprot.org/uniprot/[xref_id]', '', '',
    'https://www.uniprot.org/', 'Computationally analyzed functional information on proteins', 0, ''),
(5, 'UniProtKB/Swiss-Prot', 'https://www.uniprot.org/uniprot/[xref_id]', '', '',
    'https://www.uniprot.org/', 'Manually annotated functional information on proteins', 0, ''),
(6, 'miRBase', 'http://www.mirbase.org/cgi-bin/mirna_entry.pl?acc=[xref_id]', '', '',
    'http://www.mirbase.org/', 'Source for miRNA families', 1, 'Genomics database'),
(7, '4DXpress', 'http://4dx.embl.de/4DXpress/reg/all/search/bquery.do?id=[gene_id]', '', '',
    'http://4dx.embl.de/4DXpress/', 'Gene expression data comparison during the development', 0, ''),
(8, 'ZFIN', 'https://zfin.org/[xref_id]', 'https://zfin.org/[experiment_id]',
    'https://zfin.org/[evidence_id]',
    'https://zfin.org/', 'Zebrafish in situ data source', 1, 'In situ data source'),
(9, 'MGI', 'http://www.informatics.jax.org/accession/[xref_id]', 'http://www.informatics.jax.org/assay/[experiment_id]',
    'http://www.informatics.jax.org/assay/[experiment_id]#[inSituEvidenceUrlPart]',
    'http://www.informatics.jax.org/expression.shtml', 'Mouse in situ data source', 1, 'In situ data source'),
(10, 'FlyBase', 'http://flybase.org/reports/[gene_id].html', '', '',
    'http://flybase.org/', 'Drosophila in situ data source', 1, 'In situ data source'),
(11, 'ArrayExpress', '', 'https://www.ebi.ac.uk/arrayexpress/experiments/[experiment_id]', '',
    'https://www.ebi.ac.uk/arrayexpress/', 'Affymetrix data source for various species', 1, 'Affymetrix data source'),
(12, 'UniGene', '', 'https://www.ncbi.nlm.nih.gov/UniGene/library.cgi?LID=[experiment_id]', 'https://www.ncbi.nlm.nih.gov/entrez/viewer.fcgi?db=nucest&id=[evidence_id]',
    'https://www.ncbi.nlm.nih.gov/unigene/', 'EST data source for various species', 1, 'EST data source'),
(13, 'smiRNAdb', '', '', '',
    'http://www.mirz.unibas.ch/cloningprofiles/', 'EST data for miRNAs', 1, 'EST data source'),
(14, 'BDGP', '', 'http://insitu.fruitfly.org/cgi-bin/ex/report.pl?ftype=3&ftext=[experiment_id]', '',
    'http://insitu.fruitfly.org/', 'Drosophila in situ data source', 1, 'In situ data source'),
(15, 'Xenbase', 'http://www.xenbase.org/gene/showgene.do?method=displayGeneSummary&geneId=[xref_id]', '', '',
    'http://www.xenbase.org/', 'Xenopus in situ data source', 1, 'In situ data source'),
(16, 'neXtProt', 'https://www.nextprot.org/entry/[xref_id]', '', '',
    'https://www.nextprot.org/', 'Exploring the universe of human proteins', 0, ''),
(17, 'GEO', '', 'https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=[experiment_id]', 'https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=[evidence_id]',
    'https://www.ncbi.nlm.nih.gov/geo/', 'Affymetrix data source for various species', 1, 'Affymetrix data source'),
(18, 'Gene Ontology', 'http://amigo.geneontology.org/amigo/term/[xref_id]', '', '',
    'http://geneontology.org/page/download-ontology', 'Filtered Gene Ontology', 1, 'Ontology'),
(19, 'SRA', '', 'https://www.ncbi.nlm.nih.gov/sra/[experiment_id]', 'https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?cmd=viewer&m=data&s=viewer&run=[evidence_id]',
    'https://www.ncbi.nlm.nih.gov/sra/', 'RNA-Seq data source for various species', 1, 'RNA-Seq data source'),
(20, 'HGNC', 'http://www.genenames.org/cgi-bin/gene_symbol_report?hgnc_id=[xref_id]', '', '',
    'http://www.genenames.org/', 'HUGO (Human Genome Organisation - and Primates) Gene Nomenclature Committee', 0, 'Genomics database'),
(21, 'CCDS', 'https://www.ncbi.nlm.nih.gov/CCDS/CcdsBrowse.cgi?REQUEST=ALLFIELDS&DATA=[xref_id]&ORGANISM=0&BUILDS=CURRENTBUILDS', '', '',
    'https://www.ncbi.nlm.nih.gov/CCDS/CcdsBrowse.cgi', 'Consensus CDS (CCDS) project', 0, 'Genomics database'),
(22, 'RGD', 'https://rgd.mcw.edu/rgdweb/report/gene/main.html?id=[xref_id]', '', '',
    'https://rgd.mcw.edu/', 'RGD - Rat Genome Database', 0, 'Genomics database'),
(23, 'WormBase', 'https://www.wormbase.org/species/c_elegans/gene/[xref_id]', '', '',
    'https://www.wormbase.org', 'WormBase - Nematode Information Resource', 1, 'In situ data source'),
(24, 'EnsemblMetazoa', 'http://metazoa.ensembl.org/[species_ensembl_link]/Gene/Summary?g=[gene_id]', '', '',
    'http://metazoa.ensembl.org/',
    'Source for gene annotations, mappings to the Gene Ontology, mappings to Affymetrix probeset IDs, and cross-references to other databases',
    1, 'Genomics database'),
(25, 'Bgee', '', '', '', 'https://bgee.org/', 'Gene expression data in animals', 0, ''),
(26, 'Uberon', '', '', '',
    'http://uberon.org/', 'Integrated cross-species ontology covering anatomical structures in animals. Use of the subset "composite-metazoan".', 1, 'Ontology'),
(27, 'Developmental stage ontologies', '', '', '',
    'https://github.com/obophenotype/developmental-stage-ontologies/', 'Collection of developmental and life stage ontologies in animals. Integrated into Uberon.', 1, 'Ontology'),
(28, 'OMA', '', '', '',
    'http://omabrowser.org/', 'Source of gene orthology information', 1, 'Genomics database'),
(29, 'Anatomical similarity annotations', '', '', '',
    'https://github.com/BgeeDB/anatomical-similarity-annotations/', 'Define evolutionary relations between anatomical entities described in the Uberon ontology', 1, ''),
(30, 'CIO', '', '', '',
    'http://obofoundry.org/ontology/cio.html', 'Confidence Information Ontology', 1, 'Ontology'),
(31, 'GTEx - dbGAP', '', 'https://www.ncbi.nlm.nih.gov/projects/gap/cgi-bin/study.cgi?study_id=phs000424.v6.p1', 'https://www.ncbi.nlm.nih.gov/sra/?term=[evidence_id]',
    'https://www.ncbi.nlm.nih.gov/projects/gap/cgi-bin/study.cgi?study_id=phs000424', 'GTEx RNA-Seq data', 1, 'RNA-Seq data source'),
(32, 'VGNC', 'http://vertebrate.genenames.org/data/gene-symbol-report/#!/vgnc_id/[xref_id]', '', '',
     'http://vertebrate.genenames.org', 'Vertebrate Gene Nomenclature Committee', 0, 'Genomics database'),
(33, 'ENA', '', 'https://www.ebi.ac.uk/ena/data/view/[experiment_id]', 'https://www.ebi.ac.uk/ena/data/view/[evidence_id]',
     'https://www.ebi.ac.uk/ena', 'RNA-Seq data source for various species', 1, 'RNA-Seq data source'),
(34, 'DDBJ', '', 'https://ddbj.nig.ac.jp/DRASearch/study?acc=[experiment_id]', 'https://ddbj.nig.ac.jp/DRASearch/experiment?acc=[evidence_id]',
     'https://ddbj.nig.ac.jp/DRASearch/', 'RNA-Seq data source for various species', 1, 'RNA-Seq data source'),
(35, 'GSA', '', 'http://bigd.big.ac.cn/search?dbId=gsa&q=[experiment_id]', 'http://bigd.big.ac.cn/gsa/browse/[experiment_id]/[evidence_id]',
     'http://bigd.big.ac.cn/gsa/', 'RNA-Seq data source for various species', 1, 'RNA-Seq data source');


-- Add "ghost" sources, because a source can only be part of one category, so rather than
-- creating a link table, we do this ugly hack
INSERT INTO dataSource (dataSourceId, dataSourceName, XRefUrl, experimentUrl, evidenceUrl,
                        baseUrl, dataSourceDescription, toDisplay, category) VALUES

(100, 'GEO', '', 'https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=[experiment_id]', 'https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=[evidence_id]',
    'https://www.ncbi.nlm.nih.gov/geo/', 'RNA-Seq data source for various species', 1, 'RNA-Seq data source'),
(101, 'ArrayExpress', '', 'https://www.ebi.ac.uk/arrayexpress/experiments/[experiment_id]', '',
	'https://www.ebi.ac.uk/arrayexpress/', 'RNA-Seq data source for various species', 1, 'RNA-Seq data source');
