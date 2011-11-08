Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RNg0f-0004pD-7C
 for kexec@lists.infradead.org; Tue, 08 Nov 2011 07:22:18 +0000
Date: Tue, 8 Nov 2011 16:22:08 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] remove unnecessary check code for hole_align
Message-ID: <20111108072205.GA26841@verge.net.au>
References: <20111108052623.GA22922@darkstar.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111108052623.GA22922@darkstar.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org

On Tue, Nov 08, 2011 at 01:26:23PM +0800, Dave Young wrote:
> hole_align == 0 check is not neccesary, because it will be set to
> pagesize if it's zero. Just remove it here.
> 

Hi Dave,

it looks like the if condition can never be true due
to hole_base being set to a non-zero value on the
previous line.

Which is a long way of saying, I like your patch.

> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  kexec/kexec.c |    4 ----
>  1 file changed, 4 deletions(-)
> 
> Index: kexec-tools/kexec/kexec.c
> ===================================================================
> --- kexec-tools.orig/kexec/kexec.c
> +++ kexec-tools/kexec/kexec.c
> @@ -203,10 +203,6 @@ unsigned long locate_hole(struct kexec_i
>  	/* Set an intial invalid value for the hole base */
>  	hole_base = ULONG_MAX;
>  
> -	/* Ensure I have a sane alignment value */
> -	if (hole_align == 0) {
> -		hole_align = 1;
> -	}
>  	/* Align everything to at least a page size boundary */
>  	if (hole_align < (unsigned long)getpagesize()) {
>  		hole_align = getpagesize();
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
