Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eSGCM-0000jJ-BC
 for kexec@lists.infradead.org; Fri, 22 Dec 2017 05:48:48 +0000
Date: Fri, 22 Dec 2017 13:48:29 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] handle renamed init_level4_pgt -> init_top_pgt
Message-ID: <20171222054829.GA21523@dhcp-128-65.nay.redhat.com>
References: <0910DD04CBD6DE4193FCF86B9C00BE9701F22E63@BPXM01GP.gisp.nec.co.jp>
 <0910DD04CBD6DE4193FCF86B9C00BE9701F2A617@BPXM01GP.gisp.nec.co.jp>
 <20171220072443.GA7413@dhcp-128-65.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701F2D609@BPXM01GP.gisp.nec.co.jp>
 <20171222045444.GA978@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20171222045444.GA978@dhcp-128-65.nay.redhat.com>
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
To: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Cc: Keiichirou Suzuki <kei-suzuki@xr.jp.nec.com>, Jeff Mahoney <jeffm@suse.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On 12/22/17 at 12:54pm, Dave Young wrote:
> Hi Atsushi,
> On 12/21/17 at 08:48am, Atsushi Kumagai wrote:
> > Hello Dave,
> > 
> > >[dyoung@dhcp-*-* makedumpfile]$ sudo ./makedumpfile -l -d 31 /mnt/vmcore/vmcore /tmp/vmcore.1
> > >The kernel version is not supported.
> > >The makedumpfile operation may be incomplete.
> > >Checking for memory holes                         : [100.0 %] |                  __vtop4_x86_64: Can't get a valid pte.
> > >readmem: Can't convert a virtual address(ffff88007ebb1000) to physical address.
> > >readmem: type_addr: 0, addr:ffff88007ebb1000, size:32768
> > >__exclude_unnecessary_pages: Can't read the buffer of struct page.
> > >create_2nd_bitmap: Can't exclude unnecessary pages.
> > >
> > >makedumpfile Failed.
> > >
> > >If you need the vmcore for debugging please let me know, my test is just
> > >a normal test in kvm guest.
> > 
> > Thanks for your report.
> > I can't reproduce that in my environment, could you give me the vmcore ?
> > It's helpful if you append the vmlinux and the .config.
> 
> I'm bisecting it, nearly finished, will post the results and share
> vmcore if needed soon.

vmcore/vmlinux (gzipped) and .config:
http://people.redhat.com/ruyang/rhbz1528542/

Bisect result is below:

83e3c48729d9ebb7af5a31a504f3fd6aff0348c4 is the first bad commit
commit 83e3c48729d9ebb7af5a31a504f3fd6aff0348c4
Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Date:   Fri Sep 29 17:08:16 2017 +0300

    mm/sparsemem: Allocate mem_section at runtime for CONFIG_SPARSEMEM_EXTREME=y
    
    Size of the mem_section[] array depends on the size of the physical address space.
    
    In preparation for boot-time switching between paging modes on x86-64
    we need to make the allocation of mem_section[] dynamic, because otherwise
    we waste a lot of RAM: with CONFIG_NODE_SHIFT=10, mem_section[] size is 32kB
    for 4-level paging and 2MB for 5-level paging mode.
    
    The patch allocates the array on the first call to sparse_memory_present_with_active_regions().
    
    Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    Cc: Andrew Morton <akpm@linux-foundation.org>
    Cc: Andy Lutomirski <luto@amacapital.net>
    Cc: Borislav Petkov <bp@suse.de>
    Cc: Cyrill Gorcunov <gorcunov@openvz.org>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: linux-mm@kvack.org
    Link: http://lkml.kernel.org/r/20170929140821.37654-2-kirill.shutemov@linux.intel.com
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

:040000 040000 68b7ff3eedc2c9ff56e31108f7e982eacbb233fc 0014ee63bebe14efb0e36e0028e2cbe718fd6c30 M	include
:040000 040000 78adbc296527c802400b1f68e0fbd716920726fa a4eea8117cb318527c0d5a6281d68f312f644831 M	mm

