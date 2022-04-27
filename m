From: Catalin Marinas <catalin.marinas@arm.com>
Date: Wed, 27 Apr 2022 17:04:22 +0100
Subject: [PATCH v22 5/9] arm64: kdump: Reimplement crashkernel=X
In-Reply-To: <ae7211ad-e2ac-f5b1-5aa0-701802132e73@huawei.com>
References: <20220414115720.1887-1-thunder.leizhen@huawei.com>
 <20220414115720.1887-6-thunder.leizhen@huawei.com>
 <YmgzxsrrMlCDYsWp@arm.com>
 <ee8daaa9-3258-e7e8-e5c4-c51dc9841580@huawei.com>
 <Ymk34NsIFqUgfk3b@arm.com>
 <ae7211ad-e2ac-f5b1-5aa0-701802132e73@huawei.com>
Message-ID: <YmlphvZVMsGfFksp@arm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Wed, Apr 27, 2022 at 09:49:20PM +0800, Leizhen (ThunderTown) wrote:
> On 2022/4/27 20:32, Catalin Marinas wrote:
> > I think one could always pass a default command line like:
> > 
> > 	crashkernel=1G,high crashkernel=128M,low
> > 
> > without much knowledge of the SoC memory layout.
> 
> Yes, that's what the end result is. The user specify crashkernel=128M,low
> and the implementation ensure the 128M low memory is allocated from DMA zone.
> We use arm64_dma_phys_limit as the upper limit for crash low memory.
> 
> +#define CRASH_ADDR_LOW_MAX             arm64_dma_phys_limit
> +       unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
> +       crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
>                                                crash_base, crash_max);
> 
> > Another option is to only introduce crashkernel=Y,low and, when that is
> > passed, crashkernel=Y can go above arm64_dma_phys_limit. We won't need a
> > 'high' option at all:
> > 
> > 	crashkernel=1G				- all within ZONE_DMA
> > 	crashkernel=1G crashkernel=128M,low	- 128M in ZONE_DMA
> > 						  1G above ZONE_DMA
> > 
> > If ZONE_DMA is not present or it extends to the whole RAM, we can ignore
> > the 'low' option.
> 
> I think although the code is hard to make generic, the interface is better to
> be relatively uniform. A user might have to maintain both x86 and arm64, and
> so on. It's not a good thing that the difference is too big.

There will be some difference as the 4G limit doesn't always hold for
arm64 (though it's true in most cases). Anyway, we can probably simplify
things a bit while following the documented behaviour:

	crashkernel=Y		- current behaviour within ZONE_DMA
	crashkernel=Y,high	- allocate from above ZONE_DMA
	crashkernel=Y,low	- allocate within ZONE_DMA

There is no fallback from crashkernel=Y.

The question is whether we still want a default low allocation if
crashkernel=Y,low is missing but 'high' is present. If we add this, I
think we'd be consistent with kernel-parameters.txt for the 'low'
description. A default 'low' is probably not that bad but I'm tempted to
always mandate both 'high' and 'low'.

-- 
Catalin

