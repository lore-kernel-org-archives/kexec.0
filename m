Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1heppe-00015h-Fl
 for kexec@lists.infradead.org; Sat, 22 Jun 2019 23:54:07 +0000
Received: by mail-pf1-x441.google.com with SMTP id y15so785617pfn.5
 for <kexec@lists.infradead.org>; Sat, 22 Jun 2019 16:54:06 -0700 (PDT)
Date: Sat, 22 Jun 2019 16:54:04 -0700
From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH V34 09/29] kexec_file: Restrict at runtime if the kernel
 is locked down
Message-ID: <201906221654.3E113D1@keescook>
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-10-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190622000358.19895-10-matthewgarrett@google.com>
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
Cc: Jiri Bohac <jbohac@suse.cz>, linux-api@vger.kernel.org, kexec@lists.infradead.org, jmorris@namei.org, Matthew Garrett <mjg59@google.com>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org

On Fri, Jun 21, 2019 at 05:03:38PM -0700, Matthew Garrett wrote:
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

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Reviewed-by: Jiri Bohac <jbohac@suse.cz>
> cc: kexec@lists.infradead.org
> ---
>  kernel/kexec_file.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index eec7e5bb2a08..27adb4312b03 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -237,7 +237,10 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  			goto out;
>  		}
>  
> -		ret = 0;
> +		ret = security_locked_down(LOCKDOWN_KEXEC);
> +		if (ret)
> +			goto out;
> +
>  		break;
>  
>  		/* All other errors are fatal, including nomem, unparseable
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

-- 
Kees Cook

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
