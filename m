Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ys3CH-00080j-Ei
 for kexec@lists.infradead.org; Tue, 12 May 2015 05:57:42 +0000
Date: Tue, 12 May 2015 13:57:07 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v9 0/10] iommu/vt-d: Fix intel vt-d faults in kdump kernel
Message-ID: <20150512055707.GB29874@localhost.localdomain>
References: <1426743388-26908-1-git-send-email-zhen-hual@hp.com>
 <20150403084031.GF22579@dhcp-128-53.nay.redhat.com>
 <20150504110551.GD15736@8bytes.org>
 <20150507135600.GB4559@localhost.localdomain>
 <20150511101124.GG20611@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150511101124.GG20611@8bytes.org>
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

On 05/11/15 at 12:11pm, Joerg Roedel wrote:
> On Thu, May 07, 2015 at 09:56:00PM +0800, Dave Young wrote:
> > Joreg, I can not find the last reply from you, so just reply here about
> > my worries here.
> > 
> > I said that the patchset will cause more problems, let me explain about
> > it more here:
> > 
> > Suppose page table was corrupted, ie. original mapping iova1 -> page 1
> > it was changed to iova1 -> page 2 accidently while crash happening,
> > thus future dma will read/write page 2 instead page 1, right?
> 
> When the page-table is corrupted then it is a left-over from the old
> kernel. When the kdump kernel boots the situation can at least not get
> worse. For the page tables it is also hard to detect wrong mappings (if
> this would be possible the hardware could already do it), so any checks
> we could do there are of limited use anyway.

Joerg, since both of you guys do not think it is a problem I will object it 
any more though I still do not like reusing the old page tables. So let's
leave it as a future issue.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
