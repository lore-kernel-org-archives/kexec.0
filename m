Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hJaOf-0004X8-LR
 for kexec@lists.infradead.org; Thu, 25 Apr 2019 09:10:29 +0000
Date: Thu, 25 Apr 2019 11:10:19 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] kexec: quiet down kexec reboot
Message-ID: <20190425091019.4oqhaxfr6lug5zbo@verge.net.au>
References: <20190423204154.3085-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190423204154.3085-1-pasha.tatashin@soleen.com>
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
To: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: sashal@kernel.org, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, jmorris@namei.org, ebiederm@xmission.com

On Tue, Apr 23, 2019 at 04:41:54PM -0400, Pavel Tatashin wrote:
> Here is a regular kexec command sequence and output:
> =====
> $ kexec --reuse-cmdline -i --load Image
> $ kexec -e
> [  161.342002] kexec_core: Starting new kernel
> 
> Welcome to Buildroot
> buildroot login:
> =====
> 
> Even when "quiet" kernel parameter is specified, "kexec_core: Starting
> new kernel" is printed.
> 
> This message has  KERN_EMERG level, but there is no emergency, it is
> a normal kexec operation, so quiet it down to appropriate KERN_NOTICE.
> 
> Machines that have slow console baud rate benefit from less output.
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Simon Horman <horms@verge.net.au>

> ---
>  kernel/kexec_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index d7140447be75..fe13e86984ec 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1171,7 +1171,7 @@ int kernel_kexec(void)
>  		 * CPU hotplug again; so re-enable it here.
>  		 */
>  		cpu_hotplug_enable();
> -		pr_emerg("Starting new kernel\n");
> +		pr_notice("Starting new kernel\n");
>  		machine_shutdown();
>  	}
>  
> -- 
> 2.21.0
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
