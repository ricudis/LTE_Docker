#!/bin/bash
while true ; do
        if echo "" | nc -w 1 $LTE_MYSQL_IP 3306 ; then
                break
        fi
        echo "Waiting for MySQL..."
        sleep 1
done
