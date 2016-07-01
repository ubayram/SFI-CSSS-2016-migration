# Author: Ulya Bayram/ ulyabayram@gmail.com
set terminal pdfcairo font "Gill Sans,12" linewidth 5 rounded

#set size ratio

set xlabel "Attributes"
set ylabel "Number of Occurrences"
set title "Histogram of Observed Behaviors in the Dataset"
# Line style for axes
set style line 80 lt rgb "#808080"

# Line style for grid
set style line 81 lt 0  # dashed
set style line 81 lt rgb "#808080"  # grey

set grid back linestyle 81
set border 3 back linestyle 80 # Remove border on top and right.  These
             # borders are useless and make it harder
             # to see plotted lines near the border.
    # Also, put it in grey; no need for so much emphasis on a border.
set xtics nomirror
set ytics nomirror
set xtics rotate out

set logscale y

set style data histogram
set style fill transparent solid 0.6 noborder
set boxwidth 0.3


set output 'hist_migration_attribute_types.pdf'

plot "spring_attributes_4hist.txt" using 1:2 with boxes lc rgb "red" title "Spring Migration", "fall_attributes_4hist.txt" using 1:2 with boxes lc rgb "blue" title "Fall Migration", "attribute_names.txt" using 0:xticlabels(1) with points pt -1 notitle

