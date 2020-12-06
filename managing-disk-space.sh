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

	cd /home/osboxes/audios/
	echo `pwd`
	ls -la
fi

# find /path/to -type f -mtime +5 -exec rm {} \;
# sudo find / -type f -mtime 2 2>/dev/null -exec tail {} -n 10 \; -exec cp -p {} . \;
# find / -type f -mtime +2 -print0 2>/dev/null | tail --zero-terminated -n 15 | xargs --null cp -p -t .
