Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH v2 1/4] arm64: export memblock_reserve()d regions via
 /proc/iomem
References: <20180619064424.6642-1-takahiro.akashi@linaro.org>
 <20180619064424.6642-2-takahiro.akashi@linaro.org>
From: Dave Kleikamp <dave.kleikamp@oracle.com>
Message-ID: <72307608-90e0-4842-edc1-d3b284782940@oracle.com>
Date: Tue, 19 Jun 2018 08:37:17 -0500
MIME-Version: 1.0
In-Reply-To: <20180619064424.6642-2-takahiro.akashi@linaro.org>
Content-Language: en-US
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>, catalin.marinas@arm.com, will.deacon@arm.com, akpm@linux-foundation.org, ard.biesheuvel@linaro.org
Cc: mark.rutland@arm.com, lorenzo.pieralisi@arm.com, graeme.gregory@linaro.org, al.stone@linaro.org, bhsharma@redhat.com, tbaicar@codeaurora.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, james.morse@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, dyoung@redhat.com, linux-arm-kernel@lists.infradead.org

On 06/19/2018 01:44 AM, AKASHI Takahiro wrote:

> +static int __init reserve_memblock_reserved_regions(void)
> +{
> +	phys_addr_t start, end, roundup_end = 0;
> +	struct resource *mem, *res;
> +	u64 i;
> +
> +	for_each_reserved_mem_region(i, &start, &end) {
> +		if (end <= roundup_end)
> +			continue; /* done already */
> +
> +		start = __pfn_to_phys(PFN_DOWN(start));
> +		end = __pfn_to_phys(PFN_UP(end)) - 1;
> +		roundup_end = end;
> +
> +		res = kzalloc(sizeof(*res), GFP_ATOMIC);
> +		if (WARN_ON(!res))
> +			return -ENOMEM;
> +		res->start = start;
> +		res->end = end;
> +		res->name  = "reserved";
> +		res->flags = IORESOURCE_MEM;
> +
> +		mem = request_resource_conflict(&iomem_resource, res);
> +		/*
> +		 * We expected memblock_reserve() regions to conflict with
> +		 * memory created by request_standard_resources().
> +		 */
> +		if (WARN_ON_ONCE(!mem))
> +			continue;
> +		kfree(res);

Why is kfree() after the conditional continue? This is a memory leak.

> +
> +		reserve_region_with_split(mem, start, end, "reserved");
> +	}
> +
> +	return 0;
> +}
> +arch_initcall(reserve_memblock_reserved_regions);
> +
>  u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
>  
>  void __init setup_arch(char **cmdline_p)
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
