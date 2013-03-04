Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UCJih-000703-EA
 for kexec@lists.infradead.org; Mon, 04 Mar 2013 00:57:36 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 8CBBD3EE0BC
 for <kexec@lists.infradead.org>; Mon,  4 Mar 2013 09:57:20 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 715F245DEBC
 for <kexec@lists.infradead.org>; Mon,  4 Mar 2013 09:57:20 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 486D345DEB6
 for <kexec@lists.infradead.org>; Mon,  4 Mar 2013 09:57:20 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 3B8541DB8043
 for <kexec@lists.infradead.org>; Mon,  4 Mar 2013 09:57:20 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id DDD131DB803E
 for <kexec@lists.infradead.org>; Mon,  4 Mar 2013 09:57:19 +0900 (JST)
Message-ID: <5133F14D.4060906@jp.fujitsu.com>
Date: Mon, 04 Mar 2013 09:56:45 +0900
From: Takao Indoh <indou.takao@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v7 0/5] Reset PCIe devices to address DMA problem on kdump
 with iommu
References: <20121127004144.3604.61708.sendpatchset@tindoh.g01.fujitsu.local>
 <1593084.QhbTkmoq3N@hammer82.arch.suse.de> <50FC95A8.6060402@jp.fujitsu.com>
 <1508535.gXZDAVy6sT@hammer82.arch.suse.de>
In-Reply-To: <1508535.gXZDAVy6sT@hammer82.arch.suse.de>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: trenn@suse.de
Cc: muneda.takahiro@jp.fujitsu.com, tokunaga.keiich@jp.fujitsu.com, linux-pci@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, andi@firstfloor.org, ddutile@redhat.com, ishii.hironobu@jp.fujitsu.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, yinghai@kernel.org, mingo@redhat.com, vgoyal@redhat.com, khalid@gonehiking.org

(2013/01/23 9:47), Thomas Renninger wrote:
> On Monday, January 21, 2013 10:11:04 AM Takao Indoh wrote:
>> (2013/01/08 4:09), Thomas Renninger wrote:
> ...
>>> I tried the provided patches first on 2.6.32, then I verfied with 3.8-rc2
>>> and in both cases the disk is not detected anymore in
>>> reset_devices (kexec'ed/kdump) case (but things work fine without these
>>> patches).
>>
>> So the problem that the disk is not detected was caused by exactmap
>> problem you guys are discussing? Or still not detected even if exactmap
>> problem is fixed?
> This problem is related to the 5 PCI resetting patches.
> Dumping worked with a 2.6.32 and a 3.8-rc2 kernel, adding the PCI resetting
> patches broke both. I first tried 2.6.32 and verified with 3.8-rc2 to make sure
> I didn't mess up the backport adjustings of the patches to 2.6.32.
>
> Unfortunately this Dell platform takes really long to boot.
> I can give it the one or other test, but please do not bomb me with patches.
>
> For info:
> About the interrupt remapping error interrupt storm in kdump case I tried to
> reproduce on this machine, but never could: The guys who saw that also cannot
> reproduce this anymore.
>
> Two ideas I had about this:
>    - As said already, (also) try to catch the error case and try to reset the
>      the device in AER/Specific iterrupt remapping error interrupt caught.

I tried this idea but it did not work on megaraid_sas.

I made a experimental patch so that devices are reset when DMAR error is
detected on it. What happened is that:
1) megaraid_sas module is loaded.
2) DMAR error is detected during the driver initialization.
3) Reset device
4) kdump fails because the disk is not found.

When I tested patches which reset all devices in early boot time, the
disk was recognized correctly, so it seems that device reset during its
driver loading does something wrong. I think we need reset device at
least before its driver is loaded.

Thanks,
Takao Indoh


>    - Have a look at coreboot, these guys should know how to initialize the PCI
>      subsystem from scratch and might have some well tested PCI resetting
>      code in place already (no idea, just a thought).
>
>      Thomas
>
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
