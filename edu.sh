#!/bin/bash

#This script will use two files called result and debug
#if you have files with this name in the same directory as the scipt.
#they WILL be overwritten.

#Sometimes you get a "deauthenticated Reason: 7" and sometimes "deauthenticating Reason: 3"
#So i grep "deauth" to get all disconnects

#USAGE: connect to eduroam, start the script using "sudo ./edu.sh"


if [ $(whoami) != 'root' ]; then
	echo "Use \"sudo ./edu.sh\" to run the program"
	exit 1;
fi

OLD=`dmesg | grep capab=0x431 | tail -n1`
echo "Number of times Eduroam has disconnected us :"
NUM=0
while sleep 1; do


	NEW=`dmesg | grep capab=0x431 | tail -n1`
	
	if [ "$OLD" != "$NEW" ]
	then

 	((NUM++))
	echo $NUM
	OLD=$NEW
	#DO RESTART OF NEWWORK-MANAGER
	service network-manager restart
	sleep 15
	fi

done
	
 
