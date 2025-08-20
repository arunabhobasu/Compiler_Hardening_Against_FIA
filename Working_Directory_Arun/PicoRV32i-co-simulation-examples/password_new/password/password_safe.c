#include <stdio.h>
#include <string.h>

void secret_function() {
    printf("Access granted. The ID requested is 3528712754.\n");
}

int main() {
    char correctPassword[] = "pass$123";  // Set the correct password
    char enteredPassword[20];  // Variable to store the user-entered password

    // Prompt the user to enter the password
    printf("Input the password: ");
    scanf("%s", enteredPassword);

    // Check if the entered password is correct
    if (strcmp(enteredPassword, correctPassword) != 0) {
        printf("Incorrect password. Try again.\n");
    } else {
        secret_function();
    }

    return 0;  // Indicate successful program execution
}
