Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1b8kr7-0007FM-NT
 for kexec@lists.infradead.org; Fri, 03 Jun 2016 08:53:26 +0000
From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 8/8] ARM: kexec: fix kexec for Keystone 2
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1b8koa-0004Hl-Ey@rmk-PC.armlinux.org.uk>
Date: Fri, 03 Jun 2016 09:50:48 +0100
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-ia64@vger.kernel.org, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Provide kexec with the boot view of memory by overriding the normal
kexec translation functions added in a previous patch.  We also need
to fix a call to memblock in machine_kexec_prepare() so that we
provide it with a running-view physical address rather than a boot-
view physical address.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/kexec.h    | 24 ++++++++++++++++++++++++
 arch/arm/kernel/machine_kexec.c |  2 +-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/kexec.h b/arch/arm/include/asm/kexec.h
index c2b9b4bdec00..1869af6bac5c 100644
--- a/arch/arm/include/asm/kexec.h
+++ b/arch/arm/include/asm/kexec.h
@@ -53,6 +53,30 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
 /* Function pointer to optional machine-specific reinitialization */
 extern void (*kexec_reinit)(void);
 
+static inline unsigned long phys_to_boot_phys(phys_addr_t phys)
+{
+	return phys_to_idmap(phys);
+}
+#define phys_to_boot_phys phys_to_boot_phys
+
+static inline phys_addr_t boot_phys_to_phys(unsigned long entry)
+{
+	return idmap_to_phys(entry);
+}
+#define boot_phys_to_phys boot_phys_to_phys
+
+static inline unsigned long page_to_boot_pfn(struct page *page)
+{
+	return page_to_pfn(page) + (arch_phys_to_idmap_offset >> PAGE_SHIFT);
+}
+#define page_to_boot_pfn page_to_boot_pfn
+
+static inline struct page *boot_pfn_to_page(unsigned long boot_pfn)
+{
+	return pfn_to_page(boot_pfn - (arch_phys_to_idmap_offset >> PAGE_SHIFT));
+}
+#define boot_pfn_to_page boot_pfn_to_page
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* CONFIG_KEXEC */
diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index 59fd0e24c56b..b18c1ea56bed 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -57,7 +57,7 @@ int machine_kexec_prepare(struct kimage *image)
 	for (i = 0; i < image->nr_segments; i++) {
 		current_segment = &image->segment[i];
 
-		if (!memblock_is_region_memory(current_segment->mem,
+		if (!memblock_is_region_memory(idmap_to_phys(current_segment->mem),
 					       current_segment->memsz))
 			return -EINVAL;
 
-- 
2.1.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
