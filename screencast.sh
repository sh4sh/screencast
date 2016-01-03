#!/bin/bash
#Hosted at http://github.com/sunshineplur/screencast
#screencast uses RecordMyDesktop and castnow to send a video
#and audio stream to any Chromecast device on your network.

#function to cast to Main Room
maincast () {
 recordmydesktop --on-the-fly-encoding --overwrite &
 castnow out.ogv --address 192.168.1.5 --tomp4 &
}

#function to cast to Bedroom
bedroomcast () {
 recordmydesktop --overwrite --on-the-fly-encoding &
 castnow out.ogv --address 192.168.1.10 --tomp4 &
}

#function to input custom IP address
#broken af
customaddr () {
 read -r REPLY
 recordmydesktop --overwrite --on-the-fly-encoding &
 castnow out.ogv --tomp4 --address $REPLY &
}
	
echo "Which device should I connect to?"
echo "View Favourites, or enter a custom IP address for your device?"
select CHOICE in "Favourites" "Custom" ; do
 case $CHOICE in
  "Favourites")
    select DEVICE in "Main" "Bedroom" ; do
     case $DEVICE in
      "Main")
       maincast
       break
      ;;
      "Bedroom")
       bedroomcast
       break
      ;;
     esac
    done
   ;;
  "Custom")
   echo "What is the IP address of the device I should connect to?"
#option -r detects raw input and ignores special characters(?)
   read -r REPLY
   recordmydesktop --overwrite --on-the-fly-encoding &
   castnow out.ogv --tomp4 --address $REPLY
   break
  ;;
 esac
done
