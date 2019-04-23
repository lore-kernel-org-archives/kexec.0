Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hIkGk-0005TI-8J
 for kexec@lists.infradead.org; Tue, 23 Apr 2019 01:30:47 +0000
From: Lianbo Jiang <lijiang@redhat.com>
Subject: [PATCH 2/3 v11] x86/mm: change the check condition in SEV because a
 new descriptor is introduced
Date: Tue, 23 Apr 2019 09:30:06 +0800
Message-Id: <20190423013007.17838-3-lijiang@redhat.com>
In-Reply-To: <20190423013007.17838-1-lijiang@redhat.com>
References: <20190423013007.17838-1-lijiang@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: Thomas.Lendacky@amd.com, x86@kernel.org, bhe@redhat.com, peterz@infradead.org, dave.hansen@linux.intel.com, kexec@lists.infradead.org, mingo@redhat.com, bp@alien8.de, luto@kernel.org, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

Originally, those areas described as IORES_DESC_NONE are not mapped
encrypted in SEV when using ioremap(). It checks for a resource that
is not described as IORES_DESC_NONE, which can ensure the reserved
areas are not mapped encrypted when using ioremap().

But now, a new descriptor IORES_DESC_RESERVED has been created for
the reserved areas, similarly, the IORES_DESC_{NONE,RESERVED} should
not be mapped encrypted in SEV when using ioremap().

Therefore, need to modify the check condition in SEV and improve them.

Suggested-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 arch/x86/mm/ioremap.c  | 59 ++++++++++++++++++++++++++----------------
 include/linux/ioport.h |  9 +++++++
 2 files changed, 46 insertions(+), 22 deletions(-)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index dd73d5d74393..82be5707124b 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -27,9 +27,8 @@
 
 #include "physaddr.h"
 
-struct ioremap_mem_flags {
-	bool system_ram;
-	bool desc_other;
+struct ioremap_desc {
+	unsigned int flags;
 };
 
 /*
@@ -61,13 +60,13 @@ int ioremap_change_attr(unsigned long vaddr, unsigned long size,
 	return err;
 }
 
-static bool __ioremap_check_ram(struct resource *res)
+static unsigned int __ioremap_check_ram(struct resource *res)
 {
 	unsigned long start_pfn, stop_pfn;
 	unsigned long i;
 
 	if ((res->flags & IORESOURCE_SYSTEM_RAM) != IORESOURCE_SYSTEM_RAM)
-		return false;
+		return 0;
 
 	start_pfn = (res->start + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	stop_pfn = (res->end + 1) >> PAGE_SHIFT;
@@ -75,28 +74,44 @@ static bool __ioremap_check_ram(struct resource *res)
 		for (i = 0; i < (stop_pfn - start_pfn); ++i)
 			if (pfn_valid(start_pfn + i) &&
 			    !PageReserved(pfn_to_page(start_pfn + i)))
-				return true;
+				return IORES_MAP_SYSTEM_RAM;
 	}
 
-	return false;
+	return 0;
 }
 
-static int __ioremap_check_desc_other(struct resource *res)
+/*
+ * NONE and RESERVED should not be mapped encrypted in SEV because there
+ * the whole memory is already encrypted.
+ */
+static unsigned int __ioremap_check_desc(struct resource *res)
 {
-	return (res->desc != IORES_DESC_NONE);
+	if (!sev_active())
+		return 0;
+
+	switch (res->desc) {
+	case IORES_DESC_NONE:
+	case IORES_DESC_RESERVED:
+		break;
+	default:
+		return IORES_MAP_ENCRYPTED;
+	}
+
+	return 0;
 }
 
 static int __ioremap_res_check(struct resource *res, void *arg)
 {
-	struct ioremap_mem_flags *flags = arg;
+	struct ioremap_desc *desc = arg;
 
-	if (!flags->system_ram)
-		flags->system_ram = __ioremap_check_ram(res);
+	if (!(desc->flags & IORES_MAP_SYSTEM_RAM))
+		desc->flags |= __ioremap_check_ram(res);
 
-	if (!flags->desc_other)
-		flags->desc_other = __ioremap_check_desc_other(res);
+	if (!(desc->flags & IORES_MAP_ENCRYPTED))
+		desc->flags |= __ioremap_check_desc(res);
 
-	return flags->system_ram && flags->desc_other;
+	return ((desc->flags & (IORES_MAP_SYSTEM_RAM | IORES_MAP_ENCRYPTED)) ==
+		(IORES_MAP_SYSTEM_RAM | IORES_MAP_ENCRYPTED));
 }
 
 /*
@@ -105,15 +120,15 @@ static int __ioremap_res_check(struct resource *res, void *arg)
  * resource described not as IORES_DESC_NONE (e.g. IORES_DESC_ACPI_TABLES).
  */
 static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
-				struct ioremap_mem_flags *flags)
+				struct ioremap_desc *desc)
 {
 	u64 start, end;
 
 	start = (u64)addr;
 	end = start + size - 1;
-	memset(flags, 0, sizeof(*flags));
+	memset(desc, 0, sizeof(struct ioremap_desc));
 
-	walk_mem_res(start, end, flags, __ioremap_res_check);
+	walk_mem_res(start, end, desc, __ioremap_res_check);
 }
 
 /*
@@ -138,7 +153,7 @@ static void __iomem *__ioremap_caller(resource_size_t phys_addr,
 	resource_size_t last_addr;
 	const resource_size_t unaligned_phys_addr = phys_addr;
 	const unsigned long unaligned_size = size;
-	struct ioremap_mem_flags mem_flags;
+	struct ioremap_desc io_desc;
 	struct vm_struct *area;
 	enum page_cache_mode new_pcm;
 	pgprot_t prot;
@@ -157,12 +172,12 @@ static void __iomem *__ioremap_caller(resource_size_t phys_addr,
 		return NULL;
 	}
 
-	__ioremap_check_mem(phys_addr, size, &mem_flags);
+	__ioremap_check_mem(phys_addr, size, &io_desc);
 
 	/*
 	 * Don't allow anybody to remap normal RAM that we're using..
 	 */
-	if (mem_flags.system_ram) {
+	if (io_desc.flags & IORES_MAP_SYSTEM_RAM) {
 		WARN_ONCE(1, "ioremap on RAM at %pa - %pa\n",
 			  &phys_addr, &last_addr);
 		return NULL;
@@ -200,7 +215,7 @@ static void __iomem *__ioremap_caller(resource_size_t phys_addr,
 	 * resulting mapping.
 	 */
 	prot = PAGE_KERNEL_IO;
-	if ((sev_active() && mem_flags.desc_other) || encrypted)
+	if ((io_desc.flags & IORES_MAP_ENCRYPTED) || encrypted)
 		prot = pgprot_encrypted(prot);
 
 	switch (pcm) {
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 6ed59de48bd5..5db386cfc2d4 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -12,6 +12,7 @@
 #ifndef __ASSEMBLY__
 #include <linux/compiler.h>
 #include <linux/types.h>
+#include <linux/bits.h>
 /*
  * Resources are tree-like, allowing
  * nesting etc..
@@ -136,6 +137,14 @@ enum {
 	IORES_DESC_RESERVED			= 8,
 };
 
+/*
+ * Flags controlling ioremap() behavior.
+ */
+enum {
+	IORES_MAP_SYSTEM_RAM		= BIT(0),
+	IORES_MAP_ENCRYPTED		= BIT(1),
+};
+
 /* helpers to define resources */
 #define DEFINE_RES_NAMED(_start, _size, _name, _flags)			\
 	{								\
-- 
2.17.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
