

section .data
	help db "BANTUAN",0x0a,"1.Help 1",0x0a,"2.Help 2",0x0a,"3.Help 3",0x0a,"4.Help 4",0x0a,"Tekan apapun untuk kembali ke menu",0x0a
	len_help dd $-help
	
section .text

jmp not_help

 _show_help:
	push help
	
	call _print_function
	call _scan_function
 ret

 not_help: