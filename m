Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VJGkQ-0001kW-CB
 for kexec@lists.infradead.org; Tue, 10 Sep 2013 05:44:24 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 28E603EE1CC
 for <kexec@lists.infradead.org>; Tue, 10 Sep 2013 14:43:53 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 7755745DE57
 for <kexec@lists.infradead.org>; Tue, 10 Sep 2013 14:43:49 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 262BF45DE53
 for <kexec@lists.infradead.org>; Tue, 10 Sep 2013 14:43:49 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 14296E18001
 for <kexec@lists.infradead.org>; Tue, 10 Sep 2013 14:43:49 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id B55171DB8037
 for <kexec@lists.infradead.org>; Tue, 10 Sep 2013 14:43:48 +0900 (JST)
Message-ID: <522EB171.6000909@jp.fujitsu.com>
Date: Tue, 10 Sep 2013 14:43:13 +0900
From: Takao Indoh <indou.takao@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] intel-iommu: Quiesce devices before disabling IOMMU
References: <1377069354-5056-1-git-send-email-indou.takao@jp.fujitsu.com>
 <1378717669.2627.239.camel@shinybook.infradead.org>
In-Reply-To: <1378717669.2627.239.camel@shinybook.infradead.org>
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
Cc: alex.williamson@redhat.com, iommu@lists.linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, joro@8bytes.org

(2013/09/09 18:07), David Woodhouse wrote:
> On Wed, 2013-08-21 at 16:15 +0900, Takao Indoh wrote:
>>
>> This causes problem on kdump. Devices are working in first kernel, and
>> after switching to second kernel and initializing IOMMU, many DMAR faults
>> occur and it causes problems like driver error or PCI SERR, at last
>> kdump fails. This patch fixes this problem.
> 
> I'm not sure I'd call this a fix.
> 
> If the driver is so broken that it cannot get the device working again
> after a fault, surely the driver needs to be fixed?

Yes,this problem may be solved by fixing driver. Actually megaraid sas
driver is recently fixed for this problem. (See commit 6431f5d7)

But I think root cause of this problem is initializing IOMMU while DMA
is still working, and I want to solve the root cause rather than
handling it in each driver, otherwise we have to fix driver each time we
find this kind of problem.

> 
> If the system is suffering an IRQ storm because device doesn't give up
> after the first few faults, then we should switch off the fault
> *reporting* for that device so that its faults get ignored (until it
> next actually sets up a DMA mapping, or something).

In such a case, yeah limiting messages is enough.

> 
> For the IOMMU code to reset individual devices, just because they still
> have an active DMA mapping even if they're not *doing* DMA, seems wrong.
> You'll even end up resetting devices just because they have an RMRR,
> won't you? (Although I wouldn't lose any sleep over that, I suppose. In
> fact it might be a *feature*... :)
 
Right, current code is resetting devices which *may* be doing DMA. The
ideal way is finding devices which are actually doing DMA and reset only
them but I don't know how we can do this, though I think current code
is sufficient.

Thanks,
Takao Indoh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
