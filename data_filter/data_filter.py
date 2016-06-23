#Script to separate goose tracking data by year and spring/fall


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
