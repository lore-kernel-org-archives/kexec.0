Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from lo.gmane.org ([80.91.229.12])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1QJKBE-0000oV-5h
	for kexec@lists.infradead.org; Mon, 09 May 2011 06:42:59 +0000
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glkk-kexec@m.gmane.org>) id 1QJKB7-0007yc-HU
	for kexec@lists.infradead.org; Mon, 09 May 2011 08:42:49 +0200
Received: from 60.247.97.98 ([60.247.97.98])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <kexec@lists.infradead.org>; Mon, 09 May 2011 08:42:49 +0200
Received: from xiyou.wangcong by 60.247.97.98 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <kexec@lists.infradead.org>; Mon, 09 May 2011 08:42:49 +0200
From: WANG Cong <xiyou.wangcong@gmail.com>
Subject: Re: kdump without the kexec
Date: Mon, 9 May 2011 06:42:37 +0000 (UTC)
Message-ID: <iq82ct$bs6$1@dough.gmane.org>
References: <BANLkTi=Jt=Q9Q9kM4ogtpW0PN7k=WSLtTQ@mail.gmail.com>
	<20110507075500.GB29941@regiomontanus.bwalle.de>
	<BANLkTikgb4f-OTj1zdw9OkOWb-OZpwJS7g@mail.gmail.com>
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

On Sun, 08 May 2011 23:31:30 +0800, Lei Wen wrote:

> Hi Bernhard,
> 
> On Sat, May 7, 2011 at 3:55 PM, Bernhard Walle
> <bernhard@bwalle.de> wrote:
>> * Lei Wen <adrian.wenl@gmail.com>
>> [2011-05-06 16:33]:
>>>
>>> Is there any existed solution that could make the kdump without the
>>> kexec? For some kind of system hang, always hardware bug, or software
>>> deadlock, which could not trigger the kernel oops, so that the first
>>> kernel cannot load the second kernel
>>> with kexec tool. The only way here is to directly press the reset key.
>>>
>>> We could be assure that the ddr memory would not be corrupted by this
>>> way of reset
>>> (for we don't shutdown the ddr power during the reset). So my question
>>> is that whether
>>> we could take use of bootloader, like the u-boot, to pretend we are
>>> loading the second kernel
>>> after the reset behavior and then perform the kdump process?
>>
>> Did you try sysrq-c? Which platform? Most of them have the concept of a
>> NMI that also can trigger kdump.
>>
>>
> For some case, the sysrq-c also cannot help, as the cpu is not
> responding anymore for some
> hw bug. I am running on arm board, there is no NMI concept on it... So
> the only help is to put the hw reset and wish the bootloader do the task
> which is expected
> done by the kexec...

Then kdump can't help in this case.

And I am afraid you can't use the normal bootloader (e.g. grub, uboot), 
because we load the second kernel *while* running the first kernel, which 
means, for example, on x86 we are in protect mode after the kernel boots, 
not in the real mode in which grub starts.

What's more, kdump will not hw-reset the devices unless you add 
"reset_devices" to the second kernel.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
