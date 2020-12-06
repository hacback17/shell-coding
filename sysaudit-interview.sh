#!/usr/bin/bash

: '

Auditing Hardware

We work with companies that require our solution to be deployed on premise. For that we receive hardware, and auditing that hardware becomes important part of our deployment process.

Write a bash script to audit the following hardware spec in RHEL. The script should print out following specifications:

    OS version
    Kernel version
    CPU - Virtual cores (ratio to physical cores if possible)
    CPU - Clock speed
    CPU - Architecture
    RAM
    Networking - Bandwidth
    Networking - OS Firewall (Allowed Ports & Protocols)
    Networking - Network Firewall (Allowed Ports & Protocols)
    Disk - Mounted/Unmounted volumes, type, storage

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

	echo -e "\e[1;42m Downloading Required Packages. Please wait... \e[0m"
	sudo yum install --enablerepo="epel" ufw -y  # install ufw
	echo "y" | sudo ufw enable 		     # enable ufw
	sudo yum -y install iftop  		     # iftop
	clear

	#echo "###Auditing Hardware###"
	echo -e "\e[1;42m Auditing Hardware \e[0m"

	# System Info
	echo -e "\e[1;31m###System Info### \e[0m"
	echo "OS: "$(cat /etc/os-release | egrep '^NAME=' | cut -d '"' -f 2) $(cat /etc/os-release | egrep '^VERSION=' | cut -d '"' -f 2)
	echo "Kernel Version: "$(uname -a | cut -d " " -f 3)
	echo

	# CPU Info
	echo -e "\e[1;31m###CPU Info### \e[0m"
	echo "CPU Cores:" $(grep -c ^processor /proc/cpuinfo)
	echo "CPU Clock Speed:" $(lscpu | grep MHz | cut -d ":" -f 2 | xargs)" MHz"
	echo "CPU Architecture:" $(lscpu | grep Architecture | cut -d ":" -f 2 | xargs)
	echo

	# RAM Info
	echo -e "\e[1;31m###RAM Info### \e[0m" 
	echo "Total RAM:" $(free -mh | grep Mem | awk -F " " '{ print $2 }'), "Used RAM:" $(free -mh | grep Mem | awk -F " " '{ print $3 }'), "Free RAM:" $(free -mh | grep Mem | awk -F " " '{ print $4 }')
	echo

	# Network Bandwidth Info
	echo -e "\e[1;31m###Network Bandwidth Info### \e[0m" 
	nohup ping google.com -c 4 2>1& 

	total_network_bandwidth=$(sudo iftop -t -s 1 -n -N 2>/dev/null | awk '/send and receive/ {print $8}')

	echo "Network bandwidth": $total_network_bandwidth

	# Ports info using IFTOP
	#echo $(sudo iftop -t -s 1 -n -N 2>/dev/null | awk '/send and receive/ {gsub(/[^0-9]?b$/,"",$8) ; print $8}')

	# Ports using UFW
	printf "\nAllowed Ports:\n"

	sudo ufw status verbose | sed '1,7d'

	#echo $(sudo ufw status verbose | sed '1,7d' | awk -F / '{ print $1 }' | awk -F " " '{ print $NF }')

	echo "Allowed Protocols: " $(firewall-cmd --list-services)
	echo

	echo -e "\e[1;31m###Disk Info### \e[0m" 

	lsblk -o NAME,FSTYPE,SIZE,MOUNTPOINT
	echo -e "\e[1;42m System audit successfully completed. \e[0m"
fi

