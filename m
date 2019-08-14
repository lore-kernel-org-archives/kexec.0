Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hxlla-0003Gk-Rs
 for kexec@lists.infradead.org; Wed, 14 Aug 2019 05:24:12 +0000
Date: Wed, 14 Aug 2019 13:23:59 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 3/6] Avoid build warning when !CONFIG_KEXEC_SIG
Message-ID: <20190814052359.GA10664@dhcp-128-65.nay.redhat.com>
References: <20190813192126.122370-1-matthewgarrett@google.com>
 <20190813192126.122370-4-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190813192126.122370-4-matthewgarrett@google.com>
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
To: Matthew Garrett <matthewgarrett@google.com>
Cc: Jiri Bohac <jbohac@suse.cz>, linux-security-module@vger.kernel.org, kexec@lists.infradead.org, jmorris@namei.org, Matthew Garrett <mjg59@google.com>

On 08/13/19 at 12:21pm, Matthew Garrett wrote:
> Refactor the signature validation and lockdown integration a little in
> order to avoid an unused variable.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Cc: Jiri Bohac <jbohac@suse.cz>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: kexec@lists.infradead.org
> ---
>  kernel/kexec_file.c | 72 ++++++++++++++++++++++++++++-----------------
>  1 file changed, 45 insertions(+), 27 deletions(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index be0c13076056..e878587715b9 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -177,36 +177,13 @@ void kimage_file_post_load_cleanup(struct kimage *image)
>  	image->image_loader_data = NULL;
>  }
>  
> -/*
> - * In file mode list of segments is prepared by kernel. Copy relevant
> - * data from user space, do error checking, prepare segment list
> - */
> +#ifdef CONFIG_KEXEC_SIG
>  static int
> -kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
> -			     const char __user *cmdline_ptr,
> -			     unsigned long cmdline_len, unsigned flags)
> +kimage_validate_signature(struct kimage *image)
>  {
>  	const char *reason;
>  	int ret;
> -	void *ldata;
> -	loff_t size;
> -
> -	ret = kernel_read_file_from_fd(kernel_fd, &image->kernel_buf,
> -				       &size, INT_MAX, READING_KEXEC_IMAGE);
> -	if (ret)
> -		return ret;
> -	image->kernel_buf_len = size;
> -
> -	/* IMA needs to pass the measurement list to the next kernel. */
> -	ima_add_kexec_buffer(image);
>  
> -	/* Call arch image probe handlers */
> -	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
> -					    image->kernel_buf_len);
> -	if (ret)
> -		goto out;
> -
> -#ifdef CONFIG_KEXEC_SIG
>  	ret = arch_kexec_kernel_verify_sig(image, image->kernel_buf,
>  					   image->kernel_buf_len);
>  	switch (ret) {
> @@ -228,7 +205,7 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  	decide:
>  		if (IS_ENABLED(CONFIG_KEXEC_SIG_FORCE)) {
>  			pr_notice("%s rejected\n", reason);
> -			goto out;
> +			break;
>  		}
>  
>  		ret = 0;
> @@ -251,9 +228,44 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  		 */
>  	default:
>  		pr_notice("kernel signature verification failed (%d).\n", ret);
> -		goto out;
> +		break;
>  	}
> +
> +	return ret;
> +}
> +#endif
> +
> +/*
> + * In file mode list of segments is prepared by kernel. Copy relevant
> + * data from user space, do error checking, prepare segment list
> + */
> +static int
> +kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
> +			     const char __user *cmdline_ptr,
> +			     unsigned long cmdline_len, unsigned flags)
> +{
> +	int ret;
> +	void *ldata;
> +	loff_t size;
> +
> +	ret = kernel_read_file_from_fd(kernel_fd, &image->kernel_buf,
> +				       &size, INT_MAX, READING_KEXEC_IMAGE);
> +	if (ret)
> +		return ret;
> +	image->kernel_buf_len = size;
> +
> +	/* Call arch image probe handlers */
> +	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
> +					    image->kernel_buf_len);
> +	if (ret)
> +		goto out;
> +
> +#ifdef CONFIG_KEXEC_SIG
> +	ret = kimage_validate_signature(image);
> +	if (ret)
> +		goto out;
>  #endif
> +
>  	/* It is possible that there no initramfs is being loaded */
>  	if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
>  		ret = kernel_read_file_from_fd(initrd_fd, &image->initrd_buf,
> @@ -279,8 +291,14 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  			ret = -EINVAL;
>  			goto out;
>  		}
> +
> +		ima_kexec_cmdline(image->cmdline_buf,
> +				  image->cmdline_buf_len - 1);
>  	}
>  
> +	/* IMA needs to pass the measurement list to the next kernel. */
> +	ima_add_kexec_buffer(image);
> +
>  	/* Call arch image load handlers */
>  	ldata = arch_kexec_kernel_image_load(image);
>  

I can not get the whole thread, also not sure which tree it should
apply.

I assume it is based on your series for lockdown.  But it is really hard
to review because of no context in this patch.

Also I think it should be good to split the preparation piece of kexec
and send them separately.  Since it is improve the signature
verification logic, they do not necessarily depend on the lockdown
series.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
