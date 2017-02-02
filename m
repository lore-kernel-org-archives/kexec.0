Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cZEn2-0001UY-KT
 for kexec@lists.infradead.org; Thu, 02 Feb 2017 10:38:58 +0000
Received: by mail-pf0-f176.google.com with SMTP id 189so4530712pfu.3
 for <kexec@lists.infradead.org>; Thu, 02 Feb 2017 02:38:36 -0800 (PST)
Date: Thu, 2 Feb 2017 19:39:06 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v31 05/12] arm64: kdump: protect crash dump kernel memory
Message-ID: <20170202103905.GF13549@linaro.org>
References: <20170201124218.5823-1-takahiro.akashi@linaro.org>
 <20170201124630.6016-4-takahiro.akashi@linaro.org>
 <20170201180008.GG4756@leverpostej>
 <20170201182506.GA30584@leverpostej>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170201182506.GA30584@leverpostej>
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

On Wed, Feb 01, 2017 at 06:25:06PM +0000, Mark Rutland wrote:
> On Wed, Feb 01, 2017 at 06:00:08PM +0000, Mark Rutland wrote:
> > On Wed, Feb 01, 2017 at 09:46:24PM +0900, AKASHI Takahiro wrote:
> > > arch_kexec_protect_crashkres() and arch_kexec_unprotect_crashkres()
> > > are meant to be called around kexec_load() in order to protect
> > > the memory allocated for crash dump kernel once after it's loaded.
> > > 
> > > The protection is implemented here by unmapping the region rather than
> > > making it read-only.
> > > To make the things work correctly, we also have to
> > > - put the region in an isolated, page-level mapping initially, and
> > > - move copying kexec's control_code_page to machine_kexec_prepare()
> > > 
> > > Note that page-level mapping is also required to allow for shrinking
> > > the size of memory, through /sys/kernel/kexec_crash_size, by any number
> > > of multiple pages.
> > 
> > Looking at kexec_crash_size_store(), I don't see where memory returned
> > to the OS is mapped. AFAICT, if the region is protected when the user
> > shrinks the region, the memory will not be mapped, yet handed over to
> > the kernel for general allocation.
> > 
> > Surely we need an arch-specific callback to handle that? e.g.
> > 
> > arch_crash_release_region(unsigned long base, unsigned long size)
> > {
> > 	/*
> > 	 * Ensure the region is part of the linear map before we return
> > 	 * it to the OS. We won't unmap this again, so we can use block
> > 	 * mappings.
> > 	 */
> > 	create_pgd_mapping(&init_mm, start, __phys_to_virt(start),
> > 			   size, PAGE_KERNEL, false);
> > }
> > 
> > ... which we'd call from crash_shrink_memory() before we freed the
> > reserved pages.
> 
> Another question is (how) does hyp map this region?

I don't get your point here.
Hyp mode does care only physical memory in intermediate address, doesn't it?

If this is not a matter now, I will post v32 tomorrow :)

-Takahiro AKASHI


> Thanks,
> Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
