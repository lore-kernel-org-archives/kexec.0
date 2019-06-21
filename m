Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1heDH4-0008WS-ST
 for kexec@lists.infradead.org; Fri, 21 Jun 2019 06:43:52 +0000
Date: Fri, 21 Jun 2019 14:43:40 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH V31 07/25] kexec_file: Restrict at runtime if the kernel
 is locked down
Message-ID: <20190621064340.GB4528@localhost.localdomain>
References: <20190326182742.16950-1-matthewgarrett@google.com>
 <20190326182742.16950-8-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190326182742.16950-8-matthewgarrett@google.com>
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
Cc: Jiri Bohac <jbohac@suse.cz>, linux-api@vger.kernel.org, kexec@lists.infradead.org, jmorris@namei.org, Matthew Garrett <mjg59@google.com>, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-security-module@vger.kernel.org, luto@kernel.org

On 03/26/19 at 11:27am, Matthew Garrett wrote:
> From: Jiri Bohac <jbohac@suse.cz>
> 
> When KEXEC_SIG is not enabled, kernel should not load images through
> kexec_file systemcall if the kernel is locked down.
> 
> [Modified by David Howells to fit with modifications to the previous patch
>  and to return -EPERM if the kernel is locked down for consistency with
>  other lockdowns. Modified by Matthew Garrett to remove the IMA
>  integration, which will be replaced by integrating with the IMA
>  architecture policy patches.]
> 
> Signed-off-by: Jiri Bohac <jbohac@suse.cz>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Reviewed-by: Jiri Bohac <jbohac@suse.cz>
> cc: kexec@lists.infradead.org
> ---
>  kernel/kexec_file.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 67f3a866eabe..a1cc37c8b43b 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -239,6 +239,12 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  		}
>  
>  		ret = 0;
> +
> +		if (kernel_is_locked_down(reason, LOCKDOWN_INTEGRITY)) {
> +			ret = -EPERM;
> +			goto out;
> +		}
> +

Checking here is late, it would be good to move the check to earlier
code around below code:
        /* We only trust the superuser with rebooting the system. */
        if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
                return -EPERM;

>  		break;
>  
>  		/* All other errors are fatal, including nomem, unparseable
> -- 
> 2.21.0.392.gf8f6787159e-goog
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
