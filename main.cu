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
    if (argc < 2)
    {
        printf("Usage: ./marianisilver <./.../archivo.mp3>\n");
        return 1;
    }

    // Obteniendo argumentos de ejecucion
    String routeMP3 = argv[1];


    printf("Parameters ~ routeMP3 = %s\n", routeMP3);

    // Reservando Memoria CPU
    int *outputCPU = (int *)malloc(sizeof(int) * width * height);
    initArray(outputCPU, width, height);
    
    // Reservando memoria GPU
    int *outputGPU;
    cudaMalloc((void **)&outputGPU, sizeof(int) * width * height);

    // Copiar el array desde la CPU a CPU
    cudaMemcpy(outputGPU, outputCPU, sizeof(int) * width * height, cudaMemcpyHostToDevice);

    // Configuracion del Kernel
    dim3 gridSize(4, 1);    // Grid con 4 bloques
    dim3 blockSize(1, 1);   // Bloque con 1 hilo

    // LLamada al kernel wavelet_transform
    wavelet_transform<<<gridSize, blockSize>>>(outputGPU);
    
    // Copiando resultados de GPU a CPU
    cudaMemcpy(outputCPU, outputGPU, sizeof(int) * n * n, cudaMemcpyDeviceToHost);

    // Display Informacion


    // Liberando memoria
    free(outputCPU);
    cudaFree(outputGPU);

    return 0;
}
