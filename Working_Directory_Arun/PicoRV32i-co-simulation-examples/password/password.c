#include <stdio.h>
#include <string.h>

void secret_function() {
    printf("Access granted. The ID requested is 3528712754.\n");
}

int main() {
    char correctPassword[] = "pass$123";
    char enteredPassword[20];

    // Prompt the user to enter the password
    printf("Input the password: ");
    scanf("%s", enteredPassword);

    // Check if the entered password is correct
    if (strcmp(enteredPassword, correctPassword) == 0) {
        secret_function();
        
    } else {
        printf("Incorrect password. Try again.\n");
    }

    return 0;
}
