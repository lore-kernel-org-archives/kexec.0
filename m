Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hFteV-0001dR-B2
 for kexec@lists.infradead.org; Mon, 15 Apr 2019 04:55:33 +0000
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x3F4nJ3A086128
 for <kexec@lists.infradead.org>; Mon, 15 Apr 2019 00:55:29 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2rvhgfvch1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 15 Apr 2019 00:55:29 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <rppt@linux.ibm.com>;
 Mon, 15 Apr 2019 05:55:27 +0100
Date: Mon, 15 Apr 2019 07:55:18 +0300
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v3 3/4] arm64: kdump: support more than one crash kernel
 regions
References: <20190409102819.121335-1-chenzhou10@huawei.com>
 <20190409102819.121335-4-chenzhou10@huawei.com>
 <20190414121315.GD20947@rapoport-lnx>
 <b43e586c-219c-2911-c8c8-ba66ff7ce926@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b43e586c-219c-2911-c8c8-ba66ff7ce926@huawei.com>
Message-Id: <20190415045518.GA6167@rapoport-lnx>
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
Cc: wangkefeng.wang@huawei.com, horms@verge.net.au, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, takahiro.akashi@linaro.org, mingo@redhat.com, bp@alien8.de, ebiederm@xmission.com, kexec@lists.infradead.org, tglx@linutronix.de, akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org

On Mon, Apr 15, 2019 at 10:27:30AM +0800, Chen Zhou wrote:
> Hi Mike,
> 
> On 2019/4/14 20:13, Mike Rapoport wrote:
> > Hi,
> > 
> > On Tue, Apr 09, 2019 at 06:28:18PM +0800, Chen Zhou wrote:
> >> After commit (arm64: kdump: support reserving crashkernel above 4G),
> >> there may be two crash kernel regions, one is below 4G, the other is
> >> above 4G.
> >>
> >> Crash dump kernel reads more than one crash kernel regions via a dtb
> >> property under node /chosen,
> >> linux,usable-memory-range = <BASE1 SIZE1 [BASE2 SIZE2]>
> > 
> > Somehow I've missed that previously, but how is this supposed to work on
> > EFI systems?
> 
> Whatever the way in which the systems work, there is FDT pointer(__fdt_pointer)
> in arm64 kernel and file /sys/firmware/fdt will be created in late_initcall.
> 
> Kexec-tools read and update file /sys/firmware/fdt in EFI systems to support kdump to
> boot capture kernel.
> 
> For supporting more than one crash kernel regions, kexec-tools make changes accordingly.
> Details are in below:
> http://lists.infradead.org/pipermail/kexec/2019-April/022792.html
 
Thanks for the clarification!

