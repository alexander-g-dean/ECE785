CC = gcc

# Select one based on AArch
CFLAGS_FLOAT = # AArch64
# CFLAGS_FLOAT = -mfloat-abi=hard  -mfpu=crypto-neon-fp-armv8 # for AArch32

# Select based on CPU
CFLAGS_CPU = -mcpu=cortex-a72
# CFLAGS_CPU = -mcpu=cortex-a53

UNROLL_CFLAGS = # -fno-unroll-loops
# VECTORIZE_CFLAGS =  -fno-tree-vectorize
VECTORIZE_CFLAGS =  -ftree-vectorize 

MATH_CFLAGS =  -ffast-math -ffinite-math-only -fno-math-errno \
 -fsingle-precision-constant

WARNINGS = # -Wno-unused-variable

CFLAGS = -c -Wall -g -ggdb -fno-omit-frame-pointer \
-O3 $(CFLAGS_FLOAT) $(CFLAGS_CPU) \
$(UNROLL_CFLAGS) $(VECTORIZE_CFLAGS) $(MATH_CFLAGS) $(WARNINGS)

OBJECTS = yuv.o image_proc.o ansi_escapes.o main.o is_options.o

imstab: $(OBJECTS)
	$(CC) $(OBJECTS) -g -static -lrt -lm -o $@
#	cp -f imstab ../imstab

.c.o:
	$(CC) $(CFLAGS) -c $<
.c.s:
	$(CC) $(CFLAGS) -S $<

clean:
	rm -f imstab $(OBJECTS) 

