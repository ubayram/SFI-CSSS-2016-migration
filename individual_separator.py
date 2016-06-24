#Script to separate out individual birds from data file
#Input path of data file at command line
#Script creates a new data file for each individual bird within the original file

from sys import argv

#Command line input is a filename ending in .txt
infilename = argv[1]

infile = open(infilename,'r')

bird_ID_list = []

#For each line of the original data file, check the corresponding bird ID
#If the ID is not yet in the bird_ID_list list, add it to the list.
for line in infile:
    line_stripped = line.rstrip()
    line_list = line_stripped.split("  ")
    bird_ID = line_list[-1]
    if bird_ID not in bird_ID_list:
        bird_ID_list.append(bird_ID)
infile.close()
#bird_ID_list now contains the ID labels of all individual birds in this data set

#For each bird ID in the bird_ID_list list, open a new file labelled with the bird ID
#Write all lines from the original file corresponding to this ID to the new file. 
for bird in bird_ID_list:
    outfile = open(infilename[0:-4]+"_"+bird[1:-1]+".txt",'w')
    infile = open(infilename,'r')

    for line in infile:
        if bird in line:
            outfile.write(line)
    outfile.close()
    infile.close()
