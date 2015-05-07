Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YqMHv-0006Sv-Ut
 for kexec@lists.infradead.org; Thu, 07 May 2015 13:56:34 +0000
Date: Thu, 7 May 2015 21:56:00 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v9 0/10] iommu/vt-d: Fix intel vt-d faults in kdump kernel
Message-ID: <20150507135600.GB4559@localhost.localdomain>
References: <1426743388-26908-1-git-send-email-zhen-hual@hp.com>
 <20150403084031.GF22579@dhcp-128-53.nay.redhat.com>
 <20150504110551.GD15736@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150504110551.GD15736@8bytes.org>
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

On 05/04/15 at 01:05pm, Joerg Roedel wrote:
> On Fri, Apr 03, 2015 at 04:40:31PM +0800, Dave Young wrote:
> > Have not read all the patches, but I have a question, not sure this
> > has been answered before. Old memory is not reliable, what if the old
> > memory get corrupted before panic? Is it safe to continue using it in
> > 2nd kernel, I worry that it will cause problems.
> 
> Yes, the old memory could be corrupted, and there are more failure cases
> left which we have no way of handling yet (if iommu data structures are
> in kdump backup areas).
> 
> The question is what to do if we find some of the old data structures
> corrupted, hand how far should the tests go. Should we also check the
> page-tables, for example? I think if some of the data structures for a
> device are corrupted it probably already failed in the old kernel and
> things won't get worse in the new one.

Joreg, I can not find the last reply from you, so just reply here about
my worries here.

I said that the patchset will cause more problems, let me explain about
it more here:

Suppose page table was corrupted, ie. original mapping iova1 -> page 1
it was changed to iova1 -> page 2 accidently while crash happening,
thus future dma will read/write page 2 instead page 1, right?

so the behavior changes like:
originally, dmar faults happen, but kdump kernel may boot ok with these
faults, and vmcore can be saved.
with the patchset, dmar faults does not happen, dma translation will be
handled, but dma write could corrupt unrelevant memory.

This might be corner case, but who knows because kernel paniced we can
not assume old page table is right.

But seems you all think it is safe, but let us understand each other
first then go to a solution.

Today we talked with Zhenhua about the problem I think both of us are clear
about the problems. Just he think it can be left as future work.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
