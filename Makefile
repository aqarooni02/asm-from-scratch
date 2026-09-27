SUBDIRS = 01-hello-gas 02-hello-nasm 03-fibonacci 04-print-int 05-max-of-three

.PHONY: all clean $(SUBDIRS)

all: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@

clean:
	for d in $(SUBDIRS); do $(MAKE) -C $$d clean; done
