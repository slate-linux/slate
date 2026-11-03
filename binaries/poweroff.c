#include <stdio.h>
#include <unistd.h>
#include <sys/reboot.h>
#include <linux/reboot.h>

int main(void)
{
    sync();

    if (reboot(LINUX_REBOOT_CMD_POWER_OFF) != 0) {
        perror("poweroff");
        return 1;
    }

    return 0;
}
