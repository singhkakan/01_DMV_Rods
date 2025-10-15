#!/usr/bin/bash
#SBATCH --job-name=FastP
#SBATCH -p bigmem
#SBATCH --time=06:00:00
#SBATCH --mem=256GB
#SBATCH -c 3
#SBATCH --ntasks=10

#module purge
module load devel
module load system
module load biology
export PATH="$PATH:/home/users/singhkak/fastp"

mkdir $GROUP_SCRATCH/PRJNA294311/ChipSeq_Rods/fastq_trimmed
fastp_out_dir=$GROUP_SCRATCH/PRJNA294311/ChipSeq_Rods/fastq_trimmed
fasta=$GROUP_HOME/XCD_BSSeq/NOVOGENE_2025/adapter.fa
fastq_dir=$GROUP_SCRATCH/PRJNA294311/ChipSeq_Rods/fastq


# -w N: start N number of parallel threads
# -y: turning on low complexity filter such that 30% complexity is required 
# -l: Minimum length cut-off. For Chip-Seq, Encode recommends a minimum read length of 50
# -M N: the mean quality threshold requirement option used my -3 -5; default is 20. Useful for removing N bases from the end.
# -3, -5: move a sliding window from front (5') to tail, drop the bases in the window if its mean quality < threshold, stop otherwise

cd $fastq_dir
for j in *
do    
    out="$fastp_out_dir"
    outname="${j%%.*}"
    cd $out
    fastp -w 9 -y -M 30 -3 -5 -l 40 --adapter_fasta="$fasta" -i $fastq_dir/"$j" -o $out/"$outname"_cut.fq.gz -h $out/"$outname"
    cd ..
done

