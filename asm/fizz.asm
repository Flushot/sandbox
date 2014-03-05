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

%ifidn OS, LINUX
; Linux
; Exported function as-is

extern printf
extern fizzy

main:

%else
; Windows/OSX
; Exported function needs a _ prefix

extern _printf
extern _fizzy

_main:

%endif

    prolog 4
    push ebx        ; save (cdecl)

    mov ecx, [ebp + 8] ; arg1: start
    mov dword [ebp - 4], 0  ; fizz_c = 0

    mov eax, 1
    mov ebx, 5
	
%ifidn OS, OSX
; OSX
; Need to align stack to 16 bytes

    ; Align stack to 16 bytes
    mov ebp, esp    ; save esp
    and esp, -16    ; truncate esp to 16 byte boundary

    sub esp, 16     ; Allocate full 16 bytes (even though 8 are going to be used)
    mov dword[esp + 4], ebx ; arg 2 (4 bytes)
    mov dword[esp], eax ; arg 1 (4 bytes)
    call _fizzy

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
    call _fizzy
    add esp, 8      ; pop, pop

    pop ecx         ; restore ecx (cdecl)
    epilog

%endif

;  cleanup
    mov eax, [ebp - 4] ; return = fizz_c
    
    pop ebx         ; restore (cdecl)
    epilog
