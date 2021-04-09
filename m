Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUqVZ-000lq0-42
 for kexec@lists.infradead.org; Fri, 09 Apr 2021 12:45:11 +0000
Date: Fri, 9 Apr 2021 20:44:43 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] x86/efi: Do not release sub-1MB memory regions when the
 crashkernel option is specified
Message-ID: <20210409124443.GA20513@MiWiFi-R3L-srv>
References: <20210407140316.30210-1-lijiang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210407140316.30210-1-lijiang@redhat.com>
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
To: Lianbo Jiang <lijiang@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org, x86@kernel.org, ardb@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dvhart@infradead.org, andy@infradead.org, hpa@zytor.com, kexec@lists.infradead.org, dyoung@redhat.com

On 04/07/21 at 10:03pm, Lianbo Jiang wrote:
> Some sub-1MB memory regions may be reserved by EFI boot services, and the
> memory regions will be released later in the efi_free_boot_services().
> 
> Currently, always reserve all sub-1MB memory regions when the crashkernel
> option is specified, but unfortunately EFI boot services may have already
> reserved some sub-1MB memory regions before the crash_reserve_low_1M() is
> called, which makes that the crash_reserve_low_1M() only own the
> remaining sub-1MB memory regions, not all sub-1MB memory regions, because,
> subsequently EFI boot services will free its own sub-1MB memory regions.
> Eventually, DMA will be able to allocate memory from the sub-1MB area and
> cause the following error:
> 

So this patch is fixing a problem found in crash utility. We ever met
the similar issue, later fixed by always reserving low 1M in commit
6f599d84231fd27 ("x86/kdump: Always reserve the low 1M when the crashkernel
option is specified"). Seems the commit is not fixing it completely.

> crash> kmem -s |grep invalid
> kmem: dma-kmalloc-512: slab: ffffd52c40001900 invalid freepointer: ffff9403c0067300
> kmem: dma-kmalloc-512: slab: ffffd52c40001900 invalid freepointer: ffff9403c0067300
> crash> vtop ffff9403c0067300
> VIRTUAL           PHYSICAL
> ffff9403c0067300  67300   --->The physical address falls into this range [0x0000000000063000-0x000000000008efff]
> 
> kernel debugging log:
> ...
> [    0.008927] memblock_reserve: [0x0000000000010000-0x0000000000013fff] efi_reserve_boot_services+0x85/0xd0
> [    0.008930] memblock_reserve: [0x0000000000063000-0x000000000008efff] efi_reserve_boot_services+0x85/0xd0
> ...
> [    0.009425] memblock_reserve: [0x0000000000000000-0x00000000000fffff] crash_reserve_low_1M+0x2c/0x49
> ...
> [    0.010586] Zone ranges:
> [    0.010587]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.010589]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> [    0.010591]   Normal   [mem 0x0000000100000000-0x0000000c7fffffff]
> [    0.010593]   Device   empty
> ...
> [    8.814894] __memblock_free_late: [0x0000000000063000-0x000000000008efff] efi_free_boot_services+0x14b/0x23b
> [    8.815793] __memblock_free_late: [0x0000000000010000-0x0000000000013fff] efi_free_boot_services+0x14b/0x23b


In commit 6f599d84231fd27, we call crash_reserve_low_1M() to lock the
whole low 1M area if crashkernel is specified in kernel cmdline.
But earlier efi_reserve_boot_services() invokation will break the
intention of the whole low 1M reserving. In efi_reserve_boot_services(),
if any memory under low 1M hasn't been reserved, it will call
memblock_reserve() to reserve it and leave it to
efi_free_boot_services() to free.

Hi Lianbo,

Please correct me if I am wrong or anything is missed. IIUC, can we move
efi_reserve_boot_services() after reserve_real_mode() to fix this bug?
Or move reserve_real_mode() before efi_reserve_boot_services() since
those real mode regions are all under 1M? Assume efi boot code/data
won't rely on low 1M area any more at this moment.

Thanks
Baoquan

> 
> Do not release sub-1MB memory regions even though they are reserved by
> EFI boot services, so that always reserve all sub-1MB memory regions when
> the crashkernel option is specified.
> 
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
>  arch/x86/platform/efi/quirks.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> index 67d93a243c35..637f932c4fd4 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -18,6 +18,7 @@
>  #include <asm/cpu_device_id.h>
>  #include <asm/realmode.h>
>  #include <asm/reboot.h>
> +#include <asm/cmdline.h>
>  
>  #define EFI_MIN_RESERVE 5120
>  
> @@ -303,6 +304,19 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size)
>   */
>  static __init bool can_free_region(u64 start, u64 size)
>  {
> +	/*
> +	 * Some sub-1MB memory regions may be reserved by EFI boot
> +	 * services, and these memory regions will be released later
> +	 * in the efi_free_boot_services().
> +	 *
> +	 * Do not release sub-1MB memory regions even though they are
> +	 * reserved by EFI boot services, because, always reserve all
> +	 * sub-1MB memory when the crashkernel option is specified.
> +	 */
> +	if (cmdline_find_option(boot_command_line, "crashkernel", NULL, 0) > 0
> +		&& (start + size < (1<<20)))
> +		return false;
> +
>  	if (start + size > __pa_symbol(_text) && start <= __pa_symbol(_end))
>  		return false;
>  
> -- 
> 2.17.1
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
