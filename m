Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1a7DwJ-0006rT-6F
 for kexec@lists.infradead.org; Fri, 11 Dec 2015 03:00:24 +0000
Date: Fri, 11 Dec 2015 10:59:45 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2] kexec: Set KEXEC_TYPE_CRASH before
 sanity_check_segment_list()
Message-ID: <20151211025945.GB2544@x1.redhat.com>
References: <1449045576-18829-1-git-send-email-xlpang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1449045576-18829-1-git-send-email-xlpang@redhat.com>
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
Cc: Dave Young <dyoung@redhat.com>, akpm@linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>

On 12/02/15 at 04:39pm, Xunlei Pang wrote:
> sanity_check_segment_list() checks KEXEC_TYPE_CRASH flag to ensure
> all the segments of the loaded crash kernel are winthin the kernel
> crash resource limits, so set the flag beforehand.
> 
> Signed-off-by: Xunlei Pang <xlpang@redhat.com>
> Acked-by: Dave Young <dyoung@redhat.com>
> ---
> v1 -> v2:
> Improved some comments.
> 
>  kernel/kexec.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index d873b64..ee70aef 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -63,16 +63,16 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
>  	if (ret)
>  		goto out_free_image;
>  
> -	ret = sanity_check_segment_list(image);
> -	if (ret)
> -		goto out_free_image;
> -
> -	 /* Enable the special crash kernel control page allocation policy. */
>  	if (kexec_on_panic) {
> +		/* Enable special crash kernel control page alloc policy. */
>  		image->control_page = crashk_res.start;
>  		image->type = KEXEC_TYPE_CRASH;
>  	}

Good catch. This is hard to be found because kexec-tools user space
utility has make sure it's well located. It must be a code reviewing
finding. Ack it.

Acked-by: Baoquan He <bhe@redhat.com>

Thanks
Baoquan

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
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
