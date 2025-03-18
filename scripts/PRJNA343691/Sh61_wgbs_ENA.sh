#!/usr/bin/bash
#BATCH --job-name=PRJNA343691_data_download
#SBATCH --time=23:00:00
#SBATCH --partition=normal
#SBATCH -c 4
#SBATCH --mem=8GB


# PRJNA343691
mkdir $GROUP_SCRATCH/01_DMV_Rods/PRJNA343691/wgbs
mkdir $GROUP_SCRATCH/01_DMV_Rods/PRJNA343691/wgbs/fastq
cd $GROUP_SCRATCH/01_DMV_Rods/PRJNA343691/wgbs/fastq/


#Data was downloaded from ENA https://www.ebi.ac.uk/ena/browser/view/PRJNA343691

#Methyl-Adult-Rod_E_N-E14.5
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR425/009/SRR4254699/SRR4254699_1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR425/009/SRR4254699/SRR4254699_2.fastq.gz

#Methyl-Adult-Rod_E_N-E17.5
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR425/000/SRR4254700/SRR4254700_1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR425/000/SRR4254700/SRR4254700_2.fastq.gz

#Methyl-Adult-Rod_I_N-P3
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR425/002/SRR4254702/SRR4254702_1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR425/002/SRR4254702/SRR4254702_2.fastq.gz


wait
