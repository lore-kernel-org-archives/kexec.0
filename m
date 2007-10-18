Return-path: <kexec-bounces@lists.infradead.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IictT-0000kR-Hc
	for kexec@lists.infradead.org; Thu, 18 Oct 2007 22:27:07 +0100
Date: Thu, 18 Oct 2007 14:26:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 1/3] Add BSS to resource tree
Message-Id: <20071018142642.5b3f6ba4.akpm@linux-foundation.org>
In-Reply-To: <20071018111535.883533731@strauss.suse.de>
References: <20071018111535.356215664@strauss.suse.de>
	<20071018111535.883533731@strauss.suse.de>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: vgoyal@in.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ak@suse.de

On Thu, 18 Oct 2007 13:15:36 +0200
Bernhard Walle <bwalle@suse.de> wrote:

> This patch adds the BSS to the resource tree just as kernel text and kernel
> data are in the resource tree. The main reason behind this is to avoid
> crashkernel reservation in that area.
> 
> While it's not strictly necessary to have the BSS in the resource tree
> (the actual collision detection is done in the reserve_bootmem() function
> before), the usage of the BSS resource should be presented to the user
> in /proc/iomem just as Kernel data and Kernel code.
> 
> Note: The patch currently is only implemented for x86 and ia64 (because
> efi_initialize_iomem_resources() has the same signature on i386 and
> ia64).
> 
> 
> ...
>
> -extern char _text[], _end[], _etext[];
> +
> +static struct resource bss_resource = {
> +	.name	= "Kernel bss",
> +	.flags	= IORESOURCE_BUSY | IORESOURCE_MEM
> +};
> +extern char _text[], _end[], _etext[], _edata[], _bss[];

These should be in a header file.

> --- a/arch/x86/kernel/e820_64.c
> +++ b/arch/x86/kernel/e820_64.c
> @@ -47,7 +47,7 @@ unsigned long end_pfn_map; 
>   */
>  static unsigned long __initdata end_user_pfn = MAXMEM>>PAGE_SHIFT;
>  
> -extern struct resource code_resource, data_resource;
> +extern struct resource code_resource, data_resource, bss_resource;

As should these.  afaik they're the same on all architectures and even if
they have different names on some weird arch, an unused declaration won't
hurt.

> --- a/arch/x86/kernel/setup_32.c
> +++ b/arch/x86/kernel/setup_32.c
> @@ -73,6 +74,7 @@ int disable_pse __devinitdata = 0;
>   */
>  extern struct resource code_resource;
>  extern struct resource data_resource;
> +extern struct resource bss_resource;

See, we keep on adding the same thing over and over again.


These problems are not introduced by your changes, of course.  But we really
should degunk this stuff sometime.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
