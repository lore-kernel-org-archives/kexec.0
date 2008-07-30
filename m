Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp03.au.ibm.com ([202.81.18.172])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KOArE-0005Cy-7O
	for kexec@lists.infradead.org; Wed, 30 Jul 2008 12:32:46 +0000
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id m6UCVcX8005118
	for <kexec@lists.infradead.org>; Wed, 30 Jul 2008 22:31:38 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6UCWfAu077218
	for <kexec@lists.infradead.org>; Wed, 30 Jul 2008 22:32:41 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6UCWeD8006112
	for <kexec@lists.infradead.org>; Wed, 30 Jul 2008 22:32:40 +1000
Date: Wed, 30 Jul 2008 18:02:34 +0530
From: Ankita Garg <ankita@in.ibm.com>
Subject: kdump kernel hangs on 4-way AMD Opteron rack mounted box
Message-ID: <20080730123234.GD30011@in.ibm.com>
References: <20080730120026.GA30011@in.ibm.com>
	<20080730120143.GB30011@in.ibm.com>
	<20080730121550.GC30011@in.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="TU+u6i6jrDPzmlWF"
Content-Disposition: inline
In-Reply-To: <20080730121550.GC30011@in.ibm.com>
Reply-To: Ankita Garg <ankita@in.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Darren Hart <dvhltc@us.ibm.com>, Sripathi Kodi <sripathik@in.ibm.com>, Chirag Jog <chirag@linux.vnet.ibm.com>, "Sachin P. Sant" <sachinp@in.ibm.com>, Maneesh Soni <maneesh@in.ibm.com>, Dinakar Guniguntala <dino@in.ibm.com>


--TU+u6i6jrDPzmlWF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

We have been using RT kernel as the kdump kernel for most of our work.
This was working fine on 2.6.21.4-rt10 RT kernel. After which, we moved
over to 2.6.24-rt1 RT kernel. Now, the kdump kernel hangs. Attaching the
complete kdump kernel boot log with initcall_debug option passed to the
kdump kernel. This is on a 4-way AMD Opteron rack mounted machine
(x3455).

Attaching the kdump boot log (with 2.6.24.7 kernel as the first kernel and RT
kernel as the second kernel). Also, the output of /proc/cpuinfo and lspci.

-- 
Regards,
Ankita Garg (ankita@in.ibm.com)
Linux Technology Center
IBM India Systems & Technology Labs, 
Bangalore, India   

--TU+u6i6jrDPzmlWF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kdump_x3455_info.log"

# cat /proc/cpuinfo 
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 65
model name      : Dual-Core AMD Opteron(tm) Processor 2218
stepping        : 2
cpu MHz         : 2593.785
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt rdtscp
lm 3dnowext 3dnow pni cx16 lahf_lm cmp_legacy svm cr8_legacy
bogomips        : 5191.43
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp tm stc

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 65
model name      : Dual-Core AMD Opteron(tm) Processor 2218
stepping        : 2
cpu MHz         : 2593.785
cache size      : 1024 KB
physical id     : 0
siblings        : 2
core id         : 1
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt rdtscp
lm 3dnowext 3dnow pni cx16 lahf_lm cmp_legacy svm cr8_legacy
bogomips        : 5187.00
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp tm stc

processor       : 2
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 65
model name      : Dual-Core AMD Opteron(tm) Processor 2218
stepping        : 2
cpu MHz         : 2593.785
cache size      : 1024 KB
physical id     : 1
siblings        : 2
core id         : 0
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt rdtscp
lm 3dnowext 3dnow pni cx16 lahf_lm cmp_legacy svm cr8_legacy
bogomips        : 5187.02
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp tm stc

processor       : 3
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 65
model name      : Dual-Core AMD Opteron(tm) Processor 2218
stepping        : 2
cpu MHz         : 2593.785
cache size      : 1024 KB
physical id     : 1
siblings        : 2
core id         : 1
cpu cores       : 2
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt rdtscp
lm 3dnowext 3dnow pni cx16 lahf_lm cmp_legacy svm cr8_legacy
bogomips        : 5187.02
TLB size        : 1024 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp tm stc


