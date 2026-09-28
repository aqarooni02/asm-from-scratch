#include <stdio.h>

ssize_t read_line(char * buf, size_t count);

int main() {
    char buf[100];
    ssize_t bytesread = read_line(buf, sizeof(buf));
    printf("bytes read: %zd\n", bytesread);
    printf("buf with nul byte: %s", buf);
    bytesread = read_line(buf, sizeof(buf));
    printf("bytes read: %zd\n", bytesread);
    printf("buf with nul byte: %s", buf);
    return 0;
}
