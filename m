Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZktGF-0008Gl-1n
 for kexec@lists.infradead.org; Sat, 10 Oct 2015 12:28:27 +0000
Date: Sat, 10 Oct 2015 20:28:03 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 07/10] iommu/amd: copy old dev tables and do not touch
 dev tables
Message-ID: <20151010122803.GB31787@dhcp-16-116.nay.redhat.com>
References: <1443076656-31776-1-git-send-email-bhe@redhat.com>
 <1443076656-31776-8-git-send-email-bhe@redhat.com>
 <20150929160808.GO3036@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150929160808.GO3036@8bytes.org>
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
Cc: iommu@lists.linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On 09/29/15 at 06:08pm, Joerg Roedel wrote:
> On Thu, Sep 24, 2015 at 02:37:33PM +0800, Baoquan He wrote:
> > +		 if ( !translation_pre_enabled() ) {
> > +			iommu_disable(iommu);
> > +			iommu_init_flags(iommu);
> > +			iommu_set_device_table(iommu);
> > +			iommu_enable_command_buffer(iommu);
> > +			iommu_enable_event_buffer(iommu);
> > +			iommu_set_exclusion_range(iommu);
> > +			iommu_enable(iommu);
> > +			iommu_flush_all_caches(iommu);
> > +		} else {
> > +			copy_dev_tables();
> > +			copy_command_buffer();
> > +			copy_event_buffer();
> > +		}
> 
> Hmm, this leaves the old device-table in place and removes flushing the
> iommu-caches in kdump kernel, right?


Yeah, that's what I thought at that time. no iommu-caches flushing will
cause the timer bug I mentioned in cover letter. Later I added
iommu_flush_dte(iommu, devid) if the related amd_iommu_dev_table[devid]
need be copied, then timer interupt bug disappeared.

static void copy_dev_tables(void)
{
        u64 entry;
        u32 lo, hi;
        phys_addr_t old_devtb_phys;
        struct dev_table_entry *old_devtb;
        struct amd_iommu *iommu;
        u16 dom_id;
        u32 devid;
        //memset(amd_iommu_dev_table,0, dev_table_size);


        for_each_iommu(iommu) {
                iommu->cmd_buf_size &= ~(CMD_BUFFER_UNINITIALIZED);
                lo = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET);
                hi = readl(iommu->mmio_base + MMIO_DEV_TABLE_OFFSET + 4);
                entry = (((u64) hi) << 32) + lo;
                old_devtb_phys = entry & PAGE_MASK;
                old_devtb = ioremap_cache(old_devtb_phys, dev_table_size);
                for (devid = 0; devid <= amd_iommu_last_bdf; ++devid) {
                //for (devid = iommu->first_device; devid <=
                //iommu->last_device; ++devid) {
                        amd_iommu_dev_table[devid] = old_devtb[devid];
                        dom_id = amd_iommu_dev_table[devid].data[1] & DEV_DOMID_MASK;
                        if (!dom_id)
                                continue;
                        copy_irq_table(devid);
                        __set_bit(dom_id, amd_iommu_pd_alloc_bitmap);
                        iommu_flush_dte(iommu, devid);
                }
                iounmap(old_devtb);
                iommu_completion_wait(iommu);
        }
}
> 
> 
> 	Joerg
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
