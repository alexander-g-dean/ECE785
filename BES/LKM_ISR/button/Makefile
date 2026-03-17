obj-m+=button2.o
# CARGS = -I /usr/src/`uname -r`/include
# CARGS = -I //`uname -r`/include
all:
	make -C /lib/modules/$(shell uname -r)/build/ M=$(PWD) modules
clean:
	make -C /lib/modules/$(shell uname -r)/build/ M=$(PWD) clean
