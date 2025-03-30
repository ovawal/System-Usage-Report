#!/bin/bash

# Script to check system system information 

sudo -v 
if [ $? -ne 0 ]; then
	echo "Password error"
	exit 1
fi


FAILED_LOGGINS=$(sudo lastb -n 5)
FAILED_LOGGINS_STATUS=$?


SPACE=$(df -h / | awk 'NR==2 {print $2}')
SPACE_STATUS=$?

USED_SPACE=$(df -h / | awk 'NR==2 {print $3}')

FREE_SPACE=$(df -h / | awk 'NR==2 {print $4}')

UPTIME=$(uptime -p 2> /dev/null | awk '{print $2, $3, $4, $5}')
UPTIME_STATUS=$?

# Check logged in users

USERS=$(users | sort -u | wc -l) 
USERS_STATUS=$?

echo "Hello $(hostname -s)..."
sleep 1
echo

# Check system uptime

if [ $UPTIME_STATUS -eq 0 ]; then
	echo "Your system has been up for $UPTIME"
else
	echo "Error checking uptime"
	exit 1
fi

echo

# Check root size

if [ $SPACE_STATUS -eq 0 ]; then
	echo "System size is $SPACE"
	echo "Used root space is $USED_SPACE and free space is $FREE_SPACE"
else
	echo "Error checking size"
	exit 1
fi

echo

# Check failed login attempts

if [ $FAILED_LOGGINS_STATUS -eq 0 ]; then
	echo -e "Recent failed logging \n $FAILED_LOGGINS"
	else
		echo "Error checking failed login"
		exit 1
fi

echo

# Check number of logged in users

if [ $USERS_STATUS -eq 0 ]; then
	echo "$USERS logged in user(s)"
else
	echo "Error checking users"
	exit 1
fi


exit

