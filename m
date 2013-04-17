Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1USO3J-0007oX-V6
 for kexec@lists.infradead.org; Wed, 17 Apr 2013 08:49:19 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 858EA3EE0AE
 for <kexec@lists.infradead.org>; Wed, 17 Apr 2013 17:49:06 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 611B245DEBB
 for <kexec@lists.infradead.org>; Wed, 17 Apr 2013 17:49:06 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 46ABF45DEB5
 for <kexec@lists.infradead.org>; Wed, 17 Apr 2013 17:49:06 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 394971DB8043
 for <kexec@lists.infradead.org>; Wed, 17 Apr 2013 17:49:06 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id E0C1D1DB803E
 for <kexec@lists.infradead.org>; Wed, 17 Apr 2013 17:49:05 +0900 (JST)
Message-ID: <516E61EE.5030607@jp.fujitsu.com>
Date: Wed, 17 Apr 2013 17:48:46 +0900
From: Takao Indoh <indou.takao@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] intel-iommu: Synchronize gcmd value with global command
 register
References: <20130326144629.GB2727@8bytes.org>
 <51527D74.9080209@jp.fujitsu.com> <20130327103122.GK30540@8bytes.org>
 <51591EEE.60401@jp.fujitsu.com> <20130402140546.GA15687@8bytes.org>
 <515BD638.8070307@jp.fujitsu.com>
 <1364977479.28127.15.camel@i7.infradead.org>
 <20130405110616.GB6858@8bytes.org> <5164EEE6.8000707@jp.fujitsu.com>
 <516BC19D.4090303@jp.fujitsu.com> <20130415101829.GP6858@8bytes.org>
In-Reply-To: <20130415101829.GP6858@8bytes.org>
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
To: joro@8bytes.org
Cc: kexec@lists.infradead.org, iommu@lists.linux-foundation.org, dwmw2@infradead.org, linux-kernel@vger.kernel.org, tindoh@gmail.com

(2013/04/15 19:18), Joerg Roedel wrote:
> On Mon, Apr 15, 2013 at 06:00:13PM +0900, Takao Indoh wrote:
>> On DMAR initialization during kdump boot, do you guys agree to change
>> order like this?
>>
>> Current order:
>> (1) Disable translation
>> (2) PCI initialization
>> (3) Make pgtable and enable translation.
>>
>> Order I'm proposing:
>> (1) PCI initialization
>> (2) Disable translation
>> (3) Make pgtable and enable translation.
> 
> I think this should work. In fact, translation only needs to be disabled
> while the IOMMU hardware is reprogrammed to the new data structures the
> kdump kernel set up.

Ok, I agree.

> 
>> As Joerg said, if we need to consider the case that kdump kernel is
>> compiled without dma-remapping(CONFIG_INTEL_IOMMU is off?), I can update
>> my patch to handle such a case properly by adding ifdef
>> CONFIG_INTEL_IOMMU.
> 
> Thinking about it, this case is a bit more special. If the kdump kernel
> has no IOMMU driver at all there is also no code to disable it. So
> unless we want to force the kdump kernel to have the driver when the
> first kernel had it, I think we also want some quirk (depending on
> !CONFIG_INTEL_IOMMU) that disables translation at boot.
> 
> I know, its complicated :)

yeah complicated. hmm..., this isn't limited only to iommu case, there
are many problems which are caused by difference of config between first
kernel and second one. So, to make code simple, I think we don't need to
care such a exceptional case. I mean, I think it is a matter of user
and user has to compile second kernel with dma-remapping if user want to
use it in first kernel.

Thanks,
Takao Indoh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
