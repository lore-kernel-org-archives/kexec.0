Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mgwym01.jp.fujitsu.com ([211.128.242.40])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1e41vJ-0006dU-45
 for kexec@lists.infradead.org; Mon, 16 Oct 2017 09:43:15 +0000
Received: from g01jpfmpwkw01.exch.g01.fujitsu.local
 (g01jpfmpwkw01.exch.g01.fujitsu.local [10.0.193.38])
 by yt-mxoi2.gw.nic.fujitsu.com (Postfix) with ESMTP id D7782AC0450
 for <kexec@lists.infradead.org>; Mon, 16 Oct 2017 18:42:35 +0900 (JST)
From: Takao Indoh <indou.takao@jp.fujitsu.com>
Subject: [makedumpfile PATCH v2 3/3] sadump: Fix a KASLR problem of sadump
Date: Mon, 16 Oct 2017 18:42:17 +0900
Message-ID: <20171016094217.1020-4-indou.takao@jp.fujitsu.com>
In-Reply-To: <20171016094217.1020-1-indou.takao@jp.fujitsu.com>
References: <20171016094217.1020-1-indou.takao@jp.fujitsu.com>
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
 makedumpfile.c |  11 ++
 makedumpfile.h |   6 +-
 sadump_info.c  | 415 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 429 insertions(+), 3 deletions(-)

diff --git a/makedumpfile.c b/makedumpfile.c
index 5f2ca7d..4fa1b3a 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1554,6 +1554,10 @@ get_symbol_info(void)
 	SYMBOL_INIT(demote_segment_4k, "demote_segment_4k");
 	SYMBOL_INIT(cur_cpu_spec, "cur_cpu_spec");
 
+	SYMBOL_INIT(divide_error, "divide_error");
+	SYMBOL_INIT(idt_table, "idt_table");
+	SYMBOL_INIT(saved_command_line, "saved_command_line");
+
 	return TRUE;
 }
 
@@ -2249,6 +2253,13 @@ write_vmcoreinfo_data(void)
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
index f48dc0b..db75379 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -45,6 +45,7 @@
 #include "sadump_mod.h"
 #include <pthread.h>
 #include <semaphore.h>
+#include <inttypes.h>
 
 #define VMEMMAPSTART 0xffffea0000000000UL
 #define BITS_PER_WORD 64
