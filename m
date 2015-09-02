Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZWwbB-0001R0-Mc
 for kexec@lists.infradead.org; Wed, 02 Sep 2015 01:12:26 +0000
Date: Wed, 2 Sep 2015 10:12:05 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kernel:kexec - Fix for typo in comment in function
 sanity_check_segment_list().
Message-ID: <20150902011205.GF30886@verge.net.au>
References: <1432357737-4269-1-git-send-email-shailendra.capricorn@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1432357737-4269-1-git-send-email-shailendra.capricorn@gmail.com>
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
To: Shailendra Verma <shailendra.capricorn@gmail.com>
Cc: kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>, linux-kernel@vger.kernel.org

Hi Shailendra,

On Sat, May 23, 2015 at 10:38:57AM +0530, Shailendra Verma wrote:
> 
> Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>

Reviewed-by: Simon Horman <horms@verge.net.au>

I believe if you repost this with Andrew Morton <akpm@linux-foundation.org>
cced then there is a good chance of it progressing into a kernel release.

> ---
>  kernel/kexec.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 7a36fdc..50dffdb 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -189,7 +189,7 @@ static int sanity_check_segment_list(struct kimage *image)
>  	}
>  
>  	/* Verify our destination addresses do not overlap.
> -	 * If we alloed overlapping destination addresses
> +	 * If we allowed overlapping destination addresses
>  	 * through very weird things can happen with no
>  	 * easy explanation as one segment stops on another.
>  	 */
> -- 
> 1.7.9.5
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
