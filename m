Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x235.google.com ([2607:f8b0:400e:c05::235])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1co5Mh-00006Y-JU
 for kexec@lists.infradead.org; Wed, 15 Mar 2017 09:37:09 +0000
Received: by mail-pg0-x235.google.com with SMTP id b129so6750277pgc.2
 for <kexec@lists.infradead.org>; Wed, 15 Mar 2017 02:36:47 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v6 6/9] arm64: kdump: set up kernel image segment
Date: Wed, 15 Mar 2017 18:38:21 +0900
Message-Id: <20170315093824.24566-7-takahiro.akashi@linaro.org>
In-Reply-To: <20170315093824.24566-1-takahiro.akashi@linaro.org>
References: <20170315093824.24566-1-takahiro.akashi@linaro.org>
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
 kexec/arch/arm64/crashdump-arm64.c | 23 +++++++++++++++++++++++
 kexec/arch/arm64/crashdump-arm64.h |  1 +
 kexec/arch/arm64/kexec-arm64.c     | 25 ++++++++++++++++++++-----
 kexec/arch/arm64/kexec-elf-arm64.c | 10 +++++++++-
 4 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/kexec/arch/arm64/crashdump-arm64.c b/kexec/arch/arm64/crashdump-arm64.c
index 2497d94..64b4660 100644
--- a/kexec/arch/arm64/crashdump-arm64.c
+++ b/kexec/arch/arm64/crashdump-arm64.c
@@ -214,6 +214,29 @@ int load_crashdump_segments(struct kexec_info *info)
 	return 0;
 }
 
+/*
+ * e_entry and p_paddr are actually in virtual address space.
+ * Those values will be translated to physcal addresses by
+ * using virt_to_phys().
+ * So let's get ready for later use so the memory base (phys_offset)
+ * will be correctly replaced with crash_reserved_mem.start.
+ */
+void modify_ehdr_for_crashdump(struct mem_ehdr *ehdr)
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
 	/* Crash kernel region size is not exposed by the system */
diff --git a/kexec/arch/arm64/crashdump-arm64.h b/kexec/arch/arm64/crashdump-arm64.h
index da75a2d..382f571 100644
--- a/kexec/arch/arm64/crashdump-arm64.h
+++ b/kexec/arch/arm64/crashdump-arm64.h
@@ -21,5 +21,6 @@ extern struct memory_range crash_reserved_mem;
 extern struct memory_range elfcorehdr_mem;
 
 extern int load_crashdump_segments(struct kexec_info *info);
+extern void modify_ehdr_for_crashdump(struct mem_ehdr *ehdr);
 
 #endif /* CRASHDUMP_ARM64_H */
diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
index d02b9da..5a1da2e 100644
--- a/kexec/arch/arm64/kexec-arm64.c
+++ b/kexec/arch/arm64/kexec-arm64.c
@@ -307,12 +307,27 @@ unsigned long arm64_locate_kernel_segment(struct kexec_info *info)
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
index c70a37a..842ce21 100644
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
@@ -127,6 +129,12 @@ int elf_arm64_load(int argc, char **argv, const char *kernel_buf,
 								__func__);
 			goto exit;
 		}
+
+		/*
+		 * offset addresses in order to fit vmlinux
+		 * (elf_exec) into crash kernel's memory
+		 */
+		modify_ehdr_for_crashdump(&ehdr);
 	}
 
 	/* load the kernel */
-- 
2.11.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
