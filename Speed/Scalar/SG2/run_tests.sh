#! /bin/bash
# To save output from test program (stdout) and perf record (stderr),
#    do ./run_tests.sh &> summary.txt

# Pass m as first argument to select monochrome text output.

# Comments on Colors

# Script generates files with ANSI color code escapes by default.
# less -r file shows with ANSI colors

# For easier viewing of color-coded text (on PC, elsewhere),
# script uses ansifilter to get ANSI -> RTF converter
# sudo apt install ansifilter

clr="--stdio-color" 
if [ "$1" = "m" ]; then
    clr=""
    #    echo "Monochrome"
fi

ver=11
while [ $ver -lt 15 ]; do
    echo
    echo ____________ Version $ver _______________
    make -s clean
    make -s sg VER=$ver
    make -s geometry_list.s VER=$ver
    mv geometry_list.s geometry_list_$ver
    cp sg sg$ver
    sudo perf record ./sg 
    sudo perf report --stdio $clr --percent-limit 4  -n  > pr$ver.txt
    sudo perf annotate --stdio $clr --percent-limit 4 > an$ver.txt 2> /dev/null
    grep -v \# pr$ver.txt 
    grep -n  \>: an$ver.txt

    # Under development
    #    grep -v \# pr$ver.txt > sum$ver.txt
    #    grep -n  \>: an$ver.txt >> sum$ver.txt

    if [ -n $clr ]; then
	ansifilter --rtf -i pr$ver.txt -o pr$ver.rtf
	ansifilter --rtf -i an$ver.txt -o an$ver.rtf
	# ansifilter --rtf -i sum$ver.txt -o sum$ver.rtf
    fi
    let ver=ver+1
done
