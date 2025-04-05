#
# Makefile for AVR ATMega16
# Good example of makefiles for AVR
# can be taken from
# http://www.obdev.at/products/vusb/index.html
# e.g. this: examples/hid-mouse/firmware/Makefile
#
CC=avr-gcc
CXX=avr-g++
MMCU=atmega32u4
# MMCU=atmega16
ifeq ($(MMCU),atmega16)
RAM_SZ=1024
ROM_SZ=16384
else
RAM_SZ=2560
ROM_SZ=32768
endif

CLK=16000000UL

all:
	avr-gcc -Wall -Os -g -gdwarf-2 -std=gnu99 -mmcu=$(MMCU) -DF_CPU=16000000UL -o gdb.elf gdb.c main.c -Wl,--section-start=.nrww=0x3ea0
	./binary_stat.pl gdb.elf $(ROM_SZ) $(RAM_SZ)


# Flash burning
# to avoid sudo place udev rule for USBASP as /etc/udev/rules.d/usbasp.rules:
# SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="05dc", GROUP="users", MODE="0666"
flash: all
	avr-objcopy -j .text -j .data -j .nrww -O ihex gdb.elf gdb.hex
ifeq ($(MMCU),atmega16)
	avrdude -c usbasp -p m16 -u -U flash:w:gdb.hex
else
	avrdude -c avr109 -b57600 -D -p $(MMCU) -P /dev/ttyACM0 -e -U flash:w:gdb.elf
endif
