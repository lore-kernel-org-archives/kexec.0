Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUULx-0004CT-P2
 for kexec@lists.infradead.org; Wed, 05 Dec 2018 10:24:27 +0000
Date: Wed, 5 Dec 2018 18:24:07 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 2/2 v2] kdump, vmcoreinfo: Export the value of sme mask to
 vmcoreinfo
Message-ID: <20181205102407.GB6940@dhcp-128-65.nay.redhat.com>
References: <20181202030839.29945-1-lijiang@redhat.com>
 <20181202030839.29945-3-lijiang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181202030839.29945-3-lijiang@redhat.com>
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
Cc: bhe@redhat.com, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, bp@alien8.de, tglx@linutronix.de, akpm@linux-foundation.org

On 12/02/18 at 11:08am, Lianbo Jiang wrote:
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
> +	VMCOREINFO_NUMBER(sme_mask);

#define VMCOREINFO_NUMBER(name) \
        vmcoreinfo_append_str("NUMBER(%s)=%ld\n", #name, (long)name)

VMCOREINFO_NUMBER is defined as above, so it looks questionable to add
more users of that for different data types although it may work in real
world.

A new macro like below may be better, may need to choose a better name
though:
_VMCOREINFO_NUMBER(name, format, type)
so you can pass the format specifier and data types explictly


>  
>  #ifdef CONFIG_NUMA
>  	VMCOREINFO_SYMBOL(node_data);
> -- 
> 2.17.1
> 

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
