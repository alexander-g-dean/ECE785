#!/bin/bash
sudo cpupower frequency-set -g performance
sudo cpupower frequency-info | grep current | tail -n 1

