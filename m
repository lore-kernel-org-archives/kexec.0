Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n3E6m-005r0y-9J
 for kexec@lists.infradead.org; Fri, 31 Dec 2021 09:21:57 +0000
Received: by mail-wm1-x335.google.com with SMTP id
 v10-20020a05600c214a00b00345e59928eeso10685149wml.0
 for <kexec@lists.infradead.org>; Fri, 31 Dec 2021 01:21:55 -0800 (PST)
MIME-Version: 1.0
References: <CAC7+mTga2bGEmK4RotbiO1XvSK2U7bNK9taAoiysVXj5xkMP2Q@mail.gmail.com>
In-Reply-To: <CAC7+mTga2bGEmK4RotbiO1XvSK2U7bNK9taAoiysVXj5xkMP2Q@mail.gmail.com>
From: Rostyslav Spolyak <rspolyak@leobit.com>
Date: Fri, 31 Dec 2021 11:21:43 +0200
Message-ID: <CAC7+mTiNGENZZxv3JtPpSc__k2treNZhWiR5sfxP140beCqo=w@mail.gmail.com>
Subject: kexec fails with "locate_hole failed"
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
To: kexec@lists.infradead.org

Kexec (version 2.0.20) fails to launch crashdump kernel with following error:
> root@device:~# kexec --type zImage -p /boot/zImage --append="root=/dev/mmcblk1p1 1 maxcpus=1 reset_devices"
> syscall kexec_file_load not available.
> Could not find a free area of memory of 0x1000 bytes...
> locate_hole failed

The kernel (version 4.1.52) was configured with CONFIG_KEXEC and
CONFIG_SYSFS enabled. Additionally u-boot was updated to pass the
kernel command line "crashkernel=96M@64M" to reserve RAM for the crash
kernel.

Can you please help to understand why kexec fails to find a free area
of 0x1000 bytes if 96M should be available.
Attaching "/proc/iomem" for reference:
> root@device:~# cat /proc/iomem
> 00905000-0091ffff : 905000.sram
> 02008000-0200bfff : /soc/aips-bus@02000000/spba-bus@02000000/ecspi@02008000
> 02020000-02023fff : /soc/aips-bus@02000000/spba-bus@02000000/serial@02020000
> 02034000-02037fff : /soc/aips-bus@02000000/spba-bus@02000000/serial@02034000
> 0209c000-0209ffff : /soc/aips-bus@02000000/gpio@0209c000
> 020a0000-020a3fff : /soc/aips-bus@02000000/gpio@020a0000
> 020a4000-020a7fff : /soc/aips-bus@02000000/gpio@020a4000
> 020a8000-020abfff : /soc/aips-bus@02000000/gpio@020a8000
> 020ac000-020affff : /soc/aips-bus@02000000/gpio@020ac000
> 020b8000-020bbfff : /soc/aips-bus@02000000/kpp@020b8000
> 020bc000-020bffff : /soc/aips-bus@02000000/wdog@020bc000
> 020c9000-020c9fff : /soc/aips-bus@02000000/usbphy@020c9000
> 020ca000-020cafff : /soc/aips-bus@02000000/usbphy@020ca000
> 020e0000-020e3fff : /soc/aips-bus@02000000/iomuxc@020e0000
> 020ec000-020effff : /soc/aips-bus@02000000/sdma@020ec000
> 020f0000-020f3fff : /soc/aips-bus@02000000/pxp@020f0000
> 020f8000-020fbfff : /soc/aips-bus@02000000/lcdif@020f8000
> 020fc000-020fffff : /soc/aips-bus@02000000/dcp@020fc000
> 02184000-021841ff : /soc/aips-bus@02100000/usb@02184000
>   02184000-021841ff : /soc/aips-bus@02100000/usb@02184000
> 02184800-021849ff : /soc/aips-bus@02100000/usbmisc@02184800
> 02194000-02197fff : mmc1
> 021a0000-021a3fff : /soc/aips-bus@02100000/i2c@021a0000
> 021bc000-021bffff : /soc/aips-bus@02100000/ocotp@021bc000
> 02200000-02203fff : galcore register region
> 02204000-02207fff : galcore register region
> 04000000-09ffffff : Crash kernel
> 80000000-8fffffff : System RAM
>   80008000-8082633f : Kernel code
>   80890000-8094ee93 : Kernel data

Thanks,
Ros

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
