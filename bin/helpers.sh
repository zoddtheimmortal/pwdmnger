#!/bin/bash

source "$(dirname "$0")/bin/config.sh"

init_file(){
    touch $PASSWORD_FILE
    openssl enc -$ENC_MODE -in $PASSWORD_FILE -out $PASSWORD_FILE 2>/dev/null
}

read_encrypted_file(){
    openssl enc -d -$ENC_MODE -in $PASSWORD_FILE 2>/dev/null
}

write_encrypted_file(){
    # wut do here
}

search_query(){
    read_encrypted_file | grep -i "$1" | awk -F, '{print "Username: " $2 "\nPassword: " $3}'
}