Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RliHZ-0003X3-T5
 for kexec@lists.infradead.org; Fri, 13 Jan 2012 14:39:10 +0000
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: x86 remap allocator in kernel 3.0
Date: Fri, 13 Jan 2012 15:39:03 +0100
References: <201201121140.09221.ptesarik@suse.cz>
 <20120113122250tachibana@mail.jp.nec.com>
In-Reply-To: <20120113122250tachibana@mail.jp.nec.com>
MIME-Version: 1.0
Message-Id: <201201131539.03316.ptesarik@suse.cz>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: tachibana@mxm.nes.nec.co.jp, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>

Dne Pa 13. ledna 2012 04:22:50 tachibana@mxm.nes.nec.co.jp napsal(a):
> Hi Petr,
> 
> On 2012/01/12 11:40:08 +0100, Petr Tesarik <ptesarik@suse.cz> wrote:
> > Dne ?t 12. ledna 2012 09:16:06 Atsushi Kumagai napsal(a):
> > > Hello Petr,
> > > 
> > > On Tue, 10 Jan 2012 19:14:32 +0100
> > > 
> > > Petr Tesarik <ptesarik@suse.cz> wrote:
> > > > Ken'ichi Ohmichi, please note that makedumpfile is also affected by
> > > > this deficiency. On my test system, it will fail to produce any
> > > > output if I set dump level to anything greater than zero:
> > > > 
> > > > makedumpfile -c -d 31 -x vmlinux-3.0.13-0.5-pae.debug vmcore kdump.31
> > > > readmem: Can't convert a physical address(34a012b4) to offset.
> > > > readmem: type_addr: 0, addr:f4a012b4, size:4
> > > > get_mm_discontigmem: Can't get node_start_pfn.
> > > > 
> > > > makedumpfile Failed.
> > > > 
> > > > However, fixing this for makedumpfile is harder, and it will most
> > > > likely require a few more lines in VMCOREINFO, because debug symbols
> > > > may not be available at dump time, and I can't see any alternative
> > > > method to locate the remapped regions.
> > > 
> > > Thank you for your indication.
> > > 
> > > Could you send me your kernel configuration so that I can reproduce the
> > > issue ?
> > 
> > Attached. The most important settings are:
> > 
> > CONFIG_X86_32=y
> > CONFIG_DISCONTIGMEM_MANUAL=y
> > 
> > This also depends on CONFIG_NUMA=y
> > 
> > FYI my test system runs 3.0.15 (because that's used for SLES11 SP2), but
> > the same issue also exists in any later version.
> > 
> > Petr Tesarik
> > SUSE Linux
> 
> Thank you for the config. I will fix makedumpfile. However it will take
> time to solve various issues because I've never run makedumpfile on 3.0.X.

This patch works for me, at least when using the "-x" command-line switch. To 
make it perfect, we'll also need an accompanying patch to the kernel to store 
the appropriate values in VMCOREINFO.

Signed-off-by: Petr Tesarik <ptesarik@suse.cz>

---
 arch/x86.c     |   65 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 makedumpfile.c |   16 ++++++++++++++
 makedumpfile.h |    4 +++
 3 files changed, 85 insertions(+)

--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -831,6 +831,9 @@ get_symbol_info(void)
 	if (SYMBOL(cpu_online_mask) == NOT_FOUND_SYMBOL)
 		SYMBOL_INIT(cpu_online_mask, "cpu_online_map");
 	SYMBOL_INIT(kexec_crash_image, "kexec_crash_image");
+	SYMBOL_INIT(node_remap_start_vaddr, "node_remap_start_vaddr");
+	SYMBOL_INIT(node_remap_end_vaddr, "node_remap_end_vaddr");
+	SYMBOL_INIT(node_remap_start_pfn, "node_remap_start_pfn");
 
 	if (SYMBOL(node_data) != NOT_FOUND_SYMBOL)
 		SYMBOL_ARRAY_TYPE_INIT(node_data, "node_data");
@@ -842,6 +845,9 @@ get_symbol_info(void)
 		SYMBOL_ARRAY_LENGTH_INIT(node_memblk, "node_memblk");
 	if (SYMBOL(__per_cpu_offset) != NOT_FOUND_SYMBOL)
 		SYMBOL_ARRAY_LENGTH_INIT(__per_cpu_offset, "__per_cpu_offset");
+	if (SYMBOL(node_remap_start_pfn) != NOT_FOUND_SYMBOL)
+		SYMBOL_ARRAY_LENGTH_INIT(node_remap_start_pfn,
+					"node_remap_start_pfn");
 
 	return TRUE;
 }
