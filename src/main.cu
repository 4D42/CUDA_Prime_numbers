#include "stdio.h"

__global__ void isprime(int *test_number, int *boolprime){

  int dividedby = threadIdx.x + blockIdx.x * blockDim.x; //Compute the number wich the test_number will be divided by for each threards.

  if(dividedby > 1 && dividedby < *test_number){  // look to see if it's fine to do to test
    if(*test_number % dividedby == 0){*boolprime = 0;}
  }

}


int main(void){
  printf("Finding prime numbers using CUDA\n");

  int primelesserthan = 3000;
  int maxthreads = 1024;
  int Nb_blocks;
  int Nb_threads;

  int test_number, boolprime;  // host copies of test_number
  int *d_test_number, *d_boolprime;   // device copies of test_number

  cudaMalloc((void **)&d_test_number, sizeof(test_number)); // Allocate space for device copies of test_number
  cudaMalloc((void **)&d_boolprime, sizeof(boolprime));

  for(test_number = 2; test_number < primelesserthan; test_number++){

    boolprime = 1; //reset boolprime

    cudaMemcpy(d_test_number, &test_number, sizeof(test_number), cudaMemcpyHostToDevice);   // Copy data to device
    cudaMemcpy(d_boolprime, &boolprime, sizeof(boolprime), cudaMemcpyHostToDevice);

    // find the rigth number of blocks and threads

    if(test_number/maxthreads == 0){Nb_blocks = 1; Nb_threads = test_number;}
    else{Nb_blocks = test_number/maxthreads; Nb_threads = test_number%maxthreads;}


    isprime<<<Nb_blocks,Nb_threads>>>(d_test_number, d_boolprime);   // Launch add() kernel on GPU

    cudaDeviceSynchronize();
    cudaMemcpy(&boolprime,d_boolprime,sizeof(boolprime),cudaMemcpyDeviceToHost);

    // if(boolprime == 0){printf("%d is not prime\n",test_number);}
    // else{printf("%d is prime\n",test_number);}

    if(boolprime == 1){printf("%d is prime\n",test_number);}

  }


  return 0;
}
