Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from wm14.inbox.com ([208.50.6.14])
	by canuck.infradead.org with smtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IIGr3-0007iS-30
	for kexec@lists.infradead.org; Tue, 07 Aug 2007 00:39:39 -0400
Received: from inbox.com (127.0.0.1:25)
	by inbox.com with [InBox.Com SMTP Server]
	id <708060158105.WM14> for <kexec@lists.infradead.org> from
	<dseetharam@inbox.com>; Mon, 6 Aug 2007 8:39:13 PM -0800
Mime-Version: 1.0
Date: Mon, 6 Aug 2007 20:39:12 -0800
Message-ID: <680FB55E340.00000842dseetharam@inbox.com>
From: Dharmosoth Seetharam <dseetharam@inbox.com>
Subject: Mini kernel ( kexec ) is having boot time errors
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: vgoyal@in.ibm.com, kexec@lists.infradead.org

Hi,

I am getting the following error when my system gets panic it tries to
switch into mini kernel ( pre-loaded one).

pre-loaded the mini kernel with the following option.


/*
kexec -p /usr/u/seetharam/bin/vmlinux.10888 --initrd=/boot/initrd-2.6.20-aruba_0.0.10888.img --command-line=" root=/dev/system/rootvol console=ttyS0,19200n8 SPEED=19200 init 1 maxcpus=1 irqpoll " --serial-baud=19200 --console-vga  --console-serial --args-linux

*/

[root@tc210 root]# mount | grep root
/dev/system/rootvol on / type xfs (rw,sync)




[  359.466225] irq 19: nobody cared (try booting with the "irqpoll" option)
[  359.506286]
[  359.506287] Call Trace:
[  359.529762]  <IRQ>  [<ffffffff81053cc8>] __report_bad_irq+0x38/0x90
[  359.567313]  [<ffffffff81053dcd>] note_interrupt+0x8d/0xd0
[  359.600086]  [<ffffffff81054483>] handle_fasteoi_irq+0x93/0xb0
[  359.634936]  [<ffffffff8100c85d>] do_IRQ+0xfd/0x170
[  359.664071]  [<ffffffff8100a231>] ret_from_intr+0x0/0xb
[  359.695286]  [<ffffffff8102bfac>] vprintk+0x23c/0x250
[  359.725459]  [<ffffffff81053350>] handle_IRQ_event+0x20/0x60
[  359.759271]  [<ffffffff81053d91>] note_interrupt+0x51/0xd0
[  359.792041]  [<ffffffff81054574>] handle_edge_irq+0xd4/0x110
[  359.825851]  [<ffffffff8100c85d>] do_IRQ+0xfd/0x170
[  359.854990]  [<ffffffff81016b9e>] smp_local_timer_interrupt+0xe/0x30
[  359.892953]  [<ffffffff8100a231>] ret_from_intr+0x0/0xb
[  359.924167]  <EOI>
[  359.936736] handlers:
[  359.950292] [<ffffffff81200ac0>] (usb_hcd_irq+0x0/0x80)
[  359.981610] [<ffffffff81200ac0>] (usb_hcd_irq+0x0/0x80)
[  360.012927] Disabling IRQ #19
[  360.046773]    generic_sse:  5497.000 MB/sec
[  360.072317] raid5: using function: generic_sse (5497.000 MB/sec)
[  360.108256] md: md driver 0.90.0 MAX_MD_DEVS=1048576, MD_SB_DISKS=27
[  360.146413] device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redhat.com
[  360.196921] md: raidcm personality registered as nr 9
[  360.227155] IPv4 over IPv4 tunneling driver
[  360.252222] GRE over IPv4 tunneling driver
[  360.276890] TCP cubic registered
[  360.296234] NET: Registered protocol family 1
[  360.322311] NET: Registered protocol family 10
[  360.348987] IPv6 over IPv4 tunneling driver
[  360.374099] NET: Registered protocol family 17
[  360.400775] 802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
[  360.441379] All bugs added by David S. Miller <davem@redhat.com>
[  360.889982] md: Autodetecting RAID arrays.
[  360.914522] md: autorun ...
[  360.931240] md: ... autorun DONE.
[  360.951151] RAMDISK: Compressed image found at block 0
[  361.045990] RAMDISK: incomplete write (-28 != 32768) 8388608
[  361.429544] VFS: Cannot open root device "/dev/system/rootvol" or unknown-block(0,0)
[  361.475850] Please append a correct "root=" boot option
[  361.507115] Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
[  361.556556]                                                                                           


I have given the cmd parameter "irqpoll" but, suggesting me to use irqpoll...:)

Please help me in this regards.



Thanks,
Seetharam

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
