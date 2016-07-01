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

# Author: Ulya Bayram
# Input file is csv file, output will be 2 txt files
# separated by the seasons
# First row of the input file is the headings, so skip the first
def separateBySeason(fo):

	#Open separate files for spring and fall migration
	file_spring = open('filtered_data/migration_spring.txt','w')
	file_fall   = open('filtered_data/migration_fall.txt','w')

	i = 0
	nan_counter = 0
	nan_counter2 = 0
	temp1 = 0
	for line in fo:
		if i == 0: # skip the first line containing headers for columns
			i = 1
			continue
		else:
			#Loop over all lines
			date_time = line.split(',')[2]
			date = date_time.split()[0]
			time_ = date_time.split()[1]

			long_ = line.split(',')[3]
			lat_ = line.split(',')[4]
			heading = line.split(',')[5]
			height = line.split(',')[6]
			
			'''
			if len(height) == 0:
				nan_counter += 1
				height = 'nan'
			if len(heading) == 0:
				nan_counter2 += 1
				heading = 'nan'
			'''



			# attribute is actually migration-stage
			# but fall vs spring migration is also a stage, so attribute reduces confusion
			attribute = line.split(',')[7]
			attribute_id = findAttributeId(attribute)
			current_season = line.split(',')[8]
			bird_id =  line.split(',')[11]
			bird_id = bird_id.replace('\"', '')

			bird_id2 = line.split(',')[12]
			bird_id2 = bird_id2.replace('\"', '')

			if bird_id != bird_id2:
				print "Id Missmatch ", bird_id, " ", bird_id2

			if len(bird_id) == 0:
				temp1 += 1

			if 'spring' in current_season:
				print >> file_spring, date, time_, long_, lat_, heading, height, attribute, attribute_id, bird_id
			if 'fall' in current_season:
				print >> file_fall, date, time_, long_, lat_, heading, height, attribute, attribute_id, bird_id

	#print 'Number of missing height data in rows of complete data set ', str(nan_counter)
	#print 'Number of missing heading data in rows of complete data set ', str(nan_counter2)
 	print temp1

# Author: Ulya Bayram
# Function that maps attribute names (string) into specific id's - for easy plotting
def findAttributeId(str_):
	
	f_attributes = open('filtered_data/attribute_names.txt', 'r')

	att_vec = []
	for line in f_attributes:
		att_vec.append(line.split()[0])
	str_ = str_.replace('\"', '')

	return att_vec.index(str_)

def findMissingData(fo):

	for line in fo:
		
		if len(line.split()) == 8:
			print 'missing still', len(line.split())

'''
# Author: Ulya Bayram
def getDay(date_str):

# Author: Ulya Bayram
def getTime(time_str):

# Author: Ulya Bayram
def getDeltaTime():

# Author: Ulya Bayram
# Function to compute -average- estimated speed of individual birds given gps tracking data
def computeIndividualSpeed(file_):
		
	for line in file_:
		date_ = line.split()[0]
		time_ = line.split()[1]
		long_ = 
'''
