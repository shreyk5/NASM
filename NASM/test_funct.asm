%include 'prac_funct.asm'

section .data
msg1: db 'Enter a string',0h
l1  : equ $-msg1

msg2: db 'Enter a number',0h
l2  : equ $-msg2

section .bss
name : resb 10
l3   : resb 1
n    : resb 10
l4   : resb 1
arr  : resd 100
loop1: resb 10
loop2: resb 10


section .data

global _start:
_start:

mov eax,msg1
call print_strl


mov esi,arr

call read_arr
call print_arr

;--------------------
; inversion 
;---------------------

xor ecx,ecx    ;i=0
mov edx,[num]
sub edx,1
mov dword[loop1],edx


fori:
       cmp ecx,dword[loop1]
       ja end_i

       mov edx,ecx
       inc edx        ;j=i+1

      forj:
            cmp edx,dword[loop1]
	    ja end_j

	    mov ebx,dword[esi+4*ecx]
	    cmp ebx,dword[esi+4*edx]   ;ebx=arr[i], arr[j]

	    jnb skip
                       
	    mov eax,ebx
	    call print_int
            
	    mov eax,32
	    push eax
	    mov eax,esp
	    call print_str
	    pop eax
           	  
            mov eax,dword[esi+4*edx]
	    call print_int

	    mov eax,0ah
	    push eax
	    mov eax,esp
	    call print_str
	    pop eax

	  skip:  inc edx
            jmp forj

	   end_j: 
	         inc ecx
		 jmp fori
  end_i:		 



call stop

