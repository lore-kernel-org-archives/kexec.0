Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from pandora.arm.linux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aviKH-000330-GR
 for kexec@lists.infradead.org; Thu, 28 Apr 2016 09:33:38 +0000
In-Reply-To: <20160428092644.GX19428@n2100.arm.linux.org.uk>
References: <20160428092644.GX19428@n2100.arm.linux.org.uk>
From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 12/12] ARM: kexec: fix kexec for Keystone 2
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1aviFZ-0000jq-Ex@rmk-PC.arm.linux.org.uk>
Date: Thu, 28 Apr 2016 10:28:45 +0100
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
To: linux-arm-kernel@lists.infradead.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Jonathan Corbet <corbet@lwn.net>, Ian Campbell <ijc+devicetree@hellion.org.uk>, kexec@lists.infradead.org, Fenghua Yu <fenghua.yu@intel.com>, Haren Myneni <hbabu@us.ibm.com>, Rob Herring <robh+dt@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kumar Gala <galak@codeaurora.org>, Vivek Goyal <vgoyal@redhat.com>

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
