#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <cuda_runtime.h>

/*
    Args:
        lectura :
*/
__global__ void wavelet_transform(int *lectura)
{
    
}


int main(int argc, char *argv[])
{
    // ########## VALIDACION ##########
    if (argc < 2)
    {
        printf("Usage: ./prog <rt> <bl>\n"
            "rt (route)     <STR>\n"
            "bl (blockSize) <INT>");
        return 1;
    }

    // ########## ARGUMENTOS ##########
    String routeMP3 = argv[1];
    int bl = atoi(argv[2]);

    // ########## MEMORIA CPU ##########
    int *outputCPU = (int *)malloc(sizeof(int) * width * height);
    initArray(outputCPU, width, height);
    
    // ########## MEMORIA GPU ##########
    int *outputGPU;
    cudaMalloc((void **)&outputGPU, sizeof(int) * width * height);

    // ########## CPY CPU~GPU ##########
    cudaMemcpy(outputGPU, outputCPU, sizeof(int) * width * height, cudaMemcpyHostToDevice);

    // ########## GRID & BLOCKS ##########
    dim3 gridSize(4, 1);    // Grid con 4 bloques
    dim3 blockSize(1, 1);   // Bloque con 1 hilo

    // ########## KERNEL ##########
    wavelet_transform<<<gridSize, blockSize>>>(outputGPU);
    
    // ########## CPY GPU~CPU ##########
    cudaMemcpy(outputCPU, outputGPU, sizeof(int) * n * n, cudaMemcpyDeviceToHost);

    // Display Informacion


    // Liberando memoria
    free(outputCPU);
    cudaFree(outputGPU);

    return 0;
}
