# Select your CPU type
# CPU = cortex-a72
CPU = cortex-a53

CC = gcc
VECTORIZE_CFLAGS = -fno-tree-vectorize
# VECTORIZE_CFLAGS = -ftree-vectorize -mvectorize-with-neon-quad -fdump-tree-vect -ftree-vectorizer-verbose=1
MATH_CFLAGS =  -ffast-math -ffinite-math-only -fno-math-errno \
 -fsingle-precision-constant
# UNROLL_CFGLAGS = -fno-unroll-loops

CFLAGS = -Wall -mfpu=crypto-neon-fp-armv8 -mfloat-abi=hard -mcpu=$(CPU) \
-O3 -Ofast -ggdb $(UNROLL_CFLAGS) $(MATH_CFLAGS) $(VECTORIZE_CFLAGS)

OBJECTS = n-body.o

.c.o:
	$(CC) $(CFLAGS) -c $<

.c.s:
	$(CC) $(CFLAGS) -S $<

n-body: $(OBJECTS)
	$(CC) $(CFLAGS) $(OBJECTS) -g -static -lrt -lm -o $@

clean:
	rm -f n-body $(OBJECTS) 
