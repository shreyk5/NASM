%include 'functions.asm'

section .data
msg1 : db 'Enter first number',0h
l1   : equ $-msg1
msg2 : db 'Enter second number',0h
l2   : equ $-msg2
even : db 'Number is even',0h
odd  : db 'Number is odd',0h


section .bss
var :  resb 10
l3   :  resb  1
l4   :  resb  1
num1 : resb 10
num2 : resb 10
section .text
global _start:
_start:
   
   mov eax,msg1
   call sprint
   
   mov eax,3
   mov ebx,0
   mov ecx,num1
   mov edx,l3
   int 80h
      
   mov eax,msg2
   call sprint

   mov eax,3
   mov ebx,0
   mov ecx,num2
   mov edx,l4
   int 80h
   
   ; [num1] stores first value entered
   mov eax,num1
   call str_to_num
   mov [num1],edx
   
   ; [num2] stores second value
   mov eax,num2
   call str_to_num
   mov [num2],edx
   
   ;Now we have both the numbers

   ;--------------------------
   ; BELOW COMAPRES 2 NUMBERS
   ;------------------------- 
  ; xor ecx,ecx
  ; mov ecx,[num1]
  ; xor edx,edx
  ; mov edx,[num2]
  ; cmp ecx,edx
   
  ; ja if
   ;  mov eax,[num2]
    ; call printi
   ;  jmp skip
   ;if: mov eax,[num1]
    ;   call printi
  ; skip:
  ;--------------------------


  ;------------------------
  ; EVEN ODD
  ;------------------------
  ;mov ax,word[num1]
  ;mov bl,2
  ;div bl
  
  ;cmp ah,0
  ;je skip
  ;mov eax,odd
  ;call sprintLF
  ;jmp go  

  ;skip:
  ;mov eax,even
  ;call sprintLF
  ; go:
  ;---------------------------
  
  ;-----------------------------
  ; GCD FUNCTION
  ;-----------------------------
  
   mov ecx,[num2] ; Value b
   mov eax,[num1] ;Value a

  while:
       cmp ecx,0
       je skip
       mov edx,0  ; edx:eax is divided by ecx
       div ecx    ;eax contains the q and edx the remainder 
       mov eax,ecx ; a=b
       mov ecx,edx    ; b=r
       jmp while   
    skip:
    ; ANSWER WILL BE IN EAX
   
   call printi 
   


 call exit

   
