Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1eNDpi-0002d7-Ny
 for kexec@lists.infradead.org; Fri, 08 Dec 2017 08:16:37 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH] handle renamed init_level4_pgt -> init_top_pgt
Date: Fri, 8 Dec 2017 08:15:30 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701F2A617@BPXM01GP.gisp.nec.co.jp>
References: <0910DD04CBD6DE4193FCF86B9C00BE9701F22E63@BPXM01GP.gisp.nec.co.jp>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701F22E63@BPXM01GP.gisp.nec.co.jp>
Content-Language: ja-JP
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
To: Jeff Mahoney <jeffm@suse.com>
Cc: Keiichirou Suzuki <kei-suzuki@xr.jp.nec.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

>>Linux 4.13 renamed init_level4_pgt to init_top_pgt in preparation for
>>introducing 5-level page tables.  This patch follows the rename if
>>the lookup for init_level4_pgt fails.  It also checks to see if
>>5-level page tables are enabled and bails if it discovers they are.
>
>Thanks Jeff, but could you rebase it on the current devel branch ?
>vtop4 for x86_64 was modified in the commit below:
>
>commit 8c89727155f4994b4e75a659e28e5eff16ff6cbc
>Author: Takao Indoh <indou.takao@jp.fujitsu.com>
>Date:   Thu Oct 26 20:32:54 2017 +0900
>
>    [PATCH v3 2/4] Introduce vtop4_x86_64_pagetable
>
>Regards,
>Atsushi Kumagai

I rebased that and updated the devel branch:

https://sourceforge.net/p/makedumpfile/code/ci/97e156b493c46fabfc4b136ab834a6495166ac66/

I'll merge it into v1.6.3 if you have no comment.

Thanks,
Atsushi Kumagai

