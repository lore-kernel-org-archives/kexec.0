Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-sn1nam04on061f.outbound.protection.outlook.com
 ([2a01:111:f400:fe4c::61f]
 helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fVgBv-0007IR-OI
 for kexec@lists.infradead.org; Wed, 20 Jun 2018 16:42:45 +0000
Subject: Re: [PATCH 3/4 V3] Remap the device table of IOMMU in encrypted
 manner for kdump
References: <20180616082714.32035-1-lijiang@redhat.com>
 <20180616082714.32035-4-lijiang@redhat.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <60c6f00e-0eb3-d39c-6a1e-8a1dc1e095af@amd.com>
Date: Wed, 20 Jun 2018 11:42:16 -0500
MIME-Version: 1.0
In-Reply-To: <20180616082714.32035-4-lijiang@redhat.com>
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
To: Lianbo Jiang <lijiang@redhat.com>, linux-kernel@vger.kernel.org
Cc: dyoung@redhat.com, iommu@lists.linux-foundation.org, kexec@lists.infradead.org

On 6/16/2018 3:27 AM, Lianbo Jiang wrote:
> In kdump mode, it will copy the device table of IOMMU from the old
> device table, which is encrypted when SME is enabled in the first
> kernel. So we must remap it in encrypted manner in order to be
> automatically decrypted when we read.
> 
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
> Some changes:
> 1. add some comments
> 2. clean compile warning.
> 
>  drivers/iommu/amd_iommu_init.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index 904c575..a20af4c 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -889,11 +889,24 @@ static bool copy_device_table(void)
>  	}
>  
>  	old_devtb_phys = entry & PAGE_MASK;
> +
> +	/*
> +	 *  When sme enable in the first kernel, old_devtb_phys includes the
> +	 *  memory encryption mask(sme_me_mask), we must remove the memory
> +	 *  encryption mask to obtain the true physical address in kdump mode.
> +	 */
> +	if (mem_encrypt_active() && is_kdump_kernel())
> +		old_devtb_phys = __sme_clr(old_devtb_phys);
> +

You can probably just use "if (is_kdump_kernel())" here, since memory
encryption is either on in both the first and second kernel or off in
both the first and second kernel.  At which point __sme_clr() will do
the proper thing.

Actually, this needs to be done no matter what.  When doing either the
ioremap_encrypted() or the memremap(), the physical address should not
include the encryption bit/mask.

Thanks,
Tom

>  	if (old_devtb_phys >= 0x100000000ULL) {
>  		pr_err("The address of old device table is above 4G, not trustworthy!\n");
>  		return false;
>  	}
> -	old_devtb = memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);
> +	old_devtb = (mem_encrypt_active() && is_kdump_kernel())
> +		    ? (__force void *)ioremap_encrypted(old_devtb_phys,
> +							dev_table_size)
> +		    : memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);> +
>  	if (!old_devtb)
>  		return false;
>  
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
