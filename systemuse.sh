#!/bin/bash

# Check system usage information

echo "Hello $(hostname -s)..."
sleep 1

echo "Your system has been up for $(uptime -p | awk '{print $2, $3, $4, $5}') "

if [ $? -ne 0 ]; then
	echo "Error checking uptime. "
	exit 1
fi
echo
echo "$(users | sort -u | wc -l) users are logged in."

if [ $? -ne 0 ]; then
	echo "Error checking users.."
	exit 1
fi
exit
