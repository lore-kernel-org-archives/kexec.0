Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KQM66-0007zu-72
	for kexec@lists.infradead.org; Tue, 05 Aug 2008 12:57:06 +0000
Date: Tue, 5 Aug 2008 08:56:34 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: kdump, ia64: always reserve elfcore header memory in crash kernel
Message-ID: <20080805125634.GA15193@redhat.com>
References: <20080805094825.GA9712@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080805094825.GA9712@verge.net.au>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-ia64@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Tony Luck <tony.luck@intel.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Tue, Aug 05, 2008 at 07:48:27PM +1000, Simon Horman wrote:
> elfcore header memory needs to be reserved in a crash kernel.
> This means that the relevant code should be protected
> by CONFIG_CRASH_DUMP rather than CONFIG_PROC_VMCORE.
> 
> Signed-off-by: Simon Horman <horms@verge.net.au>
> 
> --- 
> Andrew, this patch fixes bug in the (unlikely) case where
> an ia64 crashdump kernel does not have CONFIG_PROC_FS set.
> I think it is worth including in 2.6.27. But breakage cases are
> likely to be minimal to non-existent, so I am comfortable
> with post 2.6.27 too.
> 
> This patch should be appended to the series,
> "is_kdump_kernel() cleanup and related patches".
> 
> http://lists.infradead.org/pipermail/kexec/2008-July/002270.html
> 
> Index: linux-2.6/arch/ia64/kernel/efi.c
> ===================================================================
> --- linux-2.6.orig/arch/ia64/kernel/efi.c	2008-08-05 18:31:13.000000000 +1000
> +++ linux-2.6/arch/ia64/kernel/efi.c	2008-08-05 18:31:21.000000000 +1000
> @@ -1334,7 +1334,7 @@ kdump_find_rsvd_region (unsigned long si
>  }
>  #endif
>  
> -#ifdef CONFIG_PROC_VMCORE
> +#ifdef CONFIG_CRASH_DUMP
>  /* locate the size find a the descriptor at a certain address */
>  unsigned long __init
>  vmcore_find_descriptor_size (unsigned long address)
> Index: linux-2.6/arch/ia64/kernel/setup.c
> ===================================================================
> --- linux-2.6.orig/arch/ia64/kernel/setup.c	2008-08-05 18:31:20.000000000 +1000
> +++ linux-2.6/arch/ia64/kernel/setup.c	2008-08-05 18:31:21.000000000 +1000
> @@ -352,7 +352,7 @@ reserve_memory (void)
>  	}
>  #endif
>  
> -#ifdef CONFIG_PROC_VMCORE
> +#ifdef CONFIG_CRASH_KERNEL
>  	if (reserve_elfcorehdr(&rsvd_region[n].start,
>  			       &rsvd_region[n].end) == 0)
>  		n++;

Hi Simon,

Thanks for the patch. One minor nit. I think compilation will fail
in the case of CONFIG_PROC_VMCORE=n. Because reserve_elfcorehdr will
try to use vmcore_unusabe() which is not available now?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
