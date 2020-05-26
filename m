Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jdRm7-0006sx-P6
 for kexec@lists.infradead.org; Tue, 26 May 2020 05:05:17 +0000
Date: Tue, 26 May 2020 13:04:51 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] kexec: Do not verify the signature without the lockdown
 or mandatory signature
Message-ID: <20200526050451.GA74334@dhcp-128-65.nay.redhat.com>
References: <20200525052351.24134-1-lijiang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200525052351.24134-1-lijiang@redhat.com>
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
Cc: jbohac@suse.cz, bhe@redhat.com, kexec@lists.infradead.org, jmorris@namei.org, mjg59@google.com, linux-kernel@vger.kernel.org, ebiederm@xmission.com

On 05/25/20 at 01:23pm, Lianbo Jiang wrote:
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
> ---
>  kernel/kexec_file.c | 37 ++++++-------------------------------
>  1 file changed, 6 insertions(+), 31 deletions(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index faa74d5f6941..e4bdf0c42f35 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -181,52 +181,27 @@ void kimage_file_post_load_cleanup(struct kimage *image)
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
> +		pr_debug("kernel signature verification failed (%d).\n", ret);
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
> -		if (IS_ENABLED(CONFIG_KEXEC_SIG_FORCE)) {
> -			pr_notice("%s rejected\n", reason);
> +		if (IS_ENABLED(CONFIG_KEXEC_SIG_FORCE))
>  			return ret;
> -		}
>  
> -		/* If IMA is guaranteed to appraise a signature on the kexec
> +		/*
> +		 * If IMA is guaranteed to appraise a signature on the kexec
>  		 * image, permit it even if the kernel is otherwise locked
>  		 * down.
>  		 */
>  		if (!ima_appraise_signature(READING_KEXEC_IMAGE) &&
>  		    security_locked_down(LOCKDOWN_KEXEC))
>  			return -EPERM;
> -
> -		return 0;
> -
> -		/* All other errors are fatal, including nomem, unparseable
> -		 * signatures and signature check failures - even if signatures
> -		 * aren't required.
> -		 */
> -	default:
> -		pr_notice("kernel signature verification failed (%d).\n", ret);
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


Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
