Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K6cPb-00012s-27
	for kexec@lists.infradead.org; Thu, 12 Jun 2008 02:19:39 +0000
Date: Thu, 12 Jun 2008 12:19:37 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Fix wrong remove_parameter() calls
Message-ID: <20080612021935.GG22358@verge.net.au>
References: <1212449407-22930-1-git-send-email-bwalle@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1212449407-22930-1-git-send-email-bwalle@suse.de>
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
Cc: kexec@lists.infradead.org

On Tue, Jun 03, 2008 at 01:30:07AM +0200, Bernhard Walle wrote:
> When --reuse-cmdline is specified, kexec automatically removes some command
> line parameter that are *known* to break the kexec'd target. That patch
> corrects that behaviour:
> 
>  1. BOOT_IMAGE should be removed always when --reuse-cmdline is specified since
>     it's likely that the kernel is not the same as the running kernel. As only
>     lilo-like bootloaders (i.e. not GRUB) adds that parameter, there's no need
>     to add a BOOT_IMAGE here.
> 
>  2. crashkernel should be only removed when 'kexec -p' is called. For the
>     normal kexec, the crashkernel parameter can be passed as in the
>     running kernel.
> 
> The mistake has been introduced by commit 3c5bb06948881b3e31c783c19edef74275794280
> by myself.

Hi Bernhard,

this change seems fine, however the patch requires your previous patch,
"Implement support for mem command line parameter", which is still the
point of some debate.

Could you rediff this change against the current code in git?

> 
> 
> Signed-off-by: Bernhard Walle <bwalle@suse.de>
> ---
>  kexec/kexec.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index 0a8ed32..fee895d 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -871,10 +871,10 @@ char *get_command_line(int filtered)
>  		*(line + strlen(line) - 1) = 0;
>  
>  		if (filtered) {
> -			remove_parameter(line, "crashkernel");
> +			remove_parameter(line, "BOOT_IMAGE");
>  			if (kexec_flags & KEXEC_ON_CRASH) {
> -				remove_parameter(line, "BOOT_IMAGE");
>  				remove_parameter(line, "mem");
> +				remove_parameter(line, "crashkernel");
>  			}
>  		}
>  	} else
> -- 
> 1.5.4.5
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
