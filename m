Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.87 #1 (Red Hat Linux))
 id 1cW1KP-0006jo-9h
 for kexec@lists.infradead.org; Tue, 24 Jan 2017 13:40:11 +0000
Received: from penelope.kanocho.kobe.vergenet.net
 (52D9BC73.cm-11-1c.dynamic.ziggo.nl [82.217.188.115])
 by kirsty.vergenet.net (Postfix) with ESMTPSA id 2E2C625BE79
 for <kexec@lists.infradead.org>; Wed, 25 Jan 2017 00:39:42 +1100 (AEDT)
Date: Tue, 24 Jan 2017 14:39:38 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] alpha: add missing __NR_kexec_load definition
Message-ID: <20170124133938.GF28325@verge.net.au>
References: <1482222558-30213-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1482222558-30213-1-git-send-email-horms@verge.net.au>
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
To: kexec@lists.infradead.org

On Tue, Dec 20, 2016 at 09:29:18AM +0100, Simon Horman wrote:
> Signed-off-by: Simon Horman <horms@verge.net.au>
> ---
>  kexec/kexec-syscall.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kexec/kexec-syscall.h b/kexec/kexec-syscall.h
> index c0d0beadf932..3b5c528d8aac 100644
> --- a/kexec/kexec-syscall.h
> +++ b/kexec/kexec-syscall.h
> @@ -48,6 +48,9 @@
>  #ifdef __m68k__
>  #define __NR_kexec_load                313
>  #endif
> +#ifdef __alpha__
> +#define __NR_kexec_load                448
> +#endif
>  #ifndef __NR_kexec_load
>  #error Unknown processor architecture.  Needs a kexec_load syscall number.
>  #endif

I have applied this but for the record alpha still seems far away from
compiling in my environment.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
