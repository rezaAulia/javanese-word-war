
section .data
    header_category db "Kategori Permainan",0x0a
    len_header_category dd $-header_category
    category_list db "1.Kategori Umum",0x0a,"2.Kategori Wayang",0x0a,"0.Kembali ke Menu Utama",0x0a,"Pilih Kategori:",0x0a
    len_category_list dd $-category_list
   

    
section .bss
	
	

section .text
	
	_start_game:
		
		call _choose_category
		jmp exit






	_choose_category:
		push header_category
		
		call _print_function

		push category_list
		
		call _print_function
		call _scan_function
		mov eax, DWORD[sentence]
		mov ebx, '0'
		cmp eax,ebx
		je _main_menu
		mov ebx, '1'
		cmp eax,ebx
		je _start_kategori_umum
		mov ebx, '2'
		cmp eax,ebx
		je _start_kategori_wayang
	ret	


	_generate_new_game_data:
		mov eax,3
		mov [_life],eax
		mov eax,0
		mov [_total_score],eax
		mov [_total_soal_selesai],eax
	ret



