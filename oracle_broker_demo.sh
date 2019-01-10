#!/bin/bash

echo "Start Broker"
ttcn3_start ./bin/mqtt ./cfg/oracle/broker_sut.cfg &

echo "Start Client"
# grep will show us only the statistics of the client
ttcn3_start ./bin/mqtt ./cfg/oracle/client_ts.cfg | grep "Verdict statistics:"
