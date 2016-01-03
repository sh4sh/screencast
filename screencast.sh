#!/bin/bash

maincast () {
 recordmydesktop sc.ogv --on-the-fly-encoding --overwrite &
 castnow sc.ogv --address 192.168.1.5 --tomp4
}

bedroomcast () {
 recordmydesktop sc.ogv --overwrite --on-the-fly-encoding &
 castnow sc.ogv --address 192.168.1.10 --tomp4
}

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
   read -r
   recordmydesktop sc.ogv --overwrite --on-the-fly-encoding &
   castnow sc.ogv --address $REPLY --tomp4
   break
  ;;
 esac
done