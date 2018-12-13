#!/bin/bash

echo "Start Broker"
ttcn3_start ./bin/mqtt ./cfg/self_test/sf_01_broker.cfg &

echo "Start Client"
# grep will show us only the statistics of the client
ttcn3_start ./bin/mqtt ./cfg/self_test/sf_01_client.cfg | grep "Verdict statistics:"
