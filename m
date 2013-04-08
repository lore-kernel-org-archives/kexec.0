Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp.citrix.com ([66.165.176.89])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UPHPQ-0007Gr-1a
 for kexec@lists.infradead.org; Mon, 08 Apr 2013 19:07:17 +0000
From: David Vrabel <david.vrabel@citrix.com>
Subject: [PATCH 5/5] kexec/xen: directly load images images into Xen
Date: Mon, 8 Apr 2013 20:06:54 +0100
Message-ID: <1365448014-12119-6-git-send-email-david.vrabel@citrix.com>
In-Reply-To: <1365448014-12119-1-git-send-email-david.vrabel@citrix.com>
References: <1365448014-12119-1-git-send-email-david.vrabel@citrix.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: xen-devel@lists.xen.org
Cc: Daniel Kiper <daniel.kiper@oracle.com>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, David Vrabel <david.vrabel@citrix.com>

From: David Vrabel <david.vrabel@citrix.com>

Xen 4.3 has an improvided kexec hypercall ABI that allows images to be
loaded and executed without any kernel involvement.  Use the API
provided by libxc to load images when running in a Xen guest.

Support for loading images via the kexec_load syscall in non-upstream
("classic") Xen kernels is no longer supported.

Signed-off-by: David Vrabel <david.vrabel@citrix.com>
---
 kexec/Makefile                     |    1 +
 kexec/arch/i386/crashdump-x86.c    |   19 ++++++-
 kexec/arch/i386/kexec-x86-common.c |    6 +-
 kexec/crashdump-xen.c              |   52 ++++++++++++++--
 kexec/crashdump.h                  |    3 +-
 kexec/kexec-xen.c                  |  117 ++++++++++++++++++++++++++++++++++++
 kexec/kexec.c                      |   26 +++++++--
 kexec/kexec.h                      |    7 ++
 8 files changed, 214 insertions(+), 17 deletions(-)
 create mode 100644 kexec/kexec-xen.c

diff --git a/kexec/Makefile b/kexec/Makefile
index 8a6138d..dc9dab1 100644
--- a/kexec/Makefile
+++ b/kexec/Makefile
@@ -25,6 +25,7 @@ KEXEC_SRCS_base += kexec/phys_arch.c
 KEXEC_SRCS_base += kexec/kernel_version.c
 KEXEC_SRCS_base += kexec/lzma.c
 KEXEC_SRCS_base += kexec/zlib.c
+KEXEC_SRCS_base += kexec/kexec-xen.c
 
 KEXEC_GENERATED_SRCS += $(PURGATORY_HEX_C)
 
diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
index f9709fe..46a76f9 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -939,11 +939,28 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
 	return 0;
 }
 
