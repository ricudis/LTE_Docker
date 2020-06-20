#!/bin/bash
while true ; do
        if echo "" | nc -w 1 $LTE_MONGO_IP 27017 ; then
                break
        fi
        echo "Waiting for Mongo..."
        sleep 1
done

