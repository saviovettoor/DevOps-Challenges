#!/bin/bash
NUMBER_OF_OCCURANCE=`grep -r  'HTTP/1.1" 401' /opt/host.access.log | wc -l`

if [ $NUMBER_OF_OCCURANCE > 10 ]; then
	echo "Exceed the limit..,For past 20 mintue you have entered wrong password morethan 10 time" | mail -s "You exceed the limit..!" carrer.savio@gmail.com
fi
mv /opt/host.access.log /opt/host.access_$(date +%d-%m-%Y).log

while true; do sleep 1200; done
