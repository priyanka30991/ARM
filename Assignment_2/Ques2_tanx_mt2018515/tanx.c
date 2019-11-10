#include <stdio.h>
#include <math.h>
int main()
{
    //printf("Hello World");
    float x=-1.5707;
    float y[500];
    int i;
    printf("\nx\t\ty\n");
    for(i=0;i<=10000;i++){
        y[i] = tan(x);
        printf("\t\t\n");
        printf("%f\t\t%f",x,y[i]);
        x = x+0.009;
        if(x > 1.5709) break;
    }

    return 0;
}