@@ -1599,6 +1600,9 @@ struct symbol_table {
 	unsigned long long	cpu_online_mask;
 	unsigned long long	__cpu_online_mask;
 	unsigned long long	kexec_crash_image;
+	unsigned long long	divide_error;
+	unsigned long long	idt_table;
+	unsigned long long	saved_command_line;
 
 	/*
 	 * symbols on ppc64 arch
@@ -1960,7 +1964,7 @@ int iomem_for_each_line(char *match, int (*callback)(void *data, int nr,
 						     unsigned long length),
 			void *data);
 int is_bigendian(void);
-
+int get_symbol_info(void);
 
 /*
  * for Xen extraction
diff --git a/sadump_info.c b/sadump_info.c
index 7dd22e7..485fa80 100644
--- a/sadump_info.c
+++ b/sadump_info.c
@@ -1035,6 +1035,410 @@ sadump_get_max_mapnr(void)
 
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
+ * Parse a string of [size[KMG]@]offset[KMG]
+ * Import from Linux kernel(lib/cmdline.c)
+ */
+static ulong memparse(char *ptr, char **retptr)
+{
+	char *endptr;
+
+	unsigned long long ret = strtoull(ptr, &endptr, 0);
+
+	switch (*endptr) {
+	case 'E':
+	case 'e':
+		ret <<= 10;
+	case 'P':
+	case 'p':
+		ret <<= 10;
+	case 'T':
+	case 't':
+		ret <<= 10;
+	case 'G':
+	case 'g':
+		ret <<= 10;
+	case 'M':
+	case 'm':
+		ret <<= 10;
+	case 'K':
+	case 'k':
+		ret <<= 10;
+		endptr++;
+	default:
+		break;
+	}
+
+	if (retptr)
+		*retptr = endptr;
+
+	return ret;
+}
+
+/*
+ * Find "elfcorehdr=" in the boot parameter of kernel and return the address
+ * of elfcorehdr.
+ */
+static ulong
+get_elfcorehdr(ulong cr3)
+{
+	char cmdline[BUFSIZE], *ptr;
+	ulong cmdline_vaddr;
+	ulong cmdline_paddr;
+	ulong buf_vaddr, buf_paddr;
+	char *end;
+	ulong elfcorehdr_addr = 0, elfcorehdr_size = 0;
+
+	if (SYMBOL(saved_command_line) == NOT_FOUND_SYMBOL) {
+		ERRMSG("Can't get the symbol of saved_command_line.\n");
+		return 0;
+	}
+	cmdline_vaddr = SYMBOL(saved_command_line);
+	if ((cmdline_paddr = vtop4_x86_64_pagetable(cmdline_vaddr, cr3)) == NOT_PADDR)
+		return 0;
+
+	DEBUG_MSG("sadump: cmdline vaddr: %lx\n", cmdline_vaddr);
+	DEBUG_MSG("sadump: cmdline paddr: %lx\n", cmdline_paddr);
+
+	if (!readmem(PADDR, cmdline_paddr, &buf_vaddr, sizeof(ulong)))
+		return 0;
+
+	if ((buf_paddr = vtop4_x86_64_pagetable(buf_vaddr, cr3)) == NOT_PADDR)
+		return 0;
+
+	DEBUG_MSG("sadump: cmdline buf vaddr: %lx\n", buf_vaddr);
+	DEBUG_MSG("sadump: cmdline buf paddr: %lx\n", buf_paddr);
+
+	memset(cmdline, 0, BUFSIZE);
+	if (!readmem(PADDR, buf_paddr, cmdline, BUFSIZE))
+		return 0;
+
+	ptr = strstr(cmdline, "elfcorehdr=");
+	if (!ptr)
+		return 0;
+
+	DEBUG_MSG("sadump: 2nd kernel detected.\n");
+
+	ptr += strlen("elfcorehdr=");
+	elfcorehdr_addr = memparse(ptr, &end);
+	if (*end == '@') {
+		elfcorehdr_size = elfcorehdr_addr;
+		elfcorehdr_addr = memparse(end + 1, &end);
+	}
+
+	DEBUG_MSG("sadump: elfcorehdr_addr: %lx\n", elfcorehdr_addr);
+	DEBUG_MSG("sadump: elfcorehdr_size: %lx\n", elfcorehdr_size);
+
+	return elfcorehdr_addr;
+}
+
+/*
+ * Get vmcoreinfo from elfcorehdr.
+ * Some codes are imported from Linux kernel(fs/proc/vmcore.c)
+ */
+static int
+get_vmcoreinfo_in_kdump_kernel(ulong elfcorehdr, ulong *addr, int *len)
+{
+	unsigned char e_ident[EI_NIDENT];
+	Elf64_Ehdr ehdr;
+	Elf64_Phdr phdr;
+	Elf64_Nhdr nhdr;
+	ulong ptr;
+	ulong nhdr_offset = 0;
+	int i;
+
+	if (!readmem(PADDR, elfcorehdr, e_ident, EI_NIDENT))
+		return FALSE;
+
+	if (e_ident[EI_CLASS] != ELFCLASS64) {
+		ERRMSG("Only ELFCLASS64 is supportd\n");
+		return FALSE;
+	}
+
+	if (!readmem(PADDR, elfcorehdr, &ehdr, sizeof(ehdr)))
+		return FALSE;
+
+	/* Sanity Check */
+	if (memcmp(ehdr.e_ident, ELFMAG, SELFMAG) != 0 ||
+		(ehdr.e_type != ET_CORE) ||
+		ehdr.e_ident[EI_CLASS] != ELFCLASS64 ||
+		ehdr.e_ident[EI_VERSION] != EV_CURRENT ||
+		ehdr.e_version != EV_CURRENT ||
+		ehdr.e_ehsize != sizeof(Elf64_Ehdr) ||
+		ehdr.e_phentsize != sizeof(Elf64_Phdr) ||
+		ehdr.e_phnum == 0) {
+		ERRMSG("Invalid elf header\n");
+		return FALSE;
+	}
+
+	ptr = elfcorehdr + ehdr.e_phoff;
+	for (i = 0; i < ehdr.e_phnum; i++) {
+		ulong offset;
+		char name[16];
+
+		if (!readmem(PADDR, ptr, &phdr, sizeof(phdr)))
+			return FALSE;
+
+		ptr += sizeof(phdr);
+		if (phdr.p_type != PT_NOTE)
+			continue;
+
+		offset = phdr.p_offset;
+		if (!readmem(PADDR, offset, &nhdr, sizeof(nhdr)))
+			return FALSE;
+
+		offset += divideup(sizeof(Elf64_Nhdr), sizeof(Elf64_Word))*
+			  sizeof(Elf64_Word);
+		memset(name, 0, sizeof(name));
+		if (!readmem(PADDR, offset, name, sizeof(name)))
+			return FALSE;
+
+		if(!strcmp(name, "VMCOREINFO")) {
+			nhdr_offset = offset;
+			break;
+		}
+	}
+
+	if (!nhdr_offset)
+		return FALSE;
+
+	*addr = nhdr_offset +
+		divideup(nhdr.n_namesz, sizeof(Elf64_Word))*
+		sizeof(Elf64_Word);
+	*len = nhdr.n_descsz;
+
+	DEBUG_MSG("sadump: vmcoreinfo addr: %lx\n", *addr);
+	DEBUG_MSG("sadump: vmcoreinfo len:  %d\n", *len);
+
+	return TRUE;
+}
+
+/*
+ * Check if current kaslr_offset/phys_base is for 1st kernel or 2nd kernel.
+ * If we are in 2nd kernel, get kaslr_offset/phys_base from vmcoreinfo.
+ *
+ * 1. Get command line and try to retrieve "elfcorehdr=" boot parameter
+ * 2. If "elfcorehdr=" is not found in command line, we are in 1st kernel.
+ *    There is nothing to do.
+ * 3. If "elfcorehdr=" is found, we are in 2nd kernel. Find vmcoreinfo
+ *    using "elfcorehdr=" and retrieve kaslr_offset/phys_base from vmcoreinfo.
+ */
+int
+get_kaslr_offset_from_vmcoreinfo(ulong cr3, ulong *kaslr_offset,
+				 ulong *phys_base)
+{
+	ulong elfcorehdr_addr = 0;
+	ulong vmcoreinfo_addr;
+	int vmcoreinfo_len;
+	char *buf, *pos;
+	int ret = FALSE;
+
+	elfcorehdr_addr = get_elfcorehdr(cr3);
+	if (!elfcorehdr_addr)
+		return FALSE;
+
+	if (!get_vmcoreinfo_in_kdump_kernel(elfcorehdr_addr, &vmcoreinfo_addr,
+					    &vmcoreinfo_len))
+		return FALSE;
+
+	if (!vmcoreinfo_len)
+		return FALSE;
+
+	DEBUG_MSG("sadump: Find vmcoreinfo in kdump memory\n");
+
+	if (!(buf = malloc(vmcoreinfo_len))) {
+		ERRMSG("Can't allocate vmcoreinfo buffer.\n");
+		return FALSE;
+	}
+
+	if (!readmem(PADDR, vmcoreinfo_addr, buf, vmcoreinfo_len))
+		goto finish;
+
+	pos = strstr(buf, STR_NUMBER("phys_base"));
+	if (!pos)
+		goto finish;
+	*phys_base  = strtoull(pos + strlen(STR_NUMBER("phys_base")), NULL, 0);
+
+	pos = strstr(buf, STR_KERNELOFFSET);
+	if (!pos)
+		goto finish;
+	*kaslr_offset = strtoull(pos + strlen(STR_KERNELOFFSET), NULL, 16);
+	ret = TRUE;
+
+finish:
+	free(buf);
+	return ret;
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
+ *
+ * This solution works in most every case, but does not work in the
+ * following case.
+ *
+ * 1) If the dump is captured on early stage of kernel boot, IDTR points
+ *    early IDT table(early_idts) instead of normal IDT(idt_table).
+ * 2) If the dump is captured whle kdump is working, IDTR points
+ *    IDT table of 2nd kernel, not 1st kernel.
+ *
+ * Current implementation does not support the case 1), need
+ * enhancement in the future. For the case 2), get kaslr_offset and
+ * phys_base as follows.
+ *
+ * 1) Get kaslr_offset and phys_base using the above solution.
+ * 2) Get kernel boot parameter from "saved_command_line"
+ * 3) If "elfcorehdr=" is not included in boot parameter, we are in the
+ *    first kernel, nothing to do any more.
+ * 4) If "elfcorehdr=" is included in boot parameter, we are in the 2nd
+ *    kernel. Retrieve vmcoreinfo from address of "elfcorehdr=" and
+ *    get kaslr_offset and phys_base from vmcoreinfo.
+ */
+int
+calc_kaslr_offset(void)
+{
+	struct sadump_header *sh = si->sh_memory;
+	uint64_t idtr = 0, cr3 = 0, idtr_paddr;
+	struct sadump_smram_cpu_state smram, zero;
+	int apicid;
+	unsigned long divide_error_vmcore, divide_error_vmlinux;
+
+	unsigned long kaslr_offset_kdump, phys_base_kdump;
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
+	/*
+	 * Check if current kaslr_offset/phys_base is for 1st kernel or 2nd
+	 * kernel. If we are in 2nd kernel, get kaslr_offset/phys_base
+	 * from vmcoreinfo
+	 */
+	if (get_kaslr_offset_from_vmcoreinfo(cr3, &kaslr_offset_kdump,
+					    &phys_base_kdump)) {
+		info->kaslr_offset = kaslr_offset_kdump;
+		info->phys_base = phys_base_kdump;
+
+		/* Reload symbol */
+		if (!get_symbol_info())
+			return FALSE;
+	}
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
@@ -1065,6 +1469,9 @@ sadump_virt_phys_base(void)
 	}
 
 failed:
+	if (calc_kaslr_offset())
+		return TRUE;
+
 	info->phys_base = 0;
 
 	DEBUG_MSG("sadump: failed to calculate phys_base; default to 0\n");
@@ -1518,10 +1925,14 @@ cpu_to_apicid(int cpu, int *apicid)
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
