Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.inmage.com ([67.207.115.103])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RofZq-0004Uu-2d
 for kexec@lists.infradead.org; Sat, 21 Jan 2012 18:22:11 +0000
From: Prashant Dinkar Kharche <pkharche@inmage.com>
Date: Sat, 21 Jan 2012 10:21:17 -0800
Subject: kdump not working Intel S5520UR motherboards with Xeon processor
Message-ID: <7967B71B602AF546971AB6303361B1A561AC86E1E8@mbe.inside.abhaisystems.com>
References: <20111027203029.GR3452@redhat.com> <4EA9D09E.800@draigBrady.com>
In-Reply-To: <4EA9D09E.800@draigBrady.com>
Content-Language: en-US
MIME-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hi,

I have been trying to get kdump working on Intel S5520 chipset with Xeon processor on RHEL 5 update 5  or update 6, but it appears that when I trigger a crash dump, system reboots abruptly right after loading the kdump kernel. Key observation during this experiment was that when I turn off acpi interrupt handling (acpi=off), crash has worked on RHEL 5 update 5. I have captured output of lspci and cpuinfo  below for reference.

Whereas, on RHEL 6 kdump works fine on this hardware. Could someone please help me identify the patches for RHEL 5 update 5 kernel that might be required for this issue?

00:00.0 Host bridge: Intel Corporation 5520 I/O Hub to ESI Port (rev 22)
00:01.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express Root Port 1 (rev 22)
00:03.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express Root Port 3 (rev 22)
00:05.0 PCI bridge: Intel Corporation 5520/X58 I/O Hub PCI Express Root Port 5 (rev 22)
00:07.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express Root Port 7 (rev 22)
00:09.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express Root Port 9 (rev 22)
00:0a.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express Root Port 10 (rev 22)
00:10.0 PIC: Intel Corporation 5520/5500/X58 Physical and Link Layer Registers Port 0 (rev 22)
00:10.1 PIC: Intel Corporation 5520/5500/X58 Routing and Protocol Layer Registers Port 0 (rev 22)
00:11.0 PIC: Intel Corporation 5520/5500 Physical and Link Layer Registers Port 1 (rev 22)
00:11.1 PIC: Intel Corporation 5520/5500 Routing & Protocol Layer Register Port 1 (rev 22)
00:13.0 PIC: Intel Corporation 5520/5500/X58 I/O Hub I/OxAPIC Interrupt Controller (rev 22)
00:14.0 PIC: Intel Corporation 5520/5500/X58 I/O Hub System Management Registers (rev 22)
00:14.1 PIC: Intel Corporation 5520/5500/X58 I/O Hub GPIO and Scratch Pad Registers (rev 22)
00:14.2 PIC: Intel Corporation 5520/5500/X58 I/O Hub Control Status and RAS Registers (rev 22)
00:14.3 PIC: Intel Corporation 5520/5500/X58 I/O Hub Throttle Registers (rev 22)
00:15.0 PIC: Intel Corporation 5520/5500/X58 Trusted Execution Technology Registers (rev 22)
00:16.0 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
00:16.1 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
00:16.2 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
00:16.3 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
00:16.4 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
00:16.5 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
00:16.6 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
00:16.7 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
00:1a.0 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #4
00:1a.1 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #5
00:1a.2 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #6
00:1a.7 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB2 EHCI Controller #2
00:1c.0 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI Express Root Port 1
00:1c.4 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI Express Root Port 5
00:1c.5 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI Express Root Port 6
00:1d.0 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #1
00:1d.1 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #2
00:1d.2 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #3
00:1d.7 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB2 EHCI Controller #1
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 90)
00:1f.0 ISA bridge: Intel Corporation 82801JIR (ICH10R) LPC Interface Controller
00:1f.2 IDE interface: Intel Corporation 82801JI (ICH10 Family) 4 port SATA IDE Controller #1
00:1f.3 SMBus: Intel Corporation 82801JI (ICH10 Family) SMBus Controller
00:1f.5 IDE interface: Intel Corporation 82801JI (ICH10 Family) 2 port SATA IDE Controller #2
01:00.0 Ethernet controller: Intel Corporation 82575EB Gigabit Network Connection (rev 02)
01:00.1 Ethernet controller: Intel Corporation 82575EB Gigabit Network Connection (rev 02)
03:00.0 PCI bridge: Integrated Device Technology, Inc. PES24T3G2 PCI Express Gen2 Switch (rev 02)
04:02.0 PCI bridge: Integrated Device Technology, Inc. PES24T3G2 PCI Express Gen2 Switch (rev 02)
04:04.0 PCI bridge: Integrated Device Technology, Inc. PES24T3G2 PCI Express Gen2 Switch (rev 02)
05:00.0 PCI bridge: NEC Corporation Unknown device 014f (rev 02)
06:00.0 PCI bridge: NEC Corporation Unknown device 0150 (rev 02)
06:01.0 PCI bridge: NEC Corporation Unknown device 0151 (rev 02)
06:02.0 PCI bridge: NEC Corporation Unknown device 0152 (rev 02)
07:00.0 Fibre Channel: QLogic Corp. ISP2432-based 4Gb Fibre Channel to PCI Express HBA (rev 03)
07:00.1 Fibre Channel: QLogic Corp. ISP2432-based 4Gb Fibre Channel to PCI Express HBA (rev 03)
08:00.0 Fibre Channel: QLogic Corp. ISP2432-based 4Gb Fibre Channel to PCI Express HBA (rev 03)
08:00.1 Fibre Channel: QLogic Corp. ISP2432-based 4Gb Fibre Channel to PCI Express HBA (rev 03)
0b:00.0 PCI bridge: Integrated Device Technology, Inc. PES24T3G2 PCI Express Gen2 Switch (rev 02)
0c:02.0 PCI bridge: Integrated Device Technology, Inc. PES24T3G2 PCI Express Gen2 Switch (rev 02)
0c:04.0 PCI bridge: Integrated Device Technology, Inc. PES24T3G2 PCI Express Gen2 Switch (rev 02)
0e:00.0 Ethernet controller: Intel Corporation 82571EB Gigabit Ethernet Controller (rev 06)
0e:00.1 Ethernet controller: Intel Corporation 82571EB Gigabit Ethernet Controller (rev 06)
0f:00.0 SCSI storage controller: LSI Logic / Symbios Logic SAS1064ET PCI-Express Fusion-MPT SAS (rev 08)
12:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200e [Pilot] ServerEngines (SEP1) (rev 02)

Total 16 cores on CPU --
processor       : 15
vendor_id       : GenuineIntel
cpu family      : 6
model           : 26
model name      : Intel(R) Xeon(R) CPU           E5540  @ 2.53GHz
stepping        : 5
cpu MHz         : 2527.364
cache size      : 8192 KB
physical id     : 1
siblings        : 8
core id         : 3
cpu cores       : 4
apicid          : 23
fpu             : yes
fpu_exception   : yes
cpuid level     : 11
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm syscall nx rdtscp lm constant_tsc ida nonstop_tsc pni monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr sse4_1 sse4_2 popcnt lahf_lm
bogomips        : 5054.56
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: [8]

Thanking you in anticipation.

Regards,
Prashant

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
