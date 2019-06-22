Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hepoe-0000vy-Lc
 for kexec@lists.infradead.org; Sat, 22 Jun 2019 23:53:06 +0000
Received: by mail-pl1-x641.google.com with SMTP id a93so4804927pla.7
 for <kexec@lists.infradead.org>; Sat, 22 Jun 2019 16:53:01 -0700 (PDT)
Date: Sat, 22 Jun 2019 16:52:59 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH V34 06/29] kexec_load: Disable at runtime if the kernel
 is locked down
Message-ID: <201906221652.2268FEE@keescook>
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-7-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190622000358.19895-7-matthewgarrett@google.com>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-api@vger.kernel.org, kexec@lists.infradead.org, jmorris@namei.org, Matthew Garrett <mjg59@google.com>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, Dave Young <dyoung@redhat.com>

On Fri, Jun 21, 2019 at 05:03:35PM -0700, Matthew Garrett wrote:
> From: Matthew Garrett <mjg59@srcf.ucam.org>
> 
> The kexec_load() syscall permits the loading and execution of arbitrary
> code in ring 0, which is something that lock-down is meant to prevent. It
> makes sense to disable kexec_load() in this situation.
> 
> This does not affect kexec_file_load() syscall which can check for a
> signature on the image to be booted.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Acked-by: Dave Young <dyoung@redhat.com>
> cc: kexec@lists.infradead.org
> ---
>  include/linux/security.h     | 1 +
>  kernel/kexec.c               | 8 ++++++++
>  security/lockdown/lockdown.c | 1 +
>  3 files changed, 10 insertions(+)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 200175c8605a..00a31ab2e5ba 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -84,6 +84,7 @@ enum lockdown_reason {
>  	LOCKDOWN_NONE,
>  	LOCKDOWN_MODULE_SIGNATURE,
>  	LOCKDOWN_DEV_MEM,
> +	LOCKDOWN_KEXEC,
>  	LOCKDOWN_INTEGRITY_MAX,
>  	LOCKDOWN_CONFIDENTIALITY_MAX,
>  };
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 68559808fdfa..ec3f07a4b1c0 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -207,6 +207,14 @@ static inline int kexec_load_check(unsigned long nr_segments,
>  	if (result < 0)
>  		return result;
>  
> +	/*
> +	 * kexec can be used to circumvent module loading restrictions, so
> +	 * prevent loading in that case
> +	 */
> +	result = security_locked_down(LOCKDOWN_KEXEC);
> +	if (result)
> +		return result;
> +
>  	/*
>  	 * Verify we have a legal set of flags
>  	 * This leaves us room for future extensions.
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index 565c87451f0f..08fcd8116db3 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -20,6 +20,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>  	[LOCKDOWN_NONE] = "none",
>  	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
>  	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
> +	[LOCKDOWN_KEXEC] = "kexec of unsigned images",
>  	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
>  	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
>  };
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

-- 
Kees Cook

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
