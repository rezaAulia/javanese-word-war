


section .text

global _start

	_start:
		
		
	
		%include "component/main_menu.asm"
		jmp not_get_function
		%include "component/start_game.asm"
		jmp not_get_function
		%include "component/help.asm"
		jmp not_get_function
		%include "component/game/umum.asm"
		jmp not_get_function
		%include "component/game/databaseUmum.asm"
		jmp not_get_function
		%include "component/game/wayang.asm"
		jmp not_get_function
		%include "component/game/databaseWayang.asm"
		jmp not_get_function
	





	

		
%include "library/regular_function.asm"
		jmp not_get_function
%include "library/printNum.asm"
		jmp not_get_function

%include "library/randomGenerator.asm"
		jmp not_get_function
%include "library/gameData.asm"
		jmp not_get_function
%include "library/weapon.asm"
		jmp not_get_function
	not_get_function:

	exit:
		mov eax, 1
		mov ebx, 0
		int 0x80