#lspci
00:01.0 PCI bridge: Broadcom HT1000 PCI/PCI-X bridge
00:02.0 Host bridge: Broadcom HT1000 Legacy South Bridge
00:02.1 IDE interface: Broadcom HT1000 Legacy IDE controller
00:02.2 ISA bridge: Broadcom HT1000 LPC Bridge
00:03.0 USB Controller: Broadcom HT1000 USB Controller (rev 01)
00:03.1 USB Controller: Broadcom HT1000 USB Controller (rev 01)
00:03.2 USB Controller: Broadcom HT1000 USB Controller (rev 01)
00:05.0 VGA compatible controller: ATI Technologies Inc ES1000 (rev 02)
00:06.0 PCI bridge: Broadcom HT2100 PCI-Express Bridge (rev a2)
00:07.0 PCI bridge: Broadcom HT2100 PCI-Express Bridge (rev a2)
00:08.0 PCI bridge: Broadcom Unknown device 0144 (rev a2)
00:09.0 PCI bridge: Broadcom HT2100 PCI-Express Bridge (rev a2)
00:0a.0 PCI bridge: Broadcom Unknown device 0144 (rev a2)
00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
HyperTransport Technology Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM
Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Miscellaneous Control
00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
HyperTransport Technology Configuration
00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Address Map
00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM
Controller
00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
Miscellaneous Control
01:0d.0 PCI bridge: Broadcom HT1000 PCI/PCI-X bridge (rev c0)
01:0e.0 RAID bus controller: Broadcom BCM5785 (HT1000) SATA Native SATA Mode
02:01.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit
Ethernet (rev 10)
02:01.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit
Ethernet (rev 10)



--TU+u6i6jrDPzmlWF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kdump_x3455_boot.log"

rt-alder.austin.ibm.com login: SysRq : Trigger a crashdump
Initializing cgroup subsys cpuset
Linux version 2.6.24.7 (root@rt-alder.austin.ibm.com) (gcc version 4.1.2 20071124 (Red Hat 4.1.2-42)) #1 SMP Fri Jul 4 04:13:31 EDT 2008
Command line: root=/dev/sda3 ro  console=tty1 console=ttyS0,19200 irqpoll maxcpus=1 reset_devices acpi=noirq memmap=exactmap memmap=640K@0K memmap=130416K@33408K elfcorehdr=163824K memmap=28K#2096128K memmap=484K#2096156K
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000100 - 000000000009dc00 (usable)
 BIOS-e820: 000000000009dc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ce000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ff00000 (usable)
 BIOS-e820: 000000007ff00000 - 000000007ff07000 (ACPI data)
 BIOS-e820: 000000007ff07000 - 000000007ff80000 (ACPI NVS)
 BIOS-e820: 000000007ff80000 - 0000000080000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec03000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
end_pfn_map = 1048576
user-defined physical RAM map:
 user: 0000000000000000 - 00000000000a0000 (usable)
 user: 00000000020a0000 - 0000000009ffc000 (usable)
 user: 000000007ff00000 - 000000007ff07000 (ACPI data)
 user: 000000007ff07000 - 000000007ff80000 (ACPI data)
