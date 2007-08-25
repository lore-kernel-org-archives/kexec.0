Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from xenotime.net ([66.160.160.81])
	by canuck.infradead.org with smtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IOj5z-0007nE-83
	for kexec@lists.infradead.org; Fri, 24 Aug 2007 20:01:56 -0400
Received: from midway.site ([96.225.192.201]) by xenotime.net for
	<kexec@lists.infradead.org>; Fri, 24 Aug 2007 17:01:40 -0700
Date: Fri, 24 Aug 2007 17:01:39 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: kexec+kdump + vmcoreinfo patch
Message-Id: <20070824170139.021be621.rdunlap@xenotime.net>
In-Reply-To: <20070824144147.5e1cadc2.rdunlap@xenotime.net>
References: <20070824144147.5e1cadc2.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="Multipart=_Fri__24_Aug_2007_17_01_39_-0700_/FSzBheVc64d0qbi"
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

This is a multi-part message in MIME format.

--Multipart=_Fri__24_Aug_2007_17_01_39_-0700_/FSzBheVc64d0qbi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Aug 2007 14:41:47 -0700 Randy Dunlap wrote:

> Hi,
> 
> I'm trying to use the recent vmcoreinfo patch...

> c.  My 2.6.23-rc3 dump-capture kernel currently faults a few times,
> then it panics.  I'll add a serial console and capture its output
> to see what is going on.

I booted 3 times with no problems (without serial console on the
dump-capture kernel), then I added a serial console to that kernel
and got lots of problems.  They all seem to be OOM problems, then
the kernel gives up and falls over.  (log attached)


d.  Documentation/kdump/kdump.txt mentions an option to produce
ELF32 headers instead of 64-bit headers:  --elf32-core-headers.
Where is this option used?  I.e., what program recognizes it?
kdump.txt isn't telling me this info and I can't read it between
the lines.


Thanks.
---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***

--Multipart=_Fri__24_Aug_2007_17_01_39_-0700_/FSzBheVc64d0qbi
Content-Type: text/x-log;
 name="dump-capture.log"
Content-Disposition: attachment;
 filename="dump-capture.log"
Content-Transfer-Encoding: 7bit

SysRq : Trigger a crashdump
Linux version 2.6.23-rc3 (rddunlap@unicorn) (gcc version 4.1.2 20061115 (prerelease) (SUSE Linux)) #5 SMP Thu Aug 23 15:51:37 PDT 2007
Command line: root=/dev/hda8 maxcpus=1 irqpoll 3 console=ttyS0,115200n8 memmap=exactmap memmap=640K@0K memmap=64880K@17024K elfcorehdr=81904K memmap=56K#1048320K memmap=136K#1048376K
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000100 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e8000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffc0000 (usable)
 BIOS-e820: 000000003ffc0000 - 000000003ffce000 (ACPI data)
 BIOS-e820: 000000003ffce000 - 000000003fff0000 (ACPI NVS)
 BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fecc0000 - 00000000fecc1000 (reserved)
 BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
end_pfn_map = 1048576
user-defined physical RAM map:
 user: 0000000000000000 - 00000000000a0000 (usable)
 user: 00000000010a0000 - 0000000004ffc000 (usable)
 user: 000000003ffc0000 - 000000003ffce000 (ACPI data)
 user: 000000003ffce000 - 000000003fff0000 (ACPI data)
end_pfn_map = 262128
DMI 2.3 present.
ACPI: RSDP 000F87C0, 0014 (r0 ACPIAM)
ACPI: RSDT 3FFC0000, 0034 (r1 A M I  OEMRSDT   9000528 MSFT       97)
ACPI: FACP 3FFC0200, 0084 (r2 A M I  OEMFACP   9000528 MSFT       97)
ACPI: DSDT 3FFC0440, 45ED (r1  12345 12345123      123 INTL  2002026)
ACPI: FACS 3FFCE000, 0040
ACPI: APIC 3FFC0390, 0068 (r1 A M I  OEMAPIC   9000528 MSFT       97)
ACPI: MCFG 3FFC0400, 003C (r1 A M I  OEMMCFG   9000528 MSFT       97)
ACPI: OEMB 3FFCE040, 0046 (r1 A M I  AMI_OEM   9000528 MSFT       97)
Scanning NUMA topology in Northbridge 24
CPU has 1 num_cores
No NUMA configuration found
Faking a node at 0000000000000000-0000000004ffc000
Bootmem setup node 0 0000000000000000-0000000004ffc000
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
Movable zone start PFN for each node
early_node_map[2] active PFN ranges
    0:        0 ->      160
    0:     4256 ->    20476
Looks like a VIA chipset. Disabling IOMMU. Override with iommu=allowed
ACPI: PM-Timer IO Port: 0x808
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x81] disabled)
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x02] address[0xfecc0000] gsi_base[24])
IOAPIC[1]: apic_id 2, address 0xfecc0000, GSI 24-47
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 40000000 (gap: 3fff0000:c0010000)
SMP: Allowing 2 CPUs, 1 hotplug CPUs
PERCPU: Allocating 428296 bytes of per cpu data
Built 1 zonelists in Node order.  Total pages: 15893
Policy zone: DMA32
Kernel command line: root=/dev/hda8 maxcpus=1 irqpoll 3 console=ttyS0,115200n8 memmap=exactmap memmap=640K@0K memmap=64880K@17024K elfcorehdr=81904K memmap=56K#1048320K memmap=136K#1048376K
Misrouted IRQ fixup and polling support enabled
This may significantly impact system performance
Initializing CPU#0
PID hash table entries: 256 (order: 8, 2048 bytes)
time.c: Detected 1000.063 MHz processor.
Console: colour dummy device 80x25
console [ttyS0] enabled
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:    8
... MAX_LOCK_DEPTH:          30
... MAX_LOCKDEP_KEYS:        2048
... CLASSHASH_SIZE:           1024
... MAX_LOCKDEP_ENTRIES:     8192
... MAX_LOCKDEP_CHAINS:      16384
... CHAINHASH_SIZE:          8192
 memory used by lock dependency info: 1712 kB
 per task-struct memory footprint: 2160 bytes
