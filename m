Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XLyIq-0002Tc-Sh
 for kexec@lists.infradead.org; Mon, 25 Aug 2014 17:43:37 +0000
Date: Mon, 25 Aug 2014 13:42:44 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 2/5] kexec: Simplify conditional
Message-ID: <20140825174244.GE14379@redhat.com>
References: <cover.1408731991.git.geoff@infradead.org>
 <5a3bbdeb26cd8891f2b9de1ce05dbacfc282f7d1.1408731991.git.geoff@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5a3bbdeb26cd8891f2b9de1ce05dbacfc282f7d1.1408731991.git.geoff@infradead.org>
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
To: Geoff Levand <geoff@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org

On Fri, Aug 22, 2014 at 06:39:47PM +0000, Geoff Levand wrote:
> Simplify the code around one of the conditionals in the kexec_load
> syscall routine.
> 
> The original code was confusing with a redundant check on KEXEC_ON_CRASH
> and comments outside of the conditional block.  This change switches the
> order of the conditional check, and cleans up the comments for the
> conditional.  There is no functional change to the code.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>

This is simple reorganization.

Acked-by: Vivek Goyal <vgoyal@redhat.com>

Vivek

> ---
>  kernel/kexec.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 0b49a0a..d04b56e 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -1282,19 +1282,22 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
>  	if (nr_segments > 0) {
>  		unsigned long i;
>  
> -		/* Loading another kernel to reboot into */
> -		if ((flags & KEXEC_ON_CRASH) == 0)
> -			result = kimage_alloc_init(&image, entry, nr_segments,
> -						   segments, flags);
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
>  			kimage_free(xchg(&kexec_crash_image, NULL));
>  			result = kimage_alloc_init(&image, entry, nr_segments,
>  						   segments, flags);
>  			crash_map_reserved_pages();
> +		} else {
> +			/* Loading another kernel to reboot into. */
> +
> +			result = kimage_alloc_init(&image, entry, nr_segments,
> +						   segments, flags);
>  		}
>  		if (result)
>  			goto out;
> -- 
> 1.9.1
> 
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