end_pfn_map = 524160
DMI present.
ACPI: RSDP 000F7F20, 0024 (r2 BRCM  )
ACPI: XSDT 7FF01E21, 0054 (r1 BRCM   EXPLOSN   6040000 PTL   2000001)
ACPI: FACP 7FF01E75, 0074 (r1 BRCM   EXPLOSN   6040000 MSFT  2000001)
ACPI: DSDT 7FF01EE9, 4F1B (r2 BRCM   EXPLOSN   6040000 MSFT  2000002)
ACPI: FACS 7FF12FC0, 0040
ACPI: SRAT 7FF06E04, 00C0 (r1 AMD    HAMMER    6040000 AMD         1)
ACPI: SLIT 7FF06EC4, 0029 (r1 IBM     EXPLOSN  6040000  LTP        1)
ACPI: HPET 7FF06EED, 0038 (r1 BRCM   EXPLOSN   6040000 BRCM  2000001)
ACPI: SSDT 7FF06F25, 0049 (r1 BRCM   PRT0      6040000 BRCM  2000001)
ACPI: APIC 7FF06F6E, 0092 (r1 BRCM   EXPLOSN   6040000 PTL   2000001)
SRAT: PXM 0 -> APIC 0 -> Node 0
SRAT: PXM 0 -> APIC 1 -> Node 0
SRAT: PXM 1 -> APIC 2 -> Node 1
SRAT: PXM 1 -> APIC 3 -> Node 1
SRAT: Node 0 PXM 0 0-a0000
SRAT: Node 0 PXM 0 0-80000000
ACPI: SLIT table looks invalid. Not used.
Bootmem setup node 0 0000000000000000-0000000009ffc000
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
Movable zone start PFN for each node
early_node_map[2] active PFN ranges
    0:        0 ->      160
    0:     8352 ->    40956
ACPI: PM-Timer IO Port: 0x508
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
Processor #2 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
Processor #3
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: HPET id: 0x1166a201 base: 0xfed00000
Using ACPI for processor (LAPIC) configuration information
Intel MultiProcessor Specification v1.4
MPTABLE: OEM ID: BRCM     MPTABLE: Product ID: EXPLOSION    MPTABLE: APIC at: 0xFEE00000
I/O APIC #4 at 0xFEC00000.
I/O APIC #5 at 0xFEC01000.
I/O APIC #6 at 0xFEC02000.
Setting APIC routing to flat
Processors: 4
swsusp: Registered nosave memory region: 00000000000a0000 - 00000000020a0000
Allocating PCI resources starting at 80000000 (gap: 7ff80000:80080000)
SMP: Allowing 4 CPUs, 0 hotplug CPUs
PERCPU: Allocating 38448 bytes of per cpu data
Built 1 zonelists in Node order, mobility grouping on.  Total pages: 32195
Policy zone: DMA32
Kernel command line: root=/dev/sda3 ro  console=tty1 console=ttyS0,19200 irqpoll maxcpus=1 reset_devices acpi=noirq memmap=exactmap memmap=640K@0K memmap=130416K@33408K elfcorehdr=163824K memmap=28K#2096128K memmap=484K#2096156K
Misrouted IRQ fixup and polling support enabled
This may significantly impact system performance
Initializing CPU#0
PID hash table entries: 512 (order: 9, 4096 bytes)
TSC calibrated against HPET
Marking TSC unstable due to TSCs unsynchronized
time.c: Detected 2593.500 MHz processor.
Spurious LAPIC timer interrupt on cpu 0
Console: colour VGA+ 80x25
console [tty1] enabled
console [ttyS0] enabled
Checking aperture...
CPU 0: aperture @ 0 size 32 MB
No AGP bridge found
Memory: 119192k/163824k available (2522k kernel code, 11864k reserved, 1365k data, 352k init)
Calibrating delay using timer specific routine.. 5226.86 BogoMIPS (lpj=2613433)
Security Framework initialized
SELinux:  Initializing.
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 256
Initializing cgroup subsys ns
Initializing cgroup subsys cpuacct
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0/2 -> Node 0
CPU: Physical Processor ID: 1
CPU: Processor Core ID: 0
SMP alternatives: switching to UP code
ACPI: Core revision 20070126
ExtINT not setup in hardware but reported by MP table
Using local APIC timer interrupts.
Detected 12.468 MHz APIC timer.
Brought up 1 CPUs
net_namespace: 120 bytes
Time:  4:52:10  Date: 07/04/08
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: (supports S0 S4 S5)
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
ACPI: PCI Root Bridge [PCI1] (0000:80)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
ACPI: bus type pnp registered
pnp: IRQ 12 override to level, low
pnp: PnP ACPI: found 13 devices
ACPI: ACPI bus type pnp unregistered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Probing PCI hardware
sysfs: duplicate filename 'bridge' can not be created
WARNING: at fs/sysfs/dir.c:424 sysfs_add_one()
Pid: 1, comm: swapper Not tainted 2.6.24.7 #1

