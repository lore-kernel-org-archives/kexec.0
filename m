Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from plane.gmane.org ([80.91.229.3])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TasVM-0003bd-FG
 for kexec@lists.infradead.org; Tue, 20 Nov 2012 18:25:05 +0000
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glkk-kexec@m.gmane.org>) id 1TasVM-0008N6-RN
 for kexec@lists.infradead.org; Tue, 20 Nov 2012 19:25:04 +0100
Received: from ping01.stura.uni-weimar.de ([141.54.160.24])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <kexec@lists.infradead.org>; Tue, 20 Nov 2012 19:25:04 +0100
Received: from j.f.eick by ping01.stura.uni-weimar.de with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00
 for <kexec@lists.infradead.org>; Tue, 20 Nov 2012 19:25:04 +0100
From: Jan Frederick Eick <j.f.eick@gmx.de>
Subject: Kexec on Macbook Pro 8,1
Date: Tue, 20 Nov 2012 19:19:41 +0100
Message-ID: <k8ghk2$ms8$1@ger.gmane.org>
Mime-Version: 1.0
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
To: kexec@lists.infradead.org

Hi there,

I'm not sure if this is the right place to ask my questions, but I found 
very sparse documentation when it comes to solve problems with kexec.

I'm running an arch linux setup on my Macbook Pro 8,1 (Kernel 
3.6.7-1-ck) with an i915 vga adapter (Intel HD Graphics 3000) and I try 
to use kexec with systemd.

Systemd uses a service file to load the new Kernel image before 
executing kexec:
[SNIP]
[Service]
Type=oneshot
ExecStart=/sbin/kexec -l /boot/vmlinuz-linux-ck \
                 --initrd=/boot/initramfs-linux-ck.img\
                 --reuse-cmdline
[/SNIP]

I use a system with an encrypted root partition, but I ran into the 
exact same issue with my old setup (without encrypted root).

But when I issue the kexec call I can read the line
"Starting new kernel" and then my screen is garbled. I read a lot about 
issues with the vga console, so I tried to reach my system by ssh, but 
it didn't work.

I uploaded a "screenshot" here: http://imgur.com/UVDT9

Some more info:
[kernel commandline]
BOOT_IMAGE=/vmlinuz-linux-ck root=/dev/mapper/main-root ro 
cryptdevice=/dev/sda6:main pcie_aspm=force i915.i915_enable_rc6=1 
i915.lvds_downclock=1 i915.i915_enable_fbc=1 elevator=bfq verbose

[mkinitcpio.conf]
[...]
MODULES="ahci libahci ehci-hcd uhci-hcd ext3 ext4 vfat"
BINARIES="kexec"
FILES="/etc/modprobe.d/modprobe.conf"
HOOKS="base udev keymap fsck autodetect pata scsi sata usbinput encrypt 
lvm2 uresume filesystems"

Does anyone have a hint how I could "debug" this issue or get kexec to 
work on my system?

Kind regards

Jan


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
