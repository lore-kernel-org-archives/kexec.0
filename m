Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VMo1u-0003m8-Re
 for kexec@lists.infradead.org; Thu, 19 Sep 2013 23:53:04 +0000
Date: Thu, 19 Sep 2013 14:07:50 -0700
From: Simon Horman <horms@verge.net.au>
Subject: Re: Preliminary kexec support for Linux/m68k
Message-ID: <20130919210750.GH2918@verge.net.au>
References: <1379412095-7213-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1379412095-7213-1-git-send-email-geert@linux-m68k.org>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Tue, Sep 17, 2013 at 12:01:30PM +0200, Geert Uytterhoeven wrote:
> This is a preliminary set of patches to add kexec support for m68k.

Great, this has been a long time coming!

>   - Kexec only, no kdump support yet (do you have enough RAM to keep a
>     crashdump kernel in memory at all times? ;-)
> 
>   - Tested on ARAnyM only. No support for other CPU/MMUs than 68040.
> 
>   - Although the code contains some phys/virt conversions, it will probably
>     fail miserably on platforms where kernel virtual addresses are different
>     from physical address.
> 
>   - To have automatic "kexec -e" on reboot, copy /etc/rc6.d/S85kexec from
>     another system, and fix it up for kexec living in /usr/local/sbin instead
>     of /sbin.
> 
>   - Sample invocation:
> 
> 	kexec -d -l vmlinux --reuse-cmdline
> 
> 
> KERNEL:
> 
> Patches:
>   - [PATCH 1/3] m68k: Add preliminary kexec support
>   - [PATCH 2/3] m68k: Add support to export bootinfo in procfs
>   - [PATCH 3/3] [RFC] m68k: Add System RAM to /proc/iomem
> 
> Notes:
>   - The bootinfo is now saved and exported to /proc/bootinfo, so kexec-tools
>     can read it and pass it (possibly after modification) to the new kernel.
>     This is similar to /proc/atags on ARM.
> 
>   - We should create arch/m68k/include/uapi/asm/bootinfo.h (and probably a few
>     more, e.g. machine-specific model IDs), as this is needed by both m68kboot
>     and kexec-tools.
> 
>   - I based [PATCH 3/3] on the PowerPC version, but it's no longer needed as we
>     now get this information from the bootinfo.
>     Does anyone think this is nice to have anyway?
> 
> 
> KEXEC-TOOLS:

Pasting two series in one was a bit confusing for me at first.
Perhaps you could consider posting two separate series in future.

> Patches:
>   - [PATCH 1/2] kexec: Let slurp_file_len() return the number of bytes
>   - [PATCH 2/2] kexec: Add preliminary m68k support
> 
> Notes:
>   - Based on git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git

A good choice.

>   - Tagged bootinfo is read from /proc/bootinfo by default, but this can be
>     overridden using --bootinfo. No bootinfo editor is provided.
>     The kexec command will replace/delete command line and ramdisk tags in the
>     bootinfo.

This sounds good to me.

>   - The ramdisk is loaded at the top of memory minus 4096, unlike with
>     m68boot (ataboot/amiboot), as locate_hole() seems to have a bug that it
>     cannot reserve a block at the real top of memory.

Is this a bug that could be fixed?

>   - The first unused page of the kernel image (at address zero) is
>     automatically removed, just like m68kboot does.
>     If I don't do this, relocate_new_kernel() fails with a "cannot handle
>     kernel paging request at address NULL" exception, although the MMU is
>     disabled at that point.
>     As m68kboot does this too, I guess this is OK?

It sounds sane to me. But I would appreciate some feedback from
someone familiar with the m68k kernel.

>   - Do we want to check the struct bootversion at the start of the kernel,
>     like m68kboot does?
>     Kexec may be used to load ELF files that are not Linux kernel images,
>     and thus don't have a Linux-specific struct bootversion.

If the check can sanely be skipped for non Linux kernel images then
this sounds like a reasonable idea to me. Otherwise I would lean towards
omitting it. Either way, I don't feel strongly about this.

> 
>   - Do we want to check the size of the kernel image + bootinfo, and warn the
>     user if it's larger than 4 MiB?
>     This is a limitation of the current Linux/m68k kernel only.

I think that sounds like a good idea but I don't feel strongly about it.

> 
> All comments are welcome!
> Have fun! ;-)
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
