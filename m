Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from qw-out-1920.google.com ([74.125.92.146])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KJcIj-0005z8-9O
	for kexec@lists.infradead.org; Thu, 17 Jul 2008 22:50:17 +0000
Received: by qw-out-1920.google.com with SMTP id 5so92648qwf.24
	for <kexec@lists.infradead.org>; Thu, 17 Jul 2008 15:50:15 -0700 (PDT)
Message-ID: <86802c440807171550t360a2a76mddb9ae45c7e9f4fb@mail.gmail.com>
Date: Thu, 17 Jul 2008 15:50:14 -0700
From: "Yinghai Lu" <yhlu.kernel@gmail.com>
Subject: Re: [PATCH] x86: Move crashkernel reservation before
	dma32_reserve_bootmem()
In-Reply-To: <1216332945-17197-1-git-send-email-bwalle@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
References: <1216332945-17197-1-git-send-email-bwalle@suse.de>
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
Cc: akpm@linux-foundation.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com

On Thu, Jul 17, 2008 at 3:15 PM, Bernhard Walle <bwalle@suse.de> wrote:
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
> While we strictly don't need that patch in 2.6.27 because we have the
> automatic, dynamic offset detection, it makes sense to also include it here
> because:
>
>  - it's easier to get it in -stable then,
>  - many people are still used to the 'crashkernel=...@16M' syntax,
>  - not everybody may be using a reloatable kernel.
>
> Signed-off-by: Bernhard Walle <bwalle@suse.de>
> ---
>  arch/x86/kernel/setup.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 531b55b..16101c0 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -792,6 +792,12 @@ void __init setup_arch(char **cmdline_p)
>
>        initmem_init(0, max_pfn);
>
> +       /*
> +        * dma32_reserve_bootmem() allocates bootmem which may conflict
> +        * with the crashkernel command line, so do that before
> +        */
> +       reserve_crashkernel();
> +
>  #ifdef CONFIG_X86_64
>        dma32_reserve_bootmem();
>  #endif
> @@ -808,7 +814,6 @@ void __init setup_arch(char **cmdline_p)
>         */
>        find_smp_config();
>  #endif
> -       reserve_crashkernel();
>
>        reserve_ibft_region();
>

Joe Jin already had another one to move dma32_reserve_bootmem later

YH

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
