Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1byiTC-0006EN-S5
 for kexec@lists.infradead.org; Mon, 24 Oct 2016 16:51:44 +0000
Received: by mail-oi0-f44.google.com with SMTP id d132so48020065oib.2
 for <kexec@lists.infradead.org>; Mon, 24 Oct 2016 09:51:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <49c4e7da099ef77d419d540d0e56618c67926928.1476955959.git.panand@redhat.com>
References: <cover.1477327674.git.panand@redhat.com>
 <49c4e7da099ef77d419d540d0e56618c67926928.1476955959.git.panand@redhat.com>
From: Pratyush Anand <panand@redhat.com>
Date: Mon, 24 Oct 2016 22:21:07 +0530
Message-ID: <CAHB_GuofYgSLpTJap38xn3eACrb9SfLL_Z9k6OgYnrq+c7tanA@mail.gmail.com>
Subject: Re: [PATCH] temp
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
Cc: Pratyush Anand <panand@redhat.com>, Dave Young <dyoung@redhat.com>, Kexec Mailing List <kexec@lists.infradead.org>, Baoquan He <bhe@redhat.com>

Ohhh..Please ignore this patch. This temporary changes were lying in
my directory and went away.

Sorry for this noise.

~Pratyush

On Mon, Oct 24, 2016 at 10:18 PM, Pratyush Anand <panand@redhat.com> wrote:
> Signed-off-by: Pratyush Anand <panand@redhat.com>
> ---
>  arch/x86_64.c  | 10 ++++++++--
>  makedumpfile.h |  4 ++--
>  2 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86_64.c b/arch/x86_64.c
> index ddf7be6bc57b..3a53b4fa03ed 100644
> --- a/arch/x86_64.c
> +++ b/arch/x86_64.c
> @@ -187,6 +187,12 @@ vtop4_x86_64(unsigned long vaddr)
>  {
>         unsigned long page_dir, pml4, pgd_paddr, pgd_pte, pmd_paddr, pmd_pte;
>         unsigned long pte_paddr, pte;
> +       unsigned long phys_base;
> +
> +       if (SYMBOL(phys_base) != NOT_FOUND_SYMBOL)
> +               phys_base = info->phys_base;
> +       else
> +               phys_base = 0;
>
>         if (SYMBOL(init_level4_pgt) == NOT_FOUND_SYMBOL) {
>                 ERRMSG("Can't get the symbol of init_level4_pgt.\n");
> @@ -196,9 +202,9 @@ vtop4_x86_64(unsigned long vaddr)
>         /*
>          * Get PGD.
>          */
> -       page_dir  = SYMBOL(init_level4_pgt);
> +       page_dir = SYMBOL(init_level4_pgt) - __START_KERNEL_map + phys_base;
>         page_dir += pml4_index(vaddr) * sizeof(unsigned long);
> -       if (!readmem(VADDR, page_dir, &pml4, sizeof pml4)) {
> +       if (!readmem(PADDR, page_dir, &pml4, sizeof pml4)) {
>                 ERRMSG("Can't get pml4 (page_dir:%lx).\n", page_dir);
>                 return NOT_PADDR;
>         }
> diff --git a/makedumpfile.h b/makedumpfile.h
> index f0154226bcb8..f64652e34901 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -876,12 +876,12 @@ int is_vmalloc_addr_x86_64(ulong vaddr);
>  int get_phys_base_x86_64(void);
>  int get_machdep_info_x86_64(void);
>  int get_versiondep_info_x86_64(void);
> -unsigned long long vaddr_to_paddr_x86_64(unsigned long vaddr);
> +unsigned long long vtop4_x86_64(unsigned long vaddr);
>  #define find_vmemmap()         find_vmemmap_x86_64()
>  #define get_phys_base()                get_phys_base_x86_64()
>  #define get_machdep_info()     get_machdep_info_x86_64()
>  #define get_versiondep_info()  get_versiondep_info_x86_64()
> -#define vaddr_to_paddr(X)      vaddr_to_paddr_x86_64(X)
> +#define vaddr_to_paddr(X)      vtop4_x86_64(X)
>  #define is_phys_addr(X)                (!is_vmalloc_addr_x86_64(X))
>  #endif /* x86_64 */
>
> --
> 2.7.4
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
