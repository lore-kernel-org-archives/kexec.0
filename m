Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x22b.google.com ([2607:f8b0:400e:c05::22b])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cT2aQ-0002jY-BF
 for kexec@lists.infradead.org; Mon, 16 Jan 2017 08:24:19 +0000
Received: by mail-pg0-x22b.google.com with SMTP id t6so8583800pgt.3
 for <kexec@lists.infradead.org>; Mon, 16 Jan 2017 00:23:57 -0800 (PST)
Date: Mon, 16 Jan 2017 17:25:07 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v29 9/9] Documentation: dt: chosen properties for arm64
 kdump
Message-ID: <20170116082505.GL20972@linaro.org>
References: <20161228043347.27358-1-takahiro.akashi@linaro.org>
 <20161228043734.27535-1-takahiro.akashi@linaro.org>
 <20170112153944.GB12249@leverpostej>
 <20170113091339.GK20972@linaro.org>
 <20170113111756.GC26120@leverpostej>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170113111756.GC26120@leverpostej>
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
Cc: devicetree@vger.kernel.org, geoff@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org, james.morse@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Fri, Jan 13, 2017 at 11:17:56AM +0000, Mark Rutland wrote:
> On Fri, Jan 13, 2017 at 06:13:49PM +0900, AKASHI Takahiro wrote:
> > On Thu, Jan 12, 2017 at 03:39:45PM +0000, Mark Rutland wrote:
> > > On Wed, Dec 28, 2016 at 01:37:34PM +0900, AKASHI Takahiro wrote:
> > > > +linux,crashkernel-base
> > > > +linux,crashkernel-size
> > > > +----------------------
> > > > +
> > > > +These properties (currently used on PowerPC and arm64) indicates
> > > > +the base address and the size, respectively, of the reserved memory
> > > > +range for crash dump kernel.
> > > 
> > > From this description, it's not clear to me what the (expected)
> > > consumers of this property are, nor what is expected to provide it.
> > > 
> > > In previous rounds of review, I had assumed that this was used to
> > > describe a preference to the first kernel as to what region of memory
> > > should be used for a subsequent kdump kernel. Looking around, I'm not
> > > sure if I was correct in that assessment.
> > > 
> > > I see that arch/powerpc seems to consume this property to configure
> > > crashk_res, but it also rewrites it based on crashk_res, presumably for
> > > the benefit of userspace. It's not clear to me how on powerpc the kdump
> > > kernel knows its memory range -- is more DT modification done in the
> > > kernel and/or userspace?
> > 
> > I don't believe that powerpc will rewrite the property any way.
> > As far as I know from *the source code*, powerpc kernel retrieves
> > the memory range for crash dump kernel from a kernel command line, i.e.
> > crashkernel=, and then exposes it through DT to userspace (assuming
> > kexec-tools).
> 
> The rewriting I describe is in export_crashk_values() in
> arch/powerpc/kernel/machine_kexec.c, where the code deletes existing the
> properties, and adds new ones, to the DT exposed to userspace.
> 
> So I think we're just quibbling over the definition of "rewrite".

Gotcha

> > > arm64 we should either ensure that /proc/iomem is consistently usable
> > > (and have userspace consistently use it), or we should expose a new file
> > > specifically to expose this information.
> > 
> > The thing that I had in my mind when adding this property is that
> > /proc/iomem would be obsolete in the future, then we should have
> > an alternative in hand.
> 
> Ok.
> 
> My disagreement is with using the DT as a channel to convey information
> from the kernel to userspace.
> 
> I'm more than happy for a new file or other mechanism to express this
> information. For example, we could add
> /sys/kernel/kexec_crash_{base,size} or similar.

It may make sense because /sys/kernel/kexec_crash_size already exists,
so why not kexec_crash_base?
My concern, however, is that this kind of interface might prevent us from
allowing multiple regions to be reserved for crash dump kernel in the future.
(There is an assumption that we have only one region at least on arm64 though.)

Thanks,
-Takahiro AKASHI

> 
> > > Further, I do not think we need this property. It makes more sense to me
> > > for the preference of a a region to be described to the *first* kernel
> > > using the command line consistently.
> > > 
> > > So I think we should drop this property, and not use it on arm64. Please
> > > document this as powerpc only.
> > 
> > OK, but if we drop the property from arm64 code, we have no reason
> > to leave its description in this patch.
> > (In fact, there are a few more (undocumented) properties that only ppc
> > uses for kdump.)
> 
> I'm happy to drop it, then.
> 
> > > > +linux,usable-memory-range
> > > > +-------------------------
> > > > +
> > > > +This property (currently used only on arm64) holds the memory range,
> > > > +the base address and the size, which can be used as system ram on
> > > > +the *current* kernel. Note that, if this property is present, any memory
> > > > +regions under "memory" nodes in DT blob or ones marked as "conventional
> > > > +memory" in EFI memory map should be ignored.
> > > 
> > > Could you please replace this with:
> > > 
> > >   This property (arm64 only) holds a base address and size, describing a
> > >   limited region in which memory may be considered available for use by
> > >   the kernel. Memory outside of this range is not available for use.
> > >   
> > >   This property describes a limitation: memory within this range is only
> > >   valid when also described through another mechanism that the kernel
> > >   would otherwise use to determine available memory (e.g. memory nodes
> > >   or the EFI memory map). Valid memory may be sparse within the range.
> > 
> > Sure.
> 
> Cheers!
> 
> Thanks,
> Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
