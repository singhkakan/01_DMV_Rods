#!/usr/bin/bash
#SBATCH -p normal
#SBATCH --time=23:00:00
#SBATCH --mem=16GB
#SBATCH -c 4
#SBATCH --ntasks=5
cd /scratch/groups/ximenac/GSE134873/ChipSeq/fastq


#Retina Samples

#Hu1_ret_ChIP_input
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR101/050/SRR10172850/SRR10172850.fastq.gz

#Hu1_ret_ChIP_H3K27ac
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR101/049/SRR10172849/SRR10172849.fastq.gz
#Hu2_ret_ChIP_H3K27ac
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR101/058/SRR10172858/SRR10172858.fastq.gz
#Hu3_ret_ChIP_H3K27ac
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR101/066/SRR10172866/SRR10172866.fastq.gz

#Hu3_ret_ChIP_CRX
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR101/065/SRR10172865/SRR10172865.fastq.gz
#Hu6_ret_ChIP_CRX
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR101/078/SRR10172878/SRR10172878.fastq.gz
#Hu20_ret_ChIP_CRX
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR101/003/SRR10172903/SRR10172903.fastq.gz
#Hu21_ret_ChIP_CRX
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR101/005/SRR10172905/SRR10172905.fastq.gz

#Hu22_ret_ChIP_RORB
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR101/008/SRR10172908/SRR10172908.fastq.gz

#Hu6_ret_ChIP_CTCF
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR101/079/SRR10172879/SRR10172879.fastq.gz
#Hu22_ret_ChIP_CTCF
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR101/007/SRR10172907/SRR10172907.fastq.gz
#Hu25_ret_ChIP_CTCF
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR101/009/SRR10172909/SRR10172909.fastq.gz

#Hu8_ret_ChIP_NRL
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR101/087/SRR10172887/SRR10172887.fastq.gz
#Hu9_ret_ChIP_NRL
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR101/090/SRR10172890/SRR10172890.fastq.gz &
#Hu13_ret_ChIP_NRL
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR101/097/SRR10172897/SRR10172897_1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR101/097/SRR10172897/SRR10172897_2.fastq.gz
#Hu14_ret_ChIP_NRL
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR101/099/SRR10172899/SRR10172899.fastq.gz

#Hu14_ret_ChIP_H3K4me2
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR101/098/SRR10172898/SRR10172898_1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR101/098/SRR10172898/SRR10172898_2.fastq.gz
#Hu17_ret_ChIP_H3K4me2
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR101/001/SRR10172901/SRR10172901_1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR101/001/SRR10172901/SRR10172901_2.fastq.gz
#Hu18_ret_ChIP_H3K4me2
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR101/002/SRR10172902/SRR10172902_1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR101/002/SRR10172902/SRR10172902_2.fastq.gz

#Macula Samples

#Hu26_mac_ChIP_input
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR101/012/SRR10172912/SRR10172912.fastq.gz

#Hu9_mac_ChIP_H3K27ac
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR101/089/SRR10172889/SRR10172889.fastq.gz
#Hu21_mac_ChIP_H3K27ac
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR101/004/SRR10172904/SRR10172904.fastq.gz
#Hu26_mac_ChIP_H3K27ac
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR101/011/SRR10172911/SRR10172911.fastq.gz


#RPE Choroid Samples

#Hu12_RPE_ChIP_input
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR101/095/SRR10172895/SRR10172895.fastq.gz

#Hu1_RPE_ChIP_H3K27ac
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR101/053/SRR10172853/SRR10172853.fastq.gz
#Hu2_RPE_ChIP_H3K27ac
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR101/060/SRR10172860/SRR10172860.fastq.gz
#Hu3_rpe_ChIP_H3K27ac
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR101/068/SRR10172868/SRR10172868.fastq.gz
#Hu12_RPE_ChIP_H3K27ac
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR101/094/SRR10172894/SRR10172894.fastq.gz
