%include 'functions.asm'

section .data
ms :db 'Enter the no of elements and array elements',0h
ms1:db 'Enter the no to be searched',0h
nf :db 'Not found',0h

section .bss
arr: resd 50
x  : resd 10
xlen: resd 2

section .data
global _start:
_start:

mov eax,ms
call sprintLF

mov esi,arr
call read_array
call print_array

mov eax,ms1
call sprintLF

mov eax,3
mov ebx,0
mov ecx,x
mov edx,xlen
int 80h

mov eax,x
call str_to_num
mov dword[x],edx


xor ecx,ecx         ;l=0
xor ebx,ebx
mov ebx,dword[n]
dec ebx             ; r=n-1

bsearch:
        cmp ecx,ebx
	ja finish_bsearch
        
	xor edx,edx
	xor eax,eax

	add eax,ebx     
	add eax,ecx   ;eax=l+r
        
	push ebx
	mov ebx,2
	idiv ebx       ; eax=(l+r)/2
	pop ebx        ;popped
        
	xor edx,edx
        mov edx,dword[x]     
	cmp edx,dword[esi+4*eax]
	je found
        
        cmp edx,dword[esi+4*eax]
	ja  update_l
	
	dec eax
        mov ebx,eax       ; update_r
        jmp skip_l

      update_l:
       inc eax
       mov ecx,eax
     skip_l:call bsearch


   found :
           call printi	
           jmp finish_program
           
 finish_bsearch:
                mov eax,nf
		call sprintLF

finish_program:
call exit

