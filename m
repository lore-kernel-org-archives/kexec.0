Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate1.uk.ibm.com ([194.196.100.161])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RJmb1-0006KL-Ib
	for kexec@lists.infradead.org; Fri, 28 Oct 2011 13:35:44 +0000
Received: from d06nrmr1507.portsmouth.uk.ibm.com
	(d06nrmr1507.portsmouth.uk.ibm.com [9.149.38.233])
	by mtagate1.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p9SDZbTD003640
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 13:35:37 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1507.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p9SDZbeA2543844
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 14:35:37 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p9SDZajT016999
	for <kexec@lists.infradead.org>; Fri, 28 Oct 2011 07:35:36 -0600
Message-ID: <1319808935.4558.2.camel@br98xy6r>
Subject: [PATCH] kexec-tools: s390: Fix memory detection for memory hotplug
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Fri, 28 Oct 2011 15:35:35 +0200
In-Reply-To: <20111026223126.GA9754@verge.net.au>
References: <1319563037.3056.30.camel@br98xy6r>
	<20111026223126.GA9754@verge.net.au>
Mime-Version: 1.0
Reply-To: holzheu@linux.vnet.ibm.com
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org, Vivek Goyal <vgoyal@redhat.com>

Hello Simon,

Here comes the patch...

On Thu, 2011-10-27 at 07:31 +0900, Simon Horman wrote:
> On Tue, Oct 25, 2011 at 07:17:17PM +0200, Michael Holzheu wrote:
> > To fix this I could parse /sys/devices/system/memory and exclude each
> > memory chunk that in not online from the /proc/iomem info. Do you think
> > that this approach is fine or is there a better solution?
> 
> Hi Michael,
> 
> that sounds like a reasonable approach to me.
> IIRC, kexec xen on ia64 makes use of an alternate iomem file,
> and this seems to be another example of /proc/iomem not being
> the right source of information.

From: Michael Holzheu <holzheu@linux.vnet.ibm.com>

Currently on s390 for memory detection only the "/proc/iomem" file is used.
This file does not include information on offlined memory chunks. With this
patch the memory hotplug information is read from "/sys/devices/system/memory"
and is added to the "/proc/iomem" info.

Also the MAX_MEMORY_RANGES count is increased to 1024 in order to support
systems with many memory holes.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 kexec/arch/s390/kexec-s390.c |  122 ++++++++++++++++++++++++++++++++++++++++++-
 kexec/arch/s390/kexec-s390.h |    3 -
 2 files changed, 123 insertions(+), 2 deletions(-)

--- a/kexec/arch/s390/kexec-s390.c
+++ b/kexec/arch/s390/kexec-s390.c
@@ -11,10 +11,13 @@
 #define _GNU_SOURCE
 #include <stddef.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include <errno.h>
 #include <stdint.h>
 #include <string.h>
 #include <getopt.h>
+#include <sys/types.h>
+#include <dirent.h>
 #include "../../kexec.h"
 #include "../../kexec-syscall.h"
 #include "kexec-s390.h"
