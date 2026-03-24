#obj-m+=gpio_test.o
#obj-m+=gpioctrl.o
obj-m+=gpio_test2.o
#obj-m+=dev_in4.o

all:
	make -C /lib/modules/$(shell uname -r)/build/ M=$(PWD) modules
clean:
	make -C /lib/modules/$(shell uname -r)/build/ M=$(PWD) clean
