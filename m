Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp02.citrix.com ([66.165.176.63])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U8aOy-00074G-Ce
 for kexec@lists.infradead.org; Thu, 21 Feb 2013 17:57:52 +0000
From: David Vrabel <david.vrabel@citrix.com>
Subject: [PATCH 2/4] kexec/xen: require libxc from Xen 4.3
Date: Thu, 21 Feb 2013 17:57:38 +0000
Message-ID: <1361469460-18771-3-git-send-email-david.vrabel@citrix.com>
In-Reply-To: <1361469460-18771-1-git-send-email-david.vrabel@citrix.com>
References: <1361469460-18771-1-git-send-email-david.vrabel@citrix.com>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: xen-devel@lists.xen.org
Cc: Daniel Kiper <daniel.kiper@oracle.com>, kexec@lists.infradead.org, David Vrabel <david.vrabel@citrix.com>

From: David Vrabel <david.vrabel@citrix.com>

libxc from Xen 4.3 added xc_kexec_load() which will be required to
load images into Xen in the future.

Remove all the #ifdef'ery for older versions of libxc.

Signed-off-by: David Vrabel <david.vrabel@citrix.com>
---
 configure.ac                       |    5 +-
 kexec/arch/i386/crashdump-x86.c    |  109 ------------------------------------
 kexec/arch/i386/kexec-x86-common.c |  103 ----------------------------------
 kexec/crashdump-xen.c              |   12 ----
 4 files changed, 1 insertions(+), 228 deletions(-)

diff --git a/configure.ac b/configure.ac
index 438b3c9..120a5ed 100644
--- a/configure.ac
+++ b/configure.ac
@@ -161,11 +161,8 @@ fi
 dnl find Xen control stack libraries
 if test "$with_xen" = yes ; then
 	AC_CHECK_HEADER(xenctrl.h,
-		AC_CHECK_LIB(xenctrl, xc_version, ,
+		AC_CHECK_LIB(xenctrl, xc_kexec_load, ,
 		AC_MSG_NOTICE([Xen support disabled])))
-	if test "$ac_cv_lib_xenctrl_xc_version" = yes ; then
-		AC_CHECK_FUNCS(xc_get_machine_memory_map)
-	fi
 fi
 
 dnl ---Sanity checks
diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index 245402c..f9709fe 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -43,14 +43,7 @@
 #include "crashdump-x86.h"
 
 #ifdef HAVE_LIBXENCTRL
-#ifdef HAVE_XC_GET_MACHINE_MEMORY_MAP
 #include <xenctrl.h>
-#else
-#define __XEN_TOOLS__	1
-#include <xen/xen.h>
-#include <xen/memory.h>
-#include <xen/sys/privcmd.h>
-#endif /* HAVE_XC_GET_MACHINE_MEMORY_MAP */
 #endif /* HAVE_LIBXENCTRL */
 
 #include <x86/x86-linux.h>
@@ -294,34 +287,20 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges,
 }
 
 #ifdef HAVE_LIBXENCTRL
