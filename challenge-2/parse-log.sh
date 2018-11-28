#!/bin/bash
awk {{'print $1'}} access.log | uniq > uniq_ip.txt
#removing empty line from uniq_ip file
sed -i '/^$/d' uniq_ip.txt
while read ip_address
do
        GET_Count=0
        POST_Count=0
        GET_Count=`grep GET access.log | grep $ip_address | wc -l`
        POST_Count=`grep POST access.log | grep $ip_address | wc -l`
        echo "$GET_Count $ip_address GET"
        echo "$POST_Count $ip_address POST"
done < uniq_ip.txt