Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yw0-f172.google.com ([209.85.161.172])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bahsp-0006A1-2X
 for kexec@lists.infradead.org; Fri, 19 Aug 2016 11:22:44 +0000
Received: by mail-yw0-f172.google.com with SMTP id u134so10769001ywg.3
 for <kexec@lists.infradead.org>; Fri, 19 Aug 2016 04:22:22 -0700 (PDT)
Date: Fri, 19 Aug 2016 16:52:17 +0530
From: Pratyush Anand <panand@redhat.com>
Subject: Re: [PATCH v24 5/9] arm64: kdump: add kdump support
Message-ID: <20160819112217.GB22221@localhost.localdomain>
References: <20160809015248.28414-2-takahiro.akashi@linaro.org>
 <20160809015615.28527-1-takahiro.akashi@linaro.org>
 <20160809015615.28527-3-takahiro.akashi@linaro.org>
 <57AB586D.3080900@arm.com> <20160818071547.GC20080@linaro.org>
 <20160819012651.GE20080@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160819012651.GE20080@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, James Morse <james.morse@arm.com>, catalin.marinas@arm.com, will.deacon@arm.com, geoff@infradead.org, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, mark.rutland@arm.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On 19/08/2016:10:26:52 AM, AKASHI Takahiro wrote:
> >From 740563e4a437f0d6ecf6e421c91433f9b8f19041 Mon Sep 17 00:00:00 2001
> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Date: Fri, 19 Aug 2016 09:57:52 +0900
> Subject: [PATCH] arm64: mark reserved memblock regions explicitly
> 
> ---
>  arch/arm64/kernel/setup.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 38eda13..38589b5 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -205,10 +205,15 @@ static void __init request_standard_resources(void)
>  
>  	for_each_memblock(memory, region) {
>  		res = alloc_bootmem_low(sizeof(*res));
> -		res->name  = "System RAM";
> +		if (memblock_is_nomap(region)) {
> +			res->name  = "reserved";
> +			res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
> +		} else {
> +			res->name  = "System RAM";
> +			res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
> +		}
>  		res->start = __pfn_to_phys(memblock_region_memory_base_pfn(region));
>  		res->end = __pfn_to_phys(memblock_region_memory_end_pfn(region)) - 1;
> -		res->flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
>  
>  		request_resource(&iomem_resource, res);


It will help kexec-tools to prevent copying  of any unnecessary data. I
think, then you also need to change phys_offset calculation in kexec-tools. That
should be start of either of first "reserved" or "System RAM" block.

~Pratyush

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
