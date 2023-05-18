# Warning: Not working

obj-m += hellok.o
KDIR = //usr/src/linux-headers-$(shell uname -r)

all:
        $(MAKE) -C $(KDIR) M=$(shell pwd) modules
clean:
        rm -rf *.o *.ko *.mod.* *.symvers *.order
