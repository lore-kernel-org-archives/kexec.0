Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mgwkm03.jp.fujitsu.com ([202.219.69.170])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtSqa-0006TD-7n
 for kexec@lists.infradead.org; Thu, 09 Jul 2020 09:28:06 +0000
Received: from m3050.s.css.fujitsu.com (msm.b.css.fujitsu.com [10.134.21.208])
 by kw-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id 4EF4DAC00D4
 for <kexec@lists.infradead.org>; Thu,  9 Jul 2020 18:27:53 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@fujitsu.com>
Subject: [PATCH] sadump,
 kaslr: fix failure of calculating kaslr_offset due to an sadump
 format restriction
Date: Thu,  9 Jul 2020 18:27:49 +0900
Message-Id: <1594286869-1321-1-git-send-email-d.hatayama@fujitsu.com>
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
To: k-hagio-ab@nec.com, kexec@lists.infradead.org
Cc: HATAYAMA Daisuke <d.hatayama@fujitsu.com>

We faced recently a memory dump collected by sadump where unused part
of register values are non-zero. For the crash dump, calculating
kaslr_offset fails because it is based on the assumption that unused
part of register values in the sadump format are always zero cleared.

The problem is that used and unused part of register values are
rigorously indistinguishable in the sadump format. Although there is
kernel data structure that represents a map between logical cpu
numbers and lapic ids, they cannot be used in order to calculate
kaslr_offset.

To fix this, we have no choice but use a trial-and-error approach: try
to use each entry of register values in order until we find a good
pair of cr3 and idtr by which we can refer to linux_banner symbol as
expected.

Signed-off-by: HATAYAMA Daisuke <d.hatayama@fujitsu.com>
---
 sadump_info.c | 140 ++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 97 insertions(+), 43 deletions(-)

diff --git a/sadump_info.c b/sadump_info.c
index 46867ce..aa9a048 100644
--- a/sadump_info.c
+++ b/sadump_info.c
@@ -101,6 +101,7 @@ static int lookup_diskset(unsigned long long whole_offset, int *diskid,
 			  unsigned long long *disk_offset);
 static int max_mask_cpu(void);
 static int cpu_online_mask_init(void);
+static int linux_banner_sanity_check(ulong cr3);
 static int per_cpu_init(void);
 static int get_data_from_elf_note_desc(const char *note_buf, uint32_t n_descsz,
 				       char *name, uint32_t n_type, char **data);
@@ -1293,6 +1294,30 @@ finish:
 	return ret;
 }
 
