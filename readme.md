# Praat-scripts
These are just various Praat scripts I've written that are general enough for a wider audience.

## cleanAfterDARLA.praat
After being processed in [DARLA](http://darla.dartmouth.edu), a forced aligned .TextGrid will have lots of intervals that indicate silence (marked as "sil") that are all adjacent to each other. There are also some intervals labeled "sp" in the word tier. Similarly, if processed with [SPPAS](http://www.sppas.org), silent boundaries are marked with "#". 

I don't need these labels, and I prefer blanks, so this script removes the text from those intervals. As a bonus, if there are multiple adjacent silence intervals, it'll combine them into one.

To run it, selected a TextGrid in Praat first, and then let'er rip. It'll output a new file in Praat with the same name but with "_clean" appended to the filename. You can then save it yourself.