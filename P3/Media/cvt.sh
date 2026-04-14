#!/bin/bash
# convert single file (argument) from yuv to mpg
ffmpeg -v quiet -hide_banner -pixel_format yuv420p -s 1280X720 -i $1.yuv -y $1.jpg
