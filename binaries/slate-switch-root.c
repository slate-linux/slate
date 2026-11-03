#define _GNU_SOURCE

#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mount.h>
#include <sys/reboot.h>
#include <unistd.h>

static void die(const char *msg)
{
    perror(msg);
    exit(1);
}

static void move_mount(const char *src, const char *dst)
{
    if (mount(src, dst, NULL, MS_MOVE, NULL) < 0)
        die("mount --move");
}

int main(int argc, char **argv, char **envp)
{
    const char *newroot;
    const char *init;
    char *const init_argv[] = { NULL };

    if (argc < 3) {
        fprintf(stderr, "usage: slate-switch-root NEWROOT INIT [ARGS...]\n");
        return 1;
    }

    newroot = argv[1];
    init = argv[2];

    /*
     * Make the new root our working directory.
     */
    if (chdir(newroot) < 0)
        die("chdir newroot");

    /*
     * Move the important virtual filesystems into the new root.
     */
    move_mount("/dev", "dev");
    move_mount("/proc", "proc");
    move_mount("/sys", "sys");

    /*
     * Change root.
     */
    if (chroot(".") < 0)
        die("chroot");

    if (chdir("/") < 0)
        die("chdir /");

    /*
     * Replace PID 1 with the real init.
     */
    execve(init, &argv[2], envp);

    die("execve init");
    return 1;
}
