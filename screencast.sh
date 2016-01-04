#!/bin/bash

#Hosted at http://github.com/sunshineplur/screencast
#screencast uses RecordMyDesktop and castnow to send a video
#and audio stream to any Chromecast device on your network.

#location of config file
RCFILE="$HOME/.screencast.rc"

#adds entry to config file
addaddr() {
 echo -e "$NAME = $ADDR$'\n'" >> "$RCFILE"
 echo "Device added to Favourites. View favourites in ~/.screencast.rc"
 echo "Do you want to cast to this device right now? Y/N"
 read -r CASTCHK
 if [ "${CASTCHK,,}" == "y*" ]; then
  customaddr "$ADDR"
 else
  echo "Okay, I won't cast now. Exiting."
  exit
 fi
} 

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

#function for favourite save menu
savefav () {
 echo -n "Name of device: "
 read -r NAME
 echo "Are you sure these values are correct? Y/N"
 read -r SAVECHK
 if [ "{$SAVECHK,,}" == "y*" ]; then
  addaddr "$NAME" "$ADDR"
 else
  echo "Values not written to ~/screencast.rc. Nothing learned."
  echo "Try again? Y/N"
  read -r TRYAGAIN
  if [ "${TRYAGAIN,,}" == "y*" ]; then
   savefav "$ADDR"
  else
   exit
  fi
 fi
}

#function for using custom IP addresses without saving
customaddr () {
 recordmydesktop --overwrite --on-the-fly-encoding &
 castnow out.ogv --tomp4 --address "$ADDR" &
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
    echo "What's the IP address of the device I should connect to?"
    read -r ADDR
    echo "Should I save this device to your Favourites? Y/N"
    read -r SAVEYN
    if [ "${SAVEYN,,}" == "y*" ]; then
     savefav "$ADDR"
    else
     echo "I won't save this device."
     customaddr "$ADDR"
    fi
    break
 ;;
 esac
done