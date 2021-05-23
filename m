Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
 id 1lkiy5-000MOu-Pu
 for kexec@lists.infradead.org; Sun, 23 May 2021 07:56:15 +0000
Date: Sun, 23 May 2021 09:56:01 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] arm64/crashdump-arm64: align 'Kernel code' with '_stext'
Message-ID: <20210523075601.GA23210@vergenet.net>
References: <20210519031621.21008-1-piliu@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210519031621.21008-1-piliu@redhat.com>
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
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org

On Wed, May 19, 2021 at 11:16:21AM +0800, Pingfan Liu wrote:
> Since kernel commit e2a073dde921 ("arm64: omit [_text, _stext) from
> permanent kernel mapping"), the physical address of 'Kernel code' in
> /proc/iomem is mapped from _text, instead, from _stext.
> 
> Change the code to cope with this kernel change.
> 
> Signed-off-by: Pingfan Liu <piliu@redhat.com>

Thanks, will kexec still work with older kernels with this change in place?

> ---
>  kexec/arch/arm64/crashdump-arm64.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kexec/arch/arm64/crashdump-arm64.c b/kexec/arch/arm64/crashdump-arm64.c
> index 38d1a0f..1da663e 100644
> --- a/kexec/arch/arm64/crashdump-arm64.c
> +++ b/kexec/arch/arm64/crashdump-arm64.c
> @@ -148,7 +148,11 @@ static int crash_get_memory_ranges(void)
>  	 * For additional kernel code/data segment.
>  	 * kern_paddr_start/kern_size are determined in iomem_range_callback
>  	 */
> -	elf_info.kern_vaddr_start = get_kernel_sym("_text");
> +	/* Refer to kernel:
> +	 *     kernel_code.start   = __pa_symbol(_stext);
> +	 * which is exported through /proc/iomem as "Kernel code"
> +	 */
> +	elf_info.kern_vaddr_start = get_kernel_sym("_stext");
>  	if (!elf_info.kern_vaddr_start)
>  		elf_info.kern_vaddr_start = UINT64_MAX;
>  
> -- 
> 2.29.2
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
