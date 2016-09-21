Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bmeao-0005AY-Cp
 for kexec@lists.infradead.org; Wed, 21 Sep 2016 10:17:41 +0000
Date: Wed, 21 Sep 2016 18:17:09 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v5 4/8] iommu/amd: Add function copy_dev_tables
Message-ID: <20160921101709.GA13350@x1.redhat.com>
References: <1473951806-25511-1-git-send-email-bhe@redhat.com>
 <1473951806-25511-5-git-send-email-bhe@redhat.com>
 <20160920115804.GC3541@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160920115804.GC3541@8bytes.org>
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
To: Joerg Roedel <joro@8bytes.org>
Cc: kexec@lists.infradead.org, xlpang@redhat.com, linux-kernel@vger.kernel.org, Vincent.Wan@amd.com, iommu@lists.linux-foundation.org, dyoung@redhat.com

Hi Joerg,

Thanks for your reviewing and great suggestion!

On 09/20/16 at 01:58pm, Joerg Roedel wrote:
> Hi Baoquan,
> 
> On Thu, Sep 15, 2016 at 11:03:22PM +0800, Baoquan He wrote:
> > +static int copy_dev_tables(void)
> > +{
> > +	u64 entry;
> > +	u32 lo, hi, devid;
> > +	phys_addr_t old_devtb_phys;
> > +	struct dev_table_entry *old_devtb = NULL;
> > +	u16 dom_id, dte_v;
> > +	struct amd_iommu *iommu;
> > +	static int copied;
> 
> Please order this by line-length, longer lines first.

Will do.

> 
> > +        for_each_iommu(iommu) {
> > +		if (!translation_pre_enabled(iommu)) {
> > +			pr_err("IOMMU:%d is not pre-enabled!/n", iommu->index);
> > +			return -1;
> > +		}
> > +
> > +		if (copied)
> > +			continue;
> > +
> > +                lo = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET);
> > +                hi = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET + 4);
> > +                entry = (((u64) hi) << 32) + lo;
> > +                old_devtb_phys = entry & PAGE_MASK;
> > +                old_devtb = memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);
> > +		if (!old_devtb)
> > +			return -1;
> > +                for (devid = 0; devid <= amd_iommu_last_bdf; ++devid) {
> > +                        amd_iommu_dev_table[devid] = old_devtb[devid];
> > +                        dom_id = amd_iommu_dev_table[devid].data[1] & DEV_DOMID_MASK;
> > +			dte_v = amd_iommu_dev_table[devid].data[0] & DTE_FLAG_V;
> > +			if (!dte_v || !dom_id)
> > +				continue;
> > +                        __set_bit(dom_id, amd_iommu_pd_alloc_bitmap);
> > +                }
> > +		memunmap(old_devtb);
> > +		copied = 1;
> > +        }
> 
> This loop need more refinement and sanity checking code. I suggest using
> two loops and do the sanity checking in the first one. The sanity checks
> should do:
> 
> 	* Check whether all IOMMUs actually use the same device table
> 	  with the same size
> 
> 	* Verify that the size of the old device table is the expected
> 	  size.

Will do.

> 
> 	* Also sanity check the irq-remapping information and remapping
> 	  table sizes.

Will do. Since this need those irq DTE_IRQ_xxxx MACRO which is defined
in amd_iommu.c , I plan to move them into amd_iommu_types.h, and then do
irq-remapping. These can be made in another patch.

> 
> If any of these checks fail, just bail out of copying.
> 
> What is further needed it some more selection on what is copied from the
> old kernel. There is no need to copy all the GCR3 root-pointer
> information. If a device is set up with guest translations (DTE.GV=1),
> then don't copy that information but move the device over to an empty
> guest-cr3 table and handle the faults in the PPR log (which should just
> answer them with INVALID). After all these PPR faults are recoverable
> for the device and we should not allow the device to change old-kernels
> data when we don't have to.

The current fix is simplest and cleanest. Because the on-flight DMAs
continue transferring data since system crash, including guest
translations, we may not need to care about it and just let it continue
flying a little more time until device is reset. Since you have suggested,
I will try to make another patch for this issue, we can see the effect.

Thanks
Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
