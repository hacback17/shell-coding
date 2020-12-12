#!/usr/bin/python3

"""
++++++++
Name: Bablu Kumar
Twitter: @hacback17
++++++++

++++++++
This script automates the process of connecting to the gcloud instance.
Using this script, you won't have to try over and over again to see if your server is up and running.
This script is especially useful when there is heavy usuage in a certain zone, for example Mumbai (aisa-south1-a,-b,-c)
++++++++
"""
import subprocess

while True:
    print("Trying to spin up the instance...")
    p1 = subprocess.run(["gcloud compute instances start ubuntu-2"], shell=True, capture_output=True, text=True)
    if (p1.returncode == 0):
        if(p1.returncode == 0):
            print("Instance launched")
            break
