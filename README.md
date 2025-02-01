# RNA Sequencing Workflow

**Obtain Data**
- The raw reads can be found on here https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE119855
  and are from the Gene Expression Omnibus with GEO accession GSE119855

**Read Quality Checks**
- FastQC and MultiQC : scripts 1 and 2

**Mapping Reads onto Reference Genome**
- Download reference genome : script 3
- Indexing files : script 4
- Map onto reference genome and read quality check : script 5 and 5.5
- BAM sorting and indexing : script 6

**Feature Counts**
- Obtain count data for each gene : script 7

**Exploratory Data Analysis**
- Quantify Differentially Expressed Genes and visualize withvolcano plot
- Gene Ontology overrepresentation analysis and visualize with dotplots
- Specefic Gene Analysis with boxplots