Memory: 52624k/81904k available (3234k kernel code, 12896k reserved, 1776k data, 720k init)
Calibrating delay using timer specific routine.. 2096.04 BogoMIPS (lpj=4192088)
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU 0/0 -> Node 0
lockdep: not fixing up alternatives.
ACPI: Core revision 20070126
Using local APIC timer interrupts.
result 12500807
Detected 12.500 MHz APIC timer.
Brought up 1 CPUs
khelper used greatest stack depth: 6336 bytes left
NET: Registered protocol family 16
No dock devices found.
ACPI: bus type pci registered
PCI: BIOS Bug: MCFG area at e0000000 is not E820-reserved
PCI: Not using MMCONFIG.
PCI: Using configuration type 1
khelper used greatest stack depth: 6128 bytes left
khelper used greatest stack depth: 6000 bytes left
ACPI: Interpreter enabled
ACPI: (supports S0 S1 S3)
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: MSI-K8T-Neo2Fir, attempting to turn soundcard ON
PCI: MSI-K8T-Neo2Fir, soundcard on
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI Warning (tbutils-0158): Incorrect checksum in table [OEMB] -  C8, should be C3 [20070126]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: PnP ACPI: found 14 devices
ACPI: ACPI bus type pnp unregistered
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
agpgart: Detected AGP bridge 0
agpgart: AGP aperture is 64M @ 0xcc000000
Time: tsc clocksource has been installed.
pnp: 00:08: ioport range 0xa00-0xa0f has been reserved
pnp: 00:08: ioport range 0x290-0x29f has been reserved
pnp: 00:08: ioport range 0xa20-0xa2f has been reserved
pnp: 00:08: ioport range 0xa30-0xa3f has been reserved
pnp: 00:08: ioport range 0xa40-0xa4f has been reserved
pnp: 00:09: iomem range 0xffb80000-0xffbfffff has been reserved
pnp: 00:09: iomem range 0xfff00000-0xfff7fffe has been reserved
pnp: 00:0a: iomem range 0xfec00000-0xfec00fff has been reserved
pnp: 00:0a: iomem range 0xfee00000-0xfee00fff could not be reserved
pnp: 00:0c: iomem range 0xe0000000-0xefffffff has been reserved
pnp: 00:0d: iomem range 0x0-0x9ffff could not be reserved
pnp: 00:0d: iomem range 0xc0000-0xcffff has been reserved
pnp: 00:0d: iomem range 0xe0000-0xfffff has been reserved
pnp: 00:0d: iomem range 0x100000-0x3fffffff could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:02.0
  IO window: c000-cfff
  MEM window: fea00000-feafffff
  PREFETCH window: b7f00000-c7efffff
PCI: Bridge: 0000:00:03.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:03.1
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:03.2
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:03.3
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 27 (level, low) -> IRQ 27
ACPI: PCI Interrupt 0000:00:03.0[A] -> GSI 31 (level, low) -> IRQ 31
ACPI: PCI Interrupt 0000:00:03.1[B] -> GSI 31 (level, low) -> IRQ 31
ACPI: PCI Interrupt 0000:00:03.2[C] -> GSI 39 (level, low) -> IRQ 39
ACPI: PCI Interrupt 0000:00:03.3[D] -> GSI 31 (level, low) -> IRQ 31
NET: Registered protocol family 2
IP route cache hash table entries: 512 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 5, 147456 bytes)
TCP bind hash table entries: 2048 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 2048 bind 2048)
TCP reno registered
microcode: CPU0 not a capable Intel processor
IA-32 Microcode Update Driver: v1.14a <tigran@aivazian.fsnet.co.uk>
audit: initializing netlink socket (disabled)
audit(1187974495.856:1): initialized
Total HugeTLB memory allocated, 0
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: VIA PCI bridge detected. Disabling DAC.
assign_interrupt_mode Found MSI capability
assign_interrupt_mode Found MSI capability
assign_interrupt_mode Found MSI capability
assign_interrupt_mode Found MSI capability
assign_interrupt_mode Found MSI capability
vesafb: framebuffer at 0xb8000000, mapped to 0xffffc20000100000, using 3072k, total 3072k
vesafb: mode is 1024x768x16, linelength=2048, pages=768
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
input: Power Button (FF) as /class/input/input0
ACPI: Power Button (FF) [PWRF]
input: Sleep Button (CM) as /class/input/input1
ACPI: Sleep Button (CM) [SLPB]
input: Power Button (CM) as /class/input/input2
ACPI: Power Button (CM) [PWRB]
ACPI: Processor [CPU1] (supports 16 throttling states)
ACPI Exception (processor_core-0790): AE_NOT_FOUND, Processor Device is not present [20070126]
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
ppdev: user-space parallel port driver
Linux agpgart interface v0.102
[drm] Initialized drm 1.1.0 20060810
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
Hangcheck: Using get_cycles().
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0b: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
parport_pc 00:07: reported by Plug and Play ACPI
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
floppy0: no floppy controllers found
RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
Intel(R) PRO/1000 Network Driver - version 7.3.20-k2
Copyright (c) 1999-2006 Intel Corporation.
e100: Intel(R) PRO/100 Network Driver, 3.5.23-k4-NAPI
e100: Copyright(c) 1999-2006 Intel Corporation
via-rhine.c:v1.10-LK1.4.3 2007-03-06 Written by Donald Becker
ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 23 (level, low) -> IRQ 23
eth0: VIA Rhine II at 0xfebfcc00, 00:14:2a:c9:24:d3, IRQ 23.
eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 45e1.
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
netconsole: not configured, aborting
Linux video capture interface: v2.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hda: MAXTOR STM3200820A, ATA DISK drive
hdc: TSSTcorpCD/DVDW SH-W162C, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 512KiB
hda: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63
hda: cache flushes supported
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 hda8 >
hdc: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
ACPI: PCI Interrupt 0000:00:09.2[C] -> GSI 16 (level, low) -> IRQ 16
ehci_hcd 0000:00:09.2: EHCI Host Controller
ehci_hcd 0000:00:09.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:09.2: irq 16, io mem 0xfebff400
ehci_hcd 0000:00:09.2: USB 2.0 started, EHCI 0.95, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 5 ports detected
ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level, low) -> IRQ 21
ehci_hcd 0000:00:10.4: EHCI Host Controller
ehci_hcd 0000:00:10.4: new USB bus registered, assigned bus number 2
ehci_hcd 0000:00:10.4: irq 21, io mem 0xfebff000
ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 8 ports detected
ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 18 (level, low) -> IRQ 18
ohci_hcd 0000:00:09.0: OHCI Host Controller
ohci_hcd 0000:00:09.0: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:09.0: irq 18, io mem 0xfebfe000
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
usb 2-7: new high speed USB device using ehci_hcd and address 2
usb 2-7: configuration #1 chosen from 1 choice
ACPI: PCI Interrupt 0000:00:09.1[B] -> GSI 19 (level, low) -> IRQ 19
ohci_hcd 0000:00:09.1: OHCI Host Controller
ohci_hcd 0000:00:09.1: new USB bus registered, assigned bus number 4
ohci_hcd 0000:00:09.1: irq 19, io mem 0xfebfd000
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:10.0: irq 21, io base 0x0000e800
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 6
uhci_hcd 0000:00:10.1: irq 21, io base 0x0000e400
usb usb6: configuration #1 chosen from 1 choice
hub 6-0:1.0: USB hub found
hub 6-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 7
uhci_hcd 0000:00:10.2: irq 21, io base 0x0000e000
usb usb7: configuration #1 chosen from 1 choice
hub 7-0:1.0: USB hub found
hub 7-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level, low) -> IRQ 21
uhci_hcd 0000:00:10.3: UHCI Host Controller
uhci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 8
uhci_hcd 0000:00:10.3: irq 21, io base 0x0000dc00
usb usb8: configuration #1 chosen from 1 choice
hub 8-0:1.0: USB hub found
hub 8-0:1.0: 2 ports detected
usbcore: registered new interface driver libusual
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard as /class/input/input3
input: PC Speaker as /class/input/input4
input: ImPS/2 Generic Wheel Mouse as /class/input/input5
i2c /dev entries driver
Software Watchdog Timer: 0.07 initialized. soft_noboot=0 soft_margin=60 sec (nowayout= 0)
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
ieee80211: 802.11 data/management/control stack, git-1.1.13
ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
powernow-k8: Found 1 AMD Athlon(tm) 64 Processor 3500+ processors (1 cpu cores) (version 2.00.00)
powernow-k8:    0 : fid 0xe (2200 MHz), vid 0x8
powernow-k8:    1 : fid 0xc (2000 MHz), vid 0x8
powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xa
powernow-k8:    3 : fid 0x2 (1000 MHz), vid 0x12
Marking TSC unstable due to cpufreq changes
Time: acpi_pm clocksource has been installed.
BIOS EDD facility v0.16 2004-Jun-25, 0 devices found
EDD information not available.
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: hda8: orphan cleanup on readonly fs
EXT3-fs: hda8: 1 orphan inode deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 720k freed
Write protecting the kernel read-only data: 1324k
INIT: version 2.86 booting
stty used greatest stack depth: 4472 bytes left
System Boot Control: Running /etc/init.d/boot
Mounting procfs at /procmount used greatest stack depth: 4408 bytes left
done
Mounting sysfs at /sysdone
Mounting debugfs at /sys/kernel/debugdone
Mounting tmpfs at /devdone
Initializing /devcp used greatest stack depth: 3880 bytes left
done
Mounting devpts at /dev/ptsdone
Starting udevd lp0: using parport0 (interrupt-driven).
lp0: console ready
vol_id invoked oom-killer: gfp_mask=0x201d0, order=0, oomkilladj=-17

