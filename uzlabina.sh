#!/bin/bash
#Uzlabina Login
OKFORMAT="[\e[32mOK\e[0m   ]"
WARNINGFORMAT="[\e[38;5;196mWARNING\e[0m]"
ERRORFORMAT="[\e[33mERROR\e[0m]"
INFOFORMAT="[\e[38;5;44mINFO\e[0m ]"

if [[ $1 != "" ]]
then
	if [[ $2 != "" ]]
	then
		username=$1
		password=$2
	fi
else
	username=217
	password=217
	printf "No credentials specified, using defaults.\nUsage (optional): \e[38;5;44muzlabina.sh (username) (password) [timeout, default 10s]\e[0m\n"
fi

if [[ $3 != "" ]]
then
	timeout=$3
else
	timeout=10
fi

status=$(curl -X POST -F username=$username -F password=$password https://wifi.uzlabina.cz --silent --connect-timeout $timeout)

if nmcli | grep "spse.uzlabina.cz" > /dev/null
then
	if 
		curl https://wifi.uzlabina.cz/ --silent > /dev/null
	then
		if echo $status | grep "Neplatné jméno nebo heslo" > /dev/null
			then
				printf "$ERRORFORMAT Invalid username/password\n"
			elif echo $status | grep "IP adresa je již povolena" > /dev/null
				then
					printf "$OKFORMAT You were already logged in\n"
			else
				printf "$OKFORMAT \e[32mYou were successfully logged in\e[0m\n"
			fi
	else
		printf "$ERRORFORMAT Úžlabina login is not available\nPlease try again later\n"
	fi
else
	if nmcli | grep "uzlabina" > /dev/null
	then
		printf "$WARNINGFORMAT \e[31mYou are not connected to a legitimate Úžlabina network!\nBe careful, your data may be compromised\e[0m\n"
	else
		printf "$ERRORFORMAT You are not connected to the Úžlabina WiFi network.\n"
	fi
fi

#printf "$status\n"
#printf "USER:$username\nPASS:$password\n"