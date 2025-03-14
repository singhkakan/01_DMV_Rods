#!/usr/bin/bash
#BATCH --job-name=PRJNA541237_data_download
#SBATCH --time=23:00:00
#SBATCH --partition=normal
#SBATCH -c 4
#SBATCH --mem=8GB

#Mouse embryos


# PRJNA541237
mkdir $GROUP_SCRATCH/01_DMV_Rods/PRJNA541237/wgbs
mkdir $GROUP_SCRATCH/01_DMV_Rods/PRJNA541237/wgbs/fastq
cd $GROUP_SCRATCH/01_DMV_Rods/PRJNA541237/wgbs/fastq/

#Data was downloaded from ENA https://www.ebi.ac.uk/ena/browser/view/PRJNA541237

#WGBS_WT_Rep1
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR901/006/SRR9016926/SRR9016926_1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR901/006/SRR9016926/SRR9016926_2.fastq.gz

#WGBS_WT_Rep2
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR118/087/SRR11806587/SRR11806587_1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR118/087/SRR11806587/SRR11806587_2.fastq.gz


wait
