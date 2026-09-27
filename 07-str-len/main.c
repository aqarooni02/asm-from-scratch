#include <inttypes.h>
#include <stdio.h>

uint64_t str_len(char *);

int main() {
    uint64_t len = str_len("Hello");
    printf("%lu\n", len);
    return 0;
}
