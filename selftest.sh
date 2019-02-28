#!/bin/bash

# choos config 01 by default, else config 02
if [ $# -eq 0 ]; then
    echo "Self-Test Configuration 01"
    CONFIG="01"
else
    echo "Self-Test Configuration 02"
    CONFIG="02"
fi

echo "Start Broker"
ttcn3_start ./bin/iottestware.mqtt ./cfg/self_test/st_broker_$CONFIG.cfg &

echo "Start Client"
ttcn3_start ./bin/iottestware.mqtt ./cfg/self_test/st_client_$CONFIG.cfg