@@ -1290,6 +1296,9 @@ write_vmcoreinfo_data(void)
 	WRITE_SYMBOL("log_end", log_end);
 	WRITE_SYMBOL("max_pfn", max_pfn);
 	WRITE_SYMBOL("high_memory", high_memory);
+	WRITE_SYMBOL("node_remap_start_vaddr", node_remap_start_vaddr);
+	WRITE_SYMBOL("node_remap_end_vaddr", node_remap_end_vaddr);
+	WRITE_SYMBOL("node_remap_start_pfn", node_remap_start_pfn);
 
 	/*
 	 * write the structure size of 1st kernel
@@ -1341,6 +1350,9 @@ write_vmcoreinfo_data(void)
 		WRITE_ARRAY_LENGTH("mem_section", mem_section);
 	if (SYMBOL(node_memblk) != NOT_FOUND_SYMBOL)
 		WRITE_ARRAY_LENGTH("node_memblk", node_memblk);
+	if (SYMBOL(node_remap_start_pfn) != NOT_FOUND_SYMBOL)
+		WRITE_ARRAY_LENGTH("node_remap_start_pfn",
+				   node_remap_start_pfn);
 
 	WRITE_ARRAY_LENGTH("zone.free_area", zone.free_area);
 	WRITE_ARRAY_LENGTH("free_area.free_list", free_area.free_list);
@@ -1586,6 +1598,9 @@ read_vmcoreinfo(void)
 	READ_SYMBOL("log_end", log_end);
 	READ_SYMBOL("max_pfn", max_pfn);
 	READ_SYMBOL("high_memory", high_memory);
+	READ_SYMBOL("node_remap_start_vaddr", node_remap_start_vaddr);
+	READ_SYMBOL("node_remap_end_vaddr", node_remap_end_vaddr);
+	READ_SYMBOL("node_remap_start_pfn", node_remap_start_pfn);
 
 	READ_STRUCTURE_SIZE("page", page);
 	READ_STRUCTURE_SIZE("mem_section", mem_section);
@@ -1628,6 +1643,7 @@ read_vmcoreinfo(void)
 	READ_ARRAY_LENGTH("node_memblk", node_memblk);
 	READ_ARRAY_LENGTH("zone.free_area", zone.free_area);
 	READ_ARRAY_LENGTH("free_area.free_list", free_area.free_list);
+	READ_ARRAY_LENGTH("node_remap_start_pfn", node_remap_start_pfn);
 
 	READ_NUMBER("NR_FREE_PAGES", NR_FREE_PAGES);
 	READ_NUMBER("N_ONLINE", N_ONLINE);
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -961,6 +961,9 @@ struct symbol_table {
 	unsigned long long	log_buf_len;
 	unsigned long long	log_end;
 	unsigned long long	max_pfn;
+	unsigned long long	node_remap_start_vaddr;
+	unsigned long long	node_remap_end_vaddr;
+	unsigned long long	node_remap_start_pfn;
 
 	/*
 	 * for Xen extraction
@@ -1179,6 +1182,7 @@ struct array_table {
 	long	mem_section;
 	long	node_memblk;
 	long	__per_cpu_offset;
+	long	node_remap_start_pfn;
 
 	/*
 	 * Structure
--- a/arch/x86.c
+++ b/arch/x86.c
@@ -19,6 +19,53 @@
 #include "../elf_info.h"
 #include "../makedumpfile.h"
 
+static int max_numnodes;
+static unsigned long *remap_start_vaddr;
+static unsigned long *remap_end_vaddr;
+static unsigned long *remap_start_pfn;
+
+static int
+remap_init(void)
+{
+	int n;
+
+	if (SYMBOL(node_remap_start_vaddr) == NOT_FOUND_SYMBOL)
+		return TRUE;
+	if (SYMBOL(node_remap_end_vaddr) == NOT_FOUND_SYMBOL)
+		return TRUE;
+	if (SYMBOL(node_remap_start_pfn) == NOT_FOUND_SYMBOL)
+		return TRUE;
+	if (ARRAY_LENGTH(node_remap_start_pfn) == NOT_FOUND_STRUCTURE)
+		return TRUE;
+
+	n = ARRAY_LENGTH(node_remap_start_pfn);
+	remap_start_vaddr = calloc(3 * n, sizeof(unsigned long));
+	if (!remap_start_vaddr) {
+		ERRMSG("Can't allocate remap allocator info.\n");
+		return FALSE;
+	}
+	remap_end_vaddr = remap_start_vaddr + n;
+	remap_start_pfn = remap_end_vaddr + n;
+
+	if (!readmem(VADDR, SYMBOL(node_remap_start_vaddr), remap_start_vaddr,
+		     n * sizeof(unsigned long))) {
+		ERRMSG("Can't get node_remap_start_vaddr.\n");
+		return FALSE;
+	}
+	if (!readmem(VADDR, SYMBOL(node_remap_end_vaddr), remap_end_vaddr,
+		     n * sizeof(unsigned long))) {
+		ERRMSG("Can't get node_remap_end_vaddr.\n");
+		return FALSE;
+	}
+	if (!readmem(VADDR, SYMBOL(node_remap_start_pfn), remap_start_pfn,
+		     n * sizeof(unsigned long))) {
+		ERRMSG("Can't get node_remap_start_pfn.\n");
+		return FALSE;
+	}
+
+	max_numnodes = n;
+}
+
 int
 get_machdep_info_x86(void)
 {
@@ -48,6 +95,9 @@ get_machdep_info_x86(void)
 	info->kernel_start = SYMBOL(_stext) & ~KVBASE_MASK;
 	DEBUG_MSG("kernel_start : %lx\n", info->kernel_start);
 
+	if (!remap_init())
+		return FALSE;
+
 	/*
 	 * For the compatibility, makedumpfile should run without the symbol
 	 * vmlist and the offset of vm_struct.addr if they are not necessary.
@@ -90,6 +140,18 @@ get_versiondep_info_x86(void)
 }
 
 unsigned long long
+vtop_x86_remap(unsigned long vaddr)
+{
+	int i;
+	for (i = 0; i < max_numnodes; ++i)
+		if (vaddr >= remap_start_vaddr[i] &&
+		    vaddr < remap_end_vaddr[i])
+			return pfn_to_paddr(remap_start_pfn[i]) +
+				vaddr - remap_start_vaddr[i];
+	return NOT_PADDR;
+}
+
+unsigned long long
 vtop_x86_PAE(unsigned long vaddr)
 {
 	unsigned long long page_dir, pgd_pte, pmd_paddr, pmd_pte;
@@ -152,6 +214,9 @@ vaddr_to_paddr_x86(unsigned long vaddr)
 {
 	unsigned long long paddr;
 
+	if ((paddr = vtop_x86_remap(vaddr)) != NOT_PADDR)
+		return paddr;
+
 	if ((paddr = vaddr_to_paddr_general(vaddr)) != NOT_PADDR)
 		return paddr;
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
