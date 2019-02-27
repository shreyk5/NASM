%include 'functions.asm'

section .data

msi: db 'Enter a string',0h
msi1: db 'is a palindrome',0h
msi2: db 'not a palindrome',0h

section .bss

str1: resb 20
str2: resb 20
lenstr1: resb 10
lenstr2: resb 10
sn : resb 10

section .text
global _start:
_start:

mov eax,msi
call sprintLF

mov eax,3
mov ebx,0
mov ecx,str1
mov edx,lenstr1
int  80h

mov eax,str1
call slen

;call printi
dec eax
mov [sn],eax

mov ebx,eax
dec ebx

mov eax,str1
mov edx,str2
add edx,ebx

mov ecx,0

for_str:
         cmp ecx,[sn]
	 je endfor

	 push ecx
         mov ecx,0

	 mov cl,byte[eax]
	 mov byte[edx],cl
         
	 pop ecx

	 inc ecx
	 inc eax
	 dec edx
         jmp for_str

endfor:  mov eax,str2
         call sprintLF


mov eax,str1
mov ebx,str2

mov ecx,0
mov edx,0

while_check:
             cmp ecx,[sn]
	     je end_check

	     push ecx

	     mov cl,byte[eax]
	     cmp cl,byte[ebx]
             jne skipinc

             inc edx

	     skipinc: pop ecx
	     inc eax
	     inc ebx
             inc ecx

	     jmp while_check
	  
	end_check:
	           cmp edx,[sn]
		   jne notp

		   mov eax,msi1
		   call sprintLF
		   call exit

		   notp:
		         mov eax,msi2
			 call sprintLF

	call exit 
