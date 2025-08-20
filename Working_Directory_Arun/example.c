if (strcmp(enteredPassword, correctPassword) != 0) {
        printf("Incorrect password. Try again.\n");
    } else {
        secret_function();
    }


if (strcmp(enteredPassword, correctPassword) == 0) {
        secret_function();
        
    } else {
        printf("Incorrect password. Try again.\n");
    }