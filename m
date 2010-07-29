Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OePEx-0004WH-GD
	for kexec@lists.infradead.org; Thu, 29 Jul 2010 09:17:24 +0000
Date: Thu, 29 Jul 2010 18:17:19 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v3 4/7] Update Elf-ppc to support crash kernel and misc
	fixes
Message-ID: <20100729091719.GD10021@verge.net.au>
References: <1279687384-9770-1-git-send-email-msm@freescale.com>
	<1279687384-9770-5-git-send-email-msm@freescale.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1279687384-9770-5-git-send-email-msm@freescale.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Matthew McClintock <msm@freescale.com>
Cc: muvarov@gmail.com, sebastian@breakpoint.cc, kexec@lists.infradead.org

On Tue, Jul 20, 2010 at 11:43:01PM -0500, Matthew McClintock wrote:
> Use current command line if none given, specifically useful for
> when arguments are added causing the use of the current cmdline
> to not occur
> 
> We also try to load the dtb above the kernel, this is useful for
> relocatable kernels where they device tree needs to reside just
> above the kernel base address
> 
> Set the kernel entry address in the relocatable purgatory code
> so we jump to the correct start address if not the default. Useful
> for relocatable kernels
> 
> Signed-off-by: Matthew McClintock <msm@freescale.com>
> ---
>  kexec/arch/ppc/kexec-elf-ppc.c |   26 ++++++++++++++------------
>  1 files changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/kexec/arch/ppc/kexec-elf-ppc.c b/kexec/arch/ppc/kexec-elf-ppc.c
> index ab2d343..87e6507 100644
> --- a/kexec/arch/ppc/kexec-elf-ppc.c
> +++ b/kexec/arch/ppc/kexec-elf-ppc.c
> @@ -182,6 +182,7 @@ int elf_ppc_load(int argc, char **argv,	const char *buf, off_t len,
>  	int target_is_gamecube = 0;
>  	unsigned int addr;
>  	unsigned long dtb_addr;
> +	unsigned long kernel_addr;
>  #endif
>  #define FIXUP_ENTRYS	(20)
>  	char *fixup_nodes[FIXUP_ENTRYS + 1];

I moved kernel_addr to outside the #ifdef GAME_CUBE


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
