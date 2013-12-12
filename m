Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VqvZk-0007Ni-Fb
 for kexec@lists.infradead.org; Thu, 12 Dec 2013 02:00:29 +0000
Message-ID: <52A91212.9080501@cn.fujitsu.com>
Date: Thu, 12 Dec 2013 09:32:02 +0800
From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/4] kexec: Simplify conditional
References: <cover.1386807069.git.geoff@infradead.org>
 <839896bb375c8b694473b0ea6a6db009c1128fc5.1386807069.git.geoff@infradead.org>
In-Reply-To: <839896bb375c8b694473b0ea6a6db009c1128fc5.1386807069.git.geoff@infradead.org>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Geoff Levand <geoff@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>

Add CCing Andrew Morton

On 12/12/2013 08:18 AM, Geoff Levand wrote:
> Simplify the code around one of the conditionals in the kexec_load
> syscall routine.
> 
> The original code was confusing with a redundant check on KEXEC_ON_CRASH
> and comments outside of the conditional block.  This change switches the
> order of the conditional check, and cleans up the comments for the
> conditional.  There is no functional change to the code.

This looks good.

Reviewed-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>

minor comments below.

> 
> Signed-off-by: Geoff Levand <geoff@infradead.org> for Huawei, Linaro
> ---
>  kernel/kexec.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 490afc0..89a6fa3 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -980,19 +980,22 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
>  	if (nr_segments > 0) {
>  		unsigned long i;
>  
> -		/* Loading another kernel to reboot into */
> -		if ((flags & KEXEC_ON_CRASH) == 0)
> -			result = kimage_normal_alloc(&image, entry,
> -							nr_segments, segments);
> -		/* Loading another kernel to switch to if this one crashes */
> -		else if (flags & KEXEC_ON_CRASH) {
> -			/* Free any current crash dump kernel before
> +		if (flags & KEXEC_ON_CRASH) {
> +			/*
> +			 * Loading another kernel to switch to if this one
> +			 * crashes.  Free any current crash dump kernel before
>  			 * we corrupt it.
>  			 */
> +

This empty line is not necessary, I think. But no big deal.

>  			kimage_free(xchg(&kexec_crash_image, NULL));
>  			result = kimage_crash_alloc(&image, entry,
>  						     nr_segments, segments);
>  			crash_map_reserved_pages();
> +		} else {
> +			/* Loading another kernel to reboot into. */
> +

ditto.

> +			result = kimage_normal_alloc(&image, entry,
> +							nr_segments, segments);
>  		}
>  		if (result)
>  			goto out;
> 


-- 
Thanks.
Zhang Yanfei

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
