Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1U9Bub-00026o-Op
 for kexec@lists.infradead.org; Sat, 23 Feb 2013 10:01:03 +0000
Date: Fri, 22 Feb 2013 14:54:01 -0800
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: fix memory leak in function kimage_normal_alloc
Message-ID: <20130222225400.GD4737@verge.net.au>
References: <5126F5BD.1030602@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5126F5BD.1030602@cn.fujitsu.com>
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
To: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
Cc: Sasha Levin <sasha.levin@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Feb 22, 2013 at 12:36:13PM +0800, Zhang Yanfei wrote:
> If kimage_normal_alloc() fails to alloc pages for image->swap_page, it
> should call kimage_free_page_list() to free allocated pages in
> image->control_pages list before it frees image.
> 
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Sasha Levin <sasha.levin@oracle.com>
> Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>


Reviewed-by: Simon Horman <horms@verge.net.au>

> ---
>  kernel/kexec.c |   18 ++++++++++--------
>  1 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 5e4bd78..a57face 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -223,6 +223,8 @@ out:
>  
>  }
>  
> +static void kimage_free_page_list(struct list_head *list);
> +
>  static int kimage_normal_alloc(struct kimage **rimage, unsigned long entry,
>  				unsigned long nr_segments,
>  				struct kexec_segment __user *segments)
> @@ -248,22 +250,22 @@ static int kimage_normal_alloc(struct kimage **rimage, unsigned long entry,
>  					   get_order(KEXEC_CONTROL_PAGE_SIZE));
>  	if (!image->control_code_page) {
>  		printk(KERN_ERR "Could not allocate control_code_buffer\n");
> -		goto out;
> +		goto out_free;
>  	}
>  
>  	image->swap_page = kimage_alloc_control_pages(image, 0);
>  	if (!image->swap_page) {
>  		printk(KERN_ERR "Could not allocate swap buffer\n");
> -		goto out;
> +		goto out_free;
>  	}
>  
> -	result = 0;
> - out:
> -	if (result == 0)
> -		*rimage = image;
> -	else
> -		kfree(image);
> +	*rimage = image;
> +	return 0;
>  
> +out_free:
> +	kimage_free_page_list(&image->control_pages);
> +	kfree(image);
> +out:
>  	return result;
>  }
>  
> -- 
> 1.7.1
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
