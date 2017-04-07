Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cwKEY-0005Mi-5G
 for kexec@lists.infradead.org; Fri, 07 Apr 2017 03:06:47 +0000
Date: Fri, 7 Apr 2017 11:05:45 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH 09/24] kexec_file: Disable at runtime if securelevel has
 been set
Message-ID: <20170407030545.GA4296@dhcp-128-65.nay.redhat.com>
References: <149142326734.5101.4596394505987813763.stgit@warthog.procyon.org.uk>
 <149142335441.5101.2294976563846442575.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <149142335441.5101.2294976563846442575.stgit@warthog.procyon.org.uk>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-efi@vger.kernel.org, gnomes@lxorguk.ukuu.org.uk, gregkh@linuxfoundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Chun-Yi Lee <jlee@suse.com>, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, matthew.garrett@nebula.com

On 04/05/17 at 09:15pm, David Howells wrote:
> From: Chun-Yi Lee <joeyli.kernel@gmail.com>
> 
> When KEXEC_VERIFY_SIG is not enabled, kernel should not loads image
> through kexec_file systemcall if securelevel has been set.
> 
> This code was showed in Matthew's patch but not in git:
> https://lkml.org/lkml/2015/3/13/778
> 
> Cc: Matthew Garrett <mjg59@srcf.ucam.org>
> Signed-off-by: Chun-Yi Lee <jlee@suse.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: kexec@lists.infradead.org
> ---
> 
>  kernel/kexec_file.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index b118735fea9d..f6937eecd1eb 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -268,6 +268,12 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>  	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
>  		return -EPERM;
>  
> +	/* Don't permit images to be loaded into trusted kernels if we're not
> +	 * going to verify the signature on them
> +	 */
> +	if (!IS_ENABLED(CONFIG_KEXEC_VERIFY_SIG) && kernel_is_locked_down())
> +		return -EPERM;
> +
>  	/* Make sure we have a legal set of flags */
>  	if (flags != (flags & KEXEC_FILE_FLAGS))
>  		return -EINVAL;
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