>>Signed-off-by: Jeff Mahoney <jeffm@suse.com>
>>---
>> arch/x86_64.c  | 24 +++++++++++++++++++++---
>> makedumpfile.c |  6 ++++++
>> makedumpfile.h |  2 ++
>> 3 files changed, 29 insertions(+), 3 deletions(-)
>>
>>diff --git a/arch/x86_64.c b/arch/x86_64.c
>>index 08dd6b2..9b09035 100644
>>--- a/arch/x86_64.c
>>+++ b/arch/x86_64.c
>>@@ -259,16 +259,26 @@ vtop4_x86_64(unsigned long vaddr)
>> {
>> 	unsigned long page_dir, pml4, pgd_paddr, pgd_pte, pmd_paddr, pmd_pte;
>> 	unsigned long pte_paddr, pte;
>>+	unsigned long init_level4_pgt;
>>
>>-	if (SYMBOL(init_level4_pgt) == NOT_FOUND_SYMBOL) {
>>+	if (SYMBOL(init_level4_pgt) != NOT_FOUND_SYMBOL)
>>+		init_level4_pgt = SYMBOL(init_level4_pgt);
>>+	else if (SYMBOL(init_top_pgt) != NOT_FOUND_SYMBOL)
>>+		init_level4_pgt = SYMBOL(init_top_pgt);
>>+	else {
>> 		ERRMSG("Can't get the symbol of init_level4_pgt.\n");
>> 		return NOT_PADDR;
>> 	}
>>
>>+	if (SYMBOL(level4_kernel_pgt) != NOT_FOUND_SYMBOL) {
>>+		ERRMSG("Kernel is built with 5-level page tables\n");
>>+		return NOT_PADDR;
>>+	}
>>+
>> 	/*
>> 	 * Get PGD.
>> 	 */
>>-	page_dir = SYMBOL(init_level4_pgt) - __START_KERNEL_map + info->phys_base;
>>+	page_dir = init_level4_pgt - __START_KERNEL_map + info->phys_base;
>> 	if (is_xen_memory()) {
>> 		page_dir = ptom_xen(page_dir);
>> 		if (page_dir == NOT_PADDR)
>>@@ -549,8 +559,16 @@ find_vmemmap_x86_64()
>> 	struct vmap_pfns *vmapp, *vmaphead = NULL, *cur, *tail;
>>
>> 	init_level4_pgt = SYMBOL(init_level4_pgt);
>>+	if (init_level4_pgt == NOT_FOUND_SYMBOL)
>>+		init_level4_pgt = SYMBOL(init_top_pgt);
>>+
>> 	if (init_level4_pgt == NOT_FOUND_SYMBOL) {
>>-		ERRMSG("init_level4_pgt not found\n");
>>+		ERRMSG("init_level4_pgt/init_top_pgt not found\n");
>>+		return FAILED;
>>+	}
>>+
>>+	if (SYMBOL(level4_kernel_pgt) != NOT_FOUND_SYMBOL) {
>>+		ERRMSG("kernel is configured for 5-level page tables\n");
>> 		return FAILED;
>> 	}
>> 	pagestructsize = size_table.page;
>>diff --git a/makedumpfile.c b/makedumpfile.c
>>index f85003a..6e5ec34 100644
>>--- a/makedumpfile.c
>>+++ b/makedumpfile.c
>>@@ -1486,6 +1486,8 @@ get_symbol_info(void)
>> 	SYMBOL_INIT(_stext, "_stext");
>> 	SYMBOL_INIT(swapper_pg_dir, "swapper_pg_dir");
>> 	SYMBOL_INIT(init_level4_pgt, "init_level4_pgt");
>>+	SYMBOL_INIT(level4_kernel_pgt, "level4_kernel_pgt");
>>+	SYMBOL_INIT(init_top_pgt, "init_top_pgt");
>> 	SYMBOL_INIT(vmlist, "vmlist");
>> 	SYMBOL_INIT(vmap_area_list, "vmap_area_list");
>> 	SYMBOL_INIT(node_online_map, "node_online_map");
>>@@ -2105,6 +2107,8 @@ write_vmcoreinfo_data(void)
>> 	WRITE_SYMBOL("_stext", _stext);
>> 	WRITE_SYMBOL("swapper_pg_dir", swapper_pg_dir);
>> 	WRITE_SYMBOL("init_level4_pgt", init_level4_pgt);
>>+	WRITE_SYMBOL("level4_kernel_pgt", level4_kernel_pgt);
>>+	WRITE_SYMBOL("init_top_pgt", init_top_pgt);
>> 	WRITE_SYMBOL("vmlist", vmlist);
>> 	WRITE_SYMBOL("vmap_area_list", vmap_area_list);
>> 	WRITE_SYMBOL("node_online_map", node_online_map);
>>@@ -2500,6 +2504,8 @@ read_vmcoreinfo(void)
>> 	READ_SYMBOL("_stext", _stext);
>> 	READ_SYMBOL("swapper_pg_dir", swapper_pg_dir);
>> 	READ_SYMBOL("init_level4_pgt", init_level4_pgt);
>>+	READ_SYMBOL("level4_kernel_pgt", level4_kernel_pgt);
>>+	READ_SYMBOL("init_top_pgt", init_top_pgt);
>> 	READ_SYMBOL("vmlist", vmlist);
>> 	READ_SYMBOL("vmap_area_list", vmap_area_list);
>> 	READ_SYMBOL("node_online_map", node_online_map);
>>diff --git a/makedumpfile.h b/makedumpfile.h
>>index 8a05794..9357e47 100644
>>--- a/makedumpfile.h
>>+++ b/makedumpfile.h
>>@@ -1517,6 +1517,8 @@ struct symbol_table {
>> 	unsigned long long	_stext;
>> 	unsigned long long	swapper_pg_dir;
>> 	unsigned long long	init_level4_pgt;
>>+	unsigned long long	level4_kernel_pgt;
>>+	unsigned long long	init_top_pgt;
>> 	unsigned long long	vmlist;
>> 	unsigned long long	vmap_area_list;
>> 	unsigned long long	phys_base;
>>
>>
>>--
>>Jeff Mahoney
>>SUSE Labs
>
>
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
