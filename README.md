# PhotoRoboto
Thermal printing photo bot
Based on an [Instant Camera project by Adafruit](https://learn.adafruit.com/instant-camera-using-raspberry-pi-and-thermal-printer?view=all). It has been modified for an Epson receipt printer for faster prints with auto-cutting.

Works with [epsonsimplecups drivers](https://github.com/Olernov/epsonsimplecups) up to Rasberry Pi OS Bullseye. If you get build issues, try editing epsonsimplecups/src/rastertoepsonsimple.c and removing "inline" from line 185.
