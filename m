Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YpoQs-0003dg-35
 for kexec@lists.infradead.org; Wed, 06 May 2015 01:47:30 +0000
Date: Wed, 6 May 2015 09:46:49 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v9 0/10] iommu/vt-d: Fix intel vt-d faults in kdump kernel
Message-ID: <20150506014649.GA14065@dhcp-128-4.nay.redhat.com>
References: <1426743388-26908-1-git-send-email-zhen-hual@hp.com>
 <20150403084031.GF22579@dhcp-128-53.nay.redhat.com>
 <20150504110551.GD15736@8bytes.org>
 <20150505060931.GB31063@dhcp-128-4.nay.redhat.com>
 <20150505152343.GP15736@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150505152343.GP15736@8bytes.org>
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
Cc: alex.williamson@redhat.com, indou.takao@jp.fujitsu.com, bhe@redhat.com, tom.vaden@hp.com, rwright@hp.com, linux-pci@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, jerry.hoemann@hp.com, iommu@lists.linux-foundation.org, "Li,
 Zhen-Hua" <zhen-hual@hp.com>, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com, billsumnerlinux@gmail.com, li.zhang6@hp.com, dwmw2@infradead.org, vgoyal@redhat.com

On 05/05/15 at 05:23pm, Joerg Roedel wrote:
> On Tue, May 05, 2015 at 02:09:31PM +0800, Dave Young wrote:
> > I agree that we can do nothing with the old corrupted data, but I worry
> > about the future corruption after using the old corrupted data. I wonder
> > if we can mark all the oldmem as readonly so that we can lower the risk.
> > Is it resonable?
> 
> Do you mean marking it read-only for the devices? That will very likely
> cause DMAR faults, re-introducing the problem this patch-set tries to
> fix.

I means to block all dma write to oldmem, I believe it will cause DMA error.
But all other DMA reading requests will continue and work. This will avoid
future possible corruption. It will solve half of the problem at least?

For the original problem, the key issue is dmar faults cause kdump kernel
hang so that vmcore can not be saved. I do not know the reason why it hangs
I think it is acceptable if kdump kernel boot ok with some dma errors..

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
