global _char_count, _str_count

segment .text

%define source    [ebp + 8]
%define dest      [ebp + 12]
%define size      [ebp + 16]

_char_count:
    enter   0,0
    push	edi

    mov     eax, dest       	; eax = address of character to find
    mov     edi, source			; edi = address of the string
    mov     ecx, size			; ecx = address of the size of string
    mov 	ebx, 0				; ebx = address of the frequency counter
    cld							; clear direction flag, 0 = inc, 1 = dec
	
loop:
    repne   scasb           	; execute scasb until ECX == 0, repeat while not equal zero

    je      found_it        	; if zero flag set, then value was found

    jmp     short quit

found_it:
	inc 	ebx					; increment ebx by 1 and then go back to loop
	cld
	jmp 	loop

quit:
	mov     eax, ebx			; mov ebx to eax as the final frequency to be returned
    pop 	edi
    leave
    ret

; function str_count
; returns the size of a string
; unsigned str_count( const char * );
; parameter:
;   src - pointer to string
; return value:
;   number of chars in string (not counting, ending 0) (in EAX)

%define src [ebp + 8]
_str_count:
    enter   0,0
    push	edi

    mov     edi, src        	; edi = pointer to string
    mov     ecx, 0FFFFFFFFh 	; use largest possible ECX
    xor     al, al           	; al = 0
    cld

    repnz   scasb           	; repeat while not zero

    mov     eax, 0FFFFFFFEh
    sub     eax, ecx          	; length = 0FFFFFFFEh - ecx

    pop 	edi
    leave
    ret