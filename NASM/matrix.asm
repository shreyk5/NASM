%include 'functions.asm'

section .data

msg: db 'Enter number of rows',0h
msg1: db 'Enter number of columns',0h

section .bss
r:      resb 10
c:      resb 10
numi:    resb 10
lenr:   resb 10
lenc:   resb 10
len3:   resb 10
matrix: resd 100
matt  : resd 100
matp  : resd 100
tmp:   resb 10
tmp1 : resb 10

section .text
global _start:
_start:

mov eax,msg
call sprintLF

mov eax,3
mov ebx,0
mov ecx,r
mov edx,lenr
int  80h

mov eax,msg1
call sprintLF

mov eax,3
mov ebx,0
mov ecx,c
mov edx,lenc
int 80h

mov eax,r
call str_to_num
mov [r],edx

mov eax,c
call str_to_num
mov [c],edx

mov eax,[r]
mul edx    ; eax=n*m

mov ebx,matrix

mov ecx,0  ;i=0

fori:
     cmp ecx,eax
     jnb endi
       
           pusha
	   mov eax,3
	   mov ebx,0
	   mov ecx,numi
	   mov edx,len3
	   int 80h
           popa

           push eax
	   mov eax,numi
	   call str_to_num
	   pop  eax
	   mov dword[ebx+4*ecx],edx
         
	   inc ecx
	   jmp fori
           
	endi:
mov ecx,0
pr_while:
         
        mov esi,matrix
	mov ebx,[r]
	mov ecx,[c]
	call print_mat

       mov edx,matrix
       
       mov ebx,0  ;i=0  
       mov eax,[c]
       for1:
            cmp ebx,[r]
	    je end1

	    mov ecx,0   ;j=i
	    for2:
	          cmp ecx,[c]
		  je end2
                  
		  mov eax,[c]
		  mov eax,ebx
		  
		  mov eax,ecx
		  
		  mov eax,[c]
		  mov eax,dword[edx]
		  
		  mov edx,matrix
		  mov eax,edx
		  
		  mov eax,[c]
		  call get_idx
		  push ecx
		  mov ecx,dword[eax]
                  mov eax,ecx
                  ;call printi
		  mov [tmp],ecx       ;tmp=a[i][j]
		  mov eax,[tmp]
		  pop ecx
                  
		  mov eax,[r]
		  mov edx,matt
		  call get_idx1
                  push ecx
		  mov ecx,[tmp]
		  mov [eax],ecx     
                  pop ecx
                       
		  inc ecx
		  mov eax,[c]
		  jmp for2
       end2: 
            inc ebx
	    jmp for1

     end1:
            mov esi,matt
	    mov ebx,[c]
	    mov ecx,[r]
	    call print_mat

    mov ebx,0

    forr1:                   ;i
          cmp ebx,[r]
	  je endr1

	  mov ecx,0

	 forc1:             ;j
	       cmp ecx,[r]
               je endc1
              
               mov edx,matp
	       mov eax,[r]
	       call get_idx
	       mov dword[eax],0

	      mov edx,0
	    fork1:
	          cmp edx,[c]      ;k
		  je endk1         
		                    ;res+=a[i][k]*b[k][j]
	          			    
                  pusha
		  ;mov edx,matrix
		  mov eax,[c]
		  mov ecx,edx
		  mov edx,matrix
		  call get_idx
		  mov ecx,dword[eax]
		  mov [tmp],ecx
		  popa

		  pusha
		  ;mov edx,matt
		  mov eax,[r]
		  mov ebx,edx
		  mov edx,matt
                  call get_idx
		  mov ecx,dword[eax]
		  mov edx,[tmp]
		  imul ecx,edx       ;ecx contains product
                  mov [tmp],ecx
		  popa
                  
		  push edx
		  mov edx,matp
		  mov eax,[r]
		  call get_idx
		  pop edx
		  
		  push ecx
		  mov ecx,[tmp]
		  add dword[eax],ecx
		  pop ecx

                  inc edx
		  jmp fork1
		  
          endk1:
	        inc ecx
		jmp forc1
       
       endc1: 
              inc ebx
	      jmp forr1
    
    endr1:
            mov esi,matp
	    mov ebx,[r]
	    mov ecx,[r]
	    call print_mat

      call exit    
        





