Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c6wGU-00070k-JY
 for kexec@lists.infradead.org; Wed, 16 Nov 2016 09:12:23 +0000
Subject: Re: [PATCH] iommu/vt-d: Flush old iotlb for kdump when the device
 gets context mapped
References: <1479286950-21885-1-git-send-email-xlpang@redhat.com>
From: Xunlei Pang <xpang@redhat.com>
Message-ID: <582C232F.6080205@redhat.com>
Date: Wed, 16 Nov 2016 17:13:19 +0800
MIME-Version: 1.0
In-Reply-To: <1479286950-21885-1-git-send-email-xlpang@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: xlpang@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Xunlei Pang <xlpang@redhat.com>, iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>
Cc: Don Brace <don.brace@microsemi.com>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Myron Stowe <myron.stowe@redhat.com>, David Woodhouse <dwmw2@infradead.org>

Ccing David
On 2016/11/16 at 17:02, Xunlei Pang wrote:
> We met the DMAR fault both on hpsa P420i and P421 SmartArray controllers
> under kdump, it can be steadily reproduced on several different machines,
> the dmesg log is like:
> HP HPSA Driver (v 3.4.16-0)
> hpsa 0000:02:00.0: using doorbell to reset controller
> hpsa 0000:02:00.0: board ready after hard reset.
> hpsa 0000:02:00.0: Waiting for controller to respond to no-op
> DMAR: Setting identity map for device 0000:02:00.0 [0xe8000 - 0xe8fff]
> DMAR: Setting identity map for device 0000:02:00.0 [0xf4000 - 0xf4fff]
> DMAR: Setting identity map for device 0000:02:00.0 [0xbdf6e000 - 0xbdf6efff]
> DMAR: Setting identity map for device 0000:02:00.0 [0xbdf6f000 - 0xbdf7efff]
> DMAR: Setting identity map for device 0000:02:00.0 [0xbdf7f000 - 0xbdf82fff]
> DMAR: Setting identity map for device 0000:02:00.0 [0xbdf83000 - 0xbdf84fff]
> DMAR: DRHD: handling fault status reg 2
> DMAR: [DMA Read] Request device [02:00.0] fault addr fffff000 [fault reason 06] PTE Read access is not set
> hpsa 0000:02:00.0: controller message 03:00 timed out
> hpsa 0000:02:00.0: no-op failed; re-trying
>
> After some debugging, we found that the corresponding pte entry value
> is correct, and the value of the iommu caching mode is 0, the fault is
> probably due to the old iotlb cache of the in-flight DMA.
>
> Thus need to flush the old iotlb after context mapping is setup for the
> device, where the device is supposed to finish reset at its driver probe
> stage and no in-flight DMA exists hereafter.
>
> With this patch, all our problematic machines can survive the kdump tests.
>
> CC: Myron Stowe <myron.stowe@redhat.com>
> CC: Don Brace <don.brace@microsemi.com>
> CC: Baoquan He <bhe@redhat.com>
> CC: Dave Young <dyoung@redhat.com>
> Tested-by: Joseph Szczypek <jszczype@redhat.com>
> Signed-off-by: Xunlei Pang <xlpang@redhat.com>
> ---
>  drivers/iommu/intel-iommu.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 3965e73..eb79288 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -2067,9 +2067,16 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
>  	 * It's a non-present to present mapping. If hardware doesn't cache
>  	 * non-present entry we only need to flush the write-buffer. If the
>  	 * _does_ cache non-present entries, then it does so in the special
> -	 * domain #0, which we have to flush:
> +	 * domain #0, which we have to flush.
> +	 *
> +	 * For kdump cases, present entries may be cached due to the in-flight
> +	 * DMA and copied old pgtable, but there is no unmapping behaviour for
> +	 * them, so we need an explicit iotlb flush for the newly-mapped device.
> +	 * For kdump, at this point, the device is supposed to finish reset at
> +	 * the driver probe stage, no in-flight DMA will exist, thus we do not
> +	 * need to worry about that anymore hereafter.
>  	 */
> -	if (cap_caching_mode(iommu->cap)) {
> +	if (is_kdump_kernel() || cap_caching_mode(iommu->cap)) {
>  		iommu->flush.flush_context(iommu, 0,
>  					   (((u16)bus) << 8) | devfn,
>  					   DMA_CCMD_MASK_NOBIT,


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
