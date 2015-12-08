section .data
	hello:	db 'Hello, World!', 10
	hellolen:	equ $-hello

section .text
	global _start

_start:
	mov eax,4	; sys_write
	mov ebx,1	; stdout
	mov ecx,hello
	mov edx,hellolen
	int 80h
	mov eax,1	; sys exit
	mov ebx,0	; return code
	int	80h

	
