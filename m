Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.arm.linux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by casper.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1axXUx-0001v7-93
 for kexec@lists.infradead.org; Tue, 03 May 2016 10:24:11 +0000
In-Reply-To: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH kexec-tools 30/32] arm: fix type of phys_offset
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1axXUR-0004js-5j@e0050434b2927.dyn.arm.linux.org.uk>
Date: Tue, 03 May 2016 11:23:39 +0100
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Cc: Pratyush Anand <panand@redhat.com>

Some LPAE systems may have phys_offset above the 4GB mark.  Hence, we
need phys_offset to be a 64-bit integer.

Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kexec/arch/arm/crashdump-arm.c | 4 ++--
 kexec/arch/arm/crashdump-arm.h | 1 -
 kexec/arch/arm/phys_to_virt.c  | 4 +++-
 kexec/arch/arm/phys_to_virt.h  | 8 ++++++++
 4 files changed, 13 insertions(+), 4 deletions(-)
 create mode 100644 kexec/arch/arm/phys_to_virt.h

diff --git a/kexec/arch/arm/crashdump-arm.c b/kexec/arch/arm/crashdump-arm.c
index 2dc8846..2589582 100644
--- a/kexec/arch/arm/crashdump-arm.c
+++ b/kexec/arch/arm/crashdump-arm.c
@@ -33,6 +33,7 @@
 #include "../../mem_regions.h"
 #include "crashdump-arm.h"
 #include "iomem.h"
+#include "phys_to_virt.h"
 
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 #define ELFDATANATIVE ELFDATA2LSB
@@ -70,7 +71,6 @@ static struct crash_elf_info elf_info = {
 	.page_offset	= DEFAULT_PAGE_OFFSET,
 };
 
-unsigned long phys_offset;
 extern unsigned long long user_page_offset;
 
 /* Retrieve kernel _stext symbol virtual address from /proc/kallsyms */
@@ -293,7 +293,7 @@ int load_crashdump_segments(struct kexec_info *info, char *mod_cmdline)
 	 * region as PHYS_OFFSET.
 	 */
 	phys_offset = usablemem_rgns.ranges->start;
-	dbgprintf("phys_offset: %#lx\n", phys_offset);
+	dbgprintf("phys_offset: %#llx\n", phys_offset);
 
 	if (get_kernel_page_offset(info, &elf_info))
 		return -1;
diff --git a/kexec/arch/arm/crashdump-arm.h b/kexec/arch/arm/crashdump-arm.h
index 7314960..6e87b13 100644
--- a/kexec/arch/arm/crashdump-arm.h
+++ b/kexec/arch/arm/crashdump-arm.h
@@ -16,7 +16,6 @@ extern struct memory_ranges usablemem_rgns;
 
 struct kexec_info;
 
-extern unsigned long phys_offset;
 extern int load_crashdump_segments(struct kexec_info *, char *);
 
 #ifdef __cplusplus
diff --git a/kexec/arch/arm/phys_to_virt.c b/kexec/arch/arm/phys_to_virt.c
index c2fe2ea..46a4f68 100644
--- a/kexec/arch/arm/phys_to_virt.c
+++ b/kexec/arch/arm/phys_to_virt.c
@@ -1,6 +1,8 @@
 #include "../../kexec.h"
 #include "../../crashdump.h"
-#include "crashdump-arm.h"
+#include "phys_to_virt.h"
+
+uint64_t phys_offset;
 
 /**
  * phys_to_virt() - translate physical address to virtual address
diff --git a/kexec/arch/arm/phys_to_virt.h b/kexec/arch/arm/phys_to_virt.h
new file mode 100644
index 0000000..b3147dd
--- /dev/null
+++ b/kexec/arch/arm/phys_to_virt.h
@@ -0,0 +1,8 @@
+#ifndef PHYS_TO_VIRT_H
+#define PHYS_TO_VIRT_H
+
+#include <stdint.h>
+
+extern uint64_t phys_offset;
+
+#endif
-- 
1.9.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
