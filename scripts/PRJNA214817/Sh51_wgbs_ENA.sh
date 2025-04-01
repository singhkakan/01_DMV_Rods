#!/usr/bin/bash
#BATCH --job-name=PRJNA214817_data_download
#SBATCH --time=08:00:00
#SBATCH --partition=normal
#SBATCH -c 4
#SBATCH --mem=8GB

#Mouse bone marrow hematopoietic stem cells dataset

# PRJNA214817
mkdir $GROUP_SCRATCH/PRJNA214817/wgbs
mkdir $GROUP_SCRATCH/PRJNA214817/wgbs/fastq
cd $GROUP_SCRATCH/PRJNA214817/wgbs/fastq/


#Data was downloaded from ENA https://www.ebi.ac.uk/ena/browser/view/PRJNA214817
#wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR921/SRR921774/SRR921774.fastq.gz

#m12_b1 Bisulfite-Seq (Exclude this sample as it only has 5 million reads)
#wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR950/SRR950180/SRR950180_1.fastq.gz &
#wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR950/SRR950180/SRR950180_2.fastq.gz

#m12_b2l1 Bisulfite-Seq
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR950/SRR950179/SRR950179_1.fastq.gz &
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR950/SRR950179/SRR950179_2.fastq.gz

#m12_b2l2 Bisulfite-Seq
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR950/SRR950178/SRR950178_1.fastq.gz &
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR950/SRR950178/SRR950178_2.fastq.gz

#m12_b2l3 Bisulfite-Seq
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR950/SRR950177/SRR950177_1.fastq.gz 
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR950/SRR950177/SRR950177_2.fastq.gz

#m12_b2l4 Bisulfite-Seq
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR950/SRR950176/SRR950176_1.fastq.gz &
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR950/SRR950176/SRR950176_2.fastq.gz

#exclude this, it is a dnmt3a ko sample
#wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR950/SRR950169/SRR950169_1.fastq.gz &
#wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR950/SRR950169/SRR950169_2.fastq.gz

#m12_b3 Bisulfite-Seq
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR950/SRR950175/SRR950175_1.fastq.gz &
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR950/SRR950175/SRR950175_2.fastq.gz

#m12_b4l1 Bisulfite-Seq
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR950/SRR950174/SRR950174_1.fastq.gz &  
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR950/SRR950174/SRR950174_2.fastq.gz

#m12_b4l2 Bisulfite-Seq 
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR950/SRR950173/SRR950173_1.fastq.gz &
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR950/SRR950173/SRR950173_2.fastq.gz

wait 

cat SRR950176_1.fastq.gz SRR950177_1.fastq.gz SRR950178_1.fastq.gz SRR950179_1.fastq.gz SRR950180_1.fastq.gz > SRR95017680_1.fastq.gz
cat SRR950176_2.fastq.gz SRR950177_2.fastq.gz SRR950178_2.fastq.gz SRR950179_2.fastq.gz SRR950180_2.fastq.gz > SRR95017680_2.fastq.gz


wait
