fib: fib.o
	gcc -no-pie fib.o -o fib

fib.o: fib.asm
	nasm -felf64 fib.asm -o fib.o

clean:
	rm -f fib fib.o

.PHONY: clean