Call Trace:
 [<ffffffff8023baad>] printk_ratelimit+0x15/0x17
 [<ffffffff802709c5>] out_of_memory+0x74/0x297
 [<ffffffff80272d26>] __alloc_pages+0x240/0x2cd
 [<ffffffff8028984a>] alloc_pages_current+0x78/0x7d
 [<ffffffff8026dfd1>] __page_cache_alloc+0xb/0xd
 [<ffffffff80274543>] __do_page_cache_readahead+0xbe/0x242
 [<ffffffff80253dc1>] lock_release_holdtime+0x45/0x4a
 [<ffffffff802548d1>] __lock_acquire+0x3ed/0x6ab
 [<ffffffff80253dc1>] lock_release_holdtime+0x45/0x4a
 [<ffffffff8027493d>] ondemand_readahead+0xfa/0x104
 [<ffffffff802749de>] page_cache_sync_readahead+0x18/0x1a
 [<ffffffff8026e2f1>] do_generic_mapping_read+0x104/0x440
 [<ffffffff8026db5b>] file_read_actor+0x0/0x10d
 [<ffffffff8026fbbb>] generic_file_aio_read+0x122/0x161
 [<ffffffff8029298d>] do_sync_read+0xe2/0x126
 [<ffffffff802548d1>] __lock_acquire+0x3ed/0x6ab
 [<ffffffff8024e124>] autoremove_wake_function+0x0/0x38
 [<ffffffff80293124>] vfs_read+0xab/0x134
 [<ffffffff802934e9>] sys_read+0x47/0x6f
 [<ffffffff8020bd5e>] system_call+0x7e/0x83

Mem-info:
Node 0 DMA per-cpu:
CPU    0: Hot: hi:    0, btch:   1 usd:   0   Cold: hi:    0, btch:   1 usd:   0
Node 0 DMA32 per-cpu:
CPU    0: Hot: hi:   18, btch:   3 usd:  14   Cold: hi:    6, btch:   1 usd:   0
Active:5429 inactive:68 dirty:2 writeback:0 unstable:0
 free:311 slab:2465 mapped:1 pagetables:1478 bounce:0
Node 0 DMA free:244kB min:0kB low:0kB high:0kB active:76kB inactive:0kB present:224kB pages_scanned:211 all_unreclaimable? yes
lowmem_reserve[]: 0 61 61 61
Node 0 DMA32 free:1000kB min:1004kB low:1252kB high:1504kB active:21640kB inactive:272kB present:63348kB pages_scanned:65631 all_unreclaimable? yes
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 1*4kB 0*8kB 1*16kB 1*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 244kB
Node 0 DMA32: 0*4kB 1*8kB 0*16kB 1*32kB 1*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 1000kB
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 0kB
Total swap = 0kB
Free swap:            0kB
20476 pages of RAM
7172 reserved pages
5899 pages shared
0 pages swap cached
Out of memory: kill process 680 (boot) score 309 or a child
Killed process 701 (S01boot.udev)
udevsettle invoked oom-killer: gfp_mask=0xa01d2, order=0, oomkilladj=0