> 
> > 
> > Thanks,
> > Atsushi Kumagai
> > 
> > >> >>Signed-off-by: Jeff Mahoney <jeffm@suse.com>
> > >> >>---
> > >> >> arch/x86_64.c  | 24 +++++++++++++++++++++---
> > >> >> makedumpfile.c |  6 ++++++
> > >> >> makedumpfile.h |  2 ++
> > >> >> 3 files changed, 29 insertions(+), 3 deletions(-)
> > >> >>
> > >> >>diff --git a/arch/x86_64.c b/arch/x86_64.c
> > >> >>index 08dd6b2..9b09035 100644
> > >> >>--- a/arch/x86_64.c
> > >> >>+++ b/arch/x86_64.c
> > >> >>@@ -259,16 +259,26 @@ vtop4_x86_64(unsigned long vaddr)
> > >> >> {
> > >> >> 	unsigned long page_dir, pml4, pgd_paddr, pgd_pte, pmd_paddr, pmd_pte;
> > >> >> 	unsigned long pte_paddr, pte;
> > >> >>+	unsigned long init_level4_pgt;
> > >> >>
> > >> >>-	if (SYMBOL(init_level4_pgt) == NOT_FOUND_SYMBOL) {
> > >> >>+	if (SYMBOL(init_level4_pgt) != NOT_FOUND_SYMBOL)
> > >> >>+		init_level4_pgt = SYMBOL(init_level4_pgt);
> > >> >>+	else if (SYMBOL(init_top_pgt) != NOT_FOUND_SYMBOL)
> > >> >>+		init_level4_pgt = SYMBOL(init_top_pgt);
> > >> >>+	else {
> > >> >> 		ERRMSG("Can't get the symbol of init_level4_pgt.\n");
> > >> >> 		return NOT_PADDR;
> > >> >> 	}
> > >> >>
> > >> >>+	if (SYMBOL(level4_kernel_pgt) != NOT_FOUND_SYMBOL) {
> > >> >>+		ERRMSG("Kernel is built with 5-level page tables\n");
> > >> >>+		return NOT_PADDR;
> > >> >>+	}
> > >> >>+
> > >> >> 	/*
> > >> >> 	 * Get PGD.
> > >> >> 	 */
> > >> >>-	page_dir = SYMBOL(init_level4_pgt) - __START_KERNEL_map + info->phys_base;
> > >> >>+	page_dir = init_level4_pgt - __START_KERNEL_map + info->phys_base;
> > >> >> 	if (is_xen_memory()) {
> > >> >> 		page_dir = ptom_xen(page_dir);
> > >> >> 		if (page_dir == NOT_PADDR)
> > >> >>@@ -549,8 +559,16 @@ find_vmemmap_x86_64()
> > >> >> 	struct vmap_pfns *vmapp, *vmaphead = NULL, *cur, *tail;
> > >> >>
> > >> >> 	init_level4_pgt = SYMBOL(init_level4_pgt);
> > >> >>+	if (init_level4_pgt == NOT_FOUND_SYMBOL)
> > >> >>+		init_level4_pgt = SYMBOL(init_top_pgt);
> > >> >>+
> > >> >> 	if (init_level4_pgt == NOT_FOUND_SYMBOL) {
> > >> >>-		ERRMSG("init_level4_pgt not found\n");
> > >> >>+		ERRMSG("init_level4_pgt/init_top_pgt not found\n");
> > >> >>+		return FAILED;
> > >> >>+	}
> > >> >>+
> > >> >>+	if (SYMBOL(level4_kernel_pgt) != NOT_FOUND_SYMBOL) {
> > >> >>+		ERRMSG("kernel is configured for 5-level page tables\n");
> > >> >> 		return FAILED;
> > >> >> 	}
> > >> >> 	pagestructsize = size_table.page;
> > >> >>diff --git a/makedumpfile.c b/makedumpfile.c
> > >> >>index f85003a..6e5ec34 100644
> > >> >>--- a/makedumpfile.c
> > >> >>+++ b/makedumpfile.c
> > >> >>@@ -1486,6 +1486,8 @@ get_symbol_info(void)
> > >> >> 	SYMBOL_INIT(_stext, "_stext");
> > >> >> 	SYMBOL_INIT(swapper_pg_dir, "swapper_pg_dir");
> > >> >> 	SYMBOL_INIT(init_level4_pgt, "init_level4_pgt");
> > >> >>+	SYMBOL_INIT(level4_kernel_pgt, "level4_kernel_pgt");
> > >> >>+	SYMBOL_INIT(init_top_pgt, "init_top_pgt");
> > >> >> 	SYMBOL_INIT(vmlist, "vmlist");
> > >> >> 	SYMBOL_INIT(vmap_area_list, "vmap_area_list");
> > >> >> 	SYMBOL_INIT(node_online_map, "node_online_map");
> > >> >>@@ -2105,6 +2107,8 @@ write_vmcoreinfo_data(void)
> > >> >> 	WRITE_SYMBOL("_stext", _stext);
> > >> >> 	WRITE_SYMBOL("swapper_pg_dir", swapper_pg_dir);
> > >> >> 	WRITE_SYMBOL("init_level4_pgt", init_level4_pgt);
> > >> >>+	WRITE_SYMBOL("level4_kernel_pgt", level4_kernel_pgt);
> > >> >>+	WRITE_SYMBOL("init_top_pgt", init_top_pgt);
> > >> >> 	WRITE_SYMBOL("vmlist", vmlist);
> > >> >> 	WRITE_SYMBOL("vmap_area_list", vmap_area_list);
> > >> >> 	WRITE_SYMBOL("node_online_map", node_online_map);
> > >> >>@@ -2500,6 +2504,8 @@ read_vmcoreinfo(void)
> > >> >> 	READ_SYMBOL("_stext", _stext);
> > >> >> 	READ_SYMBOL("swapper_pg_dir", swapper_pg_dir);
> > >> >> 	READ_SYMBOL("init_level4_pgt", init_level4_pgt);
> > >> >>+	READ_SYMBOL("level4_kernel_pgt", level4_kernel_pgt);
> > >> >>+	READ_SYMBOL("init_top_pgt", init_top_pgt);
> > >> >> 	READ_SYMBOL("vmlist", vmlist);
> > >> >> 	READ_SYMBOL("vmap_area_list", vmap_area_list);
> > >> >> 	READ_SYMBOL("node_online_map", node_online_map);
> > >> >>diff --git a/makedumpfile.h b/makedumpfile.h
> > >> >>index 8a05794..9357e47 100644
> > >> >>--- a/makedumpfile.h
> > >> >>+++ b/makedumpfile.h
> > >> >>@@ -1517,6 +1517,8 @@ struct symbol_table {
> > >> >> 	unsigned long long	_stext;
> > >> >> 	unsigned long long	swapper_pg_dir;
> > >> >> 	unsigned long long	init_level4_pgt;
> > >> >>+	unsigned long long	level4_kernel_pgt;
> > >> >>+	unsigned long long	init_top_pgt;
> > >> >> 	unsigned long long	vmlist;
> > >> >> 	unsigned long long	vmap_area_list;
> > >> >> 	unsigned long long	phys_base;
> > >> >>
> > >> >>
> > >> >>--
> > >> >>Jeff Mahoney
> > >> >>SUSE Labs
> > >> >
> > >> >
> > >> >
> > >> >_______________________________________________
> > >> >kexec mailing list
> > >> >kexec@lists.infradead.org
> > >> >http://lists.infradead.org/mailman/listinfo/kexec
> > >>
> > >>
> > >> _______________________________________________
> > >> kexec mailing list
> > >> kexec@lists.infradead.org
> > >> http://lists.infradead.org/mailman/listinfo/kexec
> > >
> > >Thanks
> > >Dave
> > 
> > 
> 
> Thanks
> Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
