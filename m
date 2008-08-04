Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp03.in.ibm.com ([59.145.155.3] helo=e28esmtp03.in.ibm.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KPrqe-0005YZ-An
	for kexec@lists.infradead.org; Mon, 04 Aug 2008 04:39:10 +0000
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28esmtp03.in.ibm.com (8.13.1/8.13.1) with ESMTP id m744d3XF001148
	for <kexec@lists.infradead.org>; Mon, 4 Aug 2008 10:09:03 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m744d3rn1351744
	for <kexec@lists.infradead.org>; Mon, 4 Aug 2008 10:09:03 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.13.1/8.13.3) with ESMTP id m744d3ge030208
	for <kexec@lists.infradead.org>; Mon, 4 Aug 2008 10:09:03 +0530
Date: Mon, 4 Aug 2008 10:09:03 +0530
From: Ankita Garg <ankita@in.ibm.com>
Subject: Re: kdump kernel hangs on 4-way Opteron Blade
Message-ID: <20080804043903.GB11608@in.ibm.com>
References: <20080730120026.GA30011@in.ibm.com>
	<20080730120143.GB30011@in.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+pHx0qQiF2pBVqBT"
Content-Disposition: inline
In-Reply-To: <20080730120143.GB30011@in.ibm.com>
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
Cc: Darren Hart <dvhltc@us.ibm.com>, Chirag Jog <chirag@linux.vnet.ibm.com>, linux-acpi@vger.kernel.org, Sripathi Kodi <sripathik@in.ibm.com>, "Sachin P. Sant" <sachinp@in.ibm.com>, Maneesh Soni <maneesh@in.ibm.com>, Vivek Goyal <vgoyal@redhat.com>, Dinakar Guniguntala <dino@in.ibm.com>


--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, Jul 30, 2008 at 05:31:43PM +0530, Ankita Garg wrote:
> Hi,
> 
> We have been using RT kernel as the kdump kernel for most of our work.
> This was working fine on 2.6.21.4-rt10 RT kernel. After which, we moved
> over to 2.6.24-rt1 RT kernel. Now, the kdump kernel hangs with the
> following message:
> 
> (With "quiet" param specified to the kdump kernel)
> ysRq : Trigger a crashdump
> irq 9: nobody cared (try booting with the "irqpoll" option)
> irq 9: Some systems using an IO-APIC require a special quirk to
> workaround
> irq 9: problems with interrupt routing. If your system requires such a
> quirk,
> irq 9: please try booting with the "ioapic_level_quirk=1" option.
> handlers:
> [<ffffffff811660a0>] (acpi_irq+0x0/0x1b)
> turning off IO-APIC fast mode.
> irq 9: nobody cared (try booting with the "irqpoll" option)
> irq 9: Some systems using an IO-APIC require a special quirk to
> workaround
> irq 9: problems with interrupt routing. If your system requires such a
> quirk,
> irq 9: please try booting with the "ioapic_level_quirk=1" option.
> handlers:
>

With CONFIG_PCI_DEBUG on and initcall_debug param passed to the kdump
kernel, I find that the kernel hung in acpi_init() routine. Attaching
the kdump boot log. Any ideas on what could be going wrong ?
 
-- 
Regards,
Ankita Garg (ankita@in.ibm.com)
Linux Technology Center
IBM India Systems & Technology Labs, 
Bangalore, India   

--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ls21_kdump_debug_boot_log

SysRq : Trigger a crashdump
Initializing cgroup subsys cpuset
Linux version 2.6.24-prep (root@llm52.in.ibm.com) (gcc version 4.1.2 20071124
(Red Hat 4.1.2-42)) #1 SMP PREEMPT RT Fri Aug 1 05:48:48 EDT 2008
Command line: root=/dev/sda3 ro rhgb quiet  console=tty1 console=ttyS1,19200
irqpoll maxcpus=1 reset_devices acpi.debug_level=acpi acpi.debug_layer=acpi
debug initcall_debug memmap=exactmap memmap=640K@0K memmap=130416K@17024K
elfcorehdr=147440K memmap=15K#3407502K
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000100 - 000000000009c000 (usable)
 BIOS-e820: 000000000009c000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000cffa39c0 (usable)
 BIOS-e820: 00000000cffa39c0 - 00000000cffa7400 (ACPI data)
 BIOS-e820: 00000000cffa7400 - 00000000d0000000 (reserved)
 BIOS-e820: 00000000f4000000 - 00000000fc000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000230000000 (usable)
