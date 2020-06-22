#!/bin/bash
service mysql stop
mkdir /nonexistent
LTE_MYSQL_CONFIG=${LTE_BASE_DIR}/config/mysql/mysqld.cnf
${LTE_BASE_DIR}/scripts/common/subst.sh ${LTE_MYSQL_CONFIG}.in /etc/mysql/mysql.conf.d/mysqld.cnf
echo "nameserver $LTE_DNS_IP" > /etc/resolv.conf
service mysql start
sh /opt/LTE/scripts/common/waitfor_mysql.sh

echo Creating db user...
mysql < ${LTE_BASE_DIR}/config/mysql/databases//adminuser.sql

mysqladmin drop -f hss_db
mysqladmin drop -f pcscf
mysqladmin drop -f icscf
mysqladmin drop -f scscf

echo Creating IMS HSS database
mysqladmin create hss_db && (
	mysql hss_db < ${LTE_BASE_DIR}/config/mysql/databases//hss_db.sql
	mysql hss_db < ${LTE_BASE_DIR}/config/mysql/databases//userdata.sql
)
	
echo Creating P-CSCF database
mysqladmin create pcscf && (
	mysql pcscf < ${LTE_BASE_DIR}/config/mysql/databases//standard-create.sql
	mysql pcscf < ${LTE_BASE_DIR}/config/mysql/databases//presence-create.sql
	mysql pcscf < ${LTE_BASE_DIR}/config/mysql/databases//ims_usrloc_pcscf-create.sql
	mysql pcscf < ${LTE_BASE_DIR}/config/mysql/databases//ims_dialog-create.sql
)

echo Creating I-CSCF database
mysqladmin create icscf && (
	mysql icscf < ${LTE_BASE_DIR}/config/mysql/databases//icscf.sql
)

echo Creating S-CSCF database
mysqladmin create scscf && ( 
	mysql scscf < ${LTE_BASE_DIR}/config/mysql/databases//standard-create.sql
	mysql scscf < ${LTE_BASE_DIR}/config/mysql/databases//presence-create.sql
	mysql scscf < ${LTE_BASE_DIR}/config/mysql/databases//ims_usrloc_scscf-create.sql
	mysql scscf < ${LTE_BASE_DIR}/config/mysql/databases//ims_dialog-create.sql
	mysql scscf < ${LTE_BASE_DIR}/config/mysql/databases//ims_charging-create.sql
)

echo Adjusting permissions...

mysql < ${LTE_BASE_DIR}/config/mysql/databases//permissions.sql

sh /opt/LTE/scripts/common/waitfor_ever.sh