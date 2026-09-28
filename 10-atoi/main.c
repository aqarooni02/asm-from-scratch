#include <stdio.h>
#include <inttypes.h>
int64_t atoi(char *);

int main() {
    char *num = "1234";
    
    printf("%d\n",atoi(num) + 100); 

    return 0;
}
