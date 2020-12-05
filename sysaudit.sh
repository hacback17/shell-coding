#!/usr/bin/bash

clear
echo "Loading info."
sleep 1
clear
echo "Loading info.."
sleep 1
clear
echo "Loading info..."
clear

echo "###Auditing Hardware###"

# System Info
echo "OS: "$(cat /etc/os-release | egrep '^NAME=' | cut -d '"' -f 2) $(cat /etc/os-release | egrep '^VERSION=' | cut -d '"' -f 2)
echo "Kernel Version: "$(uname -a | cut -d " " -f 3)

# CPU Info
echo "CPU Cores:" $(grep -c ^processor /proc/cpuinfo)
echo "CPU Clock Speed:" $(lscpu | grep MHz | cut -d ":" -f 2 | xargs)" MHz"
echo "CPU Architecture:" $(lscpu | grep Architecture | cut -d ":" -f 2 | xargs)

# RAM Info
echo "Total RAM:" $(free -mh | grep Mem | awk -F " " '{ print $2 }'), "Used RAM:" $(free -mh | grep Mem | awk -F " " '{ print $3 }'), "Free RAM:" $(free -mh | grep Mem | awk -F " " '{ print $4 }')


# Network Bandwidth Info
pkgs='iftop'

check=$(rpm -q pkgs &>/dev/null && echo "Installed" || echo "Not Installed")
if [[ check == "Not Installed" ]]
then
	echo "This package isn't installed. Please wait a few seconds..."
	sudo yum -y install $pkgs
#else
	#echo "The package is already installed!"
fi

total_network_bandwidth=$(sudo iftop -t -s 1 -n -N 2>/dev/null | awk '/send and receive/ {print $8}')

echo "Network bandwidth": $total_network_bandwidth

#echo $(sudo iftop -t -s 1 -n -N 2>/dev/null | awk '/send and receive/ {gsub(/[^0-9]?b$/,"",$8) ; print $8}')

echo "Allowed Ports: " $(firewall-cmd --list-services)


