#!/bin/bash

source "$(dirname "$0")/bin/config.sh"

usage(){
    echo "Usage: $0 [-v] [-s query] [-a name uname password] [-h]"
    echo "  -v: view all passwords"
    echo "  -s: search passwords"
    echo "  -a: append a new password"
    echo "  -h: help"
}

while getopts ":vs:a:h" opt; do
    case $opt in
        v)
            cat $PASSWORD_FILE
            ;;
        s)
            if grep -iq "$OPTARG" "$PASSWORD_FILE"; then
                grep -i "$OPTARG" "$PASSWORD_FILE" | awk -F, '{print "Username: " $2 "\nPassword: " $3}'
            else
                echo "No match found"
            fi
            ;;
        a)
            echo "$OPTARG" >> $PASSWORD_FILE
            ;;
        h)
            usage
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            usage
            ;;
    esac
done

main(){
    if [ $# -eq 0 ]; then
        usage
    fi
}

main "$@"