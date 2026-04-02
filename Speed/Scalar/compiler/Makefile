CC = gcc

# Select one based on AArch
CFLAGS_FLOAT = # AArch64
# CFLAGS_FLOAT = -mfloat-abi=hard  -mfpu=crypto-neon-fp-armv8 # for AArch32

# Select based on CPU
CFLAGS_CPU = -mcpu=cortex-a72
# CFLAGS_CPU = -mcpu=cortex-a53

CFLAGS = -c -Wall -g -ggdb -O3 $(CFLAGS_FLOAT) $(CFLAGS_CPU)

PROF =  -pg -g # Add for gprof $(PROF)


%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

%.s: %.c
	$(CC) $(CFLAGS) -S -fverbose-asm $<

opts: opts.o
	$(CC) opts.o -lrt -lm -static -o $@

clean:
	rm -f *.o opts *.s
