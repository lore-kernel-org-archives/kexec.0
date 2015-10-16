Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zmu8F-0000hc-W9
 for kexec@lists.infradead.org; Fri, 16 Oct 2015 01:48:32 +0000
Date: Fri, 16 Oct 2015 10:48:03 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 2/3] ppc64: Avoid rfid if no need to clear MSR_LE
Message-ID: <20151016014803.GF20667@verge.net.au>
References: <1444172150-29493-1-git-send-email-scottwood@freescale.com>
 <1444172150-29493-2-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1444172150-29493-2-git-send-email-scottwood@freescale.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Scott Wood <scottwood@freescale.com>
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>

On Tue, Oct 06, 2015 at 05:55:49PM -0500, Scott Wood wrote:
> Commit a304e2d82a8c3 ("ppc64: purgatory: Reset primary cpu endian to
> big-endian) changed bctr to rfid.  rfid is book3s-only and will cause a
> fatal exception on book3e.
> 
> Purgatory is an isolated environment which makes importing information
> about the subarch awkward, so instead rely on the fact that MSR_LE
> should never be set on book3e, and the rfid is only needed if MSR_LE is
> set (and thus needs to be cleared).  In theory that MSR bit is reserved
> on book3e, rather than zero, but in practice I have not seen it set.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> Cc: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
> ---
> v2: new patch

Could I get a review of this from at lest one ppc person?

>  purgatory/arch/ppc64/v2wrap.S | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/purgatory/arch/ppc64/v2wrap.S b/purgatory/arch/ppc64/v2wrap.S
> index 179ade9..3534080 100644
> --- a/purgatory/arch/ppc64/v2wrap.S
> +++ b/purgatory/arch/ppc64/v2wrap.S
> @@ -116,9 +116,17 @@ master:
>  	stw	7,0x5c(4)	# and patch it into the kernel
>  	mr      3,16            # restore dt address
>  
> +	mfmsr	5
> +	andi.	10,5,1		# test MSR_LE
> +	bne	little_endian
> +
> +	li	5,0		# r5 will be 0 for kernel
> +	mtctr	4		# prepare branch to
> +	bctr			# start kernel
> +	
> +little_endian:			# book3s-only
>  	mtsrr0	4		# prepare branch to
>  
> -	mfmsr	5
>  	clrrdi	5,5,1		# clear MSR_LE
>  	mtsrr1	5
>  
> -- 
> 2.1.4
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
