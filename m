Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KWgSC-0001PL-PH
	for kexec@lists.infradead.org; Fri, 22 Aug 2008 23:54:05 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <1218138156.3361.386.camel@amd.troyhebe>
	<20080808014024.GB3911@redhat.com>
	<1218750773.3361.425.camel@amd.troyhebe>
	<20080815131359.GA10208@redhat.com>
	<1219081942.3361.436.camel@amd.troyhebe>
	<20080819134748.GC18972@redhat.com>
	<m1wsib3raq.fsf@frodo.ebiederm.org>
	<1219442751.3361.459.camel@amd.troyhebe>
Date: Fri, 22 Aug 2008 16:48:10 -0700
In-Reply-To: <1219442751.3361.459.camel@amd.troyhebe> (Bob Montgomery's
	message of "Fri, 22 Aug 2008 16:05:51 -0600")
Message-ID: <m18wuofw79.fsf@frodo.ebiederm.org>
MIME-Version: 1.0
Subject: Re: Trying to test my gart/iommu vmcore problem on RH
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
To: bob.montgomery@hp.com
Cc: "Heber, Troy" <troy.heber@hp.com>, "Loftin, Terry" <terry.loftin@hp.com>, Kexec Mailing List <kexec@lists.infradead.org>, Vivek Goyal <vgoyal@redhat.com>


Hmm.  Thinking about this we actually have 2 problems.
- Communication about what is going on.
- How to handle an iommu in the event of a crash dump scenario.

The current solution is to ignore the iommu, and use swiotlb.  This
solution does not look like it will work for future iommus.

The original plan (and it still sounds like a good one) was to reserve
a section of the iommu (as we do for the physical memory).  So we
could have addresses that are only used for the crash dump kernel.  Then
have the crash dump kernel just use that section of the iommu.

Either we need to do that or we need to disable the iommu, before we
use swiotlb.

The problem is we can not reliably kill on-going DMA transactions 
at the time of a kernel panic, and likely doing so would greatly
decrease our kernel reliability.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
