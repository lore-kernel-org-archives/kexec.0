Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TyAbe-0004yj-CC
 for kexec@lists.infradead.org; Thu, 24 Jan 2013 00:23:52 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id C742D3EE0BC
 for <kexec@lists.infradead.org>; Thu, 24 Jan 2013 09:23:44 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id AA5F945DE54
 for <kexec@lists.infradead.org>; Thu, 24 Jan 2013 09:23:44 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 9178245DE5A
 for <kexec@lists.infradead.org>; Thu, 24 Jan 2013 09:23:44 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 83E181DB8051
 for <kexec@lists.infradead.org>; Thu, 24 Jan 2013 09:23:44 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 356FC1DB804C
 for <kexec@lists.infradead.org>; Thu, 24 Jan 2013 09:23:44 +0900 (JST)
Message-ID: <51007EF2.3090208@jp.fujitsu.com>
Date: Thu, 24 Jan 2013 09:23:14 +0900
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
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

If you have a chance please try again the patches with the latest
firmware. I met another problem on megaraid_sas disk when I tested the
patches and it did not occur after updated its firmware to the latest
one.
  
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
>    - Have a look at coreboot, these guys should know how to initialize the PCI
>      subsystem from scratch and might have some well tested PCI resetting
>      code in place already (no idea, just a thought).

Ok, at first I'll take a look at AER code to check how it resets devices
on PCIe error.

Thanks,
Takao Indoh

>
>      Thomas
>
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
