%include "asm_io.inc"

segment .data
prompt  db "Enter a number to calculate its factorial: ", 0 
message db "! = ", 0

segment .bss
input   resd 1

segment .text
        global  _asm_main
                                        ;main
_asm_main:
        enter   0,0           
        pusha

        mov eax, prompt                 ; print out prompt
        call print_string

        call read_int                   ; read integer
        mov [input], eax

        mov eax, [input]
        call print_int

        mov eax, message
        call print_string

        mov eax, [input]
        mov ebx, eax                    ;eax = ebx

                                        ;solving for factorial
while_loop:         
        cmp ebx, 1                      ;ebx = eax = n
        je end_while                    ;if equal to 1

        dec ebx                         ;decrement the value of ebx
        mul ebx                         ;ebx * ebx
        jmp while_loop                  ;loop

end_while:                              
        call print_int                  ;printing
        call print_nl

        popa
        leave
        ret        


