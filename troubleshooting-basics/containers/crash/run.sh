#!/bin/sh

crash () {
    >&2 echo "LOG_ECHO environment variable is unset"
    exit -1
}

while :
do
    sleep $[( $RANDOM % 10 ) + 1]
    [[ -z "${LOG_ECHO}" ]] && crash || echo ${LOG_ECHO}
done