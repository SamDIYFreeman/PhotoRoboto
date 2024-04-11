#!/bin/bash

# Flash LED on startup to indicate ready state
for i in `seq 1 5`;
do
	gpioset 0 16=0
	sleep 0.2
	gpioset 0 16=1
	sleep 0.2
done   

while :
do
	# Check for shutter button
	if [ $(gpioget -l 0 20) -eq 1 ]; then
		gpioset 0 16=0
		# takes photo and sends to printer
		libcamera-still --width 512 --height 384 -n -t 1 -o - | lp
		sleep 1
		# Wait for user to release button before resuming
		while [ $(gpioget -l 0 20) -eq 1 ]; do continue; done
		gpioset 0 16=1
	fi

	# Check for halt button
	if [ $(gpioget -l 0 21) -eq 1 ]; then
		# Must be held for 2+ seconds before shutdown is run...
		starttime=$(date +%s)
		while [ $(gpioget -l 0 21) -eq 1 ]; do
			if [ $(($(date +%s)-starttime)) -ge 2 ]; then
				gpioset 0 16=1
				shutdown -h now
			fi
		done
	fi
done
