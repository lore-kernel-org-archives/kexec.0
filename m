Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Thu, 19 Jan 2017 11:28:50 +0000
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v29 3/9] arm64: kdump: reserve memory for crash dump kernel
Message-ID: <20170119112850.GD11176@leverpostej>
References: <20161228043347.27358-1-takahiro.akashi@linaro.org>
 <20161228043605.27470-2-takahiro.akashi@linaro.org>
 <20170112150926.GA12249@leverpostej>
 <20170113081617.GI20972@linaro.org>
 <20170113113914.GB26804@leverpostej>
 <20170117082043.GM20972@linaro.org>
 <20170117115441.GC11939@leverpostej>
 <20170119094941.GP20972@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170119094941.GP20972@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com, geoff@infradead.org, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Mark Salter <msalter@redhat.com>, Pratyush Anand <panand@redhat.com>

On Thu, Jan 19, 2017 at 06:49:42PM +0900, AKASHI Takahiro wrote:
> On Tue, Jan 17, 2017 at 11:54:42AM +0000, Mark Rutland wrote:
> > On Tue, Jan 17, 2017 at 05:20:44PM +0900, AKASHI Takahiro wrote:
> > > On Fri, Jan 13, 2017 at 11:39:15AM +0000, Mark Rutland wrote:
> > > > Great! I think it would be better to follow the approach of
> > > > mark_rodata_ro(), rather than opening up set_memory_*(), but otherwise,
> > > > it looks like it should work.
> > > 
> > > I'm not quite sure what the approach of mark_rodata_ro() means, but
> > > I found that using create_mapping_late() may cause two problems:
> > > 
> > > 1) it fails when PTE_CONT bits mismatch between an old and new mmu entry.
> > >    This can happen, say, if the memory range for crash dump kernel
> > >    starts in the mid of _continuous_ pages.
> > 
> > That should only happen if we try to remap a segment different to what
> > we originally mapped.
> > 
> > I was intending that we'd explicitly map the reserved region separately
> > in the boot path, like we do for kernel segments in map_kernel(). We
> > would allow sections and/or CONT entires. 
> > 
> > Then, in __map_memblock() we'd then skip that range as we do for the
> > linear map alias of the kernel image.
> > 
> > That way, we can later use create_mapping_late for that same region, and
> > it should handle sections and/or CONT entries in the exact same way as
> > it does for the kernel image segments in mark_rodata_ro().
> 
> I see.
> Which one do you prefer, yours above or my (second) solution?
> Either way, they do almost the same thing in terms of mapping.

While both should work, I'd prefer to match the existing map_kernel()
logic, (i.e. my suggestion above), for consistency.

> > I don't think we have much code useful for unmapping. We could re-use 
> > create_mapping_late for this, passing a set of prot bits that means the
> > entries are invalid (e.g. have a PAGE_KERNEL_INVALID).
> 
> Do you really think that we should totally invalidate mmu entries?
> I guess that, given proper cache & TLB flush operations, RO attribute is
> good enough for memory consistency, no?
> (None accesses the region, as I said, except in the case of re-loading
> crash dump kernel though.)

My worry is that the first kernel and kdump kernel may map (portions of)
the region with potentially confliciting memory attributes. So it would
be necessary to completely unmap the region.

You raise a good point that this would also mean we need to perform some
cache maintenance, which makes that a little more painful. We'd need a
sequence like:

* Unmap the region
* TLB invalidation
* Remap the region with non-cacheable attributes
* Cache maintenance
* Unmap the region
* TLB invalidation

> > We'd have to perform the TLB invalidation ourselves, but that shouldn't
> > be too painful.
> 
> Do we need to invalidate TLBs not only before but also after changing
> permission attributes as make_rodata_ro() does?

I believe we'd only have to perform the TLB invalidation after the
change of attributes.

Thanks,
Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