Call Trace:
 [<ffffffff8023baad>] printk_ratelimit+0x15/0x17
 [<ffffffff802709c5>] out_of_memory+0x74/0x297
 [<ffffffff80272d26>] __alloc_pages+0x240/0x2cd
 [<ffffffff8028984a>] alloc_pages_current+0x78/0x7d
 [<ffffffff8026dfd1>] __page_cache_alloc+0xb/0xd
 [<ffffffff80274543>] __do_page_cache_readahead+0xbe/0x242
 [<ffffffff802548d1>] __lock_acquire+0x3ed/0x6ab
 [<ffffffff80253dc1>] lock_release_holdtime+0x45/0x4a
 [<ffffffff80274a35>] do_page_cache_readahead+0x55/0x62
 [<ffffffff8026fd67>] filemap_fault+0x16d/0x32c
 [<ffffffff802797b6>] __do_fault+0x65/0x36c
 [<ffffffff8027b39b>] handle_mm_fault+0x1e7/0x74a
 [<ffffffff8052466c>] do_page_fault+0x35f/0x829
 [<ffffffff8052472b>] do_page_fault+0x41e/0x829
 [<ffffffff80250abb>] hrtimer_nanosleep+0x65/0x12a
 [<ffffffff80250597>] hrtimer_wakeup+0x0/0x21
 [<ffffffff80521161>] do_nanosleep+0x42/0x81
 [<ffffffff80522b3d>] error_exit+0x0/0x84

Mem-info:
Node 0 DMA per-cpu:
CPU    0: Hot: hi:    0, btch:   1 usd:   0   Cold: hi:    0, btch:   1 usd:   0
Node 0 DMA32 per-cpu:
CPU    0: Hot: hi:   18, btch:   3 usd:  14   Cold: hi:    6, btch:   1 usd:   0
Active:5429 inactive:68 dirty:2 writeback:0 unstable:0
 free:311 slab:2465 mapped:1 pagetables:1478 bounce:0
Node 0 DMA free:244kB min:0kB low:0kB high:0kB active:76kB inactive:0kB present:224kB pages_scanned:211 all_unreclaimable? yes
lowmem_reserve[]: 0 61 61 61
Node 0 DMA32 free:1000kB min:1004kB low:1252kB high:1504kB active:21640kB inactive:272kB present:63348kB pages_scanned:65631 all_unreclaimable? yes
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 1*4kB 0*8kB 1*16kB 1*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 244kB
Node 0 DMA32: 0*4kB 1*8kB 0*16kB 1*32kB 1*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 1000kB
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 0kB
Total swap = 0kB
Free swap:            0kB
20476 pages of RAM
7172 reserved pages
5899 pages shared
0 pages swap cached
/etc/init.d/boot: line 201:   701 Killed                  $i start
hwup invoked oom-killer: gfp_mask=0xa01d2, order=0, oomkilladj=-17

Call Trace:
 [<ffffffff8023baad>] printk_ratelimit+0x15/0x17
 [<ffffffff802709c5>] out_of_memory+0x74/0x297
 [<ffffffff80272d26>] __alloc_pages+0x240/0x2cd
 [<ffffffff8028984a>] alloc_pages_current+0x78/0x7d
 [<ffffffff8026dfd1>] __page_cache_alloc+0xb/0xd
 [<ffffffff80274543>] __do_page_cache_readahead+0xbe/0x242
 [<ffffffff802548d1>] __lock_acquire+0x3ed/0x6ab
 [<ffffffff80253dc1>] lock_release_holdtime+0x45/0x4a
 [<ffffffff80274a35>] do_page_cache_readahead+0x55/0x62
 [<ffffffff8026fd67>] filemap_fault+0x16d/0x32c
 [<ffffffff802797b6>] __do_fault+0x65/0x36c
 [<ffffffff802548d1>] __lock_acquire+0x3ed/0x6ab
 [<ffffffff8027b39b>] handle_mm_fault+0x1e7/0x74a
 [<ffffffff8052466c>] do_page_fault+0x35f/0x829
 [<ffffffff8052472b>] do_page_fault+0x41e/0x829
 [<ffffffff80253dc1>] lock_release_holdtime+0x45/0x4a
 [<ffffffff805225bc>] _spin_unlock_irq+0x26/0x2b
 [<ffffffff8051f8e9>] __sched_text_start+0x6a1/0x6d6
 [<ffffffff8051f9a6>] thread_return+0x88/0x134
 [<ffffffff805225bc>] _spin_unlock_irq+0x26/0x2b
 [<ffffffff80522b3d>] error_exit+0x0/0x84

Mem-info:
Node 0 DMA per-cpu:
CPU    0: Hot: hi:    0, btch:   1 usd:   0   Cold: hi:    0, btch:   1 usd:   0
Node 0 DMA32 per-cpu:
CPU    0: Hot: hi:   18, btch:   3 usd:   7   Cold: hi:    6, btch:   1 usd:   1
Active:7000 inactive:38 dirty:0 writeback:0 unstable:0
 free:310 slab:2595 mapped:4 pagetables:1655 bounce:0
Node 0 DMA free:236kB min:0kB low:0kB high:0kB active:248kB inactive:0kB present:224kB pages_scanned:465 all_unreclaimable? yes
lowmem_reserve[]: 0 61 61 61
Node 0 DMA32 free:1004kB min:1004kB low:1252kB high:1504kB active:27752kB inactive:152kB present:63348kB pages_scanned:239567 all_unreclaimable? yes
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 1*4kB 1*8kB 0*16kB 1*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 236kB
Node 0 DMA32: 3*4kB 0*8kB 2*16kB 0*32kB 1*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 1004kB
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 0kB
Total swap = 0kB
Free swap:            0kB
20476 pages of RAM
7172 reserved pages
5595 pages shared
0 pages swap cached
Out of memory: kill process 680 (boot) score 309 or a child
Killed process 1461 (S02boot.rootfsc)
S02boot.rootfsc invoked oom-killer: gfp_mask=0xa01d2, order=0, oomkilladj=0

Call Trace:
 [<ffffffff8023baad>] printk_ratelimit+0x15/0x17
 [<ffffffff802709c5>] out_of_memory+0x74/0x297
 [<ffffffff80272d26>] __alloc_pages+0x240/0x2cd
 [<ffffffff8028984a>] alloc_pages_current+0x78/0x7d
 [<ffffffff8026dfd1>] __page_cache_alloc+0xb/0xd
 [<ffffffff80274543>] __do_page_cache_readahead+0xbe/0x242
 [<ffffffff802548d1>] __lock_acquire+0x3ed/0x6ab
 [<ffffffff80253dc1>] lock_release_holdtime+0x45/0x4a
 [<ffffffff80274a35>] do_page_cache_readahead+0x55/0x62
 [<ffffffff8026fd67>] filemap_fault+0x16d/0x32c
 [<ffffffff802797b6>] __do_fault+0x65/0x36c
 [<ffffffff802548d1>] __lock_acquire+0x3ed/0x6ab
 [<ffffffff8027b39b>] handle_mm_fault+0x1e7/0x74a
 [<ffffffff8052466c>] do_page_fault+0x35f/0x829
 [<ffffffff8052472b>] do_page_fault+0x41e/0x829
 [<ffffffff80295c34>] sys_newstat+0x31/0x3c
 [<ffffffff80522b3d>] error_exit+0x0/0x84

