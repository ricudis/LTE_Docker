#!/bin/bash
cp $1 $2
for VAR in `printenv | grep ^LTE_ | cut -f1 -d=` ; do
	VAL=${!VAR}
	sed -i "s|${VAR}|${VAL}|g" $2
done