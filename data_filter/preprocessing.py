# Author: Ulya Bayram
# For each function's owner/author, see comments above each function
from sys import argv

# - # - # - # - # - # - # - # - # - # - # - # - # - # - #
# Author: Chris Revell
#Script to separate out individual birds from data file
#Input path of data file at command line
#Script creates a new data file for each individual bird within the original file
def separateIndividually():

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

# Author: Chris Revell
#Script to separate goose tracking data by year and spring/fall
def separateBySeasonNYear():
	#Loop over all years for which we have data
	for x in range (2006,2015):
		#Open original data file
		infile = open('trackinggoosedata.txt','r')
		#Open separate files for spring and fall migration, labelled by year (x)
		outfile_spring = open('filtered_data/goose_spring_'+str(x)+'.txt','w')
		outfile_fall   = open('filtered_data/goose_fall_'+str(x)+'.txt','w')
		for line in infile:
		#Loop over all lines
		    if str(x)+'-' in line:
		    #If the year appears in this line of the file in form eg. 2006- then check whether it is spring or fall migration.
		        if 'spring' in line:
		            #If string 'spring' is present in this line of the original file, write the line to the spring data file
		            outfile_spring.write(line)
		        elif 'fall' in line:
		            #If string 'fall' is present in this line of the original file, write the line to the fall data file
		            outfile_fall.write(line)
		outfile_spring.close()
		outfile_fall.close()
		infile.close()
