Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cZ9Nj-00084z-2u
 for kexec@lists.infradead.org; Thu, 02 Feb 2017 04:52:29 +0000
Received: by mail-pf0-f176.google.com with SMTP id y143so2078075pfb.0
 for <kexec@lists.infradead.org>; Wed, 01 Feb 2017 20:52:06 -0800 (PST)
Date: Thu, 2 Feb 2017 13:52:36 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v31 03/12] arm64: kdump: reserve memory for crash dump
 kernel
Message-ID: <20170202045235.GB13549@linaro.org>
References: <20170201124218.5823-1-takahiro.akashi@linaro.org>
 <20170201124630.6016-2-takahiro.akashi@linaro.org>
 <20170201152609.GE4756@leverpostej>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170201152609.GE4756@leverpostej>
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
To: Mark Rutland <mark.rutland@arm.com>
Cc: Pratyush Anand <panand@redhat.com>, geoff@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com, Mark Salter <msalter@redhat.com>, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Wed, Feb 01, 2017 at 03:26:09PM +0000, Mark Rutland wrote:
> Hi,
> 
> On Wed, Feb 01, 2017 at 09:46:22PM +0900, AKASHI Takahiro wrote:
> > +#ifdef CONFIG_KEXEC_CORE
> > +/*
> > + * reserve_crashkernel() - reserves memory for crash kernel
> > + *
> > + * This function reserves memory area given in "crashkernel=" kernel command
> > + * line parameter. The memory reserved is used by dump capture kernel when
> > + * primary kernel is crashing.
> > + */
> > +static void __init reserve_crashkernel(void)
> > +{
> > +	unsigned long long crash_base, crash_size;
> > +	int ret;
> > +
> > +	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> > +				&crash_size, &crash_base);
> > +	/* no crashkernel= or invalid value specified */
> > +	if (ret || !crash_size)
> > +		return;
> > +
> > +	crash_size = PAGE_ALIGN(crash_size);
> > +
> > +	if (crash_base == 0) {
> > +		/* Current arm64 boot protocol requires 2MB alignment */
> > +		crash_base = memblock_find_in_range(0, ARCH_LOW_ADDRESS_LIMIT,
> > +				crash_size, SZ_2M);
> > +		if (crash_base == 0) {
> > +			pr_warn("Unable to allocate crashkernel (size:%llx)\n",
> > +				crash_size);
> 
> Nit: can we please make that "size: 0x%llx", so that it's always clearly
> a hex number? e.g.
> 
> 	pr_warn("cannot allocate 0x%llx bytes for crashkernel\n",
> 		crash_size);

OK

> > +			return;
> > +		}
> > +	} else {
> > +		/* User specifies base address explicitly. */
> > +		if (!memblock_is_region_memory(crash_base, crash_size) ||
> > +			memblock_is_region_reserved(crash_base, crash_size)) {
> > +			pr_warn("crashkernel has wrong address or size\n");
> > +			return;
> > +		}
> 
> To better report the error, can we please split these up:
> 
> 		if (!memblock_is_region_memory(crash_base, crash_size)) {
> 			pr_warn("cannot reserve crashkernel: region is not memory\n");
> 			return;
> 		}
> 
> 		if (!memblock_is_region_memory(crash_base, crash_size)) {
> 			pr_warn("cannot reserve crashkernel: region overlaps reserved memory\n");
> 			return;
> 		}

OK, and

> > +		if (!IS_ALIGNED(crash_base, SZ_2M)) {
> > +			pr_warn("crashkernel base address is not 2MB aligned\n");


			pr_warn("cannot reserve crashkernel: base address is not 2MB aligned\n");

> > +			return;
> > +		}
> > +	}
> > +	memblock_reserve(crash_base, crash_size);
> > +
> > +	pr_info("Reserving %lldMB of memory at %lldMB for crashkernel\n",
> > +		crash_size >> 20, crash_base >> 20);
> 
> We only page-align the size, so the MB will be a little off, but that's
> probably OK. However, it would also be nicer to log the base as an
> address.

You might notice that the exact same message is used by all the other
architectures, but

> Could we dump this as we do for the kernel memory layout? e.g.
> 
> 	pr_info("crashkernel reserved: 0x%016lx - 0x%016lx (%lld MB)\n",
> 		crash_base, crash_base + crash_size, crash_size >> 20);

We can go either way.

> With those:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
-Takahiro AKASHI

> Thanks,
> Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
