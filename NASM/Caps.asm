%include 'functions.asm'

section .data
  msg  : db 'Enter a character',0h
  msg1 : db 'Invalid char',0h
  msg2 : db 'Caps on',0h
  msg3 : db 'Caps off',0h

section .bss
  str : resb 1

section .text

global _start:
_start:

mov eax,msg
call sprintLF

mov eax,3
mov ebx,0
mov ecx,str
mov edx,1
int 80h


movzx ecx,byte[str]

cmp ecx,96
ja small
   cmp ecx,64
   ja capsOn
   mov eax,msg1
   call sprintLF
   jmp L1
   capsOn: mov eax,msg2
           call sprintLF
   jmp L1

small:                
   cmp ecx,122
   jna capsOff
   mov eax,msg1
   call sprintLF
   jmp L1
   
   capsOff : mov eax,msg3
             call sprintLF
   
L1:
 
call exit

