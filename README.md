Tiny script(for linux) that helps with update of your db`s

# FIRST OF ALL:
THIS IS PRE VIEW AND OPTION DRY RUN IS NOTREADY YET TO ACTUALY RUN THIS SCRIPT DELETE ON TAR #
# USAGE:
1) First of all make this script executable, here you go
`chmod +x update.sh`
2) Specify path of dir where your bases stored with -d flag
3) Specify path of .cfg file with -c flag
4) (optional) Specify backup dir with -b flag, if argument was not specified defaul var(/tmp/1c_backup.tgz) uses instead
5) (optional) You can skip backup procedure if --no-backup flag was passed (not recommended)

# TO DO:
1) researching xdotool, MORE AUTOMATION
2) add a --no-backup flag to skip backup procedure
3) bug fixies, currently loop "for" crashes at the end and not restarting apache
4) Removing toxic comments(lol) general clean up of script
