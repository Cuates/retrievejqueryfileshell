#!/bin/bash
#
#        File: retrieve_jquery_files.sh
#     Created: 07/25/2020
#     Updated: 03/27/2025
#  Programmer: Cuates
#  Updated By: AI Assistant
#     Purpose: Retrieve jQuery and jQuery-UI files from Google APIs website

# Enable strict mode for better error handling
set -o errexit  # Exit immediately if a command exits with a non-zero status
set -o nounset  # Treat unset variables as an error when substituting
set -o pipefail # Exit with a non-zero status if any command in a pipeline fails

# Create required directories if they don't exist
mkdir -p /var/www/html/{Temp_Directory,Doc_Directory}

# Define arrays of jQuery and jQuery UI versions to download
jqueryarr=("1.7" "2.1.1" "3.1.1" "3.4.1")
jqueryuiarr=("1.11.2" "1.12.1")

# Function to log messages with timestamp
log_message() {
    echo "[$(date +"%d-%m-%Y %H:%M:%S")] $1" >> /var/www/html/Doc_Directory/retrieve_jquery_log.txt
}

# Function to download and log jQuery/jQuery UI files
download_file() {
    local url="$1"
    local filename="$2"
    local http_code=$(curl -s -o /dev/null -w "%{http_code}" "$url")
    
    if [ "$http_code" -eq 200 ]; then
        curl -sSf -o "/var/www/html/Temp_Directory/$filename" "$url"
        log_message "Retrieved $filename"
    else
        log_message "Failed: $filename (HTTP $http_code)"
    fi
}

# Download jQuery files
for version in "${jqueryarr[@]}"; do
    url="https://ajax.googleapis.com/ajax/libs/jquery/$version/jquery.min.js"
    filename="jquery-$version.min.js"
    download_file "$url" "$filename"
done

# Download jQuery UI files
for version in "${jqueryuiarr[@]}"; do
    url="https://ajax.googleapis.com/ajax/libs/jqueryui/$version/jquery-ui.min.js"
    filename="jquery-ui-$version.min.js"
    download_file "$url" "$filename"
done

# Script execution completed
log_message "Script execution completed"
