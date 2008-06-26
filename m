Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from wr-out-0506.google.com ([64.233.184.231])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KBtPA-0003mf-HX
	for kexec@lists.infradead.org; Thu, 26 Jun 2008 15:29:00 +0000
Received: by wr-out-0506.google.com with SMTP id 70so63994wra.22
	for <kexec@lists.infradead.org>; Thu, 26 Jun 2008 08:28:59 -0700 (PDT)
Subject: Re: [PATCH] Remove experimental status of kdump on PPC64
From: Josh Boyer <jwboyer@gmail.com>
In-Reply-To: <1214485035-26041-1-git-send-email-bwalle@suse.de>
References: <1214485035-26041-1-git-send-email-bwalle@suse.de>
Date: Thu, 26 Jun 2008 11:28:52 -0400
Message-Id: <1214494132.2791.0.camel@weaponx>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com

On Thu, 2008-06-26 at 14:57 +0200, Bernhard Walle wrote:
> This patch removes the experimental status of kdump on IA64. kdump is on IA64
> now since more than one year and it has proven to be stable.

I think you mean PPC64?

josh

> For i386/x86_64, a similar patch has been accepted by Ingo Molnar and Vivek
> Goyal.
> 
> 
> Signed-off-by: Bernhard Walle <bwalle@suse.de>
> ---
>  arch/powerpc/Kconfig |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 3934e26..2a116b9 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -308,8 +308,8 @@ config KEXEC
>  	  strongly in flux, so no good recommendation can be made.
>  
>  config CRASH_DUMP
> -	bool "Build a kdump crash kernel (EXPERIMENTAL)"
> -	depends on PPC_MULTIPLATFORM && PPC64 && EXPERIMENTAL
> +	bool "Build a kdump crash kernel"
> +	depends on PPC_MULTIPLATFORM && PPC64
>  	help
>  	  Build a kernel suitable for use as a kdump capture kernel.
>  	  The kernel will be linked at a different address than normal, and


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
