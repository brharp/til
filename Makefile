
hello: hello.asm
	nasm -f elf hello.asm
	ld -s -o hello hello.o

