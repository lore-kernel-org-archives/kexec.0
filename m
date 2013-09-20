Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from smtp02.citrix.com ([66.165.176.63])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VN0cL-0001vP-9E
 for kexec@lists.infradead.org; Fri, 20 Sep 2013 13:19:31 +0000
From: David Vrabel <david.vrabel@citrix.com>
Subject: [PATCH 4/4] kexec/xen: directly load images images into Xen
Date: Fri, 20 Sep 2013 14:18:47 +0100
Message-ID: <1379683127-14349-5-git-send-email-david.vrabel@citrix.com>
In-Reply-To: <1379683127-14349-1-git-send-email-david.vrabel@citrix.com>
References: <1379683127-14349-1-git-send-email-david.vrabel@citrix.com>
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
Cc: kexec@lists.infradead.org, David Vrabel <david.vrabel@citrix.com>

From: David Vrabel <david.vrabel@citrix.com>

Xen 4.4 has an improvided kexec hypercall ABI that allows images to be
loaded and executed without any kernel involvement.  Use the API
provided by libxc to load images when running in a Xen guest.

Support for loading images via the kexec_load syscall in non-upstream
("classic") Xen kernels is no longer supported.

Signed-off-by: David Vrabel <david.vrabel@citrix.com>
---
 kexec/Makefile                  |    1 +
 kexec/arch/i386/crashdump-x86.c |   20 +++++-
 kexec/crashdump-xen.c           |   34 ++++++++++
 kexec/crashdump.h               |    3 +-
 kexec/kexec-xen.c               |  134 +++++++++++++++++++++++++++++++++++++++
 kexec/kexec.c                   |   24 ++++++--
 kexec/kexec.h                   |    5 ++
 7 files changed, 213 insertions(+), 8 deletions(-)
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
index 7aa5a12..85f3a87 100644
--- a/kexec/arch/i386/crashdump-x86.c
+++ b/kexec/arch/i386/crashdump-x86.c
@@ -990,8 +990,24 @@ static int crashkernel_mem_callback(void *UNUSED(data), int nr,
 
 int is_crashkernel_mem_reserved(void)
 {
-	crash_reserved_mem_nr = kexec_iomem_for_each_line("Crash kernel\n",
-                                       crashkernel_mem_callback, NULL);
+	int ret;
+
+	if (xen_present()) {
+		uint64_t start, end;
+
+		ret = xen_get_crashkernel_region(&start, &end);
+		if (ret < 0)
+			return 0;
+
+		crash_reserved_mem[0].start = start;
+		crash_reserved_mem[0].end   = end;
+		crash_reserved_mem[0].type  = RANGE_RAM;
+		crash_reserved_mem_nr = 1;
+	} else {
+		ret = kexec_iomem_for_each_line("Crash kernel\n",
+						crashkernel_mem_callback, NULL);
+		crash_reserved_mem_nr = ret;
+	}
 
 	return !!crash_reserved_mem_nr;
 }
diff --git a/kexec/crashdump-xen.c b/kexec/crashdump-xen.c
index b08220e..9f12de7 100644
--- a/kexec/crashdump-xen.c
+++ b/kexec/crashdump-xen.c
@@ -252,3 +252,37 @@ int xen_get_note(int cpu, uint64_t *addr, uint64_t *len)
 
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
index 0000000..0e47e68
--- /dev/null
+++ b/kexec/kexec-xen.c
@@ -0,0 +1,134 @@
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <elf.h>
+#include "kexec.h"
+#include "kexec-syscall.h"
+#include "crashdump.h"
+
+#include "config.h"
+
+#ifdef HAVE_LIBXENCTRL
+#include <xenctrl.h>
+
+#include "crashdump.h"
+
+int xen_kexec_load(struct kexec_info *info)
+{
+	uint32_t nr_segments = info->nr_segments;
+	struct kexec_segment *segments = info->segment;
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
+	xen_segs = calloc(nr_segments + 1, sizeof(*xen_segs));
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
+		set_xen_guest_handle(xen_segs[s].buf.h, seg_buf);
+		xen_segs[s].buf_size = segments[s].bufsz;
+		xen_segs[s].dest_maddr = (uint64_t)segments[s].mem;
+		xen_segs[s].dest_size = segments[s].memsz;
+	}
+
+	if (info->kexec_flags & KEXEC_ON_CRASH) {
+		set_xen_guest_handle(xen_segs[s].buf.h, HYPERCALL_BUFFER_NULL);
+		xen_segs[s].buf_size = 0;
+		xen_segs[s].dest_maddr = info->backup_src_start;
+		xen_segs[s].dest_size = info->backup_src_size;
+		nr_segments++;
+	}
+
+	type = (info->kexec_flags & KEXEC_ON_CRASH) ? KEXEC_TYPE_CRASH
+		: KEXEC_TYPE_DEFAULT;
+
+	arch = (info->kexec_flags & KEXEC_ARCH_MASK) >> 16;
+#if defined(_i386__) || defined(__x86_64__)
+	if (!arch)
+		arch = EM_386;
+#endif
+
+	ret = xc_kexec_load(xch, type, arch, (uint64_t)info->entry,
+			    nr_segments, xen_segs);
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
index 21ff0e7..13b568f 100644
--- a/kexec/kexec.c
+++ b/kexec/kexec.c
@@ -764,8 +764,12 @@ static int my_load(const char *type, int fileind, int argc, char **argv,
 	if (kexec_debug)
 		print_segments(stderr, &info);
 
-	result = kexec_load(
-		info.entry, info.nr_segments, info.segment, info.kexec_flags);
+	if (xen_present())
+		result = xen_kexec_load(&info);
+	else
+		result = kexec_load(info.entry,
+				    info.nr_segments, info.segment,
+				    info.kexec_flags);
 	if (result != 0) {
 		/* The load failed, print some debugging information */
 		fprintf(stderr, "kexec_load failed: %s\n", 
@@ -789,10 +793,13 @@ static int k_unload (unsigned long kexec_flags)
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
@@ -823,7 +830,10 @@ static int my_shutdown(void)
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
@@ -928,6 +938,10 @@ static int kexec_loaded(void)
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
index 715b568..c7739d5 100644
--- a/kexec/kexec.h
+++ b/kexec/kexec.h
@@ -289,4 +289,9 @@ const char * proc_iomem(void);
 
 char *concat_cmdline(const char *base, const char *append);
 
+int xen_present(void);
+int xen_kexec_load(struct kexec_info *info);
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
