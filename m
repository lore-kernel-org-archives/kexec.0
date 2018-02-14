Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt0-x230.google.com ([2607:f8b0:400d:c0d::230])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1eltJe-0008DE-7y
 for kexec@lists.infradead.org; Wed, 14 Feb 2018 09:25:28 +0000
Received: by mail-qt0-x230.google.com with SMTP id d8so6949986qtm.0
 for <kexec@lists.infradead.org>; Wed, 14 Feb 2018 01:25:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CANc8B5OiTBgZy4ez9wbqScCqxmp9G1jzHAkgW-Y8N9Nrtbo7Lg@mail.gmail.com>
References: <CANc8B5NV7xepYWHWZ3sYsv1uP2ofxwtw1SN2DERxfA4ta05fKw@mail.gmail.com>
 <CAFTCetR6cbs1eLwaxu_U4pXQ4f51e3L6R2Kz2z545VH6EX+ncA@mail.gmail.com>
 <CANc8B5NL-if_9FBoE6sHfmoUeD1zj37VcRKEYOThZBWkpo-iAQ@mail.gmail.com>
 <CANc8B5Of1EeOQTTrP4_n_kiXuLd6-7pZ62dft_0dU59H5f4C5g@mail.gmail.com>
 <CANc8B5PSv_B2iteSL3muOz6H8kRX3YHohGReXwxHFESLZsZwjw@mail.gmail.com>
 <CAFTCetQ_zmGW2=RRfBC5tWRXY6qAJbNFrFbKVmq==Bj3ry_x5A@mail.gmail.com>
 <CANc8B5OiTBgZy4ez9wbqScCqxmp9G1jzHAkgW-Y8N9Nrtbo7Lg@mail.gmail.com>
From: Bhupesh SHARMA <bhupesh.linux@gmail.com>
Date: Wed, 14 Feb 2018 14:55:14 +0530
Message-ID: <CAFTCetSc9vUDY0jZ0qqP=a9a8t31cZzuQdsxmbPeyCuj0XBkkw@mail.gmail.com>
Subject: Re: how to use kexec to jump back to the original kernel
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
To: Gioh Kim <gurugio@gmail.com>
Cc: kexec@lists.infradead.org

