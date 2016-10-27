###########################################################################################
#
# 	The goal for this script is to modify a selected TextGrid and remove any extraneous
#	boundaries that DARLA outputs and consolodate them into a single blank boundary. 
# 	Extraneous boundaries are any adjacent boundaries marked as blank, "sil", "#", or, "sp", 
#
#	Written by Joey Stanley, Septmeber 23, 2016. Home, Athens, GA.
#
###########################################################################################

writeInfoLine:  "Removing extraneous boundaries..."
appendInfoLine: ""

# Good site: http://praatscripting.lingphon.net/index.html

# Select the highlighted textgrid. "selected$" gets the name
thisTextgrid$ = selected$("TextGrid")

select TextGrid 'thisTextgrid$'

# Make a copy and rename it
Copy: thisTextgrid$
Rename... 'thisTextgrid$'_clean

# First go through briefly and zap any bad text
for thisTier from 1 to 2

	numberOfIntervals = Get number of intervals: thisTier
	for thisInterval from 1 to numberOfIntervals 
		
		thisText$ = Get label of interval: thisTier, thisInterval 

		if thisText$ = "sil" or thisText$ = "#" or thisText$ = "sp"
			# No replacement text argument means remove the text
			Set interval text... thisTier thisInterval 
		endif 
	endfor
endfor


# Now go through and remove any boundaries
for thisTier from 1 to 2

	numberOfOriginalIntervals = Get number of intervals: thisTier

	# Go through each interval
	for thisInterval from 1 to numberOfOriginalIntervals

		# After a few cycles, we will have already deleted some boundaries, meaning there 
		# are fewer intervals than there were originally. This loop will crash since it's
		# based on the number of original intervals there were. Essentially, just make 
		# sure we don't try to access interval 1000 if there are only 900 intervals left.
		numberOfCurrentIntervals = Get number of intervals: thisTier

		if thisInterval < numberOfCurrentIntervals 
	
			# Keep looping until the conditions have been met (=Perl redo function)
			successful = 0
			while not successful

				thisText$ = Get label of interval: thisTier, thisInterval 
		
				# If we're dealing with a blank interval
				if thisText$ = ""
	
					nextText$ = Get label of interval: thisTier, thisInterval + 1
		
					# If the next interval is blank, remove this interval's right boundary
					if nextText$ = ""
						Remove right boundary... thisTier thisInterval 
					
					# Otherwise, we're done and we don't need to loop again.
					else
						successful = 1	
					endif
					
					# For files where there are multiple blank segments at the end
					numberOfCurrentIntervals = Get number of intervals: thisTier
					if thisInterval >= numberOfCurrentIntervals 
						successful = 1	
					endif

				# If the interval has text in it, we're good. Move on.
				else	
					successful = 1		
				endif 
			
			# Go again until the next looks good.
			endwhile
		
		# If not, we're at the end.
		endif
		
	# Move on to the next interval
	endfor

# Move on to the next tier
endfor

appendInfoLine: ""
appendInfoLine: "Whoo-hoo! It didn't crash!"
