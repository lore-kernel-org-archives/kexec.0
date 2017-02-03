Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cZSwJ-0002Kk-D8
 for kexec@lists.infradead.org; Fri, 03 Feb 2017 01:45:29 +0000
Received: by mail-pf0-f171.google.com with SMTP id e4so1621941pfg.1
 for <kexec@lists.infradead.org>; Thu, 02 Feb 2017 17:45:06 -0800 (PST)
Date: Fri, 3 Feb 2017 10:45:39 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v31 05/12] arm64: kdump: protect crash dump kernel memory
Message-ID: <20170203014538.GA29585@linaro.org>
References: <20170201124218.5823-1-takahiro.akashi@linaro.org>
 <20170201124630.6016-4-takahiro.akashi@linaro.org>
 <20170201180008.GG4756@leverpostej>
 <20170201182506.GA30584@leverpostej>
 <20170202103905.GF13549@linaro.org>
 <20170202115425.GJ31394@leverpostej>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170202115425.GJ31394@leverpostej>
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

Mark,

On Thu, Feb 02, 2017 at 11:54:25AM +0000, Mark Rutland wrote:
> On Thu, Feb 02, 2017 at 07:39:06PM +0900, AKASHI Takahiro wrote:
> > Mark,
> > 
> > On Wed, Feb 01, 2017 at 06:25:06PM +0000, Mark Rutland wrote:
> > > On Wed, Feb 01, 2017 at 06:00:08PM +0000, Mark Rutland wrote:
> > > > On Wed, Feb 01, 2017 at 09:46:24PM +0900, AKASHI Takahiro wrote:
> > > > > arch_kexec_protect_crashkres() and arch_kexec_unprotect_crashkres()
> > > > > are meant to be called around kexec_load() in order to protect
> > > > > the memory allocated for crash dump kernel once after it's loaded.
> > > > > 
> > > > > The protection is implemented here by unmapping the region rather than
> > > > > making it read-only.
> > > > > To make the things work correctly, we also have to
> > > > > - put the region in an isolated, page-level mapping initially, and
> > > > > - move copying kexec's control_code_page to machine_kexec_prepare()
> > > > > 
> > > > > Note that page-level mapping is also required to allow for shrinking
> > > > > the size of memory, through /sys/kernel/kexec_crash_size, by any number
> > > > > of multiple pages.
> > > > 
> > > > Looking at kexec_crash_size_store(), I don't see where memory returned
> > > > to the OS is mapped. AFAICT, if the region is protected when the user
> > > > shrinks the region, the memory will not be mapped, yet handed over to
> > > > the kernel for general allocation.
> > > > 
> > > > Surely we need an arch-specific callback to handle that? e.g.
> > > > 
> > > > arch_crash_release_region(unsigned long base, unsigned long size)
> > > > {
> > > > 	/*
> > > > 	 * Ensure the region is part of the linear map before we return
> > > > 	 * it to the OS. We won't unmap this again, so we can use block
> > > > 	 * mappings.
> > > > 	 */
> > > > 	create_pgd_mapping(&init_mm, start, __phys_to_virt(start),
> > > > 			   size, PAGE_KERNEL, false);
> > > > }
> > > > 
> > > > ... which we'd call from crash_shrink_memory() before we freed the
> > > > reserved pages.
> > > 
> > > Another question is (how) does hyp map this region?
> > 
> > I don't get your point here.
> > Hyp mode does care only physical memory in intermediate address, doesn't it?
> 
> My concern was that hyp may map the region; and thus buggy code at hyp
> can corrupt the region (and/or hyp may conflict w.r.t. attributes).

Grep'ing create_hyp_mappings() under arch/arm(64)/kvm shows that
we have only a few small regions of memory mapped in hyp mode.
I also confirmed that there is no active mapping for crash dump kernel
memory by checking mmu tables with DS-5 debugger.

> We mght have to ensure hyp doesn't map the crashkernel region, and to
> case us pain, disallow freeing of any part of the region.

So I don't believe we need to worry such a case.

Thanks,
-Takahiro AKASHI

> I'll dig into this.
> 
> Thanks,
> Mark.
> 
> > If this is not a matter now, I will post v32 tomorrow :)
> > 
> > -Takahiro AKASHI
> > 
> > 
> > > Thanks,
> > > Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
