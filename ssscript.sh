xscreensaver -d :0 & 
echo "Prozess gestartet mit ID: $!"
xscreensaver-command -lock 

#warten bis befehl ausgefuehrt
sleep 1
#schleife solange, bis screen unlocked
FRAGE=`xscreensaver-command -time | grep 'screen locked'`

while [ "$FRAGE" != "" ]
do
	sleep 1
	FRAGE=`xscreensaver-command -time | grep "screen locked"`
done

kill -kill $!

#sleep 1
BEENDET=`ps -e | grep 'xscreen'`

if [ "$BEENDET" != "" ] 
then
	echo "Prozess konnte nicht beendet werden und existiert noch!!!"
	echo -e $BEENDET
fi
