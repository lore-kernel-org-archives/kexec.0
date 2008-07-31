Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KOYWa-00041x-2k
	for kexec@lists.infradead.org; Thu, 31 Jul 2008 13:49:01 +0000
Date: Thu, 31 Jul 2008 09:46:52 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: kdump kernel hangs on 2-way AMD Opteron Intellistation
Message-ID: <20080731134652.GD26782@redhat.com>
References: <20080730120026.GA30011@in.ibm.com>
	<20080730120143.GB30011@in.ibm.com>
	<20080730121550.GC30011@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080730121550.GC30011@in.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Ankita Garg <ankita@in.ibm.com>
Cc: Darren Hart <dvhltc@us.ibm.com>, Chirag Jog <chirag@linux.vnet.ibm.com>, kexec@lists.infradead.org, linux-acpi@vger.kernel.org, Sripathi Kodi <sripathik@in.ibm.com>, "Sachin P. Sant" <sachinp@in.ibm.com>, Maneesh Soni <maneesh@in.ibm.com>, Dinakar Guniguntala <dino@in.ibm.com>

On Wed, Jul 30, 2008 at 05:45:50PM +0530, Ankita Garg wrote:
> Hi,
> 
> We have been using RT kernel as the kdump kernel for most of our work.
> This was working fine on 2.6.21.4-rt10 RT kernel. After which, we moved
> over to 2.6.24-rt1 RT kernel. Now, the kdump kernel hangs. Attaching the
> complete kdump kernel boot log with initcall_debug option passed to the
> kdump kernel.
> 

Is this case also successful with acpi=noirq option?

Can you please look at /proc/iomem in first kernel and make sure that
ACPI related areas are being passed to second kernel at command line
and are visible in second kernel's memory map?

Again CCing acpi mailing list.


Thanks
Vivek

> # cat /proc/cpuinfo 
> processor       : 0
> vendor_id       : AuthenticAMD
> cpu family      : 15
> model           : 37
> model name      : AMD Opteron(tm) Processor 250
> stepping        : 1
> cpu MHz         : 2393.203
> cache size      : 1024 KB
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext fxsr_opt
> lm 3dnowext 3dnow pni lahf_lm
> bogomips        : 4789.29
> TLB size        : 1024 4K pages
> clflush size    : 64
> cache_alignment : 64
> address sizes   : 40 bits physical, 48 bits virtual
> power management: ts fid vid ttp
> 
> processor       : 1
> vendor_id       : AuthenticAMD
> cpu family      : 15
> model           : 37
> model name      : AMD Opteron(tm) Processor 250
> stepping        : 1
> cpu MHz         : 2393.203
> cache size      : 1024 KB
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext fxsr_opt
> lm 3dnowext 3dnow pni lahf_lm
> bogomips        : 4785.69
> TLB size        : 1024 4K pages
> clflush size    : 64
> cache_alignment : 64
> address sizes   : 40 bits physical, 48 bits virtual
> power management: ts fid vid ttp
> 
> #lspci
> 00:06.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI (rev 07)
> 00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC (rev 05)
> 00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE (rev
> 03)
> 00:07.2 SMBus: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0 (rev 02)
> 00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 05)
> 00:07.5 Multimedia audio controller: Advanced Micro Devices [AMD]
> AMD-8111 AC97 Audio (rev 03)
> 00:0a.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge
> (rev 12)
> 00:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev 01)
> 00:0b.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge
> (rev 12)
> 00:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X IOAPIC (rev 01)
> 00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> HyperTransport Technology Configuration
> 00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> Address Map
> 00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> DRAM Controller
> 00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> Miscellaneous Control
> 00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> HyperTransport Technology Configuration
> 00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> Address Map
> 00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> DRAM Controller
> 00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron]
> Miscellaneous Control
> 01:03.0 USB Controller: NEC Corporation USB (rev 43)
> 01:03.1 USB Controller: NEC Corporation USB (rev 43)
> 01:03.2 USB Controller: NEC Corporation USB 2.0 (rev 04)
> 01:04.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A
> IEEE-1394a-2000 Controller (PHY/Link)
> 02:01.0 Ethernet controller: Intel Corporation 82546EB Gigabit Ethernet
> Controller (Copper) (rev 01)
> 02:01.1 Ethernet controller: Intel Corporation 82546EB Gigabit Ethernet
> Controller (Copper) (rev 01)
> 03:02.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5703X
> Gigabit Ethernet (rev 02)
> 80:00.0 Memory controller: nVidia Corporation CK804 Memory Controller
> (rev a3)
> 80:01.0 Memory controller: nVidia Corporation CK804 Memory Controller
> (rev a3)
> 80:0d.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
> 80:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3)
> 81:00.0 PCI bridge: NEC Corporation uPD720400 PCI Express - PCI/PCI-X
> Bridge (rev 03)
> 81:00.1 PCI bridge: NEC Corporation uPD720400 PCI Express - PCI/PCI-X
> Bridge (rev 03)
> 83:04.0 SCSI storage controller: Adaptec AIC-7902B U320 (rev 10)
> 83:04.1 SCSI storage controller: Adaptec AIC-7902B U320 (rev 10)
> 84:00.0 VGA compatible controller: nVidia Corporation NV45GL [Quadro FX
> 3400/4400] (rev a2)
> 
> Kernel config is the same as that in the case of 4-way Opteron. Any
> ideas on what could be going wrong here? 
> 
> -- 
> Regards,
> Ankita Garg (ankita@in.ibm.com)
> Linux Technology Center
> IBM India Systems & Technology Labs, 
> Bangalore, India   

