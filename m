Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KgB9s-0004uR-4M
	for kexec@lists.infradead.org; Thu, 18 Sep 2008 04:30:24 +0000
Date: Thu, 18 Sep 2008 14:30:19 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: segmentation fault in kimage_add_entry
Message-ID: <20080918043018.GD32516@verge.net.au>
References: <48D0067F.3020007@esentire.com> <m1d4j3g29q.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m1d4j3g29q.fsf@frodo.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Jonathan Steel <jon.steel@esentire.com>, linux-kernel@vger.kernel.org

On Tue, Sep 16, 2008 at 03:21:53PM -0700, Eric W. Biederman wrote:
> From: Jonathan Steel <jon.steel@esentire.com>
> 
> A segmentation fault can occur in kimage_add_entry in kexec.c when
> loading a kernel image into memory. The fault occurs because a page is
> requested by calling kimage_alloc_page with gfp_mask GFP_KERNEL and the
> function may actually return a page with gfp_mask GFP_HIGHUSER. The high
> mem page is returned because it was swapped with the kernel page due to
> the kernel page being a page that will shortly be copied to.
> 
> This patch ensures that kimage_alloc_page returns a page that was
> created with the correct gfp flags.
> 
> 
> I have verified the change and fixed the whitespace damage of the
> original patch.  Jonathan did a great job of tracking this down
> after he hit the problem. -- Eric
> 
> Signed-off-by: Jonathan Steel <jon.steel@esentire.com>
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

For what it is worth: Acked-by: Simon Horman <horms@verge.net.au>

> ---
>  kernel/kexec.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
> 
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 59f3f0d..aef2653 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -753,8 +753,14 @@ static struct page *kimage_alloc_page(struct kimage *image,
>  			*old = addr | (*old & ~PAGE_MASK);
>  
>  			/* The old page I have found cannot be a
> -			 * destination page, so return it.
> +			 * destination page, so return it if it's
> +			 * gfp_flags honor the ones passed in.
>  			 */
> +			if (!(gfp_mask & __GFP_HIGHMEM) &&
> +			    PageHighMem(old_page)) {
> +				kimage_free_pages(old_page);
> +				continue;
> +			}
>  			addr = old_addr;
>  			page = old_page;
>  			break;
> -- 
> 1.5.3.rc6.17.g1911
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
