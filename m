Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
MIME-Version: 1.0
References: <1589251566-32126-1-git-send-email-pkushwaha@marvell.com>
 <20200518155545.GO32394@willie-the-truck>
 <CAJ2QiJLMKckbuAqJutAi_zUQqqaK5Mg_u5Q=gg-POSvmk8cT9g@mail.gmail.com>
 <20200521092311.GB5091@willie-the-truck>
In-Reply-To: <20200521092311.GB5091@willie-the-truck>
From: Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Date: Thu, 21 May 2020 16:52:02 +0530
Message-ID: <CAJ2QiJK4h=5abVdODWTYg8Loy0Hhnhm1HrBzAM3bZXKtGXYK+Q@mail.gmail.com>
Subject: Re: [PATCH][v2] iommu: arm-smmu-v3: Copy SMMU table for kdump kernel
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
To: Will Deacon <will@kernel.org>
Cc: Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>, Marc Zyngier <maz@kernel.org>, Bhupesh Sharma <bhsharma@redhat.com>, kexec mailing list <kexec@lists.infradead.org>, Bjorn Helgaas <helgaas@kernel.org>, Prabhakar Kushwaha <pkushwaha@marvell.com>, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi Will,


On Thu, May 21, 2020 at 2:53 PM Will Deacon <will@kernel.org> wrote:
>
> On Tue, May 19, 2020 at 08:24:21AM +0530, Prabhakar Kushwaha wrote:
> > On Mon, May 18, 2020 at 9:25 PM Will Deacon <will@kernel.org> wrote:
> > > On Mon, May 11, 2020 at 07:46:06PM -0700, Prabhakar Kushwaha wrote:
> > > > @@ -3272,6 +3281,23 @@ static int arm_smmu_init_l1_strtab(struct arm_smmu_device *smmu)
> > > >       return 0;
> > > >  }
> > > >
> > > > +static void arm_smmu_copy_table(struct arm_smmu_device *smmu,
> > > > +                            struct arm_smmu_strtab_cfg *cfg, u32 size)
> > > > +{
> > > > +     struct arm_smmu_strtab_cfg rdcfg;
> > > > +
> > > > +     rdcfg.strtab_dma = readq_relaxed(smmu->base + ARM_SMMU_STRTAB_BASE);
> > > > +     rdcfg.strtab_base_cfg = readq_relaxed(smmu->base
> > > > +                                           + ARM_SMMU_STRTAB_BASE_CFG);
> > > > +
> > > > +     rdcfg.strtab_dma &= STRTAB_BASE_ADDR_MASK;
> > > > +     rdcfg.strtab = memremap(rdcfg.strtab_dma, size, MEMREMAP_WB);
> > > > +
> > > > +     memcpy_fromio(cfg->strtab, rdcfg.strtab, size);
> > > > +
> >
> > this need a fix. It should be memcpy.
> >
> > > > +     cfg->strtab_base_cfg = rdcfg.strtab_base_cfg;
> > >
> > > Sorry, but this is unacceptable. These things were allocated by the DMA API
> > > so you can't just memcpy them around and hope for the best.
> > >
> >
> > I was referring copy_context_table() in drivers/iommu/intel-iommu.c.
> > here i see usage of memremap and memcpy to copy older iommu table.
> > did I take wrong reference?
> >
> > What kind of issue you are foreseeing in using memcpy(). May be we can
> > try to find a solution.
>
> Well the thing might not be cache-coherent to start with...
>

Thanks for telling possible issue area.  Let me try to explain why
this should not be an issue.

kdump kernel runs from reserved memory space defined during the boot
of first kernel. kdump does not touch memory of the previous kernel.
So no page has been created in kdump kernel  and  there should not be
any data/attribute/coherency issue from MMU point of view .

During SMMU probe functions,  dmem_alloc_coherent() will be used
allocate new memory (part of existing flow).
This patch copy STE or first level descriptor to *this* memory, after
mapping physical address using memremap().
It just copy everything  so there should not be any issue related to
attribute/content.

Yes, copying  done after mapping it as MEMREMAP_WB. if you want I can
use it as MEMREMAP_WT

In both scenario and also considering intel driver is doing similar
things. I feel there should not be an issue.

Please let me know if you have any other view to solve this problem. I
will be more than happy to explore it.

thanks
--pk

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
