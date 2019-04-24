Tiny script(for linux) that helps with update of your db`s

# USAGE:
1) First of all make this script executable, here you go
`chmod +x update.sh`
2) Specify path of dir where your bases stored with -d flag
3) Specify path of .cfg file with -c flag
(optional) 4) specify backup dir with -b flag, if argument was not specified defaul var(/tmp/1c_backup.tgz) uses instead
(optional) You can skip backup procedure if --no-backup flag was passed (not recommended)

# TO DO:
1) researching xdotool, MORE AUTOMATION
2) add a --no-backup flag to skip backup procedure
3) bug fixies, currently loop "for" crashes at the end and not restarting apache
4) Removing toxic comments(lol) general clean up of script
