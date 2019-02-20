;--------------------------
; NEWLINE FUNCTION
;--------------------------
newline:
     push eax
     push ebx
     push ecx
     push edx
     mov eax,4 
     mov ebx,1
     mov byte[vari],0ah
     mov ecx,vari
    ; mov ecx,0ah
     mov edx,1
     int 80h
     pop edx
     pop ecx
     pop ebx
     pop eax
  ret

;-----------------------
;EXIT FUNCTION
;Exit the program
;-----------------------
exit: 
     mov eax,1
     mov ebx,0
     int 80h
 ret

;--------------------------------------
; STRING LENGTH FUNCTION
;The function calculates string length
;---------------------------------------
slen:
       push ebx
       mov ebx,eax    ; The string address is in eax

    nextChar:
           cmp byte[eax],0
           jz finish
           inc eax
           jmp nextChar  
    finish:
          sub eax,ebx
          pop ebx     ; String length is in EAX
 ret

;-----------------------------------------
; PRINT STRING FUNCTION
;-----------------------------------------

sprint:
     push edx
     push ecx
     push ebx
     push eax   
     call slen
       
       mov edx,eax
       pop eax
       
       mov ecx,eax
       mov ebx,1
       mov eax,4
       int 80h
       
       pop ebx
       pop ecx
       pop edx
 ret       
  
;-------------------------------
;PRINT STRING AND GOTO NEWLINE
;-------------------------------
sprintLF:
     call sprint
     push eax
     mov eax,0ah
     push eax
     mov eax,esp
     call sprint
     pop eax
     pop eax
  ret

;---------------------------------
;CONVERT STRING TO A NUMBER
;---------------------------------

str_to_num:
     
     push eax
     push ebx
     push ecx

     xor ecx,ecx   ; Ans to be stored in ecx
     repi:
         cmp byte[eax],0ah  ; String address in eax
         je break
         movzx edx,byte[eax]
         inc eax
         sub edx,48
         imul ecx,10
         add ecx,edx
         jmp repi
      break:
     
     mov edx,ecx
     pop ecx
     pop ebx
     pop eax
  ret
   
;--------------------------------
; PRINT AN INTEGER
; EAX contains the number
;--------------------------------

printi:
       push eax
       push ebx
       push ecx
       push edx
       push esi
       mov ecx,0   ; Counter of how many bytes we need to print
      
  divideLoop:
       inc ecx
       mov edx,0
       mov esi,10
       idiv esi
       add edx,48
       push edx
       cmp eax,0
       jnz divideLoop

  printLoop:
       dec ecx
       mov eax,esp
       call sprint
       pop eax
       cmp ecx,0 
       jnz printLoop
       
       mov eax,space
       call sprint

       pop esi
       pop edx
       pop ecx
       pop ebx
       pop eax
   ret   
 
;---------------------------------
;        READ ARRAY
;--------------------------------
 
read_array:     ;ESI contains array base address
           pusha
	   ; Read number of elements
	   mov eax,3
	   mov ebx,0
	   mov ecx,n
	   mov edx,len
	   int 80h
           
           mov eax,n
	   call str_to_num  ;EDX will contain the num
           mov dword[n],edx ; [n] contains num of elements
           
	   xor ecx,ecx ; To keep a count of read elements
    read_while:
               
	       cmp ecx,dword[n]
               je end_read

	       pusha
	       mov eax,3
	       mov ebx,0
	       mov ecx,num
	       mov edx,len1
	       int 80h
	       popa

	       mov eax,num
	       call str_to_num

	       mov dword[num],edx
	       xor ebx,ebx
	       mov ebx,dword[num]

	       mov dword[esi+4*ecx],ebx
               inc ecx
               jmp read_while

	       end_read: popa
	       ret

;-------------------------------
;      PRINT ARRAY
;-------------------------------
; ESI contains array base address

print_array:
            pusha
            xor ecx,ecx

   print_while:
               cmp ecx,dword[n]
	       je end_print

	       xor ebx,ebx
	       mov ebx,dword[esi+4*ecx]
	       
	       mov eax,ebx

	       call printi

	       inc ecx
	       jmp print_while

           end_print: 
	   popa
     ret
	           

section .data
space : db ' ',0h

section .bss
vari : resb 1       
n    : resb 10
len  : resb 2 
num  : resb 10
len1 : resb 2


