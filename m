Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1U9m3u-0005Gq-Tq
 for kexec@lists.infradead.org; Mon, 25 Feb 2013 00:37:00 +0000
Date: Mon, 25 Feb 2013 09:36:51 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] kexec: Use min_t to simplify logic
Message-ID: <20130225003651.GD17964@verge.net.au>
References: <512A25A1.4040002@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <512A25A1.4040002@gmail.com>
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
To: Zhang Yanfei <zhangyanfei.yes@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sun, Feb 24, 2013 at 10:37:21PM +0800, Zhang Yanfei wrote:
> From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> 
> This is just a tweak: using min_t to simplify logic of variable
> assignments.
> 
> v2:
> - Rewrite patch description as Simon suggested.
> - Fix an inappropriate if test introduced by v1. Thanks Simon.

Hi Zhang,

thanks for the update.

Signed-off-by: Simon Horman <horms@verge.net.au>

> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Simon Horman <horms@verge.net.au>
> Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> ---
>  kernel/kexec.c |   22 ++++++----------------
>  1 files changed, 6 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 2436ffc..effd655 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -822,13 +822,8 @@ static int kimage_load_normal_segment(struct kimage *image,
>  		/* Start with a clear page */
>  		clear_page(ptr);
>  		ptr += maddr & ~PAGE_MASK;
> -		mchunk = PAGE_SIZE - (maddr & ~PAGE_MASK);
> -		if (mchunk > mbytes)
> -			mchunk = mbytes;
> -
> -		uchunk = mchunk;
> -		if (uchunk > ubytes)
> -			uchunk = ubytes;
> +		mchunk = min_t(size_t, mbytes, PAGE_SIZE - (maddr & ~PAGE_MASK));
> +		uchunk = min_t(size_t, ubytes, mchunk);
>  
>  		result = copy_from_user(ptr, buf, uchunk);
>  		kunmap(page);
> @@ -874,13 +869,9 @@ static int kimage_load_crash_segment(struct kimage *image,
>  		}
>  		ptr = kmap(page);
>  		ptr += maddr & ~PAGE_MASK;
> -		mchunk = PAGE_SIZE - (maddr & ~PAGE_MASK);
> -		if (mchunk > mbytes)
> -			mchunk = mbytes;
> -
> -		uchunk = mchunk;
> -		if (uchunk > ubytes) {
> -			uchunk = ubytes;
> +		mchunk = min_t(size_t, mbytes, PAGE_SIZE - (maddr & ~PAGE_MASK));
> +		uchunk = min_t(size_t, ubytes, mchunk);
> +		if (mchunk > uchunk) {
>  			/* Zero the trailing part of the page */
>  			memset(ptr + uchunk, 0, mchunk - uchunk);
>  		}
> @@ -1461,8 +1452,7 @@ void vmcoreinfo_append_str(const char *fmt, ...)
>  	r = vsnprintf(buf, sizeof(buf), fmt, args);
>  	va_end(args);
>  
> -	if (r + vmcoreinfo_size > vmcoreinfo_max_size)
> -		r = vmcoreinfo_max_size - vmcoreinfo_size;
> +	r = min_t(size_t, r, vmcoreinfo_max_size - vmcoreinfo_size);
>  
>  	memcpy(&vmcoreinfo_data[vmcoreinfo_size], buf, r);
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
