#! /bin/bash
ver=11
while [ $ver -lt 15 ]; do
    echo ____________ Version $ver _______________
    make -s clean
    make -s sg VER=$ver
    make -s geometry_list.s VER=$ver
    mv geometry_list.s geometry_$ver.s
    sudo perf record ./sg
    sudo perf report --stdio --stdio-color --percent-limit 4  -n  > pr$ver.txt
    sudo perf annotate --stdio --stdio-color  --percent-limit 4 > an$ver.txt 2> /dev/null
    grep -v \# pr$ver.txt
    grep \>: an$ver.txt
    
    let ver=ver+1
done

# less -r # shows colors
