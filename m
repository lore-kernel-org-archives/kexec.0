Return-path: <kexec-bounces@lists.infradead.org>
Received: from wa-out-1112.google.com ([209.85.146.176])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IhtWa-0004eJ-Oi
	for kexec@lists.infradead.org; Tue, 16 Oct 2007 22:00:27 +0100
Received: by wa-out-1112.google.com with SMTP id v33so2417307wah
	for <kexec@lists.infradead.org>; Tue, 16 Oct 2007 14:00:01 -0700 (PDT)
Message-ID: <2ea3fae10710161400s1c558845y8e398c9a18f98dfb@mail.gmail.com>
Date: Tue, 16 Oct 2007 14:00:00 -0700
From: yhlu <yinghailu@gmail.com>
Subject: Re: kexec: Cannot determine the file type of arch/x86/boot/bzImage
In-Reply-To: <20071016130657.8cc17011.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
References: <47151631.9000307@m3y3r.de>
	<20071016130657.8cc17011.randy.dunlap@oracle.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces@lists.infradead.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Meyer <thomas@m3y3r.de>

On 10/16/07, Randy Dunlap <randy.dunlap@oracle.com> wrote:
> On Tue, 16 Oct 2007 21:51:13 +0200 Thomas Meyer wrote:
>
> [adding kexec mailing list]
>
>
> > Hi.
> >
> > Look at this:
> >
> > $ file arch/x86/boot/bzImage (tree 821f3eff7cdb9d6c7076effabd46c96c322daed1)
> > arch/x86/boot/bzImage: Linux kernel x86 boot executable zImage, version
> > 2.6.23 (thomas@hotzenplotz) #39, RO-rootFS, root_dev 0x803, swap_dev
> > 0x1, Prompt for Videomode
> >
> > $ file /boot/bzImage-2.6.23
> > /boot/bzImage-2.6.23: Linux kernel x86 boot executable RO-rootFS,
> > root_dev 0x803, swap_dev 0x1, Normal VGA
> >
> > and this:
> >
> > # kexec -l arch/x86/boot/bzImage
> > Cannot determine the file type of arch/x86/boot/bzImage
> >
> > How to solve this error?

#!/bin/bash
KERNEL_VER=2.6.24_k8.2
CONSOLE=console=uart8250,io,0x3f8,9600n8

./kexec -t bzImage -l bzImage_"$KERNEL_VER" --command-line="apic=debug
acpi.debug_level=0x0000000F pci=routeirq nmi_watchdog=2
ramdisk_size=65536 root=/dev/ram0 rw ip=dhcp $CONSOLE"
--ramdisk=mydisk8_x86_64.gz

YH

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
