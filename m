Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-lf1-f66.google.com ([209.85.167.66])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghgVN-00077r-8j
 for kexec@lists.infradead.org; Thu, 10 Jan 2019 20:00:43 +0000
Received: by mail-lf1-f66.google.com with SMTP id a16so9207680lfg.3
 for <kexec@lists.infradead.org>; Thu, 10 Jan 2019 12:00:40 -0800 (PST)
MIME-Version: 1.0
References: <20181213052259.56352-1-cai@lca.pw>
 <20181214040819.58625-1-cai@lca.pw>
 <CAKv+Gu80cxx6L3KYyYnsyjbrWN6iTp76jcdBio27b_h+dAzaHw@mail.gmail.com>
 <bea04814-25d2-7bb2-0f74-0530fcd54210@lca.pw>
In-Reply-To: <bea04814-25d2-7bb2-0f74-0530fcd54210@lca.pw>
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Fri, 11 Jan 2019 01:30:26 +0530
Message-ID: <CACi5LpPDzcgW9Yjx1MkdwbmVPFAToQ5hMAw7cAgEvsrB5KwKDQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: invalidate TLB just before turning MMU on
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
To: Qian Cai <cai@lca.pw>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>, James Morse <james.morse@arm.com>, Kexec Mailing List <kexec@lists.infradead.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi Qian,

On Sat, Dec 15, 2018 at 7:24 AM Qian Cai <cai@lca.pw> wrote:
>
> On 12/14/18 2:23 AM, Ard Biesheuvel wrote:
> > On Fri, 14 Dec 2018 at 05:08, Qian Cai <cai@lca.pw> wrote:
> >> Also tried to move the local TLB flush part around a bit inside
> >> __cpu_setup(), although it did complete kdump some times, it did trigger
> >> "Synchronous Exception" in EFI after a cold-reboot fairly often that
> >> seems no way to recover remotely without reinstalling the OS.
> >
> > This doesn't make any sense to me. If the system gets into a weird
> > state out of cold reboot, how could this code be the culprit? Please
> > check your firmware, and try to reproduce the issue on a system that
> > doesn't have such defects.
> >
>
> I'll continue investigating those "Synchronous Exception" although it is kind of
> hard due to I don't have any source code of the firmware to confirm it is buggy
> or not.
>
> I did manage to reproduce this kdump issue on around 5 of those server running a
> fairly recent version of the firmware (07/01/2018). I don't have access to other
> large CPU machines.

Sorry I got busy with some other stuff, but as I reported earlier, I
am not able to reproduce this on my HPE apollo with the latest linus
tree as well.
Here are some details on my setup:

1. # uname -r
5.0.0-rc1+

with the following commit as the HEAD:
commit a88cc8da0279f8e481b0d90e51a0a1cffac55906 (HEAD -> master,
origin/master, origin/HEAD)
Merge: 9cb2feb4d21d 73444bc4d8f9
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue Jan 8 18:58:29 2019 -0800

    Merge branch 'akpm' (patches from Andrew)

2. I use the following kdump commandline:
Kernel command line: BOOT_IMAGE=(hd9,gpt2)/vmlinuz-5.0.0-rc1+ ro
irqpoll nr_cpus=1 swiotlb=noforce reset_devices
earlycon=pl011,mmio,0x402020000

3. I am able to run kdump successfully on the machine and also collect
the crash core properly:

.. snip..
kdump: saving to /sysroot//var/crash/127.0.0.1-2019-01-10-10:52:25/
kdump: saving vmcore-dmesg.txt
kdump: saving vmcore-dmesg.txt complete
kdump: saving vmcore
Copying data                                      : [100.0 %] \
   eta: 0s
kdump: saving vmcore complete
.. snip ..

4. I use the same firmware version on the board as you shared earlier:
# dmidecode | grep -A 20 -i "BIOS Information"
BIOS Information
    Vendor: American Megatrends Inc.
    Version: L50_5.13_1.0.6
    Release Date: 07/10/2018
    Address: 0xF0000
    Runtime Size: 64 kB
    ROM Size: 64 MB
    Characteristics:
        PCI is supported
        BIOS is upgradeable
        BIOS shadowing is allowed
        Boot from CD is supported
        Selectable boot is supported
        BIOS ROM is socketed
        ACPI is supported
        BIOS boot specification is supported
        Targeted content distribution is supported
        UEFI is supported
    BIOS Revision: 6.3

So, I am guessing that it might be a kdump command line issue at your end.

Thanks,
Bhupesh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
