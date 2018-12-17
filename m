Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYsWk-0007Ym-SK
 for kexec@lists.infradead.org; Mon, 17 Dec 2018 13:01:44 +0000
Date: Mon, 17 Dec 2018 14:01:29 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 2/2 v3] kdump, vmcoreinfo: Export the value of sme mask to
 vmcoreinfo
Message-ID: <20181217130129.GE12165@zn.tnic>
References: <20181216131617.2612-1-lijiang@redhat.com>
 <20181216131617.2612-3-lijiang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181216131617.2612-3-lijiang@redhat.com>
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
Cc: bhe@redhat.com, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

On Sun, Dec 16, 2018 at 09:16:17PM +0800, Lianbo Jiang wrote:
> For AMD machine with SME feature, makedumpfile tools need to know
> whether the crash kernel was encrypted or not. If SME is enabled
> in the first kernel, the crash kernel's page table(pgd/pud/pmd/pte)
> contains the memory encryption mask, so need to remove the sme mask
> to obtain the true physical address.
> 
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
>  arch/x86/kernel/machine_kexec_64.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> index 4c8acdfdc5a7..1860fe24117d 100644
> --- a/arch/x86/kernel/machine_kexec_64.c
> +++ b/arch/x86/kernel/machine_kexec_64.c
> @@ -352,10 +352,24 @@ void machine_kexec(struct kimage *image)
>  
>  void arch_crash_save_vmcoreinfo(void)
>  {
> +	u64 sme_mask = sme_me_mask;
> +
>  	VMCOREINFO_NUMBER(phys_base);
>  	VMCOREINFO_SYMBOL(init_top_pgt);
>  	vmcoreinfo_append_str("NUMBER(pgtable_l5_enabled)=%d\n",
>  			pgtable_l5_enabled());
> +	/*
> +	 * Currently, the local variable 'sme_mask' stores the value of
> +	 * sme_me_mask(bit 47), and also write the value of sme_mask to
> +	 * the vmcoreinfo.
> +	 * If need, the bit(sme_mask) might be redefined in the future,
> +	 * but the 'bit63' will be reserved.
> +	 * For example:
> +	 * [ misc	   ][ enc bit  ][ other misc SME info       ]
> +	 * 0000_0000_0000_0000_1000_0000_0000_0000_0000_0000_..._0000
> +	 * 63   59   55   51   47   43   39   35   31   27   ... 3
> +	 */

This text belongs into the document.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
