#!/usr/bin/bash
#SBATCH --job-name=Sh04_FastP
#SBATCH -p normal
#SBATCH --time=23:00:00
#SBATCH --mem=128GB
#SBATCH -c 3
#SBATCH --ntasks=21

#module purge
module load devel
module load system
module load biology

dir=PRJNA208503
export PATH="$PATH:/home/users/singhkak/fastp"

mkdir $GROUP_SCRATCH/01_DMV_Rods/$dir/wgbs/fastq_trimmed

fastp_out_dir="$GROUP_SCRATCH/01_DMV_Rods/$dir/wgbs/fastq_trimmed"
fasta="$GROUP_HOME/01_DMV_Rods/scripts/NOVOGENE_2025/adapter.fa"
fastq_dir="$GROUP_SCRATCH/01_DMV_Rods/$dir/wgbs/fastq"

# -w N: start N number of parallel threads
# -l: Minimum length cut-off. For Chip-Seq, Encode recommends a minimum read length of 50
# -M N: the mean quality threshold requirement option used my -3 -5; default is 20. Useful for removing N bases from the end.
# -3, -5: move a sliding window from front (5') to tail, drop the bases in the window if its mean quality < threshold, stop otherwise
# -f, -F:cut n bases from front (f) of read1 or (F) read2
# -t, -T:cut n bases from tail (t) of read1 or (T) read2
# -c: Correction of paired end reads

cd $fastq_dir
filename=(*.gz)
for j in {1..22}
do
    id_1=${filename["$j"]}
    echo "$id_1"
    outname="${id_1%%.*}"
    fastp -w 4 -l 20 -3 40 -5 40 -f 9 -t 5 --adapter_fasta="$fasta" -i $fastq_dir/"$id_1" -o $fastp_out_dir/"$outname"_1.fq.gz -h $fastp_out_dir/"$outname".html &
done

wait

