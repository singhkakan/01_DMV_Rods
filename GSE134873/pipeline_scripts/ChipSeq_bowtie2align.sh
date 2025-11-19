#!/usr/bin/bash
#SBATCH -p bigmem
#SBATCH --time=23:59:00
#SBATCH --mem=256GB
#SBATCH -c 2
#SBATCH --ntasks=16

module load devel
module load system
module load biology
module load bowtie2/2.5.4
module load samtools


index=/home/groups/ximenac/XCD_BSSeq/NOVOGENE_2025/Bowtie2_Index/GRCh38_Ensmble/GRCh38_Ensmble
fastq="/scratch/groups/ximenac/GSE134873/ChipSeq/fastq_trimmed"
Output="/scratch/groups/ximenac/GSE134873/ChipSeq/bowtie2_aligned"
mkdir $Output

#cd $GROUP_SCRATCH/NOVOGENE_2025/fastq_trimmed
cd $fastq
for j in *.gz
do    
    out="$Output"
    cd $out
    outname="${j%%.*}"
    bowtie2 -q -N 1 --very-sensitive -p 10 -x $index $fastq/"$j" -S "$outname".sam &
    cd ..
done
wait

cd $Output
for j in *sam
do
    out="$Output"
    cd $out
    outname="${j%%.*}" 
    samtools view -bSq 20 -o tmp.bam "$j" #convert sam to bam
    samtools sort -@ 8 tmp.bam > "$outname".bam #filter reads with mapq > 20
    samtools index -b "$outname".bam
    rm tmp.bam
done
wait

exit