> Thanks,
> Chen Zhou
> 
> >  
> >> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> >> ---
> >>  arch/arm64/mm/init.c     | 66 ++++++++++++++++++++++++++++++++++++++++--------
> >>  include/linux/memblock.h |  6 +++++
> >>  mm/memblock.c            |  7 ++---
> >>  3 files changed, 66 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> >> index 3bebddf..0f18665 100644
> >> --- a/arch/arm64/mm/init.c
> >> +++ b/arch/arm64/mm/init.c
> >> @@ -65,6 +65,11 @@ phys_addr_t arm64_dma_phys_limit __ro_after_init;
> >>  
> >>  #ifdef CONFIG_KEXEC_CORE
> >>  
> >> +/* at most two crash kernel regions, low_region and high_region */
> >> +#define CRASH_MAX_USABLE_RANGES	2
> >> +#define LOW_REGION_IDX			0
> >> +#define HIGH_REGION_IDX			1
> >> +
> >>  /*
> >>   * reserve_crashkernel() - reserves memory for crash kernel
> >>   *
> >> @@ -297,8 +302,8 @@ static int __init early_init_dt_scan_usablemem(unsigned long node,
> >>  		const char *uname, int depth, void *data)
> >>  {
> >>  	struct memblock_region *usablemem = data;
> >> -	const __be32 *reg;
> >> -	int len;
> >> +	const __be32 *reg, *endp;
> >> +	int len, nr = 0;
> >>  
> >>  	if (depth != 1 || strcmp(uname, "chosen") != 0)
> >>  		return 0;
> >> @@ -307,22 +312,63 @@ static int __init early_init_dt_scan_usablemem(unsigned long node,
> >>  	if (!reg || (len < (dt_root_addr_cells + dt_root_size_cells)))
> >>  		return 1;
> >>  
> >> -	usablemem->base = dt_mem_next_cell(dt_root_addr_cells, &reg);
> >> -	usablemem->size = dt_mem_next_cell(dt_root_size_cells, &reg);
> >> +	endp = reg + (len / sizeof(__be32));
> >> +	while ((endp - reg) >= (dt_root_addr_cells + dt_root_size_cells)) {
> >> +		usablemem[nr].base = dt_mem_next_cell(dt_root_addr_cells, &reg);
> >> +		usablemem[nr].size = dt_mem_next_cell(dt_root_size_cells, &reg);
> >> +
> >> +		if (++nr >= CRASH_MAX_USABLE_RANGES)
> >> +			break;
> >> +	}
> >>  
> >>  	return 1;
> >>  }
> >>  
> >>  static void __init fdt_enforce_memory_region(void)
> >>  {
> >> -	struct memblock_region reg = {
> >> -		.size = 0,
> >> -	};
> >> +	int i, cnt = 0;
> >> +	struct memblock_region regs[CRASH_MAX_USABLE_RANGES];
> >> +
> >> +	memset(regs, 0, sizeof(regs));
> >> +	of_scan_flat_dt(early_init_dt_scan_usablemem, regs);
> >> +
> >> +	for (i = 0; i < CRASH_MAX_USABLE_RANGES; i++)
> >> +		if (regs[i].size)
> >> +			cnt++;
> >> +		else
> >> +			break;
> >> +
> >> +	if (cnt - 1 == LOW_REGION_IDX)
> >> +		memblock_cap_memory_range(regs[LOW_REGION_IDX].base,
> >> +				regs[LOW_REGION_IDX].size);
> >> +	else if (cnt - 1 == HIGH_REGION_IDX) {
> >> +		/*
> >> +		 * Two crash kernel regions, cap the memory range
> >> +		 * [regs[LOW_REGION_IDX].base, regs[HIGH_REGION_IDX].end]
> >> +		 * and then remove the memory range in the middle.
> >> +		 */
> >> +		int start_rgn, end_rgn, i, ret;
> >> +		phys_addr_t mid_base, mid_size;
> >> +
> >> +		mid_base = regs[LOW_REGION_IDX].base + regs[LOW_REGION_IDX].size;
> >> +		mid_size = regs[HIGH_REGION_IDX].base - mid_base;
> >> +		ret = memblock_isolate_range(&memblock.memory, mid_base,
> >> +				mid_size, &start_rgn, &end_rgn);
> >>  
> >> -	of_scan_flat_dt(early_init_dt_scan_usablemem, &reg);
> >> +		if (ret)
> >> +			return;
> >>  
> >> -	if (reg.size)
> >> -		memblock_cap_memory_range(reg.base, reg.size);
> >> +		memblock_cap_memory_range(regs[LOW_REGION_IDX].base,
> >> +				regs[HIGH_REGION_IDX].base -
> >> +				regs[LOW_REGION_IDX].base +
> >> +				regs[HIGH_REGION_IDX].size);
> >> +		for (i = end_rgn - 1; i >= start_rgn; i--) {
> >> +			if (!memblock_is_nomap(&memblock.memory.regions[i]))
> >> +				memblock_remove_region(&memblock.memory, i);
> >> +		}
> >> +		memblock_remove_range(&memblock.reserved, mid_base,
> >> +				mid_base + mid_size);
> >> +	}
> >>  }
> >>  
> >>  void __init arm64_memblock_init(void)
> >> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> >> index 294d5d8..787d252 100644
> >> --- a/include/linux/memblock.h
> >> +++ b/include/linux/memblock.h
> >> @@ -110,9 +110,15 @@ void memblock_discard(void);
> >>  
> >>  phys_addr_t memblock_find_in_range(phys_addr_t start, phys_addr_t end,
> >>  				   phys_addr_t size, phys_addr_t align);
> >> +void memblock_remove_region(struct memblock_type *type, unsigned long r);
> >>  void memblock_allow_resize(void);
> >>  int memblock_add_node(phys_addr_t base, phys_addr_t size, int nid);
> >>  int memblock_add(phys_addr_t base, phys_addr_t size);
> >> +int memblock_isolate_range(struct memblock_type *type,
> >> +					phys_addr_t base, phys_addr_t size,
> >> +					int *start_rgn, int *end_rgn);
> >> +int memblock_remove_range(struct memblock_type *type,
> >> +					phys_addr_t base, phys_addr_t size);
> >>  int memblock_remove(phys_addr_t base, phys_addr_t size);
> >>  int memblock_free(phys_addr_t base, phys_addr_t size);
> >>  int memblock_reserve(phys_addr_t base, phys_addr_t size);
> >> diff --git a/mm/memblock.c b/mm/memblock.c
> >> index e7665cf..1846e2d 100644
> >> --- a/mm/memblock.c
> >> +++ b/mm/memblock.c
> >> @@ -357,7 +357,8 @@ phys_addr_t __init_memblock memblock_find_in_range(phys_addr_t start,
> >>  	return ret;
> >>  }
> >>  
> >> -static void __init_memblock memblock_remove_region(struct memblock_type *type, unsigned long r)
> >> +void __init_memblock memblock_remove_region(struct memblock_type *type,
> >> +					unsigned long r)
> >>  {
> >>  	type->total_size -= type->regions[r].size;
> >>  	memmove(&type->regions[r], &type->regions[r + 1],
> >> @@ -724,7 +725,7 @@ int __init_memblock memblock_add(phys_addr_t base, phys_addr_t size)
> >>   * Return:
> >>   * 0 on success, -errno on failure.
> >>   */
> >> -static int __init_memblock memblock_isolate_range(struct memblock_type *type,
> >> +int __init_memblock memblock_isolate_range(struct memblock_type *type,
> >>  					phys_addr_t base, phys_addr_t size,
> >>  					int *start_rgn, int *end_rgn)
> >>  {
> >> @@ -784,7 +785,7 @@ static int __init_memblock memblock_isolate_range(struct memblock_type *type,
> >>  	return 0;
> >>  }
> >>  
> >> -static int __init_memblock memblock_remove_range(struct memblock_type *type,
> >> +int __init_memblock memblock_remove_range(struct memblock_type *type,
> >>  					  phys_addr_t base, phys_addr_t size)
> >>  {
> >>  	int start_rgn, end_rgn;
> >> -- 
> >> 2.7.4
> >>
> > 
> 

-- 
Sincerely yours,
Mike.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
