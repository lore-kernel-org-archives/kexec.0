Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UDbNY-0000s3-Bm
 for kexec@lists.infradead.org; Thu, 07 Mar 2013 14:01:05 +0000
Received: from g1t0038.austin.hp.com (g1t0038.austin.hp.com [16.236.32.44])
 by g1t0026.austin.hp.com (Postfix) with ESMTP id D3F9FC0D3
 for <kexec@lists.infradead.org>; Thu,  7 Mar 2013 14:01:02 +0000 (UTC)
Subject: [RFC PATCH 3/5] crash dump bitmap: scan memory pages in kernel
 crash process
From: Jingbai Ma <jingbai.ma@hp.com>
Date: Thu, 07 Mar 2013 22:00:58 +0800
Message-ID: <20130307140057.28372.67797.stgit@k.asiapacific.hpqcorp.net>
In-Reply-To: <20130307140020.28372.34457.stgit@k.asiapacific.hpqcorp.net>
References: <20130307140020.28372.34457.stgit@k.asiapacific.hpqcorp.net>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: lisa.mitchell@hp.com

In the kernel crash process, call generate_crash_dump_bitmap() to scans
all memory pages, clear the bit for all excluded memory pages in the
reserved memory.

Signed-off-by: Jingbai Ma <jingbai.ma@hp.com>
---
 kernel/crash_dump_bitmap.c |  156 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/kexec.c             |    5 +
 2 files changed, 161 insertions(+), 0 deletions(-)

diff --git a/kernel/crash_dump_bitmap.c b/kernel/crash_dump_bitmap.c
index e743cdd..eed13ca 100644
--- a/kernel/crash_dump_bitmap.c
+++ b/kernel/crash_dump_bitmap.c
@@ -23,6 +23,8 @@
 
 #ifdef CONFIG_CRASH_DUMP_BITMAP
 
+#define virt_to_pfn(kaddr) (__pa(kaddr) >> PAGE_SHIFT)
+
 phys_addr_t crash_dump_bitmap_mem;
 EXPORT_SYMBOL(crash_dump_bitmap_mem);
 
@@ -35,6 +37,7 @@ EXPORT_SYMBOL(crash_dump_bitmap_ctrl);
 struct crash_dump_bitmap_info crash_dump_bitmap_info;
 EXPORT_SYMBOL(crash_dump_bitmap_info);
 
