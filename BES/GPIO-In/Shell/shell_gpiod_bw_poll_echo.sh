#!/bin/bash
#  Short script using shell to copy a GPIO input to a GPIO output as fast as possible
while true; do
    gpioset -t0 GPIO17=`gpioget --numeric GPIO27`
done
