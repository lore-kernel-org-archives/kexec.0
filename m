Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mailout-de.gmx.net ([213.165.64.23])
 by merlin.infradead.org with smtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TAx2k-0001xW-C0
 for kexec@lists.infradead.org; Mon, 10 Sep 2012 06:00:23 +0000
Message-ID: <504D81EE.7070409@gmx.at>
Date: Mon, 10 Sep 2012 08:00:14 +0200
From: =?ISO-8859-1?Q?Christian_Schaubschl=E4ger?=
 <christian.schaubschlaeger@gmx.at>
MIME-Version: 1.0
Subject: Re: Problem with kexec on i386, linux-3.5
References: <500EE046.2000705@gmx.at> <504A5927.2090605@hp.com>
In-Reply-To: <504A5927.2090605@hp.com>
Content-Type: multipart/mixed; boundary="------------060901050902040703040606"
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Khalid Aziz <khalid.aziz@hp.com>

This is a multi-part message in MIME format.
--------------060901050902040703040606
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


Hello Khalid,

> Are you not loading the driver for your disk drive controller when the 
> new kernel boots up, even though you are not using the driver for disk 
> I/O? If yes, the driver should have re-enabled Bus Master bit in its 
> init routine. If you are loading the driver, which driver is it? I can 
> take a look at it and see if there is anything missing in the 
> initialization routine. Can you also include output from "lspci -v" from 
> your machine?

I'm not loading any drivers in my new kernel, I'm just doing pure BIOS disk I/O using Int13 calls (the program I start using kexec I would not actually call a 'kernel', it's just a very tiny piece of software which does some disk I/O and output on the screen).

Attached you find the output of lspci -v

Best regards
Christian



--------------060901050902040703040606
Content-Type: text/plain;
 name="lspic_d520.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="lspic_d520.txt"

00:00.0 Host bridge: Intel Corporation Mobile 945GM/PM/GMS, 943/940GML and 945GT Express Memory Controller Hub (rev 03)
	Subsystem: Dell Device 01d4
	Flags: bus master, fast devsel, latency 0
	Capabilities: [e0] Vendor Specific Information: Len=09 <?>

00:02.0 VGA compatible controller: Intel Corporation Mobile 945GM/GMS, 943/940GML Express Integrated Graphics Controller (rev 03) (prog-if 00 [VGA controller])
	Subsystem: Dell Device 01d4
	Flags: bus master, fast devsel, latency 0, IRQ 11
	Memory at eff00000 (32-bit, non-prefetchable) [size=512K]
	I/O ports at eff8 [size=8]
	Memory at d0000000 (32-bit, prefetchable) [size=256M]
	Memory at efec0000 (32-bit, non-prefetchable) [size=256K]
	Expansion ROM at <unassigned> [disabled]
	Capabilities: [90] MSI: Enable- Count=1/1 Maskable- 64bit-
	Capabilities: [d0] Power Management version 2

00:02.1 Display controller: Intel Corporation Mobile 945GM/GMS/GME, 943/940GML Express Integrated Graphics Controller (rev 03)
	Subsystem: Dell Device 01d4
	Flags: bus master, fast devsel, latency 0
	Memory at eff80000 (32-bit, non-prefetchable) [size=512K]
	Capabilities: [d0] Power Management version 2

00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition Audio Controller (rev 01)
	Subsystem: Dell Device 01d4
	Flags: bus master, fast devsel, latency 0, IRQ 10
	Memory at efebc000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
	Capabilities: [60] MSI: Enable- Count=1/1 Maskable- 64bit+
	Capabilities: [70] Express Root Complex Integrated Endpoint, MSI 00
	Capabilities: [100] Virtual Channel
	Capabilities: [130] Root Complex Link

00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 1 (rev 01) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=0b, subordinate=0b, sec-latency=0
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: c4000000-c41fffff
	Prefetchable memory behind bridge: 00000000c4200000-00000000c43fffff
	Capabilities: [40] Express Root Port (Slot+), MSI 00
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
	Capabilities: [90] Subsystem: Dell Device 01d4
	Capabilities: [a0] Power Management version 2
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Root Complex Link
	Kernel driver in use: pcieport

00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 2 (rev 01) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=0c, subordinate=0c, sec-latency=0
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: efd00000-efdfffff
	Prefetchable memory behind bridge: 00000000c4400000-00000000c45fffff
	Capabilities: [40] Express Root Port (Slot+), MSI 00
	Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-
	Capabilities: [90] Subsystem: Dell Device 01d4
	Capabilities: [a0] Power Management version 2
	Capabilities: [100] Virtual Channel
	Capabilities: [180] Root Complex Link
	Kernel driver in use: pcieport

00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI Controller #1 (rev 01) (prog-if 00 [UHCI])
	Subsystem: Dell Device 01d4
	Flags: bus master, medium devsel, latency 0, IRQ 9
	I/O ports at bf80 [size=32]
	Kernel driver in use: uhci_hcd
	Kernel modules: uhci-hcd

00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI Controller #2 (rev 01) (prog-if 00 [UHCI])
	Subsystem: Dell Device 01d4
	Flags: bus master, medium devsel, latency 0, IRQ 10
	I/O ports at bf60 [size=32]
	Kernel driver in use: uhci_hcd
	Kernel modules: uhci-hcd

00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI Controller #3 (rev 01) (prog-if 00 [UHCI])
	Subsystem: Dell Device 01d4
	Flags: bus master, medium devsel, latency 0, IRQ 5
	I/O ports at bf40 [size=32]
	Kernel driver in use: uhci_hcd
	Kernel modules: uhci-hcd

00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI Controller #4 (rev 01) (prog-if 00 [UHCI])
	Subsystem: Dell Device 01d4
	Flags: bus master, medium devsel, latency 0, IRQ 3
	I/O ports at bf20 [size=32]
	Kernel driver in use: uhci_hcd
	Kernel modules: uhci-hcd

00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI Controller (rev 01) (prog-if 20 [EHCI])
	Subsystem: Dell Device 01d4
	Flags: bus master, medium devsel, latency 0, IRQ 9
	Memory at ffa80000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Debug port: BAR=1 offset=00a0
	Kernel driver in use: ehci_hcd
	Kernel modules: ehci-hcd

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e1) (prog-if 01 [Subtractive decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=06, sec-latency=32
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: efc00000-efcfffff
	Prefetchable memory behind bridge: 00000000c0000000-00000000c3ffffff
	Capabilities: [50] Subsystem: Dell Device 01d4

00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface Bridge (rev 01)
	Subsystem: Dell Device 01d4
	Flags: bus master, medium devsel, latency 0
	Capabilities: [e0] Vendor Specific Information: Len=0c <?>

00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family) SATA IDE Controller (rev 01) (prog-if 80 [Master])
	Subsystem: Dell Device 01d4
	Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 7
	I/O ports at 01f0 [size=8]
	I/O ports at 03f4 [size=1]
	I/O ports at 0170 [size=8]
	I/O ports at 0374 [size=1]
	I/O ports at bfa0 [size=16]
	Capabilities: [70] Power Management version 2
	Kernel driver in use: ata_piix

00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 01)
	Subsystem: Dell Device 01d4
	Flags: medium devsel, IRQ 11
	I/O ports at 10c0 [size=32]

