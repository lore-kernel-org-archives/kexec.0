Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cZIVu-0005Xl-7J
 for kexec@lists.infradead.org; Thu, 02 Feb 2017 14:37:32 +0000
Received: by mail-pg0-f48.google.com with SMTP id 204so6319489pge.0
 for <kexec@lists.infradead.org>; Thu, 02 Feb 2017 06:37:09 -0800 (PST)
Date: Thu, 2 Feb 2017 23:36:04 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v31 05/12] arm64: kdump: protect crash dump kernel memory
Message-ID: <20170202143602.GA3078@fireball>
References: <20170201124218.5823-1-takahiro.akashi@linaro.org>
 <20170201124630.6016-4-takahiro.akashi@linaro.org>
 <20170201180008.GG4756@leverpostej>
 <20170202103129.GE13549@linaro.org>
 <20170202111637.GA31394@leverpostej>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170202111637.GA31394@leverpostej>
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
Cc: geoff@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Thu, Feb 02, 2017 at 11:16:37AM +0000, Mark Rutland wrote:
> Hi,
> 
> On Thu, Feb 02, 2017 at 07:31:30PM +0900, AKASHI Takahiro wrote:
> > On Wed, Feb 01, 2017 at 06:00:08PM +0000, Mark Rutland wrote:
> > > On Wed, Feb 01, 2017 at 09:46:24PM +0900, AKASHI Takahiro wrote:
> > > > arch_kexec_protect_crashkres() and arch_kexec_unprotect_crashkres()
> > > > are meant to be called around kexec_load() in order to protect
> > > > the memory allocated for crash dump kernel once after it's loaded.
> > > > 
> > > > The protection is implemented here by unmapping the region rather than
> > > > making it read-only.
> > > > To make the things work correctly, we also have to
> > > > - put the region in an isolated, page-level mapping initially, and
> > > > - move copying kexec's control_code_page to machine_kexec_prepare()
> > > > 
> > > > Note that page-level mapping is also required to allow for shrinking
> > > > the size of memory, through /sys/kernel/kexec_crash_size, by any number
> > > > of multiple pages.
> > > 
> > > Looking at kexec_crash_size_store(), I don't see where memory returned
> > > to the OS is mapped. AFAICT, if the region is protected when the user
> > > shrinks the region, the memory will not be mapped, yet handed over to
> > > the kernel for general allocation.
> > 
> > The region is protected only when the crash dump kernel is loaded,
> > and after that, we are no longer able to shrink the region.
> 
> Ah, sorry. My misunderstanding strikes again. That should be fine; sorry
> for the noise, and thanks for explaining.
> 
> > > > @@ -538,6 +540,24 @@ static void __init map_mem(pgd_t *pgd)
> > > >  		if (memblock_is_nomap(reg))
> > > >  			continue;
> > > >  
> > > > +#ifdef CONFIG_KEXEC_CORE
> > > > +		/*
> > > > +		 * While crash dump kernel memory is contained in a single
> > > > +		 * memblock for now, it should appear in an isolated mapping
> > > > +		 * so that we can independently unmap the region later.
> > > > +		 */
> > > > +		if (crashk_res.end &&
> > > > +		    (start <= crashk_res.start) &&
> > > > +		    ((crashk_res.end + 1) < end)) {
> > > > +			if (crashk_res.start != start)
> > > > +				__map_memblock(pgd, start, crashk_res.start);
> > > > +
> > > > +			if ((crashk_res.end + 1) < end)
> > > > +				__map_memblock(pgd, crashk_res.end + 1, end);
> > > > +
> > > > +			continue;
> > > > +		}
> > > > +#endif
> > > 
> > > This wasn't quite what I had in mind. I had expected that here we would
> > > isolate the ranges we wanted to avoid mapping (with a comment as to why
> > > we couldn't move the memblock_isolate_range() calls earlier). In
> > > map_memblock(), we'd skip those ranges entirely.
> > > 
> > > I believe the above isn't correct if we have a single memblock.memory
> > > region covering both the crashkernel and kernel regions. In that case,
> > > we'd erroneously map the portion which overlaps the kernel.
> > > 
> > > It seems there are a number of subtle problems here. :/
> > 
> > I didn't see any problems, but I will go back with memblock_isolate_range()
> > here in map_mem().
> 
> Imagine we have phyiscal memory:
> 
> singe RAM bank:    |---------------------------------------------------|
> kernel image:              |---|
> crashkernel:                                      |------|
> 
> ... we reserve the image and crashkernel region, but these would still
> remain part of the memory memblock, and we'd have a memblock layout
> like:
> 
> memblock.memory:   |---------------------------------------------------|
> memblock.reserved:         |---|                  |------|
> 
> ... in map_mem() we iterate over memblock.memory, so we only have a
> single entry to handle in this case. With the code above, we'd find that
> it overlaps the crashk_res, and we'd map the parts which don't overlap,
> e.g.
> 
> memblock.memory:   |---------------------------------------------------|
> crashkernel:                                      |------|
> mapped regions:    |-----------------------------|        |------------|

I'm afraid that you might be talking about my v30.
The code in v31 was a bit modified, and now

> ... hwoever, this means we've mapped the portion which overlaps with the
> kernel's linear alias (i.e. the case that we try to handle in
> __map_memblock()). What we actually wanted was:
> 
> memblock.memory:   |---------------------------------------------------|
> kernel image:              |---|
> crashkernel:                                      |------|

                     |-----------(A)---------------|        |----(B)-----|

__map_memblock() is called against each of (A) and (B),
so I think we will get

> mapped regions:    |------|     |----------------|        |------------|

this mapping.

> 
> 
> To handle all cases I think we have to isolate *both* the image and
> crashkernel in map_mem(). That would leave use with:
> 
> memblock.memory:   |------||---||----------------||------||------------|
> memblock.reserved:         |---|                  |------|
> 
> ... so then we can check for overlap with either the kernel or
> crashkernel in __map_memblock(), and return early, e.g.
> 
> __map_memblock(...)
> 	if (overlaps_with_kernel(...))
> 		return;
> 	if (overlaps_with_crashekrenl(...))
> 		return;
> 	
> 	__create_pgd_mapping(...);
> }
> 
> We can pull the kernel alias mapping out of __map_memblock() and put it
> at the end of map_mem().
> 
> Does that make sense?

OK, I now understand your anticipation.

Thanks,
-Takahiro AKASHI


> Thanks,
> Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
