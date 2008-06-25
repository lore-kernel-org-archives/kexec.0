Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KBdIo-0006oL-Dc
	for kexec@lists.infradead.org; Wed, 25 Jun 2008 22:17:22 +0000
Date: Wed, 25 Jun 2008 18:16:35 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] Remove CONFIG_EXPERIMENTAL from kdump
Message-ID: <20080625221635.GD32344@redhat.com>
References: <1214430592-18043-1-git-send-email-bwalle@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1214430592-18043-1-git-send-email-bwalle@suse.de>
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
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Wed, Jun 25, 2008 at 11:49:52PM +0200, Bernhard Walle wrote:
> I would suggest to remove the "experimental" status from Kdump.
> Kdump is now in the kernel since a long time and used by Enterprise
> distributions. I don't think that "experimental" is true any more.
> 
> 
> Signed-off-by: Bernhard Walle <bwalle@suse.de>
> ---
>  arch/x86/Kconfig |    1 -
>  fs/Kconfig       |    2 +-
>  2 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index e0edaaa..f4f255b 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1190,7 +1190,6 @@ config KEXEC
>  
>  config CRASH_DUMP
>  	bool "kernel crash dumps (EXPERIMENTAL)"
> -	depends on EXPERIMENTAL
>  	depends on X86_64 || (X86_32 && HIGHMEM)
>  	help
>  	  Generate crash dump after being started by kexec.
> diff --git a/fs/Kconfig b/fs/Kconfig
> index cf12c40..b2252a4 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -930,7 +930,7 @@ config PROC_KCORE
>  
>  config PROC_VMCORE
>          bool "/proc/vmcore support (EXPERIMENTAL)"
> -        depends on PROC_FS && EXPERIMENTAL && CRASH_DUMP
> +        depends on PROC_FS && CRASH_DUMP
>  	default y
>          help
>          Exports the dump image of crashed kernel in ELF format.

Makes sense to me. Thanks.

Acked-by: Vivek Goyal <vgoyal@redhat.com>

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
