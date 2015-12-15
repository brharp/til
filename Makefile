
hello: hello.s
	gcc -nostdlib -g hello.s

hello2: hello.asm
	nasm -g -f elf hello.asm
	ld -s -o hello hello.o