Mem-info:
Node 0 DMA per-cpu:
CPU    0: Hot: hi:    0, btch:   1 usd:   0   Cold: hi:    0, btch:   1 usd:   0
Node 0 DMA32 per-cpu:
CPU    0: Hot: hi:   18, btch:   3 usd:   7   Cold: hi:    6, btch:   1 usd:   1
Active:7000 inactive:38 dirty:0 writeback:0 unstable:0
 free:310 slab:2595 mapped:4 pagetables:1655 bounce:0
Node 0 DMA free:236kB min:0kB low:0kB high:0kB active:248kB inactive:0kB present:224kB pages_scanned:465 all_unreclaimable? yes
lowmem_reserve[]: 0 61 61 61
Node 0 DMA32 free:1004kB min:1004kB low:1252kB high:1504kB active:27752kB inactive:152kB present:63348kB pages_scanned:239567 all_unreclaimable? yes
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 1*4kB 1*8kB 0*16kB 1*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 236kB
Node 0 DMA32: 3*4kB 0*8kB 2*16kB 0*32kB 1*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 1004kB
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 0kB
Total swap = 0kB
Free swap:            0kB
20476 pages of RAM
7172 reserved pages
5595 pages shared
0 pages swap cached
init invoked oom-killer: gfp_mask=0xa01d2, order=0, oomkilladj=0

Call Trace:
 [<ffffffff8023baad>] printk_ratelimit+0x15/0x17
 [<ffffffff802709c5>] out_of_memory+0x74/0x297
 [<ffffffff80272d26>] __alloc_pages+0x240/0x2cd
 [<ffffffff8028984a>] alloc_pages_current+0x78/0x7d
 [<ffffffff8026dfd1>] __page_cache_alloc+0xb/0xd
 [<ffffffff80274543>] __do_page_cache_readahead+0xbe/0x242
 [<ffffffff802548d1>] __lock_acquire+0x3ed/0x6ab
 [<ffffffff80253dc1>] lock_release_holdtime+0x45/0x4a
 [<ffffffff80274a35>] do_page_cache_readahead+0x55/0x62
 [<ffffffff8026fd67>] filemap_fault+0x16d/0x32c
 [<ffffffff802dce26>] ext3_get_block+0x0/0xed
 [<ffffffff802797b6>] __do_fault+0x65/0x36c
 [<ffffffff802548d1>] __lock_acquire+0x3ed/0x6ab
 [<ffffffff8027b39b>] handle_mm_fault+0x1e7/0x74a
 [<ffffffff8052466c>] do_page_fault+0x35f/0x829
 [<ffffffff8052472b>] do_page_fault+0x41e/0x829
 [<ffffffff802548d1>] __lock_acquire+0x3ed/0x6ab
 [<ffffffff80253dc1>] lock_release_holdtime+0x45/0x4a
 [<ffffffff805225e7>] _read_unlock_irq+0x26/0x2b
 [<ffffffff80522b3d>] error_exit+0x0/0x84
 [<ffffffff80334c3b>] __strncpy_from_user+0x38/0x51
 [<ffffffff80334c2a>] __strncpy_from_user+0x27/0x51
 [<ffffffff80334c92>] strncpy_from_user+0x3e/0x48
 [<ffffffff8029b049>] getname+0x14e/0x1b8
 [<ffffffff8029ce6c>] __user_walk_fd+0x22/0x5c
 [<ffffffff80295a23>] vfs_stat_fd+0x27/0x5d
 [<ffffffff8052476f>] do_page_fault+0x462/0x829
 [<ffffffff802548d1>] __lock_acquire+0x3ed/0x6ab
 [<ffffffff80295c25>] sys_newstat+0x22/0x3c
 [<ffffffff80522b3d>] error_exit+0x0/0x84
 [<ffffffff8020bd5e>] system_call+0x7e/0x83

Mem-info:
Node 0 DMA per-cpu:
CPU    0: Hot: hi:    0, btch:   1 usd:   0   Cold: hi:    0, btch:   1 usd:   0
Node 0 DMA32 per-cpu:
CPU    0: Hot: hi:   18, btch:   3 usd:   7   Cold: hi:    6, btch:   1 usd:   0
Active:7000 inactive:70 dirty:0 writeback:0 unstable:0
 free:295 slab:2595 mapped:4 pagetables:1655 bounce:0
Node 0 DMA free:236kB min:0kB low:0kB high:0kB active:248kB inactive:0kB present:224kB pages_scanned:465 all_unreclaimable? yes
lowmem_reserve[]: 0 61 61 61
Node 0 DMA32 free:944kB min:1004kB low:1252kB high:1504kB active:27752kB inactive:280kB present:63348kB pages_scanned:239567 all_unreclaimable? yes
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 1*4kB 1*8kB 0*16kB 1*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 236kB
Node 0 DMA32: 0*4kB 1*8kB 0*16kB 1*32kB 0*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 936kB
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 0kB
Total swap = 0kB
Free swap:            0kB
20476 pages of RAM
7172 reserved pages
5596 pages shared
0 pages swap cached
hwup invoked oom-killer: gfp_mask=0xa01d2, order=0, oomkilladj=-17

Call Trace:
 [<ffffffff8023baad>] printk_ratelimit+0x15/0x17
 [<ffffffff802709c5>] out_of_memory+0x74/0x297
 [<ffffffff80272d26>] __alloc_pages+0x240/0x2cd
 [<ffffffff80331e35>] rb_insert_color+0xb9/0xe3
 [<ffffffff8028984a>] alloc_pages_current+0x78/0x7d
 [<ffffffff8026dfd1>] __page_cache_alloc+0xb/0xd
 [<ffffffff80274543>] __do_page_cache_readahead+0xbe/0x242
 [<ffffffff802548d1>] __lock_acquire+0x3ed/0x6ab
 [<ffffffff80253dc1>] lock_release_holdtime+0x45/0x4a
 [<ffffffff80274a35>] do_page_cache_readahead+0x55/0x62
 [<ffffffff8026fd67>] filemap_fault+0x16d/0x32c
 [<ffffffff802797b6>] __do_fault+0x65/0x36c
 [<ffffffff802548d1>] __lock_acquire+0x3ed/0x6ab
 [<ffffffff8027b39b>] handle_mm_fault+0x1e7/0x74a
 [<ffffffff8052466c>] do_page_fault+0x35f/0x829
 [<ffffffff8052472b>] do_page_fault+0x41e/0x829
 [<ffffffff80295c25>] sys_newstat+0x22/0x3c
 [<ffffffff80522b3d>] error_exit+0x0/0x84

