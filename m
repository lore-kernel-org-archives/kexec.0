Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x234.google.com ([2607:f8b0:400e:c03::234])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bNLsZ-0006Hc-JT
 for kexec@lists.infradead.org; Wed, 13 Jul 2016 15:15:16 +0000
Received: by mail-pa0-x234.google.com with SMTP id pp5so11991493pac.3
 for <kexec@lists.infradead.org>; Wed, 13 Jul 2016 08:14:54 -0700 (PDT)
Date: Thu, 14 Jul 2016 00:14:46 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v22 8/8] Documentation: dt: chosen properties for arm64
 kdump
Message-ID: <20160713151438.GB25106@porco>
References: <20160712050514.22307-1-takahiro.akashi@linaro.org>
 <20160712050514.22307-9-takahiro.akashi@linaro.org>
 <20160712100745.GA21909@leverpostej>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160712100745.GA21909@leverpostej>
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
Cc: geoff@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, robh+dt@kernel.org, james.morse@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Mark,

On Tue, Jul 12, 2016 at 11:07:45AM +0100, Mark Rutland wrote:
> Hi,
> 
> Apologies for the delay on this.
> 
> On Tue, Jul 12, 2016 at 02:05:14PM +0900, AKASHI Takahiro wrote:
> > From: James Morse <james.morse@arm.com>
> > 
> > Add documentation for
> > 	linux,crashkernel-base and crashkernel-size,
> > 	linux,usable-memory-range, and
> > 	linux,elfcorehdr
> > used by arm64 kexec/kdump to decribe the kdump reserved area, and
> > the elfcorehdr's location within it.
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > [takahiro.akashi@linaro.org:
> >     renamed "usable-memory" to "usable-memory-range",
> >     added "linux,crashkernel-base" and "-size" ]
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/chosen.txt | 45 ++++++++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
> > index 6ae9d82..d7a3a86 100644
> > --- a/Documentation/devicetree/bindings/chosen.txt
> > +++ b/Documentation/devicetree/bindings/chosen.txt
> > @@ -52,3 +52,48 @@ This property is set (currently only on PowerPC, and only needed on
> >  book3e) by some versions of kexec-tools to tell the new kernel that it
> >  is being booted by kexec, as the booting environment may differ (e.g.
> >  a different secondary CPU release mechanism)
> > +
> > +linux,crashkernel-base
> > +linux,crashkernel-size
> > +----------------------
> > +These properties are set (on PowerPC and arm64) during kdump to tell
> > +use-space tools, like kexec-tools, the base address of the crash-dump
> > +kernel's reserved area of memory and the size. e.g.
> 
> No need to mention what consumes this. Just state what it describes,
> e.g.
> 
> 	These properties describe the base and size of the crash-dump
> 	kernel's reserved area of memory. Valid for PowerPC and arm64.

Sure.

> > +
> > +/ {
> > +	chosen {
> > +		linux,crashkernel-base = <0x9 0xf0000000>;
> > +		linux,crashkernel-size = <0x0 0x10000000>;
> > +	};
> > +};
> > +
> > +linux,usable-memory-range
> > +-------------------------
> > +
> > +This property is set (currently only on arm64) during kdump to tell
> > +the crash-dump kernel the base address of its reserved area of memory,
> > +and the size. e.g.
> 
> The description sounds like this duplicates linux,crashkernel-*. What is
> the difference between the two?

Simply saying, crashkernel-* are for the first(normal) kernel,
while usable-memory-range is for the second(crash-dump) kernel.

The former appears only under /sys/firmware/devicetree/base/
on kdump-enabled kernel  whenever "crashkernel=" command line parameter
is specified. So user space tools, like kexec-tools, will be able to know
what memory region is reserved for kdump.

The latter is added in device-tree blob which is passed to
crash-dump kernel so the kernel recognize what memory region is usable
for system ram. We will see it in /sys/firmware/devicetree/base
as well as /sys/firmware/fdt on crash dump kernel. 

So both can potentially appear at the same time on crash dump kernel, but
they will have different values in that case.
(So we need different names.)

> On powerpc it looks like there's a linux,usable-memory property (without
> the -range suffix). How do these differ?

Please also see Thiago's comment.
Basically "linux,usable-memory" property imposes further restriction
on memory node's "reg" property.

Currently kdump only supports a single memory region as usable memory
of crash dump kernel, and so adding "linux,usable-memory" to every
memory node in dtb is sort of "doing too much" IMHO.
In addition, there are no memory nodes on UEFI(w/ACPI) systems.

> > +
> > +/ {
> > +	chosen {
> > +		linux,usable-memory-range = <0x9 0xf0000000 0x0 0x10000000>;
> > +	};
> > +};
> > +
> > +Please note that, if this property is present, any memory regions under
> > +"memory" nodes will be ignored.
> 
> What exactly do you mean by "ignored"?
> 
> Do we truly ignore this property, or do we map that memory at some
> point, even if not used for general allocation?

Totally ignored. All the regions are excluded from memblock.
See my patch #1.

> > +
> > +linux,elfcorehdr
> > +----------------
> > +
> > +This property is set (currently only on arm64) during kdump to tell
> > +the crash-dump kernel the address and size of the elfcorehdr that describes
> > +the old kernel's memory as an elf file. This memory must reside within
> > +the area described by 'linux,usable-memory-range'. e.g.
> 
> 
> As with the linux,crashkernel-* properties, just state what this
> describes, e.g.
> 
> 	This property describes the base and size of the ELF core
> 	header, which describes the old kernel's memory as an ELF file.
> 	This memory must reside within the range described by
> 	linux,usable-memory-range.
> 
> That said, this falling within usable-memory feels very odd, because
> it's not actually usable for general purposes. Why can the kernel not
> memremap this, such that it need not be in usable-memory?

Well, James made a similar comment on this before.
By putting elfcorehdr in usable memory of crash dump kernel,
it doesn't even have to call memremap() to access the data.

Initially, I thought that it would also reduce the possibility
of the elfcorehdr region being corrupted by accident on crash, but
there will be no difference even if it is allocated anywhere else.

Thanks,
-Takahiro AKASHI

> Thanks,
> Mark.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
