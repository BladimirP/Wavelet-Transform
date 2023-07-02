#include <iostream>
#include <vector>
#include <sndfile.h>

using namespace std;

int main(int argc, char *argv[])
{
    // ########## VALIDACION ##########
    // if (argc < 2)
    // {
    //     printf("Usage: ./prog <rt>\n"
    //            "rt (route) <STR>\n");
    //     return 1;
    // }

    const char *routeWAV = "Bangarang.wav";

    SF_INFO sfinfo;
    SNDFILE* sndfile;
    float* buffer;
    
    // Abrir el archivo de audio WAV
    sndfile = sf_open(routeWAV, SFM_READ, &sfinfo);
    if (!sndfile) {
        printf("Error al abrir el archivo: %s\n", routeWAV);
        return 1;
    }
    
    // Verificar si el archivo es mono o estéreo
    int channels = sfinfo.channels;
    printf("Número de canales: %i", channels);
    
    // Leer los valores de señal del archivo WAV
    buffer = new float[sfinfo.frames * channels];
    sf_readf_float(sndfile, buffer, sfinfo.frames);
    
    // Imprimir los valores de señal
    for (int i = 0; i < sfinfo.frames; i++) {
        for (int j = 0; j < channels; j++) {
            float value = buffer[i * channels + j];
            printf("Muestra  %i, Canal %i: %f\n", i, j, value);
        }
    }
    
    // Liberar memoria y cerrar el archivo
    delete[] buffer;
    sf_close(sndfile);
    
    return 0;
}