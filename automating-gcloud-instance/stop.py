#!/usr/bin/python3

"""
Name: Bablu Kumar
Twitter: @hacback

This script stops the gcloud instance which is named as 'ubuntu-2' in aisa-south1-b region
"""

import subprocess

while True:

    print("Trying to stop the instance...")
    p1 = subprocess.run(["gcloud compute instances start ubuntu-2"], shell=True, capture_output=True, text=True)
    if (p1.returncode == 0):
        print("The instance has been stopped!")
        break
