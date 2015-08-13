Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZPgo7-00007a-J3
 for kexec@lists.infradead.org; Thu, 13 Aug 2015 00:55:48 +0000
Date: Thu, 13 Aug 2015 09:55:25 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [REPOST PATCH] kexec: Remove the unnecessary conditional
 judgement to simplify the code logic
Message-ID: <20150813005525.GB7852@verge.net.au>
References: <1438058802-6462-1-git-send-email-mnfhuang@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1438058802-6462-1-git-send-email-mnfhuang@gmail.com>
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
To: Minfei Huang <mnfhuang@gmail.com>, akpm@linux-foundation.org
Cc: kexec@lists.infradead.org, ebiederm@xmission.com, vgoyal@redhat.com, linux-kernel@vger.kernel.org

On Tue, Jul 28, 2015 at 12:46:42PM +0800, Minfei Huang wrote:
> Transforming PFN(Page Frame Number) to struct page is never failure, so
> we can simplify the code logic to do the image->control_page assignment
> directly in the loop, and remove the unnecessary conditional judgement.
> 
> Signed-off-by: Minfei Huang <mnfhuang@gmail.com>
> Acked-by: Dave Young <dyoung@redhat.com>
> Acked-by: Vivek Goyal <vgoyal@redhat.com>

Andrew, could you consider picking this up.
It seems to have been sufficiently reviewed, acked, etc...

> ---
>  kernel/kexec.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 6f1ed75..cf82474 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -807,11 +807,10 @@ static struct page *kimage_alloc_crash_control_pages(struct kimage *image,
>  		/* If I don't overlap any segments I have found my hole! */
>  		if (i == image->nr_segments) {
>  			pages = pfn_to_page(hole_start >> PAGE_SHIFT);
> +			image->control_page = hole_end;
>  			break;
>  		}
>  	}
> -	if (pages)
> -		image->control_page = hole_end;
>  
>  	return pages;
>  }
> -- 
> 2.4.0
> 
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
