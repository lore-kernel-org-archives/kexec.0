Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UDs7A-0002Qr-EC
 for kexec@lists.infradead.org; Fri, 08 Mar 2013 07:53:18 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 9F9A33EE0BD
 for <kexec@lists.infradead.org>; Fri,  8 Mar 2013 16:53:09 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 85C6C45DEBA
 for <kexec@lists.infradead.org>; Fri,  8 Mar 2013 16:53:09 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 6D0A545DEB7
 for <kexec@lists.infradead.org>; Fri,  8 Mar 2013 16:53:09 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 5F5A91DB803E
 for <kexec@lists.infradead.org>; Fri,  8 Mar 2013 16:53:09 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 10DFA1DB803C
 for <kexec@lists.infradead.org>; Fri,  8 Mar 2013 16:53:09 +0900 (JST)
Message-ID: <513998A6.3030201@jp.fujitsu.com>
Date: Fri, 08 Mar 2013 16:52:06 +0900
From: Takao Indoh <indou.takao@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: 3.9-rc1: crash kernel panic - not syncing: Can not allocate
 SWIOTLB
 buffer earlier and can't now provide you with the DMA bounce buffer
References: <51397D1D.5030602@redhat.com>
 <1750036321.11235774.1362722613994.JavaMail.root@redhat.com>
 <CAE9FiQUtDcwJkPMPfjur8LQ+u0Hc2J7sbxC=xkcemqRQ1_Gd8g@mail.gmail.com>
 <CAE9FiQU7ccdWCL=t=Zn1w33GHpHk56=JXTcotn-Huq9Wiqu7wg@mail.gmail.com>
 <51399154.5030500@redhat.com>
 <CAE9FiQVPaG5P7mG9HoFzCkaxF62hkU5hEtq_FhdT7n+38aNs9A@mail.gmail.com>
 <51399442.1080609@redhat.com>
In-Reply-To: <51399442.1080609@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: chaowang@redhat.com
Cc: caiqian@redhat.com, yinghai@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hpa@linux.intel.com, dyoung@redhat.com, vgoyal@redhat.com

(2013/03/08 16:33), WANG Chao wrote:
> On 03/08/2013 03:27 PM, Yinghai Lu wrote:
>> On Thu, Mar 7, 2013 at 11:20 PM, WANG Chao <chaowang@redhat.com> wrote:
>>>>
>>>> looks like your system DO have DMAR table, please enable dmar
>>>> remapping in your kernel config.
>>>
>>> I've already got following config:
>>> CONFIG_DMAR_TABLE=y
>>> CONFIG_INTEL_IOMMU=y
>>> CONFIG_IRQ_REMAP=y
>>>
>>> but I don't have intel_iommu=on in kernel cmdline. IIRC, iommu will prevent
>>> 2nd kernel from booting ...
>>
>> Did you put intel_iommu=on on first and second cpu both?
>
> I tried, 2nd kernel didn't boot and keep splitting errors like these:
> [    2.106939] DMAR: No ATSR found
> [    2.110121] IOMMU 0 0xfed90000: using Queued invalidation
> [    2.115522] IOMMU 1 0xfed91000: using Queued invalidation
> [    2.120919] IOMMU: Setting RMRR:
> [    2.124162] IOMMU: Setting identity map for device 0000:00:02.0 [0xab800000
> - 0xaf9fffff]
> [    2.133099] IOMMU: Setting identity map for device 0000:00:1d.0 [0xaac95000
> - 0xaacb2fff]
> [    2.141305] IOMMU: Setting identity map for device 0000:00:1a.0 [0xaac95000
> - 0xaacb2fff]
> [    2.149503] IOMMU: Setting identity map for device 0000:00:14.0 [0xaac95000
> - 0xaacb2fff]
> [    2.157690] IOMMU: Prepare 0-16MiB unity mapping for LPC
> [    2.163011] IOMMU: Setting identity map for device 0000:00:1f.0 [0x0 - 0xffffff
> [Errors, here we go]
> [    2.170932] dmar: DRHD: handling fault status reg 3
> [    2.170933] PCI-DMA: Intel(R) Virtualization Technology for Directed I/O
> [    2.182486] dmar: DMAR:[DMA Write] Request device [00:02.0] fault addr ffffe000
> [    2.182486] DMAR:[fault reason 05] PTE Write access is not set
> [    2.195705] dmar: DRHD: handling fault status reg 3
> [    2.200570] dmar: DMAR:[DMA Read] Request device [00:02.0] fault addr ff873000
> [    2.200570] DMAR:[fault reason 06] PTE Read access is not set
> [    2.213618] dmar: DRHD: handling fault status reg 3
> [..]

This is the problem I'm working on.
https://lkml.org/lkml/2012/11/26/814

Thansk,
Takao Indoh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
