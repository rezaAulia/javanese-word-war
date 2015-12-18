section .data
  _choose_weapon_text db "Pilih Senjatamu:",0x0a,"Harga Menggunakan Skor yang telah diperoleh",0x0a,"1. Buka Kata Urutan Ganjil (Harga 50)",0x0a,"2. Buka Kata Urutan Genap (Harga 50)",0x0a,"3. Terjemahkan Petunjuk Soal (Harga 20)",0x0a,"4. Buka Huruf pertama dan Terakhir (Harga 10)",0x0a,"5. Lewati Soal Ini (Harga 100)",0x0a,"6. Tambah 3 Nyawa (Harga 100)",0x0a,"0. Kembali",0x0a,"Masukkan Pilihanmu",0x0a
  len_choose_weapon_text dd $-_choose_weapon_text
section .bss


section .text


_choose_weapon:
	push _choose_weapon_text
	call _print_function
	call _scan_function
	mov eax,[sentence]
	cmp eax,49
	je .pilihan1
	cmp eax,50
	je .pilihan2
	cmp eax,51
	je .pilihan3
	cmp eax,52
	je .pilihan4
	cmp eax,53
	je .pilihan5
	cmp eax,54
	je .pilihan6
	jmp .exit

	.pilihan1:
		mov eax, 50
		call _check_enough_score
		cmp eax,1
		je .cukup1
		jmp .exit
		.cukup1:
		call weapon1
	jmp .exit

	.pilihan2:
		mov eax, 50
		call _check_enough_score
		cmp eax,1
		je .cukup2
		jmp .exit
		.cukup2:
		call weapon2

	jmp .exit

	.pilihan3:
		mov eax, 20
		call _check_enough_score
		cmp eax,1
		je .cukup3
		jmp .exit
		.cukup3:
		call weapon3

	jmp .exit

	.pilihan4:
		mov eax, 10
		call _check_enough_score
		cmp eax,1
		je .cukup4
		jmp .exit
		.cukup4:
		call weapon4

	jmp .exit

	.pilihan5:
		mov eax, 100
		call _check_enough_score
		cmp eax,1
		je .cukup5
		jmp .exit
		.cukup5:
		call weapon5

	jmp .exit

	.pilihan6:
		mov eax, 100
		call _check_enough_score
		cmp eax,1
		je .cukup6
		jmp .exit
		.cukup6:
		call weapon6

	jmp .exit

	.exit:
ret

_check_enough_score:
	cmp eax, [_total_score]
	jbe .cukup
	mov eax,0
	jmp .udah
	.cukup:
	mov ebx,[_total_score]
	sub ebx,eax
	mov [_total_score],ebx
	mov eax,1


	.udah:
ret


weapon1:



	mov ecx,0
	.loopArray:
		mov eax,ecx
		inc eax
		mov ebx,2
		mov edx,0
		div ebx
		cmp edx,0
		je .bukan
		mov eax,ecx
		mov ebx,4
		mul ebx
		mov ebx,eax
		push ecx
		mov eax,[_jawaban_soal_cur+ebx]
		;add eax,ebx
        mov [_underscore_soal_cur+ebx],eax
        mov eax,[_huruf_terjawab]
        inc eax
        mov [_huruf_terjawab],eax
	  	 pop ecx 	
		.bukan:
	  	
	  	inc ecx
	  	cmp ecx,[len_jawaban_soal_cur]
	  	jne .loopArray





ret

weapon2:



	mov ecx,0
	.loopArray:
		mov eax,ecx
		inc eax
		mov ebx,2
		mov edx,0
		div ebx
		cmp edx,0
		jne .bukan
		mov eax,ecx
		mov ebx,4
		mul ebx
		mov ebx,eax
		push ecx
		mov eax,[_jawaban_soal_cur+ebx]
		;add eax,ebx
        mov [_underscore_soal_cur+ebx],eax
        mov eax,[_huruf_terjawab]
        inc eax
        mov [_huruf_terjawab],eax
	  	 pop ecx 	
		.bukan:
	  	
	  	inc ecx
	  	cmp ecx,[len_jawaban_soal_cur]
	  	jne .loopArray





ret

weapon3:
	
 	lea edi, [_clue_1_soal_cur]
	 lea esi, [_clue_2_soal_cur]
  	 call _copy_string
	

	
	lea edi, [len_clue_1_soal_cur]
	 lea esi, [len_clue_2_soal_cur]
  	 call _copy_string


ret


weapon4:
	mov ecx,0
	.loopArray:
		mov edx,ecx
		inc edx
		cmp edx,1
		je .benar
		cmp edx,[len_jawaban_soal_cur]
		je .benar
		jmp .bukan
		.benar:
		mov eax,ecx
		mov ebx,4
		mul ebx
		mov ebx,eax
		push ecx
		mov eax,[_jawaban_soal_cur+ebx]
		;add eax,ebx
        mov [_underscore_soal_cur+ebx],eax
        mov eax,[_huruf_terjawab]
        inc eax
        mov [_huruf_terjawab],eax
	  	 pop ecx 	
	
	  	.bukan:
	  	inc ecx
	  	cmp ecx,[len_jawaban_soal_cur]

	  	jne .loopArray

ret

weapon5:
	lea edi, [_huruf_terjawab]
	 lea esi, [len_jawaban_soal_cur]
  	 call _copy_string
ret

weapon6:
	mov eax,[_life]
	add eax,3
	mov [_life],eax

ret