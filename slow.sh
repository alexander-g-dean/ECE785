#!/bin/bash
sudo cpupower frequency-set -g powersave
cpupower frequency-info | grep current | tail -n 1

