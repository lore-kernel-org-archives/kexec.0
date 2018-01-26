Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mgwkm01.jp.fujitsu.com ([202.219.69.168])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eesY0-0004hJ-Mw
 for kexec@lists.infradead.org; Fri, 26 Jan 2018 01:11:18 +0000
Received: from g01jpfmpwyt02.exch.g01.fujitsu.local
 (g01jpfmpwyt02.exch.g01.fujitsu.local [10.128.193.56])
 by kw-mxauth.gw.nic.fujitsu.com (Postfix) with ESMTP id 12363AC00B7
 for <kexec@lists.infradead.org>; Fri, 26 Jan 2018 10:10:58 +0900 (JST)
From: "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>
Subject: RE: [makedumpfile PATCH] sadump: Fix a problem of PTI enabled kernel
Date: Fri, 26 Jan 2018 01:10:55 +0000
Message-ID: <33710E6CAA200E4583255F4FB666C4E21B3353BD@G01JPEXMBYT03>
References: <1516926146-20347-1-git-send-email-indou.takao@jp.fujitsu.com>
In-Reply-To: <1516926146-20347-1-git-send-email-indou.takao@jp.fujitsu.com>
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
To: "Indoh, Takao" <indou.takao@jp.fujitsu.com>, "ats-kumagai@wm.jp.nec.com" <ats-kumagai@wm.jp.nec.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>



> -----Original Message-----
> From: kexec [mailto:kexec-bounces@lists.infradead.org] On Behalf Of Takao
> Indoh
> Sent: Friday, January 26, 2018 9:22 AM
> To: ats-kumagai@wm.jp.nec.com; Hatayama, Daisuke 
> <d.hatayama@jp.fujitsu.com>
> Cc: kexec@lists.infradead.org
> Subject: [makedumpfile PATCH] sadump: Fix a problem of PTI enabled kernel
> 
> This patch fixes a problme that a dumpfile of sadump cannot be handled by
> makedumpfile when Page Table Isolation(PTI) is enabled.
> 
> When PTI is enabled, bit 12 of CR3 register is used to split user space and
> kernel space. Also bit 11:0 is used for Process Context IDentifiers(PCID).  To
> open a dump file of sadump, a value of CR3 is used to calculate KASLR offset
> and
> phys_base, therefore this patch fixes to mask CR3 register value collectly for
> PTI enabled kernel.
> 
> Signed-off-by: Takao Indoh <indou.takao@jp.fujitsu.com>
> ---
>  makedumpfile.c | 2 ++
>  makedumpfile.h | 2 ++
>  sadump_info.c  | 9 ++++++++-
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 64b404a..247a056 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -1557,6 +1557,8 @@ get_symbol_info(void)
>  	SYMBOL_INIT(divide_error, "divide_error");
>  	SYMBOL_INIT(idt_table, "idt_table");
>  	SYMBOL_INIT(saved_command_line, "saved_command_line");
> +	SYMBOL_INIT(pti_init, "pti_init");
> +	SYMBOL_INIT(kaiser_init, "kaiser_init");
> 
>  	return TRUE;
>  }
> diff --git a/makedumpfile.h b/makedumpfile.h
> index 57cf4d9..8ee4d29 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -1608,6 +1608,8 @@ struct symbol_table {
>  	unsigned long long	divide_error;
>  	unsigned long long	idt_table;
>  	unsigned long long	saved_command_line;
> +	unsigned long long	pti_init;
> +	unsigned long long	kaiser_init;
> 
>  	/*
>  	 * symbols on ppc64 arch
> diff --git a/sadump_info.c b/sadump_info.c
> index 148d4ba..dd50d48 100644
> --- a/sadump_info.c
> +++ b/sadump_info.c
> @@ -1362,6 +1362,9 @@ finish:
>   *    kernel. Retrieve vmcoreinfo from address of "elfcorehdr=" and
>   *    get kaslr_offset and phys_base from vmcoreinfo.
>   */
> +#define PTI_USER_PGTABLE_BIT		(info->page_shift)
> +#define PTI_USER_PGTABLE_MASK		(1 << PTI_USER_PGTABLE_BIT)
> +#define CR3_PCID_MASK			0xFFFull
>  int
>  calc_kaslr_offset(void)
>  {
> @@ -1389,7 +1392,11 @@ calc_kaslr_offset(void)
>  	}
> 
>  	idtr = ((uint64_t)smram.IdtUpper)<<32 | (uint64_t)smram.IdtLower;
> -	cr3 = smram.Cr3;
> +	if ((SYMBOL(pti_init) != NOT_FOUND_SYMBOL) ||
> +	    (SYMBOL(kaiser_init) != NOT_FOUND_SYMBOL))
> +		cr3 = smram.Cr3 & ~(CR3_PCID_MASK|PTI_USER_PGTABLE_MASK);
> +	else
> +		cr3 = smram.Cr3 & ~CR3_PCID_MASK;
> 
>  	/* Convert virtual address of IDT table to physical address */
>  	if ((idtr_paddr = vtop4_x86_64_pagetable(idtr, cr3)) == NOT_PADDR)

Looks good to me.

Thanks for your work.

Kumagai-san, could you merge this patch?

Thanks.
HATAYAMA, Daisuke



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
