#!/bin/bash

#function to cast to Main Room
maincast () {
 recordmydesktop sc.ogv --on-the-fly-encoding --overwrite &
 castnow sc.ogv --address 192.168.1.5 --tomp4
}

#function to cast to Bedroom
bedroomcast () {
 recordmydesktop sc.ogv --overwrite --on-the-fly-encoding &
 castnow sc.ogv --address 192.168.1.10 --tomp4
}

#function to input custom IP address
#broken af
#customaddr () {
# recordmydesktop sc.ogv --overwrite --on-the-fly-encoding &
# castnow sc.ogv --address "$REPLY"
#}
	
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
   #how tf does read work
   #-r detects raw input and ignores special characters(?)
   #this is really b0rk
   read -r
   recordmydesktop sc.ogv --overwrite --on-the-fly-encoding &
   castnow sc.ogv --address $REPLY --tomp4
   break
  ;;
 esac
done