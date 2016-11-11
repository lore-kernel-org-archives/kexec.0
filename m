Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c5761-0007Cw-Kt
 for kexec@lists.infradead.org; Fri, 11 Nov 2016 08:22:03 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [PATCH v2 1/2] makedumpfile: Adapt code to get value of phys_base
Date: Fri, 11 Nov 2016 08:12:29 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E7EACD@BPXM01GP.gisp.nec.co.jp>
References: <1478595319-9299-1-git-send-email-bhe@redhat.com>
 <1478595319-9299-2-git-send-email-bhe@redhat.com> <20161110063050.GE22737@x1>
In-Reply-To: <20161110063050.GE22737@x1>
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
To: Baoquan He <bhe@redhat.com>
Cc: "panand@redhat.com" <panand@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "anderson@redhat.com" <anderson@redhat.com>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "dyoung@redhat.com" <dyoung@redhat.com>

>Kernel code only exports virtual address of phys_base now and it's helpless
>for Crash and Makedumpfile. Below patch which changes code to export value
>of phys_base has been posted to upstream. So adapt code to get it.
>
>kexec: Change to export the value of phys_base instead of symbol address
>marc.info/?l=linux-kernel&m=147856863629624&w=2
>
>Signed-off-by: Baoquan He <bhe@redhat.com>
>---
>v1->v2:
>    Patch v1 is not compatible with the old kernel. Change code in
>    get_phys_base_x86_64 and vtop4_x86_64 to avoid that according to
>    Atsushi's suggestion.

Looks good to me, I'll merge this patch into v1.6.1.
For 2/2, I'll revert 56649f7b6bfe7 with your patch's comment.


Thanks,
Atsushi Kumagai

