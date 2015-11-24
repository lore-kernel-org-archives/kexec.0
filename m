Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-Id: <5e852abb8e942ea49599a135e84673dcfd5f71f5.1448403503.git.geoff@infradead.org>
In-Reply-To: <cover.1448403503.git.geoff@infradead.org>
References: <cover.1448403503.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH v12 07/16] Revert "arm64: remove dead code"
Date: Tue, 24 Nov 2015 22:25:33 +0000
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
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, marc.zyngier@arm.com, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, christoffer.dall@linaro.org, linux-arm-kernel@lists.infradead.org

This reverts commit b08d4640a3dca68670fc5af2fe9205b395a02388.

Add back the setup_mm_for_reboot() needed for kexec.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/include/asm/mmu.h |  1 +
 arch/arm64/mm/mmu.c          | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 990124a..6326d11 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -29,6 +29,7 @@ typedef struct {
 #define ASID(mm)	((mm)->context.id.counter & 0xffff)
 
 extern void paging_init(void);
+extern void setup_mm_for_reboot(void);
 extern void __iomem *early_io_map(phys_addr_t phys, unsigned long virt);
 extern void init_mem_pgprot(void);
 extern void create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index abb66f8..c5bce3c 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -515,6 +515,17 @@ void __init paging_init(void)
 }
 
 /*
+ * Enable the identity mapping to allow the MMU disabling.
+ */
+void setup_mm_for_reboot(void)
+{
+	cpu_set_reserved_ttbr0();
+	flush_tlb_all();
+	cpu_set_idmap_tcr_t0sz();
+	cpu_switch_mm(idmap_pg_dir, &init_mm);
+}
+
+/*
  * Check whether a kernel address is valid (derived from arch/x86/).
  */
 int kern_addr_valid(unsigned long addr)
-- 
2.5.0



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
