;Dibuat Oleh Muhammad Reza Aulia Miftah
;NIM: G64154009
section .data
	
section .bss
	 
	
section .text

	_random_integer:
               
		   mov eax, 13
			push eax
			mov ebx, esp
			int 0x80
			
			pop eax

   ret                                


   _random_integer_with_modulo:
			mov ecx,eax
   		    push ecx
			   mov eax, 13
				push eax
				mov ebx, esp
				int 0x80
				
				pop eax
            pop ecx
            
            
            mov edx,0
            div ecx
            mov eax,edx
            


   ret
