#!/usr/bin/bash
#SBATCH --job-name=FastP
#SBATCH -p bigmem
#SBATCH --time=23:00:00
#SBATCH --mem=256GB
#SBATCH -c 2
#SBATCH --ntasks=10

#module purge
module load devel
module load system
module load biology
export PATH="$PATH:/home/users/singhkak/fastp"

mkdir $GROUP_SCRATCH/01_DMV_Rods/GSE134873/wgbs/fastq_trimmed


fastp_out_dir=$GROUP_SCRATCH/01_DMV_Rods/GSE134873/wgbs/fastq_trimmed
fasta=$GROUP_HOME/01_DMV_Rods/scripts/NOVOGENE_2025/adapter.fa
fastq_dir=$GROUP_SCRATCH/01_DMV_Rods/GSE134873/wgbs/fastq


# -w N: start N number of parallel threads
# -l: Minimum length cut-off. For Chip-Seq, Encode recommends a minimum read length of 50
# -M N: the mean quality threshold requirement option used my -3 -5; default is 20. Useful for removing N bases from the end.
# -3, -5: move a sliding window from front (5') to tail, drop the bases in the window if its mean quality < threshold, stop otherwise
# -f, -F:
# -t, -T: 
# -c: Correction of paired end reads

cd $fastq_dir
filename=(*.gz)
for j in 0 2 4 6 8 10
do
    id_1=${filename["$j"]}
    echo "$id_1"
    k=$(($j+1))
    id_2=${filename[("$k")]}
    echo "$id_2"
    outname="${id_1%%_*}"
    fastp -w 8 -c -f 10 -F 18 -t 8 -T 13 -l 28 --adapter_fasta="$fasta" -i $fastq_dir/"$id_1" -I $fastq_dir/"$id_2" -o $fastp_out_dir/"$outname"_1.fq.gz -O $fastp_out_dir/"$outname"_2.fq.gz -h $fastp_out_dir/"$outname".html
done