Call Trace:
 [<ffffffff810e6bba>] sysfs_add_one+0x5c/0xc9
 [<ffffffff810e7a85>] sysfs_create_link+0xd1/0x12c
 [<ffffffff81130cf4>] pci_bus_add_devices+0xe7/0x130
 [<ffffffff81130cd6>] pci_bus_add_devices+0xc9/0x130
 [<ffffffff8145750d>] pci_legacy_init+0x6b/0x103
 [<ffffffff8143566f>] kernel_init+0x173/0x2e3
 [<ffffffff8100ce78>] child_rip+0xa/0x12
 [<ffffffff81157830>] acpi_ds_init_one_object+0x0/0x88
 [<ffffffff814354fc>] kernel_init+0x0/0x2e3
 [<ffffffff8100ce6e>] child_rip+0x0/0x12

pci 0000:01:0d.0: Error creating sysfs bridge symlink, continuing...
sysfs: duplicate filename 'bridge' can not be created
WARNING: at fs/sysfs/dir.c:424 sysfs_add_one()
Pid: 1, comm: swapper Not tainted 2.6.24.7 #1

Call Trace:
 [<ffffffff810e6bba>] sysfs_add_one+0x5c/0xc9
 [<ffffffff810e7a85>] sysfs_create_link+0xd1/0x12c
 [<ffffffff81130cf4>] pci_bus_add_devices+0xe7/0x130
 [<ffffffff8145750d>] pci_legacy_init+0x6b/0x103
 [<ffffffff8143566f>] kernel_init+0x173/0x2e3
 [<ffffffff8100ce78>] child_rip+0xa/0x12
 [<ffffffff81157830>] acpi_ds_init_one_object+0x0/0x88
 [<ffffffff814354fc>] kernel_init+0x0/0x2e3
 [<ffffffff8100ce6e>] child_rip+0x0/0x12

pci 0000:00:01.0: Error creating sysfs bridge symlink, continuing...
sysfs: duplicate filename 'bridge' can not be created
WARNING: at fs/sysfs/dir.c:424 sysfs_add_one()
Pid: 1, comm: swapper Not tainted 2.6.24.7 #1

Call Trace:
 [<ffffffff810e6bba>] sysfs_add_one+0x5c/0xc9
 [<ffffffff810e7a85>] sysfs_create_link+0xd1/0x12c
 [<ffffffff81130cf4>] pci_bus_add_devices+0xe7/0x130
 [<ffffffff8145750d>] pci_legacy_init+0x6b/0x103
 [<ffffffff8143566f>] kernel_init+0x173/0x2e3
 [<ffffffff8100ce78>] child_rip+0xa/0x12
 [<ffffffff81157830>] acpi_ds_init_one_object+0x0/0x88
 [<ffffffff814354fc>] kernel_init+0x0/0x2e3
 [<ffffffff8100ce6e>] child_rip+0x0/0x12

pci 0000:00:06.0: Error creating sysfs bridge symlink, continuing...
sysfs: duplicate filename 'bridge' can not be created
WARNING: at fs/sysfs/dir.c:424 sysfs_add_one()
Pid: 1, comm: swapper Not tainted 2.6.24.7 #1

Call Trace:
 [<ffffffff810e6bba>] sysfs_add_one+0x5c/0xc9
 [<ffffffff810e7a85>] sysfs_create_link+0xd1/0x12c
 [<ffffffff81130cf4>] pci_bus_add_devices+0xe7/0x130
 [<ffffffff8145750d>] pci_legacy_init+0x6b/0x103
 [<ffffffff8143566f>] kernel_init+0x173/0x2e3
 [<ffffffff8100ce78>] child_rip+0xa/0x12
 [<ffffffff81157830>] acpi_ds_init_one_object+0x0/0x88
 [<ffffffff814354fc>] kernel_init+0x0/0x2e3
 [<ffffffff8100ce6e>] child_rip+0x0/0x12

