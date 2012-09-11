Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TBNqK-0000Tc-Uh
 for kexec@lists.infradead.org; Tue, 11 Sep 2012 10:37:23 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id C943B3EE0B6
 for <kexec@lists.infradead.org>; Tue, 11 Sep 2012 19:37:14 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id B1CC345DE4E
 for <kexec@lists.infradead.org>; Tue, 11 Sep 2012 19:37:14 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 99C2D45DE4D
 for <kexec@lists.infradead.org>; Tue, 11 Sep 2012 19:37:14 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 8D5B21DB8038
 for <kexec@lists.infradead.org>; Tue, 11 Sep 2012 19:37:14 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 406281DB802C
 for <kexec@lists.infradead.org>; Tue, 11 Sep 2012 19:37:14 +0900 (JST)
Message-ID: <504F1343.7030607@jp.fujitsu.com>
Date: Tue, 11 Sep 2012 19:32:35 +0900
From: Takao Indoh <indou.takao@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [RFC][PATCH] Reset PCIe devices to address DMA problem on kdump
 with iommu
References: <501BB4EF.7080909@jp.fujitsu.com>
 <20120803114643.GA28330@redhat.com> <501F4877.5050605@jp.fujitsu.com>
 <20120806203902.GH25559@redhat.com> <50473306.1070803@jp.fujitsu.com>
 <20120910143604.GB639@redhat.com>
In-Reply-To: <20120910143604.GB639@redhat.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: vgoyal@redhat.com
Cc: martin.wilck@ts.fujitsu.com, linux-pci@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com

(2012/09/10 23:36), Vivek Goyal wrote:
> On Wed, Sep 05, 2012 at 08:09:58PM +0900, Takao Indoh wrote:
>> (2012/08/07 5:39), Vivek Goyal wrote:
>>> On Mon, Aug 06, 2012 at 01:30:47PM +0900, Takao Indoh wrote:
>>>> Hi Vivek,
>>>>
>>>> (2012/08/03 20:46), Vivek Goyal wrote:
>>>>> On Fri, Aug 03, 2012 at 08:24:31PM +0900, Takao Indoh wrote:
>>>>>> Hi all,
>>>>>>
>>>>>> This patch adds kernel parameter "reset_pcie_devices" which resets PCIe
>>>>>> devices at boot time to address DMA problem on kdump with iommu. When
>>>>>> this parameter is specified, a hot reset is triggered on each PCIe root
>>>>>> port and downstream port to reset its downstream endpoint.
>>>>>
>>>>> Hi Takao,
>>>>>
>>>>> Why not use existing "reset_devices" parameter instead of introducing
>>>>> a new one?
>>>>
>>>> "reset_devices" is used for each driver to reset their own device, and
>>>> this patch resets all devices forcibly, so I thought they were different
>>>> things.
>>>
>>> Yes reset_devices currently is used for driver to reset its device. I
>>> thought one could very well extend its reach to reset pci express devices
>>> at bus level.
>>>
>>> Having them separate is not going to be much useful from kdump
>>> perspective. We will end up passing both reset_devices and
>>> reset_pcie_devices to second kernel whill lead to bus level reset as well
>>> as device level reset.
>>>
>>> Ideal situation would be that somehow detect that bus level reset has been
>>> done and skip device level reset (assuming bus level reset obviates the
>>> need of device level reset, please correct me if that's not the case).
>>>
>>> After pcie reset, can we store the state in a variable and drivers can
>>> use that variable to check if PCIe level reset was done or not. If yes,
>>> skip device level reset (Assuming driver knows that device is on a
>>> PCIe slot).
>>>
>>> In that case we will not have to introduce new kernel command line, and
>>> also avoid double reset?
>> I found a problem when testing my patch on some machines.
>>
>> Originally there are two problems in kdump kernel when iommu is enabled;
>> DMAR error and PCI SERR. I thought they are fixed by my patch, but I
>> noticed that PCI SERR is still detected after applying the patch. It
>> seems that something happens when Interrupt Remapping is initialized in
>> kdump kernel.
>>
>> Therefore resetting devices has to be done before enable_IR() is
>> called. I have three ideas for it.
>>
>>   (i) Resetting devices in 1st kernel(panic kernel)
>>   We can reset devices before jumping into 2nd kernel. Of course it may
>>   be dangerous to scan pci device tree and call PCI functions in panic'd
>>   kernel. Beforehand we need to collect device information so that only
>>   minimal code could run on panic.
>>
>>   (ii) Resetting devices in purgatory
>>   It seems to be be appropriate place to do this, but I'm not sure
>>   where I can save/restore PCI config when resetting devices in
>>   purgatory.
>>
>>   (iii) Resetting devices in 2nd kernel(kdump kernel)
>>   Important point is to do reset before enable_IR() is called as I wrote
>>   above. I think I should add new function to do reset into
>>   arch/x86/pci/early.c and call it in setup_arch like
>>   early_dump_pci_devices() or early_quirks().
>
> I would not claim that I understand hte PCI SERR issue. But whatever
> resettings needs to happen, should happen early in second kernel.
>
> Doing it in first kernel is not a good idea as it is crashed kernel and
> we want to as little as possible.
>
> Doing it in purgatory is not a good idea either as purgatory does not
> konw anything about kernel as such. We don't want to bloat purgatory
> with reset code and embedding the device knowledge there.
>
> Keeping it in second kernel makes sense so that code remains with kernel
> and can be maintained there.

I'll post new patch which clears bus master bit and resets devices in
second kernel.

As to the boot parameter to enable this function, you suggested using
reset_devices. I found that on a certain platform resetting devices
caused PCIe error due to a hardware bug. Therefore I think we need
new parameter apart from reset_devices to disable this function on
such a machine.

Thanks,
Takao Indoh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
