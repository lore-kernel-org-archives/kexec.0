Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf0-x22d.google.com ([2607:f8b0:400e:c00::22d])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bmbvk-0002fE-Fo
 for kexec@lists.infradead.org; Wed, 21 Sep 2016 07:26:58 +0000
Received: by mail-pf0-x22d.google.com with SMTP id p64so16352312pfb.1
 for <kexec@lists.infradead.org>; Wed, 21 Sep 2016 00:26:35 -0700 (PDT)
Date: Wed, 21 Sep 2016 16:33:43 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v26 0/7] arm64: add kdump support
Message-ID: <20160921073342.GH30248@linaro.org>
References: <20160907042908.6232-1-takahiro.akashi@linaro.org>
 <57DC1812.6040906@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <57DC1812.6040906@arm.com>
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
Cc: mark.rutland@arm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>, geoff@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

James,

On Fri, Sep 16, 2016 at 05:04:34PM +0100, James Morse wrote:
> (Cc: Ard),
> 
> Mark, Ard, how does/will reserved-memory work on an APCI only system?
> 
> 
> On 07/09/16 05:29, AKASHI Takahiro wrote:
> >     v26-specific note: After a comment from Rob[0], an idea of adding
> >     "linux,usable-memory-range" was dropped. Instead, an existing
> >     "reserved-memory" node will be used to limit usable memory ranges
> >     on crash dump kernel.
> >     This works not only on UEFI/ACPI systems but also on DT-only systems,
> >     but if he really insists on using DT-specific "usable-memory" property,
> >     I will post additional patches for kexec-tools. Those would be
> >     redundant, though.
> >     Even in that case, the kernel will not have to be changed.
> 
> Some narrative on how the old memory ranges get reserved, as there is no longer
> any code in the series doing this, (which is pretty neat!):

Thank you for detailed explanation :)
I was wondering whether I should have added such kind of description,
but it was nothing but, I believed, a "normal" DT behavior.

> kexec-tools parses the list of memory ranges in /proc/iomem, and adds a node to
> the /reserved-memory for System RAM ranges that don't cover the crash kernel.
> Decompiling the crash-kernel DT from Seattle, it looks roughly like this:
> 
>         reserved-memory {
>                 ranges;
>                 #size-cells = <0x2>;
>                 #address-cells = <0x2>;
> 
>                 crash_dump@83ffe50000 {
>                         no-map;
>                         reg = <0x83 0xffe50000 0x0 0x1b0000>;
>                 };
> 
> 		[ ... ]
>         };
> 
> 
> 'no-map' means its doing the same thing to memblock as
> 'linux,usable-memory-range' did in earlier versions,
> early_init_dt_reserve_memory_arch() takes no-map to mean memblock_remove().
> We trigger the removing via early_init_fdt_scan_reserved_mem() in
> arch/arm64/mm/init.c. This happens later than before, but its before the
> crashkernel and cma ranges get reserved.
> 
> One difference I can see is that before we avoided memblock_remove()ing ranges
> that were also in memblock.nomap. This was to avoid the ACPI tables getting
> mapped as device memory by mistake, this is fixed by [1]. Now these ranges are
> published in /proc/iomem as 'reserved' and won't get covered by a
> reserved-memory node, and so we don't need to check memblock.nomap when
> memblock_remove()ing.
> 
> 
> The only odd thing I can see is for a (mythical?) pure-ACPI system. The EFI stub
> will create a DT with a chosen node containing pointers to the memory map and
> the efi command line. Now such as system may also grow a /reserved-memory node
> after kdump. I don't think this is a problem, but it may not match how an
> acpi-only system reserves memory. (how does that work?)

I didn't get what you mean by "may grow a /reserved-memory after kdump."

> 
> > [1] "arm64: mark reserved memblock regions explicitly in iomem"
> >     http://lists.infradead.org/pipermail/linux-arm-kernel/2016-August/450433.html
> 
> This is queued in Will's arm64/for-next/core,
> 
> > [2] "efi: arm64: treat regions with WT/WC set but WB cleared as memory"
> >     http://lists.infradead.org/pipermail/linux-arm-kernel/2016-August/451491.html
> 
> This is queued in tip, but I can't see why kdump depends on it. It only has an
> effect if the uefi memory map has !WB regions that linux needs to use.

Just because you said that the patch had fixed your problem on Seattle.
If I misunderstood, it will be fine to remove this reference from
my commit message.

Thanks,
-Takahiro AKASHI

> 
> Thanks,
> 
> James
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
