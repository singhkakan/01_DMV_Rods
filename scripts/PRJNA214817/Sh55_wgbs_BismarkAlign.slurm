#!/usr/bin/bash
#SBATCH --job-name=Bismark_Align
#SBATCH --time=23:59:59
#SBATCH -p normal
#SBATCH -c 20
#SBATCH --mem=228GB
#SBATCH --ntasks=4

#Ensuring Bismark is in path
export PATH="$PATH:/home/users/singhkak/Bismark-0.24.2"
#Building Bismark reference genome

#Load Dependencies
module load devel
module load perl/5.36.1
module load biology
module load bowtie2/2.3.4.1
module load samtools/1.16.1

dir=PRJNA214817

#If directory exists
#rm /scratch/groups/ximenac/PRJNA214817/Bismark_Aligned/*
#rmdir /scratch/groups/ximenac/PRJNA214817/Bismark_Aligned

#Else create the directory
Genome=/home/groups/ximenac/01_DMV_Rods/data/01_raw/mouse_genome_no_patches/Ensmble

#This folder has all the "bowtie2" binaries
path_to_bowtie2=/share/software/user/open/bowtie2/2.3.4.1/bin/
Output=/scratch/groups/ximenac/01_DMV_Rods/$dir/wgbs/Bismark_Aligned/
fastq=/scratch/groups/ximenac/01_DMV_Rods/$dir/wgbs/fastq_trimmed

mkdir $Output

cd $fastq
filename=(*.gz)
cd $Output
for j in 0 2 4 6 8 
do
    id_1=${filename["$j"]}
    echo "$id_1"
    k=$(($j+1))
    id_2=${filename[("$k")]}
    echo "$id_2"
    outname="${id_1%%_*}"
    bismark --gzip --multicore 6 -p 2 --genome_folder $Genome --local --path_to_bowtie $path_to_bowtie2 --Output_dir $Output -q -1 $fastq/"$id_1" -2 $fastq/"$id_2" &
done 

wait

exit


