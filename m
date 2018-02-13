Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt0-x231.google.com ([2607:f8b0:400d:c0d::231])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1elful-00040U-KH
 for kexec@lists.infradead.org; Tue, 13 Feb 2018 19:06:53 +0000
Received: by mail-qt0-x231.google.com with SMTP id f18so4816296qth.11
 for <kexec@lists.infradead.org>; Tue, 13 Feb 2018 11:06:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CANc8B5PSv_B2iteSL3muOz6H8kRX3YHohGReXwxHFESLZsZwjw@mail.gmail.com>
References: <CANc8B5NV7xepYWHWZ3sYsv1uP2ofxwtw1SN2DERxfA4ta05fKw@mail.gmail.com>
 <CAFTCetR6cbs1eLwaxu_U4pXQ4f51e3L6R2Kz2z545VH6EX+ncA@mail.gmail.com>
 <CANc8B5NL-if_9FBoE6sHfmoUeD1zj37VcRKEYOThZBWkpo-iAQ@mail.gmail.com>
 <CANc8B5Of1EeOQTTrP4_n_kiXuLd6-7pZ62dft_0dU59H5f4C5g@mail.gmail.com>
 <CANc8B5PSv_B2iteSL3muOz6H8kRX3YHohGReXwxHFESLZsZwjw@mail.gmail.com>
From: Bhupesh SHARMA <bhupesh.linux@gmail.com>
Date: Wed, 14 Feb 2018 00:36:39 +0530
Message-ID: <CAFTCetQ_zmGW2=RRfBC5tWRXY6qAJbNFrFbKVmq==Bj3ry_x5A@mail.gmail.com>
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

On Tue, Feb 13, 2018 at 8:15 PM, Gioh Kim <gurugio@gmail.com> wrote:
> On Tue, Feb 13, 2018 at 3:36 PM, Gioh Kim <gurugio@gmail.com> wrote:
>> On Tue, Feb 13, 2018 at 11:06 AM, Gioh Kim <gurugio@gmail.com> wrote:
>>> On Mon, Feb 12, 2018 at 7:56 AM, Bhupesh SHARMA <bhupesh.linux@gmail.com> wrote:
>>>> Hello,
>>>>
>>>> On Fri, Feb 9, 2018 at 7:24 PM, Gioh Kim <gurugio@gmail.com> wrote:
>>>>> Hello,
>>>>>
>>>>> "echo c > /proc/sysrq-trigger" generates the kernel dump but it
>>>>> reboots the system.
>>>>> I'd like to generate kernel dump without system reboot.
>>>>>
>>>>> I think it is possible to jump to the kdump kernel and generate kernel
>>>>> dump, and come back to the operating kernel with kexec.
>>>>> I know I can jump to the kdump kernel with "kexec -e" but I cannot
>>>>> figure out how to come back to the operating kernel.
>>>>>
>>>>> For example, I tried following sequences after reading kexec manual page.
>>>>>
>>>>> 0. rebuild kernel with CONFIG_KEXEC_JUMP option
>>>>> 1. kexec --load=/boot/vmlinuz --initrd=/boot/initrd --reuse-cmdline
>>>>
>>>> Instead you should be using something like:
>>>> # kexec -l /boot/vmlinuz-`uname -r` --initrd=/boot/initramfs-`uname
>>>> -r`.img --reuse-cmdline  --load-preserve-context --mem-min=addr
>>>> --mem-max=addr
>>>
>>> Hello Bhupesh,
>>
>> I'm sorry to bother you.
>> I failed because I booted up wrong kernel without KEXEC_JUMP.
>> I can jump to kdump kernel with booting a kernel with KEXEC_JUMP.
>> And I can see "kexec_jump_back_entry=0x00000000000810d2" at kernel
>> booting parameter.
>> Now I can jump to kdump kernel and jump back to the original kernel.
>>
>> Can I ask just one more question?
>> After jumping to kdump kernel, there is not /proc/vmcore file.
>> I checked the kernel enabled CONFIG_PROC_VMCORE option.
>> What kernel option should I enable to use /proc/vmcore?
>> Or should I use another file instead /proc/vmcore?
>>
>>
>
> I'm sorry but please let me ask one more question.
>
> I ran "kexec -e" command on kdump kernel, then it just rebooted the system.
> I guess jumping to the original kernel means resuming the original
> kernel as it was running.
> Did I misunderstand?
> Or my machine did not work correctly?

Hello,

I have replied in another thread (in reply to the documentation patch
for kdump jump feature which you sent out today) about this in detail,
but to capture my thoughts briefly here, I think you are confusing the
'kexec -l' or loading another kernel and 'kexec -p' or the kdump use
cases.

Can you please explain whether you are trying the jump feature with
'kexec -l' or 'kexec -p'.

I remember trying the jump feature with 'kexec -p' some time back and
it did not work for me at that time. Although I was able to use the
jump feature with 'kexec -l' on the same machine.

Regards,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
