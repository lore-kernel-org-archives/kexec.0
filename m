Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KIO9B-0005E8-4J
	for kexec@lists.infradead.org; Mon, 14 Jul 2008 13:31:24 +0000
Date: Mon, 14 Jul 2008 09:30:19 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] x86: Move crashkernel reservation before
	dma32_reserve_bootmem()
Message-ID: <20080714133019.GB16673@redhat.com>
References: <1215974984-25184-1-git-send-email-bwalle@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1215974984-25184-1-git-send-email-bwalle@suse.de>
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
To: Bernhard Walle <bwalle@suse.de>
Cc: Bernhard Walle <bernhard.walle@gmx.de>, akpm@linux-foundation.org, x86@kernel.org, kexec@lists.infradead.org

On Sun, Jul 13, 2008 at 08:49:44PM +0200, Bernhard Walle wrote:
> From: Bernhard Walle <bernhard.walle@gmx.de>
> 
> On a x86-64 machine (nothing special I could encounter) I had the problem that
> crashkernel reservation with the usual "64M@16M" failed. While debugging that,
> I encountered that dma32_reserve_bootmem() reserves a memory region which is in
> that area.
> 
> Because dma32_reserve_bootmem() does not rely on a specific offset but
> crashkernel does, it makes sense to move the crashkernel reservation up a bit.
> I tested that patch and it works without problems. I don't see any negative
> effects of that move, but maybe I oversaw something ...
> 
> While the long-term solution is to make the crashkernel reservation dynamic
> (which is already done in -tip), this bug should be fixed also short-term for
> 2.6.26 (or 2.6.26-stable if it's too short), and that's why I made that patch.
> 
> 
> Signed-off-by: Bernhard Walle <bwalle@suse.de>
> Signed-off-by: Bernhard Walle <bernhard.walle@gmx.de>
> ---
>  arch/x86/kernel/setup_64.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/x86/kernel/setup_64.c b/arch/x86/kernel/setup_64.c
> index 6dff128..158cefe 100644
> --- a/arch/x86/kernel/setup_64.c
> +++ b/arch/x86/kernel/setup_64.c
> @@ -444,6 +444,12 @@ void __init setup_arch(char **cmdline_p)
>  	contig_initmem_init(0, end_pfn);
>  #endif
>  
> +	/*
> +	 * dma32_reserve_bootmem() allocates bootmem which may conflict
> +	 * with the crashkernel command line, so do that before
> +	 */
> +	reserve_crashkernel();
> +
>  	dma32_reserve_bootmem();
>  
>  #ifdef CONFIG_ACPI_SLEEP
> @@ -484,7 +490,6 @@ void __init setup_arch(char **cmdline_p)
>  		}
>  	}
>  #endif
> -	reserve_crashkernel();
>  
>  	reserve_ibft_region();

Looks good to me. 

Acked-by: Vivek Goyal <vgoyal@redhat.com>

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
