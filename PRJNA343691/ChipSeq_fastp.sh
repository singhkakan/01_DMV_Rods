#!/usr/bin/bash
#SBATCH --job-name=FastP
#SBATCH -p bigmem
#SBATCH --time=4:00:00
#SBATCH --mem=256GB
#SBATCH -c 8
#SBATCH --ntasks=2

module purge
module load devel
module load system
module load biology
export PATH="$PATH:/home/users/singhkak/fastp"

mkdir $GROUP_SCRATCH/PRJNA343691/ChipSeq_P21/fastq_trimmed
fastp_out_dir=$GROUP_SCRATCH/PRJNA343691/ChipSeq_P21/fastq_trimmed
fasta=$GROUP_HOME/XCD_BSSeq/NOVOGENE_2025/adapter.fa
fastq_dir=$GROUP_SCRATCH/PRJNA343691/ChipSeq_P21/fastq/

cd $GROUP_SCRATCH/PRJNA343691/ChipSeq_P21/fastq
for j in *
do    
    out="$fastp_out_dir"
    outname="${j%%.*}"
    cd $out
    fastp -w 4 -y -M 30 -3 -5 -l 40 --adapter_fasta="$fasta" -i $fastq_dir/"$j" -o $out/"$outname".fq.gz -h $out/"$outname"
    cd ..
done

