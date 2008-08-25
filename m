Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KXbvS-0002dl-11
	for kexec@lists.infradead.org; Mon, 25 Aug 2008 13:16:06 +0000
Date: Mon, 25 Aug 2008 09:16:03 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: Trying to test my gart/iommu vmcore problem on RH
Message-ID: <20080825131603.GB18914@redhat.com>
References: <1218138156.3361.386.camel@amd.troyhebe>
	<20080808014024.GB3911@redhat.com>
	<1218750773.3361.425.camel@amd.troyhebe>
	<20080815131359.GA10208@redhat.com>
	<1219081942.3361.436.camel@amd.troyhebe>
	<20080819134748.GC18972@redhat.com>
	<m1wsib3raq.fsf@frodo.ebiederm.org>
	<1219442751.3361.459.camel@amd.troyhebe>
	<m18wuofw79.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m18wuofw79.fsf@frodo.ebiederm.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "Heber, Troy" <troy.heber@hp.com>, Kexec Mailing List <kexec@lists.infradead.org>, "Loftin,
	Terry" <terry.loftin@hp.com>, bob.montgomery@hp.com

On Fri, Aug 22, 2008 at 04:48:10PM -0700, Eric W. Biederman wrote:
> 
> Hmm.  Thinking about this we actually have 2 problems.
> - Communication about what is going on.
> - How to handle an iommu in the event of a crash dump scenario.
> 
> The current solution is to ignore the iommu, and use swiotlb.  This
> solution does not look like it will work for future iommus.
> 

Does setting up of swiotlb require iommu to be disabled in second kernel?
IOW, can swiotlb work reliably given the fact that iommu is active and
there are some active mappings (as created by first kernel).

I am thinking is there a possibility that I set a DMA using swiotlb and the
physical address can overlap with IO address setup in IOMMU and that DMA might
go to a different buffer altogether.

> The original plan (and it still sounds like a good one) was to reserve
> a section of the iommu (as we do for the physical memory).  So we
> could have addresses that are only used for the crash dump kernel.  Then
> have the crash dump kernel just use that section of the iommu.
> 

This would also require that second kernel keeps using first kernel's
iommu settings/tables and not try to initialize the iommu freshly.

One patch from Chandru is now mainline which seems to be solving the issue
for calgary IOMMU. He seems to be re-using first kernel's iommu tables
in second kernel hence avoiding re-initializing iommu and avoiding MCE.

git commit 95b68dec0d52c7b8fea3698b3938cf3ab936436b

This patch has the risk that second kernel might not find any free entries
to setup DMA and that's why reserving a section of iommu will help.

> Either we need to do that or we need to disable the iommu, before we
> use swiotlb.
> 

I tought disabling iommu was not an option as it leads to MCE if there is
a DMA going on.

> The problem is we can not reliably kill on-going DMA transactions 
> at the time of a kernel panic, and likely doing so would greatly
> decrease our kernel reliability.

May be re-using iommu tables in second kernel along with reserving some
entries for kdump is the way to go..

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
