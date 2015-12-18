
section .data
	game_title db "Javanese Word War",0x0a,"Sebuah Kata dapat Membuatmu sengsara!",0x0a
	len_game_title dd $-game_title
	
	new_line db "",0x0a
	len_new_line dd $-new_line
	_white_space_text db " "
	;clear db 27,'[H',27,'[2J',0

	;len_clear dd $-clear
	len_white_space_text dd $-_white_space_text
section .bss
	 sentence resb 256
	 len_sentence resb 1
	
section .text


	_game_title:
		push game_title
		call _print_function
		
	ret
	
	
_print_char:

	mov ecx,eax
	mov edx,1	
	mov eax, 4
	mov ebx, 1;stdout
	int 0x80;sys_write


ret

_print_function:
	push ebp 
	mov ebp,esp 
	mov ebx,[ebp+2*4]
	call _string_length
	mov edx,ecx	

	mov eax, 4;sys write
	mov ebx, 1;stdout
	;mov edx,[ebp+2*4]
	mov ecx,[ebp+2*4]
	int 0x80;sys_write
	pop ebp
ret 1*4


_string_length:
	len:
    mov ecx,0
    dec ebx
    count:
        inc ecx
        inc ebx
        cmp byte[ebx],0
        jnz count
    dec ecx
    dec ecx
ret


_new_line:
	push new_line
	call _print_function

ret

_scan_function:
	;scan dari stdin
	;sys call ke 3 --> sys read
	mov eax, 3
	mov ebx, 0 ;karena ngambil dari stdin
	mov ecx, sentence ;alamat buat nyimpen hasil scan an
	mov edx, len_sentence ;panjang char yg mau di scan
	int 0x80 ;jalanin sys_read
	dec     eax  ;convert 1-based length to 0-based pointer
	.loop:
	    cmp     byte [ecx + eax], 0xa
	    je      .chop
	    cmp     byte [ecx + eax], 0xc
	    je      .chop
	    cmp     byte [ecx + eax], 0xd
	    je      .chop
	.done:
	    inc     eax  ;convert pointer back to length
	    ret
	.chop:
	    mov     byte [ecx + eax], 0
	    dec     eax
	    jns     .loop
	    jmp     .done


_get_current_time:
	
ret


_copy_string:


 ;edi -> from
 ;esi ->to
	    cld
		.copy:
		    lodsb
		    stosb
		    test al, al
		    jnz .copy
ret

_copy_array:
	add edx, 1 ; the first 8 characters of the string are not wanted
	mov cl, 7
	.looping:
	mov ecx, [edx]
	mov [eax], ecx
	inc edx
	inc eax
	loop .looping


ret


_white_space:
	push _white_space_text
	call _print_function

ret

_clear_screen:
	;push clear
	;call _print_function

ret


