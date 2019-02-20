%include 'functions.asm'

section .data
msg : db 'Enter the size of arr and arr elements',0h

section .bss

arr : resd 50
leni : resb 1

section .data
global _start:
_start:

mov eax,msg
call sprintLF

mov esi,arr
call read_array
call print_array
call newline

mov edx,dword[n]
dec edx

xor ecx,ecx   ; i=0
fori:
      cmp ecx,edx
      je finish_i
      
      mov eax,edx     ;eax=n-1  
      sub eax,ecx     ; eax=n-i-1

         xor ebx,ebx   ; j=0
   forj:
        cmp ebx,eax
	je finish_j

	push eax
	mov eax,dword[esi+4*ebx]
	cmp eax,dword[esi+4*ebx+4]

	jna skip_swap
	push edx
	mov edx,dword[esi+4*ebx+4]
        mov dword[esi+4*ebx],edx
	mov dword[esi+4*ebx+4],eax
	pop edx
      

   skip_swap:
              pop eax
	      inc ebx
	      jmp forj
     finish_j:
              inc ecx
	      jmp fori
         
        finish_i:
	          call print_array
      



call exit





