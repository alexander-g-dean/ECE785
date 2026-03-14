#!/bin/bash
#  Short script to toggle a GPIO pin with gpiod at the highest frequency
while true; do
    gpioset -t0 GPIO17=1
    gpioset -t0 GPIO17=0
done
