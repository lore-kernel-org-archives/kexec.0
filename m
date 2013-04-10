Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UPmx6-0003ZA-9t
 for kexec@lists.infradead.org; Wed, 10 Apr 2013 04:48:10 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 7330F3EE0BC
 for <kexec@lists.infradead.org>; Wed, 10 Apr 2013 13:47:57 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 5765D45DE4D
 for <kexec@lists.infradead.org>; Wed, 10 Apr 2013 13:47:57 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 3F0A945DDCF
 for <kexec@lists.infradead.org>; Wed, 10 Apr 2013 13:47:57 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 32E0D1DB803C
 for <kexec@lists.infradead.org>; Wed, 10 Apr 2013 13:47:57 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id DDD681DB802C
 for <kexec@lists.infradead.org>; Wed, 10 Apr 2013 13:47:56 +0900 (JST)
Message-ID: <5164EEE6.8000707@jp.fujitsu.com>
Date: Wed, 10 Apr 2013 13:47:34 +0900
From: Takao Indoh <indou.takao@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] intel-iommu: Synchronize gcmd value with global command
 register
References: <1363829556-2128-1-git-send-email-indou.takao@jp.fujitsu.com>
 <20130326144629.GB2727@8bytes.org> <51527D74.9080209@jp.fujitsu.com>
 <20130327103122.GK30540@8bytes.org> <51591EEE.60401@jp.fujitsu.com>
 <20130402140546.GA15687@8bytes.org> <515BD638.8070307@jp.fujitsu.com>
 <1364977479.28127.15.camel@i7.infradead.org>
 <20130405110616.GB6858@8bytes.org>
In-Reply-To: <20130405110616.GB6858@8bytes.org>
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
To: joro@8bytes.org, dwmw2@infradead.org
Cc: iommu@lists.linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, tindoh@gmail.com

(2013/04/05 20:06), Joerg Roedel wrote:
> On Wed, Apr 03, 2013 at 09:24:39AM +0100, David Woodhouse wrote:
>> On Wed, 2013-04-03 at 16:11 +0900, Takao Indoh wrote:
>>> Yeah, you are right. I forgot such a case.
>>
>> If you disable translation and there's some device still doing DMA, it's
>> going to scribble over random areas of memory. You really want to have
>> translation enabled and all the page tables *cleared*, during kexec. I
>> think it's fair to insist that the secondary kernel should use the IOMMU
>> if the first one did.
> 
> Do we really need to insist on that? The IOMMU initialization on x86
> happens after the kernel scanned and enumerated the PCI bus. While doing
> this the kernel (at least it should) disables all devices it finds. So
> when the IOMMU init code runs we should be safe from any in-flight DMA
> and can either disable translation or re-initialize it for the kdump
> kernel. Until then translation needs to stay enabled of course, so that
> the old page-tables are still used and in-flight DMA doesn't corrupt
> any data.

So we should do in this order, right?
(1) PCI initialization. Stop all ongoing DMA here.
(2) Disable translation if already enable.
(3) Make pgtable and enable translation.

Thanks,
Takao Indoh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
