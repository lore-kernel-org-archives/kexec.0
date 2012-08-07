Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Syfki-0007yR-J2
 for kexec@lists.infradead.org; Tue, 07 Aug 2012 09:07:02 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 943B63EE0C0
 for <kexec@lists.infradead.org>; Tue,  7 Aug 2012 18:06:55 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 7365345DEB4
 for <kexec@lists.infradead.org>; Tue,  7 Aug 2012 18:06:55 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 598F145DEB2
 for <kexec@lists.infradead.org>; Tue,  7 Aug 2012 18:06:55 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 4CB3F1DB803C
 for <kexec@lists.infradead.org>; Tue,  7 Aug 2012 18:06:55 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id F19901DB803E
 for <kexec@lists.infradead.org>; Tue,  7 Aug 2012 18:06:54 +0900 (JST)
Message-ID: <5020D9B3.7020506@jp.fujitsu.com>
Date: Tue, 07 Aug 2012 18:02:43 +0900
From: Takao Indoh <indou.takao@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [RFC][PATCH] Reset PCIe devices to address DMA problem on kdump
 with iommu
References: <501BB4EF.7080909@jp.fujitsu.com>
 <20120803114643.GA28330@redhat.com> <501F4877.5050605@jp.fujitsu.com>
 <20120806203902.GH25559@redhat.com>
In-Reply-To: <20120806203902.GH25559@redhat.com>
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
To: vgoyal@redhat.com
Cc: martin.wilck@ts.fujitsu.com, linux-pci@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, ishii.hironobu@jp.fujitsu.com, bhelgaas@google.com

(2012/08/07 5:39), Vivek Goyal wrote:
> On Mon, Aug 06, 2012 at 01:30:47PM +0900, Takao Indoh wrote:
>> Hi Vivek,
>>
>> (2012/08/03 20:46), Vivek Goyal wrote:
>>> On Fri, Aug 03, 2012 at 08:24:31PM +0900, Takao Indoh wrote:
>>>> Hi all,
>>>>
>>>> This patch adds kernel parameter "reset_pcie_devices" which resets PCIe
>>>> devices at boot time to address DMA problem on kdump with iommu. When
>>>> this parameter is specified, a hot reset is triggered on each PCIe root
>>>> port and downstream port to reset its downstream endpoint.
>>>
>>> Hi Takao,
>>>
>>> Why not use existing "reset_devices" parameter instead of introducing
>>> a new one?
>>
>> "reset_devices" is used for each driver to reset their own device, and
>> this patch resets all devices forcibly, so I thought they were different
>> things.
>
> Yes reset_devices currently is used for driver to reset its device. I
> thought one could very well extend its reach to reset pci express devices
> at bus level.
>
> Having them separate is not going to be much useful from kdump
> perspective. We will end up passing both reset_devices and
> reset_pcie_devices to second kernel whill lead to bus level reset as well
> as device level reset.
>
> Ideal situation would be that somehow detect that bus level reset has been
> done and skip device level reset (assuming bus level reset obviates the
> need of device level reset, please correct me if that's not the case).
>
> After pcie reset, can we store the state in a variable and drivers can
> use that variable to check if PCIe level reset was done or not. If yes,
> skip device level reset (Assuming driver knows that device is on a
> PCIe slot).
>
> In that case we will not have to introduce new kernel command line, and
> also avoid double reset?

Actually I'm not sure whether the driver does not need to do their reset after
bus level reset, but I agree with you, now I'm thinking that using reset_devices
is better rather than adding narrow one which is limited to PCI express, otherwise
we may have to add new parameter every time when adding new reset method, such as
reset_pcie_devices, reset_pci_legacy_devices, etc.

Thanks,
Takao Indoh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
