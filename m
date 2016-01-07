Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aH9qF-0001ex-T0
 for kexec@lists.infradead.org; Thu, 07 Jan 2016 12:39:03 +0000
Date: Thu, 7 Jan 2016 20:38:25 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v3 07/17] kexec: Set IORESOURCE_SYSTEM_RAM to System RAM
Message-ID: <20160107123825.GB2870@dhcp-128-65.nay.redhat.com>
References: <1452020081-26534-1-git-send-email-toshi.kani@hpe.com>
 <1452020081-26534-7-git-send-email-toshi.kani@hpe.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1452020081-26534-7-git-send-email-toshi.kani@hpe.com>
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
To: Toshi Kani <toshi.kani@hpe.com>
Cc: linux-arch@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, bp@alien8.de, akpm@linux-foundation.org

On 01/05/16 at 11:54am, Toshi Kani wrote:
> Set IORESOURCE_SYSTEM_RAM to 'flags' and IORES_DESC_CRASH_KERNEL
> to 'desc' of "Crash kernel" resource ranges, which are child
> nodes of System RAM.
> 
> Change crash_shrink_memory() to set IORESOURCE_SYSTEM_RAM for
> a System RAM range.
> 
> Change kexec_add_buffer() to call walk_iomem_res() with
> IORESOURCE_SYSTEM_RAM type for "Crash kernel".
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: kexec@lists.infradead.org
> Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
> ---
>  kernel/kexec_core.c |    8 +++++---
>  kernel/kexec_file.c |    2 +-
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 11b64a6..80bff05 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -66,13 +66,15 @@ struct resource crashk_res = {
>  	.name  = "Crash kernel",
>  	.start = 0,
>  	.end   = 0,
> -	.flags = IORESOURCE_BUSY | IORESOURCE_MEM
> +	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
> +	.desc  = IORES_DESC_CRASH_KERNEL
>  };
>  struct resource crashk_low_res = {
>  	.name  = "Crash kernel",
>  	.start = 0,
>  	.end   = 0,
> -	.flags = IORESOURCE_BUSY | IORESOURCE_MEM
> +	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
> +	.desc  = IORES_DESC_CRASH_KERNEL
>  };
>  
>  int kexec_should_crash(struct task_struct *p)
> @@ -934,7 +936,7 @@ int crash_shrink_memory(unsigned long new_size)
>  
>  	ram_res->start = end;
>  	ram_res->end = crashk_res.end;
> -	ram_res->flags = IORESOURCE_BUSY | IORESOURCE_MEM;
> +	ram_res->flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM;
>  	ram_res->name = "System RAM";
>  
>  	crashk_res.end = end - 1;
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index b70ada0..c245085 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -523,7 +523,7 @@ int kexec_add_buffer(struct kimage *image, char *buffer, unsigned long bufsz,
>  	/* Walk the RAM ranges and allocate a suitable range for the buffer */
>  	if (image->type == KEXEC_TYPE_CRASH)
>  		ret = walk_iomem_res("Crash kernel",
> -				     IORESOURCE_MEM | IORESOURCE_BUSY,
> +				     IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
>  				     crashk_res.start, crashk_res.end, kbuf,
>  				     locate_mem_hole_callback);
>  	else

Reviewed-by: Dave Young <dyoung@redhat.com>

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
