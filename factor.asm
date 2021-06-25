%include "asm_io.inc"

segment .data
prompt  db "Enter a number to calculate its factorial: ", 0 
message db "! = ", 0

segment .text
        global  get_int, factorial
get_int:                                ;get_int function gets the integer input of user
        enter   0,0           
        pusha

        mov     eax, prompt                 ; print out prompt
        call    print_string
        
        call    read_int                   ; read integer
        leave
        ret

factorial:                              ;factorial function prints the factorial of the number;
        enter   0,0

        mov     eax, message
        call    print_string

        mov     eax, [ebp+8]
        call    print_int
        call    print_nl

        leave
        ret






