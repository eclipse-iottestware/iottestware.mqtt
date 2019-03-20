#!/usr/bin/python3
import time
from datetime import datetime
import os
import re
import random
import subprocess
import argparse

# Note: see manpage of zzuf http://manpages.ubuntu.com/manpages/bionic/man1/zzuf.1.html
parser = argparse.ArgumentParser(description='Start MQTT Fuzzing utilizing the MQTT Test Suite and zzuf')
parser.add_argument("-s", "--seed", required=False, help="Specify a custom seed for fuzz data generation")
parser.add_argument("-r", "--ratio", required=False, help="Specify the proportion of bits that will be randomly fuzzed")
parser.add_argument("-n", "--runs", required=False, default=1, help="Specify how many times the test suite should be ran")

# TODO: add these arguments for more flexibility
#parser.add_argument("-c", "--conf", required=True, help="Specifiy the Titan configuration file")
#parser.add_argument("-t", "--test_suite", required=True, help="Specify the path to the ETS")
args = parser.parse_args()

TITAN_BINARY = 'ttcn3_start'
TESTSUITE_BINARY = './bin/iottestware.mqtt'

MIN_RATIO_MIN = 0.0
MAX_RATIO_MAX = 0.1     # flip maximally 10% of the packet

ratio_change_max = 0.005
ratio_change_min = -(2 * ratio_change_max)

r_verdict_stats = r'Verdict statistics:\s(.*)'

def main():

    if args.seed:
        seed = args.seed
    else:
        seed = int(time.time())

    if args.ratio:
        ratio = args.ratio
    else:
        ratio = "0.0001:0.035"

    # TODO: add arguments for listen_port, destination_host and destination_port
    listen_port = 1884
    destination = "127.0.0.1:1883"
    config = './cfg/broker_testing_fuzzing_01.cfg'
    runs = int(args.runs)

    verdict_statistics = {'none': 0, 'pass': 0, 'inconc': 0, 'error': 0, 'fail': 0}
    num_test_cases = 0

    start_time = datetime.now()
    for n in range(runs):
        print("[" + str(n) + "] Start Fuzzing with: " + str(seed) + " / " + str(ratio))
        proxy = start_fuzzing_proxy(seed, ratio, listen_port, destination)
        test_suite = start_test_suite(config)

        # TODO: read stdout of test_suite and count the verdicts!

        line = '..'
        while line != '':
            line = test_suite.stdout.readline().decode("utf-8")
            if 'Verdict statistics:' in line:
                # find the verdicts and store for final statistics
                matches = re.finditer(r_verdict_stats, line)

                for match_num, match in enumerate(matches):
                    for group_num in range(0, len(match.groups())):
                        item = match.group(group_num)

                        # item contains now: Verdict statistics: 0 none (0.00 %), 1 pass (33.33 %), 0 inconc (0.00 %), 2 fail (66.67 %), 0 error (0.00 %).
                        verdicts = item.split(":")[1].split(",")
                        for v in verdicts:
                            tokens = v.strip().split(" ")
                            num = int(tokens[0]) # number of verdicts
                            num_test_cases += num
                            verdict_name = tokens[1] # pass, fail, inconc etc.
                            verdict_statistics[verdict_name] += num

        # wait until the test suite terminates
        test_suite.wait()

        # terminate the proxy
        # TODO: check if proxy terminated correctly!
        proxy.terminate()

        # slightly adapt the seed and the ratio to add some diversification
        if args.seed is None:
            seed = int(time.time())

        ratio = change_ratio(ratio)

    end_time = datetime.now()
    duration = end_time - start_time

    print("\nFuzzing statistics:")
    print("===================")
    print("Fuzzing was running for " + str(duration))
    print("Executed Test cases: " + str(num_test_cases))
    print("Verdict statistics: " + str(verdict_statistics))

def change_ratio(old_ratio):
    ratio_boundaries = old_ratio.split(":")
    ratio_min = float(ratio_boundaries[0]) + random.uniform(ratio_change_min, ratio_change_max)
    ratio_max = float(ratio_boundaries[1]) + random.uniform(ratio_change_min, ratio_change_max)

    if ratio_min < MIN_RATIO_MIN:
        ratio_min = MIN_RATIO_MIN
    elif ratio_min >= MAX_RATIO_MAX:
        ratio_min = MIN_RATIO_MIN   # turn over

    if ratio_max < MIN_RATIO_MIN:
        ratio_max = MAX_RATIO_MAX   # turn over
    elif ratio_max >= MAX_RATIO_MAX:
        ratio_max = MAX_RATIO_MAX

    # flip ratios if max < min
    if ratio_max < ratio_min:
        tmp = ratio_max
        ratio_max = ratio_min
        ratio_min = tmp

    return str(ratio_min) + ':' + str(ratio_max)

def start_test_suite(config):
    args = ['ttcn3_start', TESTSUITE_BINARY, config]
    child = subprocess.Popen(args, stdout=subprocess.PIPE)
    return child

def start_fuzzing_proxy(seed, ratio, listen_port, destination, debug=False):
    # required surpress output from subprocess
    stdout = subprocess.PIPE #open(os.devnull, 'w')
    shell = False

    args = ['zzuf', '-s', str(seed), '-n', '-A', '-r', str(ratio)]

    if debug:
        args += ['-d', '-v']

    args += ['socat', 'TCP-LISTEN:' + str(listen_port) + ',reuseaddr,fork', 'TCP4:' + str(destination)]
    # if running on top of UDP e.g. CoAP
    # args += ['socat', 'UDP4-RECVFROM:' + str(listen_port) + ',fork', 'UDP4-SENDTO:' + str(destination)]

    # TODO: kill zzuf does not kill socat! these must killed separately?
    child = subprocess.Popen(args, stdout=stdout, stdin=stdout, shell=shell)
    return child


if "__main__" == __name__:
    main()