+
 /* Location of the reserved area for the crash_dump_bitmap */
 struct resource crash_dump_bitmap_res = {
 	.name  = "Crash dump bitmap",
@@ -42,4 +45,157 @@ struct resource crash_dump_bitmap_res = {
 	.end   = 0,
 	.flags = IORESOURCE_BUSY | IORESOURCE_MEM
 };
+
+inline void set_crash_dump_bitmap(unsigned long pfn, int val)
+{
+	phys_addr_t paddr = crash_dump_bitmap_info.bitmap + (pfn >> 3);
+	unsigned char *vaddr;
+	unsigned char bit = (pfn & 7);
+
+	if (unlikely(paddr > (crash_dump_bitmap_mem
+		+ crash_dump_bitmap_mem_size))) {
+		pr_err(
+		"crash_dump_bitmap: pfn exceed limit. pfn=%ld, addr=0x%llX\n",
+		pfn, paddr);
+		return;
+	}
+
+	vaddr = (unsigned char *)__va(paddr);
+
+	if (val)
+		*vaddr |= (1U << bit);
+	else
+		*vaddr &= (~(1U << bit));
+}
+
+void generate_crash_dump_bitmap(void)
+{
+	pg_data_t *pgdat;
+	struct zone *zone;
+	unsigned long flags;
+	int order, t;
+	struct list_head *curr;
+	unsigned long zone_free_pages;
+	phys_addr_t addr;
+
+	if (!crash_dump_bitmap_mem) {
+		pr_info("crash_dump_bitmap: no crash_dump_bitmap memory.\n");
+		return;
+	}
+
+	pr_info(
+	"Excluding pages: bitmap=%d, cache=%d, private=%d, user=%d, free=%d\n",
+		crash_dump_bitmap_ctrl.exclude_crash_dump_bitmap_pages,
+		crash_dump_bitmap_ctrl.exclude_cache_pages,
+		crash_dump_bitmap_ctrl.exclude_cache_private_pages,
+		crash_dump_bitmap_ctrl.exclude_user_pages,
+		crash_dump_bitmap_ctrl.exclude_free_pages);
+
+	crash_dump_bitmap_info.free_pages = 0;
+	crash_dump_bitmap_info.cache_pages = 0;
+	crash_dump_bitmap_info.cache_private_pages = 0;
+	crash_dump_bitmap_info.user_pages = 0;
+	crash_dump_bitmap_info.hwpoison_pages = 0;
+
+	/* Set all bits on bitmap */
+	memset(__va(crash_dump_bitmap_info.bitmap), 0xff,
+		crash_dump_bitmap_info.bitmap_size);
+
+	/* Exclude all crash_dump_bitmap pages */
+	if (crash_dump_bitmap_ctrl.exclude_crash_dump_bitmap_pages) {
+		for (addr = crash_dump_bitmap_mem; addr <
+			crash_dump_bitmap_mem + crash_dump_bitmap_mem_size;
+			addr += PAGE_SIZE)
+				set_crash_dump_bitmap(
+					virt_to_pfn(__va(addr)), 0);
+	}
+
+	/* Exclude unnecessary pages */
+	for_each_online_pgdat(pgdat) {
+		unsigned long i;
+		unsigned long flags;
+
+		pgdat_resize_lock(pgdat, &flags);
+		for (i = 0; i < pgdat->node_spanned_pages; i++) {
+			struct page *page;
+			unsigned long pfn = pgdat->node_start_pfn + i;
+
+			if (!pfn_valid(pfn))
+				continue;
+
+			page = pfn_to_page(pfn);
+
+			/* Exclude the cache pages without the private page */
+			if (crash_dump_bitmap_ctrl.exclude_cache_pages
+				&& (PageLRU(page) || PageSwapCache(page))
+				&& !page_has_private(page) && !PageAnon(page)) {
+					set_crash_dump_bitmap(pfn, 0);
+					crash_dump_bitmap_info.cache_pages++;
+			}
+			/* Exclude the cache pages with private page */
+			else if (
+			crash_dump_bitmap_ctrl.exclude_cache_private_pages
+				&& (PageLRU(page) || PageSwapCache(page))
+				&& !PageAnon(page)) {
+					set_crash_dump_bitmap(pfn, 0);
+				crash_dump_bitmap_info.cache_private_pages++;
+			}
+			/* Exclude the pages used by user process */
+			else if (crash_dump_bitmap_ctrl.exclude_user_pages
+					&& PageAnon(page)) {
+					set_crash_dump_bitmap(pfn, 0);
+					crash_dump_bitmap_info.user_pages++;
+			}
+#ifdef CONFIG_MEMORY_FAILURE
+			/* Exclude the hwpoison pages */
+			else if (PageHWPoison(page)) {
+					set_crash_dump_bitmap(pfn, 0);
+					crash_dump_bitmap_info.hwpoison_pages++;
+			}
+#endif
+		}
+		pgdat_resize_unlock(pgdat, &flags);
+	}
+
+	/* Exclude the free pages managed by a buddy system */
+	if (crash_dump_bitmap_ctrl.exclude_free_pages) {
+		for_each_populated_zone(zone) {
+			if (!zone->spanned_pages)
+				continue;
+
+			spin_lock_irqsave(&zone->lock, flags);
+
+			zone_free_pages = 0;
+			for_each_migratetype_order(order, t) {
+				list_for_each(
+				curr, &zone->free_area[order].free_list[t]) {
+					unsigned long i;
+					struct page *page = list_entry(curr,
+						struct page, lru);
+					for (i = 0; i < (1 << order); i++) {
+						set_crash_dump_bitmap(
+						page_to_pfn(page + i), 0);
+						zone_free_pages++;
+					crash_dump_bitmap_info.free_pages++;
+					}
+				}
+			}
+			spin_unlock_irqrestore(&zone->lock, flags);
+		}
+	}
+
+	pr_info("crash_dump_bitmap: excluded pages: cache=%ld, private=%ld\n",
+		crash_dump_bitmap_info.cache_pages,
+		crash_dump_bitmap_info.cache_private_pages);
+	pr_info("crash_dump_bitmap: excluded pages: user=%ld, free=%ld\n",
+		crash_dump_bitmap_info.user_pages,
+		crash_dump_bitmap_info.free_pages);
+	pr_info("crash_dump_bitmap: excluded pages: hwpoison=%ld\n",
+		crash_dump_bitmap_info.hwpoison_pages);
+}
+EXPORT_SYMBOL(generate_crash_dump_bitmap);
+#else
+void generate_crash_dump_bitmap(void)
+{
+}
 #endif /* CONFIG_CRASH_DUMP_BITMAP */
diff --git a/kernel/kexec.c b/kernel/kexec.c
index bddd3d7..ce00f0f 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -32,6 +32,7 @@
 #include <linux/vmalloc.h>
 #include <linux/swap.h>
 #include <linux/syscore_ops.h>
+#include <linux/crash_dump_bitmap.h>
 
 #include <asm/page.h>
 #include <asm/uaccess.h>
@@ -1097,6 +1098,7 @@ void crash_kexec(struct pt_regs *regs)
 			crash_setup_regs(&fixed_regs, regs);
 			crash_save_vmcoreinfo();
 			machine_crash_shutdown(&fixed_regs);
+			generate_crash_dump_bitmap();
 			machine_kexec(kexec_crash_image);
 		}
 		mutex_unlock(&kexec_mutex);
@@ -1495,6 +1497,9 @@ static int __init crash_save_vmcoreinfo_init(void)
 	VMCOREINFO_SYMBOL(mem_map);
 	VMCOREINFO_SYMBOL(contig_page_data);
 #endif
+#ifdef CONFIG_CRASH_DUMP_BITMAP
+	VMCOREINFO_SYMBOL(crash_dump_bitmap_info);
+#endif
 #ifdef CONFIG_SPARSEMEM
 	VMCOREINFO_SYMBOL(mem_section);
 	VMCOREINFO_LENGTH(mem_section, NR_SECTION_ROOTS);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
