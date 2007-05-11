Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from usea-naimss1.unisys.com ([192.61.61.103])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Hmcul-0002x9-6D
	for kexec@lists.infradead.org; Fri, 11 May 2007 17:44:42 -0400
Subject: Does kexec on IA64 work?
From: Amul Shah <amul.shah@unisys.com>
Date: Fri, 11 May 2007 17:12:06 -0400
Message-Id: <1178917927.10349.210.camel@ustr-shaha1-linux2.na.uis.unisys.com>
Mime-Version: 1.0
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
To: kexec@lists.infradead.org

I am using a redhat derived 2.6.18 linux kernel and I am experiencing a
panic when the second kernel boots.  I can't find the exact set of
emails that I want to tell me that kexec on IA64 isn't ready yet.

Horms said this a month ago:
https://lists.linux-foundation.org/pipermail/fastboot/2007-March/013286.html
        My recommendation is that 2.6.21rc3 is a farily good release for
        kexec,
        and if you aren't worried about ia64 then 2.6.20 is probably
        good too.
        If you really need something against 2.6.9, then I guess you
        will have
        to try to pull the patches out of git, but that is going to be
        really hard work given that 2.6.9 is quite old now.

For the curious, the panic log is below.  I did a cursory inspection of
the kernel sources and found that the function start_secondary is called
from head.S.  I don't know much about IA64 arch and assembly, so I
thought I would ask first if the IA64 implementation works.

thanks,
Amul

--- serial log ---

Red Hat Enterprise Linux Server release 5 (Tikanga)
Kernel 2.6.18-8.el5 on an ia64

login: root

Password: 
Last login: Fri May 11 16:18:56 on tty2
[root@localhost ~]# 
[root@localhost ~]# runlevel 
N 5
[root@localhost ~]# 
[root@localhost ~]# init 3
[root@localhost ~]# 
[root@localhost ~]# cat kexec_early.cmd 
kexec -l /boot/efi/efi/redhat/vmlinuz-2.6.18-8.el5
--initrd=/boot/efi/efi/redhat
/initrd-2.6.18-8.el5kdump.img
--command-line="root=/dev/VolGroup00/LogVol00 rhgb
 ro earlyprintk=ttyS0,115200n8"
[root@localhost ~]# 
[root@localhost ~]# sh kexec_early.cmd 
[root@localhost ~]# 
[root@localhost ~]# cat /sys/kernel/kexec_loaded 
1
[root@localhost ~]# 
[root@localhost ~]# kexec -e

Message from syslogd@localhost at Fri May 11ACPI: Getting cpuindex for
acpiid 0x
4
ACPI: Getting cpuindex for acpiid 0x5
ACPI: Getting cpuindex for acpiid 0x6
ACPI: Getting cpuindex for acpiid 0x7
ACPI: Getting cpuindex for acpiid 0x8
ACPI: Getting cpuindex for acpiid 0x9
ACPI: Getting cpuindex for acpiid 0xa
ACPI: Getting cpuindex for acpiid 0xb
ACPI: Getting cpuindex for acpiid 0xc
ACPI: Getting cpuindex for acpiid 0xd
ACPI: Getting cpuindex for acpiid 0xe
ACPI: Getting cpuindex for acpiid 0xf
PCI: Device 0000:00:1f.1 not available because of resource collisions
Red Hat nash version 5.1.19.6 starting
lpfc 0000:11:01.0: 0:1303 Link Up Event x1 received Data: x1 x1 x8 x2
lpfc 0000:11:01.0: 0:1305 Link Down Event x2 received Data: x2 xd x11000
lpfc 0000:11:01.0: 0:1303 Link Up Event x3 received Data: x3 x1 x8 x2
lpfc 0000:11:01.1: 1:1303 Link Up Event x1 received Data: x1 x1 x8 x2
lpfc 0000:11:01.1: 1:1305 Link Down Event x2 received Data: x2 x20 x1000
lpfc 0000:11:01.1: 1:1303 Link Up Event x3 received Data: x3 x1 x8 x2
  Reading all physical volumes.  This may take a while...
  Found volume group "VolGroup00" using metadata type lvm2
  2 logical volume(s) in volume group "VolGroup00" now active
		Welcome to Red Hat Enterprise Linux Server
		Press 'I' to enter interactive startup.
