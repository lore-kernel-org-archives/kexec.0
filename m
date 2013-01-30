Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U0Po5-000614-CI
 for kexec@lists.infradead.org; Wed, 30 Jan 2013 05:01:59 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 8301A3EE0BB
 for <kexec@lists.infradead.org>; Wed, 30 Jan 2013 14:01:50 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 69B4145DE54
 for <kexec@lists.infradead.org>; Wed, 30 Jan 2013 14:01:50 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 3656145DD78
 for <kexec@lists.infradead.org>; Wed, 30 Jan 2013 14:01:50 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 283A41DB803C
 for <kexec@lists.infradead.org>; Wed, 30 Jan 2013 14:01:50 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id CC9901DB8040
 for <kexec@lists.infradead.org>; Wed, 30 Jan 2013 14:01:49 +0900 (JST)
Message-ID: <5108A911.4070902@jp.fujitsu.com>
Date: Wed, 30 Jan 2013 14:01:05 +0900
From: Takao Indoh <indou.takao@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v7 0/5] Reset PCIe devices to address DMA problem on kdump
 with iommu
References: <20121127004144.3604.61708.sendpatchset@tindoh.g01.fujitsu.local>
 <1508535.gXZDAVy6sT@hammer82.arch.suse.de> <51007EF2.3090208@jp.fujitsu.com>
 <3404772.bJenOLl2bH@hammer82.arch.suse.de>
In-Reply-To: <3404772.bJenOLl2bH@hammer82.arch.suse.de>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: trenn@suse.de
Cc: muneda.takahiro@jp.fujitsu.com, tokunaga.keiich@jp.fujitsu.com, linux-pci@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, andi@firstfloor.org, ddutile@redhat.com, ishii.hironobu@jp.fujitsu.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, yinghai@kernel.org, mingo@redhat.com, vgoyal@redhat.com, khalid@gonehiking.org

(2013/01/29 10:14), Thomas Renninger wrote:
> On Thursday, January 24, 2013 09:23:14 AM Takao Indoh wrote:
>> (2013/01/23 9:47), Thomas Renninger wrote:
>>> On Monday, January 21, 2013 10:11:04 AM Takao Indoh wrote:
>>>> (2013/01/08 4:09), Thomas Renninger wrote:
>>> ...
>>>
>>>>> I tried the provided patches first on 2.6.32, then I verfied with
>>>>> 3.8-rc2
>>>>> and in both cases the disk is not detected anymore in
>>>>> reset_devices (kexec'ed/kdump) case (but things work fine without these
>>>>> patches).
>>>>
>>>> So the problem that the disk is not detected was caused by exactmap
>>>> problem you guys are discussing? Or still not detected even if exactmap
>>>> problem is fixed?
>>>
>>> This problem is related to the 5 PCI resetting patches.
>>> Dumping worked with a 2.6.32 and a 3.8-rc2 kernel, adding the PCI
>>> resetting
>>> patches broke both. I first tried 2.6.32 and verified with 3.8-rc2 to make
>>> sure I didn't mess up the backport adjustings of the patches to 2.6.32.
>> If you have a chance please try again the patches with the latest
>> firmware.
> Not sure I can update the firmware as this is a reference platform used exactly
> like this in production.

Anyway it seems that resetting device makes the disks disappear from
your system. I'm wondering if this reset mechanism should be disabled by
default and be enabled by boot parameter like
reset_devices_on_dmar_fault to prevent a regression like your case.

Thanks,
Takao Indoh

>
> I also cannot see how this could help.
>
>     Thomas
>
>



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