pci 0000:00:07.0: Error creating sysfs bridge symlink, continuing...
sysfs: duplicate filename 'bridge' can not be created
WARNING: at fs/sysfs/dir.c:424 sysfs_add_one()
Pid: 1, comm: swapper Not tainted 2.6.24.7 #1

Call Trace:
 [<ffffffff810e6bba>] sysfs_add_one+0x5c/0xc9
 [<ffffffff810e7a85>] sysfs_create_link+0xd1/0x12c
 [<ffffffff81130cf4>] pci_bus_add_devices+0xe7/0x130
 [<ffffffff8145750d>] pci_legacy_init+0x6b/0x103
 [<ffffffff8143566f>] kernel_init+0x173/0x2e3
 [<ffffffff8100ce78>] child_rip+0xa/0x12
 [<ffffffff81157830>] acpi_ds_init_one_object+0x0/0x88
 [<ffffffff814354fc>] kernel_init+0x0/0x2e3
 [<ffffffff8100ce6e>] child_rip+0x0/0x12

pci 0000:00:08.0: Error creating sysfs bridge symlink, continuing...
sysfs: duplicate filename 'bridge' can not be created
WARNING: at fs/sysfs/dir.c:424 sysfs_add_one()
Pid: 1, comm: swapper Not tainted 2.6.24.7 #1

Call Trace:
 [<ffffffff810e6bba>] sysfs_add_one+0x5c/0xc9
 [<ffffffff810e7a85>] sysfs_create_link+0xd1/0x12c
 [<ffffffff81130cf4>] pci_bus_add_devices+0xe7/0x130
 [<ffffffff8145750d>] pci_legacy_init+0x6b/0x103
 [<ffffffff8143566f>] kernel_init+0x173/0x2e3
 [<ffffffff8100ce78>] child_rip+0xa/0x12
 [<ffffffff81157830>] acpi_ds_init_one_object+0x0/0x88
 [<ffffffff814354fc>] kernel_init+0x0/0x2e3
 [<ffffffff8100ce6e>] child_rip+0x0/0x12

pci 0000:00:09.0: Error creating sysfs bridge symlink, continuing...
sysfs: duplicate filename 'bridge' can not be created
WARNING: at fs/sysfs/dir.c:424 sysfs_add_one()
Pid: 1, comm: swapper Not tainted 2.6.24.7 #1

Call Trace:
 [<ffffffff810e6bba>] sysfs_add_one+0x5c/0xc9
 [<ffffffff810e7a85>] sysfs_create_link+0xd1/0x12c
 [<ffffffff81130cf4>] pci_bus_add_devices+0xe7/0x130
 [<ffffffff8145750d>] pci_legacy_init+0x6b/0x103
 [<ffffffff8143566f>] kernel_init+0x173/0x2e3
 [<ffffffff8100ce78>] child_rip+0xa/0x12
 [<ffffffff81157830>] acpi_ds_init_one_object+0x0/0x88
 [<ffffffff814354fc>] kernel_init+0x0/0x2e3
 [<ffffffff8100ce6e>] child_rip+0x0/0x12

