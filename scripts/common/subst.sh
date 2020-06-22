#!/bin/bash
cp $1 $2
export LTE_MCC3=`echo ${LTE_MCC} | awk '{printf "%03u", $1}'`
export LTE_MNC3=`echo ${LTE_MNC} | awk '{printf "%03u", $1}'`

if [ "`arch`" = "aarch64" ] ; then 
	LTE_BUILD_ARCH=aarch64-linux-gnu
else
	LTE_BUILD_ARCH=x86_64-linux-gnu
fi

for VAR in `printenv | grep ^LTE_ | cut -f1 -d=` ; do
	VAL=${!VAR}
	sed -i "s|${VAR}|${VAL}|g" $2
done