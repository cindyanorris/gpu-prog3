#include <stdio.h>
#include "h_colorToGreyscale.h"
#include "CHECK.h"

#define CHANNELS 3

/*
   h_colorToGreyscale
   Performs the greyscale of an image on the CPU.
   Pout array is filled with the greyscale of each pixel.
   Pin array contains the color pixels.
   width and height are the dimensions of the image.
*/
float h_colorToGreyscale(unsigned char * Pout, unsigned char * Pin,
                        int width, int height)
{

    int i, j, inIdx = 0, outIdx = 0;
    cudaEvent_t start_cpu, stop_cpu;
    float cpuMsecTime = -1;

    //Use cuda functions to do the timing 
    //create event objects
    CHECK(cudaEventCreate(&start_cpu));
    CHECK(cudaEventCreate(&stop_cpu));
    //record the starting time
    CHECK(cudaEventRecord(start_cpu));

    for (j = 0; j < height; ++j)
    {
        for (i = 0; i < width; i++, inIdx+=CHANNELS, outIdx++)
        {
            static unsigned char red, green, blue;
            red = Pin[inIdx];  
            green = Pin[inIdx + 1];  
            blue = Pin[inIdx + 2];  
            //one character in the output array is calculated based
            //upon three characters (one pixel) in the input array
            Pout[outIdx] = 0.21f*red + 0.71f*green + 0.07f*blue;
        }
    }

    //record the ending time and wait for event to complete
    CHECK(cudaEventRecord(stop_cpu));
    CHECK(cudaEventSynchronize(stop_cpu));
    //calculate the elapsed time between the two events 
    CHECK(cudaEventElapsedTime(&cpuMsecTime, start_cpu, stop_cpu));
    return cpuMsecTime;
}
