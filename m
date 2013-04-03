Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UNHs8-0000tk-J8
 for kexec@lists.infradead.org; Wed, 03 Apr 2013 07:12:42 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 05EB83EE0BC
 for <kexec@lists.infradead.org>; Wed,  3 Apr 2013 16:12:32 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id DD04745DE5B
 for <kexec@lists.infradead.org>; Wed,  3 Apr 2013 16:12:31 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id C515A45DE59
 for <kexec@lists.infradead.org>; Wed,  3 Apr 2013 16:12:31 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id B1D4DE08009
 for <kexec@lists.infradead.org>; Wed,  3 Apr 2013 16:12:31 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 5F96DE08001
 for <kexec@lists.infradead.org>; Wed,  3 Apr 2013 16:12:31 +0900 (JST)
Message-ID: <515BD638.8070307@jp.fujitsu.com>
Date: Wed, 03 Apr 2013 16:11:52 +0900
From: Takao Indoh <indou.takao@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] intel-iommu: Synchronize gcmd value with global command
 register
References: <1363829556-2128-1-git-send-email-indou.takao@jp.fujitsu.com>
 <20130326144629.GB2727@8bytes.org> <51527D74.9080209@jp.fujitsu.com>
 <20130327103122.GK30540@8bytes.org> <51591EEE.60401@jp.fujitsu.com>
 <20130402140546.GA15687@8bytes.org>
In-Reply-To: <20130402140546.GA15687@8bytes.org>
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
To: joro@8bytes.org
Cc: kexec@lists.infradead.org, iommu@lists.linux-foundation.org, dwmw2@infradead.org, linux-kernel@vger.kernel.org

(2013/04/02 23:05), Joerg Roedel wrote:
> On Mon, Apr 01, 2013 at 02:45:18PM +0900, Takao Indoh wrote:
>> <Current flow on kdump boot>
>> enable_IR
>>    intel_enable_irq_remapping
>>      iommu_disable_irq_remapping  <== IRES/QIES/TES disabled here
>>      dmar_disable_qi              <== do nothing
>>      dmar_enable_qi               <== QIES enabled
>>      intel_setup_irq_remapping    <== IRES enabled
> 
> But what we want to do here in the kdumo case is to disable translation
> too, right? Because the former kernel might have translation and
> irq-remapping enabled and the kdump kernel might be compiled without
> support for dma-remapping. So if we don't disable translation here too
> the kdump kernel is unable to do DMA.

Yeah, you are right. I forgot such a case.

To be honest, I also expected the side effect of this patch. As I wrote
in the previous mail, I'm working on kdump problem with iommu, that is,
ongoing DMA causes DMAR fault in 2nd kernel and sometimes kdump fails
due to this fault. What we have to do is stopping DMA transaction
before DMA-remapping is disabled in 2nd kernel. To do this, we need to
reset devices before intel_enable_irq_remapping() is called, but it is
very difficult because struct pci_dev is not prepared in this stage.
After applying this patch, DMA-remapping is disabled in init_dmars where
struct pci_dev is ready, so it's easier to handle. For example we can
add pci quirk to reset devices.

So, disabling translation in 2nd kernel is necessary, and it's better if
we can do it after struct pci_dev is prepared. (after subsys_initcall?)
Any idea?

Thanks,
Takao Indoh

> 
> I agree that disabling translation should be a bit more explicit instead
> of the current code.
> 
> 
> 	Joerg
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
