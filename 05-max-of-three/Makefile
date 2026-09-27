maxofthree: maxofthree.o main.c
	gcc -no-pie main.c maxofthree.o -o maxofthree

maxofthree.o: maxofthree.asm
	nasm -felf64 maxofthree.asm -o maxofthree.o

clean:
	rm -f maxofthree maxofthree.o

.PHONY: clean
