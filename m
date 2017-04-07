Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cwKFh-0005OW-Fd
 for kexec@lists.infradead.org; Fri, 07 Apr 2017 03:07:58 +0000
Date: Fri, 7 Apr 2017 11:07:05 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 07/24] kexec: Disable at runtime if the kernel is locked
 down
Message-ID: <20170407030705.GB4296@dhcp-128-65.nay.redhat.com>
References: <149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
 <149142333752.5101.12956279967668146884.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <149142333752.5101.12956279967668146884.stgit@warthog.procyon.org.uk>
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
To: David Howells <dhowells@redhat.com>
Cc: matthew.garrett@nebula.com, linux-efi@vger.kernel.org, gnomes@lxorguk.ukuu.org.uk, gregkh@linuxfoundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org

On 04/05/17 at 09:15pm, David Howells wrote:
> From: Matthew Garrett <matthew.garrett@nebula.com>
> 
> kexec permits the loading and execution of arbitrary code in ring 0, which
> is something that lock-down is meant to prevent. It makes sense to disable
> kexec in this situation.
> 
> This does not affect kexec_file_load() which can check for a signature on the
> image to be booted.
> 
> Signed-off-by: Matthew Garrett <matthew.garrett@nebula.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: kexec@lists.infradead.org
> ---
> 
>  kernel/kexec.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 980936a90ee6..46de8e6b42f4 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -194,6 +194,13 @@ SYSCALL_DEFINE4(kexec_load, unsigned long, entry, unsigned long, nr_segments,
>  		return -EPERM;
>  
>  	/*
> +	 * kexec can be used to circumvent module loading restrictions, so
> +	 * prevent loading in that case
> +	 */
> +	if (kernel_is_locked_down())
> +		return -EPERM;
> +
> +	/*
>  	 * Verify we have a legal set of flags
>  	 * This leaves us room for future extensions.
>  	 */
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
