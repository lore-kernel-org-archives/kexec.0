Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a40H1-00066O-Db
 for kexec@lists.infradead.org; Wed, 02 Dec 2015 05:48:16 +0000
Date: Wed, 2 Dec 2015 13:47:45 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 1/2] kexec: Set KEXEC_TYPE_CRASH before
 sanity_check_segment_list()
Message-ID: <20151202054745.GA2899@dhcp-128-65.nay.redhat.com>
References: <1449033995-15700-1-git-send-email-xlpang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1449033995-15700-1-git-send-email-xlpang@redhat.com>
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
To: Xunlei Pang <xlpang@redhat.com>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>

Ccing Andrew since usually he monitors and picks up kexec patches.

On 12/02/15 at 01:26pm, Xunlei Pang wrote:
> sanity_check_segment_list() checks KEXEC_TYPE_CRASH flag to ensure
> all the segments of the loaded crash kernel are winthin the kernel
> crash resource limits, so set the flag beforehand.

Looks good except a nitpick, see comments inline.

Otherwise:
Acked-by: Dave Young <dyoung@redhat.com>

> 
> Signed-off-by: Xunlei Pang <xlpang@redhat.com>
> ---
>  kernel/kexec.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index d873b64..9624391 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -63,16 +63,19 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
>  	if (ret)
>  		goto out_free_image;
>  
> -	ret = sanity_check_segment_list(image);
> -	if (ret)
> -		goto out_free_image;
> -
> -	 /* Enable the special crash kernel control page allocation policy. */
> +	/*
> +	 * Enable the special crash kernel control page allocation policy,
> +	 * and set the crash type flag.

It is obvious it is setting the crash type flag, so no need to add extra
comment.

> +	 */
>  	if (kexec_on_panic) {

Like kexec_file.c, move /* Enable ... policy */ here sounds better.
 
>  		image->control_page = crashk_res.start;
>  		image->type = KEXEC_TYPE_CRASH;
>  	}
>  
> +	ret = sanity_check_segment_list(image);
> +	if (ret)
> +		goto out_free_image;
> +
>  	/*
>  	 * Find a location for the control code buffer, and add it
>  	 * the vector of segments so that it's pages will also be
> -- 
> 2.5.0
> 

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
