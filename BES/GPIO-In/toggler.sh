#!/bin/bash
#  Toggle a GPIO output pin with specified half-period (in us)
half_period=2000
if [ $# -gt 0 ] ; then
    half_period=$1
fi
half_period+="us"
echo "half_period is $half_period"
gpioset -t "$half_period" GPIO18=1
exit
