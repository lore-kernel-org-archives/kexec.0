Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KIE8X-0006Ar-DT
	for kexec@lists.infradead.org; Mon, 14 Jul 2008 02:50:02 +0000
Message-Id: <487ABD56.5040603@mxs.nes.nec.co.jp>
Date: Mon, 14 Jul 2008 11:43:34 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: [PATCH] x86: Move crashkernel reservation
	before	dma32_reserve_bootmem()
References: <1215974984-25184-1-git-send-email-bwalle@suse.de>
In-Reply-To: <1215974984-25184-1-git-send-email-bwalle@suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2026730141=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: Bernhard Walle <bernhard.walle@gmx.de>, akpm@linux-foundation.org, x86@kernel.org, kexec@lists.infradead.org, vgoyal@redhat.com

--===============2026730141==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi,

Bernhard Walle wrote:
> From: Bernhard Walle <bernhard.walle@gmx.de>
> 
> On a x86-64 machine (nothing special I could encounter) I had the problem that
> crashkernel reservation with the usual "64M@16M" failed. While debugging that,
> I encountered that dma32_reserve_bootmem() reserves a memory region which is in
> that area.

I tested your patch on x86_64 linux-2.6.26, and it works fine.
Good catching, Bernhard :-)


Before applying Bernhard's patch, kernel output the following message
and could not reserve the memory area for kdump. So kdump did not work.

 Jul 14 11:15:48 localhost kernel: Bootmem setup node 0 0000000000000000-0000000170000000
 Jul 14 11:15:48 localhost kdump: No crashkernel parameter specified for running kernel
 Jul 14 11:15:48 localhost kernel:   NODE_DATA [000000000000f000 - 0000000000014fff]
 Jul 14 11:15:48 localhost kdump: failed to start up
 Jul 14 11:15:48 localhost kernel:   bootmap [0000000000015000 -  0000000000042fff] pages 2e
 Jul 14 11:15:48 localhost kernel:   early res: 0 [0-fff] BIOS data page
 Jul 14 11:15:48 localhost kernel:   early res: 1 [6000-7fff] TRAMPOLINE
 Jul 14 11:15:48 localhost kernel:   early res: 2 [200000-9b1c97] TEXT DATA BSS
 Jul 14 11:15:48 localhost kernel:   early res: 3 [37ce4000-37fef146] RAMDISK
 Jul 14 11:15:48 localhost kernel:   early res: 4 [9b400-fffff] BIOS reserved
 Jul 14 11:15:48 localhost kernel:   early res: 5 [8000-efff] PGTABLE
 Jul 14 11:15:48 localhost kernel: crashkernel reservation failed - memory is in use

After applying Bernhard's patch, kernel outputs the following message,
and kdump works.

 Jul 14 11:27:39 localhost kernel: Bootmem setup node 0 0000000000000000-0000000170000000
 Jul 14 11:27:39 localhost kernel:   NODE_DATA [000000000000f000 - 0000000000014fff]
 Jul 14 11:27:39 localhost kernel:   bootmap [0000000000015000 -  0000000000042fff] pages 2e
 Jul 14 11:27:39 localhost kernel:   early res: 0 [0-fff] BIOS data page
 Jul 14 11:27:39 localhost kernel:   early res: 1 [6000-7fff] TRAMPOLINE
 Jul 14 11:27:39 localhost kernel:   early res: 2 [200000-9b1c97] TEXT DATA BSS
 Jul 14 11:27:39 localhost kernel:   early res: 3 [37ce4000-37fef14a] RAMDISK
 Jul 14 11:27:39 localhost kernel:   early res: 4 [9b400-fffff] BIOS reserved
 Jul 14 11:27:39 localhost kernel:   early res: 5 [8000-efff] PGTABLE
 Jul 14 11:27:39 localhost kernel: Reserving 128MB of memory at 16MB for crashkernel (System RAM: 5888MB)


> Because dma32_reserve_bootmem() does not rely on a specific offset but
> crashkernel does, it makes sense to move the crashkernel reservation up a bit.
> I tested that patch and it works without problems. I don't see any negative
> effects of that move, but maybe I oversaw something ...
> 
> While the long-term solution is to make the crashkernel reservation dynamic
> (which is already done in -tip), this bug should be fixed also short-term for
> 2.6.26 (or 2.6.26-stable if it's too short), and that's why I made that patch.

I hope so.


> Signed-off-by: Bernhard Walle <bwalle@suse.de>
> Signed-off-by: Bernhard Walle <bernhard.walle@gmx.de>

Tested-by: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>


Thanks
Ken'ichi Ohmichi


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
>  




--===============2026730141==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============2026730141==--
