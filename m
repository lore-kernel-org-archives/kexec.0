Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KyHPy-0004S4-HG
	for kexec@lists.infradead.org; Fri, 07 Nov 2008 02:49:51 +0000
Date: Fri, 7 Nov 2008 13:49:48 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Reserve elfcorehdr memory in CONFIG_CRASH_DUMP
Message-ID: <20081107024946.GA20889@verge.net.au>
References: <4913A8C0.8090108@sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4913A8C0.8090108@sgi.com>
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
To: Jay Lan <jlan@sgi.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>

On Thu, Nov 06, 2008 at 06:32:32PM -0800, Jay Lan wrote:
> IA64 kdump kernel failed to initialize /proc/vmcore in 2.6.28-rc2.
> A bug was introduced in this patch commit:
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=d9a9855d0b06ca6d6cc92596fedcc03f8512e062
> 
> The problem was that the call to reserve_elfcorehdr() should be placed
> in CONFIG_CRASH_DUMP rather than in CONFIG_CRASH_KERNEL, which does
> not exist.
> 
> The patch fixes the problem.
> 
> Signed-off-by: Jay Lan <jlan@sgi.com>

Acked-by: Simon Horman <horms@verge.net.au>

> ---
>  arch/ia64/kernel/setup.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux/arch/ia64/kernel/setup.c
> ===================================================================
> --- linux.orig/arch/ia64/kernel/setup.c	2008-11-06 18:01:18.000000000 -0800
> +++ linux/arch/ia64/kernel/setup.c	2008-11-06 18:05:42.047332827 -0800
> @@ -359,7 +359,7 @@ reserve_memory (void)
>  	}
>  #endif
>  
> -#ifdef CONFIG_CRASH_KERNEL
> +#ifdef CONFIG_CRASH_DUMP
>  	if (reserve_elfcorehdr(&rsvd_region[n].start,
>  			       &rsvd_region[n].end) == 0)
>  		n++;


-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
