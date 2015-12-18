

section .data
	help db "================================================================================",0x0a,	"Petunjuk Permainan : ",0x0a,"Berikut ini adalah langkah-langkah dalam memainkan Javanese World War :",0x0a,"1. Setelah Anda memilih Kategori Permainan maka Anda akan diberikan sebuah soal",0x0a,"2. Berikan jawaban terhadap soal pada kolom jawaban yang tersedia",0x0a,"3. Masukkan dengan angka Anda akan menebak jawaban pada kolom ke berapa",0x0a,"4. Kemudian masukkan huruf yang Anda tebak dg huruf KAPITAL",0x0a,"	Jika jawaban Benar, maka score akan bertambah 10",0x0a, "	Jika jawaban Salah, maka nyawa Anda akan berkurang dalam permaianan ini",0x0a," Dalam permaianan ini Anda diberikan 3 nyawa, apabila Anda salah dalam menjawab soal lebih dari 3 kali maka permainan akan berakhir.",0x0a,"5. Setelah semua kolom jawaban berhasil Anda tebak dengan benar, Anda dapat melanjutkan ke soal berikutnya",0x0a,"================================================================================",0x0a,"Senjata",0x0a,"Anda dapat menggunakan senjata dengan menukarkan score yang Anda miliki dengan menggunakan angka 9 setelah Anda memilih kolom yang akan Anda jawab. Ada berbagai macam senjata yang dapat Anda gunakan sesuai dengan score yang Anda miliki.",0x0a,"================================================================================",0x0a,"Tekan Enter untuk Kembali Ke Main Menu",0x0a,"================================================================================",0x0a
	len_help dd $-help
	
section .text

jmp not_help

 _show_help:
	push help
	
	call _print_function
	call _scan_function
 ret

 not_help:
