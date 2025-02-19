#!/usr/bin/bash
#BATCH --job-name=PRJNA294311_data_download
#SBATCH --time=23:00:00
#SBATCH --partition=normal
#SBATCH -c 4
#SBATCH --mem=8GB

#Nathan's rod and cone photoreceptors wgbs

# PRJNA294311
mkdir $GROUP_SCRATCH/01_DMV_Rods/PRJNA294311/wgbs
mkdir $GROUP_SCRATCH/01_DMV_Rods/PRJNA294311/wgbs/fastq
cd $GROUP_SCRATCH/01_DMV_Rods/PRJNA294311/wgbs/fastq/


#Data was downloaded from ENA https://www.ebi.ac.uk/ena/browser/view/PRJNA294311

#MethylC-seq_WT_rods_rep1
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR272/006/SRR2722846/SRR2722846.fastq.gz &

#MethylC-seq_WT_rods_rep2
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR272/007/SRR2722847/SRR2722847.fastq.gz &

#MethylC-seq_WT_cones_rep1
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR272/000/SRR2722850/SRR2722850.fastq.gz &

#MethylC-seq_WT_cones_rep2
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR272/001/SRR2722851/SRR2722851.fastq.gz &

wait
