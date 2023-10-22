#include <stdio.h>

void sink(int data) {
    printf("Sink received: %d\n", data);
}

void src() {
    int data = 42;
    sink(data);
}

int main() {
    src();
    return 0;
}
