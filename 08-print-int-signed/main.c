#include <inttypes.h>

void print_int_signed(int64_t n);

int main(){
    print_int_signed(-123);
    print_int_signed(123);
    print_int_signed(2312-10000);
    return 0;
}