+int get_crashkernel_region(uint64_t *start, uint64_t *end)
+{
+	int ret;
+
+	if (xen_present())
+		ret = xen_get_crashkernel_region(start, end);
+	else
+		ret = parse_iomem_single("Crash kernel\n", start, end);
+	if (ret < 0)
+		return ret;
+	if (start == end)
+		return -1;
+	return 0;
+}
+
 int is_crashkernel_mem_reserved(void)
 {
 	uint64_t start, end;
+	int rc;
 
-	if (parse_iomem_single("Crash kernel\n", &start, &end) || start == end)
+	rc = get_crashkernel_region(&start, &end);
+	if (rc < 0)
 		return 0;
 
 	crash_reserved_mem.start = start;
diff --git a/kexec/arch/i386/kexec-x86-common.c b/kexec/arch/i386/kexec-x86-common.c
index dba89f2..2477dee 100644
--- a/kexec/arch/i386/kexec-x86-common.c
+++ b/kexec/arch/i386/kexec-x86-common.c
@@ -364,9 +364,9 @@ int get_memory_ranges(struct memory_range **range, int *ranges,
 	    !(kexec_flags & KEXEC_PRESERVE_CONTEXT)) {
 		uint64_t start, end;
 
-		ret = parse_iomem_single("Crash kernel\n", &start, &end);
-		if (ret != 0) {
-			fprintf(stderr, "parse_iomem_single failed.\n");
+		ret = get_crashkernel_region(&start, &end);
+		if (ret < 0) {
+			fprintf(stderr, "No crash region available.\n");
 			return -1;
 		}
 
diff --git a/kexec/crashdump-xen.c b/kexec/crashdump-xen.c
index dfb86c8..70ae7c4 100644
--- a/kexec/crashdump-xen.c
+++ b/kexec/crashdump-xen.c
@@ -187,18 +187,27 @@ int get_xen_vmcoreinfo(uint64_t *addr, uint64_t *len)
 int xen_get_nr_phys_cpus(void)
 {
 	xc_interface *xc;
+	int max_cpus;
 	int cpu;
 
 	if (xen_phys_cpus)
 		return xen_phys_cpus;
 
 	xc = xc_interface_open(NULL, NULL, 0);
-	if ( !xc ) {
+	if (!xc) {
 		fprintf(stderr, "failed to open xen control interface.\n");
 		return -1;
 	}
 
-	for (cpu = 0;; cpu++) {
+	max_cpus = xc_get_max_cpus(xc);
+	if (max_cpus <= 0)
+		return -1;
+
+	xen_phys_notes = calloc(max_cpus, sizeof(*xen_phys_notes));
+	if (xen_phys_notes == NULL)
+		return -1;
+
+	for (cpu = 0; cpu < max_cpus; cpu++) {
 		uint64_t size, start;
 		int ret;
 
@@ -206,11 +215,6 @@ int xen_get_nr_phys_cpus(void)
 		if (ret < 0)
 			break;
 
-		xen_phys_notes = realloc(xen_phys_notes,
-					 sizeof(*xen_phys_notes) * (cpu + 1));
-		if (xen_phys_notes == NULL)
-			return -1;
-
 		xen_phys_notes[cpu].base = start;
 		xen_phys_notes[cpu].length = size;
 	}
@@ -243,3 +247,37 @@ int xen_get_note(int cpu, uint64_t *addr, uint64_t *len)
 
 	return 0;
 }
+
+#ifdef HAVE_LIBXENCTRL
+int xen_get_crashkernel_region(uint64_t *start, uint64_t *end)
+{
+	uint64_t size;
+	xc_interface *xc;
+	int rc = -1;
+
+	xc = xc_interface_open(NULL, NULL, 0);
+	if (!xc) {
+		fprintf(stderr, "failed to open xen control interface.\n");
+		goto out;
+	}
+
+	rc = xc_kexec_get_range(xc, KEXEC_RANGE_MA_CRASH, 0, &size, start);
+	if (rc < 0) {
+		fprintf(stderr, "failed to get crash region from hypervisor.\n");
+		goto out_close;
+	}
+
+	*end = *start + size - 1;
+
+out_close:
+	xc_interface_close(xc);
+
+out:
+	return rc;
+}
+#else
+int xen_get_crashkernel_region(uint64_t *start, uint64_t *end)
+{
+	return -1;
+}
+#endif
diff --git a/kexec/crashdump.h b/kexec/crashdump.h
index 0f7c2ea..95f1f0c 100644
--- a/kexec/crashdump.h
+++ b/kexec/crashdump.h
@@ -1,6 +1,7 @@
 #ifndef CRASHDUMP_H
 #define CRASHDUMP_H
 
+int get_crashkernel_region(uint64_t *start, uint64_t *end);
 extern int get_crash_notes_per_cpu(int cpu, uint64_t *addr, uint64_t *len);
 extern int get_kernel_vmcoreinfo(uint64_t *addr, uint64_t *len);
 extern int get_xen_vmcoreinfo(uint64_t *addr, uint64_t *len);
@@ -56,9 +57,9 @@ unsigned long crash_architecture(struct crash_elf_info *elf_info);
 unsigned long phys_to_virt(struct crash_elf_info *elf_info,
 			   unsigned long paddr);
 
-int xen_present(void);
 unsigned long xen_architecture(struct crash_elf_info *elf_info);
 int xen_get_nr_phys_cpus(void);
 int xen_get_note(int cpu, uint64_t *addr, uint64_t *len);
+int xen_get_crashkernel_region(uint64_t *start, uint64_t *end);
 
 #endif /* CRASHDUMP_H */
diff --git a/kexec/kexec-xen.c b/kexec/kexec-xen.c
new file mode 100644
index 0000000..817be30
--- /dev/null
+++ b/kexec/kexec-xen.c
@@ -0,0 +1,117 @@
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include "kexec.h"
+#include "crashdump.h"
+
+#include "config.h"
+
+#ifdef HAVE_LIBXENCTRL
+#include <xenctrl.h>
+
+#include "crashdump.h"
+
+int xen_kexec_load(uint64_t entry,
+		   uint32_t nr_segments, struct kexec_segment *segments,
+		   uint64_t kexec_flags)
+{
+	xc_interface *xch;
+	xc_hypercall_buffer_array_t *array = NULL;
+	uint8_t type;
+	uint8_t arch;
+	xen_kexec_segment_t *xen_segs;
+	int s;
+	int ret = -1;
+
+	xch = xc_interface_open(NULL, NULL, 0);
+	if (!xch)
+		return -1;
+
+	xen_segs = calloc(nr_segments, sizeof(*xen_segs));
+	if (!xen_segs)
+		goto out;
+
+	array = xc_hypercall_buffer_array_create(xch, nr_segments);
+	if (array == NULL)
+		goto out;
+
+	for (s = 0; s < nr_segments; s++) {
+		DECLARE_HYPERCALL_BUFFER(void, seg_buf);
+
+		seg_buf = xc_hypercall_buffer_array_alloc(xch, array, s,
+							  seg_buf, segments[s].bufsz);
+		if (seg_buf == NULL)
+			goto out;
+		memcpy(seg_buf, segments[s].buf, segments[s].bufsz);
+
+		set_xen_guest_handle(xen_segs[s].buf, seg_buf);
+		xen_segs[s].buf_size = segments[s].bufsz;
+		xen_segs[s].dest_maddr = (uint64_t)segments[s].mem;
+		xen_segs[s].dest_size = segments[s].memsz;
+	}
+
+	type = kexec_flags & KEXEC_TYPE_CRASH;
+	arch = (kexec_flags >> 16) & 0xffff;
+
+	ret = xc_kexec_load(xch, type, arch, entry, nr_segments, xen_segs);
+
+out:
+	xc_hypercall_buffer_array_destroy(xch, array);
+	free(xen_segs);
+	xc_interface_close(xch);
+
+	return ret;
+}
+
+int xen_kexec_unload(uint64_t kexec_flags)
+{
+	xc_interface *xch;
+	uint8_t type;
+	int ret;
+
+	xch = xc_interface_open(NULL, NULL, 0);
+	if (!xch)
+		return -1;
+
+	type = kexec_flags & KEXEC_TYPE_CRASH;
+
+	ret = xc_kexec_unload(xch, type);
+
+	xc_interface_close(xch);
+
+	return ret;
+}
+
+void xen_kexec_exec(void)
+{
+	xc_interface *xch;
+	
+	xch = xc_interface_open(NULL, NULL, 0);
+	if (!xch)
+		return;
+
+	xc_kexec_exec(xch, KEXEC_TYPE_DEFAULT);
+
+	xc_interface_close(xch);
+}
+
+#else /* ! HAVE_LIBXENCTRL */
+
+int xen_kexec_load(uint64_t entry,
+		   uint32_t nr_segments, struct kexec_segment *segments,
+		   uint64_t kexec_flags)
+{
+	return -1;
+}
+
+int xen_kexec_unload(uin64_t kexec_flags);
+{
+	return -1;
+}
+
+void xen_kexec_exec(void)
+{
+}
+
+#endif
diff --git a/kexec/kexec.c b/kexec/kexec.c
index 16c6308..9db288f 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -764,8 +764,14 @@ static int my_load(const char *type, int fileind, int argc, char **argv,
 		info.entry, info.kexec_flags);
 	print_segments(stderr, &info);
 #endif
-	result = kexec_load(
-		info.entry, info.nr_segments, info.segment, info.kexec_flags);
+	if (xen_present())
+		result = xen_kexec_load((uint64_t)info.entry,
+					info.nr_segments, info.segment,
+					info.kexec_flags);
+	else
+		result = kexec_load(info.entry,
+				    info.nr_segments, info.segment,
+				    info.kexec_flags);
 	if (result != 0) {
 		/* The load failed, print some debugging information */
 		fprintf(stderr, "kexec_load failed: %s\n", 
@@ -789,10 +795,13 @@ static int k_unload (unsigned long kexec_flags)
 	}
 	kexec_flags |= native_arch;
 
-	result = kexec_load(NULL, 0, NULL, kexec_flags);
+	if (xen_present())
+		result = xen_kexec_unload(kexec_flags);
+	else
+		result = kexec_load(NULL, 0, NULL, kexec_flags);
 	if (result != 0) {
 		/* The unload failed, print some debugging information */
-		fprintf(stderr, "kexec_load (0 segments) failed: %s\n",
+		fprintf(stderr, "kexec unload failed: %s\n",
 			strerror(errno));
 	}
 	return result;
@@ -823,7 +832,10 @@ static int my_shutdown(void)
  */
 static int my_exec(void)
 {
-	reboot(LINUX_REBOOT_CMD_KEXEC);
+	if (xen_present())
+		xen_kexec_exec();
+	else
+		reboot(LINUX_REBOOT_CMD_KEXEC);
 	/* I have failed if I make it here */
 	fprintf(stderr, "kexec failed: %s\n", 
 		strerror(errno));
@@ -924,6 +936,10 @@ static int kexec_loaded(void)
 	char *p;
 	char line[3];
 
+	/* No way to tell if an image is loaded under Xen, assume it is. */
+	if (xen_present())
+		return 1;
+
 	fp = fopen("/sys/kernel/kexec_loaded", "r");
 	if (fp == NULL)
 		return -1;
diff --git a/kexec/kexec.h b/kexec/kexec.h
index 94c62c1..d28a04b 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -280,4 +280,11 @@ extern int add_backup_segments(struct kexec_info *info,
 
 char *concat_cmdline(const char *base, const char *append);
 
+int xen_present(void);
+int xen_kexec_load(uint64_t entry,
+		   uint32_t nr_segments, struct kexec_segment *segments,
+		   uint64_t kexec_flags);
+int xen_kexec_unload(uint64_t kexec_flags);
+void xen_kexec_exec(void);
+
 #endif /* KEXEC_H */
-- 
1.7.2.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
