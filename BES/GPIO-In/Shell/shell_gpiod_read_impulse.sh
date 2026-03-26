#!/bin/bash
#  toggle output after receiving each newline via stdin
#   from gpiomon --format=%e | (this script)

while IFS= read -r line; do
    # 1 ms pulse
    gpioset -t1,0 GPIO17=1
    # what is delay until pulse edge?
    # what is peak delay?

    # explicit set/clear pulse is how wide?
    # gpioset -t0 GPIO17=1
    # gpioset -t0 GPIO17=0
    echo "$line" > /dev/null
done 
