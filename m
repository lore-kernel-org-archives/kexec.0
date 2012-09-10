Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from router-fw.net-space.pl ([89.174.63.77])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TB2d8-0001Y8-7C
 for kexec@lists.infradead.org; Mon, 10 Sep 2012 11:58:19 +0000
Received: from dev-00.local.net-space.pl ([192.168.1.5]:48176 "EHLO
 localhost.localdomain" TLS-CIPHER: <none>)
 by router-fw-old.local.net-space.pl with ESMTP id S1621611Ab2IJL5x
 (ORCPT <rfc822;kexec@lists.infradead.org>);
 Mon, 10 Sep 2012 13:57:53 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: [PATCH 7/7] xen: Fix Xen kdump support
Date: Mon, 10 Sep 2012 13:57:51 +0200
Message-Id: <1347278271-5211-8-git-send-email-daniel.kiper@oracle.com>
In-Reply-To: <1347278271-5211-7-git-send-email-daniel.kiper@oracle.com>
References: <1347278271-5211-1-git-send-email-daniel.kiper@oracle.com>
 <1347278271-5211-2-git-send-email-daniel.kiper@oracle.com>
 <1347278271-5211-3-git-send-email-daniel.kiper@oracle.com>
 <1347278271-5211-4-git-send-email-daniel.kiper@oracle.com>
 <1347278271-5211-5-git-send-email-daniel.kiper@oracle.com>
 <1347278271-5211-6-git-send-email-daniel.kiper@oracle.com>
 <1347278271-5211-7-git-send-email-daniel.kiper@oracle.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: konrad.wilk@oracle.com, andrew.cooper3@citrix.com, olaf@aepfle.de, jbeulich@suse.com, ptesarik@suse.cz, kexec@lists.infradead.org, xen-devel@lists.xensource.com

get_crash_memory_ranges() is unreliable under Xen. Proper machine
memory map could be obtained under Xen by calling __HYPERVISOR_memory_op
hypercall with XENMEM_machine_memory_map argument. get_crash_memory_ranges_xen()
does that. It is implemented using ioctl() or libxenctrl interface.
This solution is compatible with 3.x and 4.x Xen versions.

Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
---
 kexec/arch/i386/crashdump-x86.c |  203 ++++++++++++++++++++++++++++++++++++---
 1 files changed, 191 insertions(+), 12 deletions(-)

diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index c6b9354..09c3fd4 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -18,21 +18,41 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
+
+#define _XOPEN_SOURCE	600
+#define _BSD_SOURCE
+
+#include <fcntl.h>
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
 #include <errno.h>
 #include <limits.h>
 #include <elf.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
 #include "../../kexec.h"
 #include "../../kexec-elf.h"
 #include "../../kexec-syscall.h"
+#include "../../firmware_memmap.h"
 #include "../../crashdump.h"
 #include "kexec-x86.h"
 #include "crashdump-x86.h"
+
+#ifdef HAVE_LIBXENCTRL
+#ifdef HAVE_XC_GET_MACHINE_MEMORY_MAP
+#include <xenctrl.h>
+#else
+#define __XEN_TOOLS__	1
+#include <xen/xen.h>
+#include <xen/memory.h>
+#include <xen/sys/privcmd.h>
+#endif /* HAVE_XC_GET_MACHINE_MEMORY_MAP */
+#endif /* HAVE_LIBXENCTRL */
+
 #include <x86/x86-linux.h>
 
 extern struct arch_options_t arch_options;
@@ -273,6 +293,162 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
 	return 0;
 }
 
