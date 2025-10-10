# XCD_BSSeq Project List of Home Directories

##1. GSE134873
### Bisulphite Seq of Purified Rod photoreceptors of mice aged 3M, 12M, 18M, and 24M
Raw data was downloaded from ENA https://www.ebi.ac.uk/ena/browser/view/PRJNA556668

This folder contains the scripts created for data download, alignment, and output logs of completed runs. The folder also contains the processed CpG RDS file post smoothing. 

This folder contains the binaries for Bismark version 0.24.2 and Trimgalore version 0.6.10, which are newer versions of these softwares than those available on Sherlock. This may change in the future and may need to be updated accordingly.

Homer is not available on sherlock and is installed here locally.

The mouse whole genome from Gencode and Ensmble is stored in this direcoty including fasta and gtf file. The index for bismark alignment is also here. 

The companion directory of this folder containing all the raw pipeline data is 
/scratch/groups/ximenac/GSE134873

##2. NOVOGENE_2025
### DRIP-Seq data of the First R-loop Sequencing of the human retina.

The pipeline data cleanup and alignment scripts are stored here. 