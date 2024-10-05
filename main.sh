#!/bin/bash

source "$(dirname "$0")/bin/config.sh"
source "$(dirname "$0")/bin/helpers.sh"

usage(){
    echo "Usage: $0 [-v] [-s query] [-a name uname password] [-u old_pass new_pass] [-h]"
    echo "  -v: view all passwords"
    echo "  -s: search passwords"
    echo "  -u: update master password"
    echo "  -a: append a new password"
    echo "  -h: help"
}

while getopts ":vs:a:h" opt; do
    case $opt in
        v)
            read_encrypted_file
            ;;
        s)
            search_query "$OPTARG"
            ;;
        a)
            write_encrypted_file "$OPTARG"
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
    if ! ls -a "$PASSWORD_FILE" >/dev/null 2>&1; then
        init_file
    fi

    if [ $# -eq 0 ]; then
        usage
    fi
}

main "$@"