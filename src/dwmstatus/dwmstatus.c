#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>
#include <dirent.h>
#include <X11/Xlib.h>

void get_cpu(char *buf, size_t size) {
    FILE *file = fopen("/proc/loadavg", "r");
    if (!file) {
        snprintf(buf, size, "  CPU  ?  ");
        return;
    }
    double load;
    fscanf(file, "%lf", &load);
    fclose(file);
    snprintf(buf, size, "  CPU  %.2f  ", load);
}

void get_mem(char *buf, size_t size) {
    FILE *file = fopen("/proc/meminfo", "r");
    if (!file) {
        snprintf(buf, size, "     ?  ");
        return;
    }

    long mem_total = 0, mem_available = 0;
    char label[64];
    long value;
    char unit[16];

    while (fscanf(file, "%63s %ld %15s\n", label, &value, unit) == 3) {
        if (strcmp(label, "MemTotal:") == 0) {
            mem_total = value;
        }
        else if (strcmp(label, "MemAvailable:") == 0) {
            mem_available = value;
            break;
        }
    }
    fclose(file);

    long used = mem_total - mem_available;
    double used_gb = used / (1024.0 * 1024.0);
    snprintf(buf, size, "     %.1fG  ", used_gb);
}

void get_wlan(char *buf, size_t size) {
    DIR *netdir = opendir("/sys/class/net");
    if (!netdir) {
        snprintf(buf, size, "  󰤭  Disconnected  ");
        return;
    }

    struct dirent *ent;
    char path[256];
    char state[32];
    int connected = 0;
    while ((ent = readdir(netdir))) {
        if (strncmp(ent->d_name, "wl", 2) != 0) {
            continue;
        }
        snprintf(path, sizeof(path), "/sys/class/net/%s/operstate", ent->d_name);
        FILE *state_file = fopen(path, "r");
        if (!state_file) {
            continue;
        }
        if (fgets(state, sizeof(state), state_file) && strncmp(state, "up", 2) == 0) {
            connected = 1;
        }
        fclose(state_file);
        break;
    }
    closedir(netdir);

    if (connected) {
        snprintf(buf, size, "  󰤨  Connected  ");
    } else {
        snprintf(buf, size, "  󰤭  Disconnected  ");
    }
}

void get_clock(char *buf, size_t size) {
    time_t t = time(NULL);
    struct tm *tm_info = localtime(&t);
    strftime(buf, size, "  󱑆  %a %b %d %I:%M %p  ", tm_info);
}

int main() {
    char cpu[64], mem[64], wlan[64], clockbuf[128], status[512];
    Display *display = XOpenDisplay(NULL);
    if (!display) {
        fprintf(stderr, "Cannot open display.\n");
        return 1;
    }

    Window root = DefaultRootWindow(display);
    while (1) {
        get_cpu(cpu, sizeof(cpu));
        get_mem(mem, sizeof(mem));
        get_wlan(wlan, sizeof(wlan));
        get_clock(clockbuf, sizeof(clockbuf));
        snprintf(status, sizeof(status), "%s%s%s%s", cpu, mem, wlan, clockbuf);

        // Update root window name
        XStoreName(display, root, status);
        XFlush(display);

        sleep(1);
    }

    XCloseDisplay(display);
    return 0;
}
