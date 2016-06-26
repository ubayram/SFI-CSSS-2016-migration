def cleanTime(time_str):
	
	list_ = time_str.split()
	
	# month/day/year
	date = list_[0].split('-')
	time = list_[1].split(':')
	print date
	if len(date[1]) == 1:
		date[1] = str('0' + date[1])

	fixed_date = int(str(date[2] + date[1] + date[0]))

	fixed_time = float(str(time[0] + time[1]))
	
	return fixed_date, fixed_time
#########################3Main##########################
fo = open('../data/tracking_goose_data.csv', 'r')

i = 0
for line in fo:
	if i > 0:
		print line
		bird_id = line.split(',')[11]
		date_, time_ = cleanTime(line.split(',')[2])
		longitude = float(line.split(',')[3])
		latitude = float(line.split(',')[4])
		heading = float(line.split(',')[5])
		height = float(line.split(',')[6])
		migration_stage = line.split(',')[7]
		season = line.split(',')[8]
		
		#print date_
	i = 1



