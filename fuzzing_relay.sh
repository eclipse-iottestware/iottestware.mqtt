#!/bin/bash

# this script starts a fuzzing proxy

display_help()
{
  echo "Usage: $0 [options]" >&2
  echo
  echo "-s, --seed            the seed to initialize the random fuzzing"
  echo "-r, --ratio           the ratio of flipped bits (default: 0.035 => 3.5%)"
  echo "-d, --destination     the destination the proxy should forward to (address:port)"
  echo "-l, --listen          the port on which the proxy listens for incoming PDUs"

  exit 1
}

# set default values
SEED=$(date +%s)
RATIO=0.035
LISTEN_PORT=1884
DST_HOST=127.0.0.1:1883

# adapt values according to CLI arguments
while [ "$1" != "" ]; do
    case $1 in
        -s | --seed )           shift
                                SEED=$1
                                ;;
        -r | --ratio )          shift
                                RATIO=$1
                                ;;
        -d | --destination )    shift
                                DST_HOST=$1
                                ;;
        -l | --listen )         shift
                                LISTEN_PORT=$1
                                ;;
        -h | --help )           display_help
                                exit
                                ;;
        * )                     display_help
                                exit 1
    esac
    shift
done

echo "Starting Fuzzing-Proxy: 0.0.0.0:$LISTEN_PORT <-> $DST_HOST"
echo "Fuzzing parameters: Seed = $SEED, Ratio = $RATIO"

zzuf -s$SEED -d -n -p$LISTEN_PORT -A  -r$RATIO socat TCP-LISTEN:$LISTEN_PORT,reuseaddr,fork TCP4:$DST_HOST
