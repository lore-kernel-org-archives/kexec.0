Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VjTCm-0000bz-3Q
 for kexec@lists.infradead.org; Thu, 21 Nov 2013 12:17:58 +0000
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Thu, 21 Nov 2013 22:07:17 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2A7692BB0053
 for <kexec@lists.infradead.org>; Thu, 21 Nov 2013 23:07:14 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rALC71sS53805104
 for <kexec@lists.infradead.org>; Thu, 21 Nov 2013 23:07:01 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rALC7DdF004365
 for <kexec@lists.infradead.org>; Thu, 21 Nov 2013 23:07:13 +1100
Subject: [PATCH v3] makedumpfile: Support to filter dump for kernels that
 use CONFIG_SPARSEMEM_VMEMMAP
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Thu, 21 Nov 2013 17:37:01 +0530
Message-ID: <20131121120701.23648.31452.stgit@localhost.localdomain>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Ken'ichi <oomichi@mxs.nes.nec.co.jp>, Tachibana-san <tachibana@mxm.nes.nec.co.jp>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, Kexec-ml <kexec@lists.infradead.org>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Onkar N Mahajan <onmahaja@in.ibm.com>, Haren Myneni <hbabu@us.ibm.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

Makedumpfile fails to filter dump for kernels build with CONFIG_SPARSEMEM_VMEMMAP
enabled as it fails to do vmemmap translations. So far, makedumpfile on ppc64 never
had to deal with vmemmap addresses (vmemmap regions) seperately to filter ppc64
crash dumps as vmemmap regions where mapped in zone normal. But with the inclusion
of CONFIG_SPARSEMEM_VMEMMAP config option in recent kernels, vmemmap memory regions
are mapped outside zone normal. There is a need to handle vmemmap to physical address
translation seperately in this scenario. This patch provides support in makedumpfile
tool to do vmemmap to physical address translation when vmemmap regions are mapped
outside zone normal. Some kernel symbols are needed in vmcoreinfo for this changes to
be effective. The kernel patch that adds the necessary symbols to vmcoreinfo has been
posted to linuxppc devel mailing list. This patch is influenced by vmemmap to physical
address translation support code in crash utility. It is has been tested successfully
at all dump filtering levels on kernel dumps that have CONFIG_SPARSEMEM_VMEMMAP enabled
and kernel dumps with CONFIG_SPARSEMEM_VMEMMAP disabled as well. Also, successfully
tested dump filtering on already filtered vmcores (re-filtering). The patch applies
cleanly on version 1.5.4 of makedumpfile.

Changes from v2 to v3:
1. Changed 'flags' to a more specific name, 'flags_vmemmap'  in DumpInfo structure
2. Freeing vmemmap_buf in get_vmemmap_list_info(), in success scenario as well

Changes in v2:
1. Fixed return value when vmemmap list initialization fails
2. Fixed coding style issue

Signed-off-by: Onkar N Mahajan <onmahaja@in.ibm.com>
Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 arch/ppc64.c   |  177 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 makedumpfile.c |   38 ++++++++++++
 makedumpfile.h |   42 +++++++++++++
 3 files changed, 251 insertions(+), 6 deletions(-)

diff --git a/arch/ppc64.c b/arch/ppc64.c
index c229ede..05738e7 100644
--- a/arch/ppc64.c
+++ b/arch/ppc64.c
@@ -24,6 +24,154 @@
 #include "../elf_info.h"
 #include "../makedumpfile.h"
 
