#!/usr/bin/bash
#SBATCH -p bigmem
#SBATCH --time=23:00:00
#SBATCH --mem=256GB
#SBATCH -c 1
#SBATCH --ntasks=12

module load system
module load devel
module load biology
module load fastqc/0.11.8

# This module loads pigz: A parallel implementation of gzip for modern multi-processor, multi-core machines 2.4. This should speed up the running of trim_galore v0.6
module load contribs
module load poldrack
module load pigz/2.4
module load samtools

#Create a list of directories with paired end reads
declare -a paired_end
#paired_end=([0]="PRJNA214817" [1]="PRJNA343691" [2]="PRJNA393524" [3]="PRJNA521997" [4]= "PRJNA541237")
paired_end=(PRJNA343691 PRJNA393524 PRJNA521997 PRJNA541237)

#Create a list of directories with single end reads
declare -a single_end
#single_end=([0]="PRJNA208503" [1]="PRJNA294311")
single_end=(PRJNA294311)

#PRJNA208503 #single
#PRJNA214817 #paired
#PRJNA294311 #single
#PRJNA343691 #paired
#PRJNA393524 #paired
#PRJNA521997 #paired
#PRJNA541237 #paired

cd /scratch/groups/ximenac/

for dir in *
do 
    mkdir $dir/fastqc
done


for dir in "${paired_end[@]}"
do 
    echo $dir
    fastqc -t 6 -o $dir/fastqc $dir/fastq/*gz &
    cd ../..
done


wait

for dir in "${single_end[@]}"
do
    echo $dir
    fastqc -t 6 -o $dir/fastqc $dir/fastq/*gz &
    cd ../..
done
