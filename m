Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XduKC-0007zd-2a
 for kexec@lists.infradead.org; Tue, 14 Oct 2014 05:07:08 +0000
Date: Tue, 14 Oct 2014 07:06:40 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: distribute kexec/arch/m68k/bootinfo.h
Message-ID: <20141014050640.GA7738@verge.net.au>
References: <1381859460-13645-1-git-send-email-geert@linux-m68k.org>
 <1381859460-13645-4-git-send-email-geert@linux-m68k.org>
 <87tx39w042.fsf_-_@igel.home>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87tx39w042.fsf_-_@igel.home>
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
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: kexec@lists.infradead.org, linux-m68k@lists.linux-m68k.org, Geert Uytterhoeven <geert@linux-m68k.org>

Thanks, applied. Sorry for missing this earlier.

On Sun, Oct 12, 2014 at 09:37:17PM +0200, Andreas Schwab wrote:
> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
> ---
>  kexec/arch/m68k/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kexec/arch/m68k/Makefile b/kexec/arch/m68k/Makefile
> index 7b13564..eeaacbd 100644
> --- a/kexec/arch/m68k/Makefile
> +++ b/kexec/arch/m68k/Makefile
> @@ -10,5 +10,6 @@ m68k_ADD_SEGMENT =
>  m68k_VIRT_TO_PHYS =
>  
>  dist += kexec/arch/m68k/Makefile $(m68k_KEXEC_SRCS)			\
> +	kexec/arch/m68k/bootinfo.h					\
>  	kexec/arch/m68k/kexec-m68k.h					\
>  	kexec/arch/m68k/include/arch/options.h
> -- 
> 2.1.2
> 
> -- 
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
> "And now for something completely different."
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