Entering add_active_range(0, 1, 156) 0 entries of 3200 used
Entering add_active_range(0, 256, 851875) 1 entries of 3200 used
Entering add_active_range(0, 1048576, 2293760) 2 entries of 3200 used
end_pfn_map = 2293760
user-defined physical RAM map:
 user: 0000000000000000 - 00000000000a0000 (usable)
 user: 00000000010a0000 - 0000000008ffc000 (usable)
 user: 00000000cffa3800 - 00000000cffa7400 (ACPI data)
Entering add_active_range(0, 0, 160) 0 entries of 3200 used
Entering add_active_range(0, 4256, 36860) 1 entries of 3200 used
end_pfn_map = 851879
DMI 2.4 present.
ACPI: RSDP 000FDFE0, 0014 (r0 IBM   )
ACPI: RSDT CFFA7380, 0034 (r1 IBM    SERLEWIS     1000 IBM  45444F43)
ACPI: FACP CFFA72C0, 0084 (r2 IBM    SERLEWIS     1000 IBM  45444F43)
ACPI: DSDT CFFA39C0, 35FC (r1 IBM    SERLEWIS     1000 INTL 20060912)
ACPI: FACS CFFA7040, 0040
ACPI: APIC CFFA7200, 0090 (r1 IBM    SERLEWIS     1000 IBM  45444F43)
ACPI: SRAT CFFA70C0, 0110 (r1 AMD    HAMMER          1 AMD         1)
ACPI: HPET CFFA7080, 0038 (r1 IBM    SERLEWIS     1000 IBM  45444F43)
SRAT: PXM 0 -> APIC 0 -> Node 0
SRAT: PXM 0 -> APIC 1 -> Node 0
SRAT: PXM 1 -> APIC 2 -> Node 1
SRAT: PXM 1 -> APIC 3 -> Node 1
SRAT: Node 0 PXM 0 0-a0000
Entering add_active_range(0, 0, 160) 0 entries of 3200 used
SRAT: Node 0 PXM 0 0-d0000000
Entering add_active_range(0, 0, 160) 1 entries of 3200 used
Entering add_active_range(0, 4256, 36860) 1 entries of 3200 used
SRAT: Node 0 PXM 0 0-130000000
Entering add_active_range(0, 0, 160) 2 entries of 3200 used
Entering add_active_range(0, 4256, 36860) 2 entries of 3200 used
SRAT: Node 1 PXM 1 130000000-230000000
NUMA: Using 63 for the hash shift.
Bootmem setup node 0 0000000000000000-0000000008ffc000
 [ffffe20000000000-ffffe200001fffff] PMD ->ffff810001800000 on node 0
 [ffffe20000200000-ffffe200003fffff] PMD ->ffff810001a00000 on node 0
 [ffffe20000400000-ffffe200005fffff] PMD ->ffff810001e00000 on node 0
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
Movable zone start PFN for each node
early_node_map[2] active PFN ranges
    0:        0 ->      160
    0:     4256 ->    36860
On node 0 totalpages: 32764
  DMA zone: 96 pages used for memmap
  DMA zone: 12 pages reserved
  DMA zone: 52 pages, LIFO batch:0
  DMA32 zone: 767 pages used for memmap
  DMA32 zone: 31837 pages, LIFO batch:7
  Normal zone: 0 pages used for memmap
  Movable zone: 0 pages used for memmap
