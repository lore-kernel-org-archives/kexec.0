Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TMdV0-0004OL-6N
 for kexec@lists.infradead.org; Fri, 12 Oct 2012 11:33:52 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 8D0663EE0C0
 for <kexec@lists.infradead.org>; Fri, 12 Oct 2012 20:33:43 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 7374E45DEBB
 for <kexec@lists.infradead.org>; Fri, 12 Oct 2012 20:33:43 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 425B645DEB7
 for <kexec@lists.infradead.org>; Fri, 12 Oct 2012 20:33:43 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 368381DB8044
 for <kexec@lists.infradead.org>; Fri, 12 Oct 2012 20:33:43 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id D91F41DB803C
 for <kexec@lists.infradead.org>; Fri, 12 Oct 2012 20:33:42 +0900 (JST)
Message-ID: <5077FEE6.7060000@jp.fujitsu.com>
Date: Fri, 12 Oct 2012 20:28:38 +0900
From: Takao Indoh <indou.takao@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/2] x86, pci: Reset PCIe devices at boot time
References: <20121010074553.1084.52175.sendpatchset@indoh>
 <20121010074603.1084.92389.sendpatchset@indoh>
 <1349899704.25679.14.camel@rhapsody> <50766432.9000706@jp.fujitsu.com>
 <1349976523.7065.22.camel@rhapsody>
In-Reply-To: <1349976523.7065.22.camel@rhapsody>
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
To: khalid@gonehiking.org
Cc: martin.wilck@ts.fujitsu.com, linux-pci@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, andi@firstfloor.org, ddutile@redhat.com, ishii.hironobu@jp.fujitsu.com, hpa@zytor.com, bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com, vgoyal@redhat.com

(2012/10/12 2:28), Khalid Aziz wrote:
> On Thu, 2012-10-11 at 15:16 +0900, Takao Indoh wrote:
>> (2012/10/11 5:08), Khalid Aziz wrote:
> .....
>>>> +static void __init do_reset(u8 bus, u8 slot, u8 func)
>>>> +{
>>>> +	u16 ctrl;
>>>> +
>>>> +	printk(KERN_INFO "pci 0000:%02x:%02x.%d reset\n", bus, slot, func);
>>>> +
>>>> +	/* Assert Secondary Bus Reset */
>>>> +	ctrl = read_pci_config_16(bus, slot, func, PCI_BRIDGE_CONTROL);
>>>> +	ctrl |= PCI_BRIDGE_CTL_BUS_RESET;
>>>> +	write_pci_config_16(bus, slot, func, PCI_BRIDGE_CONTROL, ctrl);
>>>> +
>>>> +	pci_udelay(5000);
>>>> +
>>>> +	/* De-assert Secondary Bus Reset */
>>>> +	ctrl &= ~PCI_BRIDGE_CTL_BUS_RESET;
>>>> +	write_pci_config_16(bus, slot, func, PCI_BRIDGE_CONTROL, ctrl);
>>>> +
>>>> +	pci_udelay(500000);
>>>
>>> This is 0.5 second. This will add up quickly on larger servers with
>>> multiple busses. Is 0.5 second required by the spec?
>>> aer_do_secondary_bus_reset() holds PCI_BRIDGE_CTL_BUS_RESET for 2 ms and
>>> then waits another 200 ms after de-asserting it. Still long, but less
>>> than half of the delay in above code..
>>
>> According to PCIe spec, they should be more than 1ms and 100ms. The reason
>> why they're 2ms and 200ms in aer_do_secondary_bus_reset() is that it's a
>> kind of safety margin, I think.
>>
>> At first these delay were 2ms and 200ms as well as
>> aer_do_secondary_bus_reset(), but I found a problem that on certain
>> machine it was not enough. I think this problem occurs because
>> native_io_delay() is not precise. Therefore I extended them to have more
>> margin.
>>
>> If this delay should be shortened, I have two solutions.
>>
>> 1)
>> Call early_reset_pcie_devices() after calibrate_delay() so that we can
>> use precise mdelay. Personally I don't want to do this because I think
>> DMA should be stopped asap.
>>
>> 2)
>> Make it tuneable. For exmple, improve "reset_devices"
>>       reset_devices=reset_delay=500
>> or something like that. As default, 200ms is enough as far as I tested.
>> But if it is not enough, we can adjust delay time using this.
>>
>> Any other idea?
>>
>
> I don't like the idea of asking end user to determine how many msec of
> delay they would need on their system for a reset. If we have to go that
> route, I would rather have a default of 200 msec and then add a kernel
> option like "reset_devices=reset_delay=long" which changes the delay to
> 500 msec.
>
> Here is another idea. The code you currently have does:
>
> for (each device) {
>    save config registers
>    reset
>    wait for 500 ms
>    restore config registers
> }
>
> You need to wait for 500 ms because you can not access config registers
> until reset is complete. So how about this - why not just save config
> registers, reset each device and then wait only once for 500 ms before
> restoring config registers on all devices. Here is what this will look
> like:
>
> for (each device) {
>    save config registers
>    reset
> }
> wait 500 ms
> for (each device) {
>    restore config registers
> }
>
> This is obviously more complex and requires you to allocate more space
> for saving state, but it has the benefits of minimizing boot up delay
> and making the delay constant irrespective of number of switches/bridges
> on the system.
>
> Does this sound reasonable?

Yep, that looks good idea. I'll update my patch with this idea.

Thanks,
Takao Indoh

>
>
>>>
>>> We have been seeing problems with kexec/kdump kernel for quite some time
>>> that are related to I/O devices not being quiesced before kexec. I had
>>> added code to clear Bus Master bit to help stop runaway DMAs which
>>> helped many cases, but obviously not all. If resetting downstream ports
>>> helps stop runaway I/O from PCIe devices, I am all for this approach.
>>> This patch still doesn't do anything for old PCI devices though.
>>
>> This patch does not reset PCI devices because of VGA problem. As I wrote
>> in patch description, the monitor blacks out when VGA controller is
>> reset. So when VGA device is found we need to skip it. In the case of
>> PCIe, we can decide whether we do bus reset or not on each device, but
>> we cannot in the case of PCI.
>
> OK. My concern is there are plenty of older servers out there that
> potentially have the problem with kexec/kdump failing often and we are
> not solving the problem for them. If we can only solve it for PCIe for
> now, I am ok with starting there.
>
> --
> Khalid
>
>
>
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
