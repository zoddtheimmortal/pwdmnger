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
    echo "$1" | openssl enc -$ENC_MODE -out $PASSWORD_FILE 2>/dev/null
}