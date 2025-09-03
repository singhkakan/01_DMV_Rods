#!/usr/bin/bash
#SBATCH -p bigmem
#SBATCH --time=03:59:59
#SBATCH --mem=256GB
#SBATCH -c 1
#SBATCH --ntasks=20

module load devel
module load system
module load biology
module load star/2.7.10b
module load samtools 

genome_fa=/home/groups/ximenac/XCD_BSSeq/GSE134873/mouse_genome/GRCm39.dna.primary_assembly.fa
genome_gtf=/home/groups/ximenac/XCD_BSSeq/GSE134873/mouse_genome_no_patches/GRCm39.114.chr.gtf

index=/home/groups/ximenac/XCD_BSSeq/RNA_Seq/STAR_index

STAR --runMode genomeGenerate \
	--runThreadN 16 \
	--genomeDir "$index" \
	--genomeFastaFiles "$genome_fa" \
	--sjdbGTFfile "$genome_gtf" \
	--sjdbOverhang 99

wait
