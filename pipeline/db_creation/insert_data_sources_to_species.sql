-- see insert_data_sources.sql to see list of data source IDs
-- species IDs are NCBI tax IDs

-- *** query to retrieve species and data sources for RNA-Seq data ***
-- select t2.dataSourceId,count(DISTINCT t1.rnaSeqExperimentId),(SELECT speciesId from gene where bgeeGeneId = (select bgeeGeneId from rnaSeqResult WHERE rnaSeqResult.rnaSeqLibraryId = t1.rnaSeqLibraryId LIMIT 1)) as speciesId FROM rnaSeqLibrary AS t1 INNER JOIN rnaSeqExperiment AS t2 ON t1.rnaSeqExperimentId = t2.rnaSeqExperimentId GROUP BY speciesId, dataSourceId;
-- *** query to retrieve species and data sources for Affymetrix data ***
-- select t2.dataSourceId, count(DISTINCT t1.microarrayExperimentId), (SELECT speciesId from gene where bgeeGeneId = (select bgeeGeneId from affymetrixProbeset WHERE affymetrixProbeset.bgeeAffymetrixChipId = t1.bgeeAffymetrixChipId LIMIT 1)) as speciesId FROM affymetrixChip AS t1 INNER JOIN microarrayExperiment AS t2 ON t1.microarrayExperimentId = t2.microarrayExperimentId GROUP BY speciesId, dataSourceId;
-- *** query to retrieve species and data sources for EST data ***
-- select t1.dataSourceId, count(DISTINCT estLibraryId), (SELECT speciesId from gene where bgeeGeneId = (select bgeeGeneId from expressedSequenceTag WHERE expressedSequenceTag.estLibraryId = t1.estLibraryId LIMIT 1)) as speciesId from estLibrary as t1 GROUP BY speciesId, dataSourceId;
-- ** in situ ** 
-- select t2.dataSourceId, count(DISTINCT t1.inSituExperimentId), (SELECT speciesId from gene where bgeeGeneId = (select bgeeGeneId from inSituSpot WHERE inSituSpot.inSituEvidenceId = t1.inSituEvidenceId LIMIT 1)) as speciesId FROM inSituEvidence AS t1 INNER JOIN inSituExperiment AS t2 ON t1.inSituExperimentId = t2.inSituExperimentId GROUP BY speciesId, dataSourceId;

DELETE FROM dataSourceToSpecies;

