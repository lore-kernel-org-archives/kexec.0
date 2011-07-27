Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from ozlabs.org ([2402:b800:7003:1:1::1])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QlvhJ-00077A-51
	for kexec@lists.infradead.org; Wed, 27 Jul 2011 04:26:18 +0000
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc: pseries: Fix kexec on machines with more than
	4TB of RAM
In-reply-to: <20110727141503.3faa93f5@kryten>
References: <20110727141503.3faa93f5@kryten>
Date: Wed, 27 Jul 2011 14:26:10 +1000
Message-ID: <2294.1311740770@neuling.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Anton Blanchard <anton@samba.org>
Cc: benh@kernel.crashing.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org, miltonm@bga.com, kexec@lists.infradead.org

> On a box with 8TB of RAM the MMU hashtable is 64GB in size. That
> means we have 4G PTEs. pSeries_lpar_hptab_clear was using a signed
> int to store the index which will overflow at 2G.

Wow, I hear... "Anton Blanchard's machine has more memory in it's MMU
than you have in total".

Acked-by: Michael Neuling <mikey@neuling.org>

> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> Cc: <stable@kernel.org>
> ---
> 
> Index: linux-powerpc/arch/powerpc/platforms/pseries/lpar.c
> ===================================================================
> --- linux-powerpc.orig/arch/powerpc/platforms/pseries/lpar.c	2011-07-27 13:5
0:18.408091576 +1000
> +++ linux-powerpc/arch/powerpc/platforms/pseries/lpar.c	2011-07-27 13:5
1:19.359196131 +1000
> @@ -203,7 +203,7 @@ static void pSeries_lpar_hptab_clear(voi
>  		unsigned long ptel;
>  	} ptes[4];
>  	long lpar_rc;
> -	int i, j;
> +	unsigned long i, j;
>  
>  	/* Read in batches of 4,
>  	 * invalidate only valid entries not in the VRMA
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