Mem-info:
Node 0 DMA per-cpu:
CPU    0: Hot: hi:    0, btch:   1 usd:   0   Cold: hi:    0, btch:   1 usd:   0
Node 0 DMA32 per-cpu:
CPU    0: Hot: hi:   18, btch:   3 usd:   7   Cold: hi:    6, btch:   1 usd:   0
Active:7000 inactive:70 dirty:0 writeback:0 unstable:0
 free:295 slab:2595 mapped:4 pagetables:1655 bounce:0
Node 0 DMA free:236kB min:0kB low:0kB high:0kB active:248kB inactive:0kB present:224kB pages_scanned:465 all_unreclaimable? yes
lowmem_reserve[]: 0 61 61 61
Node 0 DMA32 free:944kB min:1004kB low:1252kB high:1504kB active:27752kB inactive:280kB present:63348kB pages_scanned:239567 all_unreclaimable? yes
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 1*4kB 1*8kB 0*16kB 1*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 236kB
Node 0 DMA32: 0*4kB 1*8kB 0*16kB 1*32kB 0*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 936kB
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 0kB
Total swap = 0kB
Free swap:            0kB
20476 pages of RAM
7172 reserved pages
5596 pages shared
0 pages swap cached
udevsettle invoked oom-killer: gfp_mask=0xa01d2, order=0, oomkilladj=0

Call Trace:
 [<ffffffff8023baad>] printk_ratelimit+0x15/0x17
 [<ffffffff802709c5>] out_of_memory+0x74/0x297
 [<ffffffff80272d26>] __alloc_pages+0x240/0x2cd
 [<ffffffff8028984a>] alloc_pages_current+0x78/0x7d
 [<ffffffff8026dfd1>] __page_cache_alloc+0xb/0xd
 [<ffffffff80274543>] __do_page_cache_readahead+0xbe/0x242
 [<ffffffff802548d1>] __lock_acquire+0x3ed/0x6ab
 [<ffffffff80253dc1>] lock_release_holdtime+0x45/0x4a
 [<ffffffff80274a35>] do_page_cache_readahead+0x55/0x62
 [<ffffffff8026fd67>] filemap_fault+0x16d/0x32c
 [<ffffffff802797b6>] __do_fault+0x65/0x36c
 [<ffffffff8027b39b>] handle_mm_fault+0x1e7/0x74a
 [<ffffffff8052466c>] do_page_fault+0x35f/0x829
 [<ffffffff8052472b>] do_page_fault+0x41e/0x829
 [<ffffffff80250abb>] hrtimer_nanosleep+0x65/0x12a
 [<ffffffff80250597>] hrtimer_wakeup+0x0/0x21
 [<ffffffff80521161>] do_nanosleep+0x42/0x81
 [<ffffffff80522b3d>] error_exit+0x0/0x84

Mem-info:
Node 0 DMA per-cpu:
CPU    0: Hot: hi:    0, btch:   1 usd:   0   Cold: hi:    0, btch:   1 usd:   0
Node 0 DMA32 per-cpu:
CPU    0: Hot: hi:   18, btch:   3 usd:   7   Cold: hi:    6, btch:   1 usd:   0
Active:7000 inactive:70 dirty:0 writeback:0 unstable:0
 free:295 slab:2595 mapped:4 pagetables:1655 bounce:0
Node 0 DMA free:236kB min:0kB low:0kB high:0kB active:248kB inactive:0kB present:224kB pages_scanned:465 all_unreclaimable? yes
lowmem_reserve[]: 0 61 61 61
Node 0 DMA32 free:944kB min:1004kB low:1252kB high:1504kB active:27752kB inactive:280kB present:63348kB pages_scanned:239567 all_unreclaimable? yes
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 1*4kB 1*8kB 0*16kB 1*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 236kB
Node 0 DMA32: 0*4kB 1*8kB 0*16kB 1*32kB 0*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 936kB
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 0kB
Total swap = 0kB
Free swap:            0kB
20476 pages of RAM
7172 reserved pages
5596 pages shared
0 pages swap cached
hwup invoked oom-killer: gfp_mask=0xa01d2, order=0, oomkilladj=-17

Call Trace:
 [<ffffffff8023baad>] printk_ratelimit+0x15/0x17
 [<ffffffff802709c5>] out_of_memory+0x74/0x297
 [<ffffffff80272d26>] __alloc_pages+0x240/0x2cd
 [<ffffffff80331e35>] rb_insert_color+0xb9/0xe3
 [<ffffffff8028984a>] alloc_pages_current+0x78/0x7d
 [<ffffffff8026dfd1>] __page_cache_alloc+0xb/0xd
 [<ffffffff80274543>] __do_page_cache_readahead+0xbe/0x242
 [<ffffffff802548d1>] __lock_acquire+0x3ed/0x6ab
 [<ffffffff80253dc1>] lock_release_holdtime+0x45/0x4a
 [<ffffffff80274a35>] do_page_cache_readahead+0x55/0x62
 [<ffffffff8026fd67>] filemap_fault+0x16d/0x32c
 [<ffffffff802797b6>] __do_fault+0x65/0x36c
 [<ffffffff802548d1>] __lock_acquire+0x3ed/0x6ab
 [<ffffffff8027b39b>] handle_mm_fault+0x1e7/0x74a
 [<ffffffff8052466c>] do_page_fault+0x35f/0x829
 [<ffffffff8052472b>] do_page_fault+0x41e/0x829
 [<ffffffff805225bc>] _spin_unlock_irq+0x26/0x2b
 [<ffffffff8051f8e9>] __sched_text_start+0x6a1/0x6d6
 [<ffffffff80295c25>] sys_newstat+0x22/0x3c
 [<ffffffff80522b3d>] error_exit+0x0/0x84

