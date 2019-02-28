#!/bin/bash

echo "Start Broker"
ttcn3_start ./bin/iottestware.mqtt ./cfg/self_test/st_broker_01.cfg &

echo "Start Client"
# grep will show us only the statistics of the client -> | grep "Verdict statistics:"
ttcn3_start ./bin/iottestware.mqtt ./cfg/self_test/st_client_01.cfg | grep "Verdict statistics:"
