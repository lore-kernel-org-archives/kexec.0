From: Baoquan He <bhe@redhat.com>
Date: Thu, 5 May 2022 11:00:19 +0800
Subject: [PATCH v22 5/9] arm64: kdump: Reimplement crashkernel=X
In-Reply-To: <YnGmCwaWkvCrJoU2@arm.com>
References: <Ymk34NsIFqUgfk3b@arm.com>
 <ae7211ad-e2ac-f5b1-5aa0-701802132e73@huawei.com>
 <YmlphvZVMsGfFksp@arm.com> <YmoMvV1wzHT5V1aw@MiWiFi-R3L-srv>
 <YmoPhvkXQFZQOcIO@MiWiFi-R3L-srv>
 <3fc41a94-4247-40f3-14e7-f11e3001ec33@huawei.com>
 <YmtaiJhwIgP6m2Sk@MiWiFi-R3L-srv>
 <a9c736a0-f2b3-5b8a-94d9-80742ccd2700@huawei.com>
 <23e2dcf4-4e9a-5298-d5d8-8761b0bbbe21@huawei.com>
 <YnGmCwaWkvCrJoU2@arm.com>
Message-ID: <YnM9w69l5dbE+k15@MiWiFi-R3L-srv>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

On 05/03/22 at 11:00pm, Catalin Marinas wrote:
> On Fri, Apr 29, 2022 at 04:25:37PM +0800, Leizhen (ThunderTown) wrote:
> > On 2022/4/29 16:02, Leizhen (ThunderTown) wrote:
> > > On 2022/4/29 11:24, Baoquan He wrote:
> > >> On 04/28/22 at 05:33pm, Leizhen (ThunderTown) wrote:
> > >>> On 2022/4/28 11:52, Baoquan He wrote:
> > >>>> On 04/28/22 at 11:40am, Baoquan He wrote:
> > >>>>> On 04/27/22 at 05:04pm, Catalin Marinas wrote:
> > >>>>>> There will be some difference as the 4G limit doesn't always hold for
> > >>>>>> arm64 (though it's true in most cases). Anyway, we can probably simplify
> > >>>>>> things a bit while following the documented behaviour:
> > >>>>>>
> > >>>>>> 	crashkernel=Y		- current behaviour within ZONE_DMA
> > >>>>>> 	crashkernel=Y,high	- allocate from above ZONE_DMA
> > >>>>>> 	crashkernel=Y,low	- allocate within ZONE_DMA
> [...]
> > >>>>> Sorry to interrupt. Seems the ,high ,low and fallback are main concerns
> > >>>>> about this version. And I have the same concerns about them which comes
> > >>>>> from below points:
> > >>>>> 1) we may need to take best effort to keep ,high, ,low behaviour
> > >>>>> consistent on all ARCHes. Otherwise user/admin may be confused when they
> > >>>>> deploy/configure kdump on different machines of different ARCHes in the
> > >>>>> same LAB. I think we should try to avoid the confusion.
> 
> I guess by all arches you mean just x86 here. Since the code is not
> generic, all arches do their own stuff.

Right. Since currently only x86 has crashkernel,high|low support. From
the distros and customer's point of view, we would like to see the same
feature has the same or similar behaviour. This will ease operation and
maintaining. E.g on the cloud platform, the base of it could be any
ARCH, x86, arm64. The inconsistent behaviour could cause confusion.
Certainly, the underlying implementation may be different.

Surely, if arm64 has its own manner because of reasons, we can
add document to note that.

> 
> > > OK, I plan to remove optimization, fallback and default low size, to follow the
> > > suggestion of Catalin first. But there's one minor point of contention.
> > > 
> > > 1)    Both "crashkernel=X,high" and "crashkernel=X,low" must be present.
> > > 2)    Both "crashkernel=X,high" and "crashkernel=X,low" are present.
> > >    or
> > >       Allow "crashkernel=X,high" to be present alone. Unlike x86, the default low size is zero.
> > > 
> > > I prefer 2), how about you?
> 
> (2) works for me as well. We keep these simple as "expert" options and
> allow crashkernel= to fall back to 'high' if not sufficient memory in
> ZONE_DMA. That would be a slight change from the current behaviour but,
> as Zhen Lei said, with the old tools it's just moving the error around,
> the crashkernel wouldn't be available in either case.
> 
> > >>>>> 2) Fallback behaviour is important to our distros. The reason is we will
> > >>>>> provide default value with crashkernel=xxxM along kernel of distros. In
> > >>>>> this case, we hope the reservation will succeed by all means. The ,high
> > >>>>> and ,low is an option if customer likes to take with expertise.
> 
> OK, that's good feedback.
> 
> So, to recap, IIUC you are fine with:
> 
> 	crashkernel=Y		- allocate within ZONE_DMA with fallback
> 				  above with a default in ZONE_DMA (like
> 				  x86, 256M or swiotlb size)
                                  
        Ack to this one. 