ACPI: PM-Timer IO Port: 0x488
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x02] enabled)
Processor #2
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
Processor #3
ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x0e] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 14, address 0xfec00000, GSI 0-15
ACPI: IOAPIC (id[0x0d] address[0xfec02000] gsi_base[16])
IOAPIC[1]: apic_id 13, address 0xfec02000, GSI 16-31
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
ACPI: HPET id: 0x1166a201 base: 0xfed00000
Using ACPI (MADT) for SMP configuration information
swsusp: Registered nosave memory region: 00000000000a0000 - 00000000010a0000
Allocating PCI resources starting at 10000000 (gap: 8ffc000:c6fa7800)
SMP: Allowing 4 CPUs, 0 hotplug CPUs
PERCPU: Allocating 41456 bytes of per cpu data
Real-Time Preemption Support (C) 2004-2007 Ingo Molnar
Built 1 zonelists in Node order, mobility grouping on.  Total pages: 31889
Policy zone: DMA32
Kernel command line: root=/dev/sda3 ro rhgb quiet  console=tty1
console=ttyS1,19200 irqpoll maxcpus=1 reset_devices acpi.debug_level=acpi
acpi.debug_layer=acpi debug initcall_debug memmap=exactmap memmap=640K@0K
memmap=130416K@17024K elfcorehdr=147440K memmap=15K#3407502K
irqpoll boot option not supported w/ CONFIG_PREEMPT_RT
Unknown boot option `acpi.debug_level=acpi': ignoring
Unknown boot option `acpi.debug_layer=acpi': ignoring
Initializing CPU#0
PID hash table entries: 512 (order: 9, 4096 bytes)
hpet clockevent registered
TSC calibrated against HPET
Marking TSC unstable due to TSCs unsynchronized
time.c: Detected 2200.077 MHz processor.
Spurious LAPIC timer interrupt on cpu 0
do_IRQ: 0.73 No irq handler for vector
Console: colour VGA+ 80x25
console [tty1] enabled
console [ttyS1] enabled
Checking aperture...
CPU 0: aperture @ 14000000 size 64 MB
CPU 1: aperture @ 14000000 size 64 MB
Memory: 116344k/147440k available (2612k kernel code, 14712k reserved, 1414k
data, 364k init)
Calibrating delay using timer specific routine.. 241682.83 BogoMIPS
(lpj=120841419)
Security Framework initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 256
Initializing cgroup subsys ns
Initializing cgroup subsys cpuacct
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0/1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
SMP alternatives: switching to UP code
ACPI: Core revision 20070126
Using local APIC timer interrupts.
APIC timer calibration result 12500438
Detected 12.500 MHz APIC timer.
Brought up 1 CPUs
CPU0 attaching sched-domain:
 domain 0: span 00000000,00000001
  groups: 00000000,00000001
