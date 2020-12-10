Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knBKg-0004qh-0I
 for kexec@lists.infradead.org; Thu, 10 Dec 2020 02:05:28 +0000
Date: Thu, 10 Dec 2020 10:05:08 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] kexec: Fix error code in kexec_calculate_store_digests()
Message-ID: <20201210020508.GB2950@dhcp-128-65.nay.redhat.com>
References: <X9B03LFICh/QykQ6@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <X9B03LFICh/QykQ6@mwanda>
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
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: kernel-janitors@vger.kernel.org, kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>, linux-kernel@vger.kernel.org

On 12/08/20 at 10:55pm, Dan Carpenter wrote:
> Return -ENOMEM on allocation failure instead of returning success.
> 
> Fixes: a43cac0d9dc2 ("kexec: split kexec_file syscall code to kexec_file.c")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  kernel/kexec_file.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index b02086d70492..9570f380a825 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -735,8 +735,10 @@ static int kexec_calculate_store_digests(struct kimage *image)
>  
>  	sha_region_sz = KEXEC_SEGMENT_MAX * sizeof(struct kexec_sha_region);
>  	sha_regions = vzalloc(sha_region_sz);
> -	if (!sha_regions)
> +	if (!sha_regions) {
> +		ret = -ENOMEM;
>  		goto out_free_desc;
> +	}
>  
>  	desc->tfm   = tfm;
>  
> -- 
> 2.29.2
> 

Good catch, thanks!

Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
