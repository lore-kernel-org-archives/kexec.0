Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W3aja-0008Bc-Su
 for kexec@lists.infradead.org; Thu, 16 Jan 2014 00:22:59 +0000
Date: Thu, 16 Jan 2014 09:22:34 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Fix value of mbi->mem_lower for multiboot-x86
Message-ID: <20140116002234.GC12550@verge.net.au>
References: <84k3e2lyde.wl%peter.chubb@nicta.com.au>
 <20140115034833.GA30883@verge.net.au>
 <84ppntsz5x.wl%peter.chubb@nicta.com.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <84ppntsz5x.wl%peter.chubb@nicta.com.au>
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
To: Peter Chubb <peter.chubb@nicta.com.au>
Cc: kexec@lists.infradead.org

On Thu, Jan 16, 2014 at 08:39:06AM +1100, Peter Chubb wrote:
> 
> In the multiboot header, there is a field, `mem_lower' that is meant to
> contain the size of memory starting at zero and ending below 640k.
> If your kernel is compiled with CONFIG_X86_RESERVE_LOW non zero
> (the usual case), then a hole is inserted into kernel's physical
> memory map at zero, so the test to find the size of this region in
> kexec/arch/i386/kexec-multiboot-x86.c never succeeds, so the value is
> always zero.
> 
> On a PC99 architecture, there is always memory at physycal address zero;
> assume that a region that starts below 64k actually starts at zero,
> and use it for the mem_lower variable.
> 
> Signed-off-by: Peter Chubb <peter.chubb@nicta.com.au>

Thanks Peter, I have applied this.

> 
> ---
>  kexec/arch/i386/kexec-multiboot-x86.c |   14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> Index: kexec-tools-2.0.4/kexec/arch/i386/kexec-multiboot-x86.c
> ===================================================================
> --- kexec-tools-2.0.4.orig/kexec/arch/i386/kexec-multiboot-x86.c	2013-03-14 18:45:16.000000000 +1000
> +++ kexec-tools-2.0.4/kexec/arch/i386/kexec-multiboot-x86.c	2014-01-15 10:21:02.138172304 +1000
> @@ -261,10 +261,18 @@ int multiboot_x86_load(int argc, char **
>  		mmap[i].length_high    = length >> 32;
>  		if (range[i].type == RANGE_RAM) {
>  			mmap[i].Type = 1; /* RAM */
> -			/* Is this the "low" memory? */
> -			if ((range[i].start == 0)
> -			    && (range[i].end > mem_lower))
> +			/*
> +                         * Is this the "low" memory?  Can't just test
> +                         * against zero, because Linux protects (and
> +                         * hides) the first few pages of physical
> +                         * memory.
> +                         */
> +
> +			if ((range[i].start <= 64*1024)
> +			    && (range[i].end > mem_lower)) {
> +                                range[i].start = 0;
>  				mem_lower = range[i].end;
> +                        }
>  			/* Is this the "high" memory? */
>  			if ((range[i].start <= 0x100000)
>  			    && (range[i].end > mem_upper + 0x100000))
> 
> --
> Dr Peter Chubb				        peter.chubb AT nicta.com.au
> http://www.ssrg.nicta.com.au          Software Systems Research Group/NICTA
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
