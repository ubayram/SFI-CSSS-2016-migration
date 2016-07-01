#Script to convert time and date format in original files to a scalar value for plotting
#Note: assumes all data is from the same year - can expand to multiple years if needs be.
#Requires txt file with data columns separated by one whitespace.

from sys import argv

infilename = argv[1]

infile = open(infilename,'r')
outfile = open(infilename[0:-4]+'_scalartime.txt','w')

#List containing length of each month in the year in days.
monthlengths = [31,28,31,30,31,30,31,31,30,31,30,31]

for line in infile:
    linelist = line.split(" ")
    date = linelist[1]
    datelist = date.split("-")
    time = linelist[2]
    timelist = time.split(":")

    #Calculate scalartime by summing the number of minutes in the time list (hours and minutes) and datelist (months and days)
    #Add total minutes from hours and minutes elapsed in current day
    scalartime = int(timelist[0])*60+int(timelist[1])
    #Add total minutes from past days in current month
    scalartime = scalartime + (int(datelist[2])-1)*24*60
    #Add total minutes from past months in current year
    for x in range (0,int(datelist[1])):
        scalartime = scalartime + monthlengths[x]*24*60

    #Replace date and time in line with scalartime
    linelist [1] = str(scalartime)
    del(linelist[2])

    #Write data to file
    outfile.write(" ".join(linelist))
