#include <stdio.h>

#include "cdecl.h"

int PRE_CDECL mult( int ) POST_CDECL;     /* prototype for assembly routine */

int main(void) 
{
    int  n;
    printf("Input upto the table number starting from 1 : ");
    scanf("%d", &n);
	
    printf("**********************************\n");
    printf("*******Multiplication Table*******\n");
    printf("***********From 1 to %d************\n", n);
    mult(n);
    printf("\n*********************************");
    return 0;
}