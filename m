Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n1kI2-00GJ2M-Fj
 for kexec@lists.infradead.org; Mon, 27 Dec 2021 07:19:27 +0000
Date: Mon, 27 Dec 2021 15:19:07 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH kernel-next] kernel: remove redundant result variable
Message-ID: <20211227071907.GB2731@MiWiFi-R3L-srv>
References: <20211215055913.441464-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
In-Reply-To: <20211215055913.441464-1-chi.minghao@zte.com.cn>
Content-Disposition: inline
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
To: cgel.zte@gmail.com
Cc: ebiederm@xmission.com, kexec@lists.infradead.org, Minghao Chi <chi.minghao@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>

On 12/15/21 at 05:59am, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Return value from kimage_add_entry() directly instead
> of taking this in another redundant variable.

> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>


Nice clean up, looks good to me. Thx.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> ---
>  kernel/kexec_core.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 5a5d192a89ac..574391de1f83 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -561,23 +561,17 @@ static int kimage_add_entry(struct kimage *image, kimage_entry_t entry)
>  static int kimage_set_destination(struct kimage *image,
>  				   unsigned long destination)
>  {
> -	int result;
> -
>  	destination &= PAGE_MASK;
> -	result = kimage_add_entry(image, destination | IND_DESTINATION);
>  
> -	return result;
> +	return kimage_add_entry(image, destination | IND_DESTINATION);
>  }
>  
>  
>  static int kimage_add_page(struct kimage *image, unsigned long page)
>  {
> -	int result;
> -
>  	page &= PAGE_MASK;
> -	result = kimage_add_entry(image, page | IND_SOURCE);
>  
> -	return result;
> +	return kimage_add_entry(image, page | IND_SOURCE);
>  }
>  
>  
> -- 
> 2.25.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