Calling initcall 0xffffffff814c4ad6:
init_cpufreq_transition_notifier_list+0x0/0x14()
initcall 0xffffffff814c4ad6: init_cpufreq_transition_notifier_list+0x0/0x14()
returned 0.
initcall 0xffffffff814c4ad6 ran for 0 msecs:
init_cpufreq_transition_notifier_list+0x0/0x14()
Calling initcall 0xffffffff814c7101: net_ns_init+0x0/0x13a()
net_namespace: 144 bytes
initcall 0xffffffff814c7101: net_ns_init+0x0/0x13a() returned 0.
initcall 0xffffffff814c7101 ran for 13 msecs: net_ns_init+0x0/0x13a()
Calling initcall 0xffffffff814acacc: cpufreq_tsc+0x0/0x16()
initcall 0xffffffff814acacc: cpufreq_tsc+0x0/0x16() returned 0.
initcall 0xffffffff814acacc ran for 0 msecs: cpufreq_tsc+0x0/0x16()
Calling initcall 0xffffffff8101e52a: init_smp_flush+0x0/0x4a()
initcall 0xffffffff8101e52a: init_smp_flush+0x0/0x4a() returned 0.
initcall 0xffffffff8101e52a ran for 0 msecs: init_smp_flush+0x0/0x4a()
Calling initcall 0xffffffff814b5101: init_elf32_binfmt+0x0/0x12()
initcall 0xffffffff814b5101: init_elf32_binfmt+0x0/0x12() returned 0.
initcall 0xffffffff814b5101 ran for 0 msecs: init_elf32_binfmt+0x0/0x12()
Calling initcall 0xffffffff814b6249: sysctl_init+0x0/0x22()
initcall 0xffffffff814b6249: sysctl_init+0x0/0x22() returned 0.
initcall 0xffffffff814b6249 ran for 0 msecs: sysctl_init+0x0/0x22()
Calling initcall 0xffffffff814b6d31: init_jiffies_clocksource+0x0/0x12()
initcall 0xffffffff814b6d31: init_jiffies_clocksource+0x0/0x12() returned 0.
initcall 0xffffffff814b6d31 ran for 0 msecs:
init_jiffies_clocksource+0x0/0x12()
Calling initcall 0xffffffff814b6f73: pm_init+0x0/0x29()
initcall 0xffffffff814b6f73: pm_init+0x0/0x29() returned 0.
initcall 0xffffffff814b6f73 ran for 0 msecs: pm_init+0x0/0x29()
Calling initcall 0xffffffff814b6fb1: pm_disk_init+0x0/0x19()
initcall 0xffffffff814b6fb1: pm_disk_init+0x0/0x19() returned 0.
initcall 0xffffffff814b6fb1 ran for 0 msecs: pm_disk_init+0x0/0x19()
Calling initcall 0xffffffff81067a6c: swsusp_header_init+0x0/0x2c()
initcall 0xffffffff81067a6c: swsusp_header_init+0x0/0x2c() returned 0.
initcall 0xffffffff81067a6c ran for 0 msecs: swsusp_header_init+0x0/0x2c()
Calling initcall 0xffffffff814b7d15: ksysfs_init+0x0/0x5a()
initcall 0xffffffff814b7d15: ksysfs_init+0x0/0x5a() returned 0.
initcall 0xffffffff814b7d15 ran for 0 msecs: ksysfs_init+0x0/0x5a()
Calling initcall 0xffffffff814bb19c: filelock_init+0x0/0x2e()
initcall 0xffffffff814bb19c: filelock_init+0x0/0x2e() returned 0.
initcall 0xffffffff814bb19c ran for 0 msecs: filelock_init+0x0/0x2e()
Calling initcall 0xffffffff814bbc97: init_misc_binfmt+0x0/0x3f()
initcall 0xffffffff814bbc97: init_misc_binfmt+0x0/0x3f() returned 0.
initcall 0xffffffff814bbc97 ran for 0 msecs: init_misc_binfmt+0x0/0x3f()
Calling initcall 0xffffffff814bbcd6: init_script_binfmt+0x0/0x12()
initcall 0xffffffff814bbcd6: init_script_binfmt+0x0/0x12() returned 0.
initcall 0xffffffff814bbcd6 ran for 0 msecs: init_script_binfmt+0x0/0x12()
Calling initcall 0xffffffff814bbce8: init_elf_binfmt+0x0/0x12()
initcall 0xffffffff814bbce8: init_elf_binfmt+0x0/0x12() returned 0.
initcall 0xffffffff814bbce8 ran for 0 msecs: init_elf_binfmt+0x0/0x12()
Calling initcall 0xffffffff814bce78: debugfs_init+0x0/0x4a()
initcall 0xffffffff814bce78: debugfs_init+0x0/0x4a() returned 0.
initcall 0xffffffff814bce78 ran for 0 msecs: debugfs_init+0x0/0x4a()
Calling initcall 0xffffffff814bd2df: securityfs_init+0x0/0x4a()
initcall 0xffffffff814bd2df: securityfs_init+0x0/0x4a() returned 0.
initcall 0xffffffff814bd2df ran for 0 msecs: securityfs_init+0x0/0x4a()
Calling initcall 0xffffffff814bde21: random32_init+0x0/0x58()
initcall 0xffffffff814bde21: random32_init+0x0/0x58() returned 0.
initcall 0xffffffff814bde21 ran for 0 msecs: random32_init+0x0/0x58()
Calling initcall 0xffffffff811b5a6a: early_resume_init+0x0/0x1cf()
Time: 12:22:58  Date: 08/01/08
initcall 0xffffffff811b5a6a: early_resume_init+0x0/0x1cf() returned 0.
initcall 0xffffffff811b5a6a ran for 16 msecs: early_resume_init+0x0/0x1cf()
Calling initcall 0xffffffff814c4aea: cpufreq_core_init+0x0/0x75()
initcall 0xffffffff814c4aea: cpufreq_core_init+0x0/0x75() returned 0.
initcall 0xffffffff814c4aea ran for 0 msecs: cpufreq_core_init+0x0/0x75()
Calling initcall 0xffffffff814c4b83: cpuidle_init+0x0/0x3b()
initcall 0xffffffff814c4b83: cpuidle_init+0x0/0x3b() returned 0.
initcall 0xffffffff814c4b83 ran for 0 msecs: cpuidle_init+0x0/0x3b()
Calling initcall 0xffffffff814c6fd0: sock_init+0x0/0x5e()
initcall 0xffffffff814c6fd0: sock_init+0x0/0x5e() returned 0.
initcall 0xffffffff814c6fd0 ran for 0 msecs: sock_init+0x0/0x5e()
Calling initcall 0xffffffff814c7952: netpoll_init+0x0/0x41()
initcall 0xffffffff814c7952: netpoll_init+0x0/0x41() returned 0.
initcall 0xffffffff814c7952 ran for 0 msecs: netpoll_init+0x0/0x41()
Calling initcall 0xffffffff814c7cac: netlink_proto_init+0x0/0x159()
NET: Registered protocol family 16
initcall 0xffffffff814c7cac: netlink_proto_init+0x0/0x159() returned 0.
initcall 0xffffffff814c7cac ran for 18 msecs: netlink_proto_init+0x0/0x159()
Calling initcall 0xffffffff814bdd27: kobject_uevent_init+0x0/0x45()
initcall 0xffffffff814bdd27: kobject_uevent_init+0x0/0x45() returned 0.
initcall 0xffffffff814bdd27 ran for 0 msecs: kobject_uevent_init+0x0/0x45()
Calling initcall 0xffffffff814be105: pcibus_class_init+0x0/0x12()
initcall 0xffffffff814be105: pcibus_class_init+0x0/0x12() returned 0.
initcall 0xffffffff814be105 ran for 0 msecs: pcibus_class_init+0x0/0x12()
Calling initcall 0xffffffff814be62c: pci_driver_init+0x0/0x12()
initcall 0xffffffff814be62c: pci_driver_init+0x0/0x12() returned 0.
initcall 0xffffffff814be62c ran for 0 msecs: pci_driver_init+0x0/0x12()
Calling initcall 0xffffffff814becf6: backlight_class_init+0x0/0x49()
initcall 0xffffffff814becf6: backlight_class_init+0x0/0x49() returned 0.
initcall 0xffffffff814becf6 ran for 0 msecs: backlight_class_init+0x0/0x49()
Calling initcall 0xffffffff814c1da5: tty_class_init+0x0/0x2a()
initcall 0xffffffff814c1da5: tty_class_init+0x0/0x2a() returned 0.
initcall 0xffffffff814c1da5 ran for 0 msecs: tty_class_init+0x0/0x2a()
Calling initcall 0xffffffff814c27bd: vtconsole_class_init+0x0/0xba()
initcall 0xffffffff814c27bd: vtconsole_class_init+0x0/0xba() returned 0.
initcall 0xffffffff814c27bd ran for 0 msecs: vtconsole_class_init+0x0/0xba()
Calling initcall 0xffffffff814c37b3: register_node_type+0x0/0x6b()
initcall 0xffffffff814c37b3: register_node_type+0x0/0x6b() returned 0.
initcall 0xffffffff814c37b3 ran for 0 msecs: register_node_type+0x0/0x6b()
Calling initcall 0xffffffff814ad2ea: mtrr_if_init+0x0/0x6c()
initcall 0xffffffff814ad2ea: mtrr_if_init+0x0/0x6c() returned 0.
initcall 0xffffffff814ad2ea ran for 0 msecs: mtrr_if_init+0x0/0x6c()
Calling initcall 0xffffffff814ae2bc: ffh_cstate_init+0x0/0x31()
initcall 0xffffffff814ae2bc: ffh_cstate_init+0x0/0x31() returned -1.
initcall 0xffffffff814ae2bc ran for 0 msecs: ffh_cstate_init+0x0/0x31()
initcall at 0xffffffff814ae2bc: ffh_cstate_init+0x0/0x31(): returned with
error code -1
Calling initcall 0xffffffff814be81e: acpi_pci_init+0x0/0x4a()
ACPI: bus type pci registered
initcall 0xffffffff814be81e: acpi_pci_init+0x0/0x4a() returned 0.
initcall 0xffffffff814be81e ran for 16 msecs: acpi_pci_init+0x0/0x4a()
Calling initcall 0xffffffff814c0a02: init_acpi_device_notify+0x0/0x4b()
initcall 0xffffffff814c0a02: init_acpi_device_notify+0x0/0x4b() returned 0.
initcall 0xffffffff814c0a02 ran for 0 msecs:
init_acpi_device_notify+0x0/0x4b()
Calling initcall 0xffffffff814c5392: dmi_id_init+0x0/0x2e9()
initcall 0xffffffff814c5392: dmi_id_init+0x0/0x2e9() returned 0.
initcall 0xffffffff814c5392 ran for 0 msecs: dmi_id_init+0x0/0x2e9()
Calling initcall 0xffffffff814c5dd5: pci_access_init+0x0/0x46()
PCI: Using configuration type 1
initcall 0xffffffff814c5dd5: pci_access_init+0x0/0x46() returned 0.
initcall 0xffffffff814c5dd5 ran for 17 msecs: pci_access_init+0x0/0x46()
Calling initcall 0xffffffff814ad12d: mtrr_init_finialize+0x0/0x34()
initcall 0xffffffff814ad12d: mtrr_init_finialize+0x0/0x34() returned 0.
initcall 0xffffffff814ad12d ran for 0 msecs: mtrr_init_finialize+0x0/0x34()
Calling initcall 0xffffffff814b3117: topology_init+0x0/0x89()
initcall 0xffffffff814b3117: topology_init+0x0/0x89() returned 0.
initcall 0xffffffff814b3117 ran for 0 msecs: topology_init+0x0/0x89()
Calling initcall 0xffffffff814b669f: param_sysfs_init+0x0/0x1b1()
initcall 0xffffffff814b669f: param_sysfs_init+0x0/0x1b1() returned 0.
initcall 0xffffffff814b669f ran for 0 msecs: param_sysfs_init+0x0/0x1b1()
Calling initcall 0xffffffff81068dc4: pm_sysrq_init+0x0/0x19()
initcall 0xffffffff81068dc4: pm_sysrq_init+0x0/0x19() returned 0.
initcall 0xffffffff81068dc4 ran for 0 msecs: pm_sysrq_init+0x0/0x19()
Calling initcall 0xffffffff814ba07c: readahead_init+0x0/0x12()
initcall 0xffffffff814ba07c: readahead_init+0x0/0x12() returned 0.
initcall 0xffffffff814ba07c ran for 0 msecs: readahead_init+0x0/0x12()
Calling initcall 0xffffffff814bb860: init_bio+0x0/0xc5()
initcall 0xffffffff814bb860: init_bio+0x0/0xc5() returned 0.
initcall 0xffffffff814bb860 ran for 0 msecs: init_bio+0x0/0xc5()
Calling initcall 0xffffffff814bd989: genhd_device_init+0x0/0x57()
initcall 0xffffffff814bd989: genhd_device_init+0x0/0x57() returned 0.
initcall 0xffffffff814bd989 ran for 0 msecs: genhd_device_init+0x0/0x57()
Calling initcall 0xffffffff814be868: fbmem_init+0x0/0x95()
initcall 0xffffffff814be868: fbmem_init+0x0/0x95() returned 0.
initcall 0xffffffff814be868 ran for 0 msecs: fbmem_init+0x0/0x95()
Calling initcall 0xffffffff814c0800: acpi_init+0x0/0x202()
ACPI: EC: Look up 



--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--+pHx0qQiF2pBVqBT--

