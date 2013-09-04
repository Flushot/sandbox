;
; FizzBuzz
; by Chris Lyon
;
use32

; nasm macros
%macro prolog 0
    ; enter
    push ebp        ; save ebp of caller
    mov ebp, esp    ; save start of stack frame
%endmacro
%macro prolog 1
    prolog
    sub esp, %1     ; allocate locals
%endmacro
%macro epilog 0
    ; leave
    mov esp, ebp    ; deallocate locals
    pop ebp         ; restore ebp to caller location
    ret             ; return to caller
%endmacro

; variables
segment .data
    fmt_s   db '%s', 0
    fmt_i   db '%i', 0
    newline db 13, 10, 0
    fizz    db 'fizz', 0
    buzz    db 'buzz', 0

; program
segment .text

; void fizzy(int start, int end)
;   cdecl saves: ebx, esi, edi, ebp, cs, ds, ss, es

%ifidn OS, LINUX
; Linux
; Exported function as-is

extern printf

global fizzy
fizzy:

%else
; Windows/OSX
; Exported function needs a _ prefix

extern _printf

global _fizzy
_fizzy:

%endif

    prolog 4
    push ebx        ; save (cdecl)

    mov ecx, [ebp + 8] ; arg1: start
    sub ecx, 1      ; --start
    mov dword [ebp - 4], 0  ; fizz_c = 0

next:
    add ecx, 1      ; add = .5 cycles, inc = 1 cycle

do_fizz:
    mov eax, ecx
    mov bl, 3       ; divisor
    div bl          ; div/8: ax /= bl (ah=remainder)
    test ah, ah     ; buzz_test if cx % 3 == 0
    jnz do_buzz
    add dword [ebp - 4], 1 ; ++fizz_c
    mov eax, fmt_s
    mov ebx, fizz
    call puts       ; fizz

do_buzz:    
    mov eax, ecx
    mov bl, 5
    div bl          ; divisor
    test ah, ah     ; buzz if cx % 5 == 0
    jnz do_number
    mov eax, fmt_s
    mov ebx, buzz
    call puts       ; buzz
    jmp final

do_number:
    mov eax, ecx
    mov bl, 3
    div bl
    test ah, ah     ; # if cx % 3 != 0
    jz final
    mov eax, fmt_i
    mov ebx, ecx
    call puts       ; #
    
final:
    mov eax, newline
    xor ebx, ebx
    call puts       ; \r\n
    
    cmp [ebp + 12], ecx ; loop until arg2: end
    jg next
    mov eax, [ebp - 4] ; return = fizz_c
    
    pop ebx         ; restore (cdecl)
    epilog
    
; printf(eax, ebx)
puts:
    prolog
    push ecx        ; save ecx (cdecl)

%ifidn OS, OSX
; OSX
; Need to align stack to 16 bytes

    ; Align stack to 16 bytes
    mov ebp, esp    ; save esp
    and esp, -16    ; truncate esp to 16 byte boundary

    ; Call _printf
    sub esp, 16     ; Allocate full 16 bytes (even though 8 are going to be used)
    mov dword[esp + 4], ebx ; arg 2 (4 bytes)
    mov dword[esp], eax ; arg 1 (4 bytes)
    call _printf

    ; epilog (modified for popping ecx)
    mov esp, ebp    ; deallocate locals / restore stack
    pop ecx         ; restore ecx (cdecl)
    pop ebp         ; restore ebp to caller location
    ret             ; return to caller

%else
; Linux/Windows
; No stack alignment necessary

    push ebx        ; arg 2 (4 bytes)
    push eax        ; arg 1 (4 bytes)
    call _printf
    add esp, 8      ; pop, pop

    pop ecx         ; restore ecx (cdecl)
    epilog

%endif
