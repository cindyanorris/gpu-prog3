NVCC = /usr/local/cuda-8.0/bin/nvcc
CC = g++
GENCODE_FLAGS = -arch=sm_30

#Optimization flags. Don't use this for debugging.
NVCCFLAGS = -c -m64 -O2 --compiler-options -Wall -Xptxas -O2,-v

#No optimizations. Debugging flags. Use this for debugging.
#NVCCFLAGS = -c -g -G -m64 --compiler-options -Wall

OBJS = greyscaler.o wrappers.o h_colorToGreyscale.o d_colorToGreyscale.o
.SUFFIXES: .cu .o .h 
.cu.o:
	$(NVCC) $(NVCCFLAGS) $(GENCODE_FLAGS) $< -o $@

all: greyscaler generate

greyscaler: $(OBJS)
	$(CC) $(OBJS) -L/usr/local/cuda/lib64 -lcuda -lcudart -ljpeg -o greyscaler

greyscaler.o: greyscaler.cu wrappers.h h_colorToGreyscale.h d_colorToGreyscale.h

h_colorToGreyscale.o: h_colorToGreyscale.cu h_colorToGreyscale.h CHECK.h

d_colorToGreyscale.o: d_colorToGreyscale.cu d_colorToGreyscale.h CHECK.h

wrappers.o: wrappers.cu wrappers.h

generate: generate.c
	gcc -O2 generate.c -o generate -ljpeg

clean:
	rm generate greyscaler *.o
