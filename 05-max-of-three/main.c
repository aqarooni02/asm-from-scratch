#include <stdio.h>
#include <inttypes.h>

int64_t maxofthree(int64_t , int64_t , int64_t );

int main() {
    printf("%ld\n", maxofthree(1, 3, 0));
    printf("%ld\n", maxofthree(12, 3, -123));
    printf("%ld\n", maxofthree(1, 3, 7));
    printf("%ld\n", maxofthree(1, 15, 0));
    return 0;
}
