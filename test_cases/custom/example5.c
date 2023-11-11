#include <stdio.h>

// Function to add two numbers
double add(double a, double b) {
    return a + b;
}

// Function to subtract two numbers
void sink(int data) {
    printf("Sink received: %d\n", data);
}

double multiply(double a, double b) {
    return a * b;
}

double difference(double a, double b) {
    return a - b;
}

int src() {
    // Declare variables to store user input and the result
    double num1, num2, sum, diff, mult;
    if(num1){
        add(num1, num2);
        sink(0);
    }else{
        multiply(num1, num2);
        sink(0);
    }
    return 0;
}

int main() {
    src();
    return 0;
}