Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VWLRb-0008VK-Lx
 for kexec@lists.infradead.org; Wed, 16 Oct 2013 07:23:00 +0000
Date: Wed, 16 Oct 2013 16:22:36 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 0/3] kexec support for Linux/m68k (tools part)
Message-ID: <20131016072236.GB29696@verge.net.au>
References: <1381859460-13645-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1381859460-13645-1-git-send-email-geert@linux-m68k.org>
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
Cc: linux-m68k@lists.linux-m68k.org, kexec@lists.infradead.org

On Tue, Oct 15, 2013 at 07:50:57PM +0200, Geert Uytterhoeven wrote:
> kexec support for Linux/m68k (tools part)
> 
> This is a set of patches to add kexec support for m68k to kexec-tools.
> 
>   - Kexec only, no kdump support yet (do you have enough RAM to keep a
>     crashdump kernel in memory at all times? ;-)
> 
> Patches:
>   - [PATCH 1/3] kexec: Let slurp_file_len() return the number of bytes
>       - v2: no changes
>   - [PATCH 2/3] kexec: Extract slurp_fd()
>       - v2: new patch
>   - [PATCH 3/3] kexec: Add m68k support
>       - v2:
> 	  - Fix handling of virtual and physical addresses, for machines where
> 	    memory doesn't start at zero,
> 	  - Print a warning if the kernel size exceeds 4 MiB, as current kernels
> 	    cannot handle that,
> 	  - Check struct bootversion at the start of the kernel, and print a
> 	    warning if it cannot be found or doesn't match,
> 	  - Replace literal 4096 by PAGE_SIZE,
> 	  - Handle removal of page zero at the ELF program segment level, as
> 	    m68kboot does,
> 	  - Remove -PAGE_SIZE for the ramdisk location now the bug in
>             locate_hole() is fixed,
> 	  - Use endian-correct types for bootinfo,
> 	  - Remove unused -? option handling, cfr. commit
> 	    bf9d0f055c791a26b2237b5a12b48ae1b7e0d550 ("kexec: Remove unused -?
> 	    option handling"),
> 	  - Use <asm/bootinfo.h> instead of our own definitions.
> 
> Notes:
>   - Based on git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
> 
>   - Tagged bootinfo is read from /proc/bootinfo by default, but this can be
>     overridden using --bootinfo. No bootinfo editor is provided.
>     The kexec command will replace/delete command line and ramdisk tags in the
>     bootinfo.

Thanks,

I've taken a quick look over this and it seems reasonable to me.
However, I wonder if I should wait for review of the kernel-side
to be completed before applying the kexec-tools patches.

Let me know what you think.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
