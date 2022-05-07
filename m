From: Catalin Marinas <catalin.marinas@arm.com>
Date: Sat, 7 May 2022 19:50:21 +0100
Subject: [PATCH v24 3/6] arm64: kdump: Reimplement crashkernel=X
In-Reply-To: <20220506231032.GA122876@MiWiFi-R3L-srv>
References: <20220506114402.365-1-thunder.leizhen@huawei.com>
 <20220506114402.365-4-thunder.leizhen@huawei.com>
 <20220506231032.GA122876@MiWiFi-R3L-srv>
Message-ID: <Yna/bc2nDb7PT40r@arm.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On Sat, May 07, 2022 at 07:10:32AM +0800, Baoquan He wrote:
> On 05/06/22 at 07:43pm, Zhen Lei wrote:
> ......  
> > @@ -118,8 +162,7 @@ static void __init reserve_crashkernel(void)
> >  	if (crash_base)
> >  		crash_max = crash_base + crash_size;
> >  
> > -	/* Current arm64 boot protocol requires 2MB alignment */
> > -	crash_base = memblock_phys_alloc_range(crash_size, SZ_2M,
> > +	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> >  					       crash_base, crash_max);
> >  	if (!crash_base) {
> >  		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
> > @@ -127,6 +170,11 @@ static void __init reserve_crashkernel(void)
> >  		return;
> >  	}
> >  
> 
> There's corner case missed, e.g
> 1) ,high and ,low are specified, CONFIG_ZONE_DMA|DMA32 is not enabled;
> 2) ,high and ,low are specified, the whole system memory is under 4G.

My view of ,low is that it should only used to override the default
ZONE_DMA allocation if that one is not suitable. If no ZONE_DMA exists
or everything is ZONE_DMA, ignore it altogether. That's a specialist
case for people that know more about the memory layout, otherwise
crashkernel=X works in most case with crashkernel=X,high as an
alternative to allow high allocation.

> I would suggest merging this series, Lei can add this corner case
> handling on top. Since this is a newly added support, we don't have
> to make it one step. Doing step by step can make reviewing easier.

I agree.

-- 
Catalin

