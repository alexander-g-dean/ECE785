# Select your CPU type
# CPU = cortex-a72
CPU = cortex-a53

CC = gcc
UNROLL_CFLAGS = # -fno-unroll-loops
# VECTORIZE_CFLAGS =  -fno-tree-vectorize
VECTORIZE_CFLAGS =  -ftree-vectorize -mvectorize-with-neon-quad

MATH_CFLAGS =  -ffast-math -ffinite-math-only -fno-math-errno \
 -fsingle-precision-constant

CFLAGS = -Wall -mfpu=crypto-neon-fp-armv8 -mfloat-abi=hard \
-mcpu=$(CPU) -O3 -Ofast -ggdb $(UNROLL_CFLAGS) $(VECTORIZE_CFLAGS) \
$(MATH_CFLAGS)

mandel: mandel.o
	$(CC) $(CFLAGS) $< -lrt -lm -o $@

mandel.s: mandel.c
	$(CC) $(CFLAGS) $< -S
#	$(CC) $(CFLAGS) -fverbose-asm -fopt-info-missed $< -S
#	$(CC) $(CFLAGS) -fopt-info-missed -fdump-rtl-final -fdump-tree-graph $< -S # -fverbose-asm $< -S

clean:
	rm -f *.o *.s mandel
