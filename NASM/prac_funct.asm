stop:
     mov eax,1
     mov ebx,0
     int 80h
     ret



str_length:
            push ebx
	    push ecx
	    push edx

            mov ebx,eax

	    while_str:
	               cmp byte[eax],0
		       je stop_len

		       inc eax
		       jmp while_str

      stop_len:
                sub eax,ebx
		pop edx
		pop ecx
		pop ebx
	ret

;--------------------------
; Print string
;-----------------------
print_str:
            push ebx
	    push ecx
	    push edx
            push eax

	    call str_length
	    mov edx,eax
	    pop eax
	    mov ecx,eax
	    mov eax,4
	    mov ebx,1
	    int 80h

	   pop edx
	   pop ecx
	   pop ebx
	 ret  
	     

print_strl:
            pusha

	    call print_str

	    mov eax,0ah
	    push eax

	    mov eax,esp
	    call print_str

	    pop eax

	    popa
	  ret  


;---------------------------
;  String to num addr in EAX
;----------------------------
string_to_num:
              push eax
	      push ebx
	      push edx

	       xor ecx,ecx

	     conv_while:
	                cmp byte[eax],0ah
			je fin_conv

			movzx edx,byte[eax]
			sub edx,48

			imul ecx,10
			add ecx,edx

			inc eax
			jmp conv_while

          fin_conv:
	            pop edx
		    pop ebx
		    pop eax

		    ret




;---------------------
; Print integer
;---------------------

print_int:
            
	    ; number is in eax
	    pusha 
            xor ecx,ecx
            mov ebx,10
	     
	    while_int:
	                inc ecx
	                
                        xor edx,edx
			div ebx

			add edx,48
			push edx
                        
			cmp eax,0
			je fin_int

			jmp while_int

	  fin_int:
	           dec ecx           
		   mov eax,esp
		   call print_str

		   pop eax

		   cmp ecx,0
		   je end_print
		   jmp fin_int

      end_print:popa
      ret

;-------------------------
; read array
;----------------------------
; base address in esi

read_arr:
          pusha

	  mov eax,3
	  mov ebx,0
	  mov ecx,num
	  mov edx,len
	  int 80h

	  mov eax,num
	  call string_to_num

	  mov [num],ecx
          xor eax,eax

       while_read:
                  cmp eax,[num]
		  je end_read
                  
		  push eax
		  mov eax,3
		  mov ebx,1
		  mov ecx,a
		  mov edx,lena
		  int 80h
		  pop eax
                  
		  push eax
		  mov eax,a
		  call string_to_num
		  pop eax
		  mov dword[esi+4*eax],ecx

		  inc eax
		  jmp while_read

  end_read:
             popa
	     ret




print_arr:
          pusha

	xor ecx,ecx
	while_print:
	            cmp ecx,[num]
		    je end_pri

                    mov eax,dword[esi+4*ecx]
		    call print_int
                    
		    mov eax,32
		    push eax
		    mov eax,esp
		    call print_str
		    pop eax


		    inc ecx 
		    jmp while_print
  end_pri :
               popa
	      ret
           



section .bss

lena : resb 10
len  : resb 10
a    : resb 10
num  : resb 10
          
           




