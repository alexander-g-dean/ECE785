CC = gcc

# Select one based on AArch
CFLAGS_FLOAT = # AArch64
# CFLAGS_FLOAT = -mfloat-abi=hard  -mfpu=crypto-neon-fp-armv8 # for AArch32

# Select based on CPU
CFLAGS_CPU = -mcpu=cortex-a72
# CFLAGS_CPU = -mcpu=cortex-a53


UNROLL_CFLAGS = # -fno-unroll-loops
VECTORIZE_CFLAGS =  -fno-tree-vectorize
# VECTORIZE_CFLAGS =  -ftree-vectorize # -mvectorize-with-neon-quad

MATH_CFLAGS =  -ffast-math -ffinite-math-only -fno-math-errno \
 -fsingle-precision-constant


CFLAGS = -c -Wall -g -ggdb -O3 $(CFLAGS_FLOAT) $(CFLAGS_CPU) \
$(UNROLL_CFLAGS) $(VECTORIZE_CFLAGS) $(MATH_CFLAGS)

neon0: main.o
	$(CC) main.o -g -static -lrt -lm -o $@

main_list.s: main.c
	$(CC) $(CFLAGS) -Wa,-adhln -g main.c -c > main_list.s

clean:
	rm -f test *.o  *.s
