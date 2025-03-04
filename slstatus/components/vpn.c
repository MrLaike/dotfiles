/* See LICENSE file for copyright and license details. */
#include <ifaddrs.h>
#include <stdio.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <unistd.h>

#include "../slstatus.h"
#include "../util.h"

#define RSSI_TO_PERC(rssi) \
			rssi >= -50 ? 100 : \
			(rssi <= -100 ? 0 : \
			(2 * (rssi + 100)))

#include <limits.h>
#include <linux/wireless.h>

#define NET_OPERSTATE "/sys/class/net/%s/operstate"

const char *
vpn(const char *interface)
{
	int cur;
	size_t i;
	char *p, *datastart;
	char path[PATH_MAX];
	char status[5];
	FILE *fp;

	if (esnprintf(path, sizeof(path), NET_OPERSTATE, interface) < 0)
		return NULL;
	if (!(fp = fopen(path, "r"))) {
		return NULL;
	}

	return "󰌆 ";
}

