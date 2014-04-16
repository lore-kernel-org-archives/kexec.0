Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([2a01:4f8:120:8448::d00d])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WaUYC-0004lV-8K
 for kexec@lists.infradead.org; Wed, 16 Apr 2014 18:27:13 +0000
Date: Wed, 16 Apr 2014 20:26:45 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] kexec: Fix ->unuseable_pages typo
Message-ID: <20140416182645.GA5588@pd.tnic>
References: <1392819695-24116-1-git-send-email-bp@alien8.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1392819695-24116-1-git-send-email-bp@alien8.de>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Eric Biederman <ebiederm@xmission.com>

Hey Andrew,

can you pls pick this one up - it seems it fell through the cracks.

Thanks.

On Wed, Feb 19, 2014 at 03:21:35PM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Let's use the more common "unusable".
> 
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: kexec@lists.infradead.org
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  include/linux/kexec.h | 2 +-
>  kernel/kexec.c        | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 6d4066cdb5b5..969237e338d1 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -100,7 +100,7 @@ struct kimage {
>  
>  	struct list_head control_pages;
>  	struct list_head dest_pages;
> -	struct list_head unuseable_pages;
> +	struct list_head unusable_pages;
>  
>  	/* Address of next control page to allocate for crash kernels. */
>  	unsigned long control_page;
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 60bafbed06ab..a2d0c5f80bf2 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -152,7 +152,7 @@ static int do_kimage_alloc(struct kimage **rimage, unsigned long entry,
>  	INIT_LIST_HEAD(&image->dest_pages);
>  
>  	/* Initialize the list of unusable pages */
> -	INIT_LIST_HEAD(&image->unuseable_pages);
> +	INIT_LIST_HEAD(&image->unusable_pages);
>  
>  	/* Read in the segments */
>  	image->nr_segments = nr_segments;
> @@ -607,7 +607,7 @@ static void kimage_free_extra_pages(struct kimage *image)
>  	kimage_free_page_list(&image->dest_pages);
>  
>  	/* Walk through and free any unusable pages I have cached */
> -	kimage_free_page_list(&image->unuseable_pages);
> +	kimage_free_page_list(&image->unusable_pages);
>  
>  }
>  static void kimage_terminate(struct kimage *image)
> @@ -731,7 +731,7 @@ static struct page *kimage_alloc_page(struct kimage *image,
>  		/* If the page cannot be used file it away */
>  		if (page_to_pfn(page) >
>  				(KEXEC_SOURCE_MEMORY_LIMIT >> PAGE_SHIFT)) {
> -			list_add(&page->lru, &image->unuseable_pages);
> +			list_add(&page->lru, &image->unusable_pages);
>  			continue;
>  		}
>  		addr = page_to_pfn(page) << PAGE_SHIFT;
> -- 
> 1.8.5.rc3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
