#!/bin/bash

SHUTTER=20
HALT=21
LED=16

# Initialize GPIO states
gpio -g mode  $SHUTTER up
gpio -g mode  $HALT    up
gpio -g mode  $LED     out

# Flash LED on startup to indicate ready state
for i in `seq 1 5`;
do
	gpio -g write $LED 0
	sleep 0.2
	gpio -g write $LED 1
	sleep 0.2
done   

while :
do
	# Check for shutter button
	if [ $(gpio -g read $SHUTTER) -eq 0 ]; then
		gpio -g write $LED 0
    # takes photo and sends to printer
		libcamera-still -o - | lp -d "EPSON_TM-T20II"
		sleep 1
		# Wait for user to release button before resuming
		while [ $(gpio -g read $SHUTTER) -eq 0 ]; do continue; done
		gpio -g write $LED 1
	fi

	# Check for halt button
	if [ $(gpio -g read $HALT) -eq 0 ]; then
		# Must be held for 2+ seconds before shutdown is run...
		starttime=$(date +%s)
		while [ $(gpio -g read $HALT) -eq 0 ]; do
			if [ $(($(date +%s)-starttime)) -ge 2 ]; then
				gpio -g write $LED 1
				shutdown -h now
			fi
		done
	fi
done
