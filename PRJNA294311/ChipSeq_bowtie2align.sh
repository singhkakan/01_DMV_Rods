#!/usr/bin/bash
#SBATCH -p bigmem
#SBATCH --time=23:59:00
#SBATCH --mem=256GB
#SBATCH -c 2
#SBATCH --ntasks=10

module load devel
module load system
module load biology
module load bowtie2/2.5.4
module load samtools


index=/home/groups/ximenac/XCD_BSSeq/GSE134873/mouse_genome_no_patches/Bowtie2_mm39/Bowtie2_mm39
fastq="/scratch/groups/ximenac/PRJNA294311/ChipSeq_Rods/fastq_trimmed"
Output="/scratch/groups/ximenac/PRJNA294311/ChipSeq_Rods/bowtie2_aligned"
mkdir $Output

#cd $GROUP_SCRATCH/NOVOGENE_2025/fastq_trimmed
cd $fastq
for j in *.gz
do    
    out="$Output"
    cd $out
    outname="${j%%.*}"
    bowtie2 -q -N 1 --very-sensitive -p 8 -x $index $fastq/"$j" -S "$outname".sam &
    cd ..
done
wait

cd $Output
for j in *sam
do
    out="$Output"
    cd $out
    outname="${j%%.*}" 
    samtools view -bS -o tmp.bam "$outname".sam #convert sam to bam
    samtools view -bq 20 tmp.bam | samtools sort -@ 8 -o "$outname".bam #filter reads with mapq > 20
    samtools index -b "$outname".bam &
    rm tmp.bam
    cd ..
done
wait

exit


