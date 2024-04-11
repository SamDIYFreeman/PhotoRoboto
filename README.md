# PhotoRoboto
Thermal printing photo bot
Based on an [Instant Camera project by Adafruit](https://learn.adafruit.com/instant-camera-using-raspberry-pi-and-thermal-printer?view=all). It has been modified for an Epson receipt printer for faster prints with auto-cutting.

To initilize the GPIO inputs, add "gpio=20,21=pu" to the end of config.txt

To make it executable, navigate to the containing folder in terminal and type "chmod +x camera.sh"

To make it automatically run on boot, edit the rc.local file. Above the “exit 0” line, add "sh [filepath][filename]", eg. "sh /home/pi/Documents/camera.sh"

Works with [epsonsimplecups drivers](https://github.com/Olernov/epsonsimplecups) up to Rasberry Pi OS Bullseye. If you get build issues, try editing epsonsimplecups/src/rastertoepsonsimple.c and removing "inline" from line 185.
