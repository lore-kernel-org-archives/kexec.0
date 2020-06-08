Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jiCP1-0005ju-Jn
 for kexec@lists.infradead.org; Mon, 08 Jun 2020 07:41:05 +0000
Date: Mon, 8 Jun 2020 15:40:47 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v2] kexec: Do not verify the signature without the
 lockdown or mandatory signature
Message-ID: <20200608074047.GF20367@MiWiFi-R3L-srv>
References: <20200602045952.27487-1-lijiang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200602045952.27487-1-lijiang@redhat.com>
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
To: Lianbo Jiang <lijiang@redhat.com>
Cc: jbohac@suse.cz, kexec@lists.infradead.org, jmorris@namei.org, mjg59@google.com, linux-kernel@vger.kernel.org, ebiederm@xmission.com, akpm@linux-foundation.org, dyoung@redhat.com

On 06/02/20 at 12:59pm, Lianbo Jiang wrote:
> Signature verification is an important security feature, to protect
> system from being attacked with a kernel of unknown origin. Kexec
> rebooting is a way to replace the running kernel, hence need be
> secured carefully.
> 
> In the current code of handling signature verification of kexec kernel,
> the logic is very twisted. It mixes signature verification, IMA signature
> appraising and kexec lockdown.
> 
> If there is no KEXEC_SIG_FORCE, kexec kernel image doesn't have one of
> signature, the supported crypto, and key, we don't think this is wrong,
> Unless kexec lockdown is executed. IMA is considered as another kind of
> signature appraising method.
> 
> If kexec kernel image has signature/crypto/key, it has to go through the
> signature verification and pass. Otherwise it's seen as verification
> failure, and won't be loaded.
> 
> Seems kexec kernel image with an unqualified signature is even worse than
> those w/o signature at all, this sounds very unreasonable. E.g. If people
> get a unsigned kernel to load, or a kernel signed with expired key, which
> one is more dangerous?
> 
> So, here, let's simplify the logic to improve code readability. If the
> KEXEC_SIG_FORCE enabled or kexec lockdown enabled, signature verification
> is mandated. Otherwise, we lift the bar for any kernel image.
> 
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>

Looks good to me.

Acked-by: Baoquan He <bhe@redhat.com>

> ---
> Changes since v1:
> [1] Modify the log level(suggested by Jiri Bohac)
> 
>  kernel/kexec_file.c | 34 ++++++----------------------------
>  1 file changed, 6 insertions(+), 28 deletions(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index faa74d5f6941..fae496958a68 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -181,34 +181,19 @@ void kimage_file_post_load_cleanup(struct kimage *image)
>  static int
>  kimage_validate_signature(struct kimage *image)
>  {
> -	const char *reason;
>  	int ret;
>  
>  	ret = arch_kexec_kernel_verify_sig(image, image->kernel_buf,
>  					   image->kernel_buf_len);
> -	switch (ret) {
> -	case 0:
> -		break;
> +	if (ret) {
>  
> -		/* Certain verification errors are non-fatal if we're not
> -		 * checking errors, provided we aren't mandating that there
> -		 * must be a valid signature.
> -		 */
> -	case -ENODATA:
> -		reason = "kexec of unsigned image";
> -		goto decide;
> -	case -ENOPKG:
> -		reason = "kexec of image with unsupported crypto";
> -		goto decide;
> -	case -ENOKEY:
> -		reason = "kexec of image with unavailable key";
> -	decide:
>  		if (IS_ENABLED(CONFIG_KEXEC_SIG_FORCE)) {
> -			pr_notice("%s rejected\n", reason);
> +			pr_notice("Enforced kernel signature verification failed (%d).\n", ret);
>  			return ret;
>  		}
>  
> -		/* If IMA is guaranteed to appraise a signature on the kexec
> +		/*
> +		 * If IMA is guaranteed to appraise a signature on the kexec
>  		 * image, permit it even if the kernel is otherwise locked
>  		 * down.
>  		 */
> @@ -216,17 +201,10 @@ kimage_validate_signature(struct kimage *image)
>  		    security_locked_down(LOCKDOWN_KEXEC))
>  			return -EPERM;
>  
> -		return 0;
> -
> -		/* All other errors are fatal, including nomem, unparseable
> -		 * signatures and signature check failures - even if signatures
> -		 * aren't required.
> -		 */
> -	default:
> -		pr_notice("kernel signature verification failed (%d).\n", ret);
> +		pr_debug("kernel signature verification failed (%d).\n", ret);
>  	}
>  
> -	return ret;
> +	return 0;
>  }
>  #endif
>  
> -- 
> 2.17.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
