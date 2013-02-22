Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1U9BuZ-00025R-PB
 for kexec@lists.infradead.org; Sat, 23 Feb 2013 10:00:56 +0000
Date: Fri, 22 Feb 2013 15:12:15 -0800
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: avoid freeing NULL pointer in function
 kimage_crash_alloc
Message-ID: <20130222231214.GH4737@verge.net.au>
References: <5126F92A.2030007@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5126F92A.2030007@cn.fujitsu.com>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Feb 22, 2013 at 12:50:50PM +0800, Zhang Yanfei wrote:
> Though there is no error if we free a NULL pointer, I think we could
> avoid this behaviour. Change the code a little in kimage_crash_alloc()
> could avoid this kind of unnecessary free.
> 
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>


Reviewed-by: Simon Horman <horms@verge.net.au>

> ---
>  kernel/kexec.c |   15 +++++++--------
>  1 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 5e4bd78..4e96fa7 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -310,7 +310,7 @@ static int kimage_crash_alloc(struct kimage **rimage, unsigned long entry,
>  		mend = mstart + image->segment[i].memsz - 1;
>  		/* Ensure we are within the crash kernel limits */
>  		if ((mstart < crashk_res.start) || (mend > crashk_res.end))
> -			goto out;
> +			goto out_free;
>  	}
>  
>  	/*
> @@ -323,16 +323,15 @@ static int kimage_crash_alloc(struct kimage **rimage, unsigned long entry,
>  					   get_order(KEXEC_CONTROL_PAGE_SIZE));
>  	if (!image->control_code_page) {
>  		printk(KERN_ERR "Could not allocate control_code_buffer\n");
> -		goto out;
> +		goto out_free;
>  	}
>  
> -	result = 0;
> -out:
> -	if (result == 0)
> -		*rimage = image;
> -	else
> -		kfree(image);
> +	*rimage = image;
> +	return 0;
>  
> +out_free:
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
