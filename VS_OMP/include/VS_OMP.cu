#include <omp.h>

#include <assert.h>
#include <cuda_runtime.h>
#include <stdio.h>

#define MAX 10

__global__ void kernel(int tid)
{
    printf("\n I am omp thread %d\n", tid);
}

int main()
{
    int count = 0;
#pragma omp parallel num_threads(MAX)
    {
#pragma omp atomic
        count++;
        kernel<<<1, 1>>>(omp_get_thread_num());
    }
    cudaDeviceSynchronize();
    printf_s("Number of threads: %d\n", count);
}