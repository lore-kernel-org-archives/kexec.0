Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
MIME-Version: 1.0
References: <1589251566-32126-1-git-send-email-pkushwaha@marvell.com>
 <20200518155545.GO32394@willie-the-truck>
In-Reply-To: <20200518155545.GO32394@willie-the-truck>
From: Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Date: Tue, 19 May 2020 08:24:21 +0530
Message-ID: <CAJ2QiJLMKckbuAqJutAi_zUQqqaK5Mg_u5Q=gg-POSvmk8cT9g@mail.gmail.com>
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

Sorry, I replied 1:1. Now replying with mailing list

On Mon, May 18, 2020 at 9:25 PM Will Deacon <will@kernel.org> wrote:
>
> On Mon, May 11, 2020 at 07:46:06PM -0700, Prabhakar Kushwaha wrote:
> > An SMMU Stream table is created by the primary kernel. This table is
> > used by the SMMU to perform address translations for device-originated
> > transactions. Any crash (if happened) launches the kdump kernel which
> > re-creates the SMMU Stream table. New transactions will be translated
> > via this new table.
> >
> > There are scenarios, where devices are still having old pending
> > transactions (configured in the primary kernel). These transactions
> > come in-between Stream table creation and device-driver probe.
> > As new stream table does not have entry for older transactions,
> > it will be aborted by SMMU.
> >
> > Similar observations were found with PCIe-Intel 82576 Gigabit
> > Network card. It sends old Memory Read transaction in kdump kernel.
> > Transactions configured for older Stream table entries, that do not
> > exist any longer in the new table, will cause a PCIe Completion Abort.
> > Returned PCIe completion abort further leads to AER Errors from APEI
> > Generic Hardware Error Source (GHES) with completion timeout.
> > A network device hang is observed even after continuous
> > reset/recovery from driver, Hence device is no more usable.
> >
> > So, If we are in a kdump kernel try to copy SMMU Stream table from
> > primary/old kernel to preserve the mappings until the device driver
> > takes over.
> >
> > Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
> > ---
> > Changes for v2: Used memremap in-place of ioremap
> >
> > V2 patch has been sanity tested.
>
> Are you sure?
>

I tested v1 patch thoroughly.

After replacing ioremap with memremap, I tested 1-2 cycle per type.
I can test this patch thoroughly to check any kind of possible error.

> > V1 patch has been tested with
> > A) PCIe-Intel 82576 Gigabit Network card in following
> > configurations with "no AER error". Each iteration has
> > been tested on both Suse kdump rfs And default Centos distro rfs.
> >
> >  1)  with 2 level stream table
> >        ----------------------------------------------------
> >        SMMU               |  Normal Ping   | Flood Ping
> >        -----------------------------------------------------
> >        Default Operation  |  100 times     | 10 times
> >        -----------------------------------------------------
> >        IOMMU bypass       |  41 times      | 10 times
> >        -----------------------------------------------------
> >
> >  2)  with Linear stream table.
> >        -----------------------------------------------------
> >        SMMU               |  Normal Ping   | Flood Ping
> >        ------------------------------------------------------
> >        Default Operation  |  100 times     | 10 times
> >        ------------------------------------------------------
> >        IOMMU bypass       |  55 times      | 10 times
> >        -------------------------------------------------------
> >
> > B) This patch is also tested with Micron Technology Inc 9200 PRO NVMe
> > SSD card with 2 level stream table using "fio" in mixed read/write and
> > only read configurations. It is tested for both Default Operation and
> > IOMMU bypass mode for minimum 10 iterations across Centos kdump rfs and
> > default Centos ditstro rfs.
> >
> > This patch is not full proof solution. Issue can still come
> > from the point device is discovered and driver probe called.
> > This patch has reduced window of scenario from "SMMU Stream table
> > creation - device-driver" to "device discovery - device-driver".
> > Usually, device discovery to device-driver is very small time. So
> > the probability is very low.
> >
> > Note: device-discovery will overwrite existing stream table entries
> > with both SMMU stage as by-pass.
> >
> >
> >  drivers/iommu/arm-smmu-v3.c | 36 +++++++++++++++++++++++++++++++++++-
> >  1 file changed, 35 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> > index 82508730feb7..d492d92c2dd7 100644
> > --- a/drivers/iommu/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm-smmu-v3.c
> > @@ -1847,7 +1847,13 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
> >                       break;
> >               case STRTAB_STE_0_CFG_S1_TRANS:
> >               case STRTAB_STE_0_CFG_S2_TRANS:
> > -                     ste_live = true;
> > +                     /*
> > +                      * As kdump kernel copy STE table from previous
> > +                      * kernel. It still may have valid stream table entries.
> > +                      * Forcing entry as false to allow overwrite.
> > +                      */
> > +                     if (!is_kdump_kernel())
> > +                             ste_live = true;
> >                       break;
> >               case STRTAB_STE_0_CFG_ABORT:
> >                       BUG_ON(!disable_bypass);
> > @@ -3264,6 +3270,9 @@ static int arm_smmu_init_l1_strtab(struct arm_smmu_device *smmu)
> >               return -ENOMEM;
> >       }
> >
> > +     if (is_kdump_kernel())
> > +             return 0;
> > +
> >       for (i = 0; i < cfg->num_l1_ents; ++i) {
> >               arm_smmu_write_strtab_l1_desc(strtab, &cfg->l1_desc[i]);
> >               strtab += STRTAB_L1_DESC_DWORDS << 3;
> > @@ -3272,6 +3281,23 @@ static int arm_smmu_init_l1_strtab(struct arm_smmu_device *smmu)
> >       return 0;
> >  }
> >
> > +static void arm_smmu_copy_table(struct arm_smmu_device *smmu,
> > +                            struct arm_smmu_strtab_cfg *cfg, u32 size)
> > +{
> > +     struct arm_smmu_strtab_cfg rdcfg;
> > +
> > +     rdcfg.strtab_dma = readq_relaxed(smmu->base + ARM_SMMU_STRTAB_BASE);
> > +     rdcfg.strtab_base_cfg = readq_relaxed(smmu->base
> > +                                           + ARM_SMMU_STRTAB_BASE_CFG);
> > +
> > +     rdcfg.strtab_dma &= STRTAB_BASE_ADDR_MASK;
> > +     rdcfg.strtab = memremap(rdcfg.strtab_dma, size, MEMREMAP_WB);
> > +
> > +     memcpy_fromio(cfg->strtab, rdcfg.strtab, size);
> > +

this need a fix. It should be memcpy.

> > +     cfg->strtab_base_cfg = rdcfg.strtab_base_cfg;
>
> Sorry, but this is unacceptable. These things were allocated by the DMA API
> so you can't just memcpy them around and hope for the best.
>

I was referring copy_context_table() in drivers/iommu/intel-iommu.c.
here i see usage of memremap and memcpy to copy older iommu table.
did I take wrong reference?

What kind of issue you are foreseeing in using memcpy(). May be we can
try to find a solution.

-pk

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
