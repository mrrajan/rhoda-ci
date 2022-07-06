#!/usr/bin/env bash
set -eux
#---------------------- functions ----------------------#
argument_parser(){
    # To handle arguments
    echo "--------- Parsing Arguments ----------"
    INPUTS=$@
    OPTIONS="c:d:"
    while getopts $OPTIONS opt; do
        case "$opt" in
            c)  #Configuration file for Report portal uploader
                echo "config"
                CONFIG=$OPTARG
                ;;
            d)  #Result Directory containing Results and Attachments
                echo "payload"
                PAYLOAD_DIR=${PWD}/"$OPTARG"
                ;;
        esac
    done
}

setup_venv() {
    # To install Report portal uploader on Virtual Environment
    echo "--------- Setting up RP uploader ----------"
    check_install=$(./venv/bin/pip list | grep rp-preproc | wc -c)
    if [[ $check_install -le 0 ]]; then
        ./venv/bin/pip install git+https://gitlab.cee.redhat.com/ccit/reportportal/rp_preproc.git#master
    fi
}

argument_parser "$@"
setup_venv
./venv/bin/rp_preproc -c "${CONFIG}" -d "${PAYLOAD_DIR}"

echo "------------- END ${0}"
