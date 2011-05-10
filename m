Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from lo.gmane.org ([80.91.229.12])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1QJhgw-0008Ev-AT
	for kexec@lists.infradead.org; Tue, 10 May 2011 07:49:15 +0000
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glkk-kexec@m.gmane.org>) id 1QJhgs-00052Q-A1
	for kexec@lists.infradead.org; Tue, 10 May 2011 09:49:10 +0200
Received: from 60.247.97.98 ([60.247.97.98])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <kexec@lists.infradead.org>; Tue, 10 May 2011 09:49:10 +0200
Received: from xiyou.wangcong by 60.247.97.98 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <kexec@lists.infradead.org>; Tue, 10 May 2011 09:49:10 +0200
From: WANG Cong <xiyou.wangcong@gmail.com>
Subject: Re: kdump without the kexec
Date: Tue, 10 May 2011 07:48:57 +0000 (UTC)
Message-ID: <iqaql8$tt2$1@dough.gmane.org>
References: <BANLkTi=Jt=Q9Q9kM4ogtpW0PN7k=WSLtTQ@mail.gmail.com>
	<20110507075500.GB29941@regiomontanus.bwalle.de>
	<BANLkTikgb4f-OTj1zdw9OkOWb-OZpwJS7g@mail.gmail.com>
	<iq82ct$bs6$1@dough.gmane.org>
	<BANLkTin=0D6dZANXtKKDR=JMFaB5wHzr2A@mail.gmail.com>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

On Mon, 09 May 2011 15:04:42 +0800, Lei Wen wrote:

> Hi Cong,
> 
> On Mon, May 9, 2011 at 2:42 PM, WANG Cong
> <xiyou.wangcong@gmail.com> wrote:
>> On Sun, 08 May 2011 23:31:30 +0800, Lei Wen wrote:
>>
>>> Hi Bernhard,
>>>
>>> On Sat, May 7, 2011 at 3:55 PM, Bernhard Walle
>>> <bernhard@bwalle.de> wrote:
>>>> * Lei Wen <adrian.wenl@gmail.com>
>>>> [2011-05-06 16:33]:
>>>>>
>>>>> Is there any existed solution that could make the kdump without the
>>>>> kexec? For some kind of system hang, always hardware bug, or
>>>>> software deadlock, which could not trigger the kernel oops, so that
>>>>> the first kernel cannot load the second kernel
>>>>> with kexec tool. The only way here is to directly press the reset
>>>>> key.
>>>>>
>>>>> We could be assure that the ddr memory would not be corrupted by
>>>>> this way of reset
>>>>> (for we don't shutdown the ddr power during the reset). So my
>>>>> question is that whether
>>>>> we could take use of bootloader, like the u-boot, to pretend we are
>>>>> loading the second kernel
>>>>> after the reset behavior and then perform the kdump process?
>>>>
>>>> Did you try sysrq-c? Which platform? Most of them have the concept of
>>>> a NMI that also can trigger kdump.
>>>>
>>>>
>>> For some case, the sysrq-c also cannot help, as the cpu is not
>>> responding anymore for some
>>> hw bug. I am running on arm board, there is no NMI concept on it... So
>>> the only help is to put the hw reset and wish the bootloader do the
>>> task which is expected
>>> done by the kexec...
>>
>> Then kdump can't help in this case.
>>
>> And I am afraid you can't use the normal bootloader (e.g. grub, uboot),
>> because we load the second kernel *while* running the first kernel,
>> which means, for example, on x86 we are in protect mode after the
>> kernel boots, not in the real mode in which grub starts.
>>
>> What's more, kdump will not hw-reset the devices unless you add
>> "reset_devices" to the second kernel.
>>
> I see...
> But what I am care is the memory dump done by the kdump. If I could boot
> the second kernel without break the first kernel's space, that by put
> the second kernel just in the space that has been reserved by the first
> kernel. Is that possible to use the bootloader to perform such task?
> 
> The devices state is not really cared by us, for the only interesting
> point is the
> memory context left by the first kernel.

You need to pass correct kernel parameters to the second kernel to make 
this happen, kexec uses "memmap=exactmap memmap=XXX ..." to describe the 
memory map used by the second kernel.

This is _not_ hard for normal bootloaders, the problem is still that you 
need to load the second kernel before the first kernel crashes and during 
the first kernel is running.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