On Wed, Feb 14, 2018 at 2:24 PM, Gioh Kim <gurugio@gmail.com> wrote:
> On Tue, Feb 13, 2018 at 8:06 PM, Bhupesh SHARMA <bhupesh.linux@gmail.com> wrote:
>> On Tue, Feb 13, 2018 at 8:15 PM, Gioh Kim <gurugio@gmail.com> wrote:
>>> On Tue, Feb 13, 2018 at 3:36 PM, Gioh Kim <gurugio@gmail.com> wrote:
>>>> On Tue, Feb 13, 2018 at 11:06 AM, Gioh Kim <gurugio@gmail.com> wrote:
>>>>> On Mon, Feb 12, 2018 at 7:56 AM, Bhupesh SHARMA <bhupesh.linux@gmail.com> wrote:
>>>>>> Hello,
>>>>>>
>>>>>> On Fri, Feb 9, 2018 at 7:24 PM, Gioh Kim <gurugio@gmail.com> wrote:
>>>>>>> Hello,
>>>>>>>
>>>>>>> "echo c > /proc/sysrq-trigger" generates the kernel dump but it
>>>>>>> reboots the system.
>>>>>>> I'd like to generate kernel dump without system reboot.
>>>>>>>
>>>>>>> I think it is possible to jump to the kdump kernel and generate kernel
>>>>>>> dump, and come back to the operating kernel with kexec.
>>>>>>> I know I can jump to the kdump kernel with "kexec -e" but I cannot
>>>>>>> figure out how to come back to the operating kernel.
>>>>>>>
>>>>>>> For example, I tried following sequences after reading kexec manual page.
>>>>>>>
>>>>>>> 0. rebuild kernel with CONFIG_KEXEC_JUMP option
>>>>>>> 1. kexec --load=/boot/vmlinuz --initrd=/boot/initrd --reuse-cmdline
>>>>>>
>>>>>> Instead you should be using something like:
>>>>>> # kexec -l /boot/vmlinuz-`uname -r` --initrd=/boot/initramfs-`uname
>>>>>> -r`.img --reuse-cmdline  --load-preserve-context --mem-min=addr
>>>>>> --mem-max=addr
>>>>>
>>>>> Hello Bhupesh,
>>>>
>>>> I'm sorry to bother you.
>>>> I failed because I booted up wrong kernel without KEXEC_JUMP.
>>>> I can jump to kdump kernel with booting a kernel with KEXEC_JUMP.
>>>> And I can see "kexec_jump_back_entry=0x00000000000810d2" at kernel
>>>> booting parameter.
>>>> Now I can jump to kdump kernel and jump back to the original kernel.
>>>>
>>>> Can I ask just one more question?
>>>> After jumping to kdump kernel, there is not /proc/vmcore file.
>>>> I checked the kernel enabled CONFIG_PROC_VMCORE option.
>>>> What kernel option should I enable to use /proc/vmcore?
>>>> Or should I use another file instead /proc/vmcore?
>>>>
>>>>
>>>
>>> I'm sorry but please let me ask one more question.
>>>
>>> I ran "kexec -e" command on kdump kernel, then it just rebooted the system.
>>> I guess jumping to the original kernel means resuming the original
>>> kernel as it was running.
>>> Did I misunderstand?
>>> Or my machine did not work correctly?
>>
>> Hello,
>>
>> I have replied in another thread (in reply to the documentation patch
>> for kdump jump feature which you sent out today) about this in detail,
>> but to capture my thoughts briefly here, I think you are confusing the
>> 'kexec -l' or loading another kernel and 'kexec -p' or the kdump use
>> cases.
>>
>> Can you please explain whether you are trying the jump feature with
>> 'kexec -l' or 'kexec -p'.
>>
>
> Hello,
>
> The another thread about documentation is for documentation.
> So I explain the background here.
>
> I'm working for the Cloud company providing qemu-based virtualization service.
> When system has a problem and does not panic yet, we usually migrate
> all guest VMs
> and reboot the system.
> Sometimes log files have a clue for the problem, but in many cases
> there is nothing in log files
> and it's difficult to investigate.
>
> What I want to do is generating a kernel dump at the moment when the
> system becomes unstable.
> After migrating all VMs, the system would be clean and I would get no
> clue for the problem.
> So I'd like to generate the kernel dump before migrating VMs and
> cleaning up the system.
>
> Of course, when system paniced, I got kernel dump.
> But it is the worst case because guest VMs also were killed.
> It is the service failure.
>
> I think I'm confused with system snapshot and kernel dump.
> Nevertheless I need a solution to capture the system status without
> panic or reboot.
>
>
>> I remember trying the jump feature with 'kexec -p' some time back and
>> it did not work for me at that time. Although I was able to use the
>> jump feature with 'kexec -l' on the same machine.
>
> 'kexec -p' command jumps to kdump kernel on panic, doesn't it?
> I'd like to jump to kdump kernel without panic or reboot, and get back
> to the system kernel
> and continue to service.

So you mean kexec not kdump here, see more below ..

> I think that is the jumping between the system kernel and kdump kernel.
> If I misunderstand the meaning of the jump, I'll find another way.
>
> Thank you again ;-)

.. Seems you are mixing up two separate use-cases (see [1] for some background):

Kexec is a Linux kernel-to-kernel boot loader that helps to boot the
second kernel from the context of first kernel. Kexec shuts down the
first kernel, bypasses the BIOS or firmware stage, and jumps to second
kernel.

Whereas Kdump can be used with the kexec application when the first
kernel panics, the second kernel is used to copy the memory dump of
first kernel, which can be analysed with tools such as gdb and crash
to determine the panic reasons.

I am not sure if we can jump back to a primary kernel from the
secondary kernel when the primary kernel has already panicked/crashed,
so we are looking at a 'kexec -l' use case primarily, which should
work fine normally on x86_64 with the jump use-case.

[1]. https://opensource.com/article/17/6/kdump-usage-and-internals

Regards,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
