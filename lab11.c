#include <stdio.h>

#include "cdecl.h"

#define STR_SIZE 100
/*
 * prototypes
 */

int PRE_CDECL char_count( const void *,
                           char target,
                           unsigned ) POST_CDECL;

unsigned PRE_CDECL str_count( const char * ) POST_CDECL;

int main()
{
  char strM[STR_SIZE] = "Find the maximum occuring character in a string";
  char separator[STR_SIZE] = "-----------------------------------------------";
  char prompt[STR_SIZE] = "Enter a string: ";
  char str[STR_SIZE];
  char maxChar;
  int i, max = 0, freq;

  printf("%s\n", separator);
  printf("%s\n", strM);
  printf("%s\n", separator);
  printf("%s", prompt);
  gets(str);

  for(i = 0; i < str_count(str); i++){
    freq = char_count(str, str[i], STR_SIZE);
    if(freq > max){
      max = freq;
      maxChar = str[i];
    }
  }
  printf("The highest frequency of character '%c' appears number of times is %d\n", maxChar, max);

  return 0;
}