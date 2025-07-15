#!/usr/bin/bash
#BATCH --job-name=PRJNA214817_data_download
#SBATCH --time=08:00:00
#SBATCH --partition=normal
#SBATCH -c 4
#SBATCH --mem=8GB

#PRJNA208503
mkdir $GROUP_SCRATCH/PRJNA208503/wgbs
mkdir $GROUP_SCRATCH/PRJNA208503/wgbs/fastq
cd $GROUP_SCRATCH/PRJNA208503/wgbs/fastq/

#Data was downloaded from ENA https://www.ebi.ac.uk/ena/browser/view/PRJNA208503

#MethylC-Seq_mm_fc_1wk
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR921/SRR921767/SRR921767.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR921/SRR921768/SRR921768.fastq.gz &
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR921/SRR921769/SRR921769.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR921/SRR921770/SRR921770.fastq.gz &
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR921/SRR921771/SRR921771.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR921/SRR921772/SRR921772.fastq.gz &

wait

#MethylC-Seq_mm_fc_2wk
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR921/SRR921694/SRR921694.fastq.gz &
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR921/SRR921695/SRR921695.fastq.gz 
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR921/SRR921696/SRR921696.fastq.gz &

wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR921/SRR921773/SRR921773.fastq.gz 
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR921/SRR921774/SRR921774.fastq.gz &
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR921/SRR921775/SRR921775.fastq.gz
wait

#MethylC-Seq_mm_fc_male_7wk_neun_pos
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR921/SRR921809/SRR921809.fastq.gz &
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR921/SRR921810/SRR921810.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR921/SRR921811/SRR921811.fastq.gz &
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR921/SRR921812/SRR921812.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR921/SRR921813/SRR921813.fastq.gz &
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR921/SRR921814/SRR921814.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR921/SRR921815/SRR921815.fastq.gz &
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR921/SRR921816/SRR921816.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR921/SRR921817/SRR921817.fastq.gz &
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR921/SRR921818/SRR921818.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR921/SRR921819/SRR921819.fastq.gz &

wait
