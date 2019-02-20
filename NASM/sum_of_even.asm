%include 'functions.asm'

section .data
msg : db  'Enter a number',0h
msg1: db  ' ',0h

section .bss
n : resb 10
l : resb 1

section .text
global _start:
_start:

mov eax,msg
call sprintLF

mov eax,3
mov ebx,0
mov ecx,n
mov edx,l
int 80h

mov eax,n
call str_to_num

mov ecx,0

for:
    cmp ecx,edx
    ja brk
    
    mov eax,ecx
    call printi
    
    mov eax,msg1
    call sprint
    call newline

    add ecx,2    
    jmp for

brk:
call exit

