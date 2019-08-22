Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-eopbgr750057.outbound.protection.outlook.com
 ([40.107.75.57] helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i0oBR-0001HD-Bt
 for kexec@lists.infradead.org; Thu, 22 Aug 2019 14:35:27 +0000
From: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH] x86/kdump: Reserve extra memory when SME or SEV is active
Date: Thu, 22 Aug 2019 14:35:21 +0000
Message-ID: <ff049b95-92a3-52ab-7ee8-01051a597cff@amd.com>
References: <20190822025328.17151-1-kasong@redhat.com>
In-Reply-To: <20190822025328.17151-1-kasong@redhat.com>
Content-Language: en-US
Content-ID: <EEDAE35B32F9CC4B801F6354AE021080@namprd12.prod.outlook.com>
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

On 8/21/19 9:53 PM, Kairui Song wrote:
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
> ---
>  arch/x86/kernel/setup.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index bbe35bf879f5..ed91fa9d9f6e 100644
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
> @@ -550,6 +550,17 @@ static void __init reserve_crashkernel(void)
>  		return;
>  	}
>  
> +	/*
> +	 * When SME/SEV is active, it will always required an extra SWIOTLB
> +	 * region.
> +	 */
> +	if (sme_active() || sev_active()) {

You can use mem_encrypt_active() here in place of the two checks.

> +		mem_enc_req = ALIGN(swiotlb_size_or_default(), SZ_1M);
> +		pr_info("Memory encryption is active, crashkernel needs %ldMB extra memory\n",
> +				(unsigned long)(mem_enc_req >> 20));

There is a point below where you zero out this value, so should this
be issued later only if mem_enc_req is non-zero?

Also, looks like one too many tabs.

> +	} else

Since you used braces on the if path, you need braces on the else path.

Thanks,
Tom

> +		mem_enc_req = 0;
> +
>  	/* 0 means: find the address automatically */
>  	if (!crash_base) {
>  		/*
> @@ -563,11 +574,19 @@ static void __init reserve_crashkernel(void)
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
> @@ -583,6 +602,7 @@ static void __init reserve_crashkernel(void)
>  			return;
>  		}
>  	}
> +	crash_size += mem_enc_req;
>  	ret = memblock_reserve(crash_base, crash_size);
>  	if (ret) {
>  		pr_err("%s: Error reserving crashkernel memblock.\n", __func__);
> 
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
