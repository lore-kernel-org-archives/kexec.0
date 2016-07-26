Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x232.google.com ([2607:f8b0:400e:c00::232])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bRxIc-0000AF-EZ
 for kexec@lists.infradead.org; Tue, 26 Jul 2016 08:01:17 +0000
Received: by mail-pf0-x232.google.com with SMTP id h186so72848284pfg.3
 for <kexec@lists.infradead.org>; Tue, 26 Jul 2016 01:00:50 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH 3/6] arm64: kdump: set up kernel image segment
Date: Tue, 26 Jul 2016 17:05:22 +0900
Message-Id: <20160726080525.2539-4-takahiro.akashi@linaro.org>
In-Reply-To: <20160726080525.2539-1-takahiro.akashi@linaro.org>
References: <20160726080525.2539-1-takahiro.akashi@linaro.org>
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
 kexec/arch/arm64/kexec-elf-arm64.c |  7 +++++++
 3 files changed, 31 insertions(+)

diff --git a/kexec/arch/arm64/crashdump-arm64.c b/kexec/arch/arm64/crashdump-arm64.c
index 3af01a3..e8e0489 100644
--- a/kexec/arch/arm64/crashdump-arm64.c
+++ b/kexec/arch/arm64/crashdump-arm64.c
@@ -182,3 +182,26 @@ int load_crashdump_segments(struct kexec_info *info)
 
 	return 0;
 }
+
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
diff --git a/kexec/arch/arm64/crashdump-arm64.h b/kexec/arch/arm64/crashdump-arm64.h
index da75a2d..382f571 100644
--- a/kexec/arch/arm64/crashdump-arm64.h
+++ b/kexec/arch/arm64/crashdump-arm64.h
@@ -21,5 +21,6 @@ extern struct memory_range crash_reserved_mem;
 extern struct memory_range elfcorehdr_mem;
 
 extern int load_crashdump_segments(struct kexec_info *info);
+extern void modify_ehdr_for_crashdump(struct mem_ehdr *ehdr);
 
 #endif /* CRASHDUMP_ARM64_H */
diff --git a/kexec/arch/arm64/kexec-elf-arm64.c b/kexec/arch/arm64/kexec-elf-arm64.c
index 029d3e2..1e5deb4 100644
--- a/kexec/arch/arm64/kexec-elf-arm64.c
+++ b/kexec/arch/arm64/kexec-elf-arm64.c
@@ -8,6 +8,7 @@
 #include <stdlib.h>
 #include <linux/elf.h>
 
+#include "crashdump-arm64.h"
 #include "kexec-arm64.h"
 #include "kexec-elf.h"
 #include "kexec-syscall.h"
@@ -109,6 +110,12 @@ int elf_arm64_load(int argc, char **argv, const char *kernel_buf,
 					"kexec: creating eflcorehdr failed.\n");
 				goto exit;
 			}
+
+			/*
+			 * offset addresses in order to fit vmlinux
+			 * (elf_exec) into crash kernel's memory
+			 */
+			modify_ehdr_for_crashdump(&ehdr);
 		}
 
 		result = elf_exec_load(&ehdr, info);
-- 
2.9.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
