Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UCgCE-0002YN-KK
 for kexec@lists.infradead.org; Tue, 05 Mar 2013 00:57:36 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 4AE903EE0BC
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 09:57:28 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 21AB145DEC0
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 09:57:28 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 07E5245DEB2
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 09:57:28 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id ED07AE08004
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 09:57:27 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 976DC1DB8040
 for <kexec@lists.infradead.org>; Tue,  5 Mar 2013 09:57:27 +0900 (JST)
Message-ID: <513542CF.1010602@jp.fujitsu.com>
Date: Tue, 05 Mar 2013 09:56:47 +0900
From: Takao Indoh <indou.takao@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v7 0/5] Reset PCIe devices to address DMA problem on kdump
 with iommu
References: <20121127004144.3604.61708.sendpatchset@tindoh.g01.fujitsu.local>
 <1593084.QhbTkmoq3N@hammer82.arch.suse.de> <50FC95A8.6060402@jp.fujitsu.com>
 <1508535.gXZDAVy6sT@hammer82.arch.suse.de> <5133F14D.4060906@jp.fujitsu.com>
 <5135196C.3020104@redhat.com>
In-Reply-To: <5135196C.3020104@redhat.com>
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
To: ddutile@redhat.com
Cc: muneda.takahiro@jp.fujitsu.com, mingo@redhat.com, tokunaga.keiich@jp.fujitsu.com, linux-pci@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, andi@firstfloor.org, ishii.hironobu@jp.fujitsu.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, yinghai@kernel.org, trenn@suse.de, vgoyal@redhat.com, khalid@gonehiking.org

(2013/03/05 7:00), Don Dutile wrote:
> On 03/03/2013 07:56 PM, Takao Indoh wrote:
>> (2013/01/23 9:47), Thomas Renninger wrote:
>>> On Monday, January 21, 2013 10:11:04 AM Takao Indoh wrote:
>>>> (2013/01/08 4:09), Thomas Renninger wrote:
>>> ...
>>>>> I tried the provided patches first on 2.6.32, then I verfied with 3.8-rc2
>>>>> and in both cases the disk is not detected anymore in
>>>>> reset_devices (kexec'ed/kdump) case (but things work fine without these
>>>>> patches).
>>>>
>>>> So the problem that the disk is not detected was caused by exactmap
>>>> problem you guys are discussing? Or still not detected even if exactmap
>>>> problem is fixed?
>>> This problem is related to the 5 PCI resetting patches.
>>> Dumping worked with a 2.6.32 and a 3.8-rc2 kernel, adding the PCI resetting
>>> patches broke both. I first tried 2.6.32 and verified with 3.8-rc2 to make sure
>>> I didn't mess up the backport adjustings of the patches to 2.6.32.
>>>
>>> Unfortunately this Dell platform takes really long to boot.
>>> I can give it the one or other test, but please do not bomb me with patches.
>>>
>>> For info:
>>> About the interrupt remapping error interrupt storm in kdump case I tried to
>>> reproduce on this machine, but never could: The guys who saw that also cannot
>>> reproduce this anymore.
>>>
>>> Two ideas I had about this:
>>>     - As said already, (also) try to catch the error case and try to reset the
>>>       the device in AER/Specific iterrupt remapping error interrupt caught.
>>
>> I tried this idea but it did not work on megaraid_sas.
>>
>> I made a experimental patch so that devices are reset when DMAR error is
>> detected on it. What happened is that:
>> 1) megaraid_sas module is loaded.
>> 2) DMAR error is detected during the driver initialization.
> This driver does something bad that IOMMU code isn't designed for,
> or handle correctly -- it starts with one dma-mask, does an IOMMU mapping,
> changes its dma-mask, and that moves it into another domain that's not
> valid for the first mask.... and does occassional access with original mask.
> I have it on my to-do list to dig into the driver more to see if that
> sequence can be changed/fixed.
>
>> 3) Reset device
>> 4) kdump fails because the disk is not found.
>>
>> When I tested patches which reset all devices in early boot time, the
>> disk was recognized correctly, so it seems that device reset during its
>> driver loading does something wrong. I think we need reset device at
> driver rest, or master-enable turned off ?

I have another patch to turn off busmaster bit in early quirk, but after
driver loading DMAR error is still detected as follows. This may be
driver problem as you said above.

Loading mptscsih.koigb: Intel(R) Gigabit Ethernet Network Driver - version 4.1.2-k
  module
Loadingigb: Copyright (c) 2007-2012 Intel Corporation.
  scsi_transport_dmar: DRHD: handling fault status reg 102
dmar: DMAR:[DMA Write] Request device [01:00.0] fault addr ffe16000
DMAR:[fault reason 01] Present bit in root entry is clear
Uhhuh. NMI received for unknown reason 2c on CPU 0.
Do you have a strange power saving mode enabled?
Dazed and confused, but trying to continue
fc.ko module
Loigb 0000:01:00.0: irq 76 for MSI/MSI-X
ading dm-log.ko igb 0000:01:00.0: irq 77 for MSI/MSI-X
module
Loading igb 0000:01:00.0: irq 78 for MSI/MSI-X
nf_conntrack_ipv6.ko module
Loading vhost_net.ko module
Loading igb.ko module
igb 0000:01:00.0: DCA enabled
igb 0000:01:00.0: Intel(R) Gigabit Ethernet Network Connection
igb 0000:01:00.0: eth0: (PCIe:2.5Gb/s:Width x2) c8:0a:a9:9d:fa:52
igb 0000:01:00.0: eth0: PBA No: 323131-030
igb 0000:01:00.0: Using MSI-X interrupts. 1 rx queue(s), 1 tx queue(s)
dmar: DRHD: handling fault status reg 202
dmar: DMAR:[DMA Write] Request device [01:00.1] fault addr ffee9000
DMAR:[fault reason 01] Present bit in root entry is clear
igb 0000:01:00.1: irq 79 for MSI/MSI-X
igb 0000:01:00.1: irq 80 for MSI/MSI-X
igb 0000:01:00.1: irq 81 for MSI/MSI-X
(snip)

Thanks,
Takao Indoh

  
>> least before its driver is loaded.
>>
>> Thanks,
>> Takao Indoh
>>
>>
>>>     - Have a look at coreboot, these guys should know how to initialize the PCI
>>>       subsystem from scratch and might have some well tested PCI resetting
>>>       code in place already (no idea, just a thought).
>>>
>>>       Thomas
>>>
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
