Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4zsA-0006lF-Vz
 for kexec@lists.infradead.org; Thu, 28 Jan 2021 05:29:41 +0000
Date: Thu, 28 Jan 2021 13:29:24 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: amdgpu problem after kexec
Message-ID: <20210128052924.GC2339@MiWiFi-R3L-srv>
References: <CAN_LGv3Go0DgKbjPVHFFXU+U8RRU15m-np3F6_RrVmx6FmBoHQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAN_LGv3Go0DgKbjPVHFFXU+U8RRU15m-np3F6_RrVmx6FmBoHQ@mail.gmail.com>
Content-Disposition: inline
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
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: dyoung@redhat.com, kexec@lists.infradead.org, amd-gfx@lists.freedesktop.org

On 01/11/21 at 01:17pm, Alexander E. Patrakov wrote:
> Hello,
> 
> I was trying out kexec on my new laptop, which is a HP EliteBook 735
> G6. The problem is, amdgpu does not have hardware acceleration after
> kexec. Also, strangely, the lines about BlueTooth are missing from
> dmesg after kexec, but I have not tried to use BlueTooth on this
> laptop yet. I don't know how to debug this, the relevant amdgpu lines
> in dmesg are:
> 
> amdgpu 0000:04:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB
> test failed on gfx (-110).
> [drm:process_one_work] *ERROR* ib ring test failed (-110).
> 
> The good and bad dmesg files are attached. Is it a kexec problem (and
> amdgpu is only a victim), or should I take it to amdgpu lists? Do I
> need to provide some extra kernel arguments for debugging?

I am not familiar with graphical component. Add Dave to CC to see if
he has some comments. It would be great if amdgpu expert can have a look. 

Thanks
Baoquan

> 
> -- 
> Alexander E. Patrakov
> CV: http://pc.cd/PLz7

