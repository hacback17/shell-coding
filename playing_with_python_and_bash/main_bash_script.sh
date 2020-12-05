#!/usr/bin/bash

# Method 1
# Aim: Capture the result of Python code in this bash script itself for, maybe, further processing.

# This allows you to run the python script and save the output to file named "output_file" and then cat out the file to display the output. This way you can capture the output of Python result.

#$(python3 my_simple_pyscript.py --x=$1 --y=$2 2>&1> return_file)
#cat return_file


# Method 2
# Aim: Capture the result of Python code in this bash script itself for, maybe, further processing.

VAR=$(python3 my_simple_pyscript.py --x=$1 --y=$2 2>&1)
echo "Output:" $VAR 
