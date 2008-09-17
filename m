Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KflKZ-0003MY-Q2
	for kexec@lists.infradead.org; Wed, 17 Sep 2008 00:55:47 +0000
Date: Wed, 17 Sep 2008 10:55:42 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec, kernel 2.6.26.5, segmentation fault in
	kimage_add_entry
Message-ID: <20080917005542.GD15750@verge.net.au>
References: <48D0067F.3020007@esentire.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <48D0067F.3020007@esentire.com>
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
To: Jonathan Steel <jon.steel@esentire.com>
Cc: kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org

On Tue, Sep 16, 2008 at 03:18:23PM -0400, Jonathan Steel wrote:
> A segmentation fault can occur in kimage_add_entry in kexec.c when 
> loading a kernel image into memory. The fault occurs because a page is 
> requested by calling kimage_alloc_page with gfp_mask GFP_KERNEL and the 
> function may actually return a page with gfp_mask GFP_HIGHUSER. The high 
> mem page is returned because it was swapped with the kernel page due to 
> the kernel page being a page that will shortly be copied to.
> 
> This patch ensures that kimage_alloc_page returns a page that was 
> created with the correct gfp flags.

I wonder if this problem might also affect other users of
kimage_alloc_pages(), and if so, perhaps it should guard
against this?

> 
> --- linux-2.6.26.5.orig/kernel/kexec.c    2008-09-16 13:17:56.000000000 
> -0400
> +++ linux-2.6.26.5/kernel/kexec.c    2008-09-16 13:26:35.000000000 -0400
> @@ -743,8 +743,15 @@ static struct page *kimage_alloc_page(st
>              *old = addr | (*old & ~PAGE_MASK);
>  
>              /* The old page I have found cannot be a
> -             * destination page, so return it.
> -             */
> +             * destination page, so return it if its
> +             * gfp_flags honor the ones passed in.
> +            */
> +            if (!(gfp_mask & __GFP_HIGHMEM) &&
> +                    PageHighMem(old_page)) {
> +                kimage_free_pages(old_page);
> +                continue;
> +            }
> +
>              addr = old_addr;
>              page = old_page;
>              break;
> 
> Signed-off-by: Jonathan Steel <jon.steel@esentire.com>
> 
> Jonathan Steel

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
