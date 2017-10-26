Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mgwym03.jp.fujitsu.com ([211.128.242.42])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1e7gPR-0001X2-Oq
 for kexec@lists.infradead.org; Thu, 26 Oct 2017 11:33:16 +0000
Received: from g01jpfmpwyt02.exch.g01.fujitsu.local
 (g01jpfmpwyt02.exch.g01.fujitsu.local [10.128.193.56])
 by yt-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id 6768CAC01AF
 for <kexec@lists.infradead.org>; Thu, 26 Oct 2017 20:32:50 +0900 (JST)
From: Takao Indoh <indou.takao@jp.fujitsu.com>
Subject: [makedumpfile PATCH v3 3/4] sadump: Fix a KASLR problem of sadump
Date: Thu, 26 Oct 2017 20:32:26 +0900
Message-ID: <20171026113227.36740-4-indou.takao@jp.fujitsu.com>
In-Reply-To: <20171026113227.36740-1-indou.takao@jp.fujitsu.com>
References: <20171026113227.36740-1-indou.takao@jp.fujitsu.com>
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
To: ats-kumagai@wm.jp.nec.com, d.hatayama@jp.fujitsu.com
Cc: kexec@lists.infradead.org

This patch fix a problem that makedumpfile cannot handle a dumpfile
which is captured by sadump in KASLR enabled kernel.

When KASLR feature is enabled, a kernel is placed on the memory randomly
and therefore makedumpfile cannot handle a dumpfile captured by sadump
because addresses of kernel symbols in System.map or vmlinux are
different from actual addresses.

To solve this problem, we need to calculate kaslr offset(the difference
between original symbol address and actual address) and phys_base, and
adjust symbol table of makedumpfile. In the case of dumpfile of kdump,
these information is included in the header, but dumpfile of sadump does
not have such a information.

This patch calculate kaslr offset and phys_base to solve this problem.
Please see the comment in the calc_kaslr_offset() for the detail idea.
The basic idea is getting register (IDTR and CR3) from dump header, and
calculate kaslr_offset/phys_base using them.

Signed-off-by: Takao Indoh <indou.takao@jp.fujitsu.com>
---
 makedumpfile.c |  10 ++++
 makedumpfile.h |   5 +-
 sadump_info.c  | 143 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 155 insertions(+), 3 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 5f2ca7d..0375495 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1554,6 +1554,9 @@ get_symbol_info(void)
 	SYMBOL_INIT(demote_segment_4k, "demote_segment_4k");
 	SYMBOL_INIT(cur_cpu_spec, "cur_cpu_spec");
 
+	SYMBOL_INIT(divide_error, "divide_error");
+	SYMBOL_INIT(idt_table, "idt_table");
+
 	return TRUE;
 }
 
@@ -2249,6 +2252,13 @@ write_vmcoreinfo_data(void)
 	WRITE_NUMBER_UNSIGNED("kimage_voffset", kimage_voffset);
 #endif
 
+	if (info->phys_base)
+		fprintf(info->file_vmcoreinfo, "%s%lu\n", STR_NUMBER("phys_base"),
+		        info->phys_base);
+	if (info->kaslr_offset)
+		fprintf(info->file_vmcoreinfo, "%s%lx\n", STR_KERNELOFFSET,
+		        info->kaslr_offset);
+
 	/*
 	 * write the source file of 1st kernel
 	 */
diff --git a/makedumpfile.h b/makedumpfile.h
index f48dc0b..5f814e7 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -45,6 +45,7 @@
 #include "sadump_mod.h"
 #include <pthread.h>
 #include <semaphore.h>
+#include <inttypes.h>
 
 #define VMEMMAPSTART 0xffffea0000000000UL
 #define BITS_PER_WORD 64
