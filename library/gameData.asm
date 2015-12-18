section .data
	_life_text db "| Life: "
	len_life_text dd $-_life_text

	_score_text db "=====================",0x0a,"| Score: "
	len_score_text dd $-_score_text

	heart_text db '[♥]'
    len_heart_text dd $-heart_text
    underscore_text db '_'
    len_underscore_text dd $-underscore_text
    _life dd 3
    _total_score dd 0
    len_total_score dd $-_total_score

    _weapon_text db "Tekan Angka 9 pada pilihan jawaban untuk mengakses persenjataan!",0x0a,"================================================================================",0x0a
    len_weapon_text dd $-_weapon_text

    _get_answer_column_text db "Pilih Kolom yang ingin dijawab",0x0a
    len_get_answer_column_text dd $-_get_answer_column_text

     _get_answer_char_text db "Masukkan huruf yang sekiranya menjadi jawaban anda untuk kolom tersebut",0x0a
    len_get_answer_char_text dd $-_get_answer_char_text
    
    _benar_text db "ANDA BENAR!!!!",0x0a
    len_benar_text dd $-_benar_text

     _not_valid_text db "PILIHAN ANDA TIDAK VALID",0x0a
    len_not_valid_text dd $-_not_valid_text

    _salah_text db "========== MAAF JAWABAN ANDA SALAH. SILAHKAN MENCOBA LAGI. ==========",0x0a
    len_salah_text dd $-_salah_text
    _game_over_text db "============================== GAME OVER =========================",0x0a,"Skor Anda: "
    len_game_over_text dd $-_game_over_text
	
    _selesai_soal_text db "============= SELAMAT ANDA MENYELESAIKAN SOAL ===============",0x0a,"JAWABAN DARI SOAL INI ADALAH:"
    len_selesai_soal_text dd $-_selesai_soal_text

    _selesai_soal_total_soal_text db "Total Soal Terselesaikan: "
    len_selesai_soal_total_soal_text dd $-_selesai_soal_total_soal_text
section .bss
	 _life_remaining_loop resb 255

	 _clue_1_soal_cur resb 255
    len_clue_1_soal_cur resd 255
	_clue_2_soal_cur resb 255
    len_clue_2_soal_cur resd 255
	_jawaban_soal_cur resd 255
	_underscore_soal_cur resd 255
	len_jawaban_soal_cur resd 255

	_input_column_from_user resd 255
	_input_char_answer_from_user resd 255
	_huruf_terjawab resd 255
	_total_soal_selesai resb 255
section .text

;argument pake int di eax
_print_life_remaining: 
push eax
push ebx
push ecx
push edx
	mov [_life_remaining_loop],eax
	push _life_text
	
	call _print_function
	
	.life_print_loop:
		mov eax,[_life_remaining_loop]
		dec eax
		mov [_life_remaining_loop],eax
		push heart_text
		

		call _print_function
		mov eax,[_life_remaining_loop]
		cmp eax,0
		jne .life_print_loop

pop eax
pop ebx
pop ecx
pop edx
ret

_print_score:
	
	push _score_text
	call _print_function
	mov eax,[_total_score]
	call printNum


ret

_print_header_game_status:
push eax
push ebx
push ecx
push edx
	mov eax,[_life]
	call _print_life_remaining
	call _new_line
	;mov eax,[_total_score]
	call _print_score
	call _new_line
	push _weapon_text
	
	call _print_function

	pop eax
pop ebx
pop ecx
pop edx

ret

;using eax
_increment_score:
	add eax,[_total_score]
	mov [_total_score],eax

ret

_reduce_heart:
	mov eax,[_life]
	dec eax
	mov [_life],eax
ret
_generate_underscore:
	mov eax,underscore_text
	call _print_char
ret


_generate_soal:
	
	push _clue_1_soal_cur
	call _print_function
	call _new_line
	mov ecx,0
	.loopArray:
		mov eax,ecx
		mov ebx,4
		mul ebx
		mov ebx,eax
		push ecx
		mov eax,_underscore_soal_cur
		add eax,ebx

	  	call _print_char
		
		call _white_space
	  	pop ecx


	  	inc ecx
	  	cmp ecx,[len_jawaban_soal_cur]
	  	jne .loopArray
	call _new_line
	
	

ret

_get_input_answer:
	push _get_answer_column_text
	call _print_function

	call _scan_function
	mov eax,[sentence]
	mov [_input_column_from_user],eax
	
	push _get_answer_char_text
	call _print_function
	call _scan_function
	mov eax,[sentence]
	mov [_input_char_answer_from_user],eax


ret


_check_answer:
	mov eax,[_input_char_answer_from_user]
	cmp eax,57
	je .getWeapon



	mov eax,[_input_column_from_user]
	dec eax
	mov ebx,[len_jawaban_soal_cur]
	add ebx,48
	cmp eax,ebx
	jae .notValid

	sub eax,48
	mov ebx,4
	mul ebx
	mov ebx,eax
	mov eax,[_underscore_soal_cur+ebx]
	cmp eax,95
	jne .notValid
	mov eax,_jawaban_soal_cur
	add eax,ebx
  	mov ebx,[eax]
  	cmp ebx,[_input_char_answer_from_user]
  
  	je .benar
	
  			call _reduce_heart
			push _salah_text
			call _print_function
  	jmp .exit
  	

  	.benar:
                        push _benar_text
			call _print_function
  			mov eax,[_input_char_answer_from_user]
			push eax
			mov eax,[_input_column_from_user]
			dec eax
			sub eax,48
			mov ebx,4
			mul ebx
			mov ebx,eax
			pop eax
	               	mov [_underscore_soal_cur+ebx],eax
  			mov eax,10
  			call _increment_score
			mov eax,[_huruf_terjawab]
			inc eax
			mov [_huruf_terjawab],eax
			jmp .exit
	.notValid:
			push _not_valid_text
			call _print_function
			jmp .exit

	.getWeapon:
			call _choose_weapon
			jmp .exit
			
  	.exit:
  		
	

ret

_game_over:
	push _game_over_text
	call _print_function
	call _print_score
	call _new_line


ret

_selesai_soal:
	push _selesai_soal_text
	call _print_function
	
	
	mov ecx,0
	.loopArray:
		mov eax,ecx
		mov ebx,4
		mul ebx
		mov ebx,eax
		push ecx
		mov eax,_jawaban_soal_cur
		add eax,ebx

	  	call _print_char
		
		call _white_space
	  	pop ecx


	  	inc ecx
	  	cmp ecx,[len_jawaban_soal_cur]
	  	jne .loopArray
	call _new_line
	push _selesai_soal_total_soal_text
	call _print_function
	mov eax,[_total_soal_selesai]
	inc eax
	call printNum
	mov [_total_soal_selesai],eax
	call _new_line
ret