@@ -23,6 +26,122 @@
 static struct memory_range memory_range[MAX_MEMORY_RANGES];
 
 /*
+ * Read string from file
+ */
+static void read_str(char *string, const char *path, size_t len)
+{
+	size_t rc;
+	FILE *fh;
+
+	fh = fopen(path, "rb");
+	if (fh == NULL)
+		die("Could not open \"%s\"", path);
+	rc = fread(string, 1, len - 1, fh);
+	if (rc == 0 && ferror(fh))
+		die("Could not read \"%s\"", path);
+	fclose(fh);
+	string[rc] = 0;
+	if (string[strlen(string) - 1] == '\n')
+		string[strlen(string) - 1] = 0;
+}
+
+/*
+ * Return number of memory chunks
+ */
+static int memory_range_cnt(struct memory_range chunks[])
+{
+	int i;
+
+	for (i = 0; i < MAX_MEMORY_RANGES; i++) {
+		if (chunks[i].end == 0)
+			break;
+	}
+	return i;
+}
+
+/*
+ * Create memory hole with given address and size
+ *
+ * lh = local hole
+ */
+static void add_mem_hole(struct memory_range chunks[], unsigned long addr,
+			 unsigned long size)
+{
+	unsigned long lh_start, lh_end, lh_size, chunk_cnt;
+	int i;
+
+	chunk_cnt = memory_range_cnt(chunks);
+
+	for (i = 0; i < chunk_cnt; i++) {
+		if (addr + size <= chunks[i].start)
+			break;
+		if (addr > chunks[i].end)
+			continue;
+		lh_start = MAX(addr, chunks[i].start);
+		lh_end = MIN(addr + size - 1, chunks[i].end);
+		lh_size = lh_end - lh_start + 1;
+		if (lh_start == chunks[i].start && lh_end == chunks[i].end) {
+			/* Remove chunk */
+			memmove(&chunks[i], &chunks[i + 1],
+				sizeof(struct memory_range) *
+				(MAX_MEMORY_RANGES - (i + 1)));
+			memset(&chunks[MAX_MEMORY_RANGES - 1], 0,
+			       sizeof(struct memory_range));
+			chunk_cnt--;
+			i--;
+		} else if (lh_start == chunks[i].start) {
+			/* Make chunk smaller at start */
+			chunks[i].start = chunks[i].start + lh_size;
+			break;
+		} else if (lh_end == chunks[i].end) {
+			/* Make chunk smaller at end */
+			chunks[i].end = lh_start - 1;
+		} else {
+			/* Split chunk into two */
+			if (chunk_cnt >= MAX_MEMORY_RANGES)
+				die("Unable to create memory hole: %i", i);
+			memmove(&chunks[i + 1], &chunks[i],
+				sizeof(struct memory_range) *
+				(MAX_MEMORY_RANGES - (i + 1)));
+			chunks[i + 1].start = lh_start + lh_size;
+			chunks[i].end = lh_start - 1;
+			break;
+		}
+	}
+}
+
+/*
+ * Remove offline memory from memory chunks
+ */
+static void remove_offline_memory(struct memory_range memory_range[])
+{
+	unsigned long block_size, chunk_nr;
+	struct dirent *dirent;
+	char path[PATH_MAX];
+	char str[64];
+	DIR *dir;
+
+	read_str(str, "/sys/devices/system/memory/block_size_bytes",
+		 sizeof(str));
+	sscanf(str, "%lx", &block_size);
+
+	dir = opendir("/sys/devices/system/memory");
+	if (!dir)
+		die("Could not read \"/sys/devices/system/memory\"");
+	while ((dirent = readdir(dir))) {
+		if (sscanf(dirent->d_name, "memory%ld\n", &chunk_nr) != 1)
+			continue;
+		sprintf(path, "/sys/devices/system/memory/%s/state",
+			dirent->d_name);
+		read_str(str, path, sizeof(str));
+		if (strncmp(str, "offline", 6) != 0)
+			continue;
+		add_mem_hole(memory_range, chunk_nr * block_size, block_size);
+	}
+	closedir(dir);
+}
+
+/*
  * Get memory ranges of type "System RAM" from /proc/iomem. If with_crashk=1
  * then also type "Crash kernel" is added.
  */
@@ -66,7 +185,8 @@ int get_memory_ranges_s390(struct memory
 		}
 	}
 	fclose(fp);
-	*ranges = current_range;
+	remove_offline_memory(memory_range);
+	*ranges = memory_range_cnt(memory_range);
 	return 0;
 }
 
--- a/kexec/arch/s390/kexec-s390.h
+++ b/kexec/arch/s390/kexec-s390.h
@@ -19,10 +19,11 @@
 #define OLDMEM_SIZE_OFFS      0x420
 #define COMMAND_LINE_OFFS     0x480
 #define COMMAND_LINESIZE      896
-#define MAX_MEMORY_RANGES     64
+#define MAX_MEMORY_RANGES     1024
 
 #define ALIGN_UP(addr, size) (((addr) + ((size)-1)) & (~((size)-1)))
 #define MAX(x, y) ((x) > (y) ? (x) : (y))
+#define MIN(x, y) ((x) < (y) ? (x) : (y))
 
 extern int image_s390_load(int, char **, const char *, off_t, struct kexec_info *);
 extern int image_s390_probe(const char *, off_t);




_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
