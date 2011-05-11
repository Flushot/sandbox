;
; FizzBuzz
; by Chris Lyon
;

extern printf			; windows: _printf / linux: printf

; nasm macros
%macro prolog 0
	; enter
	push ebp 		; save ebp of caller
	mov ebp, esp 		; save start of stack frame
%endmacro
%macro prolog 1
	prolog
	sub esp, %1  		; allocate locals
%endmacro
%macro epilog 0
	; leave
	mov esp, ebp		; deallocate locals
	pop ebp			; restore ebp to caller location
	ret			; return to caller
%endmacro

; variables
segment .data
	fmt_s	db '%s', 0
	fmt_i	db '%i', 0
	newline	db 13, 10, 0
	fizz	db 'fizz', 0
	buzz	db 'buzz', 0

; program
segment .code
	global fizzy		; export for multi-module compiling

; void fizzy(int start, int end)
;   cdecl saves: ebx, esi, edi, ebp, cs, ds, ss, es
fizzy:			  	; windows: _fizzy / linux: fizzy
	prolog 4
	push ebx		; save (cdecl)

	mov ecx, [ebp + 8]	; arg1: start
	sub ecx, 1		; --start
	mov dword [ebp - 4], 0	; fizz_c = 0

next:
	add ecx, 1		; add = .5 cycles, inc = 1 cycle

do_fizz:
	mov eax, ecx
	mov bl, 3		; divisor
	div bl			; div/8: ax /= bl (ah=remainder)
;	cmp ah, 0
;	jne buzz_test
	test ah, ah 		; buzz_test if cx % 3 == 0
	jnz do_buzz
	add dword [ebp - 4], 1 	; ++fizz_c
	mov eax, fmt_s
	mov ebx, fizz
	call puts		; fizz

do_buzz:	
	mov eax, ecx
	mov bl, 5
	div bl			; divisor
	test ah, ah 		; buzz if cx % 5 == 0
	jnz do_number
	mov eax, fmt_s
	mov ebx, buzz
	call puts		; buzz
	jmp final

do_number:
	mov eax, ecx
	mov bl, 3
	div bl
;	cmp ah, 0
;	je final
	test ah, ah		; # if cx % 3 != 0
	jz final
	mov eax, fmt_i
	mov ebx, ecx
	call puts		; #
	
final:
	mov eax, newline
	xor ebx, ebx
	call puts		; \r\n
	
	cmp [ebp + 12], ecx	; loop until arg2: end
	jg next
	mov eax, [ebp - 4]	; return = fizz_c
	
	pop ebx			; restore (cdecl)
	epilog
	
; printf(eax, ebx)
puts:
	prolog
	push ecx		; save (cdecl)
	
	push ebx
	push eax
	call printf
	add esp, 8		; pop, pop

	pop ecx			; restore (cdecl)
	epilog
