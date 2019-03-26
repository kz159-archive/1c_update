#!/bin/bash
while getopts b:d:c: option #ВОТ СЮДА ДОБАВИТЬ --no-backup
do
case "${option}"
in
b) BACKUP=${OPTARG};;
d) DIR=${OPTARG};;
c) CFG=${OPTARG};;
#--no-backup) BACKUP_FLAG=false;;# НЕОБХОДИМО ЗАМУТИТЬ ФЛАГ БЕЗ БЕКАПА ДЛЯ ОПУХШИХ
esac
done

if [ -z "$DIR" ] # Чекаем наличие папки
then
  echo "DIRECTORY WAS NOT SUPPLIED, EXITING!!"
  exit
fi

if [ -z "$CFG" ] # Чекаем наличие конфигурационного файла
then
  echo "CONFIGURATION FILE WAS NOT SUPPLIED, EXITING!!"
  exit
fi

if [ -z "$BACKUP" ] #чекаем место бэкапа
then
  echo "backup obsolete path was not specified, switching to /tmp!"
  BACKUP=/tmp/1c_backup.tgz
fi

ONEC="/opt/1C/v8.3/x86_64/1cv8"

# Высвечиваем инфу шоб удобно было
echo config = $CFG
echo dir = $DIR
echo 1c = $ONEC
echo backup_name = $BACKUP

echo -n stopping Apache... # останавливаем апач
systemctl stop apache232
echo ok!

echo -n making backup... # пилим бэкап
sleep 3
tar -zcf $BACKUP -P $DIR
echo ok!

for i in $DIR/*; do #глядим во все папки баз
  echo -n "updating base $i..."
  if [ -e "$i/1Cv8.1CD" ] #паралельно убеждаемся, что перед нами 1с8 база
  then
    echo -n found 1Cv8 file! Updating config!...
    #$ONEC DESIGNER /F $i /UpdateCFg $CFG /UpdateDBCfg # фигачим апдейт
    #$ONEC ENTERPRISE /F $i #Запускаем шоб руками доделать то, что руками надо
    #ВОТ ТУТ БЫ ЕЩЕ XDOTOOL ПРИЦЕПИТЬ А
    sleep 3
    echo ok!
  else
    echo 'can`t find 1Cv8 file =C Doing nothing'
    sleep 1
  fi
done

echo -n Starting Apache...
systemctl start apache2
echo ok!

echo 1c was updated!
