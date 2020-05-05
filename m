Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH] iommu: arm-smmu-v3: Copy SMMU table for kdump kernel
References: <1588694360-11114-1-git-send-email-pkushwaha@marvell.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <a8b2da83-eb6f-b928-718d-921a2d0abef3@arm.com>
Date: Tue, 5 May 2020 17:37:35 +0100
MIME-Version: 1.0
In-Reply-To: <1588694360-11114-1-git-send-email-pkushwaha@marvell.com>
Content-Language: en-GB
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Prabhakar Kushwaha <pkushwaha@marvell.com>, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, maz@kernel.org, will@kernel.org
Cc: bhsharma@redhat.com, helgaas@kernel.org, gkulkarni@marvell.com, prabhakar.pkin@gmail.com

[ fixed Will's address... ]

On 2020-05-05 4:59 pm, Prabhakar Kushwaha wrote:
> An SMMU Stream table is created by the primary kernel. This table is
> used by the SMMU to perform address translations for device-originated
> transactions. Any crash (if happened) launches the kdump kernel which
> re-creates the SMMU Stream table. New transactions will be translated
> via this new table.
> 
> There are scenarios, where devices are still having old pending
> transactions (configured in the primary kernel). These transactions
> come in-between Stream table creation and device-driver probe.
> As new stream table does not have entry for older transactions,
> it will be aborted by SMMU.
> 
> Similar observations were found with PCIe-Intel 82576 Gigabit
> Network card. It sends old Memory Read transaction in kdump kernel.
> Transactions configured for older Stream table entries, that do not
> exist any longer in the new table, will cause a PCIe Completion Abort.
> Returned PCIe completion abort further leads to AER Errors from APEI
> Generic Hardware Error Source (GHES) with completion timeout.
> A network device hang is observed even after continuous
> reset/recovery from driver, Hence device is no more usable.
> 
> So, If we are in a kdump kernel try to copy SMMU Stream table from
> primary/old kernel to preserve the mappings until the device driver
> takes over.

What about the context descriptors and pagetables that the old stream 
table points to - can you trust that those are still present and correct 
and not going to kill your device?

> Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
> ---
> This patch has been tested with
> A) PCIe-Intel 82576 Gigabit Network card in following
> configurations with "no AER error". Each iteration has
> been tested on both Suse kdump rfs And default Centos distro rfs.
> 
>   1)  with 2 level stream table
>         ----------------------------------------------------
>         SMMU               |  Normal Ping   | Flood Ping
>         -----------------------------------------------------
>         Default Operation  |  100 times     | 10 times
>         -----------------------------------------------------
>         IOMMU bypass       |  41 times      | 10 times
>         -----------------------------------------------------
> 
>   2)  with Linear stream table.
>         -----------------------------------------------------
>         SMMU               |  Normal Ping   | Flood Ping
>         ------------------------------------------------------
>         Default Operation  |  100 times     | 10 times
>         ------------------------------------------------------
>         IOMMU bypass       |  55 times      | 10 times
>         -------------------------------------------------------
> 
> B) This patch is also tested with Micron Technology Inc 9200 PRO NVMe
> SSD card with 2 level stream table using "fio" in mixed read/write and
> only read configurations. It is tested for both Default Operation and
> IOMMU bypass mode for minimum 10 iterations across Centos kdump rfs and
> default Centos ditstro rfs.
> 
> This patch is not full proof solution. Issue can still come
> from the point device is discovered and driver probe called.
> This patch has reduced window of scenario from "SMMU Stream table
> creation - device-driver" to "device discovery - device-driver".
> Usually, device discovery to device-driver is very small time. So
> the probability is very low.
> 
> Note: device-discovery will overwrite existing stream table entries
> with both SMMU stage as by-pass.

...which if there *is* ongoing DMA to addresses from previous virtual 
mappings, stands just as much chance of killing the device and/or 
corrupting the kdump kernel when it starts hitting random bits of the 
physical address map.

>   drivers/iommu/arm-smmu-v3.c | 36 +++++++++++++++++++++++++++++++++++-
>   1 file changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 82508730feb7..64d1b925932d 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -1847,7 +1847,13 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>   			break;
>   		case STRTAB_STE_0_CFG_S1_TRANS:
>   		case STRTAB_STE_0_CFG_S2_TRANS:
> -			ste_live = true;
> +			/*
> +			 * As kdump kernel copy STE table from previous
> +			 * kernel. It still may have valid stream table entries.
> +			 * Forcing entry as false to allow overwrite.
> +			 */
> +			if (!is_kdump_kernel())
> +				ste_live = true;
>   			break;
>   		case STRTAB_STE_0_CFG_ABORT:
>   			BUG_ON(!disable_bypass);
> @@ -3264,6 +3270,9 @@ static int arm_smmu_init_l1_strtab(struct arm_smmu_device *smmu)
>   		return -ENOMEM;
>   	}
>   
> +	if (is_kdump_kernel())
> +		return 0;
> +
>   	for (i = 0; i < cfg->num_l1_ents; ++i) {
>   		arm_smmu_write_strtab_l1_desc(strtab, &cfg->l1_desc[i]);
>   		strtab += STRTAB_L1_DESC_DWORDS << 3;
> @@ -3272,6 +3281,23 @@ static int arm_smmu_init_l1_strtab(struct arm_smmu_device *smmu)
>   	return 0;
>   }
>   
> +static void arm_smmu_copy_table(struct arm_smmu_device *smmu,
> +			       struct arm_smmu_strtab_cfg *cfg, u32 size)
> +{
> +	struct arm_smmu_strtab_cfg rdcfg;
> +
> +	rdcfg.strtab_dma = readq_relaxed(smmu->base + ARM_SMMU_STRTAB_BASE);
> +	rdcfg.strtab_base_cfg = readq_relaxed(smmu->base
> +					      + ARM_SMMU_STRTAB_BASE_CFG);
> +
> +	rdcfg.strtab_dma &= STRTAB_BASE_ADDR_MASK;
> +	rdcfg.strtab = ioremap(rdcfg.strtab_dma, size);

ioremap? The old table is probably in RAM and previously mapped with 
some Normal memory attribute, and may well be cached. This pretty much 
guarantees mismatched attributes, at which point who knows what you'll 
actually read?

Frankly, I'm going to say we already support a way to completely 
preserve the previous SMMU configuration in a kdump kernel if users 
really want to. Can you guess what that is?

Robin.

> +	memcpy_fromio(cfg->strtab, rdcfg.strtab, size);
> +
> +	cfg->strtab_base_cfg = rdcfg.strtab_base_cfg;
> +}
> +
>   static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
>   {
>   	void *strtab;
> @@ -3307,6 +3333,9 @@ static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
>   	reg |= FIELD_PREP(STRTAB_BASE_CFG_SPLIT, STRTAB_SPLIT);
>   	cfg->strtab_base_cfg = reg;
>   
> +	if (is_kdump_kernel())
> +		arm_smmu_copy_table(smmu, cfg, l1size);
> +
>   	return arm_smmu_init_l1_strtab(smmu);
>   }
>   
> @@ -3334,6 +3363,11 @@ static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
>   	reg |= FIELD_PREP(STRTAB_BASE_CFG_LOG2SIZE, smmu->sid_bits);
>   	cfg->strtab_base_cfg = reg;
>   
> +	if (is_kdump_kernel()) {
> +		arm_smmu_copy_table(smmu, cfg, size);
> +		return 0;
> +	}
> +
>   	arm_smmu_init_bypass_stes(strtab, cfg->num_l1_ents);
>   	return 0;
>   }
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
