#!/usr/bin/bash
#SBATCH -p normal
#SBATCH --time=23:00:00
#SBATCH --mem=128GB
#SBATCH -c 1
#SBATCH --ntasks=6

#building script to convert histone methylation chip seq files into peak summits or narrowpeaks from a bedGraphs file, using MACS3

module load system
module load devel
module load biology
module load ncurses/6.0
module load bedtools
module load samtools
module load gcc
module load python/3.9.0

module load py-cython/0.29.28_py39
module load py-numpy/1.26.3_py312
module load py-scikit-learn/1.5.1_py312

###Documentation for installing MACS 3

#To install a source distribution of MACS, unpack the distribution tarball, or clone Git repository with
#module load git
#git clone --recurse-submodules https://github.com/macs3-project/MACS.git

#Go to the directory where you cloned MACS from github or unpacked from tarball, and simply run the install command simply run the install command:
#cd MACS
#pip install .

export PATH="$PATH:/home/users/singhkak/MACS/"

cd /scratch/groups/ximenac/NATHANS/
for i in *bedGraph
do
    macs3 bdgpeakcall -i $i -c 2 -o "$i"_summits.bed
done


wait