-#ifdef HAVE_XC_GET_MACHINE_MEMORY_MAP
 static int get_crash_memory_ranges_xen(struct memory_range **range,
 					int *ranges, unsigned long lowmem_limit)
 {
 	int j, rc, ret = -1;
 	struct e820entry e820entries[CRASH_MAX_MEMORY_RANGES];
 	unsigned int i;
-#ifdef XENCTRL_HAS_XC_INTERFACE
 	xc_interface *xc;
-#else
-	int xc;
-#endif
 
-#ifdef XENCTRL_HAS_XC_INTERFACE
 	xc = xc_interface_open(NULL, NULL, 0);
 
 	if (!xc) {
 		fprintf(stderr, "%s: Failed to open Xen control interface\n", __func__);
 		goto err;
 	}
-#else
-	xc = xc_interface_open();
-
-	if (xc == -1) {
-		fprintf(stderr, "%s: Failed to open Xen control interface\n", __func__);
-		goto err;
-	}
-#endif
 
 	rc = xc_get_machine_memory_map(xc, e820entries, CRASH_MAX_MEMORY_RANGES);
 
@@ -357,94 +336,6 @@ err:
 static int get_crash_memory_ranges_xen(struct memory_range **range,
 					int *ranges, unsigned long lowmem_limit)
 {
-	int fd, j, rc, ret = -1;
-	privcmd_hypercall_t hypercall;
-	struct e820entry *e820entries = NULL;
-	struct xen_memory_map *xen_memory_map = NULL;
-	unsigned int i;
-
-	fd = open("/proc/xen/privcmd", O_RDWR);
-
-	if (fd == -1) {
-		fprintf(stderr, "%s: open(/proc/xen/privcmd): %m\n", __func__);
-		goto err;
-	}
-
-	rc = posix_memalign((void **)&e820entries, getpagesize(),
-			    sizeof(struct e820entry) * CRASH_MAX_MEMORY_RANGES);
-
-	if (rc) {
-		fprintf(stderr, "%s: posix_memalign(e820entries): %s\n", __func__, strerror(rc));
-		e820entries = NULL;
-		goto err;
-	}
-
-	rc = posix_memalign((void **)&xen_memory_map, getpagesize(),
-			    sizeof(struct xen_memory_map));
-
-	if (rc) {
-		fprintf(stderr, "%s: posix_memalign(xen_memory_map): %s\n", __func__, strerror(rc));
-		xen_memory_map = NULL;
-		goto err;
-	}
-
-	if (mlock(e820entries, sizeof(struct e820entry) * CRASH_MAX_MEMORY_RANGES) == -1) {
-		fprintf(stderr, "%s: mlock(e820entries): %m\n", __func__);
-		goto err;
-	}
-
-	if (mlock(xen_memory_map, sizeof(struct xen_memory_map)) == -1) {
-		fprintf(stderr, "%s: mlock(xen_memory_map): %m\n", __func__);
-		goto err;
-	}
-
-	xen_memory_map->nr_entries = CRASH_MAX_MEMORY_RANGES;
-	set_xen_guest_handle(xen_memory_map->buffer, e820entries);
-
-	hypercall.op = __HYPERVISOR_memory_op;
-	hypercall.arg[0] = XENMEM_machine_memory_map;
-	hypercall.arg[1] = (__u64)xen_memory_map;
-
-	rc = ioctl(fd, IOCTL_PRIVCMD_HYPERCALL, &hypercall);
-
-	if (rc == -1) {
-		fprintf(stderr, "%s: ioctl(IOCTL_PRIVCMD_HYPERCALL): %m\n", __func__);
-		goto err;
-	}
-
-	for (i = 0, j = 0; i < xen_memory_map->nr_entries &&
-				j < CRASH_MAX_MEMORY_RANGES; ++i, ++j) {
-		crash_memory_range[j].start = e820entries[i].addr;
-		crash_memory_range[j].end = e820entries[i].addr + e820entries[i].size - 1;
-		crash_memory_range[j].type = xen_e820_to_kexec_type(e820entries[i].type);
-		segregate_lowmem_region(&j, lowmem_limit);
-	}
-
-	*range = crash_memory_range;
-	*ranges = j;
-
-	qsort(*range, *ranges, sizeof(struct memory_range), compare_ranges);
-
-	if (exclude_region(ranges, crash_reserved_mem.start,
-						crash_reserved_mem.end) < 0)
-		goto err;
-
-	ret = 0;
-
-err:
-	munlock(xen_memory_map, sizeof(struct xen_memory_map));
-	munlock(e820entries, sizeof(struct e820entry) * CRASH_MAX_MEMORY_RANGES);
-	free(xen_memory_map);
-	free(e820entries);
-	close(fd);
-
-	return ret;
-}
-#endif /* HAVE_XC_GET_MACHINE_MEMORY_MAP */
-#else
-static int get_crash_memory_ranges_xen(struct memory_range **range,
-					int *ranges, unsigned long lowmem_limit)
-{
 	return 0;
 }
 #endif /* HAVE_LIBXENCTRL */
diff --git a/kexec/arch/i386/kexec-x86-common.c b/kexec/arch/i386/kexec-x86-common.c
index 02471a8..dba89f2 100644
--- a/kexec/arch/i386/kexec-x86-common.c
+++ b/kexec/arch/i386/kexec-x86-common.c
@@ -40,15 +40,7 @@
 #include "kexec-x86.h"
 
 #ifdef HAVE_LIBXENCTRL
-#ifdef HAVE_XC_GET_MACHINE_MEMORY_MAP
 #include <xenctrl.h>
-#else
-#define __XEN_TOOLS__	1
-#include <x86/x86-linux.h>
-#include <xen/xen.h>
-#include <xen/memory.h>
-#include <xen/sys/privcmd.h>
-#endif /* HAVE_XC_GET_MACHINE_MEMORY_MAP */
 #endif /* HAVE_LIBXENCTRL */
 
 static struct memory_range memory_range[MAX_MEMORY_RANGES];
@@ -175,33 +167,19 @@ unsigned xen_e820_to_kexec_type(uint32_t type)
  *
  * @return 0 on success, any other value on failure.
  */
-#ifdef HAVE_XC_GET_MACHINE_MEMORY_MAP
 static int get_memory_ranges_xen(struct memory_range **range, int *ranges)
 {
 	int rc, ret = -1;
 	struct e820entry e820entries[MAX_MEMORY_RANGES];
 	unsigned int i;
-#ifdef XENCTRL_HAS_XC_INTERFACE
 	xc_interface *xc;
-#else
-	int xc;
-#endif
 
-#ifdef XENCTRL_HAS_XC_INTERFACE
 	xc = xc_interface_open(NULL, NULL, 0);
 
 	if (!xc) {
 		fprintf(stderr, "%s: Failed to open Xen control interface\n", __func__);
 		goto err;
 	}
-#else
-	xc = xc_interface_open();
-
-	if (xc == -1) {
-		fprintf(stderr, "%s: Failed to open Xen control interface\n", __func__);
-		goto err;
-	}
-#endif
 
 	rc = xc_get_machine_memory_map(xc, e820entries, MAX_MEMORY_RANGES);
 
@@ -231,87 +209,6 @@ err:
 #else
 static int get_memory_ranges_xen(struct memory_range **range, int *ranges)
 {
-	int fd, rc, ret = -1;
-	privcmd_hypercall_t hypercall;
-	struct e820entry *e820entries = NULL;
-	struct xen_memory_map *xen_memory_map = NULL;
-	unsigned int i;
-
-	fd = open("/proc/xen/privcmd", O_RDWR);
-
-	if (fd == -1) {
-		fprintf(stderr, "%s: open(/proc/xen/privcmd): %m\n", __func__);
-		goto err;
-	}
-
-	rc = posix_memalign((void **)&e820entries, sysconf(_SC_PAGESIZE),
-			    sizeof(struct e820entry) * MAX_MEMORY_RANGES);
-
-	if (rc) {
-		fprintf(stderr, "%s: posix_memalign(e820entries): %s\n", __func__, strerror(rc));
-		e820entries = NULL;
-		goto err;
-	}
-
-	rc = posix_memalign((void **)&xen_memory_map, sysconf(_SC_PAGESIZE),
-			    sizeof(struct xen_memory_map));
-
-	if (rc) {
-		fprintf(stderr, "%s: posix_memalign(xen_memory_map): %s\n", __func__, strerror(rc));
-		xen_memory_map = NULL;
-		goto err;
-	}
-
-	if (mlock(e820entries, sizeof(struct e820entry) * MAX_MEMORY_RANGES) == -1) {
-		fprintf(stderr, "%s: mlock(e820entries): %m\n", __func__);
-		goto err;
-	}
-
-	if (mlock(xen_memory_map, sizeof(struct xen_memory_map)) == -1) {
-		fprintf(stderr, "%s: mlock(xen_memory_map): %m\n", __func__);
-		goto err;
-	}
-
-	xen_memory_map->nr_entries = MAX_MEMORY_RANGES;
-	set_xen_guest_handle(xen_memory_map->buffer, e820entries);
-
-	hypercall.op = __HYPERVISOR_memory_op;
-	hypercall.arg[0] = XENMEM_machine_memory_map;
-	hypercall.arg[1] = (__u64)xen_memory_map;
-
-	rc = ioctl(fd, IOCTL_PRIVCMD_HYPERCALL, &hypercall);
-
-	if (rc == -1) {
-		fprintf(stderr, "%s: ioctl(IOCTL_PRIVCMD_HYPERCALL): %m\n", __func__);
-		goto err;
-	}
-
-	for (i = 0; i < xen_memory_map->nr_entries; ++i) {
-		memory_range[i].start = e820entries[i].addr;
-		memory_range[i].end = e820entries[i].addr + e820entries[i].size;
-		memory_range[i].type = xen_e820_to_kexec_type(e820entries[i].type);
-	}
-
-	qsort(memory_range, xen_memory_map->nr_entries, sizeof(struct memory_range), compare_ranges);
-
-	*range = memory_range;
-	*ranges = xen_memory_map->nr_entries;
-
-	ret = 0;
-
-err:
-	munlock(xen_memory_map, sizeof(struct xen_memory_map));
-	munlock(e820entries, sizeof(struct e820entry) * MAX_MEMORY_RANGES);
-	free(xen_memory_map);
-	free(e820entries);
-	close(fd);
-
-	return ret;
-}
-#endif /* HAVE_XC_GET_MACHINE_MEMORY_MAP */
-#else
-static int get_memory_ranges_xen(struct memory_range **range, int *ranges)
-{
 	return 0;
 }
 #endif /* HAVE_LIBXENCTRL */
diff --git a/kexec/crashdump-xen.c b/kexec/crashdump-xen.c
index d8bd0f4..ff4706c 100644
--- a/kexec/crashdump-xen.c
+++ b/kexec/crashdump-xen.c
@@ -131,30 +131,18 @@ unsigned long xen_architecture(struct crash_elf_info *elf_info)
 #ifdef HAVE_LIBXENCTRL
 	int rc;
 	xen_capabilities_info_t capabilities;
-#ifdef XENCTRL_HAS_XC_INTERFACE
 	xc_interface *xc;
-#else
-	int xc;
-#endif
 
 	if (!xen_present())
 		goto out;
 
 	memset(capabilities, '0', XEN_CAPABILITIES_INFO_LEN);
 
-#ifdef XENCTRL_HAS_XC_INTERFACE
 	xc = xc_interface_open(NULL, NULL, 0);
 	if ( !xc ) {
 		fprintf(stderr, "failed to open xen control interface.\n");
 		goto out;
 	}
-#else
-	xc = xc_interface_open();
-	if ( xc == -1 ) {
-		fprintf(stderr, "failed to open xen control interface.\n");
-		goto out;
-	}
-#endif
 
 	rc = xc_version(xc, XENVER_capabilities, &capabilities[0]);
 	if ( rc == -1 ) {
-- 
1.7.2.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
