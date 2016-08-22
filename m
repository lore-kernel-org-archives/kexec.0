Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x230.google.com ([2607:f8b0:400e:c00::230])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bbgkx-0004o8-2D
 for kexec@lists.infradead.org; Mon, 22 Aug 2016 04:22:41 +0000
Received: by mail-pf0-x230.google.com with SMTP id p64so27929359pfb.1
 for <kexec@lists.infradead.org>; Sun, 21 Aug 2016 21:22:18 -0700 (PDT)
Date: Mon, 22 Aug 2016 13:28:34 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v24 9/9] Documentation: dt: chosen properties for arm64
 kdump
Message-ID: <20160822042832.GJ20080@linaro.org>
References: <20160809015248.28414-2-takahiro.akashi@linaro.org>
 <20160809015747.28591-1-takahiro.akashi@linaro.org>
 <20160819132641.GA12709@rob-hp-laptop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160819132641.GA12709@rob-hp-laptop>
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
To: Rob Herring <robh@kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, geoff@infradead.org, catalin.marinas@arm.com, dyoung@redhat.com, will.deacon@arm.com, james.morse@arm.com, bauerman@linux.vnet.ibm.com, frowand.list@gmail.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Rob,
[Cc: Mark]

On Fri, Aug 19, 2016 at 08:26:41AM -0500, Rob Herring wrote:
> On Tue, Aug 09, 2016 at 10:57:47AM +0900, AKASHI Takahiro wrote:
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
> >  Documentation/devicetree/bindings/chosen.txt | 50 ++++++++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
> > index 6ae9d82..236188a 100644
> > --- a/Documentation/devicetree/bindings/chosen.txt
> > +++ b/Documentation/devicetree/bindings/chosen.txt
> > @@ -52,3 +52,53 @@ This property is set (currently only on PowerPC, and only needed on
> >  book3e) by some versions of kexec-tools to tell the new kernel that it
> >  is being booted by kexec, as the booting environment may differ (e.g.
> >  a different secondary CPU release mechanism)
> > +
> > +linux,crashkernel-base
> > +linux,crashkernel-size
> > +----------------------
> > +These properties (currently used on PowerPC and arm64) indicates
> > +the base address and the size, respectively, of the reserved memory
> > +range for crash dump kernel.
> > +e.g.
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
> > +This property (currently used only on arm64) holds the memory range,
> > +the base address and the size, which can be used as system ram on
> > +the *current* kernel. Note that, if this property is present, any memory
> > +regions under "memory" nodes in DT blob or ones marked as "conventional
> > +memory" in EFI memory map should be ignored.
> > +e.g.
> > +
> > +/ {
> > +	chosen {
> > +		linux,usable-memory-range = <0x9 0xf0000000 0x0 0x10000000>;
> > +	};
> > +};
> 
> I've read the discussion on this. I think you should use the existing 
> linux,usable-memory property in the memory nodes. If UEFI systems don't 
> have memory nodes, then you can find an UEFI way to describe this. DT is 
> not the dumping ground for what doesn't fit in UEFI. How do x86 systems 
> work?

Kdump for x86 passes the range of usable memory to crash dump kernel
either via:
(a) "memmap=nn@ss" command line parameter, or
(b) faked BIOS e820 map (a sort of memory map table)

(a) was rejected by Mark [1], and (b) is x86-specific.

I believe that my approach is better because it works in the same way
either on UEFI systems or DT-based systems.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/400122.html

Thanks,
-Takahiro AKASHI

> Rob

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
