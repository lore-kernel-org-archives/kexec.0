Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x22f.google.com ([2607:f8b0:400e:c03::22f])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bmc4Z-0007vv-GX
 for kexec@lists.infradead.org; Wed, 21 Sep 2016 07:36:05 +0000
Received: by mail-pa0-x22f.google.com with SMTP id id6so15712783pad.3
 for <kexec@lists.infradead.org>; Wed, 21 Sep 2016 00:35:42 -0700 (PDT)
Date: Wed, 21 Sep 2016 16:42:50 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v26 0/7] arm64: add kdump support
Message-ID: <20160921074249.GI30248@linaro.org>
References: <20160907042908.6232-1-takahiro.akashi@linaro.org>
 <57DC1812.6040906@arm.com>
 <CAKv+Gu_UvFnPtFHggaO6Z_ePuArdchEK1qYWPkkwpcgLus3Epw@mail.gmail.com>
 <57E00CDC.70403@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <57E00CDC.70403@arm.com>
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
To: James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Sep 19, 2016 at 05:05:48PM +0100, James Morse wrote:
> On 16/09/16 21:17, Ard Biesheuvel wrote:
> > On 16 September 2016 at 17:04, James Morse <james.morse@arm.com> wrote:
> >> Mark, Ard, how does/will reserved-memory work on an APCI only system?
> > 
> > It works by accident, at the moment. We used to ignore both
> > /memreserve/s and the /reserved-memory node, but due to some unrelated
> > refactoring, we ended up honouring the reserved-memory node when
> > booting via UEFI
> 
> Okay, so kdump probably shouldn't rely on this behaviour...
> 
> For an acpi-only system, we could get reserve_crashkernel() to copy the uefi
> memory map into the reserved region, changing the region types for existing
> kernel memory to EfiReservedMemoryType (for example) and fixing up the reserved
> region boundaries.
> 
> This second memory map could then be added alongside the real one in the
> DT/chosen, and used in preference the second time we go through uefi_init() in
> the crash kernel.

Do we need add this map as the second one?
Why not replace "linux,uefi-mmap-start" in a new blob?

> kexec-tools would still need to keep the '/reserved-memory' node for non-uefi
> systems.

Yeah, but if we go in our own way on UEFI/ACPI systems, we may want to
go in a DT-specific way, like PPC does, on DT systems.
(That is, "linux,usable-memory" in memory nodes.)

Thanks,
-Takahiro AKASHI

> Doing this doesn't depend on userspace, and means the uefi memory map is still
> the one and only true source of memory layout information. If fixing it like
> this is valid I don't think it should block kdump.
> 
> ... I will think about this some more before trying to put it together.
> 
> 
> 
> Thanks,
> 
> James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
