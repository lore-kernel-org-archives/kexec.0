Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1U9ZFB-0005bG-Mk
 for kexec@lists.infradead.org; Sun, 24 Feb 2013 10:55:46 +0000
Date: Sun, 24 Feb 2013 19:55:33 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: use min_t/max_t to avoid 'if (foo == bar)' thing
Message-ID: <20130224105533.GG18639@verge.net.au>
References: <512990F4.3030203@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <512990F4.3030203@cn.fujitsu.com>
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

On Sun, Feb 24, 2013 at 12:03:00PM +0800, Zhang Yanfei wrote:
> This is just a tweak: using min_t/max_t to avoid `if (foo = bar)' thing.

- s/=/==/; s/[/]max_t//


But in any case the change is more than that.
I'd be happier with something like:

	kexec: Use min_t to simplify logic

> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Simon Horman <horms@verge.net.au>
> Signed-off-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> ---
>  kernel/kexec.c |   20 +++++---------------
>  1 files changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 2436ffc..065db87 100644
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
> +		mchunk = min_t(size_t, mbytes, PAGE_SIZE - (maddr & ~PAGE_MASK));
> +		uchunk = min_t(size_t, ubytes, mchunk);

The line above means that uchunk can now never be greater than ubytes.

>  		if (uchunk > ubytes) {

So the following seems more appropriate to me:

		if (mchunk > uchunk) {


> -			uchunk = ubytes;
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

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
