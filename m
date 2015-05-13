Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YsShX-0007z2-Ic
 for kexec@lists.infradead.org; Wed, 13 May 2015 09:11:40 +0000
Date: Wed, 13 May 2015 17:10:59 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v11 06/10] iommu/vt-d: datatypes and functions used for
 kdump
Message-ID: <20150513091059.GF3736@dhcp-128-28.nay.redhat.com>
References: <1431337974-545-1-git-send-email-zhen-hual@hp.com>
 <1431337974-545-7-git-send-email-zhen-hual@hp.com>
 <20150513085609.GD3736@dhcp-128-28.nay.redhat.com>
 <55531231.6040506@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <55531231.6040506@hp.com>
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
To: "Li, ZhenHua" <zhen-hual@hp.com>
Cc: alex.williamson@redhat.com, indou.takao@jp.fujitsu.com, tom.vaden@hp.com, rwright@hp.com, dwmw2@infradead.org, joro@8bytes.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, jerry.hoemann@hp.com, iommu@lists.linux-foundation.org, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, linux-pci@vger.kernel.org, bhelgaas@google.com, billsumnerlinux@gmail.com, li.zhang6@hp.com, dyoung@redhat.com, vgoyal@redhat.com

On 05/13/15 at 04:58pm, Li, ZhenHua wrote:
> Hi Dave,
> 
> iommu->root_entry_old_virt is used to store the mapped old rta.
> iommu->root_entry_old_phys is used to store the physical address
> stored in registers.
> So we must not free/unmap iommu->root_entry_old_phys .

Oh, yes. I was mistaken on this. Thanks for telling.

> 
> Zhenhua
> On 05/13/2015 04:56 PM, Baoquan He wrote:
> >>+
> >>+	iommu->root_entry_old_phys = q & VTD_PAGE_MASK;
> >>+	if (!iommu->root_entry_old_phys) {
> >>+		pr_err("Could not read old root entry address.");
> >>+		return -1;
> >>+	}
> >>+
> >
> >I didn't find where you call iounmap to free mapping of
> >iommu->root_entry_old_phys. Am I missing anything?
> >
> >>+	iommu->root_entry_old_virt = ioremap_cache(iommu->root_entry_old_phys,
> >>+						VTD_PAGE_SIZE);
> >>+	if (!iommu->root_entry_old_virt) {
> >>+		pr_err("Could not map the old root entry.");
> >>+		return -ENOMEM;
> >>+	}
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