+/*
+ * This function traverses vmemmap list to get the count of vmemmap regions
+ * and populates the regions' info in info->vmemmap_list[]
+ */
+static int
+get_vmemmap_list_info(ulong head)
+{
+	int   i, cnt;
+	long  backing_size, virt_addr_offset, phys_offset, list_offset;
+	ulong curr, next;
+	char  *vmemmap_buf = NULL;
+
+	backing_size		= SIZE(vmemmap_backing);
+	virt_addr_offset	= OFFSET(vmemmap_backing.virt_addr);
+	phys_offset		= OFFSET(vmemmap_backing.phys);
+	list_offset		= OFFSET(vmemmap_backing.list);
+	info->vmemmap_list = NULL;
+
+	/*
+	 * Get list count by traversing the vmemmap list
+	 */
+	cnt = 0;
+	curr = head;
+	next = 0;
+	do {
+		if (!readmem(VADDR, (curr + list_offset), &next,
+			     sizeof(next))) {
+			ERRMSG("Can't get vmemmap region addresses\n");
+			goto err;
+		}
+		curr = next;
+		cnt++;
+	} while ((next != 0) && (next != head));
+
+	/*
+	 * Using temporary buffer to save vmemmap region information
+	 */
+	vmemmap_buf = calloc(1, backing_size);
+	if (vmemmap_buf == NULL) {
+		ERRMSG("Can't allocate memory for vmemmap_buf. %s\n",
+		       strerror(errno));
+		goto err;
+	}
+
+	info->vmemmap_list = calloc(1, cnt * sizeof(struct ppc64_vmemmap));
+	if (info->vmemmap_list == NULL) {
+		ERRMSG("Can't allocate memory for vmemmap_list. %s\n",
+		       strerror(errno));
+		goto err;
+	}
+
+	curr = head;
+	for (i = 0; i < cnt; i++) {
+		if (!readmem(VADDR, curr, vmemmap_buf, backing_size)) {
+			ERRMSG("Can't get vmemmap region info\n");
+			goto err;
+		}
+
+		info->vmemmap_list[i].phys = ULONG(vmemmap_buf + phys_offset);
+		info->vmemmap_list[i].virt = ULONG(vmemmap_buf +
+						   virt_addr_offset);
+		curr = ULONG(vmemmap_buf + list_offset);
+
+		if (info->vmemmap_list[i].virt < info->vmemmap_start)
+			info->vmemmap_start = info->vmemmap_list[i].virt;
+
+		if ((info->vmemmap_list[i].virt + info->vmemmap_psize) >
+		    info->vmemmap_end)
+			info->vmemmap_end = (info->vmemmap_list[i].virt +
+					     info->vmemmap_psize);
+	}
+
+	free(vmemmap_buf);
+	return cnt;
+err:
+	free(vmemmap_buf);
+	free(info->vmemmap_list);
+	return 0;
+}
+
+/*
+ *  Verify that the kernel has made the vmemmap list available,
+ *  and if so, stash the relevant data required to make vtop
+ *  translations.
+ */
+static int
+ppc64_vmemmap_init(void)
+{
+	int psize, shift;
+	ulong head;
+
+	if ((SYMBOL(vmemmap_list) == NOT_FOUND_SYMBOL)
+	    || (SYMBOL(mmu_psize_defs) == NOT_FOUND_SYMBOL)
+	    || (SYMBOL(mmu_vmemmap_psize) == NOT_FOUND_SYMBOL)
+	    || (SIZE(vmemmap_backing) == NOT_FOUND_STRUCTURE)
+	    || (SIZE(mmu_psize_def) == NOT_FOUND_STRUCTURE)
+	    || (OFFSET(mmu_psize_def.shift) == NOT_FOUND_STRUCTURE)
+	    || (OFFSET(vmemmap_backing.phys) == NOT_FOUND_STRUCTURE)
+	    || (OFFSET(vmemmap_backing.virt_addr) == NOT_FOUND_STRUCTURE)
+	    || (OFFSET(vmemmap_backing.list) == NOT_FOUND_STRUCTURE))
+		return FALSE;
+
+	if (!readmem(VADDR, SYMBOL(mmu_vmemmap_psize), &psize, sizeof(int)))
+		return FALSE;
+
+	if (!readmem(VADDR, SYMBOL(mmu_psize_defs) +
+		     (SIZE(mmu_psize_def) * psize) +
+		     OFFSET(mmu_psize_def.shift), &shift, sizeof(int)))
+		return FALSE;
+	info->vmemmap_psize = 1 << shift;
+
+	if (!readmem(VADDR, SYMBOL(vmemmap_list), &head, sizeof(unsigned long)))
+		return FALSE;
+
+	/*
+	 * Get vmemmap list count and populate vmemmap regions info
+	 */
+	info->vmemmap_cnt = get_vmemmap_list_info(head);
+	if (info->vmemmap_cnt == 0)
+		return FALSE;
+
+	info->flags_vmemmap |= VMEMMAP_AWARE;
+	return TRUE;
+}
+
+/*
+ *  If the vmemmap address translation information is stored in the kernel,
+ *  make the translation.
+ */
+static unsigned long long
+ppc64_vmemmap_to_phys(unsigned long vaddr)
+{
+	int	i;
+	ulong	offset;
+	unsigned long long paddr = NOT_PADDR;
+
+	for (i = 0; i < info->vmemmap_cnt; i++) {
+		if ((vaddr >= info->vmemmap_list[i].virt) && (vaddr <
+		    (info->vmemmap_list[i].virt + info->vmemmap_psize))) {
+			offset = vaddr - info->vmemmap_list[i].virt;
+			paddr = info->vmemmap_list[i].phys + offset;
+			break;
+		}
+	}
+
+	return paddr;
+}
+
 int
 set_ppc64_max_physmem_bits(void)
 {
@@ -49,7 +197,7 @@ set_ppc64_max_physmem_bits(void)
 int
 get_machdep_info_ppc64(void)
 {
-	unsigned long vmlist, vmalloc_start;
+	unsigned long vmlist, vmap_area_list, vmalloc_start;
 
 	info->section_size_bits = _SECTION_SIZE_BITS;
 	if (!set_ppc64_max_physmem_bits()) {
@@ -103,6 +251,16 @@ get_machdep_info_ppc64(void)
 	info->vmalloc_start = vmalloc_start;
 	DEBUG_MSG("vmalloc_start: %lx\n", vmalloc_start);
 
+	if (SYMBOL(vmemmap_list) != NOT_FOUND_SYMBOL) {
+		info->vmemmap_start = VMEMMAP_REGION_ID << REGION_SHIFT;
+		info->vmemmap_end = info->vmemmap_start;
+		if (ppc64_vmemmap_init() == FALSE) {
+			ERRMSG("Can't get vmemmap list info.\n");
+			return FALSE;
+		}
+		DEBUG_MSG("vmemmap_start: %lx\n", info->vmemmap_start);
+	}
+
 	return TRUE;
 }
 
@@ -121,14 +279,23 @@ vaddr_to_paddr_ppc64(unsigned long vaddr)
 	if (paddr != NOT_PADDR)
 		return paddr;
 
-	if ((SYMBOL(vmlist) == NOT_FOUND_SYMBOL)
-	    || (OFFSET(vm_struct.addr) == NOT_FOUND_STRUCTURE)) {
-		ERRMSG("Can't get necessary information for vmalloc translation.\n");
-		return NOT_PADDR;
+	if ((SYMBOL(vmap_area_list) == NOT_FOUND_SYMBOL)
+	    || (OFFSET(vmap_area.va_start) == NOT_FOUND_STRUCTURE)
+	    || (OFFSET(vmap_area.list) == NOT_FOUND_STRUCTURE)) {
+		if ((SYMBOL(vmlist) == NOT_FOUND_SYMBOL)
+		    || (OFFSET(vm_struct.addr) == NOT_FOUND_STRUCTURE)) {
+			ERRMSG("Can't get info for vmalloc translation.\n");
+			return NOT_PADDR;
+		}
 	}
 	if (!is_vmalloc_addr_ppc64(vaddr))
 		return (vaddr - info->kernel_start);
 
+	if ((info->flags_vmemmap && VMEMMAP_AWARE)
+	    && (vaddr >= info->vmemmap_start)) {
+		return ppc64_vmemmap_to_phys(vaddr);
+	}
+
 	/*
 	 * TODO: Support vmalloc translation.
 	 */
diff --git a/makedumpfile.c b/makedumpfile.c
index b42565c..5035fce 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1097,6 +1097,10 @@ get_symbol_info(void)
 		SYMBOL_ARRAY_LENGTH_INIT(node_remap_start_pfn,
 					"node_remap_start_pfn");
 
+	SYMBOL_INIT(vmemmap_list, "vmemmap_list");
+	SYMBOL_INIT(mmu_psize_defs, "mmu_psize_defs");
+	SYMBOL_INIT(mmu_vmemmap_psize, "mmu_vmemmap_psize");
+
 	return TRUE;
 }
 
@@ -1394,6 +1398,20 @@ get_structure_info(void)
 	OFFSET_INIT(log.len, "log", "len");
 	OFFSET_INIT(log.text_len, "log", "text_len");
 
+	/*
+	 * Get offsets of the vmemmap_backing's members.
+	 */
+	SIZE_INIT(vmemmap_backing, "vmemmap_backing");
+	OFFSET_INIT(vmemmap_backing.phys, "vmemmap_backing", "phys");
+	OFFSET_INIT(vmemmap_backing.virt_addr, "vmemmap_backing", "virt_addr");
+	OFFSET_INIT(vmemmap_backing.list, "vmemmap_backing", "list");
+
+	/*
+	 * Get offsets of the mmu_psize_def's members.
+	 */
+	SIZE_INIT(mmu_psize_def, "mmu_psize_def");
+	OFFSET_INIT(mmu_psize_def.shift, "mmu_psize_def", "shift");
+
 	return TRUE;
 }
 
@@ -1580,6 +1598,9 @@ write_vmcoreinfo_data(void)
 	WRITE_SYMBOL("node_remap_start_vaddr", node_remap_start_vaddr);
 	WRITE_SYMBOL("node_remap_end_vaddr", node_remap_end_vaddr);
 	WRITE_SYMBOL("node_remap_start_pfn", node_remap_start_pfn);
+	WRITE_SYMBOL("vmemmap_list", vmemmap_list);
+	WRITE_SYMBOL("mmu_psize_defs", mmu_psize_defs);
+	WRITE_SYMBOL("mmu_vmemmap_psize", mmu_vmemmap_psize);
 
 	/*
 	 * write the structure size of 1st kernel
@@ -1594,6 +1615,8 @@ write_vmcoreinfo_data(void)
 	WRITE_STRUCTURE_SIZE("nodemask_t", nodemask_t);
 	WRITE_STRUCTURE_SIZE("pageflags", pageflags);
 	WRITE_STRUCTURE_SIZE("log", log);
+	WRITE_STRUCTURE_SIZE("vmemmap_backing", vmemmap_backing);
+	WRITE_STRUCTURE_SIZE("mmu_psize_def", mmu_psize_def);
 
 	/*
 	 * write the member offset of 1st kernel
@@ -1631,6 +1654,11 @@ write_vmcoreinfo_data(void)
 	WRITE_MEMBER_OFFSET("log.ts_nsec", log.ts_nsec);
 	WRITE_MEMBER_OFFSET("log.len", log.len);
 	WRITE_MEMBER_OFFSET("log.text_len", log.text_len);
+	WRITE_MEMBER_OFFSET("vmemmap_backing.phys", vmemmap_backing.phys);
+	WRITE_MEMBER_OFFSET("vmemmap_backing.virt_addr",
+	    vmemmap_backing.virt_addr);
+	WRITE_MEMBER_OFFSET("vmemmap_backing.list", vmemmap_backing.list);
+	WRITE_MEMBER_OFFSET("mmu_psize_def.shift", mmu_psize_def.shift);
 
 	if (SYMBOL(node_data) != NOT_FOUND_SYMBOL)
 		WRITE_ARRAY_LENGTH("node_data", node_data);
@@ -1899,6 +1927,9 @@ read_vmcoreinfo(void)
 	READ_SYMBOL("node_remap_start_vaddr", node_remap_start_vaddr);
 	READ_SYMBOL("node_remap_end_vaddr", node_remap_end_vaddr);
 	READ_SYMBOL("node_remap_start_pfn", node_remap_start_pfn);
+	READ_SYMBOL("vmemmap_list", vmemmap_list);
+	READ_SYMBOL("mmu_psize_defs", mmu_psize_defs);
+	READ_SYMBOL("mmu_vmemmap_psize", mmu_vmemmap_psize);
 
 	READ_STRUCTURE_SIZE("page", page);
 	READ_STRUCTURE_SIZE("mem_section", mem_section);
@@ -1910,6 +1941,8 @@ read_vmcoreinfo(void)
 	READ_STRUCTURE_SIZE("nodemask_t", nodemask_t);
 	READ_STRUCTURE_SIZE("pageflags", pageflags);
 	READ_STRUCTURE_SIZE("log", log);
+	READ_STRUCTURE_SIZE("vmemmap_backing", vmemmap_backing);
+	READ_STRUCTURE_SIZE("mmu_psize_def", mmu_psize_def);
 
 	READ_MEMBER_OFFSET("page.flags", page.flags);
 	READ_MEMBER_OFFSET("page._count", page._count);
@@ -1943,6 +1976,11 @@ read_vmcoreinfo(void)
 	READ_MEMBER_OFFSET("log.ts_nsec", log.ts_nsec);
 	READ_MEMBER_OFFSET("log.len", log.len);
 	READ_MEMBER_OFFSET("log.text_len", log.text_len);
+	READ_MEMBER_OFFSET("vmemmap_backing.phys", vmemmap_backing.phys);
+	READ_MEMBER_OFFSET("vmemmap_backing.virt_addr",
+	    vmemmap_backing.virt_addr);
+	READ_MEMBER_OFFSET("vmemmap_backing.list", vmemmap_backing.list);
+	READ_MEMBER_OFFSET("mmu_psize_def.shift", mmu_psize_def.shift);
 
 	READ_ARRAY_LENGTH("node_data", node_data);
 	READ_ARRAY_LENGTH("pgdat_list", pgdat_list);
diff --git a/makedumpfile.h b/makedumpfile.h
index a5826e0..a142243 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -576,6 +576,9 @@ do { \
 #define _SECTION_SIZE_BITS	(24)
 #define _MAX_PHYSMEM_BITS_ORIG  (44)
 #define _MAX_PHYSMEM_BITS_3_7   (46)
+#define REGION_SHIFT            (60UL)
+#define VMEMMAP_REGION_ID       (0xfUL)
+#define VMEMMAP_AWARE           (0x4)
 #endif
 
 #ifdef __powerpc32__
@@ -862,6 +865,11 @@ struct splitting_info {
 	unsigned long		size_eraseinfo;
 } splitting_info_t;
 
+struct ppc64_vmemmap {
+	unsigned long		phys;
+	unsigned long		virt;
+};
+
 struct DumpInfo {
 	int32_t		kernel_version;      /* version of first kernel*/
 	struct timeval	timestamp;
@@ -908,6 +916,14 @@ struct DumpInfo {
 	unsigned long   vmalloc_end;
 	unsigned long	vmemmap_start;
 	unsigned long	vmemmap_end;
+	int		vmemmap_psize;
+	int		vmemmap_cnt;
+	struct ppc64_vmemmap	*vmemmap_list;
+	unsigned long	flags_vmemmap;
+
+	/*
+	 * for vmemmap
+	 */
 
 	/*
 	 * Filter config file containing filter commands to filter out kernel
@@ -1093,7 +1109,6 @@ struct module_info {
 	struct symbol_info	*sym_info;
 };
 
-
 struct symbol_table {
 	unsigned long long	mem_map;
 	unsigned long long	vmem_map;
@@ -1165,6 +1180,13 @@ struct symbol_table {
 	unsigned long long	__per_cpu_load;
 	unsigned long long	cpu_online_mask;
 	unsigned long long	kexec_crash_image;
+
+	/*
+	 * vmemmap symbols on ppc64 arch
+	 */
+	unsigned long long		vmemmap_list;
+	unsigned long long		mmu_vmemmap_psize;
+	unsigned long long		mmu_psize_defs;
 };
 
 struct size_table {
@@ -1200,6 +1222,12 @@ struct size_table {
 	long	elf64_hdr;
 	long	log;
 
+	/*
+	 * vmemmap symbols on ppc64 arch
+	 */
+	long	vmemmap_backing;
+	long	mmu_psize_def;
+
 	long	pageflags;
 };
 
@@ -1343,6 +1371,18 @@ struct offset_table {
 		long text_len;
 	} log;
 
+	/*
+	 * vmemmap symbols on ppc64 arch
+	 */
+	struct mmu_psize_def {
+		long	shift;
+	} mmu_psize_def;
+
+	struct vmemmap_backing {
+		long	phys;
+		long	virt_addr;
+		long	list;
+	} vmemmap_backing;
 };
 
 /*


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
