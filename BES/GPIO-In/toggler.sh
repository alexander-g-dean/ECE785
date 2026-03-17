#!/bin/bash
#  Toggle a GPIO output pin with specified half-period (in us)
half_period=2000
if [ $# -gt 0 ] ; then
    half_period=$1
fi
echo "half_period is ${half_period}us"
gpioset -t "$half_period"us GPIO18=1
exit
