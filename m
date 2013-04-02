Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from 8bytes.org ([2a01:238:4242:f000:64f:6c43:3523:e535]
 helo=mail.8bytes.org)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UN1qY-0002iH-CK
 for kexec@lists.infradead.org; Tue, 02 Apr 2013 14:05:59 +0000
Received: from localhost (localhost [127.0.0.1])
 by mail.8bytes.org (Postfix) with SMTP id C0EFA12AFF2
 for <kexec@lists.infradead.org>; Tue,  2 Apr 2013 16:05:48 +0200 (CEST)
Date: Tue, 2 Apr 2013 16:05:47 +0200
From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] intel-iommu: Synchronize gcmd value with global command
 register
Message-ID: <20130402140546.GA15687@8bytes.org>
References: <1363829556-2128-1-git-send-email-indou.takao@jp.fujitsu.com>
 <20130326144629.GB2727@8bytes.org>
 <51527D74.9080209@jp.fujitsu.com>
 <20130327103122.GK30540@8bytes.org> <51591EEE.60401@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51591EEE.60401@jp.fujitsu.com>
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
To: Takao Indoh <indou.takao@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, iommu@lists.linux-foundation.org, dwmw2@infradead.org, linux-kernel@vger.kernel.org

On Mon, Apr 01, 2013 at 02:45:18PM +0900, Takao Indoh wrote:
> <Current flow on kdump boot>
> enable_IR
>   intel_enable_irq_remapping
>     iommu_disable_irq_remapping  <== IRES/QIES/TES disabled here
>     dmar_disable_qi              <== do nothing
>     dmar_enable_qi               <== QIES enabled
>     intel_setup_irq_remapping    <== IRES enabled

But what we want to do here in the kdumo case is to disable translation
too, right? Because the former kernel might have translation and
irq-remapping enabled and the kdump kernel might be compiled without
support for dma-remapping. So if we don't disable translation here too
the kdump kernel is unable to do DMA.

I agree that disabling translation should be a bit more explicit instead
of the current code.


	Joerg



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
