Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mgwym02.jp.fujitsu.com ([211.128.242.41])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1e7gPY-0001XP-IJ
 for kexec@lists.infradead.org; Thu, 26 Oct 2017 11:33:23 +0000
Received: from g01jpfmpwyt02.exch.g01.fujitsu.local
 (g01jpfmpwyt02.exch.g01.fujitsu.local [10.128.193.56])
 by yt-mxoi2.gw.nic.fujitsu.com (Postfix) with ESMTP id 27DF9AC0110
 for <kexec@lists.infradead.org>; Thu, 26 Oct 2017 20:32:54 +0900 (JST)
From: Takao Indoh <indou.takao@jp.fujitsu.com>
Subject: [makedumpfile PATCH v3 4/4] sadump: Fix a KASLR problem of sadump
 while kdump is working
Date: Thu, 26 Oct 2017 20:32:27 +0900
Message-ID: <20171026113227.36740-5-indou.takao@jp.fujitsu.com>
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

In the calc_kaslr_offset(), kaslr_offset and phys_base are calculated
using IDTR and CR3, but this solution does not work in the following
cases.

1) If the dump is captured on early stage of kernel boot, IDTR points
   early IDT table(early_idts) instead of normal IDT(idt_table).
2) If the dump is captured whle kdump is working, IDTR points IDT table
   of 2nd kernel, not 1st kernel.

This patch fixes the case 2). Current implementation does not support
the case 1), need enhancement in the future. This patch gets kernel boot
parameter from "saved_command_line" and check if "elfcorehdr=" is
included in the parameter. If it's included, we are in the 2nd kernel.
Retrieve vmcoreinfo from address of "elfcorehdr=" and get kaslr_offset
and phys_base from vmcoreinfo.

Signed-off-by: Takao Indoh <indou.takao@jp.fujitsu.com>
---
 makedumpfile.c |   1 +
 makedumpfile.h |   1 +
 sadump_info.c  | 271 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 273 insertions(+)

diff --git a/makedumpfile.c b/makedumpfile.c
index 0375495..4fa1b3a 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -1556,6 +1556,7 @@ get_symbol_info(void)
 
 	SYMBOL_INIT(divide_error, "divide_error");
 	SYMBOL_INIT(idt_table, "idt_table");
+	SYMBOL_INIT(saved_command_line, "saved_command_line");
 
 	return TRUE;
 }
diff --git a/makedumpfile.h b/makedumpfile.h
index 5f814e7..db75379 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -1602,6 +1602,7 @@ struct symbol_table {
 	unsigned long long	kexec_crash_image;
 	unsigned long long	divide_error;
 	unsigned long long	idt_table;
+	unsigned long long	saved_command_line;
 
 	/*
 	 * symbols on ppc64 arch
diff --git a/sadump_info.c b/sadump_info.c
index 29ccef8..148d4ba 100644
--- a/sadump_info.c
+++ b/sadump_info.c
@@ -1059,6 +1059,241 @@ get_vec0_addr(ulong idtr)
 }
 
 /*
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
  * Calculate kaslr_offset and phys_base
  *
  * kaslr_offset:
@@ -1106,6 +1341,26 @@ get_vec0_addr(ulong idtr)
  *
  * Note that the address (A) cannot be used instead of (E) because (A) is
  * not direct map address, it's a fixed map address.
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
  */
 int
 calc_kaslr_offset(void)
@@ -1116,6 +1371,7 @@ calc_kaslr_offset(void)
 	int apicid;
 	unsigned long divide_error_vmcore, divide_error_vmlinux;
 	unsigned long kaslr_offset, phys_base;
+	unsigned long kaslr_offset_kdump, phys_base_kdump;
 
 	memset(&zero, 0, sizeof(zero));
 	for (apicid = 0; apicid < sh->nr_cpus; ++apicid) {
@@ -1161,6 +1417,21 @@ calc_kaslr_offset(void)
 	if (!get_symbol_info())
 		return FALSE;
 
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
 	DEBUG_MSG("sadump: kaslr_offset=%lx\n", info->kaslr_offset);
 	DEBUG_MSG("sadump: phys_base=%lx\n", info->phys_base);
 
-- 
2.9.5



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
