Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UP7tX-0004M6-Cp
 for kexec@lists.infradead.org; Mon, 08 Apr 2013 08:57:44 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 6F30F3EE0C0
 for <kexec@lists.infradead.org>; Mon,  8 Apr 2013 17:57:32 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 5687145DEB6
 for <kexec@lists.infradead.org>; Mon,  8 Apr 2013 17:57:32 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 3E32B45DEB2
 for <kexec@lists.infradead.org>; Mon,  8 Apr 2013 17:57:32 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 3128A1DB803B
 for <kexec@lists.infradead.org>; Mon,  8 Apr 2013 17:57:32 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id D03AD1DB8038
 for <kexec@lists.infradead.org>; Mon,  8 Apr 2013 17:57:31 +0900 (JST)
Message-ID: <51628663.9040604@jp.fujitsu.com>
Date: Mon, 08 Apr 2013 17:57:07 +0900
From: Takao Indoh <indou.takao@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] intel-iommu: Synchronize gcmd value with global command
 register
References: <1363829556-2128-1-git-send-email-indou.takao@jp.fujitsu.com>
 <20130326144629.GB2727@8bytes.org> <51527D74.9080209@jp.fujitsu.com>
 <20130327103122.GK30540@8bytes.org> <51591EEE.60401@jp.fujitsu.com>
 <20130402140546.GA15687@8bytes.org> <515BD638.8070307@jp.fujitsu.com>
 <1364977479.28127.15.camel@i7.infradead.org> <515D1429.40707@jp.fujitsu.com>
 <1365085489.28127.64.camel@i7.infradead.org>
In-Reply-To: <1365085489.28127.64.camel@i7.infradead.org>
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
Cc: iommu@lists.linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

(2013/04/04 23:24), David Woodhouse wrote:
> On Thu, 2013-04-04 at 14:48 +0900, Takao Indoh wrote:
>>
>> - DMAR fault messages floods and second kernel does not boot. Recently I
>>    saw similar report. https://lkml.org/lkml/2013/3/8/120
> 
> Right. So the fix for that is to make the subsequent errors silent,
> until/unless we actually get a request to create a mapping for the given
> device.
> 
>> - igb driver detectes error on linkup and kdump via network fails.
> 
> That's a driver bug, IIRC. It was failing to completely reset the
> hardware. It's fixed now, isn't it?

No, it can be reproduced with latest kernel(3.9.0-rc6).

> 
>> - On a certain platform, though kdump itself works, PCIe error like
>>    Unexpected Completion is detected and it gets hardware degraded.
> 
> More information required.

When I tested intel_iommu on a certain machine, the following error
message was logged in its firmware, and I/O board got abnormal status.
05:00.0 is igb, so I think this was caused by DMA error on igb. This
occurs before igb driver loading, so this cannot be fixed in driver.

    PCI: Unexpected Completion Bus: 5 Device: 0x00 Function: 0x00

Anyway, I'm thinking we should introduce something framework to clean
all devices to stop DMA at boot time rather than dealing with the
problem in each driver. And one of the way I found is resetting devcies
by PCIe layer. If DMAR is disabled in init_dmars(), we can have a
chance to handle devices to stop DMA in PCI layer, like qci-quirk. This
is one of the reason why I propose this patch.

Thanks,
Takao Indoh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
