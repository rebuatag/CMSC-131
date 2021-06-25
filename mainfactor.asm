
%include "asm_io.inc"

segment .bss
input   resd 1

segment .text
        global  _asm_main
        extern get_int, factorial

_asm_main:
        enter   0,0           
        pusha

        call    get_int                ; read integer function in "factor.asm"
        mov     [input], eax

        mov     eax, [input]
        call    print_int              ; prints integer to calculate its factorial

        mov     eax, [input]
        mov     ebx, eax

while_loop:         
        cmp     ebx, 1                                   
        jle     end_while

        dec     ebx                                
        mul     ebx             
        jmp     while_loop

end_while:
        push    eax
        call    factorial               ;go to factorial function in "factor.asm"
        pop     eax
 
        popa
        leave                     
        ret       


