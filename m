Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TO5fs-0002Ll-T3
 for kexec@lists.infradead.org; Tue, 16 Oct 2012 11:51:06 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 3FBD63EE0BB
 for <kexec@lists.infradead.org>; Tue, 16 Oct 2012 20:50:58 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 25E7345DE50
 for <kexec@lists.infradead.org>; Tue, 16 Oct 2012 20:50:58 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 0DB6845DE4D
 for <kexec@lists.infradead.org>; Tue, 16 Oct 2012 20:50:58 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id F21451DB802C
 for <kexec@lists.infradead.org>; Tue, 16 Oct 2012 20:50:57 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id A9C161DB803A
 for <kexec@lists.infradead.org>; Tue, 16 Oct 2012 20:50:57 +0900 (JST)
Message-ID: <507D48EE.9010800@jp.fujitsu.com>
Date: Tue, 16 Oct 2012 20:45:50 +0900
From: Takao Indoh <indou.takao@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v4 1/2] x86, pci: Reset PCIe devices at boot time
References: <20121015065516.2832.42378.sendpatchset@indoh>
 <20121015065526.2832.90867.sendpatchset@indoh>
 <1350321429.7065.97.camel@rhapsody>
In-Reply-To: <1350321429.7065.97.camel@rhapsody>
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
To: khalid@gonehiking.org
Cc: martin.wilck@ts.fujitsu.com, linux-pci@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, andi@firstfloor.org, ddutile@redhat.com, ishii.hironobu@jp.fujitsu.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com, vgoyal@redhat.com

(2012/10/16 2:17), Khalid Aziz wrote:
> On Mon, 2012-10-15 at 16:00 +0900, Takao Indoh wrote:
>> This patch resets PCIe devices at boot time by hot reset when
>> "reset_devices" is specified.
>>
>> Signed-off-by: Takao Indoh <indou.takao@jp.fujitsu.com>
>> ---
>>   arch/x86/include/asm/pci-direct.h |    1
>>   arch/x86/kernel/setup.c           |    3
>>   arch/x86/pci/early.c              |  344 ++++++++++++++++++++++++++++
>>   include/linux/pci.h               |    2
>>   init/main.c                       |    4
>>   5 files changed, 352 insertions(+), 2 deletions(-)
>>
>
>
> Looks good.
>
> Reviewed-by: Khalid Aziz <khalid@gonehiking.org>
>

Thanks! But unfortunately I found a bug, so I'll post v5 patch soon.

A bug I found is that configuration register is accessed without
delay after reset.

This is an algorithm to reset devices.

  for (each device) {  <===== (A)
    if (does not have downstream devices)
      continue
    for (each downstream device) {
      save config registers
    }
    do_bus_reset <==== (B)
  }
  wait 500 ms
  ...

Let's say my system has the following devices.

00:01.0 (root port)
|
+- 01:00.0 (device)

In this case,
1) At first, 00:01.0 is found at (A). And its downstream devcice 01:00.0
   is reset at (B).
2) Next, 01:00.0 is found at (A). Then config register of 01:00.0 is
   accessed. This is PCIe spec violation because the config register of
   01:00.0 is accessed without delay after reset. PCIe spec requires
   at least 100ms waiting time before sending a config request.

Therefore I'll update patches like this so that devices could be reset
after saving phase is done:

  for (each device) {
    if (does not have downstream devices)
      continue
    for_each (its downstream devices) {
      save config registers
    }
-   do_bus_reset
  }
+ for (each device) {
+   do_bus_reset
+ }
  wait 500 ms
  ...

Thanks,
Takao Indoh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