+#ifdef HAVE_LIBXENCTRL
+#ifdef HAVE_XC_GET_MACHINE_MEMORY_MAP
+static int get_crash_memory_ranges_xen(struct memory_range **range,
+					int *ranges, unsigned long lowmem_limit)
+{
+	int j, rc, ret = -1;
+	struct e820entry e820entries[CRASH_MAX_MEMORY_RANGES];
+	unsigned int i;
+#ifdef XENCTRL_HAS_XC_INTERFACE
+	xc_interface *xc;
+#else
+	int xc;
+#endif
+
+#ifdef XENCTRL_HAS_XC_INTERFACE
+	xc = xc_interface_open(NULL, NULL, 0);
+
+	if (!xc) {
+		fprintf(stderr, "%s: Failed to open Xen control interface\n", __func__);
+		goto err;
+	}
+#else
+	xc = xc_interface_open();
+
+	if (xc == -1) {
+		fprintf(stderr, "%s: Failed to open Xen control interface\n", __func__);
+		goto err;
+	}
+#endif
+
+	rc = xc_get_machine_memory_map(xc, e820entries, CRASH_MAX_MEMORY_RANGES);
+
+	if (rc < 0) {
+		fprintf(stderr, "%s: xc_get_machine_memory_map: %s\n", __func__, strerror(-rc));
+		goto err;
+	}
+
+	for (i = 0, j = 0; i < rc && j < CRASH_MAX_MEMORY_RANGES; ++i, ++j) {
+		crash_memory_range[j].start = e820entries[i].addr;
+		crash_memory_range[j].end = e820entries[i].addr + e820entries[i].size - 1;
+		crash_memory_range[j].type = xen_e820_to_kexec_type(e820entries[i].type);
+		segregate_lowmem_region(&j, lowmem_limit);
+	}
+
+	*range = crash_memory_range;
+	*ranges = j;
+
+	qsort(*range, *ranges, sizeof(struct memory_range), compare_ranges);
+
+	if (exclude_region(ranges, crash_reserved_mem.start,
+						crash_reserved_mem.end) < 0)
+		goto err;
+
+	ret = 0;
+
+err:
+	xc_interface_close(xc);
+
+	return ret;
+}
+#else
+static int get_crash_memory_ranges_xen(struct memory_range **range,
+					int *ranges, unsigned long lowmem_limit)
+{
+	int fd, j, rc, ret = -1;
+	privcmd_hypercall_t hypercall;
+	struct e820entry *e820entries = NULL;
+	struct xen_memory_map *xen_memory_map = NULL;
+	unsigned int i;
+
+	fd = open("/proc/xen/privcmd", O_RDWR);
+
+	if (fd == -1) {
+		fprintf(stderr, "%s: open(/proc/xen/privcmd): %m\n", __func__);
+		goto err;
+	}
+
+	rc = posix_memalign((void **)&e820entries, getpagesize(),
+			    sizeof(struct e820entry) * CRASH_MAX_MEMORY_RANGES);
+
+	if (rc) {
+		fprintf(stderr, "%s: posix_memalign(e820entries): %s\n", __func__, strerror(rc));
+		e820entries = NULL;
+		goto err;
+	}
+
+	rc = posix_memalign((void **)&xen_memory_map, getpagesize(),
+			    sizeof(struct xen_memory_map));
+
+	if (rc) {
+		fprintf(stderr, "%s: posix_memalign(xen_memory_map): %s\n", __func__, strerror(rc));
+		xen_memory_map = NULL;
+		goto err;
+	}
+
+	if (mlock(e820entries, sizeof(struct e820entry) * CRASH_MAX_MEMORY_RANGES) == -1) {
+		fprintf(stderr, "%s: mlock(e820entries): %m\n", __func__);
+		goto err;
+	}
+
+	if (mlock(xen_memory_map, sizeof(struct xen_memory_map)) == -1) {
+		fprintf(stderr, "%s: mlock(xen_memory_map): %m\n", __func__);
+		goto err;
+	}
+
+	xen_memory_map->nr_entries = CRASH_MAX_MEMORY_RANGES;
+	set_xen_guest_handle(xen_memory_map->buffer, e820entries);
+
+	hypercall.op = __HYPERVISOR_memory_op;
+	hypercall.arg[0] = XENMEM_machine_memory_map;
+	hypercall.arg[1] = (__u64)xen_memory_map;
+
+	rc = ioctl(fd, IOCTL_PRIVCMD_HYPERCALL, &hypercall);
+
+	if (rc == -1) {
+		fprintf(stderr, "%s: ioctl(IOCTL_PRIVCMD_HYPERCALL): %m\n", __func__);
+		goto err;
+	}
+
+	for (i = 0, j = 0; i < xen_memory_map->nr_entries &&
+				j < CRASH_MAX_MEMORY_RANGES; ++i, ++j) {
+		crash_memory_range[j].start = e820entries[i].addr;
+		crash_memory_range[j].end = e820entries[i].addr + e820entries[i].size - 1;
+		crash_memory_range[j].type = xen_e820_to_kexec_type(e820entries[i].type);
+		segregate_lowmem_region(&j, lowmem_limit);
+	}
+
+	*range = crash_memory_range;
+	*ranges = j;
+
+	qsort(*range, *ranges, sizeof(struct memory_range), compare_ranges);
+
+	if (exclude_region(ranges, crash_reserved_mem.start,
+						crash_reserved_mem.end) < 0)
+		goto err;
+
+	ret = 0;
+
+err:
+	munlock(xen_memory_map, sizeof(struct xen_memory_map));
+	munlock(e820entries, sizeof(struct e820entry) * CRASH_MAX_MEMORY_RANGES);
+	free(xen_memory_map);
+	free(e820entries);
+	close(fd);
+
+	return ret;
+}
+#endif /* HAVE_XC_GET_MACHINE_MEMORY_MAP */
+#else
+static int get_crash_memory_ranges_xen(struct memory_range **range,
+					int *ranges, unsigned long lowmem_limit)
+{
+	return 0;
+}
+#endif /* HAVE_LIBXENCTRL */
+
 static void segregate_lowmem_region(int *nr_ranges, unsigned long lowmem_limit)
 {
 	unsigned long long end, start;
@@ -724,10 +900,15 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 		return -1;
 	}
 
