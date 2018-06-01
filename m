Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fOofv-0000wQ-8h
 for kexec@lists.infradead.org; Fri, 01 Jun 2018 18:21:25 +0000
Date: Fri, 1 Jun 2018 20:21:07 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v4 5/8] ima: based on policy require signed firmware
 (sysfs fallback)
Message-ID: <20180601182107.GO4511@wotan.suse.de>
References: <1527616920-5415-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1527616920-5415-6-git-send-email-zohar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1527616920-5415-6-git-send-email-zohar@linux.vnet.ibm.com>
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
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kexec@lists.infradead.org, linux-security-module@vger.kernel.org, Matthew Garrett <mjg59@google.com>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, "Luis R . Rodriguez" <mcgrof@kernel.org>, Eric Biederman <ebiederm@xmission.com>, linux-integrity@vger.kernel.org, Andres Rodriguez <andresx7@gmail.com>

On Tue, May 29, 2018 at 02:01:57PM -0400, Mimi Zohar wrote:
> Luis, is the security_kernel_post_read_file LSM hook in
> firmware_loading_store() still needed after this patch?  Should it be
> calling security_kernel_load_data() instead?

That's up to Kees to decide as he added that hook, and knows
what LSMs may be doing with it. From my perspective it is confusing
to have that hook there so I think it could be removed now.

Kees?

  Luis

> 
> ---
> 
> With an IMA policy requiring signed firmware, this patch prevents
> the sysfs fallback method of loading firmware.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Luis R. Rodriguez <mcgrof@suse.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Matthew Garrett <mjg59@google.com>
> ---
>  security/integrity/ima/ima_main.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index a565d46084c2..4a87f78098c8 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -475,8 +475,10 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
>  
>  	if (!file && read_id == READING_FIRMWARE) {
>  		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
> -		    (ima_appraise & IMA_APPRAISE_ENFORCE))
> +		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
> +			pr_err("Prevent firmware loading_store.\n");
>  			return -EACCES;	/* INTEGRITY_UNKNOWN */
> +		}
>  		return 0;
>  	}
>  
> @@ -520,6 +522,12 @@ int ima_load_data(enum kernel_load_data_id id)
>  			pr_err("impossible to appraise a kernel image without a file descriptor; try using kexec_file_load syscall.\n");
>  			return -EACCES;	/* INTEGRITY_UNKNOWN */
>  		}
> +		break;
> +	case LOADING_FIRMWARE:
> +		if (ima_appraise & IMA_APPRAISE_FIRMWARE) {
> +			pr_err("Prevent firmware sysfs fallback loading.\n");
> +			return -EACCES;	/* INTEGRITY_UNKNOWN */
> +		}
>  	default:
>  		break;
>  	}
> -- 
> 2.7.5
> 
> 

-- 
Do not panic

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
