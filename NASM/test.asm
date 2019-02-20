newline:
   mov eax,4
   mov ebx,1 
   mov ecx,nwl
   mov edx,1
   int 80h
 ret
;Goes to new line

exit: 
   mov eax,1
   mov ebx,0
   int 80h
  ret
;System call for exit

length:
   xor ecx,ecx
   repi:
    cmp byte[ebx],0ah
    je brk
    inc ebx
    inc ecx
    jmp repi  
 brk: ret  
;Finds length of a string

str_to_num:
   xor ecx,ecx
   repeat:
   cmp byte[ebx],0ah
   je break
   movzx edx,byte[ebx]
   inc ebx
   sub edx,48
   imul ecx,10
   add ecx,edx
   jmp repeat
    
 break: 
 mov edx,ecx
   ret
 ;Converts string to number

num_to_str:
  xor ebx,ebx
  mov ebx,10
  xor ecx,ecx
  mov ecx,char
  mov eax,dword[numb]
  for:
      cmp eax,0
      je stop
     ; xor ah,ah
      div ebx
      add edx,30h
     ; mov dl,byte[edx]
      mov byte[ecx],dl
      inc ecx
      jmp for
  stop: ret


    section .data
msg1 : db 'Enter a number',0ah
l1   : equ $-msg1
msg2 : db 'Enter another number',0ah
l2   : equ $-msg2
nwl  : db 0ah

    section .bss
l3 :   resb 1
l4 :   resb 1
n1 :   resb 10
nd1:   resd 1 ; Number of digits in first num
n2 :   resb 10
nd2:   resd 1 ; Number of digits in second num
junk : resb 1
len :  resb 1
numb:  resb 4
var :  resb 2
char:  resb 10 ; for converting num to a string

  section .text
global _start:
_start:
  mov eax,4
  mov ebx,1
  mov ecx,msg1
  mov edx,l1
 int 80h
 
 ;Read first number
  mov eax,3
  mov ebx,0
 mov ecx,n1
 mov edx,l3
 int 80h

 ;Find length of first number
 mov ebx,n1
 call length
 mov [nd1],ecx
 add ecx,30h
 add [numb],ecx
 mov ecx,numb
 mov eax,4
 mov ebx,1
 mov edx,2
 int 80h
 call newline 
 
 mov ebx,n1
 call str_to_num
 mov eax,4
 mov ebx,1
 mov byte[numb],0
 mov [numb],edx 
 mov ecx,numb     ;numb contains 50 if 50 is entered
 int 80h 

 call newline

 ;call num_to_str
 ;mov eax,4
 ;mov ebx,1
 ;mov ecx,char
 ;mov edx,[nd1]
 ;int 80h
 
 ;call newline 


mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,l2
int 80h

;Read second number
mov eax,3
mov ebx,0
mov ecx,n2
mov edx,l4
int 80h

;Find length of second number
mov ebx,n2
call length
mov [nd2],ecx


; Print first number
mov eax,4
mov ebx,1
mov ecx,n1
mov edx,[nd1]
int 80h

call newline

; Print second number
mov eax,4
mov ebx,1
mov ecx,n2
mov edx,[nd2]
int 80h

call exit

