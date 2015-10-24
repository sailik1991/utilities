#!/bin/bash

# Get time for any command/script run multiple times 

verbose=false

usage() {
    echo "Usage: ./get_time.sh -c command -t(optional) times -v(for command output)"
    echo "===== Eg. ====="
    echo "./get_time.sh -c ls\ -lrt"
    echo "./get_time.sh -c ls -t 40"
    echo "===== Explanations ====="
    echo "First command runs 'ls -lrt' one time and reports the time taken to do so"
    echo "Second command runs ls 40 times and reports the time taken to do so"
    exit 1
}

while getopts "c:t:vh" o; do
    case "${o}" in
        c)
            cmd=${OPTARG}
            ;;
        t)
            count=${OPTARG}
            ;;
        v)
            verbose=true
            ;;
        h|*) usage
            ;;
    esac
done

if [ -z "$cmd" ]; then
    usage
fi

if [ -z $count ]; then
    echo "Number of times the command is run is one."
    count=1
fi

if ! [[ "$count" =~ ^[0-9]+$ ]]; then
    usage
fi

echo "=============";
echo "Running $cmd";
echo "=============";

if [ "$verbose" = true ] ; then
    time for i in `seq 1 $count`; do $cmd; done;
else
    echo "$(time (for i in `seq 1 $count`; do $cmd; done;) 2>&1 1>/dev/null)"
fi
