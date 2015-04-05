Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YeZmo-0002np-Ep
 for kexec@lists.infradead.org; Sun, 05 Apr 2015 01:55:43 +0000
Date: Sun, 5 Apr 2015 09:54:53 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v9 0/10] iommu/vt-d: Fix intel vt-d faults in kdump kernel
Message-ID: <20150405015453.GB1562@dhcp-17-102.nay.redhat.com>
References: <1426743388-26908-1-git-send-email-zhen-hual@hp.com>
 <20150403084031.GF22579@dhcp-128-53.nay.redhat.com>
 <551E56F6.60503@hp.com>
 <20150403092111.GG22579@dhcp-128-53.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150403092111.GG22579@dhcp-128-53.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: alex.williamson@redhat.com, indou.takao@jp.fujitsu.com, tom.vaden@hp.com, rwright@hp.com, linux-pci@vger.kernel.org, joro@8bytes.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, jerry.hoemann@hp.com, iommu@lists.linux-foundation.org, "Li,
 ZhenHua" <zhen-hual@hp.com>, ddutile@redhat.com, doug.hatch@hp.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com, billsumnerlinux@gmail.com, li.zhang6@hp.com, dwmw2@infradead.org, vgoyal@redhat.com

On 04/03/15 at 05:21pm, Dave Young wrote:
> On 04/03/15 at 05:01pm, Li, ZhenHua wrote:
> > Hi Dave,
> > 
> > There may be some possibilities that the old iommu data is corrupted by
> > some other modules. Currently we do not have a better solution for the
> > dmar faults.
> > 
> > But I think when this happens, we need to fix the module that corrupted
> > the old iommu data. I once met a similar problem in normal kernel, the
> > queue used by the qi_* functions was written again by another module.
> > The fix was in that module, not in iommu module.
> 
> It is too late, there will be no chance to save vmcore then.
> 
> Also if it is possible to continue corrupt other area of oldmem because
> of using old iommu tables then it will cause more problems.
> 
> So I think the tables at least need some verifycation before being used.
> 

Yes, it's a good thinking anout this and verification is also an
interesting idea. kexec/kdump do a sha256 calculation on loaded kernel
and then verify this again when panic happens in purgatory. This checks
whether any code stomps into region reserved for kexec/kernel and corrupt
the loaded kernel.

If this is decided to do it should be an enhancement to current
patchset but not a approach change. Since this patchset is going very
close to point as maintainers expected maybe this can be merged firstly,
then think about enhancement. After all without this patchset vt-d often
raised error message, hung.

By the way I tested this patchset it works very well on my HP z420 work
station.

Thanks
Baoquan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
