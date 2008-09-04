Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1Kb2Hb-0007uA-3n
	for kexec@lists.infradead.org; Thu, 04 Sep 2008 00:01:08 +0000
Date: Thu, 4 Sep 2008 10:01:02 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] IA64: kexec allocates too few memory for kdump kernel
	itself
Message-ID: <20080904000100.GD8974@verge.net.au>
References: <48BEFB47.20004@sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <48BEFB47.20004@sgi.com>
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
To: Jay Lan <jlan@sgi.com>
Cc: kexec@lists.infradead.org

On Wed, Sep 03, 2008 at 02:01:59PM -0700, Jay Lan wrote:
> Sometimes the kexec would allocate not enough memory for kdump kernel
> itself on IA64 and caused kdump kernel to panic at boot.
> 
> When it happens, the /proc/iomem would show a kernel RAM segment like
> this:
> 3014000000-3015294fff : System RAM
>   3014000000-3014823ccf : Kernel code
>   3014823cd0-3014dee8ef : Kernel data
>   3014dee8f0-301529448f : Kernel bss
> 3015295000-307bffdfff : System RAM
>   3018000000-3037ffffff : Crash kernel
> 
> But kexec would allocate memory 3018000000-3019290000 for the kernel,
> which is 0x5000 smaller than the regular kernel. In my cases, the
> physical_node_map and kern_memmap of the kdump kernel overlaped and
> caused data corruption.
> 
> This patch fixes the problem. The patch was generated against
> kexec-tools 2.0.0 and tested in 2.6.27-rc4.

Hi Jay,

I am unclear about why this underallocation occurs.

> 
> Signed-off-by: Jay Lan <jlan@sgi.com>
> 

> ---
>  kexec/arch/ia64/crashdump-ia64.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> Index: kexec-tools/kexec/arch/ia64/crashdump-ia64.c
> ===================================================================
> --- kexec-tools.orig/kexec/arch/ia64/crashdump-ia64.c	2008-09-03 11:24:14.289758063 -0700
> +++ kexec-tools/kexec/arch/ia64/crashdump-ia64.c	2008-09-03 11:29:34.095833316 -0700
> @@ -90,15 +90,15 @@ static void add_loaded_segments_info(str
>  			phdr = &ehdr->e_phdr[i];
>  	                if (phdr->p_type != PT_LOAD)
>  	                        break;
> -			if (loaded_segments[loaded_segments_num].end !=
> -				phdr->p_paddr & ~(ELF_PAGE_SIZE-1))
> -				break;
> +			if (loaded_segments[loaded_segments_num].end <
> +			    (phdr->p_paddr & ~(ELF_PAGE_SIZE-1)) )
> +				loaded_segments[loaded_segments_num].end
> +				  = phdr->p_paddr & ~(ELF_PAGE_SIZE-1);
>  			loaded_segments[loaded_segments_num].end +=
>  				(phdr->p_memsz + ELF_PAGE_SIZE - 1) &
>  				~(ELF_PAGE_SIZE - 1);
>  			i++;
>  		}
> -
>  		loaded_segments_num++;
>  	}
>  }

> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
