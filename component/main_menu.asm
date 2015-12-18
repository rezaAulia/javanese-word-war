

section .data
	menu db "|1.| Mulai Main",10,"|2.| Bantuan",0x0a,"|3.| Keluar",0x0a,"================================== Pilih Menu: =================================",0x0a
	len_menu dd $-menu
	_repeat db "Pilihan tidak ditemukan:",0x0a
	_len_repeat dd $-_repeat

	
section .text
	call _game_title
	


	_main_menu:
		
		
		push menu
		
		call _print_function
		call _scan_function

		_main_menu_selection:
		mov eax, DWORD[sentence]
		mov ebx, '3'
		cmp eax,ebx
		je exit
		mov ebx,'2'
		cmp ebx,eax
		je _help
		
		mov ebx,'1'
		cmp ebx,eax
		je _start_game
		
		
		jmp _option_not_found
			
	    _help:
		    call _show_help
		    jmp _main_menu


		_option_not_found:
			push _repeat
			
			call _print_function
			call _scan_function
			jmp _main_menu_selection


		_high_score: