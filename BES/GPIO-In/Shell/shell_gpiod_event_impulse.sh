#!/bin/bash
# Short script using shell to wait until gpiomon detects an edge,
# and then generate 1 ms pulse on the output
while true ; do
    gpiomon -q --num-events=1 --edges=both GPIO27
    gpioset -t1,0 GPIO17=1
done
