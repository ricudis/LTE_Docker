#!/bin/bash
cd ${LTE_BASE_DIR}/open5gs/webui
export DB_URI="mongodb://${LTE_MONGO_IP}/open5gs"
sed -i "s|server.listen(3000, err|server.listen(3000, \'0.0.0.0\', err|g" server/index.js
grep server.listen server/index.js
sh /opt/LTE/scripts/common/waitfor_mongo.sh
npm run dev

