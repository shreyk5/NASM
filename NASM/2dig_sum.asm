  section .data
msg1: db 'Enter a number',0ah
l1  :  equ $-msg1
msg2: db  'Enter second number',0ah
l2  :  equ $-msg2
nwl : db 0ah
  section .bss

num1: resb 2
num2: resb 2
n1  : resw 1
n2  : resw 1
junk: resb 1
d1  : resb 1
d2  : resb 1
d3  : resb 1
d4  : resb 1
var : resw 1
ans1: resb 1
ans2: resb 1
ans3: resb 1

  section .text

 global _start:
 _start:

;Prompt to read first num
mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,l1
int 80h

; Read first num
mov eax,3
mov ebx,0
mov ecx,num1
mov edx,2
int 80h

;Read enter
mov eax,3
mov ebx,0
mov ecx,junk
mov edx,1
int 80h

;Prompt to read second num
mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,l2
int 80h

;Read second number
mov eax,3
mov ebx,0
mov ecx,num2
mov edx,2
int 80h

;Again read enter
mov eax,3
mov ebx,0
mov ecx,junk
mov edx,1
int 80h

;Print num1
mov eax,4
mov ebx,1
mov ecx,num1
mov edx,2
int 80h

;Print newline
mov eax,4
mov ebx,1
mov ecx,nwl
mov edx,1
int 80h

;print num2
;mov eax,4
;mov ebx,1
;mov ecx,num2
;mov edx,2
;int 80h

;Separate the digits

;Stored d1
mov al,byte[num1]
mov byte[d1],al

sub al,al
;Stored d2
mov al,byte[num1+1]
mov byte[d2],al

sub al,al
;Stored d3
mov al,byte[num2]
mov byte[d3],al

sub al,al
;Stored d4
mov al,byte[num2+1]
mov byte[d4],al

sub byte[d1],30h
sub byte[d2],30h
sub byte[d3],30h
sub byte[d4],30h

mov al,byte[d1]
mov ah,0
mov bl,10
mul bl
mov bx,word[d2]
add ax,bx
mov word[n1],ax


sub ax,ax
sub bx,bx
mov al,byte[d3]
mov bl,10
mul bl          ; ax=al*bl
mov bx,word[d4]
add ax,bx

; Adding the 2 numbers
add ax,word[n1]

mov bl,100
mov ah,0
div bl

;First digit of the answer
add al,30h
mov byte[ans1],al

mov byte[var],ah
mov ax,word[var]

;Now separating the remainder to the second and third digit
mov bl,10
div bl
add al,30h
add ah,30h
mov byte[ans2],al
mov byte[ans3],ah

mov eax,4
mov ebx,1
mov ecx,ans1
mov edx,1
int 80h

mov eax,4
mov ebx,1
mov ecx,ans2
mov edx,1
int 80h

mov eax,4
mov ebx,1
mov ecx,ans3
mov edx,1
int 80h

mov eax,1
mov ebx,0
int 80h
