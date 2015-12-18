

section .data
	_kategori_umum_header db "Mulai Bermain Dengan Kategori Umum",0x0a
	len_kategori_umum_header dd $-_kategori_umum_header
	
section .text

jmp not_umum

 _start_kategori_umum:
	
 	call _generate_new_game_data
	push _kategori_umum_header
	call _print_function
	
	.soal_berikutnya: 
	call _get_word_umum
	.jawab_berikutnya:
	call _print_header_game_status

	call _generate_soal
	call _get_input_answer
	call _check_answer
	mov eax,0
	cmp eax,[_life]
	
	je .gameover
	mov eax,[_huruf_terjawab]
	cmp eax,[len_jawaban_soal_cur]
	je .selesai_soal
	jmp .jawab_berikutnya
	.selesai_soal:
		call _selesai_soal
		jmp .soal_berikutnya
	.gameover:
	call _game_over
	call _main_menu
 ret

 not_umum:
