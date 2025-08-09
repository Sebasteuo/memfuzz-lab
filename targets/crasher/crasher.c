#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(int argc,char**argv){
  if(argc < 2) return 0;
  FILE *f = fopen(argv[1],"rb"); if(!f) return 0;
  char buf[8]={0}; fread(buf,1,sizeof(buf),f); fclose(f);
  if (memcmp(buf,"CRASH!!!",8)==0){
    volatile int *p = 0; *p = 42; // intentional crash
  }
  return 0;
}