Setting clock  (utc): Fri May 11 16:27:59 EDT 2007 [  OK  ]
Starting udev: [  OK  ]
Loading default keymap (us): [  OK  ]
Setting hostname localhost.localdomain:  [  OK  ]
Setting up Logical Volume Management:   2 logical volume(s) in volume
group "Vol
Group00" now active
[  OK  ]
Checking filesystems
Checking all file systems.
[/sbin/fsck.ext3 (1) -- /] fsck.ext3 -a /dev/VolGroup00/LogVol00 
/dev/VolGroup00/LogVol00: clean, 139278/4369472 files, 1091924/4366336
blocks
[  OK  ]
Remounting root filesystem in read-write mode:  [  OK  ]
Mounting local filesystems:  [  OK  ]
Enabling local filesystem quotas:  [  OK  ]
Enabling /etc/fstab swaps:  [  OK  ]
INIT: Entering runlevel: 5
Entering non-interactive startup
Starting background readahead: [  OK  ]
Checking for hardware changes [  OK  ]
Loading uscd driver...[  OK  ]
Starting uscm services...[  OK  ]
Starting uscr services...[  OK  ]
Bringing up loopback interface:  [  OK  ]
Bringing up interface eth0:  
Determining IP information for eth0... done.
[  OK  ]
Bringing up interface eth1:  
Determining IP information for eth1... failed; no link present.  Check
cable?
[FAILED]
Starting restorecond: [  OK  ]
Starting auditd: [  OK  ]
Starting system logger: [  OK  ]
Starting kernel logger: [  OK  ]
Starting irqbalance: [  OK  ]
Starting mcstransd: [  OK  ]
Starting portmap: [  OK  ]
Starting setroubleshootd: [  OK  ]
Starting NFS statd: [  OK  ]
Starting RPC idmapd: [  OK  ]
Starting kdump:[  OK  ]
Starting system message bus: [  OK  ]
Starting Bluetooth services:[  OK  ][  OK  ]
Mounting other filesystems:  [  OK  ]
Starting PC/SC smart card daemon (pcscd): [  OK  ]
Starting hidd: [  OK  ]
Starting autofs:  Loading autofs4: [  OK  ]
Starting automount: [  OK  ]
[  OK  ]
Starting acpi daemon: [  OK  ]
Starting hpiod: [  OK  ]
Starting hpssd: [  OK  ]
Starting cups: [  OK  ]
Starting sshd: [  OK  ]
Starting sendmail: [  OK  ]
Starting sm-client: [  OK  ]
Starting console mouse services: [  OK  ]
Starting crond: [  OK  ]
Starting xfs: [  OK  ]
Starting anacron: [  OK  ]
Starting atd: [  OK  ]
Starting salinfo_decode_all: [  OK  ]
Starting background readahead: [  OK  ]
Starting yum-updatesd: [  OK  ]
Starting Avahi daemon... [  OK  ]
Starting HAL daemon: [  OK  ]
Starting smartd: [  OK  ]

Red Hat Enterprise Linux Server release 5 (Tikanga)
Kernel 2.6.18-8.el5 on an ia64

localhost.localdomain login: root
Password: 
Login incorrect

login: root

Password: 
Last login: Fri May 11 16:22:11 on ttyS0
[root@localhost ~]# 
[root@localhost ~]# runlevel 
N 5
[root@localhost ~]# 
[root@localhost ~]# cat /sys/kernel/kexec_loaded 
0
[root@localhost ~]# 
[root@localhost ~]# init 3
[root@localhost ~]# 
INIT: Sending processes the TERM signal
[root@localhost ~]# Starting background readahead: [  OK  ]
Starting irqbalance: 
Starting setroubleshootd: 
Kdump already running[  OK  ]
Starting anacron: [  OK  ]

[root@localhost ~]# 
[root@localhost ~]# cat kexec_early.cmd 
kexec -l /boot/efi/efi/redhat/vmlinuz-2.6.18-8.el5
--initrd=/boot/efi/efi/redhat
/initrd-2.6.18-8.el5kdump.img
--command-line="root=/dev/VolGroup00/LogVol00 rhgb
 ro earlyprintk=ttyS0,115200n8"
[root@localhost ~]# 
[root@localhost ~]# sh kexec_early.cmd 
[root@localhost ~]# 
[root@localhost ~]# runlevel 
5 3
[root@localhost ~]# 
[root@localhost ~]# cat /sys/kernel/kexec_loaded 
1
[root@localhost ~]# 
[root@localhost ~]# kexec -e

