#!/usr/bin/bash
#SBATCH -p normal
#SBATCH --time=23:00:00
#SBATCH --mem=128GB
#SBATCH -c 1
#SBATCH --ntasks=6

module load system
module load devel
module load biology
module load bedtools
module load samtools
module load gcc
module load python/3.12.1

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

