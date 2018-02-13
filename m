Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt0-x235.google.com ([2607:f8b0:400d:c0d::235])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1elbhR-0002oY-Cb
 for kexec@lists.infradead.org; Tue, 13 Feb 2018 14:36:50 +0000
Received: by mail-qt0-x235.google.com with SMTP id q18so3822890qtl.3
 for <kexec@lists.infradead.org>; Tue, 13 Feb 2018 06:36:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CANc8B5NL-if_9FBoE6sHfmoUeD1zj37VcRKEYOThZBWkpo-iAQ@mail.gmail.com>
References: <CANc8B5NV7xepYWHWZ3sYsv1uP2ofxwtw1SN2DERxfA4ta05fKw@mail.gmail.com>
 <CAFTCetR6cbs1eLwaxu_U4pXQ4f51e3L6R2Kz2z545VH6EX+ncA@mail.gmail.com>
 <CANc8B5NL-if_9FBoE6sHfmoUeD1zj37VcRKEYOThZBWkpo-iAQ@mail.gmail.com>
From: Gioh Kim <gurugio@gmail.com>
Date: Tue, 13 Feb 2018 15:36:37 +0100
Message-ID: <CANc8B5Of1EeOQTTrP4_n_kiXuLd6-7pZ62dft_0dU59H5f4C5g@mail.gmail.com>
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
To: Bhupesh SHARMA <bhupesh.linux@gmail.com>
Cc: kexec@lists.infradead.org

On Tue, Feb 13, 2018 at 11:06 AM, Gioh Kim <gurugio@gmail.com> wrote:
> On Mon, Feb 12, 2018 at 7:56 AM, Bhupesh SHARMA <bhupesh.linux@gmail.com> wrote:
>> Hello,
>>
>> On Fri, Feb 9, 2018 at 7:24 PM, Gioh Kim <gurugio@gmail.com> wrote:
>>> Hello,
>>>
>>> "echo c > /proc/sysrq-trigger" generates the kernel dump but it
>>> reboots the system.
>>> I'd like to generate kernel dump without system reboot.
>>>
>>> I think it is possible to jump to the kdump kernel and generate kernel
>>> dump, and come back to the operating kernel with kexec.
>>> I know I can jump to the kdump kernel with "kexec -e" but I cannot
>>> figure out how to come back to the operating kernel.
>>>
>>> For example, I tried following sequences after reading kexec manual page.
>>>
>>> 0. rebuild kernel with CONFIG_KEXEC_JUMP option
>>> 1. kexec --load=/boot/vmlinuz --initrd=/boot/initrd --reuse-cmdline
>>
>> Instead you should be using something like:
>> # kexec -l /boot/vmlinuz-`uname -r` --initrd=/boot/initramfs-`uname
>> -r`.img --reuse-cmdline  --load-preserve-context --mem-min=addr
>> --mem-max=addr
>
> Hello Bhupesh,
>
> Thank you for your advice.
>
> I tried load-preserve-context as below but it failed with "Invalid
> argument" error.
> There is no reason in the error message.
> But there is entry address that looks like the address "kexec -e" in
> the kdump kernel will jump to.
> Following is what I did.
>
> root@pserver:~# kexec -l /boot/vmlinuz-`uname -r`
> --initrd=/boot/initrd.img-`uname -r` --reuse-cmdline
> --load-preserve-context --mem-min=0x1000000 --mem-max=0xffffffff
> kexec_load failed: Invalid argument
> entry       = 0xbffcb7f0 flags = 0x3e0002
> nr_segments = 7
> segment[0].buf   = (nil)
> segment[0].bufsz = 0x0
> segment[0].mem   = 0x1000000
> segment[0].memsz = 0xba080000
> segment[1].buf   = 0x7fe372eaa010
> segment[1].bufsz = 0x2f7fddc
> segment[1].mem   = 0xbb080000
> segment[1].memsz = 0x2f80000
> segment[2].buf   = 0x7fe375e2e210
> segment[2].bufsz = 0x61c840
> segment[2].mem   = 0xbe000000
> segment[2].memsz = 0x14e1000
> segment[3].buf   = (nil)
> segment[3].bufsz = 0x0
> segment[3].mem   = 0xbf4e1000
> segment[3].memsz = 0xae5000
> segment[4].buf   = 0x25eb920
> segment[4].bufsz = 0x42c6
> segment[4].mem   = 0xbffc6000
> segment[4].memsz = 0x5000
> segment[5].buf   = 0x25e27c0
> segment[5].bufsz = 0x9100
> segment[5].mem   = 0xbffcb000
> segment[5].memsz = 0xb000
> segment[6].buf   = 0x25e1e20
> segment[6].bufsz = 0x400
> segment[6].mem   = 0xbffd6000
> segment[6].memsz = 0x4000
> root@pserver:~#
> root@pserver:~#
> root@pserver:~# kexec -e
> Nothing has been loaded!
>

I'm sorry to bother you.
I failed because I booted up wrong kernel without KEXEC_JUMP.
I can jump to kdump kernel with booting a kernel with KEXEC_JUMP.
And I can see "kexec_jump_back_entry=0x00000000000810d2" at kernel
booting parameter.
Now I can jump to kdump kernel and jump back to the original kernel.

Can I ask just one more question?
After jumping to kdump kernel, there is not /proc/vmcore file.
I checked the kernel enabled CONFIG_PROC_VMCORE option.
What kernel option should I enable to use /proc/vmcore?
Or should I use another file instead /proc/vmcore?


-- 

Best regards,
Gioh Kim

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