02:00.0 Ethernet controller: Broadcom Corporation BCM4401-B0 100Base-TX (rev 02)
	Subsystem: Dell Device 01d4
	Flags: bus master, fast devsel, latency 64, IRQ 7
	Memory at efcfe000 (32-bit, non-prefetchable) [size=8K]
	Capabilities: [40] Power Management version 2
	Kernel driver in use: b44
	Kernel modules: b44

02:01.0 CardBus bridge: O2 Micro, Inc. Cardbus bridge (rev 21)
	Subsystem: Dell Device 01d4
	Flags: bus master, stepping, slow devsel, latency 168, IRQ 5
	Memory at c8000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
	Memory window 0: c0000000-c3fff000 (prefetchable)
	Memory window 1: cc000000-cffff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	16-bit legacy interface ports at 0001
	Kernel driver in use: yenta_cardbus
	Kernel modules: yenta_socket

02:01.4 FireWire (IEEE 1394): O2 Micro, Inc. Firewire (IEEE 1394) (rev 02) (prog-if 10 [OHCI])
	Subsystem: Dell Device 01d4
	Flags: bus master, medium devsel, latency 64, IRQ 5
	Memory at efcfd000 (32-bit, non-prefetchable) [size=4K]
	Memory at efcfc800 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [60] Power Management version 2

0c:00.0 Network controller: Intel Corporation PRO/Wireless 3945ABG [Golan] Network Connection (rev 02)
	Subsystem: Intel Corporation Device 1021
	Flags: bus master, fast devsel, latency 0, IRQ 7
	Memory at efdff000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [c8] Power Management version 2
	Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
	Capabilities: [e0] Express Legacy Endpoint, MSI 00
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Device Serial Number 00-18-de-ff-ff-94-bc-2f
	Kernel driver in use: iwl3945
	Kernel modules: iwl3945


--------------060901050902040703040606
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--------------060901050902040703040606--