Mem-info:
Node 0 DMA per-cpu:
CPU    0: Hot: hi:    0, btch:   1 usd:   0   Cold: hi:    0, btch:   1 usd:   0
Node 0 DMA32 per-cpu:
CPU    0: Hot: hi:   18, btch:   3 usd:   7   Cold: hi:    6, btch:   1 usd:   0
Active:7000 inactive:70 dirty:0 writeback:0 unstable:0
 free:295 slab:2595 mapped:4 pagetables:1655 bounce:0
Node 0 DMA free:236kB min:0kB low:0kB high:0kB active:248kB inactive:0kB present:224kB pages_scanned:465 all_unreclaimable? yes
lowmem_reserve[]: 0 61 61 61
Node 0 DMA32 free:944kB min:1004kB low:1252kB high:1504kB active:27752kB inactive:280kB present:63348kB pages_scanned:239567 all_unreclaimable? yes
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 1*4kB 1*8kB 0*16kB 1*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 236kB
Node 0 DMA32: 0*4kB 1*8kB 0*16kB 1*32kB 0*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 936kB
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 0kB
Total swap = 0kB
Free swap:            0kB
20476 pages of RAM
7172 reserved pages
5596 pages shared
0 pages swap cached
ls invoked oom-killer: gfp_mask=0xa01d2, order=0, oomkilladj=-17

Call Trace:
 [<ffffffff8023baad>] printk_ratelimit+0x15/0x17
 [<ffffffff802709c5>] out_of_memory+0x74/0x297
 [<ffffffff80272d26>] __alloc_pages+0x240/0x2cd
 [<ffffffff8028984a>] alloc_pages_current+0x78/0x7d
 [<ffffffff8026dfd1>] __page_cache_alloc+0xb/0xd
 [<ffffffff80274543>] __do_page_cache_readahead+0xbe/0x242
 [<ffffffff802548d1>] __lock_acquire+0x3ed/0x6ab
 [<ffffffff80253dc1>] lock_release_holdtime+0x45/0x4a
 [<ffffffff80274a35>] do_page_cache_readahead+0x55/0x62
 [<ffffffff8026fd67>] filemap_fault+0x16d/0x32c
 [<ffffffff802797b6>] __do_fault+0x65/0x36c
 [<ffffffff802548d1>] __lock_acquire+0x3ed/0x6ab
 [<ffffffff8027b39b>] handle_mm_fault+0x1e7/0x74a
 [<ffffffff8052466c>] do_page_fault+0x35f/0x829
 [<ffffffff8052472b>] do_page_fault+0x41e/0x829
 [<ffffffff802548d1>] __lock_acquire+0x3ed/0x6ab
 [<ffffffff80253dc1>] lock_release_holdtime+0x45/0x4a
 [<ffffffff80522b3d>] error_exit+0x0/0x84

Mem-info:
Node 0 DMA per-cpu:
CPU    0: Hot: hi:    0, btch:   1 usd:   0   Cold: hi:    0, btch:   1 usd:   0
Node 0 DMA32 per-cpu:
CPU    0: Hot: hi:   18, btch:   3 usd:   7   Cold: hi:    6, btch:   1 usd:   0
Active:7000 inactive:70 dirty:0 writeback:0 unstable:0
 free:295 slab:2595 mapped:4 pagetables:1655 bounce:0
Node 0 DMA free:236kB min:0kB low:0kB high:0kB active:248kB inactive:0kB present:224kB pages_scanned:465 all_unreclaimable? yes
lowmem_reserve[]: 0 61 61 61
Node 0 DMA32 free:944kB min:1004kB low:1252kB high:1504kB active:27752kB inactive:280kB present:63348kB pages_scanned:239567 all_unreclaimable? yes
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 1*4kB 1*8kB 0*16kB 1*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 236kB
Node 0 DMA32: 0*4kB 1*8kB 0*16kB 1*32kB 0*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 936kB
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 0kB
Total swap = 0kB
Free swap:            0kB
20476 pages of RAM
7172 reserved pages
5596 pages shared
0 pages swap cached
hwup invoked oom-killer: gfp_mask=0xa01d2, order=0, oomkilladj=-17

Call Trace:
 [<ffffffff8023baad>] printk_ratelimit+0x15/0x17
 [<ffffffff802709c5>] out_of_memory+0x74/0x297
 [<ffffffff80272d26>] __alloc_pages+0x240/0x2cd
 [<ffffffff8028984a>] alloc_pages_current+0x78/0x7d
 [<ffffffff8026dfd1>] __page_cache_alloc+0xb/0xd
 [<ffffffff80274543>] __do_page_cache_readahead+0xbe/0x242
 [<ffffffff802548d1>] __lock_acquire+0x3ed/0x6ab
 [<ffffffff80253dc1>] lock_release_holdtime+0x45/0x4a
 [<ffffffff80274a35>] do_page_cache_readahead+0x55/0x62
 [<ffffffff8026fd67>] filemap_fault+0x16d/0x32c
 [<ffffffff802797b6>] __do_fault+0x65/0x36c
 [<ffffffff802548d1>] __lock_acquire+0x3ed/0x6ab
 [<ffffffff8027b39b>] handle_mm_fault+0x1e7/0x74a
 [<ffffffff8052466c>] do_page_fault+0x35f/0x829
 [<ffffffff8052472b>] do_page_fault+0x41e/0x829
 [<ffffffff805225bc>] _spin_unlock_irq+0x26/0x2b
 [<ffffffff8051f8e9>] __sched_text_start+0x6a1/0x6d6
 [<ffffffff80295c25>] sys_newstat+0x22/0x3c
 [<ffffffff80522b3d>] error_exit+0x0/0x84

Mem-info:
Node 0 DMA per-cpu:
CPU    0: Hot: hi:    0, btch:   1 usd:   0   Cold: hi:    0, btch:   1 usd:   0
Node 0 DMA32 per-cpu:
CPU    0: Hot: hi:   18, btch:   3 usd:   7   Cold: hi:    6, btch:   1 usd:   0
Active:7000 inactive:70 dirty:0 writeback:0 unstable:0
 free:295 slab:2595 mapped:4 pagetables:1655 bounce:0
Node 0 DMA free:236kB min:0kB low:0kB high:0kB active:248kB inactive:0kB present:224kB pages_scanned:465 all_unreclaimable? yes
lowmem_reserve[]: 0 61 61 61
Node 0 DMA32 free:944kB min:1004kB low:1252kB high:1504kB active:27752kB inactive:280kB present:63348kB pages_scanned:239567 all_unreclaimable? yes
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 1*4kB 1*8kB 0*16kB 1*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 236kB
Node 0 DMA32: 0*4kB 1*8kB 0*16kB 1*32kB 0*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 936kB
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 0kB
Total swap = 0kB
Free swap:            0kB
20476 pages of RAM
7172 reserved pages
5596 pages shared
0 pages swap cached
hwup invoked oom-killer: gfp_mask=0xa01d2, order=0, oomkilladj=-17