> [    0.000000] Linux version 5.10.5-zen1-1-zen (linux-zen@archlinux) (gcc (GCC) 10.2.0, GNU ld (GNU Binutils) 2.35.1) #1 ZEN SMP PREEMPT Thu, 07 Jan 2021 09:50:48 +0000
> [    0.000000] Command line: initrd=\EFI\ArchLinux\initramfs-linux-zen.img quiet
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> [    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> [    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'compacted' format.
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000100-0x000000000009ffff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000009efffff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000009f00000-0x0000000009f0afff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x0000000009f0b000-0x00000000381cefff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000381cf000-0x0000000038fcefff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000038fcf000-0x00000000396cefff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x00000000396cf000-0x000000003974efff] ACPI data
> [    0.000000] BIOS-e820: [mem 0x000000003974f000-0x000000005dffffff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fd100000-0x00000000fd1fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed80fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fedf1000-0x00000000fedf1fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000041f33ffff] usable
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] e820: update [mem 0x00100000-0x0010006f] usable ==> usable
> [    0.000000] extended physical RAM map:
> [    0.000000] reserve setup_data: [mem 0x0000000000000100-0x000000000009ffff] usable
> [    0.000000] reserve setup_data: [mem 0x0000000000100000-0x000000000010006f] usable
> [    0.000000] reserve setup_data: [mem 0x0000000000100070-0x0000000009efffff] usable
> [    0.000000] reserve setup_data: [mem 0x0000000009f00000-0x0000000009f0afff] ACPI NVS
> [    0.000000] reserve setup_data: [mem 0x0000000009f0b000-0x00000000381cefff] usable
> [    0.000000] reserve setup_data: [mem 0x00000000381cf000-0x0000000038fcefff] reserved
> [    0.000000] reserve setup_data: [mem 0x0000000038fcf000-0x00000000396cefff] ACPI NVS
> [    0.000000] reserve setup_data: [mem 0x00000000396cf000-0x000000003974efff] ACPI data
> [    0.000000] reserve setup_data: [mem 0x000000003974f000-0x000000005dffffff] usable
> [    0.000000] reserve setup_data: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000fd100000-0x00000000fd1fffff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000fed80000-0x00000000fed80fff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000fedf1000-0x00000000fedf1fff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
> [    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000041f33ffff] usable
> [    0.000000] efi: EFI v2.60 by HP
> [    0.000000] efi: ACPI=0x3974e000 ACPI 2.0=0x3974e014 SMBIOS=0x388c8000 SMBIOS 3.0=0x388c6000 ESRT=0x388c4118 TPMFinalLog=0x39621000 MEMATTR=0x3474d018 RNG=0x388afb18 TPMEventLog=0x2337a018 
> [    0.000000] efi: seeding entropy pool
> [    0.000000] SMBIOS 3.1.1 present.
> [    0.000000] DMI: HP HP EliteBook 735 G6/8589, BIOS R74 Ver. 01.05.00 04/15/2020
> [    0.000000] tsc: Fast TSC calibration using PIT
> [    0.000000] tsc: Detected 2295.664 MHz processor
> [    0.000028] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> [    0.000031] e820: remove [mem 0x000a0000-0x000fffff] usable
> [    0.000039] last_pfn = 0x41f340 max_arch_pfn = 0x400000000
> [    0.000047] MTRR default type: uncachable
> [    0.000048] MTRR fixed ranges enabled:
> [    0.000050]   00000-9FFFF write-back
> [    0.000051]   A0000-BFFFF uncachable
> [    0.000052]   C0000-DFFFF write-protect
> [    0.000053]   E0000-FFFFF uncachable
> [    0.000054] MTRR variable ranges enabled:
> [    0.000056]   0 base 0000FF000000 mask FFFFFF000000 write-protect
> [    0.000058]   1 base 000000000000 mask FFFF80000000 write-back
> [    0.000059]   2 base 000080000000 mask FFFFC0000000 write-back
> [    0.000060]   3 base 0000C0000000 mask FFFFE0000000 write-back
> [    0.000061]   4 disabled
> [    0.000062]   5 disabled
> [    0.000062]   6 disabled
> [    0.000063]   7 disabled
> [    0.000065] TOM2: 0000000420000000 aka 16896M
> [    0.000884] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
> [    0.001185] last_pfn = 0x5e000 max_arch_pfn = 0x400000000
> [    0.007980] esrt: Reserving ESRT space from 0x00000000388c4118 to 0x00000000388c4150.
> [    0.007993] check: Scanning 1 areas for low memory corruption
> [    0.008007] Using GB pages for direct mapping
> [    0.008451] Secure boot could not be determined
> [    0.008453] RAMDISK: [mem 0x4198a9000-0x41bdfffff]
> [    0.008469] ACPI: Early table checksum verification disabled
> [    0.008477] ACPI: RSDP 0x000000003974E014 000024 (v02 HPQOEM)
> [    0.008483] ACPI: XSDT 0x0000000039720188 000134 (v01 HPQOEM SLIC-BPC 00000001      01000013)
> [    0.008494] ACPI: FACP 0x000000003973C000 00010C (v05 HPQOEM SLIC-BPC 00000001 HP   00000001)
> [    0.008502] ACPI: DSDT 0x0000000039724000 010B6A (v02 HPQOEM 8589     00000000 INTL 20160527)
> [    0.008507] ACPI: FACS 0x000000003960C000 000040
> [    0.008510] ACPI: SSDT 0x000000003974C000 0002D7 (v01 HP     NVTEC    00000001 INTL 20160527)
> [    0.008515] ACPI: SSDT 0x000000003974B000 00012A (v02 HP     ShmTable 00000001 INTL 20160527)
> [    0.008519] ACPI: SSDT 0x0000000039745000 005419 (v02 AMD    AmdTable 00000002 MSFT 02000002)
> [    0.008523] ACPI: UEFI 0x0000000039630000 000042 (v01 HPQOEM EDK2     00000002      01000013)
> [    0.008526] ACPI: RTMA 0x0000000039743000 00009E (v01 HP     _HBMART_ 00001000 HP   00000001)
> [    0.008530] ACPI: SSDT 0x0000000039741000 001575 (v02 HP     UcsiAcpi 00000001 INTL 20160527)
> [    0.008534] ACPI: SSDT 0x0000000039740000 0000FB (v02 HP     UcsiCntr 00000001 INTL 20160527)
> [    0.008537] ACPI: SSDT 0x000000003973F000 0003CE (v02 HPQOEM Tpm2Tabl 00001000 INTL 20160527)
> [    0.008541] ACPI: TPM2 0x000000003973E000 000034 (v03 HPQOEM EDK2     00000002      01000013)
> [    0.008545] ACPI: OEML 0x000000003973D000 000028 (v03 HPQOEM EDK2     00000002      01000013)
> [    0.008548] ACPI: ASF! 0x000000003973B000 00006E (v32 HPQOEM 8589     00000001 HP   00000001)
> [    0.008552] ACPI: MSDM 0x000000003973A000 000055 (v03 HPQOEM SLIC-BPC 00000000 HP   00000001)
> [    0.008556] ACPI: SLIC 0x0000000039739000 000176 (v01 HPQOEM SLIC-BPC 00000001 HP   00000001)
> [    0.008559] ACPI: WSMT 0x0000000039738000 000028 (v01 HPQOEM 8589     00000001 HP   00000001)
> [    0.008563] ACPI: HPET 0x0000000039737000 000038 (v01 HPQOEM 8589     00000001 HP   00000001)
> [    0.008567] ACPI: APIC 0x0000000039736000 000138 (v02 HPQOEM 8589     00000001 HP   00000001)
> [    0.008570] ACPI: MCFG 0x0000000039735000 00003C (v01 HPQOEM 8589     00000001 HP   00000001)
> [    0.008574] ACPI: SSDT 0x0000000039721000 00119C (v01 AMD    AMD CPU  00000001 AMD  00000001)
> [    0.008577] ACPI: CRAT 0x000000003974D000 000810 (v01 AMD    AMD CRAT 00000001 AMD  00000001)
> [    0.008581] ACPI: CDIT 0x000000003971F000 000029 (v01 AMD    AMD CDIT 00000001 AMD  00000001)
> [    0.008584] ACPI: SSDT 0x000000003971E000 00013B (v01 HP     HPNBCONV 00001000 INTL 20160527)
> [    0.008588] ACPI: SSDT 0x000000003971D000 000245 (v01 HP     AMDTPL   00001000 INTL 20160527)
> [    0.008592] ACPI: SSDT 0x000000003971C000 0008F5 (v01 HP     HPADNBWL 00001000 INTL 20160527)
> [    0.008595] ACPI: SSDT 0x000000003971B000 000032 (v01 HP     HPCONDEV 00001000 INTL 20160527)
> [    0.008599] ACPI: SSDT 0x000000003971A000 000069 (v01 HP     HPCAHWID 00001000 INTL 20160527)
> [    0.008603] ACPI: VFCT 0x000000003970C000 00D484 (v01 HPQOEM SLIC-BPC 00000001 AMD  31504F47)
> [    0.008606] ACPI: SSDT 0x0000000039723000 000949 (v01 AMD    AmdTable 00000001 INTL 20160527)
> [    0.008610] ACPI: FPDT 0x000000003970B000 000044 (v01 HPQOEM EDK2     00000002      01000013)
> [    0.008613] ACPI: SSDT 0x0000000039708000 0024C8 (v01 AMD    AmdTable 00000001 INTL 20160527)
> [    0.008617] ACPI: BGRT 0x0000000039707000 000038 (v01 HPQOEM EDK2     00000002      01000013)
> [    0.008621] ACPI: SSDT 0x0000000039706000 000668 (v01 AMD    AmdTable 00000001 INTL 20160527)
> [    0.008624] ACPI: SSDT 0x0000000039744000 0002F9 (v02 HP     PwrCtlEv 00000001 INTL 20160527)
> [    0.008628] ACPI: IVRS 0x0000000039705000 00013E (v02 AMD    AMD IVRS 00000001 AMD  00000000)
> [    0.008638] ACPI: Local APIC address 0xfee00000
> [    0.008713] No NUMA configuration found
> [    0.008715] Faking a node at [mem 0x0000000000000000-0x000000041f33ffff]
> [    0.008721] NODE_DATA(0) allocated [mem 0x41f33c000-0x41f33ffff]
> [    0.058743] Zone ranges:
> [    0.058748]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.058751]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> [    0.058753]   Normal   [mem 0x0000000100000000-0x000000041f33ffff]
> [    0.058754]   Device   empty
> [    0.058756] Movable zone start for each node
> [    0.058757] Early memory node ranges
> [    0.058758]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
> [    0.058759]   node   0: [mem 0x0000000000100000-0x0000000009efffff]
> [    0.058760]   node   0: [mem 0x0000000009f0b000-0x00000000381cefff]
> [    0.058761]   node   0: [mem 0x000000003974f000-0x000000005dffffff]
> [    0.058762]   node   0: [mem 0x0000000100000000-0x000000041f33ffff]
> [    0.059021] Zeroed struct page in unavailable ranges: 17068 pages
> [    0.059024] Initmem setup node 0 [mem 0x0000000000001000-0x000000041f33ffff]
> [    0.059027] On node 0 totalpages: 3652948
> [    0.059029]   DMA zone: 64 pages used for memmap
> [    0.059030]   DMA zone: 25 pages reserved
> [    0.059031]   DMA zone: 3999 pages, LIFO batch:0
> [    0.059091]   DMA32 zone: 5866 pages used for memmap
> [    0.059092]   DMA32 zone: 375413 pages, LIFO batch:63
> [    0.064409]   Normal zone: 51149 pages used for memmap
> [    0.064414]   Normal zone: 3273536 pages, LIFO batch:63
> [    0.110740] ACPI: PM-Timer IO Port: 0x408
> [    0.110748] ACPI: Local APIC address 0xfee00000
> [    0.110759] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
> [    0.110761] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> [    0.110762] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
> [    0.110762] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
> [    0.110763] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
> [    0.110764] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
> [    0.110765] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
> [    0.110766] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
> [    0.110767] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
> [    0.110768] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
> [    0.110769] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
> [    0.110770] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
> [    0.110770] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
> [    0.110771] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
> [    0.110772] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
> [    0.110773] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
> [    0.110797] IOAPIC[0]: apic_id 33, version 33, address 0xfec00000, GSI 0-23
> [    0.110806] IOAPIC[1]: apic_id 34, version 33, address 0xfec01000, GSI 24-55
> [    0.110809] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.110811] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
> [    0.110813] ACPI: IRQ0 used by override.
> [    0.110815] ACPI: IRQ9 used by override.
> [    0.110818] Using ACPI (MADT) for SMP configuration information
> [    0.110820] ACPI: HPET id: 0x10228210 base: 0xfed00000
> [    0.110835] e820: update [mem 0x33bdc000-0x33c24fff] usable ==> reserved
> [    0.110852] smpboot: Allowing 16 CPUs, 8 hotplug CPUs
> [    0.110879] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
> [    0.110881] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000fffff]
> [    0.110882] PM: hibernation: Registered nosave memory: [mem 0x00100000-0x00100fff]
> [    0.110884] PM: hibernation: Registered nosave memory: [mem 0x09f00000-0x09f0afff]
> [    0.110886] PM: hibernation: Registered nosave memory: [mem 0x33bdc000-0x33c24fff]
> [    0.110887] PM: hibernation: Registered nosave memory: [mem 0x381cf000-0x38fcefff]
> [    0.110888] PM: hibernation: Registered nosave memory: [mem 0x38fcf000-0x396cefff]
> [    0.110889] PM: hibernation: Registered nosave memory: [mem 0x396cf000-0x3974efff]
> [    0.110891] PM: hibernation: Registered nosave memory: [mem 0x5e000000-0xf7ffffff]
> [    0.110891] PM: hibernation: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
> [    0.110892] PM: hibernation: Registered nosave memory: [mem 0xfc000000-0xfd0fffff]
> [    0.110893] PM: hibernation: Registered nosave memory: [mem 0xfd100000-0xfd1fffff]
> [    0.110894] PM: hibernation: Registered nosave memory: [mem 0xfd200000-0xfebfffff]
> [    0.110894] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
> [    0.110895] PM: hibernation: Registered nosave memory: [mem 0xfec01000-0xfec0ffff]
> [    0.110896] PM: hibernation: Registered nosave memory: [mem 0xfec10000-0xfec10fff]
> [    0.110896] PM: hibernation: Registered nosave memory: [mem 0xfec11000-0xfed7ffff]
> [    0.110897] PM: hibernation: Registered nosave memory: [mem 0xfed80000-0xfed80fff]
> [    0.110898] PM: hibernation: Registered nosave memory: [mem 0xfed81000-0xfedf0fff]
> [    0.110899] PM: hibernation: Registered nosave memory: [mem 0xfedf1000-0xfedf1fff]
> [    0.110899] PM: hibernation: Registered nosave memory: [mem 0xfedf2000-0xfedfffff]
> [    0.110900] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
> [    0.110901] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0xfeffffff]
> [    0.110902] PM: hibernation: Registered nosave memory: [mem 0xff000000-0xffffffff]
> [    0.110904] [mem 0x5e000000-0xf7ffffff] available for PCI devices
> [    0.110906] Booting paravirtualized kernel on bare hardware
> [    0.110911] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
> [    0.117677] setup_percpu: NR_CPUS:320 nr_cpumask_bits:320 nr_cpu_ids:16 nr_node_ids:1
> [    0.119048] percpu: Embedded 56 pages/cpu s192512 r8192 d28672 u262144
> [    0.119060] pcpu-alloc: s192512 r8192 d28672 u262144 alloc=1*2097152
> [    0.119063] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 13 14 15 
> [    0.119103] Built 1 zonelists, mobility grouping on.  Total pages: 3595844
> [    0.119104] Policy zone: Normal
> [    0.119107] Kernel command line: initrd=\EFI\ArchLinux\initramfs-linux-zen.img quiet
> [    0.122651] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
> [    0.124378] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
> [    0.124453] mem auto-init: stack:byref_all(zero), heap alloc:on, heap free:off
> [    0.194105] Memory: 14208336K/14611792K available (16392K kernel code, 2040K rwdata, 8724K rodata, 1720K init, 4188K bss, 403196K reserved, 0K cma-reserved)
> [    0.194125] random: get_random_u64 called from __kmem_cache_create+0x28/0x630 with crng_init=0
> [    0.194460] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
> [    0.194510] ftrace: allocating 39659 entries in 155 pages
> [    0.215096] ftrace: allocated 155 pages with 5 groups
> [    0.215339] rcu: Preemptible hierarchical RCU implementation.
> [    0.215341] rcu: 	RCU dyntick-idle grace-period acceleration is enabled.
> [    0.215342] rcu: 	RCU restricting CPUs from NR_CPUS=320 to nr_cpu_ids=16.
> [    0.215343] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
> [    0.215344] 	Trampoline variant of Tasks RCU enabled.
> [    0.215345] 	Rude variant of Tasks RCU enabled.
> [    0.215346] 	Tracing variant of Tasks RCU enabled.
> [    0.215347] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
> [    0.215348] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
> [    0.219776] NR_IRQS: 20736, nr_irqs: 1096, preallocated irqs: 16
> [    0.221785] Console: colour dummy device 80x25
> [    0.221803] printk: console [tty0] enabled
> [    0.221833] ACPI: Core revision 20200925
> [    0.222193] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
> [    0.222236] APIC: Switch to symmetric I/O mode setup
> [    0.223559] AMD-Vi: ivrs, add hid:PNP0D40, uid:, rdevid:152
> [    0.415504] Switched APIC routing to physical flat.
> [    0.416594] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    0.421242] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2117351afbb, max_idle_ns: 440795213115 ns
> [    0.421251] Calibrating delay loop (skipped), value calculated using timer frequency.. 4591.32 BogoMIPS (lpj=2295664)
> [    0.421255] pid_max: default: 32768 minimum: 301
> [    0.421419] LSM: Security Framework initializing
> [    0.421426] Yama: becoming mindful.
> [    0.421531] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
> [    0.421585] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
> [    0.422313] LVT offset 1 assigned for vector 0xf9
> [    0.422403] LVT offset 2 assigned for vector 0xf4
> [    0.422431] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512
> [    0.422432] Last level dTLB entries: 4KB 1536, 2MB 1536, 4MB 768, 1GB 0
> [    0.422437] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
> [    0.422439] Spectre V2 : Mitigation: Full AMD retpoline
> [    0.422441] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
> [    0.422443] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
> [    0.422444] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
> [    0.422452] clr: Applying alternatives
> [    0.422845] clr: Applying alternatives done
> [    0.422869] Freeing SMP alternatives memory: 40K
> [    0.526364] smpboot: CPU0: AMD Ryzen 7 PRO 3700U w/ Radeon Vega Mobile Gfx (family: 0x17, model: 0x18, stepping: 0x1)
> [    0.526525] Performance Events: Fam17h+ core perfctr, AMD PMU driver.
> [    0.526533] ... version:                0
> [    0.526533] ... bit width:              48
> [    0.526534] ... generic registers:      6
> [    0.526535] ... value mask:             0000ffffffffffff
> [    0.526535] ... max period:             00007fffffffffff
> [    0.526536] ... fixed-purpose events:   0
> [    0.526537] ... event mask:             000000000000003f
> [    0.526656] rcu: Hierarchical SRCU implementation.
> [    0.527244] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
> [    0.527475] smp: Bringing up secondary CPUs ...
> [    0.527656] x86: Booting SMP configuration:
> [    0.527658] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7
> [    0.540385] smp: Brought up 1 node, 8 CPUs
> [    0.540385] smpboot: Max logical packages: 2
> [    0.540385] smpboot: Total of 8 processors activated (36730.62 BogoMIPS)
> [    0.542653] devtmpfs: initialized
> [    0.542653] x86/mm: Memory block size: 128MB
> [    0.544291] PM: Registering ACPI NVS region [mem 0x09f00000-0x09f0afff] (45056 bytes)
> [    0.544294] PM: Registering ACPI NVS region [mem 0x38fcf000-0x396cefff] (7340032 bytes)
> [    0.544568] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> [    0.544568] futex hash table entries: 4096 (order: 6, 262144 bytes, linear)
> [    0.544568] pinctrl core: initialized pinctrl subsystem
> [    0.545259] PM: RTC time: 07:59:27, date: 2021-01-11
> [    0.545548] NET: Registered protocol family 16
> [    0.545990] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic allocations
> [    0.546437] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
> [    0.546849] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
> [    0.546884] audit: initializing netlink subsys (disabled)
> [    0.546927] audit: type=2000 audit(1610351967.133:1): state=initialized audit_enabled=0 res=1
> [    0.547351] thermal_sys: Registered thermal governor 'fair_share'
> [    0.547352] thermal_sys: Registered thermal governor 'bang_bang'
> [    0.547353] thermal_sys: Registered thermal governor 'step_wise'
> [    0.547354] thermal_sys: Registered thermal governor 'user_space'
> [    0.547355] thermal_sys: Registered thermal governor 'power_allocator'
> [    0.547378] cpuidle: using governor ladder
> [    0.547383] cpuidle: using governor menu
> [    0.547429] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
> [    0.547429] ACPI: bus type PCI registered
> [    0.547429] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [    0.547487] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
> [    0.547495] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
> [    0.547513] PCI: Using configuration type 1 for base access
> [    0.550274] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
> [    0.550276] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
> [    0.553513] ACPI: Added _OSI(Module Device)
> [    0.553516] ACPI: Added _OSI(Processor Device)
> [    0.553517] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    0.553519] ACPI: Added _OSI(Processor Aggregator Device)
> [    0.553522] ACPI: Added _OSI(Linux-Dell-Video)
> [    0.553524] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
> [    0.553525] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
> [    0.583284] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.LPC0.EC0], AE_NOT_FOUND (20200925/dswload2-162)
> [    0.583299] ACPI Error: AE_NOT_FOUND, During name lookup/catalog (20200925/psobject-220)
> [    0.583304] ACPI: Skipping parse of AML opcode: Scope (0x0010)
> [    0.588202] ACPI: 17 ACPI AML tables successfully acquired and loaded
> [    0.599470] ACPI: EC: EC started
> [    0.599472] ACPI: EC: interrupt blocked
> [    0.600311] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
> [    0.622608] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
> [    0.622614] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC used to handle transactions
> [    0.622615] ACPI: Interpreter enabled
> [    0.622671] ACPI: (supports S0 S3 S4 S5)
> [    0.622674] ACPI: Using IOAPIC for interrupt routing
> [    0.623820] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [    0.624755] ACPI: Enabled 8 GPEs in block 00 to 1F
> [    0.626580] ACPI: Power Resource [PXP] (off)
> [    0.627946] ACPI: Power Resource [WLRT] (on)
> [    0.631788] ACPI: Power Resource [APPR] (off)
> [    0.641910] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> [    0.641923] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
> [    0.642237] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug LTR DPC]
> [    0.642541] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
> [    0.642544] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
> [    0.642581] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-3f] only partially covers this bridge
> [    0.643041] PCI host bridge to bus 0000:00
> [    0.643045] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> [    0.643051] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> [    0.643054] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> [    0.643056] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000c3fff window]
> [    0.643058] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c7fff window]
> [    0.643060] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000cbfff window]
> [    0.643063] pci_bus 0000:00: root bus resource [mem 0x000cc000-0x000cffff window]
> [    0.643065] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3fff window]
> [    0.643067] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff window]
> [    0.643069] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff window]
> [    0.643071] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff window]
> [    0.643073] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3fff window]
> [    0.643075] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7fff window]
> [    0.643077] pci_bus 0000:00: root bus resource [mem 0x000e8000-0x000ebfff window]
> [    0.643079] pci_bus 0000:00: root bus resource [mem 0x000ec000-0x000effff window]
> [    0.643081] pci_bus 0000:00: root bus resource [mem 0xe0000000-0xf7ffffff window]
> [    0.643083] pci_bus 0000:00: root bus resource [mem 0xfc000000-0xfeafffff window]
> [    0.643086] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    0.643113] pci 0000:00:00.0: [1022:15d0] type 00 class 0x060000
> [    0.643298] pci 0000:00:00.2: [1022:15d1] type 00 class 0x080600
> [    0.643494] pci 0000:00:01.0: [1022:1452] type 00 class 0x060000
> [    0.643655] pci 0000:00:01.3: [1022:15d3] type 01 class 0x060400
> [    0.643790] pci 0000:00:01.3: PME# supported from D0 D3hot D3cold
> [    0.644023] pci 0000:00:01.4: [1022:15d3] type 01 class 0x060400
> [    0.644194] pci 0000:00:01.4: PME# supported from D0 D3hot D3cold
> [    0.644375] pci 0000:00:01.7: [1022:15d3] type 01 class 0x060400
> [    0.644507] pci 0000:00:01.7: PME# supported from D0 D3hot D3cold
> [    0.644730] pci 0000:00:08.0: [1022:1452] type 00 class 0x060000
> [    0.644892] pci 0000:00:08.1: [1022:15db] type 01 class 0x060400
> [    0.645003] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
> [    0.645220] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500
> [    0.645456] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100
> [    0.645694] pci 0000:00:18.0: [1022:15e8] type 00 class 0x060000
> [    0.645805] pci 0000:00:18.1: [1022:15e9] type 00 class 0x060000
> [    0.645913] pci 0000:00:18.2: [1022:15ea] type 00 class 0x060000
> [    0.646024] pci 0000:00:18.3: [1022:15eb] type 00 class 0x060000
> [    0.646131] pci 0000:00:18.4: [1022:15ec] type 00 class 0x060000
> [    0.646262] pci 0000:00:18.5: [1022:15ed] type 00 class 0x060000
> [    0.646371] pci 0000:00:18.6: [1022:15ee] type 00 class 0x060000
> [    0.646480] pci 0000:00:18.7: [1022:15ef] type 00 class 0x060000
> [    0.646710] pci 0000:01:00.0: [10ec:8168] type 00 class 0x020000
> [    0.646738] pci 0000:01:00.0: reg 0x10: [io  0x3300-0x33ff]
> [    0.646773] pci 0000:01:00.0: reg 0x18: [mem 0xf0914000-0xf0914fff 64bit]
> [    0.646795] pci 0000:01:00.0: reg 0x20: [mem 0xf0900000-0xf0903fff 64bit]
> [    0.646937] pci 0000:01:00.0: supports D1 D2
> [    0.646940] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    0.647160] pci 0000:01:00.1: [10ec:816a] type 00 class 0x070002
> [    0.647185] pci 0000:01:00.1: reg 0x10: [io  0x3200-0x32ff]
> [    0.647219] pci 0000:01:00.1: reg 0x18: [mem 0xf0915000-0xf0915fff 64bit]
> [    0.647249] pci 0000:01:00.1: reg 0x20: [mem 0xf0904000-0xf0907fff 64bit]
> [    0.647381] pci 0000:01:00.1: supports D1 D2
> [    0.647383] pci 0000:01:00.1: PME# supported from D0 D1 D2 D3hot D3cold
> [    0.647559] pci 0000:01:00.2: [10ec:816b] type 00 class 0x070002
> [    0.647584] pci 0000:01:00.2: reg 0x10: [io  0x3100-0x31ff]
> [    0.647618] pci 0000:01:00.2: reg 0x18: [mem 0xf0916000-0xf0916fff 64bit]
> [    0.647639] pci 0000:01:00.2: reg 0x20: [mem 0xf0908000-0xf090bfff 64bit]
> [    0.647770] pci 0000:01:00.2: supports D1 D2
> [    0.647772] pci 0000:01:00.2: PME# supported from D0 D1 D2 D3hot D3cold
> [    0.647930] pci 0000:01:00.3: [10ec:816c] type 00 class 0x0c0701
> [    0.647952] pci 0000:01:00.3: reg 0x10: [io  0x3000-0x30ff]
> [    0.647978] pci 0000:01:00.3: reg 0x18: [mem 0xf0917000-0xf0917fff 64bit]
> [    0.647996] pci 0000:01:00.3: reg 0x20: [mem 0xf090c000-0xf090ffff 64bit]
> [    0.648124] pci 0000:01:00.3: supports D1 D2
> [    0.648126] pci 0000:01:00.3: PME# supported from D0 D1 D2 D3hot D3cold
> [    0.648295] pci 0000:01:00.4: [10ec:816d] type 00 class 0x0c0320
> [    0.648320] pci 0000:01:00.4: reg 0x10: [mem 0xf0918000-0xf0918fff]
> [    0.648353] pci 0000:01:00.4: reg 0x18: [mem 0xf0910000-0xf0913fff 64bit]
> [    0.648510] pci 0000:01:00.4: PME# supported from D0 D3cold
> [    0.648736] pci 0000:00:01.3: PCI bridge to [bus 01]
> [    0.648743] pci 0000:00:01.3:   bridge window [io  0x3000-0x3fff]
> [    0.648748] pci 0000:00:01.3:   bridge window [mem 0xf0900000-0xf09fffff]
> [    0.649027] pci 0000:02:00.0: [8086:2723] type 00 class 0x028000
> [    0.649092] pci 0000:02:00.0: reg 0x10: [mem 0xf0800000-0xf0803fff 64bit]
> [    0.649402] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
> [    0.650128] pci 0000:00:01.4: PCI bridge to [bus 02]
> [    0.650136] pci 0000:00:01.4:   bridge window [io  0x1000-0x1fff]
> [    0.650141] pci 0000:00:01.4:   bridge window [mem 0xf0800000-0xf08fffff]
> [    0.650148] pci 0000:00:01.4:   bridge window [mem 0xf0a00000-0xf0bfffff 64bit pref]
> [    0.650227] pci 0000:03:00.0: [1179:011a] type 00 class 0x010802
> [    0.650257] pci 0000:03:00.0: reg 0x10: [mem 0xf0700000-0xf0703fff 64bit]
> [    0.650468] pci 0000:03:00.0: 16.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x4 link at 0000:00:01.7 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
> [    0.650545] pci 0000:00:01.7: PCI bridge to [bus 03]
> [    0.650554] pci 0000:00:01.7:   bridge window [mem 0xf0700000-0xf07fffff]
> [    0.650743] pci 0000:04:00.0: [1002:15d8] type 00 class 0x030000
> [    0.650768] pci 0000:04:00.0: reg 0x10: [mem 0xe0000000-0xefffffff 64bit pref]
> [    0.650784] pci 0000:04:00.0: reg 0x18: [mem 0xf0000000-0xf01fffff 64bit pref]
> [    0.650795] pci 0000:04:00.0: reg 0x20: [io  0x2000-0x20ff]
> [    0.650807] pci 0000:04:00.0: reg 0x24: [mem 0xf0600000-0xf067ffff]
> [    0.650931] pci 0000:04:00.0: PME# supported from D1 D2 D3hot D3cold
> [    0.651138] pci 0000:04:00.1: [1002:15de] type 00 class 0x040300
> [    0.651158] pci 0000:04:00.1: reg 0x10: [mem 0xf06c8000-0xf06cbfff]
> [    0.651286] pci 0000:04:00.1: PME# supported from D1 D2 D3hot D3cold
> [    0.651399] pci 0000:04:00.2: [1022:15df] type 00 class 0x108000
> [    0.651435] pci 0000:04:00.2: reg 0x18: [mem 0xf0500000-0xf05fffff]
> [    0.651463] pci 0000:04:00.2: reg 0x24: [mem 0xf06ce000-0xf06cffff]
> [    0.651696] pci 0000:04:00.3: [1022:15e0] type 00 class 0x0c0330
> [    0.651721] pci 0000:04:00.3: reg 0x10: [mem 0xf0200000-0xf02fffff 64bit]
> [    0.651842] pci 0000:04:00.3: PME# supported from D0 D3hot D3cold
> [    0.651992] pci 0000:04:00.4: [1022:15e1] type 00 class 0x0c0330
> [    0.652017] pci 0000:04:00.4: reg 0x10: [mem 0xf0300000-0xf03fffff 64bit]
> [    0.652138] pci 0000:04:00.4: PME# supported from D0 D3hot D3cold
> [    0.652291] pci 0000:04:00.5: [1022:15e2] type 00 class 0x048000
> [    0.652311] pci 0000:04:00.5: reg 0x10: [mem 0xf0680000-0xf06bffff]
> [    0.652435] pci 0000:04:00.5: PME# supported from D0 D3hot D3cold
> [    0.652610] pci 0000:04:00.6: [1022:15e3] type 00 class 0x040300
> [    0.652629] pci 0000:04:00.6: reg 0x10: [mem 0xf06c0000-0xf06c7fff]
> [    0.652754] pci 0000:04:00.6: PME# supported from D0 D3hot D3cold
> [    0.652904] pci 0000:04:00.7: [1022:15e6] type 00 class 0x000000
> [    0.652940] pci 0000:04:00.7: reg 0x18: [mem 0xf0400000-0xf04fffff]
> [    0.652968] pci 0000:04:00.7: reg 0x24: [mem 0xf06cc000-0xf06cdfff]
> [    0.653220] pci 0000:00:08.1: PCI bridge to [bus 04]
> [    0.653227] pci 0000:00:08.1:   bridge window [io  0x2000-0x2fff]
> [    0.653232] pci 0000:00:08.1:   bridge window [mem 0xf0200000-0xf06fffff]
> [    0.653239] pci 0000:00:08.1:   bridge window [mem 0xe0000000-0xf01fffff 64bit pref]
> [    0.656262] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 5 6 10 11) *0, disabled.
> [    0.656532] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 5 6 10 11) *0, disabled.
> [    0.656749] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 5 6 10 11) *0, disabled.
> [    0.657010] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 5 6 10 11) *0, disabled.
> [    0.657259] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 5 6 10 11) *0, disabled.
> [    0.657453] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 5 6 10 11) *0, disabled.
> [    0.657659] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 5 6 10 11) *0, disabled.
> [    0.657852] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 5 6 10 11) *0, disabled.
> [    0.658248] ACPI: EC: interrupt unblocked
> [    0.658248] ACPI: EC: event unblocked
> [    0.658248] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
> [    0.658248] ACPI: EC: GPE=0x3
> [    0.658248] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC initialization complete
> [    0.658248] ACPI: \_SB_.PCI0.LPCB.EC0_: EC: Used to handle transactions and events
> [    0.658248] iommu: Default domain type: Translated 
> [    0.658628] SCSI subsystem initialized
> [    0.659296] libata version 3.00 loaded.
> [    0.659305] pci 0000:04:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
> [    0.659305] pci 0000:04:00.0: vgaarb: bridge control possible
> [    0.659305] pci 0000:04:00.0: vgaarb: setting as boot device (VGA legacy resources not available)
> [    0.659305] vgaarb: loaded
> [    0.659309] ACPI: bus type USB registered
> [    0.659338] usbcore: registered new interface driver usbfs
> [    0.659355] usbcore: registered new interface driver hub
> [    0.659406] usbcore: registered new device driver usb
> [    0.662658] i2c_designware AMDI0010:00: Unknown Synopsys component type: 0xffffffff
> [    0.663481] pps_core: LinuxPPS API ver. 1 registered
> [    0.663481] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> [    0.663481] PTP clock support registered
> [    0.663481] EDAC MC: Ver: 3.0.0
> [    0.664325] Registered efivars operations
> [    0.664460] NetLabel: Initializing
> [    0.664460] NetLabel:  domain hash size = 128
> [    0.664460] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
> [    0.664460] NetLabel:  unlabeled traffic allowed by default
> [    0.664460] PCI: Using ACPI for IRQ routing
> [    0.667331] PCI: pci_cache_line_size set to 64 bytes
> [    0.667522] e820: reserve RAM buffer [mem 0x09f00000-0x0bffffff]
> [    0.667526] e820: reserve RAM buffer [mem 0x33bdc000-0x33ffffff]
> [    0.667528] e820: reserve RAM buffer [mem 0x381cf000-0x3bffffff]
> [    0.667530] e820: reserve RAM buffer [mem 0x5e000000-0x5fffffff]
> [    0.667532] e820: reserve RAM buffer [mem 0x41f340000-0x41fffffff]
> [    0.668325] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
> [    0.668334] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
> [    0.670378] clocksource: Switched to clocksource tsc-early
> [    0.694771] VFS: Disk quotas dquot_6.6.0
> [    0.694814] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [    0.695002] pnp: PnP ACPI init
> [    0.695590] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
> [    0.695749] system 00:01: [io  0x0400-0x04cf] has been reserved
> [    0.695753] system 00:01: [io  0x04d0-0x04d1] has been reserved
> [    0.695756] system 00:01: [io  0x04d6] has been reserved
> [    0.695758] system 00:01: [io  0x0680-0x06ff] has been reserved
> [    0.695760] system 00:01: [io  0x077a] has been reserved
> [    0.695763] system 00:01: [io  0x0c00-0x0c01] has been reserved
> [    0.695765] system 00:01: [io  0x0c14] has been reserved
> [    0.695767] system 00:01: [io  0x0c50-0x0c52] has been reserved
> [    0.695770] system 00:01: [io  0x0c6c] has been reserved
> [    0.695772] system 00:01: [io  0x0c6f] has been reserved
> [    0.695774] system 00:01: [io  0x0cd0-0x0cdb] has been reserved
> [    0.695777] system 00:01: [io  0x0840-0x0847] has been reserved
> [    0.695786] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.695960] system 00:02: [mem 0x000e0000-0x000fffff] could not be reserved
> [    0.695968] system 00:02: Plug and Play ACPI device, IDs PNP0c01 (active)
> [    0.696011] pnp 00:03: Plug and Play ACPI device, IDs HPQ8002 PNP0303 (active)
> [    0.696049] pnp 00:04: Plug and Play ACPI device, IDs SYN308c SYN0100 SYN0002 PNP0f13 (active)
> [    0.696238] system 00:05: [io  0x0200-0x027f] has been reserved
> [    0.696243] system 00:05: [mem 0xfedf1000-0xfedf1fff] has been reserved
> [    0.696250] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.696520] system 00:06: [mem 0xfec00000-0xfec00fff] could not be reserved
> [    0.696523] system 00:06: [mem 0xfee00000-0xfee00fff] has been reserved
> [    0.696526] system 00:06: [mem 0xfec20000-0xfec20fff] has been reserved
> [    0.696533] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.697917] pnp: PnP ACPI: found 7 devices
> [    0.706125] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> [    0.706280] NET: Registered protocol family 2
> [    0.706803] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes, linear)
> [    0.707030] TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
> [    0.707550] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
> [    0.707816] TCP: Hash tables configured (established 131072 bind 65536)
> [    0.708009] MPTCP token hash table entries: 16384 (order: 6, 393216 bytes, linear)
> [    0.708130] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
> [    0.708234] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, linear)
> [    0.708514] NET: Registered protocol family 1
> [    0.708525] NET: Registered protocol family 44
> [    0.708560] pci 0000:00:01.3: PCI bridge to [bus 01]
> [    0.708568] pci 0000:00:01.3:   bridge window [io  0x3000-0x3fff]
> [    0.708578] pci 0000:00:01.3:   bridge window [mem 0xf0900000-0xf09fffff]
> [    0.708589] pci 0000:00:01.4: PCI bridge to [bus 02]
> [    0.708593] pci 0000:00:01.4:   bridge window [io  0x1000-0x1fff]
> [    0.708598] pci 0000:00:01.4:   bridge window [mem 0xf0800000-0xf08fffff]
> [    0.708603] pci 0000:00:01.4:   bridge window [mem 0xf0a00000-0xf0bfffff 64bit pref]
> [    0.708611] pci 0000:00:01.7: PCI bridge to [bus 03]
> [    0.708622] pci 0000:00:01.7:   bridge window [mem 0xf0700000-0xf07fffff]
> [    0.708637] pci 0000:00:08.1: PCI bridge to [bus 04]
> [    0.708644] pci 0000:00:08.1:   bridge window [io  0x2000-0x2fff]
> [    0.708650] pci 0000:00:08.1:   bridge window [mem 0xf0200000-0xf06fffff]
> [    0.708654] pci 0000:00:08.1:   bridge window [mem 0xe0000000-0xf01fffff 64bit pref]
> [    0.708665] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> [    0.708667] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
> [    0.708670] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
> [    0.708672] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff window]
> [    0.708675] pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff window]
> [    0.708677] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff window]
> [    0.708679] pci_bus 0000:00: resource 10 [mem 0x000cc000-0x000cffff window]
> [    0.708682] pci_bus 0000:00: resource 11 [mem 0x000d0000-0x000d3fff window]
> [    0.708684] pci_bus 0000:00: resource 12 [mem 0x000d4000-0x000d7fff window]
> [    0.708686] pci_bus 0000:00: resource 13 [mem 0x000d8000-0x000dbfff window]
> [    0.708688] pci_bus 0000:00: resource 14 [mem 0x000dc000-0x000dffff window]
> [    0.708691] pci_bus 0000:00: resource 15 [mem 0x000e0000-0x000e3fff window]
> [    0.708693] pci_bus 0000:00: resource 16 [mem 0x000e4000-0x000e7fff window]
> [    0.708695] pci_bus 0000:00: resource 17 [mem 0x000e8000-0x000ebfff window]
> [    0.708697] pci_bus 0000:00: resource 18 [mem 0x000ec000-0x000effff window]
> [    0.708699] pci_bus 0000:00: resource 19 [mem 0xe0000000-0xf7ffffff window]
> [    0.708702] pci_bus 0000:00: resource 20 [mem 0xfc000000-0xfeafffff window]
> [    0.708705] pci_bus 0000:01: resource 0 [io  0x3000-0x3fff]
> [    0.708707] pci_bus 0000:01: resource 1 [mem 0xf0900000-0xf09fffff]
> [    0.708709] pci_bus 0000:02: resource 0 [io  0x1000-0x1fff]
> [    0.708711] pci_bus 0000:02: resource 1 [mem 0xf0800000-0xf08fffff]
> [    0.708713] pci_bus 0000:02: resource 2 [mem 0xf0a00000-0xf0bfffff 64bit pref]
> [    0.708716] pci_bus 0000:03: resource 1 [mem 0xf0700000-0xf07fffff]
> [    0.708718] pci_bus 0000:04: resource 0 [io  0x2000-0x2fff]
> [    0.708720] pci_bus 0000:04: resource 1 [mem 0xf0200000-0xf06fffff]
> [    0.708722] pci_bus 0000:04: resource 2 [mem 0xe0000000-0xf01fffff 64bit pref]
> [    0.709421] pci 0000:04:00.1: D0 power state depends on 0000:04:00.0
> [    0.709494] pci 0000:04:00.3: extending delay after power-on from D3hot to 20 msec
> [    0.709858] pci 0000:04:00.4: extending delay after power-on from D3hot to 20 msec
> [    0.710070] PCI: CLS 64 bytes, default 64
> [    0.710170] Trying to unpack rootfs image as initramfs...
> [    1.841419] Freeing initrd memory: 38236K
> [    1.841472] pci 0000:00:00.2: AMD-Vi: Unable to read/write to IOMMU perf counter.
> [    1.841744] pci 0000:00:00.2: can't derive routing for PCI INT A
> [    1.841747] pci 0000:00:00.2: PCI INT A: not connected
> [    1.841844] pci 0000:00:01.0: Adding to iommu group 0
> [    1.841867] pci 0000:00:01.3: Adding to iommu group 1
> [    1.841888] pci 0000:00:01.4: Adding to iommu group 2
> [    1.841908] pci 0000:00:01.7: Adding to iommu group 3
> [    1.841944] pci 0000:00:08.0: Adding to iommu group 4
> [    1.841965] pci 0000:00:08.1: Adding to iommu group 5
> [    1.842005] pci 0000:00:14.0: Adding to iommu group 6
> [    1.842024] pci 0000:00:14.3: Adding to iommu group 6
> [    1.842106] pci 0000:00:18.0: Adding to iommu group 7
> [    1.842127] pci 0000:00:18.1: Adding to iommu group 7
> [    1.842146] pci 0000:00:18.2: Adding to iommu group 7
> [    1.842164] pci 0000:00:18.3: Adding to iommu group 7
> [    1.842182] pci 0000:00:18.4: Adding to iommu group 7
> [    1.842206] pci 0000:00:18.5: Adding to iommu group 7
> [    1.842224] pci 0000:00:18.6: Adding to iommu group 7
> [    1.842243] pci 0000:00:18.7: Adding to iommu group 7
> [    1.842316] pci 0000:01:00.0: Adding to iommu group 8
> [    1.842339] pci 0000:01:00.1: Adding to iommu group 8
> [    1.842361] pci 0000:01:00.2: Adding to iommu group 8
> [    1.842383] pci 0000:01:00.3: Adding to iommu group 8
> [    1.842405] pci 0000:01:00.4: Adding to iommu group 8
> [    1.842426] pci 0000:02:00.0: Adding to iommu group 9
> [    1.842459] pci 0000:03:00.0: Adding to iommu group 10
> [    1.842499] pci 0000:04:00.0: Adding to iommu group 11
> [    1.842577] pci 0000:04:00.1: Adding to iommu group 12
> [    1.842605] pci 0000:04:00.2: Adding to iommu group 12
> [    1.842629] pci 0000:04:00.3: Adding to iommu group 12
> [    1.842655] pci 0000:04:00.4: Adding to iommu group 12
> [    1.842681] pci 0000:04:00.5: Adding to iommu group 12
> [    1.842705] pci 0000:04:00.6: Adding to iommu group 12
> [    1.842729] pci 0000:04:00.7: Adding to iommu group 12
> [    1.846336] pci 0000:00:00.2: AMD-Vi: Found IOMMU cap 0x40
> [    1.846341] pci 0000:00:00.2: AMD-Vi: Extended features (0x4f77ef22294ada):
> [    1.846343]  PPR NX GT IA GA PC GA_vAPIC
> [    1.846350] AMD-Vi: Interrupt remapping enabled
> [    1.846351] AMD-Vi: Virtual APIC enabled
> [    1.846728] AMD-Vi: Lazy IO/TLB flushing enabled
> [    1.848737] amd_uncore: 4  amd_df counters detected
> [    1.848744] amd_uncore: 6  amd_l3 counters detected
> [    1.852105] check: Scanning for low memory corruption every 60 seconds
> [    1.852941] Initialise system trusted keyrings
> [    1.853017] Key type blacklist registered
> [    1.853209] workingset: timestamp_bits=41 max_order=22 bucket_order=0
> [    1.855356] zbud: loaded
> [    1.878218] Key type asymmetric registered
> [    1.878222] Asymmetric key parser 'x509' registered
> [    1.878257] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
> [    1.878519] io scheduler mq-deadline registered
> [    1.878522] io scheduler kyber registered
> [    1.878571] io scheduler bfq registered
> [    1.878951] atomic64_test: passed for x86-64 platform with CX8 and with SSE
> [    1.879298] pcieport 0000:00:01.3: PME: Signaling with IRQ 26
> [    1.879485] pcieport 0000:00:01.3: AER: enabled with IRQ 26
> [    1.879755] pcieport 0000:00:01.4: PME: Signaling with IRQ 27
> [    1.879948] pcieport 0000:00:01.4: AER: enabled with IRQ 27
> [    1.880009] pcieport 0000:00:01.4: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
> [    1.880457] pcieport 0000:00:01.7: PME: Signaling with IRQ 28
> [    1.880659] pcieport 0000:00:01.7: AER: enabled with IRQ 28
> [    1.880910] pcieport 0000:00:08.1: PME: Signaling with IRQ 29
> [    1.881098] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> [    1.882942] ACPI: AC Adapter [AC] (off-line)
> [    1.883021] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
> [    1.883058] ACPI: Power Button [PWRB]
> [    1.883112] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input1
> [    1.883138] ACPI: Sleep Button [SLPB]
> [    1.883197] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input2
> [    1.883221] ACPI: Lid Switch [LID]
> [    1.883276] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
> [    1.884454] ACPI: Power Button [PWRF]
> [    1.884612] Monitor-Mwait will be used to enter C-1 state
> [    1.884635] ACPI: \_PR_.C000: Found 2 idle states
> [    1.885070] ACPI: \_PR_.C001: Found 2 idle states
> [    1.885304] ACPI: \_PR_.C002: Found 2 idle states
> [    1.885456] ACPI: \_PR_.C003: Found 2 idle states
> [    1.885648] ACPI: \_PR_.C004: Found 2 idle states
> [    1.885966] ACPI: \_PR_.C005: Found 2 idle states
> [    1.886189] ACPI: \_PR_.C006: Found 2 idle states
> [    1.886407] ACPI: \_PR_.C007: Found 2 idle states
> [    1.886884] thermal LNXTHERM:00: registered as thermal_zone0
> [    1.886887] ACPI: Thermal Zone [HEPZ] (30 C)
> [    1.892041] thermal LNXTHERM:01: registered as thermal_zone1
> [    1.892045] ACPI: Thermal Zone [CPUZ] (44 C)
> [    1.897873] thermal LNXTHERM:02: registered as thermal_zone2
> [    1.897876] ACPI: Thermal Zone [GFXZ] (0 C)
> [    1.900914] thermal LNXTHERM:03: registered as thermal_zone3
> [    1.900917] ACPI: Thermal Zone [EXTZ] (38 C)
> [    1.903577] thermal LNXTHERM:04: registered as thermal_zone4
> [    1.903580] ACPI: Thermal Zone [LOCZ] (39 C)
> [    1.909416] thermal LNXTHERM:05: registered as thermal_zone5
> [    1.909420] ACPI: Thermal Zone [BATZ] (31 C)
> [    1.909495] ACPI BIOS Error (bug): AE_AML_PACKAGE_LIMIT, Index (0x000000005) is beyond end of object (length 0x5) (20200925/exoparg2-393)
> [    1.909514] ACPI Error: Aborting method \_TZ.GETP due to previous error (AE_AML_PACKAGE_LIMIT) (20200925/psparse-529)
> [    1.909525] ACPI Error: Aborting method \_TZ.CHGZ._CRT due to previous error (AE_AML_PACKAGE_LIMIT) (20200925/psparse-529)
> [    1.910242] ACPI BIOS Error (bug): AE_AML_PACKAGE_LIMIT, Index (0x000000005) is beyond end of object (length 0x5) (20200925/exoparg2-393)
> [    1.910262] ACPI Error: Aborting method \_TZ.GTTP due to previous error (AE_AML_PACKAGE_LIMIT) (20200925/psparse-529)
> [    1.910273] ACPI Error: Aborting method \_TZ.CHGZ._TMP due to previous error (AE_AML_PACKAGE_LIMIT) (20200925/psparse-529)
> [    1.910333] ACPI BIOS Error (bug): AE_AML_PACKAGE_LIMIT, Index (0x000000005) is beyond end of object (length 0x5) (20200925/exoparg2-393)
> [    1.910348] ACPI Error: Aborting method \_TZ.GETP due to previous error (AE_AML_PACKAGE_LIMIT) (20200925/psparse-529)
> [    1.910356] ACPI Error: Aborting method \_TZ.CHGZ._CRT due to previous error (AE_AML_PACKAGE_LIMIT) (20200925/psparse-529)
> [    1.910373] [Firmware Bug]: No valid trip found
> [    1.910858] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
> [    1.914392] 0000:01:00.1: ttyS4 at I/O 0x3200 (irq = 30, base_baud = 115200) is a 16550A
> [    1.914983] 0000:01:00.2: ttyS5 at I/O 0x3100 (irq = 31, base_baud = 115200) is a 16550A
> [    1.915497] Non-volatile memory driver v1.3
> [    1.915500] AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
> [    1.917415] nvme nvme0: pci function 0000:03:00.0
> [    1.917541] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    1.917551] ehci-pci: EHCI PCI platform driver
> [    1.918051] ehci-pci 0000:01:00.4: EHCI Host Controller
> [    1.918063] ehci-pci 0000:01:00.4: new USB bus registered, assigned bus number 1
> [    1.918195] ehci-pci 0000:01:00.4: irq 35, io mem 0xf0918000
> [    1.921953] battery: ACPI: Battery Slot [BAT0] (battery present)
> [    1.924370] ehci-pci 0000:01:00.4: USB 0.0 started, EHCI 1.00
> [    1.924457] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.10
> [    1.924460] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    1.924464] usb usb1: Product: EHCI Host Controller
> [    1.924466] usb usb1: Manufacturer: Linux 5.10.5-zen1-1-zen ehci_hcd
> [    1.924468] usb usb1: SerialNumber: 0000:01:00.4
> [    1.924719] hub 1-0:1.0: USB hub found
> [    1.924738] hub 1-0:1.0: 1 port detected
> [    1.924926] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [    1.924933] ohci-pci: OHCI PCI platform driver
> [    1.924951] uhci_hcd: USB Universal Host Controller Interface driver
> [    1.925017] usbcore: registered new interface driver usbserial_generic
> [    1.925025] usbserial: USB Serial support registered for generic
> [    1.925079] i8042: PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
> [    1.926280] i8042: Detected active multiplexing controller, rev 1.1
> [    1.926442] serio: i8042 KBD port at 0x60,0x64 irq 1
> [    1.926495] serio: i8042 AUX0 port at 0x60,0x64 irq 12
> [    1.926526] serio: i8042 AUX1 port at 0x60,0x64 irq 12
> [    1.926553] serio: i8042 AUX2 port at 0x60,0x64 irq 12
> [    1.926581] serio: i8042 AUX3 port at 0x60,0x64 irq 12
> [    1.927313] rtc_cmos 00:00: RTC can wake from S4
> [    1.927702] rtc_cmos 00:00: registered as rtc0
> [    1.927769] rtc_cmos 00:00: setting system clock to 2021-01-11T07:59:29 UTC (1610351969)
> [    1.927798] rtc_cmos 00:00: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
> [    1.928029] ledtrig-cpu: registered to indicate activity on CPUs
> [    1.952870] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input4
> [    1.973770] random: fast init done
> [    1.979772] nvme nvme0: 16/0/0 default/read/poll queues
> [    1.985861] pstore: Registered efi as persistent store backend
> [    1.985903] hid: raw HID events driver (C) Jiri Kosina
> [    1.986299] drop_monitor: Initializing network drop monitor service
> [    1.986419] Initializing XFRM netlink socket
> [    1.986614] NET: Registered protocol family 10
> [    1.990866]  nvme0n1: p1 p2 p3 p4 p5 p6
> [    1.994891] Segment Routing with IPv6
> [    1.994895] RPL Segment Routing with IPv6
> [    1.994961] NET: Registered protocol family 17
> [    1.996089] microcode: CPU0: patch_level=0x08108109
> [    1.996103] microcode: CPU1: patch_level=0x08108109
> [    1.996136] microcode: CPU2: patch_level=0x08108109
> [    1.996149] microcode: CPU3: patch_level=0x08108109
> [    1.996158] microcode: CPU4: patch_level=0x08108109
> [    1.996173] microcode: CPU5: patch_level=0x08108109
> [    1.996180] microcode: CPU6: patch_level=0x08108109
> [    1.996195] microcode: CPU7: patch_level=0x08108109
> [    1.996202] microcode: Microcode Update Driver: v2.2.
> [    1.996217] IPI shorthand broadcast: enabled
> [    1.996245] sched_clock: Marking stable (1802744615, 193208552)->(2003329321, -7376154)
> [    1.996451] registered taskstats version 1
> [    1.996471] Loading compiled-in X.509 certificates
> [    2.001807] Loaded X.509 cert 'Build time autogenerated kernel key: a4ba5de36a3939e2a028724bc173b6cf0c4adb93'
> [    2.002168] zswap: loaded using pool lz4/z3fold
> [    2.002558] Key type ._fscrypt registered
> [    2.002561] Key type .fscrypt registered
> [    2.002563] Key type fscrypt-provisioning registered
> [    2.003075] pstore: Using crash dump compression: zstd
> [    2.004056] PM:   Magic number: 5:976:975
> [    2.004176] platform PNP0C0E:00: hash matches
> [    2.004213] button PNP0C0E:00: hash matches
> [    2.004513] RAS: Correctable Errors collector initialized.
> [    2.007653] Freeing unused decrypted memory: 2036K
> [    2.008275] Freeing unused kernel image (initmem) memory: 1720K
> [    2.020639] Write protecting the kernel read-only data: 28672k
> [    2.021506] Freeing unused kernel image (text/rodata gap) memory: 2036K
> [    2.021993] Freeing unused kernel image (rodata/data gap) memory: 1516K
> [    2.073534] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> [    2.073542] rodata_test: all tests were successful
> [    2.073551] CFS CPU scheduler.
> [    2.073552] Run /init as init process
> [    2.073554]   with arguments:
> [    2.073556]     /init
> [    2.073556]   with environment:
> [    2.073557]     HOME=/
> [    2.073558]     TERM=linux
> [    2.192183] random: crng init done
> [    2.192204] systemd[1]: Successfully credited entropy passed from boot loader.
> [    2.193812] systemd[1]: systemd 247.2-1-arch running in system mode. (+PAM +AUDIT -SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
> [    2.205477] systemd[1]: Detected architecture x86-64.
> [    2.205484] systemd[1]: Running in initial RAM disk.
> [    2.221597] systemd[1]: Set hostname to <hp-laptop>.
> [    2.354397] systemd[1]: Queued start job for default target Initrd Default Target.
> [    2.366974] systemd[1]: Created slice system-systemd\x2dcryptsetup.slice.
> [    2.367617] systemd[1]: Created slice system-systemd\x2dfsck.slice.
> [    2.367741] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
> [    2.367851] systemd[1]: Reached target Local File Systems.
> [    2.367897] systemd[1]: Reached target Paths.
> [    2.367955] systemd[1]: Reached target Slices.
> [    2.368035] systemd[1]: Reached target Swap.
> [    2.368077] systemd[1]: Reached target Timers.
> [    2.368331] systemd[1]: Listening on Journal Audit Socket.
> [    2.368494] systemd[1]: Listening on Journal Socket (/dev/log).
> [    2.368684] systemd[1]: Listening on Journal Socket.
> [    2.368860] systemd[1]: Listening on udev Control Socket.
> [    2.369022] systemd[1]: Listening on udev Kernel Socket.
> [    2.369069] systemd[1]: Reached target Sockets.
> [    2.370541] systemd[1]: Starting Create list of static device nodes for the current kernel...
> [    2.373132] systemd[1]: Starting Journal Service...
> [    2.374780] systemd[1]: Starting Load Kernel Modules...
> [    2.376490] systemd[1]: Starting Setup Virtual Console...
> [    2.377815] systemd[1]: Finished Create list of static device nodes for the current kernel.
> [    2.379613] systemd[1]: Starting Create Static Device Nodes in /dev...
> [    2.388095] ashmem_linux: module is from the staging directory, the quality is unknown, you have been warned.
> [    2.388974] ashmem: initialized
> [    2.392367] systemd[1]: Finished Create Static Device Nodes in /dev.
> [    2.396388] systemd[1]: Finished Setup Virtual Console.
> [    2.398063] systemd[1]: Starting dracut ask for additional cmdline parameters...
> [    2.420766] systemd[1]: Finished Load Kernel Modules.
> [    2.420876] audit: type=1130 audit(1610351969.991:2): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-modules-load comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    2.422662] systemd[1]: Starting Apply Kernel Variables...
> [    2.428798] systemd[1]: Finished dracut ask for additional cmdline parameters.
> [    2.428909] audit: type=1130 audit(1610351969.999:3): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dracut-cmdline-ask comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    2.430819] systemd[1]: Starting dracut cmdline hook...
> [    2.433881] systemd[1]: Finished Apply Kernel Variables.
> [    2.433999] audit: type=1130 audit(1610351970.004:4): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-sysctl comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    2.448453] systemd[1]: Started Journal Service.
> [    2.448620] audit: type=1130 audit(1610351970.019:5): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    2.459225] audit: type=1130 audit(1610351970.029:6): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-tmpfiles-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    2.597778] audit: type=1130 audit(1610351970.168:7): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dracut-cmdline comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    2.634870] device-mapper: uevent: version 1.0.3
> [    2.635063] device-mapper: ioctl: 4.43.0-ioctl (2020-10-01) initialised: dm-devel@redhat.com
> [    2.681216] Linux agpgart interface v0.103
> [    2.876272] tsc: Refined TSC clocksource calibration: 2295.677 MHz
> [    2.876290] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2117416719f, max_idle_ns: 440795272949 ns
> [    2.876552] clocksource: Switched to clocksource tsc
> [    2.879151] input: PS/2 Generic Mouse as /devices/platform/i8042/serio2/input/input10
> [    3.474358] [drm] amdgpu kernel modesetting enabled.
> [    3.474587] amdgpu: Topology: Add APU node [0x0:0x0]
> [    3.474733] amdgpu 0000:04:00.0: vgaarb: deactivate vga console
> [    3.475061] [drm] initializing kernel modesetting (RAVEN 0x1002:0x15D8 0x103C:0x8589 0xD1).
> [    3.475066] amdgpu 0000:04:00.0: amdgpu: Trusted Memory Zone (TMZ) feature disabled as experimental (default)
> [    3.476091] [drm] register mmio base: 0xF0600000
> [    3.476093] [drm] register mmio size: 524288
> [    3.476117] [drm] add ip block number 0 <soc15_common>
> [    3.476119] [drm] add ip block number 1 <gmc_v9_0>
> [    3.476121] [drm] add ip block number 2 <vega10_ih>
> [    3.476123] [drm] add ip block number 3 <psp>
> [    3.476125] [drm] add ip block number 4 <gfx_v9_0>
> [    3.476127] [drm] add ip block number 5 <sdma_v4_0>
> [    3.476128] [drm] add ip block number 6 <powerplay>
> [    3.476130] [drm] add ip block number 7 <dm>
> [    3.476132] [drm] add ip block number 8 <vcn_v1_0>
> [    3.476232] amdgpu 0000:04:00.0: amdgpu: Fetched VBIOS from VFCT
> [    3.476236] amdgpu: ATOM BIOS: SWBRT48929.001
> [    3.476320] [drm] VCN decode is enabled in VM mode
> [    3.476322] [drm] VCN encode is enabled in VM mode
> [    3.476323] [drm] JPEG decode is enabled in VM mode
> [    3.476380] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
> [    3.476397] amdgpu 0000:04:00.0: amdgpu: VRAM: 2048M 0x000000F400000000 - 0x000000F47FFFFFFF (2048M used)
> [    3.476399] amdgpu 0000:04:00.0: amdgpu: GART: 1024M 0x0000000000000000 - 0x000000003FFFFFFF
> [    3.476402] amdgpu 0000:04:00.0: amdgpu: AGP: 267419648M 0x000000F800000000 - 0x0000FFFFFFFFFFFF
> [    3.476412] [drm] Detected VRAM RAM=2048M, BAR=2048M
> [    3.476414] [drm] RAM width 64bits DDR4
> [    3.476582] [TTM] Zone  kernel: Available graphics memory: 7160050 KiB
> [    3.476583] [TTM] Zone   dma32: Available graphics memory: 2097152 KiB
> [    3.476586] [TTM] Initializing pool allocator
> [    3.476593] [TTM] Initializing DMA pool allocator
> [    3.476736] [drm] amdgpu: 2048M of VRAM memory ready
> [    3.476742] [drm] amdgpu: 3072M of GTT memory ready.
> [    3.476746] [drm] GART: num cpu pages 262144, num gpu pages 262144
> [    3.477045] [drm] PCIE GART of 1024M enabled (table at 0x000000F400900000).
> [    3.480587] amdgpu: hwmgr_sw_init smu backed is smu10_smu
> [    3.480888] [drm] Found VCN firmware Version ENC: 1.12 DEC: 2 VEP: 0 Revision: 1
> [    3.480893] [drm] PSP loading VCN firmware
> [    3.503227] [drm] reserve 0x400000 from 0xf47fc00000 for PSP TMR
> [    3.595449] amdgpu 0000:04:00.0: amdgpu: RAS: optional ras ta ucode is not available
> [    3.610646] amdgpu 0000:04:00.0: amdgpu: RAP: optional rap ta ucode is not available
> [    3.612821] [drm] kiq ring mec 2 pipe 1 q 0
> [    3.614376] [drm] DM_PPLIB: values for F clock
> [    3.614378] [drm] DM_PPLIB:	 400000 in kHz, 2749 in mV
> [    3.614379] [drm] DM_PPLIB:	 933000 in kHz, 3224 in mV
> [    3.614380] [drm] DM_PPLIB:	 1067000 in kHz, 3924 in mV
> [    3.614381] [drm] DM_PPLIB:	 1200000 in kHz, 4074 in mV
> [    3.614383] [drm] DM_PPLIB: values for DCF clock
> [    3.614384] [drm] DM_PPLIB:	 300000 in kHz, 2749 in mV
> [    3.614385] [drm] DM_PPLIB:	 600000 in kHz, 3224 in mV
> [    3.614386] [drm] DM_PPLIB:	 626000 in kHz, 3924 in mV
> [    3.614387] [drm] DM_PPLIB:	 654000 in kHz, 4074 in mV
> [    3.641547] psmouse serio3: synaptics: queried max coordinates: x [..5676], y [..4762]
> [    3.673444] psmouse serio3: synaptics: queried min coordinates: x [1262..], y [1124..]
> [    3.673462] psmouse serio3: synaptics: Your touchpad (PNP: SYN308c SYN0100 SYN0002 PNP0f13) says it can support a different bus. If i2c-hid and hid-rmi are not used, you might want to try setting psmouse.synaptics_intertouch to 1 and report this to linux-input@vger.kernel.org.
> [    3.733183] psmouse serio3: synaptics: Touchpad model: 1, fw: 10.16, id: 0x1e2a1, caps: 0xf00123/0x840300/0x12e800/0x500000, board id: 3447, fw id: 2885702
> [    3.775387] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio3/input/input11
> [    4.164803] [drm] Display Core initialized with v3.2.104!
> [    4.225599] [drm] VCN decode and encode initialized successfully(under SPG Mode).
> [    4.228650] kfd kfd: Allocated 3969056 bytes on gart
> [    4.230480] amdgpu: Topology: Add APU node [0x15d8:0x1002]
> [    4.230484] kfd kfd: added device 1002:15d8
> [    4.230489] amdgpu 0000:04:00.0: amdgpu: SE 1, SH per SE 1, CU per SH 11, active_cu_number 10
> [    4.232241] [drm] fb mappable at 0x60BCA000
> [    4.232243] [drm] vram apper at 0x60000000
> [    4.232245] [drm] size 8294400
> [    4.232260] [drm] fb depth is 24
> [    4.232261] [drm]    pitch is 7680
> [    4.232402] fbcon: amdgpudrmfb (fb0) is primary device
> [    4.232405] fbcon: Deferring console take-over
> [    4.232409] amdgpu 0000:04:00.0: [drm] fb0: amdgpudrmfb frame buffer device
> [    4.240489] amdgpu 0000:04:00.0: amdgpu: ring gfx uses VM inv eng 0 on hub 0
> [    4.240495] amdgpu 0000:04:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
> [    4.240498] amdgpu 0000:04:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
> [    4.240500] amdgpu 0000:04:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 5 on hub 0
> [    4.240502] amdgpu 0000:04:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 6 on hub 0
> [    4.240505] amdgpu 0000:04:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 7 on hub 0
> [    4.240507] amdgpu 0000:04:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 8 on hub 0
> [    4.240509] amdgpu 0000:04:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 9 on hub 0
> [    4.240511] amdgpu 0000:04:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 10 on hub 0
> [    4.240514] amdgpu 0000:04:00.0: amdgpu: ring kiq_2.1.0 uses VM inv eng 11 on hub 0
> [    4.240516] amdgpu 0000:04:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on hub 1
> [    4.240519] amdgpu 0000:04:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 on hub 1
> [    4.240521] amdgpu 0000:04:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4 on hub 1
> [    4.240523] amdgpu 0000:04:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5 on hub 1
> [    4.240526] amdgpu 0000:04:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6 on hub 1
> [    4.262480] [drm] Initialized amdgpu 3.40.0 20150101 for 0000:04:00.0 on minor 0
> [    4.281306] audit: type=1130 audit(1610351971.852:8): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dracut-pre-udev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    4.282905] audit: type=1334 audit(1610351971.853:9): prog-id=5 op=LOAD
> [    4.283036] audit: type=1334 audit(1610351971.853:10): prog-id=6 op=LOAD
> [    4.479953] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
> [    4.481444] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:09/LNXVIDEO:00/input/input13
> [    4.507552] acpi PNP0C14:01: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
> [    4.549311] xhci_hcd 0000:04:00.3: xHCI Host Controller
> [    4.549334] xhci_hcd 0000:04:00.3: new USB bus registered, assigned bus number 2
> [    4.549565] xhci_hcd 0000:04:00.3: hcc params 0x0270ffe5 hci version 0x110 quirks 0x0000000840000410
> [    4.550680] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.10
> [    4.550687] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    4.550691] usb usb2: Product: xHCI Host Controller
> [    4.550694] usb usb2: Manufacturer: Linux 5.10.5-zen1-1-zen xhci-hcd
> [    4.550697] usb usb2: SerialNumber: 0000:04:00.3
> [    4.552103] r8169 0000:01:00.0: can't disable ASPM; OS doesn't have ASPM control
> [    4.554027] hub 2-0:1.0: USB hub found
> [    4.554062] hub 2-0:1.0: 4 ports detected
> [    4.556295] xhci_hcd 0000:04:00.3: xHCI Host Controller
> [    4.556308] xhci_hcd 0000:04:00.3: new USB bus registered, assigned bus number 3
> [    4.556318] xhci_hcd 0000:04:00.3: Host supports USB 3.1 Enhanced SuperSpeed
> [    4.556376] usb usb3: We don't know the algorithms for LPM for this host, disabling LPM.
> [    4.556438] usb usb3: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.10
> [    4.556442] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    4.556446] usb usb3: Product: xHCI Host Controller
> [    4.556449] usb usb3: Manufacturer: Linux 5.10.5-zen1-1-zen xhci-hcd
> [    4.556452] usb usb3: SerialNumber: 0000:04:00.3
> [    4.556799] hub 3-0:1.0: USB hub found
> [    4.556827] hub 3-0:1.0: 4 ports detected
> [    4.563315] xhci_hcd 0000:04:00.4: xHCI Host Controller
> [    4.563332] xhci_hcd 0000:04:00.4: new USB bus registered, assigned bus number 4
> [    4.563546] xhci_hcd 0000:04:00.4: hcc params 0x0260ffe5 hci version 0x110 quirks 0x0000000840000410
> [    4.563847] libphy: r8169: probed
> [    4.564195] r8169 0000:01:00.0 eth0: RTL8168ep/8111ep, b0:5c:da:ac:bb:8c, XID 502, IRQ 64
> [    4.564198] r8169 0000:01:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksumming: ko]
> [    4.564632] usb usb4: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.10
> [    4.564638] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    4.564642] usb usb4: Product: xHCI Host Controller
> [    4.564645] usb usb4: Manufacturer: Linux 5.10.5-zen1-1-zen xhci-hcd
> [    4.564649] usb usb4: SerialNumber: 0000:04:00.4
> [    4.572560] ccp 0000:04:00.2: ccp enabled
> [    4.572579] ccp 0000:04:00.2: psp: unable to access the device: you might be running a broken BIOS.
> [    4.573411] hub 4-0:1.0: USB hub found
> [    4.578935] hub 4-0:1.0: 2 ports detected
> [    4.581102] xhci_hcd 0000:04:00.4: xHCI Host Controller
> [    4.581115] xhci_hcd 0000:04:00.4: new USB bus registered, assigned bus number 5
> [    4.581124] xhci_hcd 0000:04:00.4: Host supports USB 3.1 Enhanced SuperSpeed
> [    4.582368] usb usb5: We don't know the algorithms for LPM for this host, disabling LPM.
> [    4.582446] usb usb5: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.10
> [    4.582451] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    4.582455] usb usb5: Product: xHCI Host Controller
> [    4.582459] usb usb5: Manufacturer: Linux 5.10.5-zen1-1-zen xhci-hcd
> [    4.582462] usb usb5: SerialNumber: 0000:04:00.4
> [    4.582797] hub 5-0:1.0: USB hub found
> [    4.582820] hub 5-0:1.0: 1 port detected
> [    4.584337] cryptd: max_cpu_qlen set to 1000
> [    4.621484] AVX2 version of gcm_enc/dec engaged.
> [    4.621489] AES CTR mode by8 optimization enabled
> [    4.686273] r8169 0000:01:00.0 enp1s0f0: renamed from eth0
> [    4.720528] fbcon: Taking over console
> [    4.902286] usb 4-1: new high-speed USB device number 2 using xhci_hcd
> [    4.940295] Console: switching to colour frame buffer device 240x67
> [    5.030269] usb 4-1: New USB device found, idVendor=05e3, idProduct=0610, bcdDevice=60.60
> [    5.030273] usb 4-1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
> [    5.030276] usb 4-1: Product: USB2.0 Hub
> [    5.094172] hub 4-1:1.0: USB hub found
> [    5.094635] hub 4-1:1.0: 4 ports detected
> [    5.276663] usb 4-2: new high-speed USB device number 3 using xhci_hcd
> [    5.482080] usb 4-2: New USB device found, idVendor=04ca, idProduct=7089, bcdDevice= 0.08
> [    5.482087] usb 4-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [    5.482090] usb 4-2: Product: HP HD Camera
> [    5.482093] usb 4-2: Manufacturer: DJFYKA1BIDL3W7
> [    5.482095] usb 4-2: SerialNumber: 01.00.00
> [    5.483278] usb 4-1.2: new full-speed USB device number 4 using xhci_hcd
> [    5.613342] usb 4-1.2: New USB device found, idVendor=8087, idProduct=0029, bcdDevice= 0.01
> [    5.613347] usb 4-1.2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [    5.737331] usb 4-1.3: new full-speed USB device number 5 using xhci_hcd
> [    5.833340] usb 4-1.3: New USB device found, idVendor=06cb, idProduct=00b7, bcdDevice= 1.64
> [    5.833346] usb 4-1.3: New USB device strings: Mfr=0, Product=0, SerialNumber=1
> [    5.833349] usb 4-1.3: SerialNumber: 35df848cb768
> [    7.292418] amdgpu 0000:04:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB test failed on gfx (-110).
> [    7.292432] [drm:process_one_work] *ERROR* ib ring test failed (-110).
> [   13.403159] Key type encrypted registered
> [   13.442192] kauditd_printk_skb: 11 callbacks suppressed
> [   13.442195] audit: type=1130 audit(1610351981.012:22): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-cryptsetup@root comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   13.784201] audit: type=1130 audit(1610351981.354:23): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dracut-initqueue comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   13.806958] audit: type=1130 audit(1610351981.377:24): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-fsck@dev-mapper-root comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   14.083764] SGI XFS with ACLs, security attributes, realtime, scrub, repair, quota, no debug enabled
> [   14.085897] XFS: attr2 mount option is deprecated.
> [   14.086960] XFS (dm-0): Mounting V5 Filesystem
> [   14.106397] XFS (dm-0): Starting recovery (logdev: internal)
> [   14.109800] XFS (dm-0): Ending recovery (logdev: internal)
> [   14.111715] xfs filesystem being mounted at /sysroot supports timestamps until 2038 (0x7fffffff)
> [   14.129155] audit: type=1334 audit(1610351981.699:25): prog-id=8 op=UNLOAD
> [   14.129166] audit: type=1334 audit(1610351981.699:26): prog-id=7 op=UNLOAD
> [   14.130545] audit: type=1334 audit(1610351981.701:27): prog-id=10 op=UNLOAD
> [   14.130785] audit: type=1334 audit(1610351981.701:28): prog-id=9 op=UNLOAD
> [   14.332803] audit: type=1334 audit(1610351981.903:29): prog-id=11 op=LOAD
> [   14.333133] audit: type=1334 audit(1610351981.903:30): prog-id=12 op=LOAD
> [   14.336403] audit: type=1334 audit(1610351981.907:31): prog-id=13 op=LOAD
> [   14.698580] systemd[1]: systemd 247.2-1-arch running in system mode. (+PAM +AUDIT -SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
> [   14.710503] systemd[1]: Detected architecture x86-64.
> [   14.712176] systemd[1]: Set hostname to <hp-laptop>.
> [   14.928683] systemd[1]: initrd-switch-root.service: Succeeded.
> [   14.929398] systemd[1]: Stopped Switch Root.
> [   14.929853] systemd[1]: systemd-journald.service: Scheduled restart job, restart counter is at 1.
> [   14.930494] systemd[1]: Created slice system-getty.slice.
> [   14.931032] systemd[1]: Created slice system-modprobe.slice.
> [   14.931552] systemd[1]: Created slice User and Session Slice.
> [   14.931694] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
> [   14.931793] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
> [   14.932099] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
> [   14.932164] systemd[1]: Reached target Block Device Preparation for /dev/mapper/root.
> [   14.932210] systemd[1]: Reached target Local Encrypted Volumes.
> [   14.932272] systemd[1]: Reached target Login Prompts.
> [   14.932311] systemd[1]: Stopped target Switch Root.
> [   14.932336] systemd[1]: Stopped target Initrd File Systems.
> [   14.932352] systemd[1]: Stopped target Initrd Root File System.
> [   14.932414] systemd[1]: Reached target Paths.
> [   14.932472] systemd[1]: Reached target Remote File Systems.
> [   14.932518] systemd[1]: Reached target Slices.
> [   14.932574] systemd[1]: Reached target Swap.
> [   14.932719] systemd[1]: Listening on Device-mapper event daemon FIFOs.
> [   14.933182] systemd[1]: Listening on LVM2 metadata daemon socket.
> [   14.933595] systemd[1]: Listening on LVM2 poll daemon socket.
> [   14.936232] systemd[1]: Listening on Process Core Dump Socket.
> [   14.937564] systemd[1]: Listening on udev Control Socket.
> [   14.937749] systemd[1]: Listening on udev Kernel Socket.
> [   14.939486] systemd[1]: Mounting Huge Pages File System...
> [   14.941002] systemd[1]: Mounting POSIX Message Queue File System...
> [   14.942610] systemd[1]: Mounting Kernel Debug File System...
> [   14.944230] systemd[1]: Mounting Kernel Trace File System...
> [   14.945896] systemd[1]: Mounting Temporary Directory (/tmp)...
> [   14.947638] systemd[1]: Starting Create list of static device nodes for the current kernel...
> [   14.949303] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
> [   14.951319] systemd[1]: Starting Load Kernel Module configfs...
> [   14.953130] systemd[1]: Starting Load Kernel Module drm...
> [   14.954961] systemd[1]: Starting Load Kernel Module fuse...
> [   14.955620] systemd[1]: Condition check resulted in Set Up Additional Binary Formats being skipped.
> [   14.955975] systemd[1]: systemd-fsck@dev-mapper-root.service: Succeeded.
> [   14.956685] systemd[1]: Stopped File System Check on /dev/mapper/root.
> [   14.956889] systemd[1]: Condition check resulted in File System Check on Root Device being skipped.
> [   14.956990] systemd[1]: Stopped Journal Service.
> [   14.960441] systemd[1]: Starting Journal Service...
> [   14.963347] systemd[1]: Starting Load Kernel Modules...
> [   14.965686] systemd[1]: Starting Remount Root and Kernel File Systems...
> [   14.965889] systemd[1]: Condition check resulted in Repartition Root Disk being skipped.
> [   14.968840] systemd[1]: Starting Coldplug All udev Devices...
> [   14.972095] systemd[1]: sysroot.mount: Succeeded.
> [   14.974030] systemd[1]: Mounted Huge Pages File System.
> [   14.974220] fuse: init (API version 7.32)
> [   14.974408] systemd[1]: Mounted POSIX Message Queue File System.
> [   14.974739] systemd[1]: Mounted Kernel Debug File System.
> [   14.974975] systemd[1]: Mounted Kernel Trace File System.
> [   14.975331] systemd[1]: Mounted Temporary Directory (/tmp).
> [   14.975465] XFS: attr2 mount option is deprecated.
> [   14.976363] xfs filesystem being remounted at / supports timestamps until 2038 (0x7fffffff)
> [   14.976633] systemd[1]: Finished Create list of static device nodes for the current kernel.
> [   14.979043] systemd[1]: modprobe@configfs.service: Succeeded.
> [   14.979962] systemd[1]: Finished Load Kernel Module configfs.
> [   14.980660] systemd[1]: modprobe@drm.service: Succeeded.
> [   14.981427] systemd[1]: Finished Load Kernel Module drm.
> [   14.981912] systemd[1]: modprobe@fuse.service: Succeeded.
> [   14.982560] systemd[1]: Finished Load Kernel Module fuse.
> [   14.983505] systemd[1]: Finished Load Kernel Modules.
> [   14.984650] systemd[1]: Finished Remount Root and Kernel File Systems.
> [   14.986967] systemd[1]: Mounting FUSE Control File System...
> [   14.988678] systemd[1]: Mounting Kernel Configuration File System...
> [   14.988839] systemd[1]: Condition check resulted in First Boot Wizard being skipped.
> [   14.989567] systemd[1]: Condition check resulted in Rebuild Hardware Database being skipped.
> [   14.991936] systemd[1]: Starting Load/Save Random Seed...
> [   14.994305] systemd[1]: Starting Apply Kernel Variables...
> [   14.996795] systemd[1]: Starting Create System Users...
> [   14.999654] systemd[1]: Mounted FUSE Control File System.
> [   14.999902] systemd[1]: Mounted Kernel Configuration File System.
> [   15.004851] systemd[1]: Finished Apply Kernel Variables.
> [   15.006802] systemd[1]: Finished Load/Save Random Seed.
> [   15.007064] systemd[1]: Condition check resulted in First Boot Complete being skipped.
> [   15.016466] systemd[1]: Finished Create System Users.
> [   15.018795] systemd[1]: Starting Create Static Device Nodes in /dev...
> [   15.019928] systemd[1]: Started Journal Service.
> [   15.210572] acpi_cpufreq: overriding BIOS provided _PSD data
> [   15.220729] input: HP Wireless hotkeys as /devices/virtual/input/input14
> [   15.222418] i2c_amd_mp2 0000:04:00.7: MP2 device registered.
> [   15.233787] tpm_tis IFX0785:00: 2.0 TPM (device-id 0x1B, rev-id 22)
> [   15.240620] i2c_hid i2c-SYNA308C:00: supply vdd not found, using dummy regulator
> [   15.240668] i2c_hid i2c-SYNA308C:00: supply vddl not found, using dummy regulator
> [   15.293154] IPMI message handler: version 39.2
> [   15.297144] ipmi device interface
> [   15.334073] snd_pci_acp3x 0000:04:00.5: Invalid ACP audio mode : 1
> [   15.334135] ipmi_si: IPMI System Interface driver
> [   15.334345] ipmi_si: Unable to find any System Interface(s)
> [   15.343622] ACPI Warning: SystemIO range 0x0000000000000B00-0x0000000000000B08 conflicts with OpRegion 0x0000000000000B00-0x0000000000000B06 (\_SB.PCI0.SMBS.SMBO) (20200925/utaddress-204)
> [   15.343662] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
> [   15.355539] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
> [   15.355765] sp5100-tco sp5100-tco: Using 0xfeb00000 for watchdog MMIO address
> [   15.362941] sp5100-tco sp5100-tco: initialized. heartbeat=60 sec (nowayout=0)
> [   15.366313] mousedev: PS/2 mouse device common for all mice
> [   15.384839] input: SYNA308C:00 06CB:CD77 Mouse as /devices/platform/AMDI0011:00/i2c-8/i2c-SYNA308C:00/0018:06CB:CD77.0001/input/input15
> [   15.385042] input: SYNA308C:00 06CB:CD77 Touchpad as /devices/platform/AMDI0011:00/i2c-8/i2c-SYNA308C:00/0018:06CB:CD77.0001/input/input16
> [   15.385157] hid-generic 0018:06CB:CD77.0001: input,hidraw0: I2C HID v1.00 Mouse [SYNA308C:00 06CB:CD77] on i2c-SYNA308C:00
> [   15.388014] input: PC Speaker as /devices/platform/pcspkr/input/input18
> [   15.412240] hp_wmi: query 0x4 returned error 0x5
> [   15.413113] RAPL PMU: API unit is 2^-32 Joules, 1 fixed counters, 163840 ms ovfl timer
> [   15.413117] RAPL PMU: hw unit of domain package 2^-16 Joules
> [   15.416701] hp_wmi: query 0x4 returned error 0x5
> [   15.421733] hp_wmi: query 0xd returned error 0x5
> [   15.421839] input: HP WMI hotkeys as /devices/virtual/input/input19
> [   15.434571] hp_wmi: query 0x1b returned error 0x5
> [   15.473993] cfg80211: Loading compiled-in X.509 certificates for regulatory database
> [   15.491346] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> [   15.494530] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
> [   15.494537] cfg80211: failed to load regulatory.db
> [   15.608460] Intel(R) Wireless WiFi driver for Linux
> [   15.635417] iwlwifi 0000:02:00.0: api flags index 2 larger than supported by driver
> [   15.635450] iwlwifi 0000:02:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 89.3.35.22
> [   15.636187] iwlwifi 0000:02:00.0: loaded firmware version 59.601f3a66.0 cc-a0-59.ucode op_mode iwlmvm
> [   15.650494] kvm: Nested Virtualization enabled
> [   15.650528] SVM: kvm: Nested Paging enabled
> [   15.650529] SVM: Virtual VMLOAD VMSAVE supported
> [   15.650530] SVM: Virtual GIF supported
> [   15.664049] MCE: In-kernel MCE decoding enabled.
> [   15.670529] EDAC amd64: F17h_M10h detected (node 0).
> [   15.670619] EDAC amd64: Node 0: DRAM ECC disabled.
> [   15.673483] input: SYNA308C:00 06CB:CD77 Mouse as /devices/platform/AMDI0011:00/i2c-8/i2c-SYNA308C:00/0018:06CB:CD77.0001/input/input20
> [   15.673737] input: SYNA308C:00 06CB:CD77 Touchpad as /devices/platform/AMDI0011:00/i2c-8/i2c-SYNA308C:00/0018:06CB:CD77.0001/input/input21
> [   15.674104] hid-multitouch 0018:06CB:CD77.0001: input,hidraw0: I2C HID v1.00 Mouse [SYNA308C:00 06CB:CD77] on i2c-SYNA308C:00
> [   15.691615] EDAC amd64: F17h_M10h detected (node 0).
> [   15.691707] EDAC amd64: Node 0: DRAM ECC disabled.
> [   15.712789] EDAC amd64: F17h_M10h detected (node 0).
> [   15.712881] EDAC amd64: Node 0: DRAM ECC disabled.
> [   15.730440] EDAC amd64: F17h_M10h detected (node 0).
> [   15.730549] EDAC amd64: Node 0: DRAM ECC disabled.
> [   15.742780] EDAC amd64: F17h_M10h detected (node 0).
> [   15.742899] EDAC amd64: Node 0: DRAM ECC disabled.
> [   15.748479] snd_hda_intel 0000:04:00.1: bound 0000:04:00.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu])
> [   15.765525] input: HD-Audio Generic HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:08.1/0000:04:00.1/sound/card0/input23
> [   15.765606] input: HD-Audio Generic HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:08.1/0000:04:00.1/sound/card0/input24
> [   15.765682] input: HD-Audio Generic HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:08.1/0000:04:00.1/sound/card0/input25
> [   15.765745] input: HD-Audio Generic HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:08.1/0000:04:00.1/sound/card0/input26
> [   15.767368] EDAC amd64: F17h_M10h detected (node 0).
> [   15.767506] EDAC amd64: Node 0: DRAM ECC disabled.
> [   15.773587] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC215: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
> [   15.773594] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> [   15.773597] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
> [   15.773598] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=0x0
> [   15.773600] snd_hda_codec_realtek hdaudioC1D0:    inputs:
> [   15.773602] snd_hda_codec_realtek hdaudioC1D0:      Mic=0x19
> [   15.773605] snd_hda_codec_realtek hdaudioC1D0:      Internal Mic=0x12
> [   15.786977] EDAC amd64: F17h_M10h detected (node 0).
> [   15.787067] EDAC amd64: Node 0: DRAM ECC disabled.
> [   15.805769] EDAC amd64: F17h_M10h detected (node 0).
> [   15.805864] EDAC amd64: Node 0: DRAM ECC disabled.
> [   15.818573] input: HD-Audio Generic Mic as /devices/pci0000:00/0000:00:08.1/0000:04:00.6/sound/card1/input27
> [   15.818662] input: HD-Audio Generic Headphone as /devices/pci0000:00/0000:00:08.1/0000:04:00.6/sound/card1/input28
> [   15.832731] iwlwifi 0000:02:00.0: Detected Intel(R) Wi-Fi 6 AX200 160MHz, REV=0x340
> [   15.975312] Generic FE-GE Realtek PHY r8169-100:00: attached PHY driver [Generic FE-GE Realtek PHY] (mii_bus:phy_addr=r8169-100:00, irq=IGNORE)
> [   16.025085] iwlwifi 0000:02:00.0: base HW address: 14:f6:d8:2f:b2:1e
> [   16.045406] r8169 0000:01:00.0 enp1s0f0: Link is Down
> [   16.046747] thermal thermal_zone6: failed to read out thermal zone (-61)
> [   16.052606] iwlwifi 0000:02:00.0 wlp2s0: renamed from wlan0
> [   16.624214] mc: Linux media interface: v0.10
> [   16.658479] videodev: Linux video capture interface: v2.00
> [   16.791738] uvcvideo: Found UVC 1.50 device HP HD Camera (04ca:7089)
> [   16.860956] input: HP HD Camera: HP HD Camera as /devices/pci0000:00/0000:00:08.1/0000:04:00.4/usb4/4-2/4-2:1.0/input/input29
> [   16.865334] uvcvideo: Found UVC 1.50 device HP HD Camera (04ca:7089)
> [   16.882674] input: HP HD Camera: HP IR Camera as /devices/pci0000:00/0000:00:08.1/0000:04:00.4/usb4/4-2/4-2:1.2/input/input30
> [   16.882875] usbcore: registered new interface driver uvcvideo
> [   16.882878] USB Video Class driver (1.1.1)
> [   17.241100] Bluetooth: Core ver 2.22
> [   17.241174] NET: Registered protocol family 31
> [   17.241175] Bluetooth: HCI device and connection manager initialized
> [   17.241184] Bluetooth: HCI socket layer initialized
> [   17.241188] Bluetooth: L2CAP socket layer initialized
> [   17.241193] Bluetooth: SCO socket layer initialized
> [   17.413708] usbcore: registered new interface driver btusb
> [   17.417601] Bluetooth: hci0: Firmware revision 0.0 build 127 week 48 2020
> [   21.135905] kauditd_printk_skb: 101 callbacks suppressed
> [   21.135908] audit: type=1100 audit(1610351988.706:133): pid=1466 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:authentication grantors=pam_shells,pam_faillock,pam_permit,pam_faillock acct="aep" exe="/usr/bin/lightdm" hostname=? addr=? terminal=:0 res=success'
> [   21.138016] audit: type=1101 audit(1610351988.708:134): pid=1466 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:accounting grantors=pam_access,pam_unix,pam_permit,pam_time acct="aep" exe="/usr/bin/lightdm" hostname=? addr=? terminal=:0 res=success'
> [   21.197029] audit: type=1106 audit(1610351988.767:135): pid=1385 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:session_close grantors=pam_unix,pam_systemd acct="lightdm" exe="/usr/bin/lightdm" hostname=? addr=? terminal=:0 res=success'
> [   21.197194] audit: type=1104 audit(1610351988.767:136): pid=1385 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:setcred grantors=pam_env,pam_permit acct="lightdm" exe="/usr/bin/lightdm" hostname=? addr=? terminal=:0 res=success'
> [   21.203741] audit: type=1103 audit(1610351988.774:137): pid=1466 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:setcred grantors=pam_shells,pam_faillock,pam_permit,pam_faillock acct="aep" exe="/usr/bin/lightdm" hostname=? addr=? terminal=:0 res=success'
> [   21.203870] audit: type=1006 audit(1610351988.774:138): pid=1466 uid=0 old-auid=4294967295 auid=1000 tty=(none) old-ses=4294967295 ses=2 res=1
> [   21.238164] audit: type=1130 audit(1610351988.808:139): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=user-runtime-dir@1000 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   21.250081] audit: type=1101 audit(1610351988.820:140): pid=1477 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:accounting grantors=pam_access,pam_unix,pam_permit,pam_time acct="aep" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   21.250127] audit: type=1103 audit(1610351988.820:141): pid=1477 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:setcred grantors=? acct="aep" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
> [   21.250286] audit: type=1006 audit(1610351988.820:142): pid=1477 uid=0 old-auid=4294967295 auid=1000 tty=(none) old-ses=4294967295 ses=3 res=1
> [   23.265369] wlp2s0: authenticate with 78:d2:94:a2:22:bf
> [   23.269614] wlp2s0: send auth to 78:d2:94:a2:22:bf (try 1/3)
> [   23.406117] wlp2s0: authenticate with 78:d2:94:a2:22:bf
> [   23.406125] wlp2s0: send auth to 78:d2:94:a2:22:bf (try 1/3)
> [   23.407323] wlp2s0: authenticated
> [   23.408291] wlp2s0: associate with 78:d2:94:a2:22:bf (try 1/3)
> [   23.411421] wlp2s0: RX AssocResp from 78:d2:94:a2:22:bf (capab=0x11 status=0 aid=1)
> [   23.416394] wlp2s0: associated
> [   23.458614] IPv6: ADDRCONF(NETDEV_CHANGE): wlp2s0: link becomes ready
> [   26.201490] kauditd_printk_skb: 12 callbacks suppressed
> [   26.201493] audit: type=1131 audit(1610351993.772:155): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=NetworkManager-dispatcher comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   31.239448] audit: type=1131 audit(1610351998.810:156): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=user@975 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   31.253460] audit: type=1131 audit(1610351998.824:157): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=user-runtime-dir@975 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   40.331211] audit: type=1100 audit(1610352007.901:158): pid=1865 uid=1000 auid=1000 ses=3 msg='op=PAM:authentication grantors=pam_faillock,pam_permit,pam_faillock acct="aep" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
> [   40.333261] audit: type=1101 audit(1610352007.903:159): pid=1865 uid=1000 auid=1000 ses=3 msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="aep" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
> [   40.333542] audit: type=1110 audit(1610352007.904:160): pid=1865 uid=1000 auid=1000 ses=3 msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_faillock acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
> [   40.334802] audit: type=1105 audit(1610352007.905:161): pid=1865 uid=1000 auid=1000 ses=3 msg='op=PAM:session_open grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
> [   45.916908] audit: type=1131 audit(1610352013.487:162): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-hostnamed comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   45.976848] audit: type=1334 audit(1610352013.548:163): prog-id=26 op=UNLOAD
> [   45.976872] audit: type=1334 audit(1610352013.548:164): prog-id=25 op=UNLOAD

