#!/bin/bash

echo "Start Broker"
ttcn3_start ./bin/mqtt ./cfg/self_test/sf_01_broker.cfg &

echo "Start Client"
# grep will show us only the statistics of the client -> | grep "Verdict statistics:" 
ttcn3_start ./bin/mqtt ./cfg/self_test/sf_01_client.cfg
