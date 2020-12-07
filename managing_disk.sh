#!/usr/bin/bash

: '
We provide call center automation as one of our products. Essentially it processes user"s audio and return a correct audio response. For managing all these audios that are generated in the due process we use NFS. With the call volumes we have, it essential that disk space of NFS should be managed properly.

Write a bash script to clean out all the audios in /home/ubuntu/audios/ folder that are older than 48hrs. Also generate a log file with the name deleted-files-<date>-<month>-<year>.log which should contain:

    name of audio file
    time of creation of audio file (ISO Format)
    time of deletion of audio file (ISO Format)

For example: A sample log file deleted-files-12-02-2020.log will contain:

audio_0010023.wav 10-02-2020T08:37:16+05:30 12-02-2020T10:18:40+05:30
audio_0010024.wav 10-02-2020T08:38:16+05:30 12-02-2020T10:18:42+05:30
audio_0010025.wav 10-02-2020T08:38:50+05:30 12-02-2020T10:18:45+05:30
'

if [ "$EUID" -ne 0 ]
	then echo "Please run as root"
	exit
	else

	clear
	echo "Loading info."
	sleep 1
	clear
	echo "Loading info.."
	sleep 1
	clear
	echo "Loading info..."
	clear

	echo -e "\e[1;42m Managing Disk Space... \e[0m"

	output_path=`pwd` # current working directory
	fpath='/home/osboxes/audios/' # the directory where audios are stored
	cd $fpath
	echo `pwd`
	find $fpath -type f -mtime +2 -exec ls -l {} \; > output          					# output the file older than 48hrs
	cat output | awk -F " " '{print $9}' | awk -F "/" '{ print $NF }' > output_name 	#Print the file name
	find $fpath -type f -mtime +2 -exec date -r {} --iso-8601=seconds \; > output_file_creation_iso_time

	cat output_name
	cat output_file_creation_iso_time

	paste output_name output_file_creation_iso_time | while read output_name output_file_creation_iso_time; do
		echo "$output_name $output_file_creation_iso_time $(date --iso-8601=seconds)" >> $output_path/deleted-files-$(date +%m-%d-%Y).log
	done

	find $fpath -type f -mtime +2 -delete # delete the files
fi

# find /path/to -type f -mtime +5 -exec rm {} \;
# find . -type f -mtime +2 | xargs rm
# find . -type f -mtime +2 -print | awk -F '/' '{ print $2 }' > output
# find / -type f -mtime +2 -print0 2>/dev/null | tail --zero-terminated -n 15 | xargs --null cp -p -t $fpath               # generate some file

# https://stackoverflow.com/a/17880721

# https://dev.to/allericksha/script-to-clean-out-files-in-dir-and-have-a-note-of-deleted-files-in-deletedfiles-log-2741

# Assuming: I am working with the modified time rather than the creation time as I couldn't find a method to do so in a normal filesystem

#https://www.2daygeek.com/bash-script-to-delete-files-folders-older-than-x-days-in-linux/

# https://unix.stackexchange.com/questions/340010/how-do-i-create-sequentially-numbered-file-names-in-bash