@@ -1599,6 +1600,8 @@ struct symbol_table {
 	unsigned long long	cpu_online_mask;
 	unsigned long long	__cpu_online_mask;
 	unsigned long long	kexec_crash_image;
+	unsigned long long	divide_error;
+	unsigned long long	idt_table;
 
 	/*
 	 * symbols on ppc64 arch
@@ -1960,7 +1963,7 @@ int iomem_for_each_line(char *match, int (*callback)(void *data, int nr,
 						     unsigned long length),
 			void *data);
 int is_bigendian(void);
-
+int get_symbol_info(void);
 
 /*
  * for Xen extraction
diff --git a/sadump_info.c b/sadump_info.c
index 7dd22e7..29ccef8 100644
--- a/sadump_info.c
+++ b/sadump_info.c
@@ -1035,6 +1035,138 @@ sadump_get_max_mapnr(void)
 
 #ifdef __x86_64__
 
+/*
+ * Get address of vector0 interrupt handler (Devide Error) form Interrupt
+ * Descriptor Table.
+ */
+static unsigned long
+get_vec0_addr(ulong idtr)
+{
+	struct gate_struct64 {
+		uint16_t offset_low;
+		uint16_t segment;
+		uint32_t ist : 3, zero0 : 5, type : 5, dpl : 2, p : 1;
+		uint16_t offset_middle;
+		uint32_t offset_high;
+		uint32_t zero1;
+	} __attribute__((packed)) gate;
+
+	readmem(PADDR, idtr, &gate, sizeof(gate));
+
+	return ((ulong)gate.offset_high << 32)
+		+ ((ulong)gate.offset_middle << 16)
+		+ gate.offset_low;
+}
+
+/*
+ * Calculate kaslr_offset and phys_base
+ *
+ * kaslr_offset:
+ *   The difference between original address in vmlinux and actual address
+ *   placed randomly by kaslr feature. To be more accurate,
+ *   kaslr_offset = actual address  - original address
+ *
+ * phys_base:
+ *   Physical address where the kerenel is placed. In other words, it's a
+ *   physical address of __START_KERNEL_map. This is also decided randomly by
+ *   kaslr.
+ *
+ * kaslr offset and phys_base are calculated as follows:
+ *
+ * kaslr_offset:
+ * 1) Get IDTR and CR3 value from the dump header.
+ * 2) Get a virtual address of IDT from IDTR value
+ *    --- (A)
+ * 3) Translate (A) to physical address using CR3, which points a top of
+ *    page table.
+ *    --- (B)
+ * 4) Get an address of vector0 (Devide Error) interrupt handler from
+ *    IDT, which are pointed by (B).
+ *    --- (C)
+ * 5) Get an address of symbol "divide_error" form vmlinux
+ *    --- (D)
+ *
+ * Now we have two addresses:
+ * (C)-> Actual address of "divide_error"
+ * (D)-> Original address of "divide_error" in the vmlinux
+ *
+ * kaslr_offset can be calculated by the difference between these two
+ * value.
+ *
+ * phys_base;
+ * 1) Get IDT virtual address from vmlinux
+ *    --- (E)
+ *
+ * So phys_base can be calculated using relationship of directly mapped
+ * address.
+ *
+ * phys_base =
+ *   Physical address(B) -
+ *   (Virtual address(E) + kaslr_offset - __START_KERNEL_map)
+ *
+ * Note that the address (A) cannot be used instead of (E) because (A) is
+ * not direct map address, it's a fixed map address.
+ */
+int
+calc_kaslr_offset(void)
+{
+	struct sadump_header *sh = si->sh_memory;
+	uint64_t idtr = 0, cr3 = 0, idtr_paddr;
+	struct sadump_smram_cpu_state smram, zero;
+	int apicid;
+	unsigned long divide_error_vmcore, divide_error_vmlinux;
+	unsigned long kaslr_offset, phys_base;
+
+	memset(&zero, 0, sizeof(zero));
+	for (apicid = 0; apicid < sh->nr_cpus; ++apicid) {
+		if (!get_smram_cpu_state(apicid, &smram)) {
+			ERRMSG("get_smram_cpu_state error\n");
+			return FALSE;
+		}
+
+		if (memcmp(&smram, &zero, sizeof(smram)) != 0)
+			break;
+	}
+	if (apicid >= sh->nr_cpus) {
+		ERRMSG("Can't get smram state\n");
+		return FALSE;
+	}
+
+	idtr = ((uint64_t)smram.IdtUpper)<<32 | (uint64_t)smram.IdtLower;
+	cr3 = smram.Cr3;
+
+	/* Convert virtual address of IDT table to physical address */
+	if ((idtr_paddr = vtop4_x86_64_pagetable(idtr, cr3)) == NOT_PADDR)
+		return FALSE;
+
+	/* Now we can calculate kaslr_offset and phys_base */
+	divide_error_vmlinux = SYMBOL(divide_error);
+	divide_error_vmcore = get_vec0_addr(idtr_paddr);
+	kaslr_offset = divide_error_vmcore - divide_error_vmlinux;
+	phys_base = idtr_paddr -
+		(SYMBOL(idt_table) + kaslr_offset - __START_KERNEL_map);
+
+	info->kaslr_offset = kaslr_offset;
+	info->phys_base = phys_base;
+
+	DEBUG_MSG("sadump: idtr=%" PRIx64 "\n", idtr);
+	DEBUG_MSG("sadump: cr3=%" PRIx64 "\n", cr3);
+	DEBUG_MSG("sadump: idtr(phys)=%" PRIx64 "\n", idtr_paddr);
+	DEBUG_MSG("sadump: devide_error(vmlinux)=%lx\n",
+		divide_error_vmlinux);
+	DEBUG_MSG("sadump: devide_error(vmcore)=%lx\n",
+		divide_error_vmcore);
+
+	/* Reload symbol */
+	if (!get_symbol_info())
+		return FALSE;
+
+	DEBUG_MSG("sadump: kaslr_offset=%lx\n", info->kaslr_offset);
+	DEBUG_MSG("sadump: phys_base=%lx\n", info->phys_base);
+
+	return TRUE;
+}
+
 int
 sadump_virt_phys_base(void)
 {
@@ -1065,6 +1197,9 @@ sadump_virt_phys_base(void)
 	}
 
 failed:
+	if (calc_kaslr_offset())
+		return TRUE;
+
 	info->phys_base = 0;
 
 	DEBUG_MSG("sadump: failed to calculate phys_base; default to 0\n");
@@ -1518,10 +1653,14 @@ cpu_to_apicid(int cpu, int *apicid)
 		if (!readmem(VADDR, SYMBOL(x86_bios_cpu_apicid_early_ptr),
 			     &early_ptr, sizeof(early_ptr)))
 			return FALSE;
-
+		/*
+		 * Note: SYMBOL(name) value is adjusted by info->kaslr_offset,
+		 * but per_cpu symbol does not need to be adjusted becasue it
+		 * is not affected by kaslr.
+		 */
 		apicid_addr = early_ptr
 			? SYMBOL(x86_bios_cpu_apicid_early_map)+cpu*sizeof(uint16_t)
-			: per_cpu_ptr(SYMBOL(x86_bios_cpu_apicid), cpu);
+			: per_cpu_ptr(SYMBOL(x86_bios_cpu_apicid) - info->kaslr_offset, cpu);
 
 		if (!readmem(VADDR, apicid_addr, &apicid_u16, sizeof(uint16_t)))
 			return FALSE;
-- 
2.9.5



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
