Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5udN-0000Tf-JJ
 for kexec@lists.infradead.org; Thu, 05 Sep 2019 16:29:23 +0000
Date: Thu, 5 Sep 2019 18:29:09 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2] x86/kdump: Reserve extra memory when SME or SEV is
 active
Message-ID: <20190905162909.GF19246@zn.tnic>
References: <20190826044535.9646-1-kasong@redhat.com>
 <20190830164513.GE30413@zn.tnic>
 <e70f1e99-f696-51e2-f50c-148bcda5dfb6@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e70f1e99-f696-51e2-f50c-148bcda5dfb6@redhat.com>
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
Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>, Lianbo Jiang <lijiang@redhat.com>, Baoquan He <bhe@redhat.com>, x86@kernel.org, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>

On Mon, Sep 02, 2019 at 03:38:22PM +0800, Kairui Song wrote:
> Will it be good if the final code looks like this?
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 48115cf11e0f..754b25d6e785 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -526,6 +526,69 @@ static int __init reserve_crashkernel_low(void)
>  	return 0;
>  }
> +static int __init crashkernel_find_region(
> +		unsigned long long *base,
> +		unsigned long long *size,
> +		bool high)

Those should be aligned at the opening brace.

> +{
> +	unsigned long long start, mem_enc_req = 0;

Declare that mem_enc_req in the if (!high) branch below, where you need it only.

> +
> +	/*
> +	 * *base == 0 means: find the address automatically, else just
> +	 * verify the region is useable
> +	 */
> +	if (*base) {
> +		start = memblock_find_in_range(*base, *base + *size,
> +					       *size, 1 << 20);
> +		if (start != *base) {
> +			pr_info("crashkernel reservation failed - memory is in use.\n");
> +			return -EBUSY;

I don't like functions which change external variables passed as
pointers but then in the error case, change those unnecessarily. Write
into *base and *size only in the success case pls and use local vars for
the intermediate results.

Also, those retvals are not visible to userspace - just return negative for
error and 0 for success.

> +		}
> +		return 0;
> +	}
> +
> +	/*
> +	 * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
> +	 * crashkernel=x,high reserves memory over 4G, also allocates
> +	 * 256M extra low memory for DMA buffers and swiotlb.
> +	 * But the extra memory is not required for all machines.
> +	 * So try low memory first and fall back to high memory
> +	 * unless "crashkernel=size[KMG],high" is specified.
> +	 */
> +	if (!high) {

	if (high)
		goto high_reserve;

	< now save an indentation level >

> +		/*
> +		 * When SME/SEV is active and not using high reserve,
> +		 * it will always required an extra SWIOTLB region.
> +		 */
> +		if (mem_encrypt_active())
> +			mem_enc_req = ALIGN(swiotlb_size_or_default(), SZ_1M);
> +
> +		*base = memblock_find_in_range(CRASH_ALIGN,
> +					       CRASH_ADDR_LOW_MAX,
> +					       *size + mem_enc_req,
> +					       CRASH_ALIGN);
> +		if (*base) {
> +			if (mem_enc_req) {
> +				pr_info("Memory encryption is active, crashkernel needs %ldMB extra memory\n",
> +					(unsigned long)(mem_enc_req >> 20));
> +				*size += mem_enc_req;
> +			}
> +			return 0;
> +		}
> +	}
> +

high_reserve:

> +	/* Try high reserve */
> +	*base = memblock_find_in_range(CRASH_ALIGN,
> +				       CRASH_ADDR_HIGH_MAX,
> +				       *size, CRASH_ALIGN);
> +	if (!*base) {
> +		pr_info("crashkernel reservation failed - No suitable area found.\n");
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}

...

> If you are OK with this, I will split it into two patch and send V3.

With that, yes, this looks a bit better.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