> [    0.000000] Linux version 5.10.5-zen1-1-zen (linux-zen@archlinux) (gcc (GCC) 10.2.0, GNU ld (GNU Binutils) 2.35.1) #1 ZEN SMP PREEMPT Thu, 07 Jan 2021 09:50:48 +0000
> [    0.000000] Command line: initrd=\EFI\ArchLinux\initramfs-linux-zen.img quiet
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> [    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> [    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'compacted' format.
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000009efffff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000009f00000-0x0000000009f0afff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x0000000009f0b000-0x00000000381cefff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000381cf000-0x0000000038fcefff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000038fcf000-0x00000000396cefff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x00000000396cf000-0x000000003974efff] ACPI data
> [    0.000000] BIOS-e820: [mem 0x000000003974f000-0x000000005dffffff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fd100000-0x00000000fd1fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed80fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fedf1000-0x00000000fedf1fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000041f33ffff] usable
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] e820: update [mem 0x2336c018-0x23379457] usable ==> usable
> [    0.000000] e820: update [mem 0x2336c018-0x23379457] usable ==> usable
> [    0.000000] extended physical RAM map:
> [    0.000000] reserve setup_data: [mem 0x0000000000000000-0x000000000009ffff] usable
> [    0.000000] reserve setup_data: [mem 0x0000000000100000-0x0000000009efffff] usable
> [    0.000000] reserve setup_data: [mem 0x0000000009f00000-0x0000000009f0afff] ACPI NVS
> [    0.000000] reserve setup_data: [mem 0x0000000009f0b000-0x000000002336c017] usable
> [    0.000000] reserve setup_data: [mem 0x000000002336c018-0x0000000023379457] usable
> [    0.000000] reserve setup_data: [mem 0x0000000023379458-0x00000000381cefff] usable
> [    0.000000] reserve setup_data: [mem 0x00000000381cf000-0x0000000038fcefff] reserved
> [    0.000000] reserve setup_data: [mem 0x0000000038fcf000-0x00000000396cefff] ACPI NVS
> [    0.000000] reserve setup_data: [mem 0x00000000396cf000-0x000000003974efff] ACPI data
> [    0.000000] reserve setup_data: [mem 0x000000003974f000-0x000000005dffffff] usable
> [    0.000000] reserve setup_data: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000fd100000-0x00000000fd1fffff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000fec10000-0x00000000fec10fff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000fed80000-0x00000000fed80fff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000fedf1000-0x00000000fedf1fff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
> [    0.000000] reserve setup_data: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
> [    0.000000] reserve setup_data: [mem 0x0000000100000000-0x000000041f33ffff] usable
> [    0.000000] efi: EFI v2.60 by HP
> [    0.000000] efi: ACPI=0x3974e000 ACPI 2.0=0x3974e014 SMBIOS=0x388c8000 SMBIOS 3.0=0x388c6000 ESRT=0x388c4118 TPMFinalLog=0x39621000 MEMATTR=0x3474d018 RNG=0x388afb18 TPMEventLog=0x2337a018 
> [    0.000000] efi: seeding entropy pool
> [    0.000000] SMBIOS 3.1.1 present.
> [    0.000000] DMI: HP HP EliteBook 735 G6/8589, BIOS R74 Ver. 01.05.00 04/15/2020
> [    0.000000] tsc: Fast TSC calibration using PIT
> [    0.000000] tsc: Detected 2295.789 MHz processor
> [    0.000014] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> [    0.000015] e820: remove [mem 0x000a0000-0x000fffff] usable
> [    0.000020] last_pfn = 0x41f340 max_arch_pfn = 0x400000000
> [    0.000025] MTRR default type: uncachable
> [    0.000025] MTRR fixed ranges enabled:
> [    0.000026]   00000-9FFFF write-back
> [    0.000027]   A0000-BFFFF uncachable
> [    0.000028]   C0000-DFFFF write-protect
> [    0.000028]   E0000-FFFFF uncachable
> [    0.000029] MTRR variable ranges enabled:
> [    0.000030]   0 base 0000FF000000 mask FFFFFF000000 write-protect
> [    0.000031]   1 base 000000000000 mask FFFF80000000 write-back
> [    0.000032]   2 base 000080000000 mask FFFFC0000000 write-back
> [    0.000032]   3 base 0000C0000000 mask FFFFE0000000 write-back
> [    0.000033]   4 disabled
> [    0.000033]   5 disabled
> [    0.000034]   6 disabled
> [    0.000034]   7 disabled
> [    0.000035] TOM2: 0000000420000000 aka 16896M
> [    0.000506] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
> [    0.000640] last_pfn = 0x5e000 max_arch_pfn = 0x400000000
> [    0.004706] esrt: Reserving ESRT space from 0x00000000388c4118 to 0x00000000388c4150.
> [    0.004715] check: Scanning 1 areas for low memory corruption
> [    0.004725] Using GB pages for direct mapping
> [    0.005012] Secure boot disabled
> [    0.005013] RAMDISK: [mem 0x2337f000-0x258d5fff]
> [    0.005024] ACPI: Early table checksum verification disabled
> [    0.005029] ACPI: RSDP 0x000000003974E014 000024 (v02 HPQOEM)
> [    0.005032] ACPI: XSDT 0x0000000039720188 000134 (v01 HPQOEM SLIC-BPC 00000001      01000013)
> [    0.005038] ACPI: FACP 0x000000003973C000 00010C (v05 HPQOEM SLIC-BPC 00000001 HP   00000001)
> [    0.005043] ACPI: DSDT 0x0000000039724000 010B6A (v02 HPQOEM 8589     00000000 INTL 20160527)
> [    0.005045] ACPI: FACS 0x000000003960C000 000040
> [    0.005048] ACPI: SSDT 0x000000003974C000 0002D7 (v01 HP     NVTEC    00000001 INTL 20160527)
> [    0.005050] ACPI: SSDT 0x000000003974B000 00012A (v02 HP     ShmTable 00000001 INTL 20160527)
> [    0.005052] ACPI: SSDT 0x0000000039745000 005419 (v02 AMD    AmdTable 00000002 MSFT 02000002)
> [    0.005055] ACPI: UEFI 0x0000000039630000 000042 (v01 HPQOEM EDK2     00000002      01000013)
> [    0.005057] ACPI: RTMA 0x0000000039743000 00009E (v01 HP     _HBMART_ 00001000 HP   00000001)
> [    0.005059] ACPI: SSDT 0x0000000039741000 001575 (v02 HP     UcsiAcpi 00000001 INTL 20160527)
> [    0.005061] ACPI: SSDT 0x0000000039740000 0000FB (v02 HP     UcsiCntr 00000001 INTL 20160527)
> [    0.005064] ACPI: SSDT 0x000000003973F000 0003CE (v02 HPQOEM Tpm2Tabl 00001000 INTL 20160527)
> [    0.005066] ACPI: TPM2 0x000000003973E000 000034 (v03 HPQOEM EDK2     00000002      01000013)
> [    0.005068] ACPI: OEML 0x000000003973D000 000028 (v03 HPQOEM EDK2     00000002      01000013)
> [    0.005070] ACPI: ASF! 0x000000003973B000 00006E (v32 HPQOEM 8589     00000001 HP   00000001)
> [    0.005072] ACPI: MSDM 0x000000003973A000 000055 (v03 HPQOEM SLIC-BPC 00000000 HP   00000001)
> [    0.005074] ACPI: SLIC 0x0000000039739000 000176 (v01 HPQOEM SLIC-BPC 00000001 HP   00000001)
> [    0.005077] ACPI: WSMT 0x0000000039738000 000028 (v01 HPQOEM 8589     00000001 HP   00000001)
> [    0.005079] ACPI: HPET 0x0000000039737000 000038 (v01 HPQOEM 8589     00000001 HP   00000001)
> [    0.005081] ACPI: APIC 0x0000000039736000 000138 (v02 HPQOEM 8589     00000001 HP   00000001)
> [    0.005083] ACPI: MCFG 0x0000000039735000 00003C (v01 HPQOEM 8589     00000001 HP   00000001)
> [    0.005085] ACPI: SSDT 0x0000000039721000 00119C (v01 AMD    AMD CPU  00000001 AMD  00000001)
> [    0.005087] ACPI: CRAT 0x000000003974D000 000810 (v01 AMD    AMD CRAT 00000001 AMD  00000001)
> [    0.005089] ACPI: CDIT 0x000000003971F000 000029 (v01 AMD    AMD CDIT 00000001 AMD  00000001)
> [    0.005092] ACPI: SSDT 0x000000003971E000 00013B (v01 HP     HPNBCONV 00001000 INTL 20160527)
> [    0.005094] ACPI: SSDT 0x000000003971D000 000245 (v01 HP     AMDTPL   00001000 INTL 20160527)
> [    0.005096] ACPI: SSDT 0x000000003971C000 0008F5 (v01 HP     HPADNBWL 00001000 INTL 20160527)
> [    0.005098] ACPI: SSDT 0x000000003971B000 000032 (v01 HP     HPCONDEV 00001000 INTL 20160527)
> [    0.005100] ACPI: SSDT 0x000000003971A000 000069 (v01 HP     HPCAHWID 00001000 INTL 20160527)
> [    0.005103] ACPI: VFCT 0x000000003970C000 00D484 (v01 HPQOEM SLIC-BPC 00000001 AMD  31504F47)
> [    0.005105] ACPI: SSDT 0x0000000039723000 000949 (v01 AMD    AmdTable 00000001 INTL 20160527)
> [    0.005107] ACPI: FPDT 0x000000003970B000 000044 (v01 HPQOEM EDK2     00000002      01000013)
> [    0.005109] ACPI: SSDT 0x0000000039708000 0024C8 (v01 AMD    AmdTable 00000001 INTL 20160527)
> [    0.005111] ACPI: BGRT 0x0000000039707000 000038 (v01 HPQOEM EDK2     00000002      01000013)
> [    0.005113] ACPI: SSDT 0x0000000039706000 000668 (v01 AMD    AmdTable 00000001 INTL 20160527)
> [    0.005115] ACPI: SSDT 0x0000000039744000 0002F9 (v02 HP     PwrCtlEv 00000001 INTL 20160527)
> [    0.005118] ACPI: IVRS 0x0000000039705000 00013E (v02 AMD    AMD IVRS 00000001 AMD  00000000)
> [    0.005123] ACPI: Local APIC address 0xfee00000
> [    0.005179] No NUMA configuration found
> [    0.005180] Faking a node at [mem 0x0000000000000000-0x000000041f33ffff]
> [    0.005183] NODE_DATA(0) allocated [mem 0x41f33c000-0x41f33ffff]
> [    0.041132] Zone ranges:
> [    0.041134]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.041136]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> [    0.041137]   Normal   [mem 0x0000000100000000-0x000000041f33ffff]
> [    0.041138]   Device   empty
> [    0.041139] Movable zone start for each node
> [    0.041139] Early memory node ranges
> [    0.041140]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
> [    0.041141]   node   0: [mem 0x0000000000100000-0x0000000009efffff]
> [    0.041141]   node   0: [mem 0x0000000009f0b000-0x00000000381cefff]
> [    0.041142]   node   0: [mem 0x000000003974f000-0x000000005dffffff]
> [    0.041143]   node   0: [mem 0x0000000100000000-0x000000041f33ffff]
> [    0.041295] Zeroed struct page in unavailable ranges: 17068 pages
> [    0.041296] Initmem setup node 0 [mem 0x0000000000001000-0x000000041f33ffff]
> [    0.041298] On node 0 totalpages: 3652948
> [    0.041299]   DMA zone: 64 pages used for memmap
> [    0.041300]   DMA zone: 1074 pages reserved
> [    0.041301]   DMA zone: 3999 pages, LIFO batch:0
> [    0.041331]   DMA32 zone: 5866 pages used for memmap
> [    0.041332]   DMA32 zone: 375413 pages, LIFO batch:63
> [    0.044536]   Normal zone: 51149 pages used for memmap
> [    0.044539]   Normal zone: 3273536 pages, LIFO batch:63
> [    0.072636] ACPI: PM-Timer IO Port: 0x408
> [    0.072640] ACPI: Local APIC address 0xfee00000
> [    0.072646] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
> [    0.072647] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> [    0.072647] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
> [    0.072648] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
> [    0.072648] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
> [    0.072649] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
> [    0.072649] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
> [    0.072650] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
> [    0.072650] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
> [    0.072651] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
> [    0.072651] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
> [    0.072652] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
> [    0.072652] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
> [    0.072653] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
> [    0.072653] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
> [    0.072653] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
> [    0.072677] IOAPIC[0]: apic_id 33, version 33, address 0xfec00000, GSI 0-23
> [    0.072683] IOAPIC[1]: apic_id 34, version 33, address 0xfec01000, GSI 24-55
> [    0.072685] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.072686] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
> [    0.072687] ACPI: IRQ0 used by override.
> [    0.072688] ACPI: IRQ9 used by override.
> [    0.072690] Using ACPI (MADT) for SMP configuration information
> [    0.072691] ACPI: HPET id: 0x10228210 base: 0xfed00000
> [    0.072699] e820: update [mem 0x33bdc000-0x33c24fff] usable ==> reserved
> [    0.072708] smpboot: Allowing 16 CPUs, 8 hotplug CPUs
> [    0.072724] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
> [    0.072726] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000fffff]
> [    0.072727] PM: hibernation: Registered nosave memory: [mem 0x09f00000-0x09f0afff]
> [    0.072728] PM: hibernation: Registered nosave memory: [mem 0x2336c000-0x2336cfff]
> [    0.072729] PM: hibernation: Registered nosave memory: [mem 0x23379000-0x23379fff]
> [    0.072730] PM: hibernation: Registered nosave memory: [mem 0x33bdc000-0x33c24fff]
> [    0.072731] PM: hibernation: Registered nosave memory: [mem 0x381cf000-0x38fcefff]
> [    0.072731] PM: hibernation: Registered nosave memory: [mem 0x38fcf000-0x396cefff]
> [    0.072732] PM: hibernation: Registered nosave memory: [mem 0x396cf000-0x3974efff]
> [    0.072733] PM: hibernation: Registered nosave memory: [mem 0x5e000000-0xf7ffffff]
> [    0.072733] PM: hibernation: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
> [    0.072734] PM: hibernation: Registered nosave memory: [mem 0xfc000000-0xfd0fffff]
> [    0.072734] PM: hibernation: Registered nosave memory: [mem 0xfd100000-0xfd1fffff]
> [    0.072735] PM: hibernation: Registered nosave memory: [mem 0xfd200000-0xfebfffff]
> [    0.072735] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
> [    0.072736] PM: hibernation: Registered nosave memory: [mem 0xfec01000-0xfec0ffff]
> [    0.072736] PM: hibernation: Registered nosave memory: [mem 0xfec10000-0xfec10fff]
> [    0.072736] PM: hibernation: Registered nosave memory: [mem 0xfec11000-0xfed7ffff]
> [    0.072737] PM: hibernation: Registered nosave memory: [mem 0xfed80000-0xfed80fff]
> [    0.072737] PM: hibernation: Registered nosave memory: [mem 0xfed81000-0xfedf0fff]
> [    0.072738] PM: hibernation: Registered nosave memory: [mem 0xfedf1000-0xfedf1fff]
> [    0.072738] PM: hibernation: Registered nosave memory: [mem 0xfedf2000-0xfedfffff]
> [    0.072738] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
> [    0.072739] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0xfeffffff]
> [    0.072739] PM: hibernation: Registered nosave memory: [mem 0xff000000-0xffffffff]
> [    0.072741] [mem 0x5e000000-0xf7ffffff] available for PCI devices
> [    0.072742] Booting paravirtualized kernel on bare hardware
> [    0.072745] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
> [    0.076798] setup_percpu: NR_CPUS:320 nr_cpumask_bits:320 nr_cpu_ids:16 nr_node_ids:1
> [    0.077519] percpu: Embedded 56 pages/cpu s192512 r8192 d28672 u262144
> [    0.077525] pcpu-alloc: s192512 r8192 d28672 u262144 alloc=1*2097152
> [    0.077527] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 12 13 14 15 
> [    0.077549] Built 1 zonelists, mobility grouping on.  Total pages: 3594795
> [    0.077550] Policy zone: Normal
> [    0.077551] Kernel command line: initrd=\EFI\ArchLinux\initramfs-linux-zen.img quiet
> [    0.079696] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
> [    0.080779] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
> [    0.080820] mem auto-init: stack:byref_all(zero), heap alloc:on, heap free:off
> [    0.124045] Memory: 14114984K/14611792K available (16392K kernel code, 2040K rwdata, 8724K rodata, 1720K init, 4188K bss, 496548K reserved, 0K cma-reserved)
> [    0.124055] random: get_random_u64 called from __kmem_cache_create+0x28/0x630 with crng_init=0
> [    0.124175] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
> [    0.124189] ftrace: allocating 39659 entries in 155 pages
> [    0.135620] ftrace: allocated 155 pages with 5 groups
> [    0.135752] rcu: Preemptible hierarchical RCU implementation.
> [    0.135753] rcu: 	RCU dyntick-idle grace-period acceleration is enabled.
> [    0.135753] rcu: 	RCU restricting CPUs from NR_CPUS=320 to nr_cpu_ids=16.
> [    0.135754] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
> [    0.135755] 	Trampoline variant of Tasks RCU enabled.
> [    0.135755] 	Rude variant of Tasks RCU enabled.
> [    0.135755] 	Tracing variant of Tasks RCU enabled.
> [    0.135756] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
> [    0.135756] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
> [    0.138329] NR_IRQS: 20736, nr_irqs: 1096, preallocated irqs: 16
> [    0.138711] Console: colour dummy device 80x25
> [    0.138721] printk: console [tty0] enabled
> [    0.138739] ACPI: Core revision 20200925
> [    0.138950] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
> [    0.138972] APIC: Switch to symmetric I/O mode setup
> [    0.139735] AMD-Vi: ivrs, add hid:PNP0D40, uid:, rdevid:152
> [    0.311235] Switched APIC routing to physical flat.
> [    0.312158] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    0.316970] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2117ab45c4c, max_idle_ns: 440795239981 ns
> [    0.316974] Calibrating delay loop (skipped), value calculated using timer frequency.. 4591.57 BogoMIPS (lpj=2295789)
> [    0.316976] pid_max: default: 32768 minimum: 301
> [    0.319007] LSM: Security Framework initializing
> [    0.319013] Yama: becoming mindful.
> [    0.319077] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
> [    0.319118] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
> [    0.319428] LVT offset 1 assigned for vector 0xf9
> [    0.319474] LVT offset 2 assigned for vector 0xf4
> [    0.319488] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512
> [    0.319488] Last level dTLB entries: 4KB 1536, 2MB 1536, 4MB 768, 1GB 0
> [    0.319492] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
> [    0.319494] Spectre V2 : Mitigation: Full AMD retpoline
> [    0.319494] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
> [    0.319495] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
> [    0.319496] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
> [    0.319500] clr: Applying alternatives
> [    0.319716] clr: Applying alternatives done
> [    0.319731] Freeing SMP alternatives memory: 40K
> [    0.424053] smpboot: CPU0: AMD Ryzen 7 PRO 3700U w/ Radeon Vega Mobile Gfx (family: 0x17, model: 0x18, stepping: 0x1)
> [    0.424134] Performance Events: Fam17h+ core perfctr, AMD PMU driver.
> [    0.424137] ... version:                0
> [    0.424138] ... bit width:              48
> [    0.424138] ... generic registers:      6
> [    0.424139] ... value mask:             0000ffffffffffff
> [    0.424139] ... max period:             00007fffffffffff
> [    0.424139] ... fixed-purpose events:   0
> [    0.424140] ... event mask:             000000000000003f
> [    0.424203] rcu: Hierarchical SRCU implementation.
> [    0.424547] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
> [    0.424676] smp: Bringing up secondary CPUs ...
> [    0.424770] x86: Booting SMP configuration:
> [    0.424772] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7
> [    0.434034] smp: Brought up 1 node, 8 CPUs
> [    0.434034] smpboot: Max logical packages: 2
> [    0.434034] smpboot: Total of 8 processors activated (36732.62 BogoMIPS)
> [    0.435492] devtmpfs: initialized
> [    0.435492] x86/mm: Memory block size: 128MB
> [    0.436334] PM: Registering ACPI NVS region [mem 0x09f00000-0x09f0afff] (45056 bytes)
> [    0.436334] PM: Registering ACPI NVS region [mem 0x38fcf000-0x396cefff] (7340032 bytes)
> [    0.436334] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
> [    0.436334] futex hash table entries: 4096 (order: 6, 262144 bytes, linear)
> [    0.436334] pinctrl core: initialized pinctrl subsystem
> [    0.436334] PM: RTC time: 07:09:54, date: 2021-01-11
> [    0.436989] NET: Registered protocol family 16
> [    0.437258] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic allocations
> [    0.437572] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
> [    0.437886] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
> [    0.437905] audit: initializing netlink subsys (disabled)
> [    0.437985] audit: type=2000 audit(1610348994.129:1): state=initialized audit_enabled=0 res=1
> [    0.438103] thermal_sys: Registered thermal governor 'fair_share'
> [    0.438103] thermal_sys: Registered thermal governor 'bang_bang'
> [    0.438104] thermal_sys: Registered thermal governor 'step_wise'
> [    0.438105] thermal_sys: Registered thermal governor 'user_space'
> [    0.438105] thermal_sys: Registered thermal governor 'power_allocator'
> [    0.438118] cpuidle: using governor ladder
> [    0.438121] cpuidle: using governor menu
> [    0.438152] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
> [    0.438152] ACPI: bus type PCI registered
> [    0.438152] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> [    0.438152] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
> [    0.438152] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
> [    0.438152] PCI: Using configuration type 1 for base access
> [    0.439456] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
> [    0.439456] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
> [    0.440146] ACPI: Added _OSI(Module Device)
> [    0.440148] ACPI: Added _OSI(Processor Device)
> [    0.440149] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    0.440150] ACPI: Added _OSI(Processor Aggregator Device)
> [    0.440152] ACPI: Added _OSI(Linux-Dell-Video)
> [    0.440154] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
> [    0.440155] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
> [    0.453544] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.LPC0.EC0], AE_NOT_FOUND (20200925/dswload2-162)
> [    0.453550] ACPI Error: AE_NOT_FOUND, During name lookup/catalog (20200925/psobject-220)
> [    0.453551] ACPI: Skipping parse of AML opcode: Scope (0x0010)
> [    0.455178] ACPI: 17 ACPI AML tables successfully acquired and loaded
> [    0.459090] ACPI: EC: EC started
> [    0.459091] ACPI: EC: interrupt blocked
> [    0.459486] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
> [    0.476134] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
> [    0.476137] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC used to handle transactions
> [    0.476138] ACPI: Interpreter enabled
> [    0.476160] ACPI: (supports S0 S3 S4 S5)
> [    0.476161] ACPI: Using IOAPIC for interrupt routing
> [    0.476567] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [    0.476894] ACPI: Enabled 8 GPEs in block 00 to 1F
> [    0.477631] ACPI: Power Resource [PXP] (off)
> [    0.478248] ACPI: Power Resource [WLRT] (on)
> [    0.479531] ACPI: Power Resource [APPR] (off)
> [    0.483006] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> [    0.483013] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
> [    0.483118] acpi PNP0A08:00: _OSC: platform does not support [SHPCHotplug LTR DPC]
> [    0.483215] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
> [    0.483217] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
> [    0.483229] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-3f] only partially covers this bridge
> [    0.483401] PCI host bridge to bus 0000:00
> [    0.483403] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> [    0.483403] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> [    0.483404] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> [    0.483405] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000c3fff window]
> [    0.483406] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c7fff window]
> [    0.483407] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000cbfff window]
> [    0.483407] pci_bus 0000:00: root bus resource [mem 0x000cc000-0x000cffff window]
> [    0.483408] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3fff window]
> [    0.483409] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff window]
> [    0.483409] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff window]
> [    0.483410] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff window]
> [    0.483411] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3fff window]
> [    0.483411] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7fff window]
> [    0.483412] pci_bus 0000:00: root bus resource [mem 0x000e8000-0x000ebfff window]
> [    0.483413] pci_bus 0000:00: root bus resource [mem 0x000ec000-0x000effff window]
> [    0.483413] pci_bus 0000:00: root bus resource [mem 0xe0000000-0xf7ffffff window]
> [    0.483414] pci_bus 0000:00: root bus resource [mem 0xfc000000-0xfeafffff window]
> [    0.483415] pci_bus 0000:00: root bus resource [bus 00-ff]
> [    0.483432] pci 0000:00:00.0: [1022:15d0] type 00 class 0x060000
> [    0.483540] pci 0000:00:00.2: [1022:15d1] type 00 class 0x080600
> [    0.483660] pci 0000:00:01.0: [1022:1452] type 00 class 0x060000
> [    0.483755] pci 0000:00:01.3: [1022:15d3] type 01 class 0x060400
> [    0.483796] pci 0000:00:01.3: enabling Extended Tags
> [    0.483865] pci 0000:00:01.3: PME# supported from D0 D3hot D3cold
> [    0.483999] pci 0000:00:01.4: [1022:15d3] type 01 class 0x060400
> [    0.484040] pci 0000:00:01.4: enabling Extended Tags
> [    0.484122] pci 0000:00:01.4: PME# supported from D0 D3hot D3cold
> [    0.484232] pci 0000:00:01.7: [1022:15d3] type 01 class 0x060400
> [    0.484276] pci 0000:00:01.7: enabling Extended Tags
> [    0.484344] pci 0000:00:01.7: PME# supported from D0 D3hot D3cold
> [    0.484463] pci 0000:00:08.0: [1022:1452] type 00 class 0x060000
> [    0.484552] pci 0000:00:08.1: [1022:15db] type 01 class 0x060400
> [    0.484592] pci 0000:00:08.1: enabling Extended Tags
> [    0.484645] pci 0000:00:08.1: PME# supported from D0 D3hot D3cold
> [    0.484784] pci 0000:00:14.0: [1022:790b] type 00 class 0x0c0500
> [    0.484927] pci 0000:00:14.3: [1022:790e] type 00 class 0x060100
> [    0.485083] pci 0000:00:18.0: [1022:15e8] type 00 class 0x060000
> [    0.485134] pci 0000:00:18.1: [1022:15e9] type 00 class 0x060000
> [    0.485182] pci 0000:00:18.2: [1022:15ea] type 00 class 0x060000
> [    0.485231] pci 0000:00:18.3: [1022:15eb] type 00 class 0x060000
> [    0.485279] pci 0000:00:18.4: [1022:15ec] type 00 class 0x060000
> [    0.485330] pci 0000:00:18.5: [1022:15ed] type 00 class 0x060000
> [    0.485384] pci 0000:00:18.6: [1022:15ee] type 00 class 0x060000
> [    0.485433] pci 0000:00:18.7: [1022:15ef] type 00 class 0x060000
> [    0.485580] pci 0000:01:00.0: [10ec:8168] type 00 class 0x020000
> [    0.485603] pci 0000:01:00.0: reg 0x10: [io  0x3300-0x33ff]
> [    0.485632] pci 0000:01:00.0: reg 0x18: [mem 0xf0914000-0xf0914fff 64bit]
> [    0.485650] pci 0000:01:00.0: reg 0x20: [mem 0xf0900000-0xf0903fff 64bit]
> [    0.485772] pci 0000:01:00.0: supports D1 D2
> [    0.485773] pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> [    0.485927] pci 0000:01:00.1: [10ec:816a] type 00 class 0x070002
> [    0.485948] pci 0000:01:00.1: reg 0x10: [io  0x3200-0x32ff]
> [    0.485977] pci 0000:01:00.1: reg 0x18: [mem 0xf0915000-0xf0915fff 64bit]
> [    0.485995] pci 0000:01:00.1: reg 0x20: [mem 0xf0904000-0xf0907fff 64bit]
> [    0.486108] pci 0000:01:00.1: supports D1 D2
> [    0.486109] pci 0000:01:00.1: PME# supported from D0 D1 D2 D3hot D3cold
> [    0.486226] pci 0000:01:00.2: [10ec:816b] type 00 class 0x070002
> [    0.486247] pci 0000:01:00.2: reg 0x10: [io  0x3100-0x31ff]
> [    0.486276] pci 0000:01:00.2: reg 0x18: [mem 0xf0916000-0xf0916fff 64bit]
> [    0.486293] pci 0000:01:00.2: reg 0x20: [mem 0xf0908000-0xf090bfff 64bit]
> [    0.486406] pci 0000:01:00.2: supports D1 D2
> [    0.486407] pci 0000:01:00.2: PME# supported from D0 D1 D2 D3hot D3cold
> [    0.486522] pci 0000:01:00.3: [10ec:816c] type 00 class 0x0c0701
> [    0.486541] pci 0000:01:00.3: reg 0x10: [io  0x3000-0x30ff]
> [    0.486563] pci 0000:01:00.3: reg 0x18: [mem 0xf0917000-0xf0917fff 64bit]
> [    0.486578] pci 0000:01:00.3: reg 0x20: [mem 0xf090c000-0xf090ffff 64bit]
> [    0.486688] pci 0000:01:00.3: supports D1 D2
> [    0.486688] pci 0000:01:00.3: PME# supported from D0 D1 D2 D3hot D3cold
> [    0.486804] pci 0000:01:00.4: [10ec:816d] type 00 class 0x0c0320
> [    0.486825] pci 0000:01:00.4: reg 0x10: [mem 0xf0918000-0xf0918fff]
> [    0.486853] pci 0000:01:00.4: reg 0x18: [mem 0xf0910000-0xf0913fff 64bit]
> [    0.486987] pci 0000:01:00.4: PME# supported from D0 D3cold
> [    0.487158] pci 0000:00:01.3: PCI bridge to [bus 01]
> [    0.487164] pci 0000:00:01.3:   bridge window [io  0x3000-0x3fff]
> [    0.487167] pci 0000:00:01.3:   bridge window [mem 0xf0900000-0xf09fffff]
> [    0.487283] pci 0000:02:00.0: [8086:2723] type 00 class 0x028000
> [    0.487341] pci 0000:02:00.0: reg 0x10: [mem 0xf0800000-0xf0803fff 64bit]
> [    0.487571] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
> [    0.488170] pci 0000:00:01.4: PCI bridge to [bus 02]
> [    0.488177] pci 0000:00:01.4:   bridge window [mem 0xf0800000-0xf08fffff]
> [    0.488235] pci 0000:03:00.0: [1179:011a] type 00 class 0x010802
> [    0.488257] pci 0000:03:00.0: reg 0x10: [mem 0xf0700000-0xf0703fff 64bit]
> [    0.488454] pci 0000:03:00.0: 16.000 Gb/s available PCIe bandwidth, limited by 5.0 GT/s PCIe x4 link at 0000:00:01.7 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
> [    0.488499] pci 0000:00:01.7: PCI bridge to [bus 03]
> [    0.488506] pci 0000:00:01.7:   bridge window [mem 0xf0700000-0xf07fffff]
> [    0.488614] pci 0000:04:00.0: [1002:15d8] type 00 class 0x030000
> [    0.488634] pci 0000:04:00.0: reg 0x10: [mem 0xe0000000-0xefffffff 64bit pref]
> [    0.488646] pci 0000:04:00.0: reg 0x18: [mem 0xf0000000-0xf01fffff 64bit pref]
> [    0.488655] pci 0000:04:00.0: reg 0x20: [io  0x2000-0x20ff]
> [    0.488663] pci 0000:04:00.0: reg 0x24: [mem 0xf0600000-0xf067ffff]
> [    0.488678] pci 0000:04:00.0: enabling Extended Tags
> [    0.488699] pci 0000:04:00.0: BAR 0: assigned to efifb
> [    0.488772] pci 0000:04:00.0: PME# supported from D1 D2 D3hot D3cold
> [    0.488901] pci 0000:04:00.1: [1002:15de] type 00 class 0x040300
> [    0.488914] pci 0000:04:00.1: reg 0x10: [mem 0xf06c8000-0xf06cbfff]
> [    0.488976] pci 0000:04:00.1: enabling Extended Tags
> [    0.489030] pci 0000:04:00.1: PME# supported from D1 D2 D3hot D3cold
> [    0.489088] pci 0000:04:00.2: [1022:15df] type 00 class 0x108000
> [    0.489111] pci 0000:04:00.2: reg 0x18: [mem 0xf0500000-0xf05fffff]
> [    0.489128] pci 0000:04:00.2: reg 0x24: [mem 0xf06ce000-0xf06cffff]
> [    0.489139] pci 0000:04:00.2: enabling Extended Tags
> [    0.489273] pci 0000:04:00.3: [1022:15e0] type 00 class 0x0c0330
> [    0.489291] pci 0000:04:00.3: reg 0x10: [mem 0xf0200000-0xf02fffff 64bit]
> [    0.489336] pci 0000:04:00.3: enabling Extended Tags
> [    0.489393] pci 0000:04:00.3: PME# supported from D0 D3hot D3cold
> [    0.489473] pci 0000:04:00.4: [1022:15e1] type 00 class 0x0c0330
> [    0.489492] pci 0000:04:00.4: reg 0x10: [mem 0xf0300000-0xf03fffff 64bit]
> [    0.489536] pci 0000:04:00.4: enabling Extended Tags
> [    0.489593] pci 0000:04:00.4: PME# supported from D0 D3hot D3cold
> [    0.489675] pci 0000:04:00.5: [1022:15e2] type 00 class 0x048000
> [    0.489688] pci 0000:04:00.5: reg 0x10: [mem 0xf0680000-0xf06bffff]
> [    0.489727] pci 0000:04:00.5: enabling Extended Tags
> [    0.489779] pci 0000:04:00.5: PME# supported from D0 D3hot D3cold
> [    0.489857] pci 0000:04:00.6: [1022:15e3] type 00 class 0x040300
> [    0.489870] pci 0000:04:00.6: reg 0x10: [mem 0xf06c0000-0xf06c7fff]
> [    0.489908] pci 0000:04:00.6: enabling Extended Tags
> [    0.489960] pci 0000:04:00.6: PME# supported from D0 D3hot D3cold
> [    0.490058] pci 0000:04:00.7: [1022:15e6] type 00 class 0x000000
> [    0.490082] pci 0000:04:00.7: reg 0x18: [mem 0xf0400000-0xf04fffff]
> [    0.490099] pci 0000:04:00.7: reg 0x24: [mem 0xf06cc000-0xf06cdfff]
> [    0.490111] pci 0000:04:00.7: enabling Extended Tags
> [    0.490273] pci 0000:00:08.1: PCI bridge to [bus 04]
> [    0.490278] pci 0000:00:08.1:   bridge window [io  0x2000-0x2fff]
> [    0.490280] pci 0000:00:08.1:   bridge window [mem 0xf0200000-0xf06fffff]
> [    0.490285] pci 0000:00:08.1:   bridge window [mem 0xe0000000-0xf01fffff 64bit pref]
> [    0.491398] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 5 6 10 11) *0, disabled.
> [    0.491491] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 5 6 10 11) *0, disabled.
> [    0.491563] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 5 6 10 11) *0, disabled.
> [    0.491658] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 5 6 10 11) *0, disabled.
> [    0.491751] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 5 6 10 11) *0, disabled.
> [    0.491818] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 5 6 10 11) *0, disabled.
> [    0.491886] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 5 6 10 11) *0, disabled.
> [    0.491964] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 5 6 10 11) *0, disabled.
> [    0.492090] ACPI: EC: interrupt unblocked
> [    0.492091] ACPI: EC: event unblocked
> [    0.492098] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
> [    0.492099] ACPI: EC: GPE=0x3
> [    0.492101] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC initialization complete
> [    0.492102] ACPI: \_SB_.PCI0.LPCB.EC0_: EC: Used to handle transactions and events
> [    0.492173] iommu: Default domain type: Translated 
> [    0.492375] SCSI subsystem initialized
> [    0.493011] libata version 3.00 loaded.
> [    0.493018] pci 0000:04:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
> [    0.493018] pci 0000:04:00.0: vgaarb: bridge control possible
> [    0.493018] pci 0000:04:00.0: vgaarb: setting as boot device
> [    0.493018] vgaarb: loaded
> [    0.493018] ACPI: bus type USB registered
> [    0.493031] usbcore: registered new interface driver usbfs
> [    0.493038] usbcore: registered new interface driver hub
> [    0.493057] usbcore: registered new device driver usb
> [    0.494168] pps_core: LinuxPPS API ver. 1 registered
> [    0.494169] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> [    0.494172] PTP clock support registered
> [    0.494186] EDAC MC: Ver: 3.0.0
> [    0.495002] Registered efivars operations
> [    0.495117] NetLabel: Initializing
> [    0.495118] NetLabel:  domain hash size = 128
> [    0.495119] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
> [    0.495131] NetLabel:  unlabeled traffic allowed by default
> [    0.495135] PCI: Using ACPI for IRQ routing
> [    0.497425] PCI: pci_cache_line_size set to 64 bytes
> [    0.497588] e820: reserve RAM buffer [mem 0x09f00000-0x0bffffff]
> [    0.497591] e820: reserve RAM buffer [mem 0x2336c018-0x23ffffff]
> [    0.497592] e820: reserve RAM buffer [mem 0x33bdc000-0x33ffffff]
> [    0.497593] e820: reserve RAM buffer [mem 0x381cf000-0x3bffffff]
> [    0.497593] e820: reserve RAM buffer [mem 0x5e000000-0x5fffffff]
> [    0.497594] e820: reserve RAM buffer [mem 0x41f340000-0x41fffffff]
> [    0.498021] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
> [    0.498025] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
> [    0.500071] clocksource: Switched to clocksource tsc-early
> [    0.511471] VFS: Disk quotas dquot_6.6.0
> [    0.511494] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [    0.511620] pnp: PnP ACPI init
> [    0.511959] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
> [    0.512041] system 00:01: [io  0x0400-0x04cf] has been reserved
> [    0.512042] system 00:01: [io  0x04d0-0x04d1] has been reserved
> [    0.512044] system 00:01: [io  0x04d6] has been reserved
> [    0.512045] system 00:01: [io  0x0680-0x06ff] has been reserved
> [    0.512046] system 00:01: [io  0x077a] has been reserved
> [    0.512047] system 00:01: [io  0x0c00-0x0c01] has been reserved
> [    0.512047] system 00:01: [io  0x0c14] has been reserved
> [    0.512048] system 00:01: [io  0x0c50-0x0c52] has been reserved
> [    0.512049] system 00:01: [io  0x0c6c] has been reserved
> [    0.512050] system 00:01: [io  0x0c6f] has been reserved
> [    0.512051] system 00:01: [io  0x0cd0-0x0cdb] has been reserved
> [    0.512052] system 00:01: [io  0x0840-0x0847] has been reserved
> [    0.512056] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.512124] system 00:02: [mem 0x000e0000-0x000fffff] could not be reserved
> [    0.512127] system 00:02: Plug and Play ACPI device, IDs PNP0c01 (active)
> [    0.512151] pnp 00:03: Plug and Play ACPI device, IDs HPQ8002 PNP0303 (active)
> [    0.512165] pnp 00:04: Plug and Play ACPI device, IDs SYN308c SYN0100 SYN0002 PNP0f13 (active)
> [    0.512236] system 00:05: [io  0x0200-0x027f] has been reserved
> [    0.512237] system 00:05: [mem 0xfedf1000-0xfedf1fff] has been reserved
> [    0.512240] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.512357] system 00:06: [mem 0xfec00000-0xfec00fff] could not be reserved
> [    0.512358] system 00:06: [mem 0xfee00000-0xfee00fff] has been reserved
> [    0.512359] system 00:06: [mem 0xfec20000-0xfec20fff] has been reserved
> [    0.512362] system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.512892] pnp: PnP ACPI: found 7 devices
> [    0.519456] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> [    0.519537] NET: Registered protocol family 2
> [    0.519779] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes, linear)
> [    0.519978] TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
> [    0.520285] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
> [    0.520359] TCP: Hash tables configured (established 131072 bind 65536)
> [    0.520508] MPTCP token hash table entries: 16384 (order: 6, 393216 bytes, linear)
> [    0.520595] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
> [    0.520655] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, linear)
> [    0.520826] NET: Registered protocol family 1
> [    0.520833] NET: Registered protocol family 44
> [    0.520856] pci 0000:00:01.4: bridge window [io  0x1000-0x0fff] to [bus 02] add_size 1000
> [    0.520858] pci 0000:00:01.4: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 02] add_size 200000 add_align 100000
> [    0.520883] pci 0000:00:01.4: BAR 15: assigned [mem 0xf0a00000-0xf0bfffff 64bit pref]
> [    0.520887] pci 0000:00:01.4: BAR 13: assigned [io  0x1000-0x1fff]
> [    0.520892] pci 0000:00:01.3: PCI bridge to [bus 01]
> [    0.520895] pci 0000:00:01.3:   bridge window [io  0x3000-0x3fff]
> [    0.520899] pci 0000:00:01.3:   bridge window [mem 0xf0900000-0xf09fffff]
> [    0.520906] pci 0000:00:01.4: PCI bridge to [bus 02]
> [    0.520908] pci 0000:00:01.4:   bridge window [io  0x1000-0x1fff]
> [    0.520912] pci 0000:00:01.4:   bridge window [mem 0xf0800000-0xf08fffff]
> [    0.520915] pci 0000:00:01.4:   bridge window [mem 0xf0a00000-0xf0bfffff 64bit pref]
> [    0.520921] pci 0000:00:01.7: PCI bridge to [bus 03]
> [    0.520925] pci 0000:00:01.7:   bridge window [mem 0xf0700000-0xf07fffff]
> [    0.520934] pci 0000:00:08.1: PCI bridge to [bus 04]
> [    0.520941] pci 0000:00:08.1:   bridge window [io  0x2000-0x2fff]
> [    0.520944] pci 0000:00:08.1:   bridge window [mem 0xf0200000-0xf06fffff]
> [    0.520947] pci 0000:00:08.1:   bridge window [mem 0xe0000000-0xf01fffff 64bit pref]
> [    0.520954] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> [    0.520955] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
> [    0.520956] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
> [    0.520957] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff window]
> [    0.520958] pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff window]
> [    0.520959] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff window]
> [    0.520960] pci_bus 0000:00: resource 10 [mem 0x000cc000-0x000cffff window]
> [    0.520960] pci_bus 0000:00: resource 11 [mem 0x000d0000-0x000d3fff window]
> [    0.520961] pci_bus 0000:00: resource 12 [mem 0x000d4000-0x000d7fff window]
> [    0.520962] pci_bus 0000:00: resource 13 [mem 0x000d8000-0x000dbfff window]
> [    0.520962] pci_bus 0000:00: resource 14 [mem 0x000dc000-0x000dffff window]
> [    0.520963] pci_bus 0000:00: resource 15 [mem 0x000e0000-0x000e3fff window]
> [    0.520964] pci_bus 0000:00: resource 16 [mem 0x000e4000-0x000e7fff window]
> [    0.520964] pci_bus 0000:00: resource 17 [mem 0x000e8000-0x000ebfff window]
> [    0.520965] pci_bus 0000:00: resource 18 [mem 0x000ec000-0x000effff window]
> [    0.520966] pci_bus 0000:00: resource 19 [mem 0xe0000000-0xf7ffffff window]
> [    0.520967] pci_bus 0000:00: resource 20 [mem 0xfc000000-0xfeafffff window]
> [    0.520968] pci_bus 0000:01: resource 0 [io  0x3000-0x3fff]
> [    0.520968] pci_bus 0000:01: resource 1 [mem 0xf0900000-0xf09fffff]
> [    0.520970] pci_bus 0000:02: resource 0 [io  0x1000-0x1fff]
> [    0.520970] pci_bus 0000:02: resource 1 [mem 0xf0800000-0xf08fffff]
> [    0.520971] pci_bus 0000:02: resource 2 [mem 0xf0a00000-0xf0bfffff 64bit pref]
> [    0.520972] pci_bus 0000:03: resource 1 [mem 0xf0700000-0xf07fffff]
> [    0.520973] pci_bus 0000:04: resource 0 [io  0x2000-0x2fff]
> [    0.520974] pci_bus 0000:04: resource 1 [mem 0xf0200000-0xf06fffff]
> [    0.520975] pci_bus 0000:04: resource 2 [mem 0xe0000000-0xf01fffff 64bit pref]
> [    0.521445] pci 0000:04:00.1: D0 power state depends on 0000:04:00.0
> [    0.521473] pci 0000:04:00.3: extending delay after power-on from D3hot to 20 msec
> [    0.521719] pci 0000:04:00.4: extending delay after power-on from D3hot to 20 msec
> [    0.521834] PCI: CLS 0 bytes, default 64
> [    0.521933] Trying to unpack rootfs image as initramfs...
> [    0.896373] Freeing initrd memory: 38236K
> [    0.896419] pci 0000:00:00.2: AMD-Vi: Unable to read/write to IOMMU perf counter.
> [    0.896632] pci 0000:00:00.2: can't derive routing for PCI INT A
> [    0.896633] pci 0000:00:00.2: PCI INT A: not connected
> [    0.896699] pci 0000:00:01.0: Adding to iommu group 0
> [    0.896710] pci 0000:00:01.3: Adding to iommu group 1
> [    0.896721] pci 0000:00:01.4: Adding to iommu group 2
> [    0.896730] pci 0000:00:01.7: Adding to iommu group 3
> [    0.896745] pci 0000:00:08.0: Adding to iommu group 4
> [    0.896756] pci 0000:00:08.1: Adding to iommu group 5
> [    0.896776] pci 0000:00:14.0: Adding to iommu group 6
> [    0.896784] pci 0000:00:14.3: Adding to iommu group 6
> [    0.896815] pci 0000:00:18.0: Adding to iommu group 7
> [    0.896823] pci 0000:00:18.1: Adding to iommu group 7
> [    0.896831] pci 0000:00:18.2: Adding to iommu group 7
> [    0.896840] pci 0000:00:18.3: Adding to iommu group 7
> [    0.896848] pci 0000:00:18.4: Adding to iommu group 7
> [    0.896856] pci 0000:00:18.5: Adding to iommu group 7
> [    0.896864] pci 0000:00:18.6: Adding to iommu group 7
> [    0.896872] pci 0000:00:18.7: Adding to iommu group 7
> [    0.896898] pci 0000:01:00.0: Adding to iommu group 8
> [    0.896908] pci 0000:01:00.1: Adding to iommu group 8
> [    0.896918] pci 0000:01:00.2: Adding to iommu group 8
> [    0.896928] pci 0000:01:00.3: Adding to iommu group 8
> [    0.896937] pci 0000:01:00.4: Adding to iommu group 8
> [    0.896948] pci 0000:02:00.0: Adding to iommu group 9
> [    0.896960] pci 0000:03:00.0: Adding to iommu group 10
> [    0.896989] pci 0000:04:00.0: Adding to iommu group 11
> [    0.897020] pci 0000:04:00.1: Adding to iommu group 12
> [    0.897038] pci 0000:04:00.2: Adding to iommu group 12
> [    0.897051] pci 0000:04:00.3: Adding to iommu group 12
> [    0.897065] pci 0000:04:00.4: Adding to iommu group 12
> [    0.897078] pci 0000:04:00.5: Adding to iommu group 12
> [    0.897091] pci 0000:04:00.6: Adding to iommu group 12
> [    0.897104] pci 0000:04:00.7: Adding to iommu group 12
> [    0.900145] pci 0000:00:00.2: AMD-Vi: Found IOMMU cap 0x40
> [    0.900150] pci 0000:00:00.2: AMD-Vi: Extended features (0x4f77ef22294ada):
> [    0.900152]  PPR NX GT IA GA PC GA_vAPIC
> [    0.900155] AMD-Vi: Interrupt remapping enabled
> [    0.900156] AMD-Vi: Virtual APIC enabled
> [    0.900477] AMD-Vi: Lazy IO/TLB flushing enabled
> [    0.901279] amd_uncore: 4  amd_df counters detected
> [    0.901284] amd_uncore: 6  amd_l3 counters detected
> [    0.903211] check: Scanning for low memory corruption every 60 seconds
> [    0.903650] Initialise system trusted keyrings
> [    0.903789] Key type blacklist registered
> [    0.903913] workingset: timestamp_bits=41 max_order=22 bucket_order=0
> [    0.904766] zbud: loaded
> [    0.912820] Key type asymmetric registered
> [    0.912822] Asymmetric key parser 'x509' registered
> [    0.912829] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
> [    0.912926] io scheduler mq-deadline registered
> [    0.912928] io scheduler kyber registered
> [    0.912943] io scheduler bfq registered
> [    0.913380] atomic64_test: passed for x86-64 platform with CX8 and with SSE
> [    0.913632] pcieport 0000:00:01.3: PME: Signaling with IRQ 26
> [    0.913711] pcieport 0000:00:01.3: AER: enabled with IRQ 26
> [    0.913878] pcieport 0000:00:01.4: PME: Signaling with IRQ 27
> [    0.913948] pcieport 0000:00:01.4: AER: enabled with IRQ 27
> [    0.913969] pcieport 0000:00:01.4: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise- Interlock- NoCompl+ IbPresDis- LLActRep+
> [    0.914192] pcieport 0000:00:01.7: PME: Signaling with IRQ 28
> [    0.914283] pcieport 0000:00:01.7: AER: enabled with IRQ 28
> [    0.914434] pcieport 0000:00:08.1: PME: Signaling with IRQ 29
> [    0.914544] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> [    0.914570] efifb: probing for efifb
> [    0.914603] efifb: showing boot graphics
> [    0.917151] efifb: framebuffer at 0xe0000000, using 8100k, total 8100k
> [    0.917152] efifb: mode is 1920x1080x32, linelength=7680, pages=1
> [    0.917152] efifb: scrolling: redraw
> [    0.917154] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
> [    0.917242] fbcon: Deferring console take-over
> [    0.917243] fb0: EFI VGA frame buffer device
> [    0.918220] ACPI: AC Adapter [AC] (off-line)
> [    0.918262] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
> [    0.918281] ACPI: Power Button [PWRB]
> [    0.918303] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input1
> [    0.918319] ACPI: Sleep Button [SLPB]
> [    0.918339] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input2
> [    0.918350] ACPI: Lid Switch [LID]
> [    0.918371] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
> [    0.919327] ACPI: Power Button [PWRF]
> [    0.919414] Monitor-Mwait will be used to enter C-1 state
> [    0.919422] ACPI: \_PR_.C000: Found 2 idle states
> [    0.919793] ACPI: \_PR_.C001: Found 2 idle states
> [    0.919972] ACPI: \_PR_.C002: Found 2 idle states
> [    0.920169] ACPI: \_PR_.C003: Found 2 idle states
> [    0.920516] ACPI: \_PR_.C004: Found 2 idle states
> [    0.920761] ACPI: \_PR_.C005: Found 2 idle states
> [    0.921008] ACPI: \_PR_.C006: Found 2 idle states
> [    0.921241] ACPI: \_PR_.C007: Found 2 idle states
> [    0.921554] thermal LNXTHERM:00: registered as thermal_zone0
> [    0.921556] ACPI: Thermal Zone [HEPZ] (30 C)
> [    0.926443] thermal LNXTHERM:01: registered as thermal_zone1
> [    0.926445] ACPI: Thermal Zone [CPUZ] (46 C)
> [    0.928539] thermal LNXTHERM:02: registered as thermal_zone2
> [    0.928541] ACPI: Thermal Zone [GFXZ] (0 C)
> [    0.933407] thermal LNXTHERM:03: registered as thermal_zone3
> [    0.933409] ACPI: Thermal Zone [EXTZ] (40 C)
> [    0.936233] thermal LNXTHERM:04: registered as thermal_zone4
> [    0.936235] ACPI: Thermal Zone [LOCZ] (41 C)
> [    0.940136] thermal LNXTHERM:05: registered as thermal_zone5
> [    0.940139] ACPI: Thermal Zone [BATZ] (32 C)
> [    0.940190] ACPI BIOS Error (bug): AE_AML_PACKAGE_LIMIT, Index (0x000000005) is beyond end of object (length 0x5) (20200925/exoparg2-393)
> [    0.940204] ACPI Error: Aborting method \_TZ.GETP due to previous error (AE_AML_PACKAGE_LIMIT) (20200925/psparse-529)
> [    0.940212] ACPI Error: Aborting method \_TZ.CHGZ._CRT due to previous error (AE_AML_PACKAGE_LIMIT) (20200925/psparse-529)
> [    0.940862] ACPI BIOS Error (bug): AE_AML_PACKAGE_LIMIT, Index (0x000000005) is beyond end of object (length 0x5) (20200925/exoparg2-393)
> [    0.940871] ACPI Error: Aborting method \_TZ.GTTP due to previous error (AE_AML_PACKAGE_LIMIT) (20200925/psparse-529)
> [    0.940878] ACPI Error: Aborting method \_TZ.CHGZ._TMP due to previous error (AE_AML_PACKAGE_LIMIT) (20200925/psparse-529)
> [    0.940920] ACPI BIOS Error (bug): AE_AML_PACKAGE_LIMIT, Index (0x000000005) is beyond end of object (length 0x5) (20200925/exoparg2-393)
> [    0.940931] ACPI Error: Aborting method \_TZ.GETP due to previous error (AE_AML_PACKAGE_LIMIT) (20200925/psparse-529)
> [    0.940937] ACPI Error: Aborting method \_TZ.CHGZ._CRT due to previous error (AE_AML_PACKAGE_LIMIT) (20200925/psparse-529)
> [    0.940948] [Firmware Bug]: No valid trip found
> [    0.941185] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
> [    0.943597] 0000:01:00.1: ttyS4 at I/O 0x3200 (irq = 30, base_baud = 115200) is a 16550A
> [    0.944154] 0000:01:00.2: ttyS5 at I/O 0x3100 (irq = 31, base_baud = 115200) is a 16550A
> [    0.944457] Non-volatile memory driver v1.3
> [    0.944459] AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
> [    0.945839] nvme nvme0: pci function 0000:03:00.0
> [    0.945924] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    0.945938] ehci-pci: EHCI PCI platform driver
> [    0.946202] ehci-pci 0000:01:00.4: EHCI Host Controller
> [    0.946209] ehci-pci 0000:01:00.4: new USB bus registered, assigned bus number 1
> [    0.946314] ehci-pci 0000:01:00.4: irq 34, io mem 0xf0918000
> [    0.953803] ehci-pci 0000:01:00.4: USB 0.0 started, EHCI 1.00
> [    0.953854] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.10
> [    0.953856] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    0.953858] usb usb1: Product: EHCI Host Controller
> [    0.953859] usb usb1: Manufacturer: Linux 5.10.5-zen1-1-zen ehci_hcd
> [    0.953860] usb usb1: SerialNumber: 0000:01:00.4
> [    0.953973] hub 1-0:1.0: USB hub found
> [    0.953978] hub 1-0:1.0: 1 port detected
> [    0.954065] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [    0.954069] ohci-pci: OHCI PCI platform driver
> [    0.954077] uhci_hcd: USB Universal Host Controller Interface driver
> [    0.954121] usbcore: registered new interface driver usbserial_generic
> [    0.954125] usbserial: USB Serial support registered for generic
> [    0.954161] i8042: PNP: PS/2 Controller [PNP0303:KBC0,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
> [    0.955027] i8042: Detected active multiplexing controller, rev 1.1
> [    0.955342] battery: ACPI: Battery Slot [BAT0] (battery present)
> [    0.955505] serio: i8042 KBD port at 0x60,0x64 irq 1
> [    0.955539] serio: i8042 AUX0 port at 0x60,0x64 irq 12
> [    0.955557] serio: i8042 AUX1 port at 0x60,0x64 irq 12
> [    0.955573] serio: i8042 AUX2 port at 0x60,0x64 irq 12
> [    0.955585] serio: i8042 AUX3 port at 0x60,0x64 irq 12
> [    0.955813] rtc_cmos 00:00: RTC can wake from S4
> [    0.956040] rtc_cmos 00:00: registered as rtc0
> [    0.956099] rtc_cmos 00:00: setting system clock to 2021-01-11T07:09:54 UTC (1610348994)
> [    0.956118] rtc_cmos 00:00: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
> [    0.956272] ledtrig-cpu: registered to indicate activity on CPUs
> [    0.967690] random: fast init done
> [    0.970064] nvme nvme0: 16/0/0 default/read/poll queues
> [    0.981249] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input4
> [    0.993509]  nvme0n1: p1 p2 p3 p4 p5 p6
> [    1.010305] pstore: Registered efi as persistent store backend
> [    1.010335] hid: raw HID events driver (C) Jiri Kosina
> [    1.010608] drop_monitor: Initializing network drop monitor service
> [    1.010716] Initializing XFRM netlink socket
> [    1.010903] NET: Registered protocol family 10
> [    1.017992] Segment Routing with IPv6
> [    1.017995] RPL Segment Routing with IPv6
> [    1.018045] NET: Registered protocol family 17
> [    1.019238] microcode: CPU0: patch_level=0x08108109
> [    1.019250] microcode: CPU1: patch_level=0x08108109
> [    1.019255] microcode: CPU2: patch_level=0x08108109
> [    1.019265] microcode: CPU3: patch_level=0x08108109
> [    1.019291] microcode: CPU4: patch_level=0x08108109
> [    1.019303] microcode: CPU5: patch_level=0x08108109
> [    1.019332] microcode: CPU6: patch_level=0x08108109
> [    1.019343] microcode: CPU7: patch_level=0x08108109
> [    1.019348] microcode: Microcode Update Driver: v2.2.
> [    1.019359] IPI shorthand broadcast: enabled
> [    1.019386] sched_clock: Marking stable (848674046, 170430593)->(1032854121, -13749482)
> [    1.019599] registered taskstats version 1
> [    1.019621] Loading compiled-in X.509 certificates
> [    1.023342] Loaded X.509 cert 'Build time autogenerated kernel key: a4ba5de36a3939e2a028724bc173b6cf0c4adb93'
> [    1.023680] zswap: loaded using pool lz4/z3fold
> [    1.023993] Key type ._fscrypt registered
> [    1.023995] Key type .fscrypt registered
> [    1.023996] Key type fscrypt-provisioning registered
> [    1.024372] pstore: Using crash dump compression: zstd
> [    1.024966] PM:   Magic number: 5:152:167
> [    1.025103] acpi PNP0000:00: hash matches
> [    1.025106] acpi device:30: hash matches
> [    1.025352] RAS: Correctable Errors collector initialized.
> [    1.026768] Freeing unused decrypted memory: 2036K
> [    1.027209] Freeing unused kernel image (initmem) memory: 1720K
> [    1.036275] Write protecting the kernel read-only data: 28672k
> [    1.037183] Freeing unused kernel image (text/rodata gap) memory: 2036K
> [    1.037665] Freeing unused kernel image (rodata/data gap) memory: 1516K
> [    1.087740] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> [    1.087750] rodata_test: all tests were successful
> [    1.087758] CFS CPU scheduler.
> [    1.087759] Run /init as init process
> [    1.087762]   with arguments:
> [    1.087763]     /init
> [    1.087764]   with environment:
> [    1.087765]     HOME=/
> [    1.087765]     TERM=linux
> [    1.199770] random: crng init done
> [    1.199787] systemd[1]: Successfully credited entropy passed from boot loader.
> [    1.201215] systemd[1]: systemd 247.2-1-arch running in system mode. (+PAM +AUDIT -SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
> [    1.214391] systemd[1]: Detected architecture x86-64.
> [    1.214397] systemd[1]: Running in initial RAM disk.
> [    1.225513] systemd[1]: Set hostname to <hp-laptop>.
> [    1.311689] systemd[1]: Queued start job for default target Initrd Default Target.
> [    1.319380] systemd[1]: Created slice system-systemd\x2dcryptsetup.slice.
> [    1.319768] systemd[1]: Created slice system-systemd\x2dfsck.slice.
> [    1.319868] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
> [    1.319945] systemd[1]: Reached target Local File Systems.
> [    1.319983] systemd[1]: Reached target Paths.
> [    1.320032] systemd[1]: Reached target Slices.
> [    1.320101] systemd[1]: Reached target Swap.
> [    1.320140] systemd[1]: Reached target Timers.
> [    1.320333] systemd[1]: Listening on Journal Audit Socket.
> [    1.320451] systemd[1]: Listening on Journal Socket (/dev/log).
> [    1.320598] systemd[1]: Listening on Journal Socket.
> [    1.320718] systemd[1]: Listening on udev Control Socket.
> [    1.320843] systemd[1]: Listening on udev Kernel Socket.
> [    1.320883] systemd[1]: Reached target Sockets.
> [    1.321908] systemd[1]: Starting Create list of static device nodes for the current kernel...
> [    1.323740] systemd[1]: Starting Journal Service...
> [    1.324918] systemd[1]: Starting Load Kernel Modules...
> [    1.326020] systemd[1]: Starting Setup Virtual Console...
> [    1.327017] systemd[1]: Finished Create list of static device nodes for the current kernel.
> [    1.328501] systemd[1]: Starting Create Static Device Nodes in /dev...
> [    1.331785] ashmem_linux: module is from the staging directory, the quality is unknown, you have been warned.
> [    1.332318] ashmem: initialized
> [    1.334717] systemd[1]: Finished Create Static Device Nodes in /dev.
> [    1.337325] systemd[1]: Finished Setup Virtual Console.
> [    1.338721] systemd[1]: Starting dracut ask for additional cmdline parameters...
> [    1.349598] systemd[1]: Finished Load Kernel Modules.
> [    1.350795] systemd[1]: Starting Apply Kernel Variables...
> [    1.357232] systemd[1]: Finished dracut ask for additional cmdline parameters.
> [    1.357359] audit: type=1130 audit(1610348994.899:2): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dracut-cmdline-ask comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    1.358432] systemd[1]: Starting dracut cmdline hook...
> [    1.358928] systemd[1]: Finished Apply Kernel Variables.
> [    1.359042] audit: type=1130 audit(1610348994.901:3): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-sysctl comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    1.400778] systemd[1]: Started Journal Service.
> [    1.400920] audit: type=1130 audit(1610348994.942:4): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    1.410424] audit: type=1130 audit(1610348994.952:5): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-tmpfiles-setup comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    1.474882] audit: type=1130 audit(1610348995.016:6): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dracut-cmdline comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    1.500106] device-mapper: uevent: version 1.0.3
> [    1.500246] device-mapper: ioctl: 4.43.0-ioctl (2020-10-01) initialised: dm-devel@redhat.com
> [    1.529121] Linux agpgart interface v0.103
> [    1.904312] input: PS/2 Generic Mouse as /devices/platform/i8042/serio2/input/input10
> [    1.939998] tsc: Refined TSC clocksource calibration: 2295.678 MHz
> [    1.940019] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x211742346a2, max_idle_ns: 440795232653 ns
> [    1.940259] clocksource: Switched to clocksource tsc
> [    2.004261] [drm] amdgpu kernel modesetting enabled.
> [    2.004452] amdgpu: Topology: Add APU node [0x0:0x0]
> [    2.004571] checking generic (e0000000 7e9000) vs hw (e0000000 10000000)
> [    2.004572] fb0: switching to amdgpudrmfb from EFI VGA
> [    2.004657] amdgpu 0000:04:00.0: vgaarb: deactivate vga console
> [    2.004919] [drm] initializing kernel modesetting (RAVEN 0x1002:0x15D8 0x103C:0x8589 0xD1).
> [    2.004923] amdgpu 0000:04:00.0: amdgpu: Trusted Memory Zone (TMZ) feature disabled as experimental (default)
> [    2.006029] [drm] register mmio base: 0xF0600000
> [    2.006030] [drm] register mmio size: 524288
> [    2.006054] [drm] add ip block number 0 <soc15_common>
> [    2.006055] [drm] add ip block number 1 <gmc_v9_0>
> [    2.006056] [drm] add ip block number 2 <vega10_ih>
> [    2.006058] [drm] add ip block number 3 <psp>
> [    2.006059] [drm] add ip block number 4 <gfx_v9_0>
> [    2.006060] [drm] add ip block number 5 <sdma_v4_0>
> [    2.006061] [drm] add ip block number 6 <powerplay>
> [    2.006062] [drm] add ip block number 7 <dm>
> [    2.006064] [drm] add ip block number 8 <vcn_v1_0>
> [    2.006164] amdgpu 0000:04:00.0: amdgpu: Fetched VBIOS from VFCT
> [    2.006167] amdgpu: ATOM BIOS: SWBRT48929.001
> [    2.006218] [drm] VCN decode is enabled in VM mode
> [    2.006218] [drm] VCN encode is enabled in VM mode
> [    2.006219] [drm] JPEG decode is enabled in VM mode
> [    2.006262] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
> [    2.006275] amdgpu 0000:04:00.0: amdgpu: VRAM: 2048M 0x000000F400000000 - 0x000000F47FFFFFFF (2048M used)
> [    2.006277] amdgpu 0000:04:00.0: amdgpu: GART: 1024M 0x0000000000000000 - 0x000000003FFFFFFF
> [    2.006279] amdgpu 0000:04:00.0: amdgpu: AGP: 267419648M 0x000000F800000000 - 0x0000FFFFFFFFFFFF
> [    2.006287] [drm] Detected VRAM RAM=2048M, BAR=2048M
> [    2.006288] [drm] RAM width 64bits DDR4
> [    2.006418] [TTM] Zone  kernel: Available graphics memory: 7160024 KiB
> [    2.006419] [TTM] Zone   dma32: Available graphics memory: 2097152 KiB
> [    2.006420] [TTM] Initializing pool allocator
> [    2.006425] [TTM] Initializing DMA pool allocator
> [    2.006520] [drm] amdgpu: 2048M of VRAM memory ready
> [    2.006524] [drm] amdgpu: 3072M of GTT memory ready.
> [    2.006527] [drm] GART: num cpu pages 262144, num gpu pages 262144
> [    2.006826] [drm] PCIE GART of 1024M enabled (table at 0x000000F400900000).
> [    2.009276] amdgpu: hwmgr_sw_init smu backed is smu10_smu
> [    2.009494] [drm] Found VCN firmware Version ENC: 1.12 DEC: 2 VEP: 0 Revision: 1
> [    2.009498] [drm] PSP loading VCN firmware
> [    2.031228] [drm] reserve 0x400000 from 0xf47fc00000 for PSP TMR
> [    2.154408] amdgpu 0000:04:00.0: amdgpu: RAS: optional ras ta ucode is not available
> [    2.175391] amdgpu 0000:04:00.0: amdgpu: RAP: optional rap ta ucode is not available
> [    2.177576] [drm] kiq ring mec 2 pipe 1 q 0
> [    2.179062] [drm] DM_PPLIB: values for F clock
> [    2.179063] [drm] DM_PPLIB:	 400000 in kHz, 2749 in mV
> [    2.179064] [drm] DM_PPLIB:	 933000 in kHz, 3224 in mV
> [    2.179064] [drm] DM_PPLIB:	 1067000 in kHz, 3924 in mV
> [    2.179065] [drm] DM_PPLIB:	 1200000 in kHz, 4074 in mV
> [    2.179067] [drm] DM_PPLIB: values for DCF clock
> [    2.179067] [drm] DM_PPLIB:	 300000 in kHz, 2749 in mV
> [    2.179068] [drm] DM_PPLIB:	 600000 in kHz, 3224 in mV
> [    2.179069] [drm] DM_PPLIB:	 626000 in kHz, 3924 in mV
> [    2.179069] [drm] DM_PPLIB:	 654000 in kHz, 4074 in mV
> [    2.179482] [drm] Display Core initialized with v3.2.104!
> [    2.249372] [drm] VCN decode and encode initialized successfully(under SPG Mode).
> [    2.252091] kfd kfd: Allocated 3969056 bytes on gart
> [    2.253541] amdgpu: Topology: Add APU node [0x15d8:0x1002]
> [    2.253544] kfd kfd: added device 1002:15d8
> [    2.253548] amdgpu 0000:04:00.0: amdgpu: SE 1, SH per SE 1, CU per SH 11, active_cu_number 10
> [    2.255804] [drm] fb mappable at 0x60BCA000
> [    2.255806] [drm] vram apper at 0x60000000
> [    2.255806] [drm] size 8294400
> [    2.255807] [drm] fb depth is 24
> [    2.255808] [drm]    pitch is 7680
> [    2.255925] fbcon: amdgpudrmfb (fb0) is primary device
> [    2.255927] fbcon: Deferring console take-over
> [    2.255929] amdgpu 0000:04:00.0: [drm] fb0: amdgpudrmfb frame buffer device
> [    2.264561] amdgpu 0000:04:00.0: amdgpu: ring gfx uses VM inv eng 0 on hub 0
> [    2.264567] amdgpu 0000:04:00.0: amdgpu: ring comp_1.0.0 uses VM inv eng 1 on hub 0
> [    2.264570] amdgpu 0000:04:00.0: amdgpu: ring comp_1.1.0 uses VM inv eng 4 on hub 0
> [    2.264572] amdgpu 0000:04:00.0: amdgpu: ring comp_1.2.0 uses VM inv eng 5 on hub 0
> [    2.264575] amdgpu 0000:04:00.0: amdgpu: ring comp_1.3.0 uses VM inv eng 6 on hub 0
> [    2.264577] amdgpu 0000:04:00.0: amdgpu: ring comp_1.0.1 uses VM inv eng 7 on hub 0
> [    2.264579] amdgpu 0000:04:00.0: amdgpu: ring comp_1.1.1 uses VM inv eng 8 on hub 0
> [    2.264581] amdgpu 0000:04:00.0: amdgpu: ring comp_1.2.1 uses VM inv eng 9 on hub 0
> [    2.264583] amdgpu 0000:04:00.0: amdgpu: ring comp_1.3.1 uses VM inv eng 10 on hub 0
> [    2.264586] amdgpu 0000:04:00.0: amdgpu: ring kiq_2.1.0 uses VM inv eng 11 on hub 0
> [    2.264589] amdgpu 0000:04:00.0: amdgpu: ring sdma0 uses VM inv eng 0 on hub 1
> [    2.264591] amdgpu 0000:04:00.0: amdgpu: ring vcn_dec uses VM inv eng 1 on hub 1
> [    2.264594] amdgpu 0000:04:00.0: amdgpu: ring vcn_enc0 uses VM inv eng 4 on hub 1
> [    2.264596] amdgpu 0000:04:00.0: amdgpu: ring vcn_enc1 uses VM inv eng 5 on hub 1
> [    2.264599] amdgpu 0000:04:00.0: amdgpu: ring jpeg_dec uses VM inv eng 6 on hub 1
> [    2.280336] [drm] Initialized amdgpu 3.40.0 20150101 for 0000:04:00.0 on minor 0
> [    2.294525] audit: type=1130 audit(1610348995.837:7): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dracut-pre-udev comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    2.296024] audit: type=1334 audit(1610348995.839:8): prog-id=5 op=LOAD
> [    2.296104] audit: type=1334 audit(1610348995.839:9): prog-id=6 op=LOAD
> [    2.331068] audit: type=1130 audit(1610348995.873:10): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-udevd comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [    2.432331] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
> [    2.433069] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:09/LNXVIDEO:00/input/input12
> [    2.451852] acpi PNP0C14:01: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
> [    2.476330] xhci_hcd 0000:04:00.3: xHCI Host Controller
> [    2.476348] xhci_hcd 0000:04:00.3: new USB bus registered, assigned bus number 2
> [    2.476568] xhci_hcd 0000:04:00.3: hcc params 0x0270ffe5 hci version 0x110 quirks 0x0000000840000410
> [    2.478932] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.10
> [    2.478936] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    2.478939] usb usb2: Product: xHCI Host Controller
> [    2.478941] usb usb2: Manufacturer: Linux 5.10.5-zen1-1-zen xhci-hcd
> [    2.478942] usb usb2: SerialNumber: 0000:04:00.3
> [    2.480666] hub 2-0:1.0: USB hub found
> [    2.480697] hub 2-0:1.0: 4 ports detected
> [    2.481767] ccp 0000:04:00.2: enabling device (0000 -> 0002)
> [    2.482788] xhci_hcd 0000:04:00.3: xHCI Host Controller
> [    2.482802] xhci_hcd 0000:04:00.3: new USB bus registered, assigned bus number 3
> [    2.482810] xhci_hcd 0000:04:00.3: Host supports USB 3.1 Enhanced SuperSpeed
> [    2.482859] usb usb3: We don't know the algorithms for LPM for this host, disabling LPM.
> [    2.482928] usb usb3: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.10
> [    2.482929] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    2.482931] usb usb3: Product: xHCI Host Controller
> [    2.482933] usb usb3: Manufacturer: Linux 5.10.5-zen1-1-zen xhci-hcd
> [    2.482934] usb usb3: SerialNumber: 0000:04:00.3
> [    2.486443] hub 3-0:1.0: USB hub found
> [    2.486477] hub 3-0:1.0: 4 ports detected
> [    2.490837] xhci_hcd 0000:04:00.4: xHCI Host Controller
> [    2.490850] xhci_hcd 0000:04:00.4: new USB bus registered, assigned bus number 4
> [    2.491097] xhci_hcd 0000:04:00.4: hcc params 0x0260ffe5 hci version 0x110 quirks 0x0000000840000410
> [    2.493296] r8169 0000:01:00.0: can't disable ASPM; OS doesn't have ASPM control
> [    2.493353] usb usb4: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.10
> [    2.493357] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    2.493361] usb usb4: Product: xHCI Host Controller
> [    2.493363] usb usb4: Manufacturer: Linux 5.10.5-zen1-1-zen xhci-hcd
> [    2.493365] usb usb4: SerialNumber: 0000:04:00.4
> [    2.493940] hub 4-0:1.0: USB hub found
> [    2.493961] hub 4-0:1.0: 2 ports detected
> [    2.497268] ccp 0000:04:00.2: ccp enabled
> [    2.497291] ccp 0000:04:00.2: psp: unable to access the device: you might be running a broken BIOS.
> [    2.501398] xhci_hcd 0000:04:00.4: xHCI Host Controller
> [    2.501410] xhci_hcd 0000:04:00.4: new USB bus registered, assigned bus number 5
> [    2.501418] xhci_hcd 0000:04:00.4: Host supports USB 3.1 Enhanced SuperSpeed
> [    2.501484] usb usb5: We don't know the algorithms for LPM for this host, disabling LPM.
> [    2.501527] usb usb5: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.10
> [    2.501529] usb usb5: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    2.501532] usb usb5: Product: xHCI Host Controller
> [    2.501535] usb usb5: Manufacturer: Linux 5.10.5-zen1-1-zen xhci-hcd
> [    2.501536] usb usb5: SerialNumber: 0000:04:00.4
> [    2.501751] hub 5-0:1.0: USB hub found
> [    2.501766] hub 5-0:1.0: 1 port detected
> [    2.506173] libphy: r8169: probed
> [    2.506510] r8169 0000:01:00.0 eth0: RTL8168ep/8111ep, b0:5c:da:ac:bb:8c, XID 502, IRQ 74
> [    2.506515] r8169 0000:01:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksumming: ko]
> [    2.515055] cryptd: max_cpu_qlen set to 1000
> [    2.537180] AVX2 version of gcm_enc/dec engaged.
> [    2.537185] AES CTR mode by8 optimization enabled
> [    2.592315] fbcon: Taking over console
> [    2.595804] r8169 0000:01:00.0 enp1s0f0: renamed from eth0
> [    2.606635] Console: switching to colour frame buffer device 240x67
> [    2.673560] psmouse serio3: synaptics: queried max coordinates: x [..5676], y [..4762]
> [    2.703764] psmouse serio3: synaptics: queried min coordinates: x [1262..], y [1124..]
> [    2.703776] psmouse serio3: synaptics: Your touchpad (PNP: SYN308c SYN0100 SYN0002 PNP0f13) says it can support a different bus. If i2c-hid and hid-rmi are not used, you might want to try setting psmouse.synaptics_intertouch to 1 and report this to linux-input@vger.kernel.org.
> [    2.757208] psmouse serio3: synaptics: Touchpad model: 1, fw: 10.16, id: 0x1e2a1, caps: 0xf00123/0x840300/0x12e800/0x500000, board id: 3447, fw id: 2885702
> [    2.797274] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio3/input/input11
> [    2.822542] usb 4-1: new high-speed USB device number 2 using xhci_hcd
> [    2.950457] usb 4-1: New USB device found, idVendor=05e3, idProduct=0610, bcdDevice=60.60
> [    2.950463] usb 4-1: New USB device strings: Mfr=0, Product=1, SerialNumber=0
> [    2.950466] usb 4-1: Product: USB2.0 Hub
> [    3.014446] hub 4-1:1.0: USB hub found
> [    3.014769] hub 4-1:1.0: 4 ports detected
> [    3.196394] usb 4-2: new high-speed USB device number 3 using xhci_hcd
> [    3.401223] usb 4-2: New USB device found, idVendor=04ca, idProduct=7089, bcdDevice= 0.08
> [    3.401229] usb 4-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [    3.401233] usb 4-2: Product: HP HD Camera
> [    3.401235] usb 4-2: Manufacturer: DJFYKA1BIDL3W7
> [    3.401237] usb 4-2: SerialNumber: 01.00.00
> [    3.403007] usb 4-1.2: new full-speed USB device number 4 using xhci_hcd
> [    3.535003] usb 4-1.2: New USB device found, idVendor=8087, idProduct=0029, bcdDevice= 0.01
> [    3.535009] usb 4-1.2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [    3.658376] usb 4-1.3: new full-speed USB device number 5 using xhci_hcd
> [    3.754614] usb 4-1.3: New USB device found, idVendor=06cb, idProduct=00b7, bcdDevice= 1.64
> [    3.754621] usb 4-1.3: New USB device strings: Mfr=0, Product=0, SerialNumber=1
> [    3.754624] usb 4-1.3: SerialNumber: 35df848cb768
> [   10.506869] Key type encrypted registered
> [   10.536402] kauditd_printk_skb: 10 callbacks suppressed
> [   10.536405] audit: type=1130 audit(1610349004.079:21): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-cryptsetup@root comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   10.841248] audit: type=1130 audit(1610349004.384:22): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=dracut-initqueue comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   10.861012] audit: type=1130 audit(1610349004.403:23): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-fsck@dev-mapper-root comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   11.038643] SGI XFS with ACLs, security attributes, realtime, scrub, repair, quota, no debug enabled
> [   11.040095] XFS: attr2 mount option is deprecated.
> [   11.041114] XFS (dm-0): Mounting V5 Filesystem
> [   11.055790] XFS (dm-0): Ending clean mount
> [   11.057475] xfs filesystem being mounted at /sysroot supports timestamps until 2038 (0x7fffffff)
> [   11.071593] audit: type=1334 audit(1610349004.614:24): prog-id=8 op=UNLOAD
> [   11.071600] audit: type=1334 audit(1610349004.614:25): prog-id=7 op=UNLOAD
> [   11.072128] audit: type=1334 audit(1610349004.615:26): prog-id=10 op=UNLOAD
> [   11.072336] audit: type=1334 audit(1610349004.615:27): prog-id=9 op=UNLOAD
> [   11.203672] audit: type=1334 audit(1610349004.746:28): prog-id=11 op=LOAD
> [   11.204000] audit: type=1334 audit(1610349004.747:29): prog-id=12 op=LOAD
> [   11.204809] audit: type=1334 audit(1610349004.747:30): prog-id=13 op=LOAD
> [   11.510664] systemd[1]: systemd 247.2-1-arch running in system mode. (+PAM +AUDIT -SELINUX -IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +ZSTD +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
> [   11.522236] systemd[1]: Detected architecture x86-64.
> [   11.523643] systemd[1]: Set hostname to <hp-laptop>.
> [   11.727022] systemd[1]: initrd-switch-root.service: Succeeded.
> [   11.727400] systemd[1]: Stopped Switch Root.
> [   11.727671] systemd[1]: systemd-journald.service: Scheduled restart job, restart counter is at 1.
> [   11.728084] systemd[1]: Created slice system-getty.slice.
> [   11.728397] systemd[1]: Created slice system-modprobe.slice.
> [   11.728706] systemd[1]: Created slice User and Session Slice.
> [   11.728804] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
> [   11.728869] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
> [   11.729140] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
> [   11.729190] systemd[1]: Reached target Block Device Preparation for /dev/mapper/root.
> [   11.729228] systemd[1]: Reached target Local Encrypted Volumes.
> [   11.729268] systemd[1]: Reached target Login Prompts.
> [   11.729289] systemd[1]: Stopped target Switch Root.
> [   11.729303] systemd[1]: Stopped target Initrd File Systems.
> [   11.729313] systemd[1]: Stopped target Initrd Root File System.
> [   11.729363] systemd[1]: Reached target Paths.
> [   11.729406] systemd[1]: Reached target Remote File Systems.
> [   11.729444] systemd[1]: Reached target Slices.
> [   11.729488] systemd[1]: Reached target Swap.
> [   11.729584] systemd[1]: Listening on Device-mapper event daemon FIFOs.
> [   11.730000] systemd[1]: Listening on LVM2 metadata daemon socket.
> [   11.730304] systemd[1]: Listening on LVM2 poll daemon socket.
> [   11.731934] systemd[1]: Listening on Process Core Dump Socket.
> [   11.732875] systemd[1]: Listening on udev Control Socket.
> [   11.733001] systemd[1]: Listening on udev Kernel Socket.
> [   11.734169] systemd[1]: Mounting Huge Pages File System...
> [   11.735170] systemd[1]: Mounting POSIX Message Queue File System...
> [   11.736263] systemd[1]: Mounting Kernel Debug File System...
> [   11.737471] systemd[1]: Mounting Kernel Trace File System...
> [   11.739054] systemd[1]: Mounting Temporary Directory (/tmp)...
> [   11.740383] systemd[1]: Starting Create list of static device nodes for the current kernel...
> [   11.741546] systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
> [   11.742674] systemd[1]: Starting Load Kernel Module configfs...
> [   11.744163] systemd[1]: Starting Load Kernel Module drm...
> [   11.746063] systemd[1]: Starting Load Kernel Module fuse...
> [   11.746655] systemd[1]: Condition check resulted in Set Up Additional Binary Formats being skipped.
> [   11.746955] systemd[1]: systemd-fsck@dev-mapper-root.service: Succeeded.
> [   11.747583] systemd[1]: Stopped File System Check on /dev/mapper/root.
> [   11.747750] systemd[1]: Condition check resulted in File System Check on Root Device being skipped.
> [   11.747820] systemd[1]: Stopped Journal Service.
> [   11.750225] systemd[1]: Starting Journal Service...
> [   11.752184] systemd[1]: Starting Load Kernel Modules...
> [   11.753898] systemd[1]: Starting Remount Root and Kernel File Systems...
> [   11.754055] systemd[1]: Condition check resulted in Repartition Root Disk being skipped.
> [   11.755764] systemd[1]: Starting Coldplug All udev Devices...
> [   11.758463] systemd[1]: sysroot.mount: Succeeded.
> [   11.759687] systemd[1]: Mounted Huge Pages File System.
> [   11.759868] systemd[1]: Mounted POSIX Message Queue File System.
> [   11.760072] systemd[1]: Mounted Kernel Debug File System.
> [   11.760213] systemd[1]: Mounted Kernel Trace File System.
> [   11.760335] systemd[1]: Mounted Temporary Directory (/tmp).
> [   11.761142] systemd[1]: Finished Create list of static device nodes for the current kernel.
> [   11.761568] systemd[1]: modprobe@configfs.service: Succeeded.
> [   11.762207] systemd[1]: Finished Load Kernel Module configfs.
> [   11.762581] systemd[1]: modprobe@drm.service: Succeeded.
> [   11.763124] systemd[1]: Finished Load Kernel Module drm.
> [   11.763866] systemd[1]: Finished Load Kernel Modules.
> [   11.764166] fuse: init (API version 7.32)
> [   11.765182] XFS: attr2 mount option is deprecated.
> [   11.766116] systemd[1]: Mounting Kernel Configuration File System...
> [   11.767625] systemd[1]: Starting Apply Kernel Variables...
> [   11.768177] systemd[1]: modprobe@fuse.service: Succeeded.
> [   11.768711] systemd[1]: Finished Load Kernel Module fuse.
> [   11.768962] xfs filesystem being remounted at / supports timestamps until 2038 (0x7fffffff)
> [   11.772163] systemd[1]: Finished Remount Root and Kernel File Systems.
> [   11.772439] systemd[1]: Mounted Kernel Configuration File System.
> [   11.774594] systemd[1]: Mounting FUSE Control File System...
> [   11.774697] systemd[1]: Condition check resulted in First Boot Wizard being skipped.
> [   11.775253] systemd[1]: Condition check resulted in Rebuild Hardware Database being skipped.
> [   11.777022] systemd[1]: Starting Load/Save Random Seed...
> [   11.778430] systemd[1]: Starting Create System Users...
> [   11.780783] systemd[1]: Finished Apply Kernel Variables.
> [   11.781128] systemd[1]: Mounted FUSE Control File System.
> [   11.788834] systemd[1]: Finished Load/Save Random Seed.
> [   11.789066] systemd[1]: Condition check resulted in First Boot Complete being skipped.
> [   11.789989] systemd[1]: Started Journal Service.
> [   11.971535] acpi_cpufreq: overriding BIOS provided _PSD data
> [   11.977393] i2c_amd_mp2 0000:04:00.7: enabling device (0000 -> 0002)
> [   11.977799] i2c_amd_mp2 0000:04:00.7: MP2 device registered.
> [   11.987047] input: HP Wireless hotkeys as /devices/virtual/input/input14
> [   11.990156] tpm_tis IFX0785:00: 2.0 TPM (device-id 0x1B, rev-id 22)
> [   11.995269] i2c_hid i2c-SYNA308C:00: supply vdd not found, using dummy regulator
> [   11.995391] i2c_hid i2c-SYNA308C:00: supply vddl not found, using dummy regulator
> [   12.069929] snd_pci_acp3x 0000:04:00.5: enabling device (0000 -> 0002)
> [   12.070366] snd_pci_acp3x 0000:04:00.5: Invalid ACP audio mode : 1
> [   12.074284] IPMI message handler: version 39.2
> [   12.077622] ACPI Warning: SystemIO range 0x0000000000000B00-0x0000000000000B08 conflicts with OpRegion 0x0000000000000B00-0x0000000000000B06 (\_SB.PCI0.SMBS.SMBO) (20200925/utaddress-204)
> [   12.077637] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
> [   12.086897] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
> [   12.087426] sp5100-tco sp5100-tco: Using 0xfeb00000 for watchdog MMIO address
> [   12.087557] sp5100-tco sp5100-tco: initialized. heartbeat=60 sec (nowayout=0)
> [   12.104587] ipmi device interface
> [   12.108547] mousedev: PS/2 mouse device common for all mice
> [   12.126120] input: PC Speaker as /devices/platform/pcspkr/input/input15
> [   12.142555] input: SYNA308C:00 06CB:CD77 Mouse as /devices/platform/AMDI0011:00/i2c-9/i2c-SYNA308C:00/0018:06CB:CD77.0001/input/input16
> [   12.142728] input: SYNA308C:00 06CB:CD77 Touchpad as /devices/platform/AMDI0011:00/i2c-9/i2c-SYNA308C:00/0018:06CB:CD77.0001/input/input17
> [   12.142839] hid-generic 0018:06CB:CD77.0001: input,hidraw0: I2C HID v1.00 Mouse [SYNA308C:00 06CB:CD77] on i2c-SYNA308C:00
> [   12.176893] hp_wmi: query 0x4 returned error 0x5
> [   12.183072] ipmi_si: IPMI System Interface driver
> [   12.183294] ipmi_si: Unable to find any System Interface(s)
> [   12.184934] hp_wmi: query 0x4 returned error 0x5
> [   12.192206] hp_wmi: query 0xd returned error 0x5
> [   12.192318] input: HP WMI hotkeys as /devices/virtual/input/input19
> [   12.195282] RAPL PMU: API unit is 2^-32 Joules, 1 fixed counters, 163840 ms ovfl timer
> [   12.195286] RAPL PMU: hw unit of domain package 2^-16 Joules
> [   12.204106] hp_wmi: query 0x1b returned error 0x5
> [   12.238855] cfg80211: Loading compiled-in X.509 certificates for regulatory database
> [   12.255391] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> [   12.255705] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
> [   12.255709] cfg80211: failed to load regulatory.db
> [   12.345519] input: SYNA308C:00 06CB:CD77 Mouse as /devices/platform/AMDI0011:00/i2c-9/i2c-SYNA308C:00/0018:06CB:CD77.0001/input/input20
> [   12.345902] input: SYNA308C:00 06CB:CD77 Touchpad as /devices/platform/AMDI0011:00/i2c-9/i2c-SYNA308C:00/0018:06CB:CD77.0001/input/input21
> [   12.346127] hid-multitouch 0018:06CB:CD77.0001: input,hidraw0: I2C HID v1.00 Mouse [SYNA308C:00 06CB:CD77] on i2c-SYNA308C:00
> [   12.354486] Intel(R) Wireless WiFi driver for Linux
> [   12.354671] iwlwifi 0000:02:00.0: enabling device (0000 -> 0002)
> [   12.371624] iwlwifi 0000:02:00.0: api flags index 2 larger than supported by driver
> [   12.371669] iwlwifi 0000:02:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 89.3.35.22
> [   12.372637] iwlwifi 0000:02:00.0: loaded firmware version 59.601f3a66.0 cc-a0-59.ucode op_mode iwlmvm
> [   12.398414] kvm: Nested Virtualization enabled
> [   12.398450] SVM: kvm: Nested Paging enabled
> [   12.398451] SVM: Virtual VMLOAD VMSAVE supported
> [   12.398452] SVM: Virtual GIF supported
> [   12.407635] MCE: In-kernel MCE decoding enabled.
> [   12.415126] EDAC amd64: F17h_M10h detected (node 0).
> [   12.415214] EDAC amd64: Node 0: DRAM ECC disabled.
> [   12.432099] EDAC amd64: F17h_M10h detected (node 0).
> [   12.432189] EDAC amd64: Node 0: DRAM ECC disabled.
> [   12.448970] EDAC amd64: F17h_M10h detected (node 0).
> [   12.449173] EDAC amd64: Node 0: DRAM ECC disabled.
> [   12.462831] EDAC amd64: F17h_M10h detected (node 0).
> [   12.462934] EDAC amd64: Node 0: DRAM ECC disabled.
> [   12.482705] EDAC amd64: F17h_M10h detected (node 0).
> [   12.482801] EDAC amd64: Node 0: DRAM ECC disabled.
> [   12.491132] snd_hda_intel 0000:04:00.1: enabling device (0000 -> 0002)
> [   12.492121] snd_hda_intel 0000:04:00.6: enabling device (0000 -> 0002)
> [   12.506289] EDAC amd64: F17h_M10h detected (node 0).
> [   12.506464] EDAC amd64: Node 0: DRAM ECC disabled.
> [   12.507791] snd_hda_intel 0000:04:00.1: bound 0000:04:00.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu])
> [   12.523447] input: HD-Audio Generic HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:08.1/0000:04:00.1/sound/card0/input23
> [   12.523532] input: HD-Audio Generic HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:08.1/0000:04:00.1/sound/card0/input24
> [   12.523609] input: HD-Audio Generic HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:08.1/0000:04:00.1/sound/card0/input25
> [   12.523696] input: HD-Audio Generic HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:08.1/0000:04:00.1/sound/card0/input26
> [   12.523809] EDAC amd64: F17h_M10h detected (node 0).
> [   12.524174] EDAC amd64: Node 0: DRAM ECC disabled.
> [   12.540921] iwlwifi 0000:02:00.0: Detected Intel(R) Wi-Fi 6 AX200 160MHz, REV=0x340
> [   12.541755] EDAC amd64: F17h_M10h detected (node 0).
> [   12.541851] EDAC amd64: Node 0: DRAM ECC disabled.
> [   12.543942] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC215: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
> [   12.543949] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> [   12.543951] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
> [   12.543953] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=0x0
> [   12.543955] snd_hda_codec_realtek hdaudioC1D0:    inputs:
> [   12.543958] snd_hda_codec_realtek hdaudioC1D0:      Mic=0x19
> [   12.543960] snd_hda_codec_realtek hdaudioC1D0:      Internal Mic=0x12
> [   12.589408] input: HD-Audio Generic Mic as /devices/pci0000:00/0000:00:08.1/0000:04:00.6/sound/card1/input27
> [   12.589569] input: HD-Audio Generic Headphone as /devices/pci0000:00/0000:00:08.1/0000:04:00.6/sound/card1/input28
> [   12.730060] Generic FE-GE Realtek PHY r8169-100:00: attached PHY driver [Generic FE-GE Realtek PHY] (mii_bus:phy_addr=r8169-100:00, irq=IGNORE)
> [   12.735641] iwlwifi 0000:02:00.0: base HW address: 14:f6:d8:2f:b2:1e
> [   12.836117] r8169 0000:01:00.0 enp1s0f0: Link is Down
> [   12.837704] thermal thermal_zone6: failed to read out thermal zone (-61)
> [   12.841769] iwlwifi 0000:02:00.0 wlp2s0: renamed from wlan0
> [   13.324817] mc: Linux media interface: v0.10
> [   13.373243] videodev: Linux video capture interface: v2.00
> [   13.499431] uvcvideo: Found UVC 1.50 device HP HD Camera (04ca:7089)
> [   13.570360] input: HP HD Camera: HP HD Camera as /devices/pci0000:00/0000:00:08.1/0000:04:00.4/usb4/4-2/4-2:1.0/input/input29
> [   13.574724] uvcvideo: Found UVC 1.50 device HP HD Camera (04ca:7089)
> [   13.592640] input: HP HD Camera: HP IR Camera as /devices/pci0000:00/0000:00:08.1/0000:04:00.4/usb4/4-2/4-2:1.2/input/input30
> [   13.592818] usbcore: registered new interface driver uvcvideo
> [   13.592820] USB Video Class driver (1.1.1)
> [   13.960345] Bluetooth: Core ver 2.22
> [   13.960411] NET: Registered protocol family 31
> [   13.960412] Bluetooth: HCI device and connection manager initialized
> [   13.960418] Bluetooth: HCI socket layer initialized
> [   13.960422] Bluetooth: L2CAP socket layer initialized
> [   13.960429] Bluetooth: SCO socket layer initialized
> [   14.131957] usbcore: registered new interface driver btusb
> [   14.135877] Bluetooth: hci0: Bootloader revision 0.3 build 0 week 24 2017
> [   14.140893] Bluetooth: hci0: Device revision is 1
> [   14.140897] Bluetooth: hci0: Secure boot is enabled
> [   14.140899] Bluetooth: hci0: OTP lock is enabled
> [   14.140900] Bluetooth: hci0: API lock is enabled
> [   14.140901] Bluetooth: hci0: Debug lock is disabled
> [   14.140904] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
> [   14.144618] Bluetooth: hci0: Found device firmware: intel/ibt-20-1-3.sfi
> [   15.882387] Bluetooth: hci0: Waiting for firmware download to complete
> [   15.882918] Bluetooth: hci0: Firmware loaded in 1709981 usecs
> [   15.883006] Bluetooth: hci0: Waiting for device to boot
> [   15.900880] Bluetooth: hci0: Device booted in 17532 usecs
> [   15.901381] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-20-1-3.ddc
> [   15.907868] Bluetooth: hci0: Applying Intel DDC parameters completed
> [   15.919962] Bluetooth: hci0: Firmware revision 0.0 build 127 week 48 2020
> [   17.504706] kauditd_printk_skb: 103 callbacks suppressed
> [   17.504710] audit: type=1100 audit(1610349011.047:134): pid=1419 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:authentication grantors=pam_shells,pam_faillock,pam_permit,pam_faillock acct="aep" exe="/usr/bin/lightdm" hostname=? addr=? terminal=:0 res=success'
> [   17.507098] audit: type=1101 audit(1610349011.050:135): pid=1419 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:accounting grantors=pam_access,pam_unix,pam_permit,pam_time acct="aep" exe="/usr/bin/lightdm" hostname=? addr=? terminal=:0 res=success'
> [   17.554692] audit: type=1106 audit(1610349011.097:136): pid=1352 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:session_close grantors=pam_unix,pam_systemd acct="lightdm" exe="/usr/bin/lightdm" hostname=? addr=? terminal=:0 res=success'
> [   17.554799] audit: type=1104 audit(1610349011.097:137): pid=1352 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:setcred grantors=pam_env,pam_permit acct="lightdm" exe="/usr/bin/lightdm" hostname=? addr=? terminal=:0 res=success'
> [   17.560655] audit: type=1103 audit(1610349011.103:138): pid=1419 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:setcred grantors=pam_shells,pam_faillock,pam_permit,pam_faillock acct="aep" exe="/usr/bin/lightdm" hostname=? addr=? terminal=:0 res=success'
> [   17.560786] audit: type=1006 audit(1610349011.103:139): pid=1419 uid=0 old-auid=4294967295 auid=1000 tty=(none) old-ses=4294967295 ses=2 res=1
> [   17.590609] audit: type=1130 audit(1610349011.133:140): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=user-runtime-dir@1000 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   17.600762] audit: type=1101 audit(1610349011.143:141): pid=1452 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:accounting grantors=pam_access,pam_unix,pam_permit,pam_time acct="aep" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   17.600770] audit: type=1103 audit(1610349011.143:142): pid=1452 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:setcred grantors=? acct="aep" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
> [   17.600838] audit: type=1006 audit(1610349011.143:143): pid=1452 uid=0 old-auid=4294967295 auid=1000 tty=(none) old-ses=4294967295 ses=3 res=1
> [   19.761769] wlp2s0: authenticate with 78:d2:94:a2:22:bf
> [   19.765603] wlp2s0: send auth to 78:d2:94:a2:22:bf (try 1/3)
> [   19.900646] wlp2s0: authenticate with 78:d2:94:a2:22:bf
> [   19.900658] wlp2s0: send auth to 78:d2:94:a2:22:bf (try 1/3)
> [   19.901806] wlp2s0: authenticated
> [   19.903015] wlp2s0: associate with 78:d2:94:a2:22:bf (try 1/3)
> [   19.905785] wlp2s0: RX AssocResp from 78:d2:94:a2:22:bf (capab=0x11 status=0 aid=1)
> [   19.912052] wlp2s0: associated
> [   19.978397] IPv6: ADDRCONF(NETDEV_CHANGE): wlp2s0: link becomes ready
> [   23.175619] kauditd_printk_skb: 12 callbacks suppressed
> [   23.175621] audit: type=1131 audit(1610349016.718:156): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=NetworkManager-dispatcher comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   27.837693] audit: type=1131 audit(1610349021.380:157): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=user@975 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   27.852532] audit: type=1131 audit(1610349021.395:158): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=user-runtime-dir@975 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   42.694375] audit: type=1131 audit(1610349036.237:159): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-hostnamed comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [   42.756222] audit: type=1334 audit(1610349036.299:160): prog-id=26 op=UNLOAD
> [   42.756227] audit: type=1334 audit(1610349036.299:161): prog-id=25 op=UNLOAD
> [  126.254330] No UUID available providing old NGUID
> [  267.925279] audit: type=1100 audit(1610349261.468:162): pid=2565 uid=1000 auid=1000 ses=3 msg='op=PAM:authentication grantors=pam_faillock,pam_permit,pam_faillock acct="aep" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
> [  267.927360] audit: type=1101 audit(1610349261.470:163): pid=2565 uid=1000 auid=1000 ses=3 msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="aep" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
> [  267.927675] audit: type=1110 audit(1610349261.470:164): pid=2565 uid=1000 auid=1000 ses=3 msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_faillock acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
> [  267.928843] audit: type=1105 audit(1610349261.471:165): pid=2565 uid=1000 auid=1000 ses=3 msg='op=PAM:session_open grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/0 res=success'
> [  755.756987] audit: type=1100 audit(1610349749.299:166): pid=6265 uid=1000 auid=1000 ses=3 msg='op=PAM:authentication grantors=pam_faillock,pam_permit,pam_faillock acct="aep" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1 res=success'
> [  755.758765] audit: type=1101 audit(1610349749.301:167): pid=6265 uid=1000 auid=1000 ses=3 msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="aep" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1 res=success'
> [  755.759116] audit: type=1110 audit(1610349749.302:168): pid=6265 uid=1000 auid=1000 ses=3 msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_faillock acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1 res=success'
> [  755.760693] audit: type=1105 audit(1610349749.303:169): pid=6265 uid=1000 auid=1000 ses=3 msg='op=PAM:session_open grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1 res=success'
> [  756.886216] audit: type=1106 audit(1610349750.429:170): pid=6265 uid=1000 auid=1000 ses=3 msg='op=PAM:session_close grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1 res=success'
> [  756.886290] audit: type=1104 audit(1610349750.429:171): pid=6265 uid=1000 auid=1000 ses=3 msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_faillock acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1 res=success'
> [  761.480271] audit: type=1101 audit(1610349755.023:172): pid=6297 uid=1000 auid=1000 ses=3 msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="aep" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1 res=success'
> [  761.480657] audit: type=1110 audit(1610349755.023:173): pid=6297 uid=1000 auid=1000 ses=3 msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_env,pam_faillock acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1 res=success'
> [  761.481832] audit: type=1105 audit(1610349755.024:174): pid=6297 uid=1000 auid=1000 ses=3 msg='op=PAM:session_open grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1 res=success'
> [  852.384355] audit: type=1106 audit(1610349845.927:175): pid=6297 uid=1000 auid=1000 ses=3 msg='op=PAM:session_close grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1 res=success'
> [  852.384363] audit: type=1104 audit(1610349845.927:176): pid=6297 uid=1000 auid=1000 ses=3 msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_env,pam_faillock acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1 res=success'
> [  935.590096] audit: type=1130 audit(1610349929.133:177): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-tmpfiles-clean comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [  935.590104] audit: type=1131 audit(1610349929.133:178): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-tmpfiles-clean comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
> [ 1391.137087] audit: type=1100 audit(1610350384.679:179): pid=7075 uid=1000 auid=1000 ses=3 msg='op=PAM:authentication grantors=pam_faillock,pam_permit,pam_faillock acct="aep" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1 res=success'
> [ 1391.138890] audit: type=1101 audit(1610350384.681:180): pid=7075 uid=1000 auid=1000 ses=3 msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="aep" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1 res=success'
> [ 1391.139242] audit: type=1110 audit(1610350384.682:181): pid=7075 uid=1000 auid=1000 ses=3 msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_faillock acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1 res=success'
> [ 1391.140424] audit: type=1105 audit(1610350384.683:182): pid=7075 uid=1000 auid=1000 ses=3 msg='op=PAM:session_open grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/sudo" hostname=? addr=? terminal=/dev/pts/1 res=success'

> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
