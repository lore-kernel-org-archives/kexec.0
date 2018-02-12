Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-qt0-x232.google.com ([2607:f8b0:400d:c0d::232])
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1el82M-0008Hs-LK
 for kexec@lists.infradead.org; Mon, 12 Feb 2018 06:56:28 +0000
Received: by mail-qt0-x232.google.com with SMTP id f18so17638558qth.11
 for <kexec@lists.infradead.org>; Sun, 11 Feb 2018 22:56:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CANc8B5NV7xepYWHWZ3sYsv1uP2ofxwtw1SN2DERxfA4ta05fKw@mail.gmail.com>
References: <CANc8B5NV7xepYWHWZ3sYsv1uP2ofxwtw1SN2DERxfA4ta05fKw@mail.gmail.com>
From: Bhupesh SHARMA <bhupesh.linux@gmail.com>
Date: Mon, 12 Feb 2018 12:26:12 +0530
Message-ID: <CAFTCetR6cbs1eLwaxu_U4pXQ4f51e3L6R2Kz2z545VH6EX+ncA@mail.gmail.com>
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

Hello,

On Fri, Feb 9, 2018 at 7:24 PM, Gioh Kim <gurugio@gmail.com> wrote:
> Hello,
>
> "echo c > /proc/sysrq-trigger" generates the kernel dump but it
> reboots the system.
> I'd like to generate kernel dump without system reboot.
>
> I think it is possible to jump to the kdump kernel and generate kernel
> dump, and come back to the operating kernel with kexec.
> I know I can jump to the kdump kernel with "kexec -e" but I cannot
> figure out how to come back to the operating kernel.
>
> For example, I tried following sequences after reading kexec manual page.
>
> 0. rebuild kernel with CONFIG_KEXEC_JUMP option
> 1. kexec --load=/boot/vmlinuz --initrd=/boot/initrd --reuse-cmdline

Instead you should be using something like:
# kexec -l /boot/vmlinuz-`uname -r` --initrd=/boot/initramfs-`uname
-r`.img --reuse-cmdline  --load-preserve-context --mem-min=addr
--mem-max=addr

to let the kernel know that the primary kernel context should be
retained so that we can return to the same once we do a 'kexec -e'
from the secondary kernel.

Can you please try the same. Also can you please share the details of
the hardware you are using this one, AFAIK only x86 and sh
architectures support CONFIG_KEXEC_JUMP in upstream linux.

Regards,
Bhupesh

> 2. kexec -e
> 3. now kdump kernel is running
> 4. kexec --load-jump-back-helper --entry=<ADDRESS>
> 5. kexec -e
>
> I can jump to the kdump kernel with step 1 and step 2.
> kexec manual says I need an entry address.
> I don't know what address I should use.
> I found a email thread about jump_back_entry= but there is no
> parameter like jump_back_entry in kernel booting parameters of
> v4.4~v4.14.
>
> Does anybody know how to use kexec to jump between kdump kernel and
> operating kernel?
>
>
> --
>
> Best regards,
> Gioh Kim
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