+static int linux_banner_sanity_check(ulong cr3)
+{
+	unsigned long linux_banner_paddr;
+	char buf[sizeof("Linux version")];
+
+	linux_banner_paddr = vtop4_x86_64_pagetable(SYMBOL(linux_banner), cr3);
+	if (linux_banner_paddr == NOT_PADDR) {
+		DEBUG_MSG("sadump: linux_banner address translation failed\n");
+		return FALSE;
+	}
+
+	if (!readmem(PADDR, linux_banner_paddr, &buf, sizeof(buf))) {
+		DEBUG_MSG("sadump: reading linux_banner failed\n");
+		return FALSE;
+	}
+
+	if (!STRNEQ(buf, "Linux version")) {
+		DEBUG_MSG("sadump: linux_banner sanity check failed\n");
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
 /*
  * Calculate kaslr_offset and phys_base
  *
@@ -1370,59 +1395,86 @@ calc_kaslr_offset(void)
 {
 	struct sadump_header *sh = si->sh_memory;
 	uint64_t idtr = 0, cr3 = 0, idtr_paddr;
-	struct sadump_smram_cpu_state smram, zero;
+	struct sadump_smram_cpu_state smram;
 	int apicid;
 	unsigned long divide_error_vmcore, divide_error_vmlinux;
 	unsigned long kaslr_offset, phys_base;
 	unsigned long kaslr_offset_kdump, phys_base_kdump;
+	int sanity_check_passed = FALSE;
 
-	memset(&zero, 0, sizeof(zero));
 	for (apicid = 0; apicid < sh->nr_cpus; ++apicid) {
-		if (!get_smram_cpu_state(apicid, &smram)) {
-			ERRMSG("get_smram_cpu_state error\n");
+
+                DEBUG_MSG("sadump: apicid: %d\n", apicid);
+
+                if (!get_smram_cpu_state(apicid, &smram)) {
+                        ERRMSG("get_smram_cpu_state error\n");
+                        return FALSE;
+                }
+
+                idtr = ((uint64_t)smram.IdtUpper)<<32|(uint64_t)smram.IdtLower;
+
+                if (!smram.Cr3 || !idtr) {
+                        DEBUG_MSG("sadump: cr3: %lx idt: %lx, skipped\n",
+                                  smram.Cr3,
+                                  idtr);
+                        continue;
+                }
+
+                if ((SYMBOL(pti_init) != NOT_FOUND_SYMBOL) ||
+                    (SYMBOL(kaiser_init) != NOT_FOUND_SYMBOL))
+                        cr3 = smram.Cr3 & ~(CR3_PCID_MASK|PTI_USER_PGTABLE_MASK);
+                else
+                        cr3 = smram.Cr3 & ~CR3_PCID_MASK;
+
+                /* Convert virtual address of IDT table to physical address */
+		idtr_paddr = vtop4_x86_64_pagetable(idtr, cr3);
+                if (idtr_paddr == NOT_PADDR) {
+                        DEBUG_MSG("sadump: converting IDT physical address "
+				  "failed.\n");
+                        continue;
+                }
+
+		/* Now we can calculate kaslr_offset and phys_base */
+		divide_error_vmlinux = SYMBOL(divide_error);
+		divide_error_vmcore = get_vec0_addr(idtr_paddr);
+		kaslr_offset = divide_error_vmcore - divide_error_vmlinux;
+		phys_base = idtr_paddr -
+			(SYMBOL(idt_table)+kaslr_offset-__START_KERNEL_map);
+
+		info->kaslr_offset = kaslr_offset;
+		info->phys_base = phys_base;
+
+		DEBUG_MSG("sadump: idtr=%" PRIx64 "\n", idtr);
+		DEBUG_MSG("sadump: cr3=%" PRIx64 "\n", cr3);
+		DEBUG_MSG("sadump: idtr(phys)=%" PRIx64 "\n", idtr_paddr);
+		DEBUG_MSG("sadump: devide_error(vmlinux)=%lx\n",
+			  divide_error_vmlinux);
+		DEBUG_MSG("sadump: devide_error(vmcore)=%lx\n",
+			  divide_error_vmcore);
+
+		/* Reload symbol */
+		if (!get_symbol_info()) {
+			ERRMSG("Reading symbol table failed\n");
 			return FALSE;
 		}
 
-		if (memcmp(&smram, &zero, sizeof(smram)) != 0)
+		/* Sanity check */
+		if (linux_banner_sanity_check(cr3)) {
+			sanity_check_passed = TRUE;
 			break;
-	}
-	if (apicid >= sh->nr_cpus) {
-		ERRMSG("Can't get smram state\n");
-		return FALSE;
-	}
-
-	idtr = ((uint64_t)smram.IdtUpper)<<32 | (uint64_t)smram.IdtLower;
-	if ((SYMBOL(pti_init) != NOT_FOUND_SYMBOL) ||
-	    (SYMBOL(kaiser_init) != NOT_FOUND_SYMBOL))
-		cr3 = smram.Cr3 & ~(CR3_PCID_MASK|PTI_USER_PGTABLE_MASK);
-	else
-		cr3 = smram.Cr3 & ~CR3_PCID_MASK;
-
-	/* Convert virtual address of IDT table to physical address */
-	if ((idtr_paddr = vtop4_x86_64_pagetable(idtr, cr3)) == NOT_PADDR)
-		return FALSE;
-
-	/* Now we can calculate kaslr_offset and phys_base */
-	divide_error_vmlinux = SYMBOL(divide_error);
-	divide_error_vmcore = get_vec0_addr(idtr_paddr);
-	kaslr_offset = divide_error_vmcore - divide_error_vmlinux;
-	phys_base = idtr_paddr -
-		(SYMBOL(idt_table) + kaslr_offset - __START_KERNEL_map);
-
-	info->kaslr_offset = kaslr_offset;
-	info->phys_base = phys_base;
+		}
 
-	DEBUG_MSG("sadump: idtr=%" PRIx64 "\n", idtr);
-	DEBUG_MSG("sadump: cr3=%" PRIx64 "\n", cr3);
-	DEBUG_MSG("sadump: idtr(phys)=%" PRIx64 "\n", idtr_paddr);
-	DEBUG_MSG("sadump: devide_error(vmlinux)=%lx\n",
-		divide_error_vmlinux);
-	DEBUG_MSG("sadump: devide_error(vmcore)=%lx\n",
-		divide_error_vmcore);
+		info->kaslr_offset = 0;
+		info->phys_base = 0;
+	}
 
-	/* Reload symbol */
-	if (!get_symbol_info())
-		return FALSE;
+	if (!sanity_check_passed) {
+		ERRMSG("failed to calculate kaslr_offset and phys_base; "
+		       "default to 0\n");
+		info->kaslr_offset = 0;
+		info->phys_base = 0;
+		return TRUE;
+	}
 
 	/*
 	 * Check if current kaslr_offset/phys_base is for 1st kernel or 2nd
@@ -1430,13 +1482,15 @@ calc_kaslr_offset(void)
 	 * from vmcoreinfo
 	 */
 	if (get_kaslr_offset_from_vmcoreinfo(cr3, &kaslr_offset_kdump,
-					    &phys_base_kdump)) {
+					     &phys_base_kdump)) {
 		info->kaslr_offset = kaslr_offset_kdump;
 		info->phys_base = phys_base_kdump;
 
 		/* Reload symbol */
-		if (!get_symbol_info())
+		if (!get_symbol_info()) {
+			ERRMSG("Reading symbol table failed\n");
 			return FALSE;
+		}
 	}
 
 	DEBUG_MSG("sadump: kaslr_offset=%lx\n", info->kaslr_offset);
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
