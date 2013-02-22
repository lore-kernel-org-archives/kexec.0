Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1U90ea-0000fG-9t
 for kexec@lists.infradead.org; Fri, 22 Feb 2013 21:59:40 +0000
Date: Fri, 22 Feb 2013 13:59:38 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] kexec: fix memory leak in function kimage_normal_alloc
Message-Id: <20130222135938.c6f28ff5.akpm@linux-foundation.org>
In-Reply-To: <5126F5BD.1030602@cn.fujitsu.com>
References: <5126F5BD.1030602@cn.fujitsu.com>
Mime-Version: 1.0
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
Cc: Sasha Levin <sasha.levin@oracle.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, 22 Feb 2013 12:36:13 +0800
Zhang Yanfei <zhangyanfei@cn.fujitsu.com> wrote:

> If kimage_normal_alloc() fails to alloc pages for image->swap_page, it
> should call kimage_free_page_list() to free allocated pages in
> image->control_pages list before it frees image.
>
> ...
>
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

kimage_alloc_normal_control_pages() won't add any pages to the image if
one of its allocation attemtps failed.  So afaict the first `goto
out_free' could be just `goto out'.

The second `goto out_free' does appear to be needed: it frees the pages
allocated by the first call to kimage_alloc_control_pages().  I think. 
The kimage_alloc_control_pages() handling of image->type is a bit
twisty.

Please double-check the logic?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
