
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <termios.h>
#include <sys/ioctl.h>

static struct termios old_term;
static char **lines;
static int line_count;
static int offset;
static int height;

static void restore(void)
{
    tcsetattr(STDIN_FILENO, TCSAFLUSH, &old_term);
}

static void terminal_size(void)
{
    struct winsize ws;

    if (ioctl(STDOUT_FILENO, TIOCGWINSZ, &ws) == 0)
        height = ws.ws_row;
    else
        height = 24;

    if (height < 2)
        height = 2;
}

static void load_file(FILE *fp)
{
    char *line = NULL;
    size_t size = 0;
    ssize_t len;

    while ((len = getline(&line, &size, fp)) != -1) {
        char *copy = malloc(len + 1);
        if (!copy) {
            free(line);
            return;
        }

        memcpy(copy, line, len + 1);

        char **tmp = realloc(lines,
            sizeof(char *) * (line_count + 1));

        if (!tmp) {
            free(copy);
            free(line);
            return;
        }

        lines = tmp;
        lines[line_count++] = copy;
    }

    free(line);
}

static void draw(void)
{
    int i;

    printf("\033[H\033[2J");

    for (i = 0; i < height - 1; i++) {
        int index = offset + i;

        if (index < line_count)
            printf("%s", lines[index]);

        if (index >= line_count ||
            !strchr(lines[index], '\n'))
            printf("\033[K\n");
    }

    printf("\033[7m less: lines %d-%d of %d | q: quit \033[0m",
        offset + 1,
        offset + height - 1,
        line_count);

    fflush(stdout);
}

static void run(void)
{
    struct termios raw;
    char c;

    tcgetattr(STDIN_FILENO, &old_term);
    raw = old_term;

    raw.c_lflag &= ~(ICANON | ECHO);
    raw.c_iflag &= ~(IXON | ICRNL);
    raw.c_cc[VMIN] = 1;
    raw.c_cc[VTIME] = 0;

    tcsetattr(STDIN_FILENO, TCSAFLUSH, &raw);
    atexit(restore);

    terminal_size();
    draw();

    while (read(STDIN_FILENO, &c, 1) == 1) {
        switch (c) {
        case 'q':
            return;

        case 'j':
        case ' ':
            offset += c == ' ' ? height - 1 : 1;
            break;

        case 'k':
            offset--;
            break;

        case 'f':
            offset += height - 1;
            break;

        case 'b':
            offset -= height - 1;
            break;

        case 'g':
            offset = 0;
            break;

        case 'G':
            offset = line_count - height + 1;
            break;

        case '\033': {
            char seq[2];

            if (read(STDIN_FILENO, &seq[0], 1) != 1)
                break;
            if (read(STDIN_FILENO, &seq[1], 1) != 1)
                break;

            if (seq[0] == '[') {
                if (seq[1] == 'A')
                    offset--;
                else if (seq[1] == 'B')
                    offset++;
            }
            break;
        }

        default:
            break;
        }

        if (offset < 0)
            offset = 0;

        if (offset > line_count - height + 1)
            offset = line_count - height + 1;

        if (offset < 0)
            offset = 0;

        terminal_size();
        draw();
    }
}

int main(int argc, char **argv)
{
    FILE *fp = stdin;

    if (argc > 1) {
        fp = fopen(argv[1], "r");

        if (!fp) {
            perror(argv[1]);
            return 1;
        }
    }

    load_file(fp);

    if (fp != stdin)
        fclose(fp);

    if (!isatty(STDIN_FILENO) || !isatty(STDOUT_FILENO)) {
        for (int i = 0; i < line_count; i++)
            fputs(lines[i], stdout);
    } else {
        run();
    }

    for (int i = 0; i < line_count; i++)
        free(lines[i]);

    free(lines);
    return 0;
}

