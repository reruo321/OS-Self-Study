/*
 * WARNING: The code will produce a linker error!
 */

#include <stdio.h>

int main(){
    extern int NN;
    printf("Hello, %d!\n", NN);

    return 0;
}
