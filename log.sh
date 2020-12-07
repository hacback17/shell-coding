#!/usr/bin/bash

TIMESTAMP=$(date +%F)

echo "Auto Generate Log files"
find /home/osboxes/audios/ -name 'netstat' -mmin +2 -exec bash -c ' echo "{} - " date -r {} rm -rf {} ' \; | xargs > deleted-files-$TIMESTAMP.log
echo "Log Generated Successfully"

