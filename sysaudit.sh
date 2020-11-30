#!/usr/bin/bash

# System Info
echo "OS: "$(cat /etc/os-release | egrep '^NAME=' | cut -d '"' -f 2) $(cat /etc/os-release | egrep '^VERSION=' | cut -d '"' -f 2)
echo "Kernel Version: "$(uname -a | cut -d " " -f 3)

# CPU Info
echo "CPU Cores: "$(grep -c ^processor /proc/cpuinfo)
echo "CPU Clock Speed: "$(lscpu | grep MHz | cut -d ":" -f 2 | xargs)" MHz"
echo "CPU Architecture:" $(lscpu | grep Architecture | cut -d ":" -f 2 | xargs)

# RAM Info
echo "Total RAM:" $(free -mh | grep Mem | awk -F " " '{ print $2 }'), "Used RAM:" $(free -mh | grep Mem | awk -F " " '{ print $3 }'), "Free RAM:" $(free -mh | grep Mem | awk -F " " '{ print $4 }')


# Network Bandwidth Info
pkgs='nethogs'
if ! rpm -qa | grep $pkgs; 
then
	sudo yum -y install $pkgs
else
	"The package is already installed!"
fi





