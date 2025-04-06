#include <avr/interrupt.h> // sei()
#include "gdb.h"

int fact(int n)
{volatile int __attribute__((unused)) tmp=n; // stack
 if (n>1)
    return(fact(n-1)*n);
 else return(1); // 1!=1
}

int main(void)
{
 volatile int __attribute__((unused)) val=5,res;
 volatile __attribute__((unused)) static int val1=0x42,val2=0x55; // heap
 struct gdb_context ctx;
 gdb_init(&ctx);
 sei();
 while(1)
    res=fact(val);
}
