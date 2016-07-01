# SFI-CSSS-2016-migration
PLEASE DON'T MODIFY THE ORIGINAL DATA FILE tracking_goose_data.csv

In the tracking_goose_data.csv

Number of missing height data in rows of complete data set  20703
Number of missing heading data in rows of complete data set  3752

I've (Ulya) Divided the dataset into two, files are:
migration_spring.txt
migration_fall.txt

Each column has the data in the following order:

Date Time Longitude Latitude Heading Height Attribute(Migration Stage) Attribute_ID Bird_ID

Note that if you want to extract data from the csv file and if you don't know how to do that, since it is different from txt files, please look at the function separateBySeason() inside the preprocessing.py file, instead of modifying the original dataset file.
