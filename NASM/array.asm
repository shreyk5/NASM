
%include 'functions.asm'

section .data
 msg : db 'Enter the size of the array and array elements',0h


section .bss
k   : resb 10
l1  : resb 2
arr : resw 50
freq: TIMES 100 dw 0 


section .data
 global _start:
 _start:

    mov eax,msg
    call sprintLF

    mov esi,arr
    push esi
    call read_array
    
   ; mov eax,3
   ; mov ebx,0
   ; mov ecx,k
   ; mov edx,l1
   ; int 80h
    
   ; mov eax,k
   ; call str_to_num
    
   ; mov [k],edx
   ; mov eax,edx
    ;call printi
    pop esi
   mov edx,freq
    ;call print_array
    
    ;-------------------------------------------------
    ;  COMPARE ELEMENTS OF AN ARRAY WITH A VALUE k
    ;------------------------------------------------

  ;   xor ecx,ecx
   ; xor edx,edx
   ; mov eax,[k]

    ;g_while:
     ;       cmp ecx,dword[n]
;	    je g_finish

 ;           cmp  dword[esi+4*ecx],eax
;	    jna skip_c
            
;	    inc edx
;	    skip_c:
;	       inc ecx
;	       jmp g_while

 ;  g_finish:
  ;         mov eax,edx
;	   call printi
 ;------------------------------------------------------

;----------------------------------
;  NUMBERS DIVISIBLE BY 7
;----------------------------------
   
;   xor ebx,ebx
 ;  mov ebx,7
  ; xor ecx,ecx

   ;div_while:
    ;        cmp ecx,dword[n]
  ;	     je div_finish
  
  ;	     mov eax,dword[esi+4*ecx]
  ;	     xor edx,edx

  ;	     div ebx  ;edx will contain remainder
	     
  ;	     cmp edx,0
  ;	     jne skip_print
  
   ;          mov eax,dword[esi+4*ecx]
;	     call printi
                        
;	     skip_print:
;	        inc ecx
;		jmp div_while
 ;   div_finish:

;------------------------------------------------------------


;------------------------------------
; LARGEST AND SMALLEST
;-------------------------------------

mov eax,0      ; For maximum
mov ebx,10000  ; for minimum

xor ecx,ecx
  
  cmp_while:
            cmp ecx,dword[n]
	    je finish_cmp

           cmp eax,dword[esi+4*ecx]
	    ja skip_max

	    mov eax,dword[esi+4*ecx]
	  skip_max:
	    
	    cmp ebx,dword[esi+4*ecx]
	    jna skip_min

	    mov ebx,dword[esi+4*ecx]

	   skip_min:
	     
	     inc ecx
	     jmp cmp_while
	
  finish_cmp:
        
        call printi
	mov eax,ebx   ;EBX has smallest val
	call printi

;--------------------------------
; SECOND LARGEST NUM
;-------------------------------

;xor ebx,ebx
;xor ecx,ecx

 ; slargest:
  ;         cmp ecx,dword[n]
;	   je finish_slargest
           
;	   cmp dword[esi+4*ecx],eax
 ;          jnb skip_cmp

  ;         cmp ebx,dword[esi+4*ecx]
;	   ja skip_cmp

;	   mov ebx,dword[esi+4*ecx]

;	skip_cmp:
;	   inc ecx
;	   jmp slargest

 ;  finish_slargest:
  ;      mov eax,ebx
;	call printi


;-------------------------------------
; COUNT FREQUENCY
;-------------------------------------

;xor ecx,ecx

;traverse:
 ;           cmp ecx,dword[n]
  ;          je finish_trav

;	    mov ebx,dword[esi+4*ecx] ; esi->array
 ;           mov eax,dword[edx+4*ebx] ; edx->freq
;	    inc eax

;	    mov dword[edx+4*ebx],eax

;	    inc ecx
;	    jmp traverse

 ;  finish_trav:
             
;	     xor eax,eax ; to store num having max count
;	     xor ecx,ecx
;	     xor ebx,ebx ; max count

 ;      while_count:
  ;            cmp ecx,99
;	      je  finish_c
              
;	      cmp ebx,dword[edx+4*ecx]
 ;             ja skip_update

  ;            mov ebx,dword[edx+4*ecx]
;	      mov eax,ecx

;	   skip_update:
;	       inc ecx
;	       jmp while_count
     
;finish_c:     call printi



  mov eax,1
  mov ebx,0
  int 80h
