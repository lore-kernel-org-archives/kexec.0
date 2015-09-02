Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZWwSb-0006ez-JV
 for kexec@lists.infradead.org; Wed, 02 Sep 2015 01:03:34 +0000
Date: Wed, 2 Sep 2015 10:02:51 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] purgatory/arch/ppc64: Reset primary cpu endian to
 big-endian
Message-ID: <20150902010251.GC30886@verge.net.au>
References: <1440125476-9420-1-git-send-email-sam.mj@au1.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1440125476-9420-1-git-send-email-sam.mj@au1.ibm.com>
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
To: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
Cc: mpe@ellerman.id.au, kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org

[CC linuxppc-dev]

On Fri, Aug 21, 2015 at 12:51:16PM +1000, Samuel Mendoza-Jonas wrote:
> Older big-endian ppc64 kernels don't include the FIXUP_ENDIAN check,
> meaning if we kexec from a little-endian kernel the target kernel will
> fail to boot.
> Returning to big-endian before we enter the target kernel ensures that
> the target kernel can boot whether or not it includes FIXUP_ENDIAN.
> 
> This mirrors commit 150b14e7 in kexec-lite.
> 
> Signed-off-by: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>

I would value a review from one of the PPC folks.

> ---
>  purgatory/arch/ppc64/v2wrap.S | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/purgatory/arch/ppc64/v2wrap.S b/purgatory/arch/ppc64/v2wrap.S
> index dc5034f..179ade9 100644
> --- a/purgatory/arch/ppc64/v2wrap.S
> +++ b/purgatory/arch/ppc64/v2wrap.S
> @@ -114,10 +114,16 @@ master:
>  	LOADADDR(6,run_at_load) # the load flag
>  	lwz	7,0(6)		# possibly patched by kexec-elf-ppc64
>  	stw	7,0x5c(4)	# and patch it into the kernel
> -	li	5,0		# r5 will be 0 for kernel
> -	mtctr	4		# prepare branch too
>  	mr      3,16            # restore dt address
>  
> +	mtsrr0	4		# prepare branch to
> +
> +	mfmsr	5
> +	clrrdi	5,5,1		# clear MSR_LE
> +	mtsrr1	5
> +
> +	li	5,0		# r5 will be 0 for kernel
> +
>  				# skip cache flush, do we care?
>  
> -	bctr			# start kernel
> +	rfid			# update MSR and start kernel
> -- 
> 2.5.0
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
