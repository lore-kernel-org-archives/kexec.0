Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UNd2Y-0002hU-Gr
 for kexec@lists.infradead.org; Thu, 04 Apr 2013 05:48:52 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 2763F3EE0AE
 for <kexec@lists.infradead.org>; Thu,  4 Apr 2013 14:48:43 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 04D4645DEB6
 for <kexec@lists.infradead.org>; Thu,  4 Apr 2013 14:48:43 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id D817C45DEB5
 for <kexec@lists.infradead.org>; Thu,  4 Apr 2013 14:48:42 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id C959EE08001
 for <kexec@lists.infradead.org>; Thu,  4 Apr 2013 14:48:42 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 7F4891DB803B
 for <kexec@lists.infradead.org>; Thu,  4 Apr 2013 14:48:42 +0900 (JST)
Message-ID: <515D1429.40707@jp.fujitsu.com>
Date: Thu, 04 Apr 2013 14:48:25 +0900
From: Takao Indoh <indou.takao@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] intel-iommu: Synchronize gcmd value with global command
 register
References: <1363829556-2128-1-git-send-email-indou.takao@jp.fujitsu.com>
 <20130326144629.GB2727@8bytes.org> <51527D74.9080209@jp.fujitsu.com>
 <20130327103122.GK30540@8bytes.org> <51591EEE.60401@jp.fujitsu.com>
 <20130402140546.GA15687@8bytes.org> <515BD638.8070307@jp.fujitsu.com>
 <1364977479.28127.15.camel@i7.infradead.org>
In-Reply-To: <1364977479.28127.15.camel@i7.infradead.org>
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
To: dwmw2@infradead.org
Cc: joro@8bytes.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org

(2013/04/03 17:24), David Woodhouse wrote:
> On Wed, 2013-04-03 at 16:11 +0900, Takao Indoh wrote:
>> (2013/04/02 23:05), Joerg Roedel wrote:
>>> On Mon, Apr 01, 2013 at 02:45:18PM +0900, Takao Indoh wrote:
>>>> <Current flow on kdump boot>
>>>> enable_IR
>>>>     intel_enable_irq_remapping
>>>>       iommu_disable_irq_remapping  <== IRES/QIES/TES disabled here
>>>>       dmar_disable_qi              <== do nothing
>>>>       dmar_enable_qi               <== QIES enabled
>>>>       intel_setup_irq_remapping    <== IRES enabled
>>>
>>> But what we want to do here in the kdumo case is to disable translation
>>> too, right? Because the former kernel might have translation and
>>> irq-remapping enabled and the kdump kernel might be compiled without
>>> support for dma-remapping. So if we don't disable translation here too
>>> the kdump kernel is unable to do DMA.
>>
>> Yeah, you are right. I forgot such a case.
> 
> If you disable translation and there's some device still doing DMA, it's
> going to scribble over random areas of memory. You really want to have
> translation enabled and all the page tables *cleared*, during kexec. I
> think it's fair to insist that the secondary kernel should use the IOMMU
> if the first one did.
> 
>> To be honest, I also expected the side effect of this patch. As I wrote
>> in the previous mail, I'm working on kdump problem with iommu, that is,
>> ongoing DMA causes DMAR fault in 2nd kernel and sometimes kdump fails
>> due to this fault.
> 
> Here you've lost me. The DMAR fault is caught and reported, and how does
> this lead to a kdump failure? Are you using dodgy hardware that just
> keeps *trying* after an abort, and floods the system with a storm of
> DMAR faults? We've occasionally spoken about working around such a
> problem by setting a bit to make subsequent faults *silent*. Would that
> work?

There are several cases.
- DMAR fault messages floods and second kernel does not boot. Recently I
  saw similar report. https://lkml.org/lkml/2013/3/8/120
- igb driver detectes error on linkup and kdump via network fails.
- On a certain platform, though kdump itself works, PCIe error like
  Unexpected Completion is detected and it gets hardware degraded.

Thanks,
Takao Indoh


> 
>>   What we have to do is stopping DMA transaction
>> before DMA-remapping is disabled in 2nd kernel.
> 
> The IOMMU is there to stop DMA transactions. That is its *job*. :)
> 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
