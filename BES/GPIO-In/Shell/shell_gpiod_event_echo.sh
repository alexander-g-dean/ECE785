#!/bin/bash
# Short script using shell to wait until gpiomon detects an edge,
# and then use gpioset update to output using gpioset based on edge direction. 

while true ; do
    edge="$(gpiomon --format=%e --num-events=1 --edges=both GPIO27)"
    # echo $edge
    # 1: rising, 2: falling
    level=$((2-edge))
    # echo $level
    gpioset -t0 GPIO17=$level
done