pci 0000:00:0a.0: Error creating sysfs bridge symlink, continuing...
PCI->APIC IRQ transform: 0000:00:03.0[A] -> IRQ 10
PCI->APIC IRQ transform: 0000:00:03.1[A] -> IRQ 10
PCI->APIC IRQ transform: 0000:00:03.2[A] -> IRQ 10
PCI->APIC IRQ transform: 0000:00:05.0[A] -> IRQ 16
PCI->APIC IRQ transform: 0000:00:06.0[A] -> IRQ 19
PCI->APIC IRQ transform: 0000:00:07.0[A] -> IRQ 23
PCI->APIC IRQ transform: 0000:00:08.0[A] -> IRQ 22
PCI->APIC IRQ transform: 0000:00:09.0[A] -> IRQ 21
PCI->APIC IRQ transform: 0000:00:0a.0[A] -> IRQ 20
PCI->APIC IRQ transform: 0000:01:0e.0[A] -> IRQ 7
PCI->APIC IRQ transform: 0000:02:01.0[A] -> IRQ 18
PCI->APIC IRQ transform: 0000:02:01.1[B] -> IRQ 17
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
DMAR:No DMAR devices found
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 3 64-bit timers, 14318180 Hz
Time: hpet clocksource has been installed.
system 00:00: iomem range 0xe0000000-0xefffffff has been reserved
system 00:0a: ioport range 0x40b-0x40b has been reserved
system 00:0a: ioport range 0x4d0-0x4d1 has been reserved
system 00:0a: ioport range 0x4d6-0x4d6 has been reserved
system 00:0a: ioport range 0x500-0x560 has been reserved
system 00:0a: ioport range 0x558-0x55b has been reserved
system 00:0a: ioport range 0x580-0x58f has been reserved
system 00:0a: ioport range 0x590-0x593 has been reserved
system 00:0a: ioport range 0x600-0x61f has been reserved
system 00:0a: ioport range 0x620-0x623 has been reserved
system 00:0a: ioport range 0x700-0x703 has been reserved
system 00:0a: ioport range 0xc00-0xc01 has been reserved
system 00:0a: ioport range 0xc06-0xc08 has been reserved
system 00:0a: ioport range 0xc14-0xc14 has been reserved
system 00:0a: ioport range 0xc49-0xc4a has been reserved
system 00:0a: ioport range 0xc50-0xc53 has been reserved
system 00:0a: ioport range 0xc6c-0xc6c has been reserved
system 00:0a: ioport range 0xc6f-0xc6f has been reserved
system 00:0a: ioport range 0xcd6-0xcd7 has been reserved
system 00:0a: ioport range 0xcf9-0xcf9 could not be reserved
system 00:0a: ioport range 0xf50-0xf58 has been reserved
system 00:0a: ioport range 0x4c0-0x4cf has been reserved
system 00:0a: ioport range 0x820-0x857 has been reserved
system 00:0a: ioport range 0xca8-0xcaf has been reserved
PCI: Bridge: 0000:01:0d.0
  IO window: disabled.
  MEM window: d8000000-d80fffff
  PREFETCH window: 88000000-880fffff
PCI: Bridge: 0000:00:01.0
  IO window: 3000-3fff
  MEM window: d8000000-d81fffff
  PREFETCH window: 88000000-880fffff
