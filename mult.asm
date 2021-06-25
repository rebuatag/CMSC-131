;subroutine mult
;prints multiplication
;Parameters:
;n - size of the multiplication table (at [ebp + 8]
;
;pseudocode C code:
;	void mult (int n){
;		int i, j;
;		
;		for (i=1;i<=n;i++)
;		{
;			for (j=1;j<=n;j++)
;			{
;				if (j<=n-1)
;					printf("\t%d", i*j);
;				else
;					printf("\t%d", i*j);
;			}
;		printf("\n");
;		}
;	}


%include "asm_io.inc"

segment .data
tab db 9, 0								; 9 = tab                     		

segment .bss
input resd 1

segment .text
        global  _mult

_mult:
        enter 0, 0
        
        mov     eax, [ebp + 8]          ; assign n to eax
        add     eax, 1                  ; for checking 
        mov     [input], eax            ; assign to eax(n) input
        mov     ebx, 0                  ; ebx = counter for outer loop

        jmp     outer_loop

outer_loop:								; ROW
        call    print_nl            	; prints newline every new row

        add     ebx, 1                  ; increment for every new row, starting from 1
        cmp     ebx, [input]            ; checks if ebx <= input
        je      end_loop              	; end_loop if equal
	
        mov     ecx, 0                  ; ecx = counter for inner loop

inner_loop: 							; COLUMN
        add     ecx, 1                  ; increment for every new column, starting from 1

        mov     eax, tab                ; print tab for uniformity
        call    print_string

        mov     eax, ebx                ; ebx = eax
        mul     ecx                     ; multiply the value of current row (eax) to ecx
        call    print_int

        cmp     ecx, [ebp + 8]          ; checks if ecx <= input
        je      outer_loop				; end_loop if equal
        jmp     inner_loop				; loop while ecx <= input

end_loop:
        leave
        ret