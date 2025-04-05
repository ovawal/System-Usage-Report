#!/bin/bash

# Script to check system information 

# Valdate sudo 

sudo -v 
if [[ $? -ne 0 ]]; then
	echo "Password error"
	exit 1
fi

# Log in variables

FAILED_LOGGINS=$(sudo lastb -n 5)
FAILED_LOGGINS_STATUS=$?

# Disk space variables

SPACE=$(df -h / | awk 'NR==2 {print $2}')
SPACE_STATUS=$?

USED_SPACE=$(df -h / | awk 'NR==2 {print $3}')

FREE_SPACE=$(df -h / | awk 'NR==2 {print $4}')

# Uptime variables

UPTIME=$(uptime -p 2> /dev/null | awk '{print $2, $3, $4, $5}')
UPTIME_STATUS=$?

# Check logged in users

USERS=$(users | sort -u | wc -l) 
USERS_STATUS=$?

# Introduction

echo -e "\n#################\n"
echo "Hostname: $(hostname -s)"
echo "OS: $(uname -o)"
echo "IP Address: $(ip -br addr show | awk 'NR==2 {print $3}')"

# Check system uptime

echo -e  "\n#################\n"
if [[ $UPTIME_STATUS -eq 0 ]]; then
	echo "Uptime: $UPTIME"
else
	echo "Error checking uptime"
	exit 1
fi


# Check root size

echo -e "\n#################\n"
if [[ $SPACE_STATUS -eq 0 ]]; then
	echo "Root size: $SPACE"
	echo -e "Used root space: $USED_SPACE \nFree root space: $FREE_SPACE"
else
	echo "Error checking size"
	exit 1
fi


# Check failed login attempts

echo -e "\n#################\n"
if [[ $FAILED_LOGGINS_STATUS -eq 0 ]]; then
	echo -e "Recent failed logging \n $FAILED_LOGGINS"
	else
		echo "Error checking failed login"
		exit 1
fi


# Check number of logged in users

echo -e "\n#################\n"
if [[ $USERS_STATUS -eq 0 ]]; then
	echo "$USERS logged in user(s)"
else
	echo "Error checking users"
	exit 1
fi


exit

