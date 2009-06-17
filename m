Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1MGtaW-0004J7-0M
	for kexec@lists.infradead.org; Wed, 17 Jun 2009 11:46:02 +0000
Date: Wed, 17 Jun 2009 21:45:52 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Do not inline putprops function
Message-ID: <20090617114551.GA5672@verge.net.au>
References: <20090617113456.GC31595@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20090617113456.GC31595@in.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
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
To: "M. Mohan Kumar" <mohan@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org, miltonm@bga.com

On Wed, Jun 17, 2009 at 05:04:56PM +0530, M. Mohan Kumar wrote:
> Do not inline putprops function
> 
> With the recent kexec-tools git tree, both kexec and kdump kernels hang (i.e
> kexec -l and kexec -p respectively). This happened after the patch "ppc64:
> cleanups" commit b43a84a31a4be6ed025c1bdef3bb1c3c12e01b16. I tried
> reverting each hunk and then found out that retaining following lines in
> fs2dt.c makes kexec/kdump work.
> 
> -static unsigned *dt_len; /* changed len of modified cmdline
> -                           in flat device-tree */
> 
> [....]
> 
> -               dt_len = dt;
> 
> I don't have any clue why removing a unused variable would cause the kexec
> kernel to hang. After further investigation, I observed that if the putprops
> function is not inlined, kexec/kdump kernel would work even after removing
> the above lines.
> 
> This patch directs gcc to not inline the putprops function. Now we could
> invoke kexec and kdump kernels.

I'm happy to apply this if you provide a sign-off,
but do you know why not inlining makes a difference here?

> ---
>  kexec/arch/ppc64/fs2dt.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/kexec/arch/ppc64/fs2dt.c b/kexec/arch/ppc64/fs2dt.c
> index 1f551fd..1e01f74 100644
> --- a/kexec/arch/ppc64/fs2dt.c
> +++ b/kexec/arch/ppc64/fs2dt.c
> @@ -259,7 +259,7 @@ static void add_usable_mem_property(int fd, int len)
>  }
>  
>  /* put all properties (files) in the property structure */
> -static void putprops(char *fn, struct dirent **nlist, int numlist)
> +__attribute__ ((noinline)) static void putprops(char *fn, struct dirent **nlist, int numlist)
>  {
>  	struct dirent *dp;
>  	int i = 0, fd, len;
> -- 
> 1.6.0.6

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
