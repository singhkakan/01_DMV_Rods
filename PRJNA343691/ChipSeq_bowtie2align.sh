#!/usr/bin/bash
#SBATCH -p bigmem
#SBATCH --time=03:00:00
#SBATCH --mem=256GB
#SBATCH -c 8
#SBATCH --ntasks=4

module load devel
module load system
module load biology
module load bowtie2/2.5.4

index=/home/groups/ximenac/XCD_BSSeq/GSE134873/mouse_genome_no_patches/Bowtie2_mm39/Bowtie2_mm39
fastq="/scratch/groups/ximenac/PRJNA343691/ChipSeq_P21/fastq_trimmed"
Output="/scratch/groups/ximenac/PRJNA343691/ChipSeq_P21/bowtie2_aligned"
#mkdir $Output

#cd $GROUP_SCRATCH/NOVOGENE_2025/fastq_trimmed
cd "/scratch/groups/ximenac/PRJNA343691/ChipSeq_P21/fastq_trimmed/"
for j in *gz
do    
    out="$Output"
    cd $out
    outname="${j%%.*}"
    bowtie2 -q -N 1 --very-sensitive -p 8 -x $index $fastq/"$j" -S "$outname".sam 
    samtools view -bS "$outname".sam tmp.bam #convert sam to bam
    samtools view -bSq 20 tmp.bam | samtools sort -@ 8 -o "$outname".bam #filter reads with mapq > 20
    samtools index -b "$outname".bam &
    rm tmp.bam
    cd ..
done

#for i in SRR4252883*
#do
#    out="$Output"
#    cd $out
#    Outname="${i%%.*}"
#    bowtie2 -q -N 1 --very-sensitive -p 8 -x $index $fastq/"$i" -S "$Outname".sam &
#    cd ..
#done

wait

exit
