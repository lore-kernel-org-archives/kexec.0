Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Mon, 8 Jun 2020 12:41:23 +0100
From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH][v2] iommu: arm-smmu-v3: Copy SMMU table for kdump kernel
Message-ID: <20200608114122.GB3108@willie-the-truck>
References: <1589251566-32126-1-git-send-email-pkushwaha@marvell.com>
 <20200518155545.GO32394@willie-the-truck>
 <CAJ2QiJLMKckbuAqJutAi_zUQqqaK5Mg_u5Q=gg-POSvmk8cT9g@mail.gmail.com>
 <20200521092311.GB5091@willie-the-truck>
 <CAJ2QiJK4h=5abVdODWTYg8Loy0Hhnhm1HrBzAM3bZXKtGXYK+Q@mail.gmail.com>
 <20200601073957.GD8601@willie-the-truck>
 <CAJ2QiJ+-VV9bXbdfqHxeZgUiGBg_iMqBQcSH5cD_sfb-UQpQ6w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJ2QiJ+-VV9bXbdfqHxeZgUiGBg_iMqBQcSH5cD_sfb-UQpQ6w@mail.gmail.com>
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
To: Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Cc: Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>, Marc Zyngier <maz@kernel.org>, Bhupesh Sharma <bhsharma@redhat.com>, kexec mailing list <kexec@lists.infradead.org>, Bjorn Helgaas <helgaas@kernel.org>, Prabhakar Kushwaha <pkushwaha@marvell.com>, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Tue, Jun 02, 2020 at 07:34:47PM +0530, Prabhakar Kushwaha wrote:
> On Mon, Jun 1, 2020 at 1:10 PM Will Deacon <will@kernel.org> wrote:
> > On Thu, May 21, 2020 at 04:52:02PM +0530, Prabhakar Kushwaha wrote:
> > > On Thu, May 21, 2020 at 2:53 PM Will Deacon <will@kernel.org> wrote:
> > > > On Tue, May 19, 2020 at 08:24:21AM +0530, Prabhakar Kushwaha wrote:
> > > > > What kind of issue you are foreseeing in using memcpy(). May be we can
> > > > > try to find a solution.
> > > >
> > > > Well the thing might not be cache-coherent to start with...
> > > >
> > >
> > > Thanks for telling possible issue area.  Let me try to explain why
> > > this should not be an issue.
> > >
> > > kdump kernel runs from reserved memory space defined during the boot
> > > of first kernel. kdump does not touch memory of the previous kernel.
> > > So no page has been created in kdump kernel  and  there should not be
> > > any data/attribute/coherency issue from MMU point of view .
> >
> > Then how does this work?:
> >
> >         rdcfg.strtab = memremap(rdcfg.strtab_dma, size, MEMREMAP_WB);
> >
> > You're explicitly asking for a write-back mapping.
> >
> 
> As i mentioned earlier, I will replace it with MEMREMAP_WT to make
> sure data is written into the memory.
> 
> Please note, this memmap is temporary for copying older SMMU table to
> cfg->strtab.
> Here, cfg->strtab & cfg->strtab_dma allocated via dmam_alloc_coherent
> during SMMU probe.
> 
> 
> > > During SMMU probe functions,  dmem_alloc_coherent() will be used
> > > allocate new memory (part of existing flow).
> > > This patch copy STE or first level descriptor to *this* memory, after
> > > mapping physical address using memremap().
> > > It just copy everything  so there should not be any issue related to
> > > attribute/content.
> > >
> > > Yes, copying  done after mapping it as MEMREMAP_WB. if you want I can
> > > use it as MEMREMAP_WT
> >
> > You need to take into account whether or not the device is coherent, and the
> > DMA API is designed to handle that for you. But even then, this is fragile
> > as hell because you end up having to infer the hardware configuration
> > from the device to understand the size and format of the data structures.
> > If the crashkernel isn't identical to the host kernel (in terms of kconfig,
> > driver version, firmware tables, cmdline etc) then this is very likely to
> > go wrong.
> 
> There are two possible scenarios for mismatched kdump kernel
> 1.  kdump kernel does not have the devices' driver
> 2.  kdump kernel have the different variation/configuration of driver
> 
> This patch create temporary SMMU table entries which are overwritten
> by driver-probe.

What exactly does this achieve, given that you don't copy the context
descriptors or the page tables?

> Driver's probe will overwrite SMMU entries based on its new
> requirement (size, format, data structures etc).
> 
> for "1",  As  no device driver,  SMMU entry will remain there.
> Means no-one looking for the copied content (even if device continued
> to perform DMA).
> 
> About coherency between Cores and Memory(DMA).
> At the time of crash:  Only one CPU is allowed to remain continue,
> rest are stopped.
> __crash_kexec --> machine_crash_shutdown --> crash_smp_send_stop()
> 
> The active CPU is used to boot kdump kernel. hence none of the CPUs is
> looking for data copied by DMA.
> Coherency issue should not be there.

I'm talking about coherency between the SMMU and the CPU, so I don't think
the number of CPUs is relevant.

> please let me know your view.

It still seems extremely fragile to me, so I continue to think that this
is the wrong approach.

Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