--ZFIN in situ in zebrafish, data and annot
INSERT INTO dataSourceToSpecies (dataSourceId, speciesId, dataType, infoType) VALUES 
(8, 7955, 'in situ', 'data'), 
(8, 7955, 'in situ', 'annotation'); 
--MGI in situ mouse, data and annot
INSERT INTO dataSourceToSpecies (dataSourceId, speciesId, dataType, infoType) VALUES 
(9, 10090, 'in situ', 'data'), 
(9, 10090, 'in situ', 'annotation'); 
--Flybase in situ droso, data and annot
INSERT INTO dataSourceToSpecies (dataSourceId, speciesId, dataType, infoType) VALUES 
(10, 7227, 'in situ', 'data'), 
(10, 7227, 'in situ', 'annotation'); 
-- ArrayExpress source for Affymetrix data in drosophila, human, zebrafish, mouse
INSERT INTO dataSourceToSpecies (dataSourceId, speciesId, dataType, infoType) VALUES 
(11, 7227, 'affymetrix', 'data'), 
(11, 9606, 'affymetrix', 'data'), 
(11, 7955, 'affymetrix', 'data'), 
(11, 10090, 'affymetrix', 'data');
-- Unigene source for EST data in droso, zebrafish, xenopus, human, mouse
INSERT INTO dataSourceToSpecies (dataSourceId, speciesId, dataType, infoType) VALUES 
(12, 7227, 'est', 'data'), 
(12, 7955, 'est', 'data'), 
(12, 8364, 'est', 'data'), 
(12, 9606, 'est', 'data'), 
(12, 10090, 'est', 'data');
-- smiRNAdb source for EST data in zebrafish human mouse
-- we hide it because it's outdated
-- INSERT INTO dataSourceToSpecies (dataSourceId, speciesId, dataType, infoType) VALUES 
-- (13, 7955, 'est', 'data'), 
-- (13, 9606, 'est', 'data'), 
-- (13, 10090, 'est', 'data');
-- BDGP source for in situ data and annot in drosophila
INSERT INTO dataSourceToSpecies (dataSourceId, speciesId, dataType, infoType) VALUES 
(14, 7227, 'in situ', 'data'), 
(14, 7227, 'in situ', 'annotation');
-- Xenbase source for in situ data and annot in xenopus
INSERT INTO dataSourceToSpecies (dataSourceId, speciesId, dataType, infoType) VALUES 
(15, 8364, 'in situ', 'data'), 
(15, 8364, 'in situ', 'annotation');
-- GEO, source for Affymetrix data in c. elegans, drosophila, human, zebrafish, mouse
INSERT INTO dataSourceToSpecies (dataSourceId, speciesId, dataType, infoType) VALUES 
(17, 6239, 'affymetrix', 'data'),
(17, 7227, 'affymetrix', 'data'),
(17, 7955, 'affymetrix', 'data'),
(17, 9544, 'affymetrix', 'data'),
(17, 9606, 'affymetrix', 'data'),
(17, 10090, 'affymetrix', 'data'),
(17, 10116, 'affymetrix', 'data');
-- and source of RNA-Seq data in lots of species :p
INSERT INTO dataSourceToSpecies (dataSourceId, speciesId, dataType, infoType) VALUES 
(100, 6239, 'rna-seq', 'data'),
(100, 7217, 'rna-seq', 'data'),
(100, 7227, 'rna-seq', 'data'),
(100, 7230, 'rna-seq', 'data'),
(100, 7237, 'rna-seq', 'data'),
(100, 7240, 'rna-seq', 'data'),
(100, 7244, 'rna-seq', 'data'),
(100, 7245, 'rna-seq', 'data'),
(100, 7955, 'rna-seq', 'data'),
(100, 8364, 'rna-seq', 'data'),
(100, 9031, 'rna-seq', 'data'),
(100, 9258, 'rna-seq', 'data'),
(100, 9365, 'rna-seq', 'data'),
(100, 9544, 'rna-seq', 'data'),
(100, 9593, 'rna-seq', 'data'),
(100, 9597, 'rna-seq', 'data'),
(100, 9598, 'rna-seq', 'data'),
(100, 9606, 'rna-seq', 'data'),
(100, 9615, 'rna-seq', 'data'),
(100, 9685, 'rna-seq', 'data'),
(100, 9796, 'rna-seq', 'data'),
(100, 9823, 'rna-seq', 'data'),
(100, 9913, 'rna-seq', 'data'),
(100, 9986, 'rna-seq', 'data'),
(100, 10090, 'rna-seq', 'data'),
(100, 10116, 'rna-seq', 'data'),
(100, 10141, 'rna-seq', 'data'),
(100, 13616, 'rna-seq', 'data'),
(100, 28377, 'rna-seq', 'data');
-- SRA source for RNA-Seq data in c. elegans
INSERT INTO dataSourceToSpecies (dataSourceId, speciesId, dataType, infoType) VALUES 
(19, 6239, 'rna-seq', 'data');
-- wormbase source for in situ data and annot in c. elegans
-- also source of annotations for affymetrix and RNA-Seq
INSERT INTO dataSourceToSpecies (dataSourceId, speciesId, dataType, infoType) VALUES 
(23, 6239, 'in situ', 'data'), 
(23, 6239, 'in situ', 'annotation'), 
(23, 6239, 'affymetrix', 'annotation'), 
(23, 6239, 'rna-seq', 'annotation');
-- Bgee source of annotation for EST, Affymetrix and RNA-Seq data in all species
INSERT INTO dataSourceToSpecies (dataSourceId, speciesId, dataType, infoType) VALUES 
(25, 28377, 'affymetrix', 'annotation'), 
(25, 28377, 'est', 'annotation'), 
(25, 28377, 'rna-seq', 'annotation'), 
(25, 9597, 'affymetrix', 'annotation'), 
(25, 9597, 'est', 'annotation'), 
(25, 9597, 'rna-seq', 'annotation'), 
(25, 6239, 'affymetrix', 'annotation'), 
(25, 6239, 'est', 'annotation'), 
(25, 6239, 'rna-seq', 'annotation'), 
(25, 9031, 'affymetrix', 'annotation'), 
(25, 9031, 'est', 'annotation'), 
(25, 9031, 'rna-seq', 'annotation'), 
(25, 9598, 'affymetrix', 'annotation'), 
(25, 9598, 'est', 'annotation'), 
(25, 9598, 'rna-seq', 'annotation'), 
(25, 9913, 'affymetrix', 'annotation'), 
(25, 9913, 'est', 'annotation'), 
(25, 9913, 'rna-seq', 'annotation'), 
(25, 7227, 'affymetrix', 'annotation'), 
(25, 7227, 'est', 'annotation'), 
(25, 7227, 'rna-seq', 'annotation'), 
(25, 9593, 'affymetrix', 'annotation'), 
(25, 9593, 'est', 'annotation'), 
(25, 9593, 'rna-seq', 'annotation'), 
(25, 9606, 'affymetrix', 'annotation'), 
(25, 9606, 'est', 'annotation'), 
(25, 9606, 'rna-seq', 'annotation'), 
(25, 9544, 'affymetrix', 'annotation'), 
(25, 9544, 'est', 'annotation'), 
(25, 9544, 'rna-seq', 'annotation'), 
(25, 10090, 'affymetrix', 'annotation'), 
(25, 10090, 'est', 'annotation'), 
(25, 10090, 'rna-seq', 'annotation'), 
(25, 13616, 'affymetrix', 'annotation'), 
(25, 13616, 'est', 'annotation'), 
(25, 13616, 'rna-seq', 'annotation'), 
(25, 9823, 'affymetrix', 'annotation'), 
(25, 9823, 'est', 'annotation'), 
(25, 9823, 'rna-seq', 'annotation'), 
(25, 9258, 'affymetrix', 'annotation'), 
(25, 9258, 'est', 'annotation'), 
(25, 9258, 'rna-seq', 'annotation'), 
(25, 10116, 'affymetrix', 'annotation'), 
(25, 10116, 'est', 'annotation'), 
(25, 10116, 'rna-seq', 'annotation'), 
(25, 8364, 'affymetrix', 'annotation'), 
(25, 8364, 'est', 'annotation'), 
(25, 8364, 'rna-seq', 'annotation'), 
(25, 7955, 'affymetrix', 'annotation'), 
(25, 7955, 'est', 'annotation'), 
(25, 7955, 'rna-seq', 'annotation'),
(25, 7217, 'rna-seq', 'annotation'),
(25, 7230, 'rna-seq', 'annotation'),
(25, 7237, 'rna-seq', 'annotation'),
(25, 7240, 'rna-seq', 'annotation'),
(25, 7244, 'rna-seq', 'annotation'),
(25, 7245, 'rna-seq', 'annotation'),
(25, 9365, 'rna-seq', 'annotation'),
(25, 9615, 'rna-seq', 'annotation'),
(25, 9685, 'rna-seq', 'annotation'),
(25, 9796, 'rna-seq', 'annotation'),
(25, 9986, 'rna-seq', 'annotation'),
(25, 10141, 'rna-seq', 'annotation');

-- GTEx data source
INSERT INTO dataSourceToSpecies (dataSourceId, speciesId, dataType, infoType) VALUES 
(31, 9606, 'rna-seq', 'data');