#!/bin/bash
#This script assumes that you runnig 1c in web server mode(apache2.4 to be exact) and 1c is installed in /opt/1C/v8.3/x86_64/1cv8
ONEC="/opt/1C/v8.3/x86_64/1cv8"
BACKUP_DEF="/tmp/1c_backup.tgz"
COUNT=1

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
  echo "backup obsolete path was not specified, staying on defaults!($BACKUP_DEF)"
  BACKUP=$BACKUP_DEF
fi

# Высвечиваем инфу шоб удобно было
echo config = $CFG
echo dir = $DIR
echo 1c = $ONEC
echo backup_name = $BACKUP

echo is this info correct?[y/n]
read all_set

if [ ! "$all_set" = "y" ]; then
  echo expected y, exiting
  exit
fi

echo -n stopping Apache... # останавливаем апач
systemctl stop apache2
echo ok!

echo -n making backup... # пилим бэкап
sleep 3
#tar -zcf $BACKUP -P $DIR
echo ok!

how_many=$(ls -l $DIR | grep -c ^d) #подсчет папок для УдОбСтВа трека

for i in $DIR/*; do
  if [ -d "$i" ]; then #глядим во все папки баз #delete '/'
    echo -n "updating base $i($COUNT/$how_many)..."
    ((COUNT++))
    if [ -e "$i/1Cv8.1CD" ]; then #паралельно убеждаемся, что перед нами 1с8 база
      echo -n found 1Cv8 file! Updating config!...
      $ONEC DESIGNER /F $i /UpdateCFg $CFG /UpdateDBCfg &> /dev/null # фигачим апдейт
      sleep 3
      echo ok!
      echo -n launching 1c!...
      $ONEC ENTERPRISE /F $i &> /dev/null #Запускаем шоб руками доделать то, что руками надо
      #xdotool search --name Бухгалтерия windowactivate
      #ВОТ ТУТ БЫ ЕЩЕ XDOTOOL ПРИЦЕПИТЬ А
    else
      echo 'can`t find 1Cv8 file, consider remove or fix that db!'
      sleep 2
    fi
  fi
done

echo -n Starting Apache...
systemctl start apache2
echo ok!

echo 1c was updated!
