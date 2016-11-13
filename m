Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c5n0x-0000z6-5C
 for kexec@lists.infradead.org; Sun, 13 Nov 2016 05:07:35 +0000
Date: Sun, 13 Nov 2016 13:07:06 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v6 0/9] Fix kdump faults on system with amd iommu
Message-ID: <20161113050706.GA19995@x1>
References: <1476963440-23039-1-git-send-email-bhe@redhat.com>
 <20161110115218.GF9996@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20161110115218.GF9996@8bytes.org>
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

On 11/10/16 at 12:52pm, Joerg Roedel wrote:
> Hi Baoquan,
> 
> thanks for working on this, really appreciated!
> 
> On Thu, Oct 20, 2016 at 07:37:11PM +0800, Baoquan He wrote:
> > This is v6 post. 
> > 
> > The principle of the fix is similar to intel iommu. Just defer the assignment
> > of device to domain to device driver init. But there's difference than
> > intel iommu. AMD iommu create protection domain and assign device to
> > domain in iommu driver init stage. So in this patchset I just allow the
> > assignment of device to domain in software level, but defer updating the
> > domain info, especially the pte_root to dev table entry to device driver
> > init stage.
> 
> I recently talked with the IOMMU guys from AMD about whether it is safe
> to update the device-table pointer while the iommu is enabled. It turns
> out that device-table pointer update is split up into two 32bit writes
> in the IOMMU hardware. So updating it while the IOMMU is enabled could
> have some nasty side effects.
> 
> The only way to work around this is to allocate the device-table
> below 4GB, but that needs more low-mem then in the kdump kernel. So some
> adjustments are needed there too. Anyway, can you add that to your
> patch-set?

Yes, sure. Seems this is the only way to work around the 64bit address
being split up into two times of 32bit writes into IOMMU hardware risk.

I guess we need add a GFP_DMA32 flag when allocate pages for
amd_iommu_dev_table in kdump kernel. And better add a note in kdump.txt.
I have been told on some big advanced servers they don't need low mem
reseved at all with the help of hardware iommu. Now server with amd
iommu hardware have to be exceptional.

Thanks
Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
