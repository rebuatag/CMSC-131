;
; file: searchArray.asm
; This program demonstrates arrays in assembly
;
; To create executable:
; nasm -f coff array1.asm
; gcc -o array1 array1.o array1c.c
;

%include "asm_io.inc"
%define ARRAY_SIZE 100

segment .data
arraySize       	db   "Enter array size: ", 0
arrayInput1 		db 	 "Enter value @ array[", 0
arrayInput2		 	db   "] : ", 0
arrayContains 		db   "Array contains: ", 10, 0
searchPrompt 		db   10, "Enter number to be searched : ", 0
found1 				db   " is @ array[", 0
found2	 			db   "]", 0
error 				db   "Number not found in the array!", 0
separator			db   " ", 0

segment .bss
array           resd ARRAY_SIZE						;array of size 100
size  			resd 1
valueSearch		resd 1

segment .text
    global  _asm_main
	
_asm_main:
    enter 0, 0
    pusha
    
    mov     eax, arraySize
    call    print_string
    call    read_int
	
    mov     [size], eax							;mov eax = arraySize to size

    mov 	ecx, 0								; counter and index
		
inputLoop:
	mov 	eax, arrayInput1					; print prompt string
	call 	print_string

	mov 	eax, ecx							; print the index number
	call 	print_int

	mov		eax, arrayInput2					; print closing square brackets
	call 	print_string

	call 	read_int							; read user input
	mov 	[array + 4 * ecx], eax				; store input to array with 32 bits (x4) offset times the index

	inc 	ecx
	cmp 	ecx, [size]							; checking

	jne 	inputLoop							; if not equal, loop

	mov 	eax, arrayContains					; print string 
	call 	print_string

	mov 	ecx, 0								; initialized counter and index ecx = 0
		
printArray:
	mov 	eax, [array + 4 * ecx]				; prints every element in the array which are stored at that index
	call 	print_int

	mov 	eax, separator
	call 	print_string

	inc  	ecx									; counter/index
	cmp 	ecx, [size]
	jne 	printArray

	mov 	eax, searchPrompt					; print string then user input for the value to be searched
	call 	print_string

	call 	read_int							; read user input
	mov 	[valueSearch], eax					; store to valueSearch

	mov 	ecx, 0

searchValue:
	cmp 	ecx, [size]
	je 		notFound

	mov 	eax, [array + 4 * ecx]
	cmp 	eax, [valueSearch]					; check if current element is equal to number searched

	je 		found 								; if found jump to found

	inc 	ecx
	jne 	searchValue	 						; if not found, loop again

found:
	mov 	eax, [valueSearch]
	call 	print_int

	mov 	eax, found1
	call 	print_string

	mov 	eax, ecx
	call 	print_int

	mov 	eax, found2
	call 	print_string

	jmp 	endProgram

notFound:
	mov 	eax, error
	call 	print_string

endProgram:
    leave
    ret
		