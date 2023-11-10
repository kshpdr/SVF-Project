#include <stdio.h>

// Function to add two numbers
double add(double a, double b) {
    return a + b;
}

// Function to subtract two numbers
double subtract(double a, double b) {
    return a - b;
}

double mutiply(double a, double b) {
    return a * b;
}

int main() {
    // Declare variables to store user input and the result
    double num1, num2, sum, difference;
    scanf("%lf", &num1);
    scanf("%lf", &num2);
    for(int i = 0; i<num1; i++)
    {
        sum = add(num1, num2);
    }

    // Call the subtract function and store the result in the difference variable
    difference = subtract(num1, num2);
    return 0;
}