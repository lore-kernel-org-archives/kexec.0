Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr680083.outbound.protection.outlook.com
 ([40.107.68.83] helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i2bkg-0001VI-DM
 for kexec@lists.infradead.org; Tue, 27 Aug 2019 13:43:16 +0000
From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH v2] x86/kdump: Reserve extra memory when SME or SEV is
 active
Date: Tue, 27 Aug 2019 13:43:10 +0000
Message-ID: <dfb623dd-6c68-14a9-7ef5-ea8c6b5a2567@amd.com>
References: <20190826044535.9646-1-kasong@redhat.com>
In-Reply-To: <20190826044535.9646-1-kasong@redhat.com>
Content-Language: en-US
Content-ID: <2DC00BA7C27A87489CB7E42FBC4B6659@namprd12.prod.outlook.com>
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
To: Kairui Song <kasong@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Lianbo Jiang <lijiang@redhat.com>, Baoquan He <bhe@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>

On 8/25/19 11:45 PM, Kairui Song wrote:
> Since commit c7753208a94c ("x86, swiotlb: Add memory encryption support"),
> SWIOTLB will be enabled even if there is less than 4G of memory when SME
> is active, to support DMA of devices that not support address with the
> encrypt bit.
> 
> And commit aba2d9a6385a ("iommu/amd: Do not disable SWIOTLB if SME is
> active") make the kernel keep SWIOTLB enabled even if there is an IOMMU.
> 
> Then commit d7b417fa08d1 ("x86/mm: Add DMA support for SEV memory
> encryption") will always force SWIOTLB to be enabled when SEV is active
> in all cases.
> 
> Now, when either SME or SEV is active, SWIOTLB will be force enabled,
> and this is also true for kdump kernel. As a result kdump kernel will
> run out of already scarce pre-reserved memory easily.
> 
> So when SME/SEV is active, reserve extra memory for SWIOTLB to ensure
> kdump kernel have enough memory, except when "crashkernel=size[KMG],high"
> is specified or any offset is used. As for the high reservation case, an
> extra low memory region will always be reserved and that is enough for
> SWIOTLB. Else if the offset format is used, user should be fully aware
> of any possible kdump kernel memory requirement and have to organize the
> memory usage carefully.
> 
> Signed-off-by: Kairui Song <kasong@redhat.com>

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> 
> ---
> Update from V1:
> - Use mem_encrypt_active() instead of "sme_active() || sev_active()"
> - Don't reserve extra memory when ",high" or "@offset" is used, and
>   don't print redundant message.
> - Fix coding style problem
> 
>  arch/x86/kernel/setup.c | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index bbe35bf879f5..221beb10c55d 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -528,7 +528,7 @@ static int __init reserve_crashkernel_low(void)
>  
>  static void __init reserve_crashkernel(void)
>  {
> -	unsigned long long crash_size, crash_base, total_mem;
> +	unsigned long long crash_size, crash_base, total_mem, mem_enc_req;
>  	bool high = false;
>  	int ret;
>  
> @@ -550,6 +550,15 @@ static void __init reserve_crashkernel(void)
>  		return;
>  	}
>  
> +	/*
> +	 * When SME/SEV is active, it will always required an extra SWIOTLB
> +	 * region.
> +	 */
> +	if (mem_encrypt_active())
> +		mem_enc_req = ALIGN(swiotlb_size_or_default(), SZ_1M);
> +	else
> +		mem_enc_req = 0;
> +
>  	/* 0 means: find the address automatically */
>  	if (!crash_base) {
>  		/*
> @@ -563,11 +572,19 @@ static void __init reserve_crashkernel(void)
>  		if (!high)
>  			crash_base = memblock_find_in_range(CRASH_ALIGN,
>  						CRASH_ADDR_LOW_MAX,
> -						crash_size, CRASH_ALIGN);
> -		if (!crash_base)
> +						crash_size + mem_enc_req,
> +						CRASH_ALIGN);
> +		/*
> +		 * For high reservation, an extra low memory for SWIOTLB will
> +		 * always be reserved later, so no need to reserve extra
> +		 * memory for memory encryption case here.
> +		 */
> +		if (!crash_base) {
> +			mem_enc_req = 0;
>  			crash_base = memblock_find_in_range(CRASH_ALIGN,
>  						CRASH_ADDR_HIGH_MAX,
>  						crash_size, CRASH_ALIGN);
> +		}
>  		if (!crash_base) {
>  			pr_info("crashkernel reservation failed - No suitable area found.\n");
>  			return;
> @@ -575,6 +592,7 @@ static void __init reserve_crashkernel(void)
>  	} else {
>  		unsigned long long start;
>  
> +		mem_enc_req = 0;
>  		start = memblock_find_in_range(crash_base,
>  					       crash_base + crash_size,
>  					       crash_size, 1 << 20);
> @@ -583,6 +601,13 @@ static void __init reserve_crashkernel(void)
>  			return;
>  		}
>  	}
> +
> +	if (mem_enc_req) {
> +		pr_info("Memory encryption is active, crashkernel needs %ldMB extra memory\n",
> +			(unsigned long)(mem_enc_req >> 20));
> +		crash_size += mem_enc_req;
> +	}
> +
>  	ret = memblock_reserve(crash_base, crash_size);
>  	if (ret) {
>  		pr_err("%s: Error reserving crashkernel memblock.\n", __func__);
> 
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