> arch/x86_64.c  | 12 +++++-------
> makedumpfile.c |  5 ++---
> makedumpfile.h |  2 +-
> 3 files changed, 8 insertions(+), 11 deletions(-)
>
>diff --git a/arch/x86_64.c b/arch/x86_64.c
>index 3ef33ae..010ea10 100644
>--- a/arch/x86_64.c
>+++ b/arch/x86_64.c
>@@ -62,6 +62,10 @@ get_phys_base_x86_64(void)
> 	 * Get the relocatable offset
> 	 */
> 	info->phys_base = 0; /* default/traditional */
>+	if (NUMBER(phys_base) != NOT_FOUND_NUMBER) {
>+		info->phys_base = NUMBER(phys_base);
>+		return TRUE;
>+	}
>
> 	for (i = 0; get_pt_load(i, &phys_start, NULL, &virt_start, NULL); i++) {
> 		if (virt_start >= __START_KERNEL_map) {
>@@ -187,12 +191,6 @@ vtop4_x86_64(unsigned long vaddr)
> {
> 	unsigned long page_dir, pml4, pgd_paddr, pgd_pte, pmd_paddr, pmd_pte;
> 	unsigned long pte_paddr, pte;
>-	unsigned long phys_base;
>-
>-	if (SYMBOL(phys_base) != NOT_FOUND_SYMBOL)
>-		phys_base = info->phys_base;
>-	else
>-		phys_base = 0;
>
> 	if (SYMBOL(init_level4_pgt) == NOT_FOUND_SYMBOL) {
> 		ERRMSG("Can't get the symbol of init_level4_pgt.\n");
>@@ -202,7 +200,7 @@ vtop4_x86_64(unsigned long vaddr)
> 	/*
> 	 * Get PGD.
> 	 */
>-	page_dir = SYMBOL(init_level4_pgt) - __START_KERNEL_map + phys_base;
>+	page_dir = SYMBOL(init_level4_pgt) - __START_KERNEL_map + info->phys_base;
> 	page_dir += pml4_index(vaddr) * sizeof(unsigned long);
> 	if (!readmem(PADDR, page_dir, &pml4, sizeof pml4)) {
> 		ERRMSG("Can't get pml4 (page_dir:%lx).\n", page_dir);
>diff --git a/makedumpfile.c b/makedumpfile.c
>index b916dfb..a3f711e 100644
>--- a/makedumpfile.c
>+++ b/makedumpfile.c
>@@ -1507,7 +1507,6 @@ get_symbol_info(void)
> 	SYMBOL_INIT(init_level4_pgt, "init_level4_pgt");
> 	SYMBOL_INIT(vmlist, "vmlist");
> 	SYMBOL_INIT(vmap_area_list, "vmap_area_list");
>-	SYMBOL_INIT(phys_base, "phys_base");
> 	SYMBOL_INIT(node_online_map, "node_online_map");
> 	SYMBOL_INIT(node_states, "node_states");
> 	SYMBOL_INIT(node_memblk, "node_memblk");
>@@ -2134,7 +2133,6 @@ write_vmcoreinfo_data(void)
> 	WRITE_SYMBOL("init_level4_pgt", init_level4_pgt);
> 	WRITE_SYMBOL("vmlist", vmlist);
> 	WRITE_SYMBOL("vmap_area_list", vmap_area_list);
>-	WRITE_SYMBOL("phys_base", phys_base);
> 	WRITE_SYMBOL("node_online_map", node_online_map);
> 	WRITE_SYMBOL("node_states", node_states);
> 	WRITE_SYMBOL("node_data", node_data);
>@@ -2261,6 +2259,7 @@ write_vmcoreinfo_data(void)
>
> 	WRITE_NUMBER("PAGE_BUDDY_MAPCOUNT_VALUE", PAGE_BUDDY_MAPCOUNT_VALUE);
> 	WRITE_NUMBER("KERNEL_IMAGE_SIZE", KERNEL_IMAGE_SIZE);
>+	WRITE_NUMBER("phys_base", phys_base);
>
> 	WRITE_NUMBER("HUGETLB_PAGE_DTOR", HUGETLB_PAGE_DTOR);
>
>@@ -2488,7 +2487,6 @@ read_vmcoreinfo(void)
> 	READ_SYMBOL("init_level4_pgt", init_level4_pgt);
> 	READ_SYMBOL("vmlist", vmlist);
> 	READ_SYMBOL("vmap_area_list", vmap_area_list);
>-	READ_SYMBOL("phys_base", phys_base);
> 	READ_SYMBOL("node_online_map", node_online_map);
> 	READ_SYMBOL("node_states", node_states);
> 	READ_SYMBOL("node_data", node_data);
>@@ -2609,6 +2607,7 @@ read_vmcoreinfo(void)
>
> 	READ_NUMBER("PAGE_BUDDY_MAPCOUNT_VALUE", PAGE_BUDDY_MAPCOUNT_VALUE);
> 	READ_NUMBER("KERNEL_IMAGE_SIZE", KERNEL_IMAGE_SIZE);
>+	READ_NUMBER("phys_base", phys_base);
>
> 	READ_NUMBER("HUGETLB_PAGE_DTOR", HUGETLB_PAGE_DTOR);
>
>diff --git a/makedumpfile.h b/makedumpfile.h
>index 338c651..422b6be 100644
>--- a/makedumpfile.h
>+++ b/makedumpfile.h
>@@ -1394,7 +1394,6 @@ struct symbol_table {
> 	unsigned long long	init_level4_pgt;
> 	unsigned long long	vmlist;
> 	unsigned long long	vmap_area_list;
>-	unsigned long long	phys_base;
> 	unsigned long long	node_online_map;
> 	unsigned long long	node_states;
> 	unsigned long long	node_memblk;
>@@ -1718,6 +1717,7 @@ struct number_table {
> 	long	SECTION_SIZE_BITS;
> 	long	MAX_PHYSMEM_BITS;
> 	long    HUGETLB_PAGE_DTOR;
>+	long	phys_base;
> };
>
> struct srcfile_table {
>--
>2.5.5

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
