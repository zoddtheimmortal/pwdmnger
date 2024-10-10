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
    read -sp "Enter encryption key: " encryption_key
    echo

    if ! existing_content=$(openssl enc -d -$ENC_MODE -in $PASSWORD_FILE -k "$encryption_key" 2>/dev/null); then
        echo "Incorrect encryption key, try again"
        return 1
    fi

    new_content="$existing_content"'\n'"$1"

    echo "$new_content" | openssl enc -$ENC_MODE -out $PASSWORD_FILE -k "$encryption_key" 2>/dev/null
}

search_query(){
    read_encrypted_file | grep -i "$1" | awk -F, '{print "Username: " $2 "\nPassword: " $3}'
}