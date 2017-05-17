Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x230.google.com ([2607:f8b0:400e:c05::230])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dArpR-0000jb-72
 for kexec@lists.infradead.org; Wed, 17 May 2017 05:48:58 +0000
Received: by mail-pg0-x230.google.com with SMTP id u28so1756366pgn.1
 for <kexec@lists.infradead.org>; Tue, 16 May 2017 22:48:38 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v7 07/10] arm64: kdump: set up kernel image segment
Date: Wed, 17 May 2017 14:51:47 +0900
Message-Id: <20170517055150.12601-8-takahiro.akashi@linaro.org>
In-Reply-To: <20170517055150.12601-1-takahiro.akashi@linaro.org>
References: <20170517055150.12601-1-takahiro.akashi@linaro.org>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: horms@verge.net.au
Cc: geoff@infradead.org, panand@redhat.com, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>

On arm64, we can use the same kernel image as 1st kernel, but
we have to modify the entry point as well as segments' addresses
in the kernel's elf header in order to load them into correct places.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 kexec/arch/arm64/crashdump-arm64.c | 24 ++++++++++++++++++++++++
 kexec/arch/arm64/crashdump-arm64.h |  1 +
 kexec/arch/arm64/kexec-arm64.c     | 25 ++++++++++++++++++++-----
 kexec/arch/arm64/kexec-elf-arm64.c | 11 ++++++++++-
 4 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/kexec/arch/arm64/crashdump-arm64.c b/kexec/arch/arm64/crashdump-arm64.c
index d142435..4fd7aa8 100644
--- a/kexec/arch/arm64/crashdump-arm64.c
+++ b/kexec/arch/arm64/crashdump-arm64.c
@@ -211,6 +211,30 @@ int load_crashdump_segments(struct kexec_info *info)
 	return 0;
 }
 
+/*
+ * e_entry and p_paddr are actually in virtual address space.
+ * Those values will be translated to physcal addresses by using
+ * virt_to_phys() in add_segment().
+ * So let's fix up those values for later use so the memory base
+ * (arm64_mm.phys_offset) will be correctly replaced with
+ * crash_reserved_mem.start.
+ */
+void fixup_elf_addrs(struct mem_ehdr *ehdr)
+{
+	struct mem_phdr *phdr;
+	int i;
+
+	ehdr->e_entry += - arm64_mem.phys_offset + crash_reserved_mem.start;
+
+	for (i = 0; i < ehdr->e_phnum; i++) {
+		phdr = &ehdr->e_phdr[i];
+		if (phdr->p_type != PT_LOAD)
+			continue;
+		phdr->p_paddr +=
+			(-arm64_mem.phys_offset + crash_reserved_mem.start);
+	}
+}
+
 int get_crash_kernel_load_range(uint64_t *start, uint64_t *end)
 {
 	if (!usablemem_rgns.size)
diff --git a/kexec/arch/arm64/crashdump-arm64.h b/kexec/arch/arm64/crashdump-arm64.h
index 64c677d..880b83a 100644
--- a/kexec/arch/arm64/crashdump-arm64.h
+++ b/kexec/arch/arm64/crashdump-arm64.h
@@ -21,5 +21,6 @@ extern struct memory_range crash_reserved_mem;
 extern struct memory_range elfcorehdr_mem;
 
 extern int load_crashdump_segments(struct kexec_info *info);
+extern void fixup_elf_addrs(struct mem_ehdr *ehdr);
 
 #endif /* CRASHDUMP_ARM64_H */
diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index 153c96f..6c21756 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -308,12 +308,27 @@ unsigned long arm64_locate_kernel_segment(struct kexec_info *info)
 {
 	unsigned long hole;
 
-	hole = locate_hole(info,
-		arm64_mem.text_offset + arm64_mem.image_size,
-		MiB(2), 0, ULONG_MAX, 1);
+	if (info->kexec_flags & KEXEC_ON_CRASH) {
+		unsigned long hole_end;
+
+		hole = (crash_reserved_mem.start < mem_min ?
+				mem_min : crash_reserved_mem.start);
+		hole = _ALIGN_UP(hole, MiB(2));
+		hole_end = hole + arm64_mem.text_offset + arm64_mem.image_size;
+
+		if ((hole_end > mem_max) ||
+		    (hole_end > crash_reserved_mem.end)) {
+			dbgprintf("%s: Crash kernel out of range\n", __func__);
+			hole = ULONG_MAX;
+		}
+	} else {
+		hole = locate_hole(info,
+			arm64_mem.text_offset + arm64_mem.image_size,
+			MiB(2), 0, ULONG_MAX, 1);
 
-	if (hole == ULONG_MAX)
-		dbgprintf("%s: locate_hole failed\n", __func__);
+		if (hole == ULONG_MAX)
+			dbgprintf("%s: locate_hole failed\n", __func__);
+	}
 
 	return hole;
 }
diff --git a/kexec/arch/arm64/kexec-elf-arm64.c b/kexec/arch/arm64/kexec-elf-arm64.c
index 900c693..a961147 100644
--- a/kexec/arch/arm64/kexec-elf-arm64.c
+++ b/kexec/arch/arm64/kexec-elf-arm64.c
@@ -9,6 +9,7 @@
 #include <stdlib.h>
 #include <linux/elf.h>
 
+#include "crashdump-arm64.h"
 #include "kexec-arm64.h"
 #include "kexec-elf.h"
 #include "kexec-syscall.h"
@@ -105,7 +106,8 @@ int elf_arm64_load(int argc, char **argv, const char *kernel_buf,
 	}
 
 	arm64_mem.vp_offset = _ALIGN_DOWN(ehdr.e_entry, MiB(2));
-	arm64_mem.vp_offset -= kernel_segment - get_phys_offset();
+	if (!(info->kexec_flags & KEXEC_ON_CRASH))
+		arm64_mem.vp_offset -= kernel_segment - get_phys_offset();
 
 	dbgprintf("%s: kernel_segment: %016lx\n", __func__, kernel_segment);
 	dbgprintf("%s: text_offset:    %016lx\n", __func__,
@@ -130,6 +132,13 @@ int elf_arm64_load(int argc, char **argv, const char *kernel_buf,
 	}
 
 	/* load the kernel */
+	if (info->kexec_flags & KEXEC_ON_CRASH)
+		/*
+		 * offset addresses in elf header in order to load
+		 * vmlinux (elf_exec) into crash kernel's memory
+		 */
+		fixup_elf_addrs(&ehdr);
+
 	result = elf_exec_load(&ehdr, info);
 
 	if (result) {
-- 
2.11.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