-	if (get_crash_memory_ranges(&mem_range, &nr_ranges,
-				    info->kexec_flags,
-				    elf_info.lowmem_limit) < 0)
-		return -1;
+	if (xen_present()) {
+		if (get_crash_memory_ranges_xen(&mem_range, &nr_ranges,
+						elf_info.lowmem_limit) < 0)
+			return -1;
+	} else
+		if (get_crash_memory_ranges(&mem_range, &nr_ranges,
+						info->kexec_flags,
+						elf_info.lowmem_limit) < 0)
+			return -1;
 
 	get_backup_area(info, mem_range, nr_ranges);
 
@@ -784,17 +965,15 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 
 	/* Create elf header segment and store crash image data. */
 	if (arch_options.core_header_type == CORE_TYPE_ELF64) {
-		if (crash_create_elf64_headers(info, &elf_info,
-					       crash_memory_range, nr_ranges,
-					       &tmp, &bufsz,
-					       ELF_CORE_HEADER_ALIGN) < 0)
+		if (crash_create_elf64_headers(info, &elf_info, mem_range,
+						nr_ranges, &tmp, &bufsz,
+						ELF_CORE_HEADER_ALIGN) < 0)
 			return EFAILED;
 	}
 	else {
-		if (crash_create_elf32_headers(info, &elf_info,
-					       crash_memory_range, nr_ranges,
-					       &tmp, &bufsz,
-					       ELF_CORE_HEADER_ALIGN) < 0)
+		if (crash_create_elf32_headers(info, &elf_info, mem_range,
+						nr_ranges, &tmp, &bufsz,
+						ELF_CORE_HEADER_ALIGN) < 0)
 			return EFAILED;
 	}
 	/* the size of the elf headers allocated is returned in 'bufsz' */
-- 
1.5.6.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
