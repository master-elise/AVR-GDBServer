/*
 * Sort algorithm and its test from linux kernel
 */
#include <avr/interrupt.h>
#include <stdlib.h>
#include <avr/io.h>

#include "gdb.h"

int fact(int n)
{volatile int tmp=n;
 if (n>1)
    return(fact(n-1)*n);
 else return(1); // 1!=1
}


int main(void)
{
 int val=5,res;
 volatile static int val1=0x42,val2=0x55;
 struct gdb_context ctx;
 gdb_init(&ctx);
 USBCON=0;
 sei();
 while(1)
    res=fact(val);
}
