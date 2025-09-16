#!/usr/bin/python3
import sys
import fileinput

#This script will read a bed file with 5 columns
#chr1    1000    5000    gene1    +
#chr1    6000    7000    gene2    -
#chr2    1500    3000    gene3    +

#Read in bed files with all genes str and stop locations with strand information

def read_bed_file(file_path):
    """Read a BED file and return two lists based on strand."""
    plus_strand = []
    minus_strand = []
    chromosome = []
    
    try:
        with open(file_path, 'r') as file:
            for line in file:
                # Skip comments and empty lines
                if line.startswith('#') or not line.strip():
                    continue
                # Split the line into columns
                columns = line.strip().split('\t')
                # Ensure there are at least 5 columns (chromosome, start, end, gene_id, strand)
                if len(columns) < 5:
                    print(f"Warning: Line skipped due to insufficient columns: {line.strip()}")
                    continue
                # Extract relevant columns
                chrm = columns[0]
                start = int(columns[1])
                end = int(columns[2])
                gene_id = columns[3]
                strand = columns[4]
                chromosome.append(chrm)
#Create two separate lists/dictionaries based on chromosome (chr) and strands
                if strand == '+':
                    plus_strand.append((chrm, start, end, gene_id, strand))
                elif strand == '-':
                    minus_strand.append((chrm, start, end, gene_id, strand))
                else:
                    print(f"Warning: Unknown strand '{strand}' in line: {line.strip()}")
            chromosome = list(set(chromosome))   
 
    except FileNotFoundError:
        print(f"Error: The file '{file_path}' was not found.")
    except Exception as e:
        print(f"An error occurred while reading '{file_path}': {e}")
    
    chromosome = list(set(chromosome))
    
    return plus_strand, minus_strand, chromosome


# + strand start and end are defined as 'str' and 'end'

# - strand start and end are defined as 'end*' and 'str*'


# For each chromosome
# if str > str*
# then, if str* + 400 > str (i.e. str is within a distance of 400 bp from str*)
#          then this is a co-promoter; write it to file

def copromoter(plus, minus, chrm):
    for plusList in plus:
        chr_plus = plusList[0]
        str1 = int(plusList[1])
        end1 = int(plusList[2])
        gene1 = plusList[3]
        #print(chr_plus)
        for minusList in minus:
            chr_minus=minusList[0]
            str2 = int(minusList[2]) #remember to flip these
            end2 = int(minusList[1])
            gene2 = minusList[3]
            if chr_plus == chr_minus:
                if str1 > str2:
                    if str2 + 2301 > str1:
                        print(chr_plus, '\t', str2, '\t', str1, '\t', gene1, '\t', gene2, '\t', chr_minus)

                #print(plusList[0:][0]
                 
def main():
    if len(sys.argv) != 2:
        print("Usage: python3 read_bed_by_strand.py <path_to_bed_file>")
        sys.exit(1)
    file_path = sys.argv[1]
    plus_data, minus_data, chromosome = read_bed_file(file_path)
    copromoter(plus_data, minus_data, chromosome)
#    for line in plus_data:
#        print(line)
#    for gene_id in minus_data:
#        print(f"Gene ID: {gene_id}")
#    print(chromosome)
if __name__ == "__main__":
    main()


# if str < str*
# then, if end* < str <str* (i.e. str falls in between the str* and end* of the - strand transcript
#            then this is a co-promoter; write it to file