> Starting set_kthread_prio:  Setting kernel thread priorities: done
> [  OK  ]
> Starting smartd: [  OK  ]
> 
> Red Hat Enterprise Linux Server release 5.2 (Tikanga)
> Kernel 2.6.24.7-68ibmrt2.5 on an x86_64
> 
> intell-aus1.austin.ibm.com login: krcupreemptd new prio is 115??
> (bot:conmon-payload) connected
> SysRq : Trigger a crashdump
> Unable to handle kernel paging request at fffffffffffffff8 RIP:
>  [<ffffffff8100ade2>] default_idle+0x41/0x56
> PGD 203067 PUD 204067 PMD 0
> Oops: 0002 [1] PREEMPT SMP
> CPU 0
> Modules linked in: dm_multipath scsi_dh sr_mod snd_intel8x0 snd_ac97_codec snd_pcm_oss snd_pcm k8_edac k8temp edac_core hwmon pata_amd pata_acpi ata_generic sata_sil libata tg3 shpchp i2c_amd756 serio_raw cdrom i2c_amd8111 i2c_core amd_rng snd_mixer_oss snd_seq_oss snd_seq_midi_event snd_seq_dummy snd_seq snd_seq_device ac97_bus snd_timer snd soundcore snd_page_alloc floppy lp ac battery button sbs sbshc video output dm_mirror dm_mod xt_tcpudp ip6t_REJECT ipv6 nfnetlink nf_conntrack_ipv4 xt_state ipt_REJECTx_tables nf_conntrack_netbios_ns nf_conntrack sunrpc rfcomm hidp l2cap bluetooth autofs4 sg aic79xx scsi_transport_spi sd_mod scsi_mod pcspkr parport_pc parport ext3 jbd mbcache uhci_hcd ohci_hcd ehci_hcd
> Pid: 0, comm: swapper Not tainted 2.6.24.7-68ibmrt2.5 #1
> RIP: 0010:[<ffffffff8100ade2>]  [<ffffffff8100ade2>] default_idle+0x41/0x56
> RSP: 0018:ffffffff8149ff48  EFLAGS: 00010246
> RAX: 0000000000000000 RBX: ffffffff8100ada1 RCX: ffff810001008994
> RDX: ffff810001008990 RSI: 0000000000000046 RDI: ffffffff813b2230
> RBP: ffffffff8149ff48 R08: 0000000000000000 R09: ffff81024d82dda8
> R10: ffff810001008990 R11: ffffffff8149ff38 R12: ffffffffffffffff
> R13: ffffffff814cf080 R14: ffffffff814d14a0 R15: 0000000000000000
> FS:  00002b9aba1ff6e0(0000) GS:ffffffff813f3100(0000) knlGS:0000000000000000
> CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
> CR2: fffffffffffffff8 CR3: 000000024e4c2000 CR4: 00000000000006e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> Process swapper (pid: 0, threadinfo ffffffff8149e000, task ffffffff813ae7a0)
> Stack:  ffffffff8149ff68 ffffffff8100ae90 ffffffff8149ff68 0000000000000000
>  ffffffff8149ff78 ffffffff8128681e ffffffff8149ffb8 ffffffff814a8b70
>  0000000000000000 ffffffff814d14a0 ffff810000000000 00000000000930c0
> Call Trace:
>  [<ffffffff8100ae90>] cpu_idle+0x99/0xf8
>  [<ffffffff8128681e>] rest_init+0x82/0x84
>  [<ffffffff814a8b70>] start_kernel+0x31e/0x329
>  [<ffffffff814a8119>] _sinittext+0x119/0x120
> 
> 
> Code: f0 fa 65 48 8b 04 25 00 00 00 00 48 8b 40 08 8b 40 10 a8 08 75 17 65 48 8b 04 25 10 00 00 00 8b 80 38 e0 ff ff a8 40 75 Initializing cgroup subsys cpuset
> 04 inux version 2.6.24.7-68ibmrt2.5 (root@elm3b213.beavertob ibm.com) (gcc version 4.1.2 20070626 (Red Hat 4.1.2-14))4 #1 SMP PREEMPT RT Thu Jul 3 16:47:12 EDT 2008
> <eb>ommand line: root=/dev/sda3 ro  console=tty1 console=tty01,19200 irqpoll maxcpus=1 reset_devices initcall_debug mefb p=exactmap memmap=640K@0K memmap=130416K@33408K elfcoreh5 =163824K memmap=72K#2882944K memmap=56K#2883016K
> 48 BIOS-provided physical RAM map:
> 8b BIOS-e820: 0000000000000100 - 000000000009d400 (usable)
>  25 BIOS-e820: 000000000009d400 - 00000000000a0000 (reserved10 00 BIOS-e820: 00000000000d0000 - 0000000000100000 (reserve0)
> 00 BIOS-e820: 0000000000100000 - 00000000aff60000 (usable)
>  88 BIOS-e820: 00000000aff60000 - 00000000aff72000 (ACPI da3a)
> e0 BIOS-e820: 00000000aff72000 - 00000000aff80000 (ACPI NVS)
> ff BIOS-e820: 00000000aff80000 - 00000000b0002000 (reserved)
> c9 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reservec)
> 
>  BIOS-e820: 00000000fec00000 - 00000000fec00400 (reserved)
>  [<BIOS-fff8: 0ade2000fefau000 - e+0x0000x5600000 (reserved)
>   BIO<fff20: f81490010>
> 0000 - 0000000250000000 (usable)
> Cen: ffn_mffff= 24ff8
> 
> user-defined physical RAM map:
>  user: 0000000000000000 - 00000000000a0000 (usable)
>  user: 00000000020a0000 - 0000000009ffc000 (usable)
>  user: 00000000aff60000 - 00000000aff72000 (ACPI data)
>  user: 00000000aff72000 - 00000000aff80000 (ACPI data)
> end_pfn_map = 720768
> DMI present.
> ACPI: RSDP 000F6D90, 0024 (r2 PTLTD )
> ACPI: XSDT AFF6CAB5, 004C (r1 PTLTD      XSDT    6040000  LTP        0)
> ACPI: FACP AFF71CB7, 00F4 (r3 AMD    HAMMER    6040000 PTEC    F4240)
> ACPI: DSDT AFF6CB01, 5142 (r1 AMD-K8  AMDACPI  6040000 MSFT  100000E)
> ACPI: FACS AFF72FC0, 0040
> ACPI: SRAT AFF71DAB, 00F0 (r1 AMD    HAMMER    6040000 AMD         1)
> ACPI: MCFG AFF71E9B, 003C (r1 PTLTD    MCFG    6040000  LTP        0)
> ACPI: APIC AFF71ED7, 0082 (r1 PTLTD      APIC    6040000  LTP        0)
> ACPI: ASF! AFF71F59, 00A7 (r16    MBI     CETP  6040000 PTL         1)
> SRAT: PXM 0 -> APIC 0 -> Node 0
> SRAT: PXM 1 -> APIC 1 -> Node 1
> SRAT: Node 0 PXM 0 0-a0000
> SRAT: Node 0 PXM 0 0-b0000000
> SRAT: Node 0 PXM 0 0-150000000
> SRAT: Node 1 PXM 1 150000000-250000000
> Bootmem setup node 0 0000000000000000-0000000009ffc000
> Zone PFN ranges:
>   DMA             0 ->     4096
>   DMA32        4096 ->  1048576
>   Normal    1048576 ->  1048576
> Movable zone start PFN for each node
> early_node_map[2] active PFN ranges
>     0:        0 ->      160
>     0:     8352 ->    40956
> ACPI: PM-Timer IO Port: 0x8008
> ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
> Processor #0
> ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
> Processor #1 (Bootup-CPU)
> ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
> ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
> IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
> ACPI: IOAPIC (id[0x03] address[0xb0000000] gsi_base[24])
> IOAPIC[1]: apic_id 3, address 0xb0000000, GSI 24-27
> ACPI: IOAPIC (id[0x04] address[0xb0001000] gsi_base[28])
> IOAPIC[2]: apic_id 4, address 0xb0001000, GSI 28-31
> ACPI: IOAPIC (id[0x05] address[0xb0500000] gsi_base[32])
> IOAPIC[3]: apic_id 5, address 0xb0500000, GSI 32-55
> ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
> Setting APIC routing to flat
> Using ACPI (MADT) for SMP configuration information
> swsusp: Registered nosave memory region: 00000000000a0000 - 00000000020a0000
> Allocating PCI resources starting at 10000000 (gap: 9ffc000:a5f64000)
> SMP: Allowing 2 CPUs, 0 hotplug CPUs
> PERCPU: Allocating 41456 bytes of per cpu data
> Real-Time Preemption Support (C) 2004-2007 Ingo Molnar
> Built 1 zonelists in Node order, mobility grouping on.  Total pages: 31795
> Policy zone: DMA32
> Kernel command line: root=/dev/sda3 ro  console=tty1 console=ttyS0,19200 irqpoll maxcpus=1 reset_devices initcall_debug memmap=exactmap memmap=640K@0K memmap=130416K@33408K elfcorehdr=163824K memmap=72K#2882944K memmap=56K#2883016K
> irqpoll boot option not supported w/ CONFIG_PREEMPT_RT
> Initializing CPU#0
> PID hash table entries: 512 (order: 9, 4096 bytes)
> Extended CMOS year: 2000
> TSC calibrated against PM_TIMER
> Marking TSC unstable due to TSCs unsynchronized
> time.c: Detected 2393.255 MHz processor.
> Spurious LAPIC timer interrupt on cpu 0
> do_IRQ: 0.129 No irq handler for vector
> do_IRQ: 0.113 No irq handler for vector
> Console: colour VGA+ 80x25
> console [tty1] enabled
> console [ttyS0] enabled
> Checking aperture...
> CPU 0: aperture @ 14000000 size 64 MB
> CPU 1: aperture @ 14000000 size 64 MB
> Memory: 116516k/163824k available (2623k kernel code, 14540k reserved, 1419k data, 368k init)
> Calibrating delay using timer specific routine.. 4789.33 BogoMIPS (lpj=2394668)
> Security Framework initialized
> SELinux:  Initializing.
> selinux_register_security:  Registering secondary module capability
> Capability LSM initialized as secondary
> Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
> Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
> Mount-cache hash table entries: 256
> Initializing cgroup subsys ns
> Initializing cgroup subsys cpuacct
> CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
> CPU: L2 Cache: 1024K (64 bytes/line)
> CPU 0/1 -> Node 0
> SMP alternatives: switching to UP code
> ACPI: Core revision 20070126
> Using local APIC timer interrupts.
> Detected 12.464 MHz APIC timer.
> Brought up 1 CPUs
> Calling initcall 0xffffffff814c9d09: init_cpufreq_transition_notifier_list+0x0/0x14()
> initcall 0xffffffff814c9d09: init_cpufreq_transition_notifier_list+0x0/0x14() returned 0.
> initcall 0xffffffff814c9d09 ran for 0 msecs: init_cpufreq_transition_notifier_list+0x0/0x14()
> Calling initcall 0xffffffff814cc368: net_ns_init+0x0/0x13a()
> net_namespace: 144 bytes
> initcall 0xffffffff814cc368: net_ns_init+0x0/0x13a() returned 0.
> initcall 0xffffffff814cc368 ran for 13 msecs: net_ns_init+0x0/0x13a()
> Calling initcall 0xffffffff814b0b72: cpufreq_tsc+0x0/0x16()
> initcall 0xffffffff814b0b72: cpufreq_tsc+0x0/0x16() returned 0.
> initcall 0xffffffff814b0b72 ran for 0 msecs: cpufreq_tsc+0x0/0x16()
> Calling initcall 0xffffffff8101e56a: init_smp_flush+0x0/0x4f()
> initcall 0xffffffff8101e56a: init_smp_flush+0x0/0x4f() returned 0.
> initcall 0xffffffff8101e56a ran for 0 msecs: init_smp_flush+0x0/0x4f()
> Calling initcall 0xffffffff814b91ed: init_elf32_binfmt+0x0/0x12()
> initcall 0xffffffff814b91ed: init_elf32_binfmt+0x0/0x12() returned 0.
> initcall 0xffffffff814b91ed ran for 0 msecs: init_elf32_binfmt+0x0/0x12()
> Calling initcall 0xffffffff814ba341: sysctl_init+0x0/0x22()
> initcall 0xffffffff814ba341: sysctl_init+0x0/0x22() returned 0.
> initcall 0xffffffff814ba341 ran for 0 msecs: sysctl_init+0x0/0x22()
> Calling initcall 0xffffffff814bae2a: init_jiffies_clocksource+0x0/0x12()
> initcall 0xffffffff814bae2a: init_jiffies_clocksource+0x0/0x12() returned 0.
> initcall 0xffffffff814bae2a ran for 0 msecs: init_jiffies_clocksource+0x0/0x12()
> Calling initcall 0xffffffff814bb077: pm_init+0x0/0x29()
> initcall 0xffffffff814bb077: pm_init+0x0/0x29() returned 0.
> initcall 0xffffffff814bb077 ran for 0 msecs: pm_init+0x0/0x29()
> Calling initcall 0xffffffff814bb0b5: pm_disk_init+0x0/0x19()
> initcall 0xffffffff814bb0b5: pm_disk_init+0x0/0x19() returned 0.
> initcall 0xffffffff814bb0b5 ran for 0 msecs: pm_disk_init+0x0/0x19()
> Calling initcall 0xffffffff81067da0: swsusp_header_init+0x0/0x2c()
> initcall 0xffffffff81067da0: swsusp_header_init+0x0/0x2c() returned 0.
> initcall 0xffffffff81067da0 ran for 0 msecs: swsusp_header_init+0x0/0x2c()
> Calling initcall 0xffffffff814bbe19: ksysfs_init+0x0/0x5a()
> initcall 0xffffffff814bbe19: ksysfs_init+0x0/0x5a() returned 0.
> initcall 0xffffffff814bbe19 ran for 0 msecs: ksysfs_init+0x0/0x5a()
> Calling initcall 0xffffffff814bf2c2: filelock_init+0x0/0x2e()
> initcall 0xffffffff814bf2c2: filelock_init+0x0/0x2e() returned 0.
> initcall 0xffffffff814bf2c2 ran for 0 msecs: filelock_init+0x0/0x2e()
> Calling initcall 0xffffffff814bfdbd: init_misc_binfmt+0x0/0x3f()
> initcall 0xffffffff814bfdbd: init_misc_binfmt+0x0/0x3f() returned 0.
> initcall 0xffffffff814bfdbd ran for 0 msecs: init_misc_binfmt+0x0/0x3f()
> Calling initcall 0xffffffff814bfdfc: init_script_binfmt+0x0/0x12()
> initcall 0xffffffff814bfdfc: init_script_binfmt+0x0/0x12() returned 0.
> initcall 0xffffffff814bfdfc ran for 0 msecs: init_script_binfmt+0x0/0x12()
> Calling initcall 0xffffffff814bfe0e: init_elf_binfmt+0x0/0x12()
> initcall 0xffffffff814bfe0e: init_elf_binfmt+0x0/0x12() returned 0.
> initcall 0xffffffff814bfe0e ran for 0 msecs: init_elf_binfmt+0x0/0x12()
> Calling initcall 0xffffffff814c0f9e: debugfs_init+0x0/0x4a()
> initcall 0xffffffff814c0f9e: debugfs_init+0x0/0x4a() returned 0.
> initcall 0xffffffff814c0f9e ran for 0 msecs: debugfs_init+0x0/0x4a()
> Calling initcall 0xffffffff814c1405: securityfs_init+0x0/0x4a()
> initcall 0xffffffff814c1405: securityfs_init+0x0/0x4a() returned 0.
> initcall 0xffffffff814c1405 ran for 0 msecs: securityfs_init+0x0/0x4a()
> Calling initcall 0xffffffff814c1f50: random32_init+0x0/0x58()
> initcall 0xffffffff814c1f50: random32_init+0x0/0x58() returned 0.
> initcall 0xffffffff814c1f50 ran for 0 msecs: random32_init+0x0/0x58()
> Calling initcall 0xffffffff811b849a: early_resume_init+0x0/0x1cf()
> Time: 15:11:05  Date: 07/10/08
> initcall 0xffffffff811b849a: early_resume_init+0x0/0x1cf() returned 0.
> initcall 0xffffffff811b849a ran for 16 msecs: early_resume_init+0x0/0x1cf()
> Calling initcall 0xffffffff814c9d1d: cpufreq_core_init+0x0/0x75()
> initcall 0xffffffff814c9d1d: cpufreq_core_init+0x0/0x75() returned 0.
> initcall 0xffffffff814c9d1d ran for 0 msecs: cpufreq_core_init+0x0/0x75()
> Calling initcall 0xffffffff814c9db6: cpuidle_init+0x0/0x3b()
> initcall 0xffffffff814c9db6: cpuidle_init+0x0/0x3b() returned 0.
> initcall 0xffffffff814c9db6 ran for 0 msecs: cpuidle_init+0x0/0x3b()
> Calling initcall 0xffffffff814cc237: sock_init+0x0/0x5e()
> initcall 0xffffffff814cc237: sock_init+0x0/0x5e() returned 0.
> initcall 0xffffffff814cc237 ran for 0 msecs: sock_init+0x0/0x5e()
> Calling initcall 0xffffffff814ccbb9: netpoll_init+0x0/0x41()
> initcall 0xffffffff814ccbb9: netpoll_init+0x0/0x41() returned 0.
> initcall 0xffffffff814ccbb9 ran for 0 msecs: netpoll_init+0x0/0x41()
> Calling initcall 0xffffffff814ccf13: netlink_proto_init+0x0/0x159()
> NET: Registered protocol family 16
> initcall 0xffffffff814ccf13: netlink_proto_init+0x0/0x159() returned 0.
> initcall 0xffffffff814ccf13 ran for 18 msecs: netlink_proto_init+0x0/0x159()
> Calling initcall 0xffffffff814c1e56: kobject_uevent_init+0x0/0x45()
> initcall 0xffffffff814c1e56: kobject_uevent_init+0x0/0x45() returned 0.
> initcall 0xffffffff814c1e56 ran for 0 msecs: kobject_uevent_init+0x0/0x45()
> Calling initcall 0xffffffff814c223a: pcibus_class_init+0x0/0x12()
> initcall 0xffffffff814c223a: pcibus_class_init+0x0/0x12() returned 0.
> initcall 0xffffffff814c223a ran for 0 msecs: pcibus_class_init+0x0/0x12()
> Calling initcall 0xffffffff814c2772: pci_driver_init+0x0/0x12()
> initcall 0xffffffff814c2772: pci_driver_init+0x0/0x12() returned 0.
> initcall 0xffffffff814c2772 ran for 0 msecs: pci_driver_init+0x0/0x12()
> Calling initcall 0xffffffff814c3efd: backlight_class_init+0x0/0x49()
> initcall 0xffffffff814c3efd: backlight_class_init+0x0/0x49() returned 0.
> initcall 0xffffffff814c3efd ran for 0 msecs: backlight_class_init+0x0/0x49()
> Calling initcall 0xffffffff814c6fbe: tty_class_init+0x0/0x2a()
> initcall 0xffffffff814c6fbe: tty_class_init+0x0/0x2a() returned 0.
> initcall 0xffffffff814c6fbe ran for 0 msecs: tty_class_init+0x0/0x2a()
> Calling initcall 0xffffffff814c79d6: vtconsole_class_init+0x0/0xba()
> initcall 0xffffffff814c79d6: vtconsole_class_init+0x0/0xba() returned 0.
> initcall 0xffffffff814c79d6 ran for 0 msecs: vtconsole_class_init+0x0/0xba()
> Calling initcall 0xffffffff814c89dd: register_node_type+0x0/0x6b()
> initcall 0xffffffff814c89dd: register_node_type+0x0/0x6b() returned 0.
> initcall 0xffffffff814c89dd ran for 0 msecs: register_node_type+0x0/0x6b()
> Calling initcall 0xffffffff814b1393: mtrr_if_init+0x0/0x6c()
> initcall 0xffffffff814b1393: mtrr_if_init+0x0/0x6c() returned 0.
> initcall 0xffffffff814b1393 ran for 0 msecs: mtrr_if_init+0x0/0x6c()
> Calling initcall 0xffffffff814b2365: ffh_cstate_init+0x0/0x31()
> initcall 0xffffffff814b2365: ffh_cstate_init+0x0/0x31() returned -1.
> initcall 0xffffffff814b2365 ran for 0 msecs: ffh_cstate_init+0x0/0x31()
> initcall at 0xffffffff814b2365: ffh_cstate_init+0x0/0x31(): returned with error code -1
> Calling initcall 0xffffffff814c3a15: acpi_pci_init+0x0/0x4a()
> ACPI: bus type pci registered
> initcall 0xffffffff814c3a15: acpi_pci_init+0x0/0x4a() returned 0.
> initcall 0xffffffff814c3a15 ran for 15 msecs: acpi_pci_init+0x0/0x4a()
> Calling initcall 0xffffffff814c5c11: init_acpi_device_notify+0x0/0x4b()
> initcall 0xffffffff814c5c11: init_acpi_device_notify+0x0/0x4b() returned 0.
> initcall 0xffffffff814c5c11 ran for 0 msecs: init_acpi_device_notify+0x0/0x4b()
> Calling initcall 0xffffffff814ca5c7: dmi_id_init+0x0/0x2e9()
> initcall 0xffffffff814ca5c7: dmi_id_init+0x0/0x2e9() returned 0.
> initcall 0xffffffff814ca5c7 ran for 0 msecs: dmi_id_init+0x0/0x2e9()
> Calling initcall 0xffffffff814cb018: pci_access_init+0x0/0x46()
> PCI: BIOS Bug: MCFG area at e0000000 is not E820-reserved
> PCI: Not using MMCONFIG.
> PCI: Using configuration type 1
> initcall 0xffffffff814cb018: pci_access_init+0x0/0x46() returned 0.
> initcall 0xffffffff814cb018 ran for 60 msecs: pci_access_init+0x0/0x46()
> Calling initcall 0xffffffff814b11d6: mtrr_init_finialize+0x0/0x34()
> initcall 0xffffffff814b11d6: mtrr_init_finialize+0x0/0x34() returned 0.
> initcall 0xffffffff814b11d6 ran for 0 msecs: mtrr_init_finialize+0x0/0x34()
> Calling initcall 0xffffffff814b71f9: topology_init+0x0/0x89()
> initcall 0xffffffff814b71f9: topology_init+0x0/0x89() returned 0.
> initcall 0xffffffff814b71f9 ran for 0 msecs: topology_init+0x0/0x89()
> Calling initcall 0xffffffff814ba797: param_sysfs_init+0x0/0x1b2()
> initcall 0xffffffff814ba797: param_sysfs_init+0x0/0x1b2() returned 0.
> initcall 0xffffffff814ba797 ran for 0 msecs: param_sysfs_init+0x0/0x1b2()
> Calling initcall 0xffffffff810690f8: pm_sysrq_init+0x0/0x19()
> initcall 0xffffffff810690f8: pm_sysrq_init+0x0/0x19() returned 0.
> initcall 0xffffffff810690f8 ran for 0 msecs: pm_sysrq_init+0x0/0x19()
> Calling initcall 0xffffffff814be198: readahead_init+0x0/0x12()
> initcall 0xffffffff814be198: readahead_init+0x0/0x12() returned 0.
> initcall 0xffffffff814be198 ran for 0 msecs: readahead_init+0x0/0x12()
> Calling initcall 0xffffffff814bf986: init_bio+0x0/0xc5()
> initcall 0xffffffff814bf986: init_bio+0x0/0xc5() returned 0.
> initcall 0xffffffff814bf986 ran for 0 msecs: init_bio+0x0/0xc5()
> Calling initcall 0xffffffff814c1aaf: genhd_device_init+0x0/0x57()
> initcall 0xffffffff814c1aaf: genhd_device_init+0x0/0x57() returned 0.
> initcall 0xffffffff814c1aaf ran for 0 msecs: genhd_device_init+0x0/0x57()
> Calling initcall 0xffffffff814c3a5f: fbmem_init+0x0/0x95()
> initcall 0xffffffff814c3a5f: fbmem_init+0x0/0x95() returned 0.
> initcall 0xffffffff814c3a5f ran for 0 msecs: fbmem_init+0x0/0x95()
> Calling initcall 0xffffffff814c5a0f: acpi_init+0x0/0x202()
> ACPI: Interpreter enabled
> ACPI: (supports S0 S1 S3 S4 S5)
> ACPI: Using IOAPIC for interrupt routing
> initcall 0xffffffff814c5a0f: acpi_init+0x0/0x202() returned 0.
> initcall 0xffffffff814c5a0f ran for 54 msecs: acpi_init+0x0/0x202()
> Calling initcall 0xffffffff814c5d69: acpi_scan_init+0x0/0x11e()
> initcall 0xffffffff814c5d69: acpi_scan_init+0x0/0x11e() returned 0.
> initcall 0xffffffff814c5d69 ran for 3 msecs: acpi_scan_init+0x0/0x11e()
> Calling initcall 0xffffffff814c5e87: acpi_ec_init+0x0/0x61()
> initcall 0xffffffff814c5e87: acpi_ec_init+0x0/0x61() returned 0.
> initcall 0xffffffff814c5e87 ran for 0 msecs: acpi_ec_init+0x0/0x61()
> Calling initcall 0xffffffff814c6094: acpi_pci_root_init+0x0/0x28()
> ACPI: PCI Root Bridge [PCI0] (0000:00)
> ACPI: PCI Root Bridge [PCI1] (0000:80)

> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
