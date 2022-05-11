From: Baoquan He <bhe@redhat.com>
Date: Wed, 11 May 2022 17:06:51 +0800
Subject: [PATCH] arm64: kdump: Do not allocate crash low memory if not
 needed
In-Reply-To: <20220511032033.426-1-thunder.leizhen@huawei.com>
References: <20220511032033.426-1-thunder.leizhen@huawei.com>
Message-ID: <Ynt8qwG9WoiW4L+o@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 05/11/22 at 11:20am, Zhen Lei wrote:
> When "crashkernel=X,high" is specified, the specified "crashkernel=Y,low"
> memory is not required in the following corner cases:
> 1. If both CONFIG_ZONE_DMA and CONFIG_ZONE_DMA32 are disabled, it means
>    that the devices can access any memory.
> 2. If the system memory is small, the crash high memory may be allocated
>    from the DMA zones. If that happens, there's no need to allocate
>    another crash low memory because there's already one.
> 
> Add condition '(crash_base >= CRASH_ADDR_LOW_MAX)' to determine whether
> the 'high' memory is allocated above DMA zones. Note: when both
> CONFIG_ZONE_DMA and CONFIG_ZONE_DMA32 are disabled, the entire physical
> memory is DMA accessible, CRASH_ADDR_LOW_MAX equals 'PHYS_MASK + 1'.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 5 +++--
>  arch/arm64/mm/init.c                            | 3 ++-
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f6ff55840751a78..1b543c3109f4851 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -823,7 +823,7 @@
>  			low memory is needed to make sure DMA buffers for 32-bit
>  			devices won't run out. Kernel would try to allocate
>  			at least 256M below 4G automatically.
> -			This one let user to specify own low range under 4G
> +			This one lets the user specify own low range under 4G
                        ~ This one let users specify own low range ...

Other than this nitpick, LGTM

Acked-by: Baoquan He <bhe@redhat.com>

>  			for second kernel instead.
>  			0: to disable low allocation.
>  			It will be ignored when crashkernel=X,high is not used
> @@ -832,7 +832,8 @@
>  			[KNL, ARM64] range in low memory.
>  			This one lets the user specify a low range in the
>  			DMA zone for the crash dump kernel.
> -			It will be ignored when crashkernel=X,high is not used.
> +			It will be ignored when crashkernel=X,high is not used
> +			or memory reserved is located in the DMA zones.
>  
>  	cryptomgr.notests
>  			[KNL] Disable crypto self-tests
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 18ba66c90991ea0..ac510fb6a2c0189 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -170,7 +170,8 @@ static void __init reserve_crashkernel(void)
>  		return;
>  	}
>  
> -	if (crash_low_size && reserve_crashkernel_low(crash_low_size)) {
> +	if ((crash_base >= CRASH_ADDR_LOW_MAX) &&
> +	     crash_low_size && reserve_crashkernel_low(crash_low_size)) {
>  		memblock_phys_free(crash_base, crash_size);
>  		return;
>  	}
> -- 
> 2.25.1
> 


