#include <stdio.h>

int main(int ac, char **av)
{
    int c;
    while ((c = getchar()) != EOF) {
        if ((c & 0x80) || c == 12)
            printf("[[%02X]]", c);
        else
            putchar(c);
    }
}