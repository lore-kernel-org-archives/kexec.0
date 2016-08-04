Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x22c.google.com ([2607:f8b0:400e:c03::22c])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bVApx-0000of-Ra
 for kexec@lists.infradead.org; Thu, 04 Aug 2016 05:04:55 +0000
Received: by mail-pa0-x22c.google.com with SMTP id iw10so79971096pac.2
 for <kexec@lists.infradead.org>; Wed, 03 Aug 2016 22:04:32 -0700 (PDT)
Date: Thu, 4 Aug 2016 14:10:11 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v23 9/9] Documentation: dt: chosen properties for arm64
 kdump
Message-ID: <20160804051010.GK7995@linaro.org>
References: <20160726075659.2290-1-takahiro.akashi@linaro.org>
 <20160726080206.2441-1-takahiro.akashi@linaro.org>
 <20160727150933.GA25732@rob-hp-laptop>
 <20160728075511.GA7995@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160728075511.GA7995@linaro.org>
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
To: Rob Herring <robh@kernel.org>, catalin.marinas@arm.com, will.deacon@arm.com, frowand.list@gmail.com, james.morse@arm.com, geoff@infradead.org, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, mark.rutland@arm.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Rob,

On Thu, Jul 28, 2016 at 04:55:11PM +0900, AKASHI Takahiro wrote:
> Rob,
> 
> On Wed, Jul 27, 2016 at 10:09:33AM -0500, Rob Herring wrote:
> > On Tue, Jul 26, 2016 at 05:02:06PM +0900, AKASHI Takahiro wrote:
> > > From: James Morse <james.morse@arm.com>
> > > 
> > > Add documentation for
> > > 	linux,crashkernel-base and crashkernel-size,
> > > 	linux,usable-memory-range, and
> > > 	linux,elfcorehdr
> > > used by arm64 kexec/kdump to decribe the kdump reserved area, and
> > > the elfcorehdr's location within it.
> > > 
> > > Signed-off-by: James Morse <james.morse@arm.com>
> > > [takahiro.akashi@linaro.org:
> > >     renamed "usable-memory" to "usable-memory-range",
> > >     added "linux,crashkernel-base" and "-size" ]
> > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > ---
> > >  Documentation/devicetree/bindings/chosen.txt | 45 ++++++++++++++++++++++++++++
> > >  1 file changed, 45 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
> > > index 6ae9d82..d7a3a86 100644
> > > --- a/Documentation/devicetree/bindings/chosen.txt
> > > +++ b/Documentation/devicetree/bindings/chosen.txt
> > > @@ -52,3 +52,48 @@ This property is set (currently only on PowerPC, and only needed on
> > >  book3e) by some versions of kexec-tools to tell the new kernel that it
> > >  is being booted by kexec, as the booting environment may differ (e.g.
> > >  a different secondary CPU release mechanism)
> > > +
> > > +linux,crashkernel-base
> > > +linux,crashkernel-size
> > > +----------------------
> > > +These properties are set (on PowerPC and arm64) during kdump to tell
> > > +use-space tools, like kexec-tools, the base address of the crash-dump
> > 
> > s/use/user/
> >
> > Ideally, userspace should not care whether this comes from DT, kernel 
> > command-line or somewhere else and should be exposed in some source 
> > independent way. However, that's not really the problem for the binding.
> 
> Yeah, I will remove "user-space"-related description as Mark also
> commented before.
> 
> > > +kernel's reserved area of memory and the size. e.g.
> > > +
> > > +/ {
> > > +	chosen {
> > > +		linux,crashkernel-base = <0x9 0xf0000000>;
> > > +		linux,crashkernel-size = <0x0 0x10000000>;
> > > +	};
> > > +};
> > > +
> > > +linux,usable-memory-range
> > > +-------------------------
> > > +
> > > +This property is set (currently only on arm64) during kdump to tell
> > > +the crash-dump kernel the base address of its reserved area of memory,
> > > +and the size. e.g.
> > > +
> > > +/ {
> > > +	chosen {
> > > +		linux,usable-memory-range = <0x9 0xf0000000 0x0 0x10000000>;
> > 
> > This is the same range as linux,crashkernel-*, but used by the 2nd 
> > kernel? Why not just update the memory node or use command line mem= 
> > parameter?
> 
> Please see:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-July/443225.html
> 
> There was also a discussion that simply appending "mem=", or more generally
> any parameter, to a command line might break some assumption of order of
> parameters in the future.
> So adding a DT property would be a better way.

Do you have any other comments about those properties?

-Takahiro AKASHI

> Thanks,
> -Takahiro AKASHI
> 
> > Why has PPC not need this and ARM does? 
> > 
> > > +	};
> > > +};
> > > +
> > > +Please note that, if this property is present, any memory regions under
> > > +"memory" nodes will be ignored.
> > > +
> > > +linux,elfcorehdr
> > > +----------------
> > > +
> > > +This property is set (currently only on arm64) during kdump to tell
> > > +the crash-dump kernel the address and size of the elfcorehdr that describes
> > > +the old kernel's memory as an elf file. This memory must reside within
> > > +the area described by 'linux,usable-memory-range'. e.g.
> > > +
> > > +/ {
> > > +	chosen {
> > > +		linux,usable-memory = <0x9 0xf0000000 0x0 0x10000000>;
> > > +		linux,elfcorehdr = <0x9 0xfffff000 0x0 0x800>;
> > > +	};
> > > +};
> > > -- 
> > > 2.9.0
> > > 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
