Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jdNw6-00053U-BC
 for kexec@lists.infradead.org; Tue, 26 May 2020 00:59:20 +0000
Date: Tue, 26 May 2020 08:59:04 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v8 2/5] arm64: kdump: reserve crashkenel above 4G for
 crash dump kernel
Message-ID: <20200526005904.GE20045@MiWiFi-R3L-srv>
References: <20200521093805.64398-1-chenzhou10@huawei.com>
 <20200521093805.64398-3-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200521093805.64398-3-chenzhou10@huawei.com>
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
To: Chen Zhou <chenzhou10@huawei.com>
Cc: horms@verge.net.au, John.p.donnelly@oracle.com, arnd@arndb.de, will@kernel.org, devicetree@vger.kernel.org, catalin.marinas@arm.com, linux-doc@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, mingo@redhat.com, guohanjun@huawei.com, tglx@linutronix.de, pkushwaha@marvell.com, dyoung@redhat.com, linux-arm-kernel@lists.infradead.org

On 05/21/20 at 05:38pm, Chen Zhou wrote:
> Crashkernel=X tries to reserve memory for the crash dump kernel under
> 4G. If crashkernel=X,low is specified simultaneously, reserve spcified
> size low memory for crash kdump kernel devices firstly and then reserve
> memory above 4G.

Wondering why crashkernel=,high is not introduced to arm64 to be
consistent with x86_64, to make the behaviour be the same on all
architecutres. 

> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Tested-by: John Donnelly <John.p.donnelly@oracle.com>
> Tested-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
> ---
>  arch/arm64/kernel/setup.c |  8 +++++++-
>  arch/arm64/mm/init.c      | 31 +++++++++++++++++++++++++++++--
>  2 files changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 3fd2c11c09fc..a8487e4d3e5a 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -238,7 +238,13 @@ static void __init request_standard_resources(void)
>  		    kernel_data.end <= res->end)
>  			request_resource(res, &kernel_data);
>  #ifdef CONFIG_KEXEC_CORE
> -		/* Userspace will find "Crash kernel" region in /proc/iomem. */
> +		/*
> +		 * Userspace will find "Crash kernel" region in /proc/iomem.
> +		 * Note: the low region is renamed as Crash kernel (low).
> +		 */
> +		if (crashk_low_res.end && crashk_low_res.start >= res->start &&
> +				crashk_low_res.end <= res->end)
> +			request_resource(res, &crashk_low_res);
>  		if (crashk_res.end && crashk_res.start >= res->start &&
>  		    crashk_res.end <= res->end)
>  			request_resource(res, &crashk_res);
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index e42727e3568e..71498acf0cd8 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -81,6 +81,7 @@ static void __init reserve_crashkernel(void)
>  {
>  	unsigned long long crash_base, crash_size;
>  	int ret;
> +	phys_addr_t crash_max = arm64_dma32_phys_limit;
>  
>  	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
>  				&crash_size, &crash_base);
> @@ -88,12 +89,38 @@ static void __init reserve_crashkernel(void)
>  	if (ret || !crash_size)
>  		return;
>  
> +	ret = reserve_crashkernel_low();
> +	if (!ret && crashk_low_res.end) {
> +		/*
> +		 * If crashkernel=X,low specified, there may be two regions,
> +		 * we need to make some changes as follows:
> +		 *
> +		 * 1. rename the low region as "Crash kernel (low)"
> +		 * In order to distinct from the high region and make no effect
> +		 * to the use of existing kexec-tools, rename the low region as
> +		 * "Crash kernel (low)".
> +		 *
> +		 * 2. change the upper bound for crash memory
> +		 * Set MEMBLOCK_ALLOC_ACCESSIBLE upper bound for crash memory.
> +		 *
> +		 * 3. mark the low region as "nomap"
> +		 * The low region is intended to be used for crash dump kernel
> +		 * devices, just mark the low region as "nomap" simply.
> +		 */
> +		const char *rename = "Crash kernel (low)";
> +
> +		crashk_low_res.name = rename;
> +		crash_max = MEMBLOCK_ALLOC_ACCESSIBLE;
> +		memblock_mark_nomap(crashk_low_res.start,
> +				    resource_size(&crashk_low_res));
> +	}
> +
>  	crash_size = PAGE_ALIGN(crash_size);
>  
>  	if (crash_base == 0) {
>  		/* Current arm64 boot protocol requires 2MB alignment */
> -		crash_base = memblock_find_in_range(0, arm64_dma32_phys_limit,
> -				crash_size, SZ_2M);
> +		crash_base = memblock_find_in_range(0, crash_max, crash_size,
> +				SZ_2M);
>  		if (crash_base == 0) {
>  			pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
>  				crash_size);
> -- 
> 2.20.1
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
