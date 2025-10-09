#!/usr/bin/bash
#SBATCH -p bigmem
#SBATCH --time=03:59:59
#SBATCH --mem=16GB
#SBATCH -c 1
#SBATCH --ntasks=1

cd $GROUP_SCRATCH
#Define the single end directories
outname_SE=(PRJNA208503 PRJNA294311)
#Define the paired end directories
outname_PE=(PRJNA343691 PRJNA541237 GSE134873)


#create a file called samples.txt with the sample ids of all the output file names in all the folders

for j in */RNASeq/STAR_aligned/
do
    cd "$j"
    ls *ReadsPerGene.out.tab > sample.txt
    #Remove ".fastq.gz.ReadsPerGene.out.tab" from the sample IDs
    sed -i 's/\.fastq\.gzReadsPerGene\.out\.tab//g' sample.txt
    #Add "geneID" to it
    sed -i '1iGENE_ID\t' sample.txt
    cd $GROUP_SCRATCH
done
        

#Extract the second column of the STAR output file labelled "*ReadsPerGene.out.tab". 
#This second column has the sum of the read counts from either strand
#Pull this column out of each file and save it in a txt file with the sample's ID as filename
#j is the folder
for j in */RNASeq/STAR_aligned/
do
    cd "$j"
    rm *count
    outname="${j%%/*}"
    for i in *ReadsPerGene.out.tab
    do
        sample="${i%%_*}"
        cat "$i" | tail -n +5 | cut -f2 > "$sample".count
    done
    #Now extract the gene ids
    tail -n +5 "$i" | cut -f1 > geneids.txt
    #Finally combine all of these columns together using the ‘paste’ command, and put it in a temporary file
    paste geneids.txt SRR*count > "$outname".tmp.count
    #And create a header of sample names and combine it with the temp file
    cat <(cat sample.txt | sort | paste -s) "$outname".tmp.count > "$outname"_total_counts.txt
    rm *count 
    cd $GROUP_SCRATCH
done




