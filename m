Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from 8bytes.org ([85.214.48.195] helo=mail.8bytes.org)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1URgUg-0006Kd-GK
 for kexec@lists.infradead.org; Mon, 15 Apr 2013 10:18:40 +0000
Received: from localhost (localhost [127.0.0.1])
 by mail.8bytes.org (Postfix) with SMTP id 3351D12B07F
 for <kexec@lists.infradead.org>; Mon, 15 Apr 2013 12:18:30 +0200 (CEST)
Date: Mon, 15 Apr 2013 12:18:29 +0200
From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] intel-iommu: Synchronize gcmd value with global command
 register
Message-ID: <20130415101829.GP6858@8bytes.org>
References: <20130326144629.GB2727@8bytes.org>
 <51527D74.9080209@jp.fujitsu.com>
 <20130327103122.GK30540@8bytes.org> <51591EEE.60401@jp.fujitsu.com>
 <20130402140546.GA15687@8bytes.org>
 <515BD638.8070307@jp.fujitsu.com>
 <1364977479.28127.15.camel@i7.infradead.org>
 <20130405110616.GB6858@8bytes.org>
 <5164EEE6.8000707@jp.fujitsu.com> <516BC19D.4090303@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <516BC19D.4090303@jp.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Takao Indoh <indou.takao@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, iommu@lists.linux-foundation.org, dwmw2@infradead.org, linux-kernel@vger.kernel.org, tindoh@gmail.com

On Mon, Apr 15, 2013 at 06:00:13PM +0900, Takao Indoh wrote:
> On DMAR initialization during kdump boot, do you guys agree to change
> order like this?
> 
> Current order:
> (1) Disable translation
> (2) PCI initialization
> (3) Make pgtable and enable translation.
> 
> Order I'm proposing:
> (1) PCI initialization
> (2) Disable translation
> (3) Make pgtable and enable translation.

I think this should work. In fact, translation only needs to be disabled
while the IOMMU hardware is reprogrammed to the new data structures the
kdump kernel set up.

> As Joerg said, if we need to consider the case that kdump kernel is
> compiled without dma-remapping(CONFIG_INTEL_IOMMU is off?), I can update
> my patch to handle such a case properly by adding ifdef
> CONFIG_INTEL_IOMMU.

Thinking about it, this case is a bit more special. If the kdump kernel
has no IOMMU driver at all there is also no code to disable it. So
unless we want to force the kdump kernel to have the driver when the
first kernel had it, I think we also want some quirk (depending on
!CONFIG_INTEL_IOMMU) that disables translation at boot.

I know, its complicated :)


	Joerg



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
