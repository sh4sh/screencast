#!/bin/bash

maincast () {
 recordmydesktop --overwrite --on-the-fly-encoding sc.ogv &
 castnow --address 192.168.1.5 --tomp4 sc.ogv
}

bedroomcast () {
 recordmydesktop --overwrite --on-the-fly-encoding sc.ogv &
 castnow --address 192.168.1.10 --tomp4 sc.ogv
}

customaddr () {
 recordmydesktop --overwrite --on-the-fly-encoding sc.ogv & castnow sc.ogv --address $REPLY
}
	
echo "Which device should I connect to?"
echo "View Favourites, or enter a custom IP address for your device?"
select choice in "Favourites" "Custom" ; do
 case $CHOICE in
  "Favourites")
    select device in "Main" "Bedroom" ; do
     case $DEV in
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
  "Custom")
   echo "What is the IP address of the device I should connect to?"
   read -r
   customaddr $REPLY
   break
  ;;
 esac
done
