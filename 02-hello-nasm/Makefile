hi: hi.o
	ld hi.o -o hi

hi.o: hi.asm
	nasm -f elf64 hi.asm -o hi.o

clean:
	rm -f hi hi.o

.PHONY: clean
