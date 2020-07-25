#!/bin/sh
#
#        File: retrieve_jquery_files.sh
#     Created: 07/25/2020
#     Updated: 07/25/2020
#  Programmer: Cuates
#  Updated By: Cuates
#     Purpose: Retrieve jQuery and jQuery-UI files from Google APIs website
#

# Initialize date
DATE=$(date +"%d-%m-%Y %H:%M:%S")

# Initialize array of possible jquery and jqueryui
jqueryarr=("1.7" "2.1.1" "3.1.1" "3.4.1")
jqueryuiarr=("1.11.2" "1.12.1")

# Loop through array
for i in ${jqueryarr[@]}
do
  # jquery status
  jqueryStatus=$(curl -s --head https://ajax.googleapis.com/ajax/libs/jquery/$i/jquery.min.js | head -n 1 | grep "200 OK")

  # Check if value is empty
  if [ -z "$jqueryStatus" ]; then
    # Write to log file
    echo "["$DATE"] File does not exist for jquery-"$i".min.js" >> /var/www/html/Doc_Directory/retrieve_jquery_log.txt
  else
    # Else pull file from web
    curl -o /var/www/html/Temp_Directory/jquery-$i.min.js https://ajax.googleapis.com/ajax/libs/jquery/$i/jquery.min.js > /dev/null

    # Write to log file
    echo "["$DATE"] File jquery-"$i".min.js retrieved." >> /var/www/html/Doc_Directory/retrieve_jquery_log.txt
  fi
done

# Loop through array
for j in ${jqueryuiarr[@]}
do
  # jquery ui status
  jqueryuiStatus=$(curl -s --head https://ajax.googleapis.com/ajax/libs/jqueryui/$j/jquery-ui.min.js | head -n 1 | grep "200 OK")

  # Check if value is empty
  if [ -z "$jqueryuiStatus" ]; then
    # Write to log file
    echo "["$DATE"] File does not exist for jquery-ui-"$j".min.js" >> /var/www/html/Doc_Directory/retrieve_jquery_log.txt
  else
    # Else pull file from web
    curl -o /var/www/html/Temp_Directory/jquery-ui-$j.min.js https://ajax.googleapis.com/ajax/libs/jqueryui/$j/jquery-ui.min.js > /dev/null

    # Write to log file
    echo "["$DATE"] File jquery-ui-"$j".min.js retrieved." >> /var/www/html/Doc_Directory/retrieve_jquery_log.txt
  fi
done