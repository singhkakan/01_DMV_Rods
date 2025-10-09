#!/usr/bin/bash
#SBATCH -p bigmem
#SBATCH --time=23:59:59
#SBATCH --mem=512GB
#SBATCH -c 5
#SBATCH --ntasks=15

module load devel
module load system
module load biology
module load star/2.7.10b
module load samtools 

genome_fa=/home/groups/ximenac/XCD_BSSeq/GSE134873/mouse_genome/GRCm39.dna.primary_assembly.fa
genome_gtf=/home/groups/ximenac/XCD_BSSeq/GSE134873/mouse_genome_no_patches/GRCm39.114.chr.gtf

cd $GROUP_SCRATCH
#Define the single end directories
outname_SE=(PRJNA208503 PRJNA294311)
#Define the paired end directories
outname_PE=(PRJNA343691 PRJNA541237 GSE134873)

index=/home/groups/ximenac/XCD_BSSeq/RNA_Seq/STAR_index

for i in "${outname_SE[@]}"
do
    mkdir $GROUP_SCRATCH/"$i"/RNASeq/STAR_aligned
    star_out_dir=$GROUP_SCRATCH/"$i"/RNASeq/STAR_aligned
    fastq_dir=$GROUP_SCRATCH/"$i"/RNASeq/fastq_trimmed
    cd $fastq_dir
    for j in *.gz
        do
        echo $j
        STAR --runThreadN 6 \
        --genomeDir /home/groups/ximenac/XCD_BSSeq/RNA_Seq/STAR_index \
        --readFilesCommand gunzip -c \
        --readFilesIn "$j" \
        --quantMode GeneCounts \
        --sjdbGTFfile "$genome_gtf" \
        --outFileNamePrefix "$star_out_dir"/"$j" \
        --outSAMtype BAM SortedByCoordinate \
        --outBAMsortingThreadN 4 \
        --outWigType bedGraph \
        --outWigStrand Stranded &
        done
        wait
        cd $GROUP_SCRATCH
done

cd $GROUP_SCRATCH

for i in "${outname_PE[@]}"
do    
    mkdir $GROUP_SCRATCH/"$i"/RNASeq/STAR_aligned
    star_out_dir=$GROUP_SCRATCH/"$i"/RNASeq/STAR_aligned
    fastq_dir=$GROUP_SCRATCH/"$i"/RNASeq/fastq_trimmed
    cd $fastq_dir
    filename=(*.gz)
    for j in 0 2 4 6 8 10
    do
        id_1=${filename["$j"]}
        echo "$id_1"
        k=$(($j+1))
        id_2=${filename[("$k")]}
        echo "$id_2"
        STAR --runThreadN 8 \
        --genomeDir /home/groups/ximenac/XCD_BSSeq/RNA_Seq/STAR_index \
        --readFilesCommand gunzip -c \
        --readFilesIn "$id_1" "$id_2"  \
        --sjdbGTFfile "$genome_gtf" \
        --outSAMtype BAM SortedByCoordinate \
        --quantMode GeneCounts \
        --outBAMsortingThreadN 4 \
        --outWigType bedGraph \
        --outWigStrand Stranded \
        --outFileNamePrefix "$star_out_dir"/"$id_1" &
    done
    wait
    cd $GROUP_SCRATCH
done

wait


