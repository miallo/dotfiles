#!/bin/sh -e

# Take a screenshot
import -silent -window root ~/.screen_locked.png

# Pixellate it 10x
convert ~/.screen_locked.png -blur 0x5 -brightness-contrast -5x-30 -gravity Center -pointsize 50 -font DejaVu-Sans -fill yellow -draw 'text 0,0 "Dieser PC wird gerade benutzt!"' ~/.screen_locked.png
#convert ~/.screen_locked.png -blur 0x5 -contrast-stretch 0.55 -gravity Center -pointsize 50 -fill yellow -draw 'text 0,0 "Dieser PC wird gerade benutzt!"' ~/.screen_locked.png

# Lock screen displaying this image.
i3lock -i ~/.screen_locked.png

# Turn the screen off after a delay.
for i in $(seq 1 20)
do
    #echo $i
	sleep 1
	pgrep i3lock > /dev/null || exit 0
done
pgrep i3lock > /dev/null && xset dpms force off
