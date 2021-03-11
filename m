Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKDvr-008P9D-PG
 for kexec@lists.infradead.org; Thu, 11 Mar 2021 05:32:26 +0000
Date: Thu, 11 Mar 2021 13:32:13 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] kernel: kexec_file: fix error return code of
 kexec_calculate_store_digests()
Message-ID: <20210311053213.GH2962@MiWiFi-R3L-srv>
References: <20210309083904.24321-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210309083904.24321-1-baijiaju1990@gmail.com>
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
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: ebiederm@xmission.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org

On 03/09/21 at 12:39am, Jia-Ju Bai wrote:
> When vzalloc() returns NULL to sha_regions, no error return code of
> kexec_calculate_store_digests() is assigned.
> To fix this bug, ret is assigned with -ENOMEM in this case.
> 
> Fixes: a43cac0d9dc2 ("kexec: split kexec_file syscall code to kexec_file.c")
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  kernel/kexec_file.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 5c3447cf7ad5..33400ff051a8 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -740,8 +740,10 @@ static int kexec_calculate_store_digests(struct kimage *image)
>  
>  	sha_region_sz = KEXEC_SEGMENT_MAX * sizeof(struct kexec_sha_region);
>  	sha_regions = vzalloc(sha_region_sz);
> -	if (!sha_regions)
> +	if (!sha_regions) {
> +		ret = -ENOMEM;
>  		goto out_free_desc;

A good catch. Even though the chance of failure is very small, it does
cause issue if happened.

Acked-by: Baoquan He <bhe@redhat.com>

Thanks
Baoquan

> +	}
>  
>  	desc->tfm   = tfm;
>  
> -- 
> 2.17.1
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
