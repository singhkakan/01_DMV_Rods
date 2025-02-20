#!/usr/bin/bash
#SBATCH -p normal
#SBATCH --time=23:00:00
#SBATCH --mem=16GB
#SBATCH -c 1
#SBATCH --ntasks=6

#WGBS Mouse Rod Photoreceptors 
#Data downloaded from ENA https://www.ebi.ac.uk/ena/browser/view/PRJNA556668

mkdir /scratch/groups/ximenac/01_DMV_Rods/GSE134873/wgbs
mkdir /scratch/groups/ximenac/01_DMV_Rods/GSE134873/wgbs/fastq

cd /scratch/groups/ximenac/01_DMV_Rods/GSE134873/wgbs/fastq

#Rod3m

#WGBS_3M_rep1
wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR983/002/SRR9833662/SRR9833662_1.fastq.gz &
wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR983/002/SRR9833662/SRR9833662_2.fastq.gz &
#WGBS_3M_rep2
wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR983/003/SRR9833663/SRR9833663_1.fastq.gz &
wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR983/003/SRR9833663/SRR9833663_2.fastq.gz &
#WGBS_3M_rep3 
wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR983/004/SRR9833664/SRR9833664_1.fastq.gz &
wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR983/004/SRR9833664/SRR9833664_2.fastq.gz


#Rod12m

#WGBS_12M_rep1
wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR983/005/SRR9833665/SRR9833665_1.fastq.gz &
wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR983/005/SRR9833665/SRR9833665_2.fastq.gz &
#WGBS_12M_rep2
wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR983/006/SRR9833666/SRR9833666_1.fastq.gz &
wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR983/006/SRR9833666/SRR9833666_2.fastq.gz &

#Rod18m

#WGBS_18M_rep1
wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR983/007/SRR9833667/SRR9833667_1.fastq.gz &
wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR983/007/SRR9833667/SRR9833667_2.fastq.gz
#WGBS_18M_rep2
wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR983/008/SRR9833668/SRR9833668_1.fastq.gz &
wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR983/008/SRR9833668/SRR9833668_2.fastq.gz &
#WGBS_18M_rep3
wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR983/009/SRR9833669/SRR9833669_1.fastq.gz &
wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR983/009/SRR9833669/SRR9833669_2.fastq.gz &

#Rod24m

#WGBS_24M_rep1
wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR983/000/SRR9833670/SRR9833670_1.fastq.gz &
wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR983/000/SRR9833670/SRR9833670_2.fastq.gz
#WGBS_24M_rep2
wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR983/001/SRR9833671/SRR9833671_1.fastq.gz &
wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR983/001/SRR9833671/SRR9833671_2.fastq.gz &
#WGBS_24M_rep3
wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR983/002/SRR9833672/SRR9833672_1.fastq.gz &
wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR983/002/SRR9833672/SRR9833672_2.fastq.gz &

#Adding the 'wait' is important to make slurm wait to end the slurm run untill all the background (&) processes (in this case the downloads) have completed.
wait

#Without the wait, download will be incomplete