Taking down system, will reboot
Synchronizing SCSI cache for disk sdv: 
Synchronizing SCSI cache for disk sdu: 
Starting new kernel

Message from syslogd@localhost at Fri May 11CPU 1 is now offline
huh, phys CPU#0x200, CPU#0x3 already present??
kernel BUG at arch/ia64/kernel/smpboot.c:392!
swapper[0]: bugcheck! 0 [1]
Modules linked in: autofs4 hidp rfcomm l2cap bluetooth sunrpc ipv6
uscd(U) vfat 
fat button parport_pc lp parport joydev sg mptsas mptscsih mptbase
shpchp scsi_t
ransport_sas e1000 ide_cd cdrom dm_snapshot dm_zero dm_mirror dm_mod
lpfc scsi_t
ransport_fc sd_mod scsi_mod ext3 jbd ehci_hcd ohci_hcd uhci_hcd

Pid: 0, CPU 3, comm:              swapper
psr : 00001010084a2010 ifs : 800000000000048c ip  : [<a0000001000567f0>]
Not 
tainted
ip is at start_secondary+0x170/0x420
unat: 0000000000000000 pfs : 000000000000048c rsc : 0000000000000003
rnat: aaaaaaaa55555555 bsps: 000000000001003e pr  : 0bad0bad0bada667
ldrs: 0000000000000000 ccv : 00000000ffffffff fpsr: 0009804c8a70433f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a0000001000567f0 b6  : a000000100062300 b7  : e0000000fd01d9b0
f6  : 0fffbccccccccc8c00000 f7  : 0ffdaf300000000000000
f8  : 10000c000000000000000 f9  : 10002a000000000000000
f10 : 0fffd9999999996900000 f11 : 1003e0000000000000000
r1  : a000000100bfe220 r2  : a000000100a157f0 r3  : a0000001009d67a8
r8  : 0000000000000031 r9  : a000000100c8c4c7 r10 : a000000100a15820
r11 : a000000100a15820 r12 : e00000080ce97e30 r13 : e00000080ce90000
r14 : a000000100a157f0 r15 : 0000000000000000 r16 : 0000000100000000
r17 : 0000000000000001 r18 : a000000100a15b4c r19 : ffffffffffffffff
r20 : 0000000000000000 r21 : a0000001009fe850 r22 : a000000100a15b80
r23 : a000000100849200 r24 : a0000001009fe850 r25 : a000000100a157f8
r26 : a000000100a157f8 r27 : 0000000000000000 r28 : 000000000000000a
r29 : 0000000000000000 r30 : 0000000000000000 r31 : a0000001009d67a0

Call Trace:
 [<a000000100014140>] show_stack+0x40/0xa0
                                sp=e00000080ce979c0 bsp=e00000080ce91228
 [<a000000100014a40>] show_regs+0x840/0x880
                                sp=e00000080ce97b90 bsp=e00000080ce911c8
 [<a000000100037ce0>] die+0x1c0/0x2c0
                                sp=e00000080ce97b90 bsp=e00000080ce91180
 [<a000000100037e30>] die_if_kernel+0x50/0x80
                                sp=e00000080ce97bb0 bsp=e00000080ce91150
 [<a000000100617c00>] ia64_bad_break+0x280/0x4a0
                                sp=e00000080ce97bb0 bsp=e00000080ce91128
 [<a00000010000c700>] __ia64_leave_kernel+0x0/0x280
                                sp=e00000080ce97c60 bsp=e00000080ce91128
 [<a0000001000567f0>] start_secondary+0x170/0x420
                                sp=e00000080ce97e30 bsp=e00000080ce910c8
 [<a0000001000085e0>] __end_ivt_text+0x6c0/0x6f0
                                sp=e00000080ce97e30 bsp=e00000080ce910a0
 <0>Kernel panic - not syncing: Fatal exception
 <3>huh, phys CPU#0x400, CPU#0x3 already present??
kernel BUG at arch/ia64/kernel/smpboot.c:392!
swapper[0]: bugcheck! 0 [2]
Modules linked in: autofs4 hidp rfcomm l2cap bluetooth sunrpc ipv6
uscd(U) vfat 
fat button parport_pc lp parport joydev sg mptsas mptscsih mptbase
shpchp scsi_t
ransport_sas e1000 ide_cd cdrom dm_snapshot dm_zero dm_mirror dm_mod
lpfc scsi_t
ransport_fc sd_mod scsi_mod ext3 jbd ehci_hcd ohci_hcd uhci_hcd

