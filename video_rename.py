#!/usr/bin/python3

import os

os.chdir('/home/osboxes/Downloads/')

#print(os.getcwd())  # /home/osboxes/Downloads/
#print(os.listdir()) # List all the files in the directory

for f in os.listdir():
	#print(os.path.splitext(f))
	f_name, f_ext = os.path.splitext(f)

	f_title, f_num = f_name.split('-')
	f_title = f_title.strip()
	f_num = f_num.strip()[1:].zfill(2)
	
	new_name = '{}-{}{}'.format(f_num, f_title, f_ext)
	os.rename(f, new_name)
	
