#!/bin/bash
#  Short script to toggle a GPIO pin with gpiod at the highest frequency

# one argument: g
if [[ $# -gt 0 && $1 = "g" ]] ; then
    while true; do
	gpioset -t1 GPIO17=1
    done
else
    # no arguments (or more than one)
    while true; do
	gpioset -t0 GPIO17=1
	gpioset -t0 GPIO17=0
    done
fi


      
