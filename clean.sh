#!/bin/bash

echo "Going to watch $source for $look_for and move them to $destination"

# -m, --monitor which directory?
# -e, --event which action to watch for?
inotifywait \
		--monitor "$source" \
		--event create \
		--event moved_to |
		#This is ideal but only works with inotifywait 3.20.1+
		#Unfortunaetly not included with Pop!_OS 20.04 LTS
		#CAREFUL! Regex not tested
		#--include "*.png" \
		#--include "*.jpeg" \
		#--include "*.jpg" \
		#--include "*.gif" \
		#--include "*.webp" |
		while read dir action file; do
				#Does the file end the extension we want?
                #This is not exactly performant, you could use --exclude on inotifywait, but that looks a bit more complex to me right now.
				if [[ "$file" =~ ${look_for} ]]; then
						echo "The file '$file' appeared in directory '$dir' via '$action'"
						#do something with the file
						#we move it to the Pictures directory and remove from Downloads
						rsync -avP --remove-source-files \
							"$dir/$file" \
							"$destination"
				fi
		done

