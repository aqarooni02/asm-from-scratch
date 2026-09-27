print_int: print_int.o main.c
	gcc -no-pie main.c print_int.o -o print_int

print_int.o: print_int.asm
	nasm -felf64 print_int.asm -o print_int.o

clean:
	rm -f print_int print_int.o

.PHONY: clean
