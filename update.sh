#!/bin/bash
while getopts c:d:f: option
do
case "${option}"
in
c) CONFIG=${OPTARG};;
d) DIR=${OPTARG};;
f) CFG=$CFG;;
esac
done

ONEC="/opt/1C/v8.3/x86_64/1cv8"

DATE=$(date +"%d-%b-%Y")
echo config = $CONFIG
echo date = $DATE
echo dir = $DIR
echo format = $FORMAT
echo 1c = $ONEC

echo -n stopping Apache...
systemctl stop apach23231
echo ok!

echo -n making backup...
sleep 3
#tar -zcf "/mnt/backup/1cv8-$DATE.tgz" -C /opt/1C_bases/ Bases
echo ok!

for i in $DIR/*; do
  echo -n "updating base $i..."
  $ONEC DESIGNER /F $i /UpdateCFg $CONFIG /UpdateDBCfg
  $ONEC ENTERPRISE /F $i
  sleep 30
  echo ok!
done
