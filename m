Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mgwkm04.jp.fujitsu.com ([202.219.69.171])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1e2yee-0008Or-VY
 for kexec@lists.infradead.org; Fri, 13 Oct 2017 12:01:31 +0000
Received: from g01jpfmpwyt03.exch.g01.fujitsu.local
 (g01jpfmpwyt03.exch.g01.fujitsu.local [10.128.193.57])
 by kw-mxauth.gw.nic.fujitsu.com (Postfix) with ESMTP id D517EAC0093
 for <kexec@lists.infradead.org>; Fri, 13 Oct 2017 21:00:57 +0900 (JST)
From: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
Subject: RE: [PATCH 2/3] makedumpfile: Introduce vtop4_x86_64_pagetable
Date: Fri, 13 Oct 2017 12:00:55 +0000
Message-ID: <33710E6CAA200E4583255F4FB666C4E21B09C9A5@G01JPEXMBYT03>
References: <20171010092717.7392-1-indou.takao@jp.fujitsu.com>
 <20171010092717.7392-3-indou.takao@jp.fujitsu.com>
In-Reply-To: <20171010092717.7392-3-indou.takao@jp.fujitsu.com>
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
To: "Indoh, Takao" <indou.takao@jp.fujitsu.com>
Cc: "ats-kumagai@wm.jp.nec.com" <ats-kumagai@wm.jp.nec.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>



> -----Original Message-----
> From: Takao Indoh [mailto:indou.takao@jp.fujitsu.com]
> Sent: Tuesday, October 10, 2017 6:27 PM
> To: ats-kumagai@wm.jp.nec.com; Hatayama, Daisuke 
> <d.hatayama@jp.fujitsu.com>
> Cc: kexec@lists.infradead.org
> Subject: [PATCH 2/3] makedumpfile: Introduce vtop4_x86_64_pagetable
> 
> This patch introduces new function vtop4_x86_64_pagetable
> to translate virtual address to physical address. Unlike vtop4_x86_64,
> vtop4_x86_64_pagetable need a pointer of top of pagetable like CR3.
> 
> Current vtop4_x86_64 implementation uses symbol value of
> init_level4_pgt, therefore vtop4_x86_64 does not work for sadump
> dumpfile of kaslr enabled kernel because it does not have vmcoreinfo to
> correct address of init_level4_pgt. vtop4_x86_64_pagetable requires
> pagetable address instead of init_level4_pgt and sadump dumpfile can
> pass CR3 value which is included in dump header.
> 
> Signed-off-by: Takao Indoh <indou.takao@jp.fujitsu.com>
> ---
>  arch/x86_64.c  | 30 +++++++++++++++++++++++-------
>  makedumpfile.h |  1 +
>  2 files changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86_64.c b/arch/x86_64.c
> index 08dd6b2..33621f1 100644
> --- a/arch/x86_64.c
> +++ b/arch/x86_64.c
> @@ -255,20 +255,15 @@ get_versiondep_info_x86_64(void)
>   * Translate a virtual address to a physical address by using 4 levels paging.
>   */
>  unsigned long long
> -vtop4_x86_64(unsigned long vaddr)
> +__vtop4_x86_64(unsigned long vaddr, unsigned long pagetable)
>  {
>  	unsigned long page_dir, pml4, pgd_paddr, pgd_pte, pmd_paddr, pmd_pte;
>  	unsigned long pte_paddr, pte;
> 
> -	if (SYMBOL(init_level4_pgt) == NOT_FOUND_SYMBOL) {
> -		ERRMSG("Can't get the symbol of init_level4_pgt.\n");
> -		return NOT_PADDR;
> -	}
> -
>  	/*
>  	 * Get PGD.
>  	 */
> -	page_dir = SYMBOL(init_level4_pgt) - __START_KERNEL_map +
> info->phys_base;
> +	page_dir = pagetable;
>  	if (is_xen_memory()) {
>  		page_dir = ptom_xen(page_dir);
>  		if (page_dir == NOT_PADDR)
> @@ -346,6 +341,27 @@ vtop4_x86_64(unsigned long vaddr)
>  	return (pte & ENTRY_MASK) + PAGEOFFSET(vaddr);
>  }
> 
> +unsigned long long
> +vtop4_x86_64(unsigned long vaddr)
> +{
> +	unsigned long pagetable;
> +
> +	if (SYMBOL(init_level4_pgt) == NOT_FOUND_SYMBOL) {
> +		ERRMSG("Can't get the symbol of init_level4_pgt.\n");
> +		return NOT_PADDR;
> +	}
> +
> +	pagetable = SYMBOL(init_level4_pgt) - __START_KERNEL_map +
> info->phys_base;
> +
> +	return __vtop4_x86_64(vaddr, pagetable);
> +}
> +
> +unsigned long long
> +vtop4_x86_64_pagetable(unsigned long vaddr, unsigned long pagetable)
> +{
> +	return __vtop4_x86_64(vaddr, pagetable);
> +}
> +
>  /*
>   * for Xen extraction
>   */
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 704a6bc..f48dc0b 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -978,6 +978,7 @@ int get_phys_base_x86_64(void);
>  int get_machdep_info_x86_64(void);
>  int get_versiondep_info_x86_64(void);
>  unsigned long long vtop4_x86_64(unsigned long vaddr);
> +unsigned long long vtop4_x86_64_pagetable(unsigned long vaddr, unsigned long
> pagetable);
>  #define find_vmemmap()		find_vmemmap_x86_64()
>  #define get_phys_base()		get_phys_base_x86_64()
>  #define get_machdep_info()	get_machdep_info_x86_64()
> --
> 2.9.5

Looks good to me.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
