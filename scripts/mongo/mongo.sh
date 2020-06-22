#!/bin/bash
/usr/bin/mongod --smallfiles --dbpath /var/lib/mongodb --bind_ip_all &
sh /opt/LTE/scripts/common/waitfor_mongo.sh
mongoimport --collection=subscribers --db=open5gs --drop --file /opt/LTE/config/mongo/subscribers.json
sh /opt/LTE/scripts/common/waitfor_ever.sh

