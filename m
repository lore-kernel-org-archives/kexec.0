Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i7vc9-0002mq-2E
 for kexec@lists.infradead.org; Wed, 11 Sep 2019 05:56:26 +0000
Received: by mail-wm1-x344.google.com with SMTP id t9so1911421wmi.5
 for <kexec@lists.infradead.org>; Tue, 10 Sep 2019 22:56:22 -0700 (PDT)
Date: Wed, 11 Sep 2019 07:56:18 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3 2/2] x86/kdump: Reserve extra memory when SME or SEV
 is active
Message-ID: <20190911055618.GA104115@gmail.com>
References: <20190910151341.14986-1-kasong@redhat.com>
 <20190910151341.14986-3-kasong@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190910151341.14986-3-kasong@redhat.com>
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
To: Kairui Song <kasong@redhat.com>
Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>, Lianbo Jiang <lijiang@redhat.com>, Baoquan He <bhe@redhat.com>, x86@kernel.org, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>


* Kairui Song <kasong@redhat.com> wrote:

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
>  arch/x86/kernel/setup.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 71f20bb18cb0..ee6a2f1e2226 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -530,7 +530,7 @@ static int __init crashkernel_find_region(unsigned long long *crash_base,
>  					  unsigned long long *crash_size,
>  					  bool high)
>  {
> -	unsigned long long base, size;
> +	unsigned long long base, size, mem_enc_req = 0;
>  
>  	base = *crash_base;
>  	size = *crash_size;
> @@ -561,11 +561,25 @@ static int __init crashkernel_find_region(unsigned long long *crash_base,
>  	if (high)
>  		goto high_reserve;
>  
> +	/*
> +	 * When SME/SEV is active and not using high reserve,
> +	 * it will always required an extra SWIOTLB region.
> +	 */
> +	if (mem_encrypt_active())
> +		mem_enc_req = ALIGN(swiotlb_size_or_default(), SZ_1M);
> +
>  	base = memblock_find_in_range(CRASH_ALIGN,
> -				      CRASH_ADDR_LOW_MAX, size,
> +				      CRASH_ADDR_LOW_MAX,
> +				      size + mem_enc_req,
>  				      CRASH_ALIGN);

What sizes are we talking about here?

- What is the possible size range of swiotlb_size_or_default()

- What is the size of CRASH_ADDR_LOW_MAX (the old limit)?

- Why do we replace one fixed limit with another fixed limit instead of 
  accurately sizing the area, with each required feature adding its own 
  requirement to the reservation size?

I.e. please engineer this into a proper solution instead of just 
modifying it around the edges.

For example have you considered adding some sort of 
kdump_memory_reserve(size) facility, which increases the reservation size 
as something like SWIOTLB gets activated? That would avoid the ugly 
mem_encrypt_active() flag, it would just automagically work.

Thanks,

	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
