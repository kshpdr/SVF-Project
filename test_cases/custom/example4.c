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
    for(int i = 0; i<num1; i++)
    {
        sum = add(num1, num2);
        diff = difference(num1, num2);
        mult = multiply(num1, num2);
    }

    sink(0);
    return 0;
}

int main() {
    src();
    return 0;
}