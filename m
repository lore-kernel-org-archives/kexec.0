Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hQtz8-0001Rx-6V
 for kexec@lists.infradead.org; Wed, 15 May 2019 13:30:19 +0000
Date: Wed, 15 May 2019 15:30:06 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 2/3 v3] x86/kexec: Set the C-bit in the identity map page
 table when SEV is active
Message-ID: <20190515133006.GG24212@zn.tnic>
References: <20190430074421.7852-1-lijiang@redhat.com>
 <20190430074421.7852-3-lijiang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190430074421.7852-3-lijiang@redhat.com>
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
To: Lianbo Jiang <lijiang@redhat.com>
Cc: Thomas.Lendacky@amd.com, brijesh.singh@amd.com, bhe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

On Tue, Apr 30, 2019 at 03:44:20PM +0800, Lianbo Jiang wrote:
> When SEV is active, the second kernel image is loaded into the
> encrypted memory. Lets make sure that when kexec builds the
> identity mapping page table it adds the memory encryption mask(C-bit).
> 
> Co-developed-by: Brijesh Singh <brijesh.singh@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
>  arch/x86/kernel/machine_kexec_64.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index f60611531d17..11fe352f7344 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -56,6 +56,7 @@ static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
>  	pte_t *pte;
>  	unsigned long vaddr, paddr;
>  	int result = -ENOMEM;
> +	pgprot_t prot = PAGE_KERNEL_EXEC_NOENC;
>  
>  	vaddr = (unsigned long)relocate_kernel;
>  	paddr = __pa(page_address(image->control_code_page)+PAGE_SIZE);
> @@ -92,7 +93,11 @@ static int init_transition_pgtable(struct kimage *image, pgd_t *pgd)
>  		set_pmd(pmd, __pmd(__pa(pte) | _KERNPG_TABLE));
>  	}
>  	pte = pte_offset_kernel(pmd, vaddr);
> -	set_pte(pte, pfn_pte(paddr >> PAGE_SHIFT, PAGE_KERNEL_EXEC_NOENC));
> +
> +	if (sev_active())
> +		prot = PAGE_KERNEL_EXEC;
> +
> +	set_pte(pte, pfn_pte(paddr >> PAGE_SHIFT, prot));
>  	return 0;
>  err:
>  	return result;
> @@ -129,6 +134,11 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
>  	level4p = (pgd_t *)__va(start_pgtable);
>  	clear_page(level4p);
>  
> +	if (sev_active()) {
> +		info.page_flag |= _PAGE_ENC;
> +		info.kernpg_flag = _KERNPG_TABLE;

kernpg_flag above is initialized to _KERNPG_TABLE_NOENC so you can do here

		info.kernpg_flag |= _PAGE_ENC;

too, to make it even more clear what this does, right?

IOW:

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 783ce5184405..16c37fe489bc 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -135,8 +135,8 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
        clear_page(level4p);
 
        if (sev_active()) {
-               info.page_flag |= _PAGE_ENC;
-               info.kernpg_flag = _KERNPG_TABLE;
+               info.page_flag   |= _PAGE_ENC;
+               info.kernpg_flag |= _PAGE_ENC;
        }
 
        if (direct_gbpages)


-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
