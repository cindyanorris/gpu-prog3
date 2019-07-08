#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <cuda_runtime.h>
#include "d_colorToGreyscale.h"
#include "CHECK.h"

#define CHANNELS 3
__global__ void d_colorToGreyscaleKernel(unsigned char *, unsigned char *,
                                         int, int);
/*
   d_colorToGreyscale
   Performs the greyscale of an image on the GPU.
   Pout array is filled with the greyscale of each pixel.
   Pin array contains the color pixels.
   width and height are the dimensions of the image.
*/
float d_colorToGreyscale(unsigned char * Pout, unsigned char * Pin,
                        int width, int height)
{
    cudaEvent_t start_cpu, stop_cpu;
    float cpuMsecTime = -1;

    //Use cuda functions to do the timing 
    //create event objects
    CHECK(cudaEventCreate(&start_cpu));
    CHECK(cudaEventCreate(&stop_cpu));
    //record the starting time
    CHECK(cudaEventRecord(start_cpu));

    //Your work goes here and in the kernel below

    //record the ending time and wait for event to complete
    CHECK(cudaEventRecord(stop_cpu));
    CHECK(cudaEventSynchronize(stop_cpu));
    //calculate the elapsed time between the two events 
    CHECK(cudaEventElapsedTime(&cpuMsecTime, start_cpu, stop_cpu));
    return cpuMsecTime;
}

/*
   d_colorToGreyscaleKernel
   Kernel code executed by each thread on its own data when the kernel is
   launched.
   Pout array is filled with the greyscale of each pixel (one element per thread).
   Pin array contains the color pixels.
   width and height are the dimensions of the image.
*/
__global__
void d_colorToGreyscaleKernel(unsigned char * Pin, unsigned char * Pout,
                              int width, int height)
{

}