PCI: Bridge: 0000:00:06.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:07.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:08.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:09.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0a.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 1, 8192 bytes)
TCP established hash table entries: 4096 (order: 4, 65536 bytes)
TCP bind hash table entries: 4096 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 2274k freed
audit: initializing netlink socket (disabled)
audit(1215147128.846:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: Found enabled HT MSI Mapping on 0000:00:01.0
assign_interrupt_mode Found MSI capability
assign_interrupt_mode Found MSI capability
assign_interrupt_mode Found MSI capability
assign_interrupt_mode Found MSI capability
assign_interrupt_mode Found MSI capability
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
tick-braodcast: ignoring broadcast for offline CPU #1
ACPI Exception (processor_core-0816): AE_NOT_FOUND, Processor Device is not present [20070126]
ACPI Exception (processor_core-0816): AE_NOT_FOUND, Processor Device is not present [20070126]
ACPI Exception (processor_core-0816): AE_NOT_FOUND, Processor Device is not present [20070126]
ACPI Exception (processor_core-0816): AE_NOT_FOUND, Processor Device is not present [20070126]
Non-volatile memory driver v1.2
Linux agpgart interface v0.102
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
erial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0b: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 4096 blocksize
input: Macintosh mouse button emulation as /class/input/input0
usbcore: registered new interface driver libusual
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
rtc_cmos 00:05: rtc core: registered rtc_cmos as rtc0
rtc0: alarms up to one year, y3k
cpuidle: using governor ladder
cpuidle: using governor menu
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow-k8: Found 1 Dual-Core AMD Opteron(tm) Processor 2218 processors (1 cpu cores) (version 2.20.00)
powernow-k8: BIOS error - no PSB or ACPI _PSS objects
registered taskstats version 1
  Magic number: 0:67:868
Freeing unused kernel memory: 352k freed
Write protecting the kernel read-only data: 1056k
Mounting proc filesystem
Mounting sysfs filesysSCSI subsystem initialized
tem
Creating /dDriver 'sd' needs updating - please use bus_type methods
ev
Creating iniscsi0 : sata_svw
tial device nodescsi1 : sata_svw
s
Loading scsi_scsi2 : sata_svw
mod.ko module
Lscsi3 : sata_svw
oading sd_mod.koata1: SATA max UDMA/133 mmio m8192@0xd8100000 port 0xd8100000 irq 7
 module
Loadingata2: SATA max UDMA/133 mmio m8192@0xd8100000 port 0xd8100100 irq 7
 libata.ko modulata3: SATA max UDMA/133 mmio m8192@0xd8100000 port 0xd8100200 irq 7
e
Loading sata_ata4: SATA max UDMA/133 mmio m8192@0xd8100000 port 0xd8100300 irq 7
svw.ko module
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: qc timeout (cmd 0x27)
ata1.00: failed to read native max address (err_mask=0x4)
ata1.00: HPA support seems broken, will skip HPA handling
ata1: failed to recover some devices, retrying in 5 secs
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/133
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: qc timeout (cmd 0x27)
ata2.00: failed to read native max address (err_mask=0x4)
ata2.00: HPA support seems broken, will skip HPA handling
ata2: failed to recover some devices, retrying in 5 secs
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: configured for UDMA/133
ata3: SATA link down (SStatus 4 SControl 300)
ata4: SATA link down (SStatus 4 SControl 300)
scsi 0:0:0:0: Direct-Access     ATA      HDS728080PLA380  PF2O PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 156312576 512-byte hardware sectors (80032 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 156312576 512-byte hardware sectors (80032 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sda:<3>ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x40000000 action 0x2 frozen
ata1: SError: { }
ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x40000000 action 0x2 frozen
ata1: SError: { }
ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x40000000 action 0x2 frozen
ata1: SError: { }
ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1: limiting SATA link speed to 1.5 Gbps
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x40000000 action 0x6 frozen
ata1: SError: { }
ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: hard resetting link
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x40000000 action 0x2 frozen
ata1: SError: { }
ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for UDMA/133
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x40000000 action 0x2 frozen
ata1: SError: { }
ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for UDMA/133
sd 0:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
sd 0:0:0:0: [sda] Sense Key : Aborted Command [current] [descriptor]
Descriptor sense data with sense descriptors (in hex):
        72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
        00 00 00 00 
sd 0:0:0:0: [sda] Add. Sense: No additional sense information
end_request: I/O error, dev sda, sector 0
Buffer I/O error on device sda, logical block 0
ata1: EH complete
ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x40000000 action 0x2 frozen
ata1: SError: { }
ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0 dma 4096 in
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1.00: status: { DRDY }
ata1: soft resetting link
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.00: configured for UDMA/133
ata1: EH complete
Dev sda: unable to read RDB block 0
 unable to read partition table
sd 0:0:0:0: [sda] Attached SCSI disk
scsi 1:0:0:0: Direct-Access     ATA      HDT722516DLA380  V43O PQ: 0 ANSI: 5
sd 1:0:0:0: [sdb] 312581808 512-byte hardware sectors (160042 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 1:0:0:0: [sdb] 312581808 512-byte hardware sectors (160042 MB)
sd 1:0:0:0: [sdb] Write Protect is off
sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
 sdb:

--TU+u6i6jrDPzmlWF
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--TU+u6i6jrDPzmlWF--