Call Trace:
 [<ffffffff8023baad>] printk_ratelimit+0x15/0x17
 [<ffffffff802709c5>] out_of_memory+0x74/0x297
 [<ffffffff80272d26>] __alloc_pages+0x240/0x2cd
 [<ffffffff8028984a>] alloc_pages_current+0x78/0x7d
 [<ffffffff8026dfd1>] __page_cache_alloc+0xb/0xd
 [<ffffffff80274543>] __do_page_cache_readahead+0xbe/0x242
 [<ffffffff802548d1>] __lock_acquire+0x3ed/0x6ab
 [<ffffffff80253dc1>] lock_release_holdtime+0x45/0x4a
 [<ffffffff80274a35>] do_page_cache_readahead+0x55/0x62
 [<ffffffff8026fd67>] filemap_fault+0x16d/0x32c
 [<ffffffff802797b6>] __do_fault+0x65/0x36c
 [<ffffffff802548d1>] __lock_acquire+0x3ed/0x6ab
 [<ffffffff8027b39b>] handle_mm_fault+0x1e7/0x74a
 [<ffffffff8052466c>] do_page_fault+0x35f/0x829
 [<ffffffff8052472b>] do_page_fault+0x41e/0x829
 [<ffffffff80295c25>] sys_newstat+0x22/0x3c
 [<ffffffff80522b3d>] error_exit+0x0/0x84

Mem-info:
Node 0 DMA per-cpu:
CPU    0: Hot: hi:    0, btch:   1 usd:   0   Cold: hi:    0, btch:   1 usd:   0
Node 0 DMA32 per-cpu:
CPU    0: Hot: hi:   18, btch:   3 usd:   7   Cold: hi:    6, btch:   1 usd:   0
Active:7000 inactive:70 dirty:0 writeback:0 unstable:0
 free:295 slab:2595 mapped:4 pagetables:1655 bounce:0
Node 0 DMA free:236kB min:0kB low:0kB high:0kB active:248kB inactive:0kB present:224kB pages_scanned:465 all_unreclaimable? yes
lowmem_reserve[]: 0 61 61 61
Node 0 DMA32 free:944kB min:1004kB low:1252kB high:1504kB active:27752kB inactive:280kB present:63348kB pages_scanned:239567 all_unreclaimable? yes
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 1*4kB 1*8kB 0*16kB 1*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 236kB
Node 0 DMA32: 0*4kB 1*8kB 0*16kB 1*32kB 0*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 936kB
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 0kB
Total swap = 0kB
Free swap:            0kB
20476 pages of RAM
7172 reserved pages
5596 pages shared
0 pages swap cached
Out of memory: kill process 680 (boot) score 206 or a child
Killed process 680 (boot)
printk: 84 messages suppressed.
udevsettle invoked oom-killer: gfp_mask=0xa01d2, order=0, oomkilladj=0

Call Trace:
 [<ffffffff8023baad>] printk_ratelimit+0x15/0x17
 [<ffffffff802709c5>] out_of_memory+0x74/0x297
 [<ffffffff80272d26>] __alloc_pages+0x240/0x2cd
 [<ffffffff8028984a>] alloc_pages_current+0x78/0x7d
 [<ffffffff8026dfd1>] __page_cache_alloc+0xb/0xd
 [<ffffffff80274543>] __do_page_cache_readahead+0xbe/0x242
 [<ffffffff802548d1>] __lock_acquire+0x3ed/0x6ab
 [<ffffffff80253dc1>] lock_release_holdtime+0x45/0x4a
 [<ffffffff80274a35>] do_page_cache_readahead+0x55/0x62
 [<ffffffff8026fd67>] filemap_fault+0x16d/0x32c
 [<ffffffff802797b6>] __do_fault+0x65/0x36c
 [<ffffffff802548d1>] __lock_acquire+0x3ed/0x6ab
 [<ffffffff8027b39b>] handle_mm_fault+0x1e7/0x74a
 [<ffffffff8052466c>] do_page_fault+0x35f/0x829
 [<ffffffff8052472b>] do_page_fault+0x41e/0x829
 [<ffffffff80250abb>] hrtimer_nanosleep+0x65/0x12a
 [<ffffffff80250597>] hrtimer_wakeup+0x0/0x21
 [<ffffffff80521161>] do_nanosleep+0x42/0x81
 [<ffffffff80522b3d>] error_exit+0x0/0x84

Mem-info:
Node 0 DMA per-cpu:
CPU    0: Hot: hi:    0, btch:   1 usd:   0   Cold: hi:    0, btch:   1 usd:   0
Node 0 DMA32 per-cpu:
CPU    0: Hot: hi:   18, btch:   3 usd:   2   Cold: hi:    6, btch:   1 usd:   5
Active:6941 inactive:38 dirty:0 writeback:0 unstable:0
 free:311 slab:2471 mapped:4 pagetables:1641 bounce:0
Node 0 DMA free:244kB min:0kB low:0kB high:0kB active:252kB inactive:0kB present:224kB pages_scanned:2761 all_unreclaimable? yes
lowmem_reserve[]: 0 61 61 61
Node 0 DMA32 free:1000kB min:1004kB low:1252kB high:1504kB active:27512kB inactive:152kB present:63348kB pages_scanned:224076 all_unreclaimable? yes
lowmem_reserve[]: 0 0 0 0
Node 0 DMA: 1*4kB 0*8kB 1*16kB 1*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 244kB
Node 0 DMA32: 0*4kB 1*8kB 0*16kB 1*32kB 1*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 1000kB
Swap cache: add 0, delete 0, find 0/0, race 0+0
Free swap  = 0kB
Total swap = 0kB
Free swap:            0kB
20476 pages of RAM
7172 reserved pages
5516 pages shared
0 pages swap cached
Out of memory: kill process 743 (udevsettle) score 56 or a child
Killed process 743 (udevsettle)
Kernel panic - not syncing: Out of memory and no killable processes...

--Multipart=_Fri__24_Aug_2007_17_01_39_-0700_/FSzBheVc64d0qbi
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--Multipart=_Fri__24_Aug_2007_17_01_39_-0700_/FSzBheVc64d0qbi--

