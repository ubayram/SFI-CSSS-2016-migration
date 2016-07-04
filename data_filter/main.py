# Author: Ulya Bayram
import preprocessing as pre


fo = open('tracking_goose_data.csv' , 'r')

pre.separateBySeason(fo)

#fo = open('filtered_data/migration_spring.txt', 'r')
#pre.computeIndividualSpeed(fo)
#pre.findMissingData(fo)
