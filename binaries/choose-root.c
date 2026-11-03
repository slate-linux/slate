#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>

int main(void)
{
    int fd;
    char buf[256];
    int pos = 0;
    char c;

    fd = open("/dev/console", O_RDWR);
    if (fd < 0)
        return 1;

    write(fd, "\nChoose root device:\n> ", 23);

    while (pos < (int)sizeof(buf) - 1) {
        if (read(fd, &c, 1) != 1)
            continue;

        if (c == '\n' || c == '\r')
            break;

        buf[pos++] = c;
    }

    buf[pos] = '\0';

    write(fd, "\n", 1);

    printf("%s\n", buf);

    return 0;
}