> 	crashkernel=Y,high	- allocate from above ZONE_DMA
                                  
        Not exactly. If there's only ZONE_DMA, crashkernel,high will
        be reserved in ZONE_DMA, and crashkernel,low will be ignored.
        Other than this, ack.

> 	crashkernel=Y,low	- allocate within ZONE_DMA

        Ack to this one.
> 
> 'crashkernel' overrides the high and low while the latter two can be
> passed independently.

        crashkernel=,high can be passed independently, then a crashkernel=,low
        is needed implicitly. If people don't want crashkernel=,low
        explicitly, crashkernel=0,low need be specified.

        An independent crashkernel=,low makes no sense. Crashkernel=,low
        should be paird with crashkernel=,high.
        
        My personal opinion according to the existed senmantics on x86.
        Otherwise, the guidance of crashkernel= |,high|,low reservation
        will be complicated to write.

> 
> > >>>>> After going through arm64 memory init code, I got below summary about
> > >>>>> arm64_dma_phys_limit which is the first zone's upper limit. I think we
> > >>>>> can make use of it to facilitate to simplify code.
> > >>>>> ================================================================================
> > >>>>>                         DMA                      DMA32                    NORMAL
> > >>>>> 1)Raspberry Pi4         0~1G                     3G~4G                    (above 4G)
> > >>>>> 2)Normal machine        0~4G                     0                        (above 4G)
> > >>>>> 3)Special machine       (above 4G)~MAX
> > >>>>> 4)No DMA|DMA32                                                            (above 4G)~MAX
> > >>>
> > >>> arm64_memblock_init()
> > >>> 	reserve_crashkernel()        ---------------   0a30c53573b0 ("arm64: mm: Move reserve_crashkernel() into mem_init()")
> > >> We don't need different code for this place of reservation as you are
> > >> doing in this patchset, since arm64_dma_phys_limit is initialized as 
> > >> below. In fact, in arm64_memblock_init(), we have made memblock ready,
> > >> we can initialize arm64_dma_phys_limit as memblock_end_of_DRAM(). And if
> > >> memblock_start_of_DRAM() is bigger than 4G, we possibly can call
> > >> reserve_crashkernel() here too.
> > > 
> > > Yes. Maybe all the devices in this environment are 64-bit. One way I
> > > know of allowing 32-bit devices to access high memory without SMMU
> > > is: Set a fixed value for the upper 32 bits. In this case, the DMA
> > > zone should be [phys_start, phys_start + 4G).
> 
> We decided that this case doesn't really exists for arm64 platforms (no
> need for special ZONE_DMA).
> 
> > I just read the message of commit 791ab8b2e3 ("arm64: Ignore any DMA
> > offsets in the max_zone_phys() calculation")
> > 
> >     Currently, the kernel assumes that if RAM starts above 32-bit (or
> >     zone_bits), there is still a ZONE_DMA/DMA32 at the bottom of the RAM and
> >     such constrained devices have a hardwired DMA offset. In practice, we
> >     haven't noticed any such hardware so let's assume that we can expand
> >     ZONE_DMA32 to the available memory if no RAM below 4GB. Similarly,
> >     ZONE_DMA is expanded to the 4GB limit if no RAM addressable by
> >     zone_bits.
> 
> I think the above log is slightly confusing. If the DRAM starts above
> 4G, ZONE_DMA goes to the end of DRAM. If the DRAM starts below 4G but
> above the zone_bits for ZONE_DMA as specified in DT/ACPI, it pushes
> ZONE_DMA to 4G. I don't remember why we did this last part, maybe in
> case we get incorrect firmware tables, otherwise we could have extended
> ZONE_DMA to end of DRAM.
> 
> Zhen Lei, if we agreed on the crashkernel behaviour, could you please
> post a series that does the above parsing allocation? Ignore the
> optimisations, we can look at them afterwards.
> 
> Thanks.
> 
> -- 
> Catalin
> 


