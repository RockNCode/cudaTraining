#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>


__global__ void printThreadIds()
{
    printf("ThreadId.x = %d , ThreadId.y = %d , ThreadId.z = %d \n",
        threadIdx.x, threadIdx.y, threadIdx.z);
}

int main()
{
    int nx, ny;
    nx = 16;
    ny = 16;

    dim3 block(8, 8);
    dim3 grid(nx / block.x, ny / block.y);

    printThreadIds << <grid, block >> > ();
    cudaDeviceSynchronize();
    cudaError_t cudaStatus = cudaDeviceReset();
    if (cudaStatus != cudaSuccess) {
        fprintf(stderr, "cudaDeviceReset failed!");
        return 1;
    }

    return 0;
}
