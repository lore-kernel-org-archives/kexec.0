Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yw0-x243.google.com ([2607:f8b0:4002:c05::243])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1de7lH-0006KD-QI
 for kexec@lists.infradead.org; Sat, 05 Aug 2017 22:41:37 +0000
Received: by mail-yw0-x243.google.com with SMTP id n83so2977956ywn.3
 for <kexec@lists.infradead.org>; Sat, 05 Aug 2017 15:41:15 -0700 (PDT)
From: Bradley Bolen <bradleybolen@gmail.com>
Subject: [PATCH] makedumpfile: arm64: Fix page table walk of 1GB section
Date: Sat,  5 Aug 2017 18:41:07 -0400
Message-Id: <20170805224107.4966-2-bradleybolen@gmail.com>
In-Reply-To: <20170805224107.4966-1-bradleybolen@gmail.com>
References: <20170805224107.4966-1-bradleybolen@gmail.com>
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
To: kexec@lists.infradead.org
Cc: panand@redhat.com, Bradley Bolen <bradleybolen@gmail.com>

makedumpfile was generating large (> 500MB) vmcore files for an arm64
board with 2GB of DRAM.  It was not excluding any pages because the
mem_map address was not being converted correctly.

readmem: Can't convert a virtual address(ffffffc07fff6000) to physical
address.
readmem: type_addr: 0, addr:ffffffc07fff6000, size:16
section_mem_map_addr: Can't get a struct mem_section(ffffffc07fff6000).
mem_map (0)
mem_map : 0

makedumpfile was not handling 1GB sections in the PGD and was trying to
drill down to a PTE in which it was trying to dereference invalid
memory.  This patch adds code to check the PGD for a section type and
handle it instead of treating it as a table entry.

Signed-off-by: Bradley Bolen <bradleybolen@gmail.com>
---
 arch/arm64.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64.c b/arch/arm64.c
index 958f57f..cae4b70 100644
--- a/arch/arm64.c
+++ b/arch/arm64.c
@@ -57,6 +57,8 @@ static unsigned long kimage_voffset;
 #define PGDIR_SHIFT		((PAGESHIFT() - 3) * pgtable_level + 3)
 #define PTRS_PER_PGD		(1 << (va_bits - PGDIR_SHIFT))
 #define PUD_SHIFT		get_pud_shift_arm64()
+#define PUD_SIZE		(1UL << PUD_SHIFT)
+#define PUD_MASK		(~(PUD_SIZE - 1))
 #define PTRS_PER_PTE		(1 << (PAGESHIFT() - 3))
 #define PTRS_PER_PUD		PTRS_PER_PTE
 #define PMD_SHIFT		((PAGESHIFT() - 3) * 2 + 3)
@@ -79,6 +81,10 @@ static unsigned long kimage_voffset;
 #define PMD_TYPE_SECT		1
 #define PMD_TYPE_TABLE		3
 
+#define PUD_TYPE_MASK		3
+#define PUD_TYPE_SECT		1
+#define PUD_TYPE_TABLE		3
+
 #define pgd_index(vaddr) 		(((vaddr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
 #define pgd_offset(pgdir, vaddr)	((pgd_t *)(pgdir) + pgd_index(vaddr))
 
@@ -253,6 +259,13 @@ vaddr_to_paddr_arm64(unsigned long vaddr)
 		return NOT_PADDR;
 	}
 
+	if ((pud_val(pudv) & PUD_TYPE_MASK) == PUD_TYPE_SECT) {
+		/* 1GB section */
+		paddr = (pud_val(pudv) & (PUD_MASK & PMD_SECTION_MASK))
+					+ (vaddr & (PUD_SIZE - 1));
+		return paddr;
+	}
+
 	pmda = pmd_offset(puda, &pudv, vaddr);
 	if (!readmem(PADDR, (unsigned long long)pmda, &pmdv, sizeof(pmdv))) {
 		ERRMSG("Can't read pmd\n");
-- 
1.9.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