Pid: 0, CPU 3, comm:              swapper
psr : 00001010084a2010 ifs : 800000000000048c ip  : [<a0000001000567f0>]
Not 
tainted
ip is at start_secondary+0x170/0x420
unat: 0000000000000000 pfs : 000000000000048c rsc : 0000000000000003
rnat: aaaaaaaa55555555 bsps: 000000000001003e pr  : 0bad0bad0bada667
ldrs: 0000000000000000 ccv : 00000000ffffffff fpsr: 0009804c8a70433f
csd : 0000000000000000 ssd : 0000000000000000
b0  : a0000001000567f0 b6  : a000000100062300 b7  : e0000000fd01d9b0
f6  : 0fffbccccccccc8c00000 f7  : 0ffdaf300000000000000
f8  : 10000c000000000000000 f9  : 10002a000000000000000
f10 : 0fffd9999999996900000 f11 : 1003e0000000000000000
r1  : a000000100bfe220 r2  : a000000100a157f0 r3  : a0000001009d67a8
r8  : 0000000000000031 r9  : a000000100c8cfef r10 : a000000100a15820
r11 : a000000100a15820 r12 : e00000080ce97e30 r13 : e00000080ce90000
r14 : a000000100a157f0 r15 : 0000000000000000 r16 : 0000000100000000
r17 : 0000000000000001 r18 : a000000100a15b4c r19 : ffffffffffffffff
r20 : 0000000000000000 r21 : a0000001009fe850 r22 : a000000100a15b80
r23 : a000000100849200 r24 : a0000001009fe850 r25 : a000000100a157f8
r26 : a000000100a157f8 r27 : 0000000000000000 r28 : 000000000000000a
r29 : 0000000000000000 r30 : 0000000000000000 r31 : a0000001009d67a0

Call Trace:
 [<a000000100014140>] show_stack+0x40/0xa0
                                sp=e00000080ce979c0 bsp=e00000080ce91228
 [<a000000100014a40>] show_regs+0x840/0x880
                                sp=e00000080ce97b90 bsp=e00000080ce911c8
 [<a000000100037ce0>] die+0x1c0/0x2c0
                                sp=e00000080ce97b90 bsp=e00000080ce91180
 [<a000000100037e30>] die_if_kernel+0x50/0x80
                                sp=e00000080ce97bb0 bsp=e00000080ce91150
 [<a000000100617c00>] ia64_bad_break+0x280/0x4a0
                                sp=e00000080ce97bb0 bsp=e00000080ce91128
 [<a00000010000c700>] __ia64_leave_kernel+0x0/0x280
                                sp=e00000080ce97c60 bsp=e00000080ce91128
 [<a0000001000567f0>] start_secondary+0x170/0x420
                                sp=e00000080ce97e30 bsp=e00000080ce910c8
 [<a0000001000085e0>] __end_ivt_text+0x6c0/0x6f0
                                sp=e00000080ce97e30 bsp=e00000080ce910a0
 <0>Kernel panic - not syncing: Fatal exception
 BUG: warning at kernel/panic.c:137/panic() (Not tainted)

Call Trace:
 [<a000000100014140>] show_stack+0x40/0xa0
                                sp=e00000080ce97970 bsp=e00000080ce91250
 [<a0000001000141d0>] dump_stack+0x30/0x60
                                sp=e00000080ce97b40 bsp=e00000080ce91238
 [<a000000100078550>] panic+0x410/0x440
                                sp=e00000080ce97b40 bsp=e00000080ce911c8
 [<a000000100037db0>] die+0x290/0x2c0
                                sp=e00000080ce97b90 bsp=e00000080ce91180
 [<a000000100037e30>] die_if_kernel+0x50/0x80
                                sp=e00000080ce97bb0 bsp=e00000080ce91150
 [<a000000100617c00>] ia64_bad_break+0x280/0x4a0
                                sp=e00000080ce97bb0 bsp=e00000080ce91128
 [<a00000010000c700>] __ia64_leave_kernel+0x0/0x280
                                sp=e00000080ce97c60 bsp=e00000080ce91128



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
