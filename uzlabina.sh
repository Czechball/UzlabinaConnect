#!/bin/bash
#Uzlabina Login
OKFORMAT="[\e[32mOK\e[0m   ]"
WARNINGFORMAT="[\e[38;5;196mWARNING\e[0m]"
ERRORFORMAT="[\e[33mERROR\e[0m]"

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

if nmcli | grep "spse.uzlabina.cz" > /dev/null
then
	if 
		curl https://wifi.uzlabina.cz/ --silent > /dev/null
	then
		status=$(curl -X POST -F username=$username -F password=$password https://wifi.uzlabina.cz --silent --connect-timeout $timeout)
		if echo "$status" | grep "Neplatné jméno nebo heslo" > /dev/null
			then
				echo -e "$ERRORFORMAT Invalid username/password"
			elif echo "$status" | grep "IP adresa je již povolena" > /dev/null
				then
					echo -e "$OKFORMAT You were already logged in"
			else
				echo -e "$OKFORMAT \e[32mYou were successfully logged in\e[0m"
			fi
	else
		echo -e "$ERRORFORMAT Úžlabina login is not available\nPlease try again later"
	fi
else
	if nmcli | grep "uzlabina" > /dev/null
	then
		echo -e "$WARNINGFORMAT \e[31mYou are not connected to a legitimate Úžlabina network!\nBe careful, your data may be compromised\e[0m"
	else
		echo -e "$ERRORFORMAT You are not connected to the Úžlabina WiFi network."
	fi
fi

#printf "$status\n"
#printf "USER:$username\nPASS:$password\n"