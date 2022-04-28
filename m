From: Baoquan He <bhe@redhat.com>
Date: Thu, 28 Apr 2022 11:40:45 +0800
Subject: [PATCH v22 5/9] arm64: kdump: Reimplement crashkernel=X
In-Reply-To: <YmlphvZVMsGfFksp@arm.com>
References: <20220414115720.1887-1-thunder.leizhen@huawei.com>
 <20220414115720.1887-6-thunder.leizhen@huawei.com>
 <YmgzxsrrMlCDYsWp@arm.com>
 <ee8daaa9-3258-e7e8-e5c4-c51dc9841580@huawei.com>
 <Ymk34NsIFqUgfk3b@arm.com>
 <ae7211ad-e2ac-f5b1-5aa0-701802132e73@huawei.com>
 <YmlphvZVMsGfFksp@arm.com>
Message-ID: <YmoMvV1wzHT5V1aw@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hi Catalin, Zhen Lei,

On 04/27/22 at 05:04pm, Catalin Marinas wrote:
> On Wed, Apr 27, 2022 at 09:49:20PM +0800, Leizhen (ThunderTown) wrote:
> > On 2022/4/27 20:32, Catalin Marinas wrote:
> > > I think one could always pass a default command line like:
> > > 
> > > 	crashkernel=1G,high crashkernel=128M,low
> > > 
> > > without much knowledge of the SoC memory layout.
> > 
> > Yes, that's what the end result is. The user specify crashkernel=128M,low
> > and the implementation ensure the 128M low memory is allocated from DMA zone.
> > We use arm64_dma_phys_limit as the upper limit for crash low memory.
> > 
> > +#define CRASH_ADDR_LOW_MAX             arm64_dma_phys_limit
> > +       unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
> > +       crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
> >                                                crash_base, crash_max);
> > 
> > > Another option is to only introduce crashkernel=Y,low and, when that is
> > > passed, crashkernel=Y can go above arm64_dma_phys_limit. We won't need a
> > > 'high' option at all:
> > > 
> > > 	crashkernel=1G				- all within ZONE_DMA
> > > 	crashkernel=1G crashkernel=128M,low	- 128M in ZONE_DMA
> > > 						  1G above ZONE_DMA
> > > 
> > > If ZONE_DMA is not present or it extends to the whole RAM, we can ignore
> > > the 'low' option.
> > 
> > I think although the code is hard to make generic, the interface is better to
> > be relatively uniform. A user might have to maintain both x86 and arm64, and
> > so on. It's not a good thing that the difference is too big.
> 
> There will be some difference as the 4G limit doesn't always hold for
> arm64 (though it's true in most cases). Anyway, we can probably simplify
> things a bit while following the documented behaviour:
> 
> 	crashkernel=Y		- current behaviour within ZONE_DMA
> 	crashkernel=Y,high	- allocate from above ZONE_DMA
> 	crashkernel=Y,low	- allocate within ZONE_DMA
> 
> There is no fallback from crashkernel=Y.
> 
> The question is whether we still want a default low allocation if
> crashkernel=Y,low is missing but 'high' is present. If we add this, I
> think we'd be consistent with kernel-parameters.txt for the 'low'
> description. A default 'low' is probably not that bad but I'm tempted to
> always mandate both 'high' and 'low'.

Sorry to interrupt. Seems the ,high ,low and fallback are main concerns
about this version. And I have the same concerns about them which comes
from below points:
1) we may need to take best effort to keep ,high, ,low behaviour
consistent on all ARCHes. Otherwise user/admin may be confused when they
deploy/configure kdump on different machines of different ARCHes in the
same LAB. I think we should try to avoid the confusion.
2) Fallback behaviour is important to our distros. The reason is we will
provide default value with crashkernel=xxxM along kernel of distros. In
this case, we hope the reservation will succeed by all means. The ,high
and ,low is an option if customer likes to take with expertise.

After going through arm64 memory init code, I got below summary about
arm64_dma_phys_limit which is the first zone's upper limit. I think we
can make use of it to facilitate to simplify code.
================================================================================
                        DMA                      DMA32                    NORMAL
1)Raspberry Pi4         0~1G                     3G~4G                    (above 4G)
2)Normal machine        0~4G                     0                        (above 4G)
3)Special machine       (above 4G)~MAX
4)No DMA|DMA32                                                            (above 4G)~MAX

-------------------------------------------
                      arm64_dma_phys_limit
1)Raspberry Pi4         1G                     
2)Normal machine        4G                     
3)Special machine       MAX
4)No DMA|DMA32          MAX

Note: 3)Special machine means the machine's starting physical address is above 4G.
WHile 4)No DMA|DMA32 means kernel w/o CONFIG_ZONE_DMA|DMA32, and has
IOMMU hardware supporting.
===================================================================================

I made a draft patch based on this patchset, please feel free to check and
see if it's OK, or anything missing or wrongly understood. I removed
reserve_crashkernel_high() and only keep reserve_crashkernel() and
reserve_crashkernel_low() as the v21 did.

Thanks
Baoquan


