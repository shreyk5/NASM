%include 'functions.asm'

section .data

msi1: db 'Enter first string',0h
msi2: db 'Enter second string',0h

section .bss

str1: resb 20
str2: resb 20
lenstr1: resb 10
lenstr2: resb 10

section .text
global _start:
_start:

mov eax,msi1
call sprintLF

mov eax,3
mov ebx,0
mov ecx,str1
mov edx,lenstr1
int 80h

mov eax,str1
call slen

mov edx,eax
dec edx

mov ecx,0
mov ebx,0
mov eax,str1

while_c:
        cmp ecx,edx
	je endc

	cmp byte[eax],32
	jne skipc

        inc ebx

	skipc: 
	       inc ecx
	       inc eax
	       jmp while_c

endc: 
     mov eax,ebx
     call printi


mov eax,msi2
call sprintLF

mov eax,3
mov ebx,0
mov ecx,str2
mov edx,lenstr2
int 80h

mov eax,str1
call slen

mov ebx,eax
dec ebx

mov eax,str1
add ebx,eax

mov ecx,str2
mov eax,str2
call slen

mov edx,eax
dec edx      ;edx=len(str2)
mov eax,0

while_con:
          cmp eax,edx
	  je endcon

	  push edx

	  mov dl,byte[ecx]
	  mov byte[ebx],dl

	  pop edx

	  inc ecx
	  inc ebx
	  inc eax

	  jmp while_con
 
  endcon: mov eax,str1
          call sprintLF

call exit


