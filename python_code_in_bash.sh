#!/usr/bin/bash

total_network_bandwidth=$(sudo iftop -t -s 1 -n -N 2>/dev/null | awk '/send and receive/ {print $8}')
echo $total_network_bandwidth > reports.txt

python3 - << EOF

file = open('reports.txt')
print(file.readline())

EOF
