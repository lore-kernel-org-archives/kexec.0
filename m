Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iYF7M-0005Sg-Vd
 for kexec@lists.infradead.org; Fri, 22 Nov 2019 20:01:34 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20191122180552.GA32104@weiser.dinsnail.net>
Date: Fri, 22 Nov 2019 14:00:22 -0600
In-Reply-To: <20191122180552.GA32104@weiser.dinsnail.net> (Michael Weiser's
 message of "Fri, 22 Nov 2019 19:05:52 +0100")
Message-ID: <87blt3y949.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: kexec_file overwrites reserved EFI ESRT memory
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
To: Michael Weiser <michael@weiser.dinsnail.net>
Cc: linux-efi@vger.kernel.org, kexec@lists.infradead.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>

Michael Weiser <michael@weiser.dinsnail.net> writes:

> Hello Eric,
> Hello Ard,
>
> on my machine, kexec_file loads the normal (not crash) kernel image
> right across the EFI ESRT reserved memory range:
>
> esrt: Reserving ESRT space from 0x0000000074dd6f98 to 0x0000000074dd6fd0.
> [...]
> kexec_file: kernel signature verification successful.
> kexec_file: Loading segment 0: buf=0x00000000e99b31ad bufsz=0x5000 mem=0x91000 memsz=0x6000
> kexec_file: Loading segment 1: buf=0x00000000e45cdeb8 bufsz=0x1240 mem=0x8f000 memsz=0x2000
> kexec_file: Loading segment 2: buf=0x00000000096e6de9 bufsz=0x1133888 mem=0x73000000 memsz=0x249a000
>
> This causes the following message by the kexec'd kernel:
>
> esrt: Unsupported ESRT version 2904149718861218184.
>
> (The image is rather large at 18MiB as it has a built-in initrd.)

When did x86_64 get support for ARCH_KEEP_MEMBLOCK?  I can't find it
anywhere.

My recollection is that on x86 the definitive specification of what is
reserved and what is not is the struct resource (aka /proc/iomem).
While on some other architectures they do something else apparently
the memblock implementation.

Fundamentally when deciding where to place a new kernel kexec (either
user space or the in kernel kexec_file implementation) needs to be able
to ask the question which memory ares are reserved.  What the buddy
allocator does is unimportant as kexec copies memory from all over
the place and places it in the destined memory addresses at the
time of the kexec operation.

So my question is why doesn't the ESRT reservation wind up in
/proc/iomem?

Are you dealing with an embedded port that is being clever?

Or is there some subtle breakage now that x86 has memblock support that
/proc/iomem is no longer being properly maintained?

Eric

> Poking at the involved code a bit (as a layman) I found that the EFI
> code reserves the memory range using memblock_reserve() which is by all
> appearances correctly handed over to the buddy allocator as
> in-use/reserved. kexec_file on the other hand by default looks at iomem
> regions of type System RAM using walk_system_ram_res() and does not seem
> to have that particular information available to consider. (As may have
> become clear from this explanation I'm still somewhat fuzzy (to put it
> midly) on the relationship of memblock, buddy and slab allocator and how
> (if at all) kexec_file interacts with them to a.) find available memory
> regions for the new kernel to load to and b.) tell them where it
> loaded the new kernel to so they don't use it any more.)
>
> As is to be expected, activating CONFIG_ARCH_KEEP_MEMBLOCK makes
> kexec_file use the preserved memblock structures and indeed end up using
> totally different memory regions and gets rid of the message:
>
> kexec_file: kernel signature verification successful.
> kexec_file: Loading segment 0: buf=0x000000002dea71f8 bufsz=0x5000 mem=0x47df8e000 memsz=0x6000
> kexec_file: Loading segment 1: buf=0x000000000686ff17 bufsz=0x1240 mem=0x47df8c000 memsz=0x2000
> kexec_file: Loading segment 2: buf=0x00000000fc444e67 bufsz=0x1133888 mem=0x469000000 memsz=0x2497000
>
> This is with 5.3.11 mainline and linux-next 5.4.0-rc8-next-20191122.
>
> I'm not actually trying to use ESRT for anything at this point but want
> to stop the boot message from messing up silent boot and suspect that
> this could potentially happen to other, more important EFI memory
> regions as well.
>
> I'm willing to chase this further but at this point I'm wondering
> whether it's the EFI code not reserving this memory area with enough
> emphasis (as iomem?) or kexec_file not checking usability of
> candidate memory regions rigorously enough (based on what other
> criteria?).
>
> Are there maybe any upcoming patches or subsystem-specific kernel trees
> I should try?
>
> Please let me know what other information may be helpful or if I should
> open a bug on bugzilla.kernel.org.
>
> Boot messages on normal boot:
> Linux version 5.3.11-gentoo (m@n) (gcc version 9.2.0 (Gentoo 9.2.0-r2 p3)) #29 SMP Thu Nov 21 20:40:28 CET 2019
> Command line: 
> x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
> x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
> x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
> x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
> x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
> BIOS-provided physical RAM map:
> BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
> BIOS-e820: [mem 0x000000000009f000-0x00000000000fffff] reserved
> BIOS-e820: [mem 0x0000000000100000-0x00000000763fafff] usable
> BIOS-e820: [mem 0x00000000763fb000-0x0000000079979fff] reserved
> BIOS-e820: [mem 0x000000007997a000-0x00000000799f6fff] ACPI data
> BIOS-e820: [mem 0x00000000799f7000-0x0000000079aabfff] ACPI NVS
> BIOS-e820: [mem 0x0000000079aac000-0x000000007a40dfff] reserved
> BIOS-e820: [mem 0x000000007a40e000-0x000000007a40efff] usable
> BIOS-e820: [mem 0x000000007a40f000-0x000000007fffffff] reserved
> BIOS-e820: [mem 0x00000000f0000000-0x00000000f7ffffff] reserved
> BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
> BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
> BIOS-e820: [mem 0x00000000fed00000-0x00000000fed03fff] reserved
> BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
> BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
> BIOS-e820: [mem 0x0000000100000000-0x000000047dffffff] usable
> NX (Execute Disable) protection: active
> efi: EFI v2.70 by American Megatrends
> efi:  ACPI 2.0=0x79993000  ACPI=0x79993000  TPMFinalLog=0x79a35000  SMBIOS=0x7a1cf000  SMBIOS 3.0=0x7a1ce000  ESRT=0x74dd6f98  TPMEventLog=0x6d634018 
> efi: mem00: [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000000000000-0x0000000000000fff] (0MB)
> efi: mem01: [Loader Data        |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000000001000-0x0000000000005fff] (0MB)
> efi: mem02: [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000000006000-0x000000000009efff] (0MB)
> efi: mem03: [Reserved           |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000000009f000-0x000000000009ffff] (0MB)
> efi: mem04: [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000000100000-0x0000000000ffffff] (15MB)
> efi: mem05: [Loader Data        |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000001000000-0x0000000003499fff] (36MB)
> efi: mem06: [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000000349a000-0x000000005d62afff] (1441MB)
> efi: mem07: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000005d62b000-0x000000005d66afff] (0MB)
> efi: mem08: [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000005d66b000-0x00000000698dcfff] (194MB)
> efi: mem09: [Loader Code        |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000698dd000-0x000000006bd76fff] (36MB)
> efi: mem10: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000006bd77000-0x000000006c078fff] (3MB)
> efi: mem11: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000006c079000-0x000000006c093fff] (0MB)
> efi: mem12: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000006c094000-0x000000006c0bffff] (0MB)
> efi: mem13: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000006c0c0000-0x000000006c0c4fff] (0MB)
> efi: mem14: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000006c0c5000-0x000000006c0d4fff] (0MB)
> efi: mem15: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000006c0d5000-0x000000006c0e2fff] (0MB)
> efi: mem16: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000006c0e3000-0x000000006d53efff] (20MB)
> efi: mem17: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000006d53f000-0x000000006d54cfff] (0MB)
> efi: mem18: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000006d54d000-0x000000006d571fff] (0MB)
> efi: mem19: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000006d572000-0x000000006d588fff] (0MB)
> efi: mem20: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000006d589000-0x000000006d5b0fff] (0MB)
> efi: mem21: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000006d5b1000-0x000000006d5e4fff] (0MB)
> efi: mem22: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000006d5e5000-0x000000006d5f4fff] (0MB)
> efi: mem23: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000006d5f5000-0x000000006d5f6fff] (0MB)
> efi: mem24: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000006d5f7000-0x000000006d60efff] (0MB)
> efi: mem25: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000006d60f000-0x000000006d62afff] (0MB)
> efi: mem26: [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000006d62b000-0x000000006d630fff] (0MB)
> efi: mem27: [Loader Data        |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000006d631000-0x000000006d639fff] (0MB)
> efi: mem28: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000006d63a000-0x0000000075bf1fff] (133MB)
> efi: mem29: [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000075bf2000-0x0000000075d8cfff] (1MB)
> efi: mem30: [Loader Data        |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000075d8d000-0x0000000075d8dfff] (0MB)
> efi: mem31: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000075d8e000-0x00000000763fafff] (6MB)
> efi: mem32: [Reserved           |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000763fb000-0x0000000079979fff] (53MB)
> efi: mem33: [ACPI Reclaim Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007997a000-0x00000000799f6fff] (0MB)
> efi: mem34: [ACPI Memory NVS    |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x00000000799f7000-0x0000000079aabfff] (0MB)
> efi: mem35: [Runtime Data       |RUN|  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000079aac000-0x000000007a316fff] (8MB)
> efi: mem36: [Runtime Code       |RUN|  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007a317000-0x000000007a40dfff] (0MB)
> efi: mem37: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007a40e000-0x000000007a40efff] (0MB)
> efi: mem38: [Conventional Memory|   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000100000000-0x000000047dffffff] (14304MB)
> efi: mem39: [Reserved           |   |  |  |  |  |  |  |   |  |  |  |  ] range=[0x00000000000a0000-0x00000000000fffff] (0MB)
> efi: mem40: [Reserved           |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007a40f000-0x000000007a6fffff] (2MB)
> efi: mem41: [Reserved           |attr=0x070000000000000f] range=[0x000000007a700000-0x000000007a7fffff] (1MB)
> efi: mem42: [Reserved           |   |  |  |  |  |  |  |   |  |  |  |  ] range=[0x000000007a800000-0x000000007fffffff] (88MB)
> efi: mem43: [Memory Mapped I/O  |RUN|  |  |  |  |WP|  |   |WB|WT|  |UC] range=[0x00000000f0000000-0x00000000f7ffffff] (128MB)
> efi: mem44: [Memory Mapped I/O  |RUN|  |  |  |  |  |  |   |  |  |  |UC] range=[0x00000000fe000000-0x00000000fe010fff] (0MB)
> efi: mem45: [Memory Mapped I/O  |RUN|  |  |  |  |WP|  |   |WB|WT|  |UC] range=[0x00000000fec00000-0x00000000fec00fff] (0MB)
> efi: mem46: [Memory Mapped I/O  |RUN|  |  |  |  |WP|  |   |WB|WT|  |UC] range=[0x00000000fed00000-0x00000000fed03fff] (0MB)
> efi: mem47: [Memory Mapped I/O  |RUN|  |  |  |  |  |  |   |  |  |  |UC] range=[0x00000000fee00000-0x00000000fee00fff] (0MB)
> efi: mem48: [Memory Mapped I/O  |RUN|  |  |  |  |WP|  |   |WB|WT|  |UC] range=[0x00000000ff000000-0x00000000ffffffff] (16MB)
> SMBIOS 3.2.1 present.
> DMI: ASUSTeK COMPUTER INC. ZenBook UX391FA_UX391FA/UX391FA, BIOS UX391FA.301 02/14/2019
> tsc: Detected 2000.000 MHz processor
> tsc: Detected 1999.968 MHz TSC
> [Firmware Bug]: TSC ADJUST: CPU0: -456722435 force to 0
> e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> e820: remove [mem 0x000a0000-0x000fffff] usable
> last_pfn = 0x47e000 max_arch_pfn = 0x400000000
> MTRR default type: write-back
> MTRR fixed ranges enabled:
>   00000-9FFFF write-back
>   A0000-BFFFF uncachable
>   C0000-FFFFF write-back
> MTRR variable ranges enabled:
>   0 base 0080000000 mask 7F80000000 uncachable
>   1 base 007C000000 mask 7FFC000000 uncachable
>   2 base 007B800000 mask 7FFF800000 uncachable
>   3 base 2000000000 mask 6000000000 uncachable
>   4 base 1000000000 mask 7000000000 uncachable
>   5 base 0800000000 mask 7800000000 uncachable
>   6 base 4000000000 mask 4000000000 uncachable
>   7 disabled
>   8 disabled
>   9 disabled
> x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
> last_pfn = 0x7a40f max_arch_pfn = 0x400000000
> esrt: Reserving ESRT space from 0x0000000074dd6f98 to 0x0000000074dd6fd0.
> Using GB pages for direct mapping
> BRK [0x454201000, 0x454201fff] PGTABLE
> BRK [0x454202000, 0x454202fff] PGTABLE
> BRK [0x454203000, 0x454203fff] PGTABLE
> BRK [0x454204000, 0x454204fff] PGTABLE
> BRK [0x454205000, 0x454205fff] PGTABLE
> BRK [0x454206000, 0x454206fff] PGTABLE
> BRK [0x454207000, 0x454207fff] PGTABLE
> BRK [0x454208000, 0x454208fff] PGTABLE
> Secure boot enabled
> ACPI: Early table checksum verification disabled
> ACPI: RSDP 0x0000000079993000 000024 (v02 _ASUS_)
> ACPI: XSDT 0x00000000799930B0 0000E4 (v01 _ASUS_ Notebook 01072009 AMI  00010013)
> ACPI: FACP 0x00000000799D7EF8 000114 (v06 _ASUS_ Notebook 01072009 AMI  00010013)
> ACPI: DSDT 0x0000000079993228 044CCB (v02 _ASUS_ Notebook 01072009 INTL 20160527)
> ACPI: FACS 0x0000000079AAA080 000040
> ACPI: APIC 0x00000000799D8010 0000BC (v04 _ASUS_ Notebook 01072009 AMI  00010013)
> ACPI: FPDT 0x00000000799D80D0 000044 (v01 _ASUS_ Notebook 01072009 AMI  00010013)
> ACPI: FIDT 0x00000000799D8118 00009C (v01 _ASUS_ Notebook 01072009 AMI  00010013)
> ACPI: MCFG 0x00000000799D81B8 00003C (v01 _ASUS_ Notebook 01072009 MSFT 00000097)
> ACPI: ECDT 0x00000000799D81F8 0000C1 (v01 _ASUS_ Notebook 01072009 AMI. 00000005)
> ACPI: SSDT 0x00000000799D82C0 005428 (v02 DptfTa DptfTabl 00001000 INTL 20160527)
> ACPI: SSDT 0x00000000799DD6E8 001B1C (v02 CpuRef CpuSsdt  00003000 INTL 20160527)
> ACPI: MSDM 0x00000000799DF208 000055 (v03 _ASUS_ Notebook 01072009 ASUS 00000001)
> ACPI: SSDT 0x00000000799DF260 0031C6 (v02 SaSsdt SaSsdt   00003000 INTL 20160527)
> ACPI: HPET 0x00000000799E2428 000038 (v01 _ASUS_ Notebook 00000002      01000013)
> ACPI: SSDT 0x00000000799E2460 003047 (v02 INTEL  xh_whld4 00000000 INTL 20160527)
> ACPI: UEFI 0x00000000799E54A8 000042 (v01 _ASUS_ Notebook 00000002      01000013)
> ACPI: LPIT 0x00000000799E54F0 00005C (v01 _ASUS_ Notebook 00000002      01000013)
> ACPI: SSDT 0x00000000799E5550 000FFB (v02 _ASUS_ TbtTypeC 00000000 INTL 20160527)
> ACPI: DBGP 0x00000000799E6550 000034 (v01 _ASUS_ Notebook 00000002      01000013)
> ACPI: DBG2 0x00000000799E6588 000054 (v00 _ASUS_ Notebook 00000002      01000013)
> ACPI: SSDT 0x00000000799E65E0 000E0B (v02 _ASUS_ UsbCTabl 00001000 INTL 20160527)
> ACPI: SSDT 0x00000000799E73F0 000144 (v02 Intel  ADebTabl 00001000 INTL 20160527)
> ACPI: NHLT 0x00000000799E7538 00002D (v00 INTEL  EDK2     00000002      01000013)
> ACPI: BGRT 0x00000000799E7568 000038 (v01 _ASUS_ Notebook 01072009 AMI  00010013)
> ACPI: TPM2 0x00000000799E75A0 000034 (v04 _ASUS_ Notebook 00000001 AMI  00000000)
> ACPI: DMAR 0x00000000799E75D8 0000A8 (v01 INTEL  EDK2     00000002      01000013)
> ACPI: WSMT 0x00000000799E7680 000028 (v01 _ASUS_ Notebook 01072009 AMI  00010013)
> ACPI: Local APIC address 0xfee00000
> Reserving 96MB of memory at 1616MB for crashkernel (System RAM: 16195MB)
> Zone ranges:
>   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
>   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
>   Normal   [mem 0x0000000100000000-0x000000047dffffff]
> Movable zone start for each node
> Early memory node ranges
>   node   0: [mem 0x0000000000001000-0x000000000009efff]
>   node   0: [mem 0x0000000000100000-0x00000000763fafff]
>   node   0: [mem 0x000000007a40e000-0x000000007a40efff]
>   node   0: [mem 0x0000000100000000-0x000000047dffffff]
> Zeroed struct page in unavailable ranges: 40038 pages
> Initmem setup node 0 [mem 0x0000000000001000-0x000000047dffffff]
> On node 0 totalpages: 4146074
>   DMA zone: 64 pages used for memmap
>   DMA zone: 22 pages reserved
>   DMA zone: 3998 pages, LIFO batch:0
>   DMA32 zone: 7504 pages used for memmap
>   DMA32 zone: 480252 pages, LIFO batch:63
>   Normal zone: 57216 pages used for memmap
>   Normal zone: 3661824 pages, LIFO batch:63
> Reserving Intel graphics memory at [mem 0x7c000000-0x7fffffff]
> ACPI: PM-Timer IO Port: 0x1808
> ACPI: Local APIC address 0xfee00000
> ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
> ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
> ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
> ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
> ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
> ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
> ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
> IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
> ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> ACPI: IRQ0 used by override.
> ACPI: IRQ9 used by override.
> Using ACPI (MADT) for SMP configuration information
> ACPI: HPET id: 0x8086a201 base: 0xfed00000
> smpboot: Allowing 8 CPUs, 0 hotplug CPUs
> PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
> PM: Registered nosave memory: [mem 0x0009f000-0x000fffff]
> PM: Registered nosave memory: [mem 0x763fb000-0x79979fff]
> PM: Registered nosave memory: [mem 0x7997a000-0x799f6fff]
> PM: Registered nosave memory: [mem 0x799f7000-0x79aabfff]
> PM: Registered nosave memory: [mem 0x79aac000-0x7a40dfff]
> PM: Registered nosave memory: [mem 0x7a40f000-0x7fffffff]
> PM: Registered nosave memory: [mem 0x80000000-0xefffffff]
> PM: Registered nosave memory: [mem 0xf0000000-0xf7ffffff]
> PM: Registered nosave memory: [mem 0xf8000000-0xfdffffff]
> PM: Registered nosave memory: [mem 0xfe000000-0xfe010fff]
> PM: Registered nosave memory: [mem 0xfe011000-0xfebfffff]
> PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
> PM: Registered nosave memory: [mem 0xfec01000-0xfecfffff]
> PM: Registered nosave memory: [mem 0xfed00000-0xfed03fff]
> PM: Registered nosave memory: [mem 0xfed04000-0xfedfffff]
> PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
> PM: Registered nosave memory: [mem 0xfee01000-0xfeffffff]
> PM: Registered nosave memory: [mem 0xff000000-0xffffffff]
> [mem 0x80000000-0xefffffff] available for PCI devices
> clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370452778343963 ns
> setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
> percpu: Embedded 51 pages/cpu s170776 r8192 d29928 u262144
> pcpu-alloc: s170776 r8192 d29928 u262144 alloc=1*2097152
> pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
> Built 1 zonelists, mobility grouping on.  Total pages: 4081268
> Kernel command line: root=UUID=97bd2b14-ed61-436f-94ed-e9d5d5c21be4 rd.luks.uuid=8a530094-03c0-44ab-a589-7461160dcbc3 rd.luks.allow-discards=8a530094-03c0-44ab-a589-7461160dcbc3 mem_sleep_default=deep resume=UUID=97bd2b14-ed61-436f-94ed-e9d5d5c21be4 resume_offset=96256 quiet splash rd.systemd.show_status=auto i915.enable_guc=2 i915.enable_fbc=1 i915.enable_psr=0 vt.global_cursor_default=0 crashkernel=96M efi=debug
> Setting dangerous option i915.enable_guc - tainting kernel
> Setting dangerous option i915.enable_fbc - tainting kernel
> Setting dangerous option i915.enable_psr - tainting kernel
> Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
> Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
> mem auto-init: stack:byref_all, heap alloc:on, heap free:off
> Memory: 15927596K/16584296K available (10243K kernel code, 847K rwdata, 2932K rodata, 12600K init, 2268K bss, 656700K reserved, 0K cma-reserved)
> rcu: Hierarchical RCU implementation.
> rcu: RCU calculated value of scheduler-enlistment delay is 30 jiffies.
> NR_IRQS: 4352, nr_irqs: 2048, preallocated irqs: 16
> random: get_random_bytes called from start_kernel+0x399/0x555 with crng_init=0
> Console: colour dummy device 80x25
> printk: console [tty0] enabled
> ACPI: Core revision 20190703
> clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
> APIC: Switch to symmetric I/O mode setup
> DMAR: Host address width 39
> DMAR: DRHD base: 0x000000fed90000 flags: 0x0
> DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 19e2ff0505e
> DMAR: DRHD base: 0x000000fed91000 flags: 0x1
> DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
> DMAR: RMRR base: 0x000000771e3000 end: 0x00000077202fff
> DMAR: RMRR base: 0x0000007b800000 end: 0x0000007fffffff
> DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
> DMAR-IR: HPET id 0 under DRHD base 0xfed91000
> DMAR-IR: Enabled IRQ remapping in xapic mode
> ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x39a8208cdd2, max_idle_ns: 881590748921 ns
> Calibrating delay loop (skipped), value calculated using timer frequency.. 4001.60 BogoMIPS (lpj=6666560)
> pid_max: default: 32768 minimum: 301
> efi: EFI runtime memory map:
> efi: mem00: [Memory Mapped I/O  |RUN|  |  |  |  |WP|  |   |WB|WT|  |UC] range=[0x00000000ff000000-0x00000000ffffffff] (16MB)
> efi: mem01: [Memory Mapped I/O  |RUN|  |  |  |  |  |  |   |  |  |  |UC] range=[0x00000000fee00000-0x00000000fee00fff] (0MB)
> efi: mem02: [Memory Mapped I/O  |RUN|  |  |  |  |WP|  |   |WB|WT|  |UC] range=[0x00000000fed00000-0x00000000fed03fff] (0MB)
> efi: mem03: [Memory Mapped I/O  |RUN|  |  |  |  |WP|  |   |WB|WT|  |UC] range=[0x00000000fec00000-0x00000000fec00fff] (0MB)
> efi: mem04: [Memory Mapped I/O  |RUN|  |  |  |  |  |  |   |  |  |  |UC] range=[0x00000000fe000000-0x00000000fe010fff] (0MB)
> efi: mem05: [Memory Mapped I/O  |RUN|  |  |  |  |WP|  |   |WB|WT|  |UC] range=[0x00000000f0000000-0x00000000f7ffffff] (128MB)
> efi: mem06: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007a40e000-0x000000007a40efff] (0MB)
> efi: mem07: [Runtime Code       |RUN|  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007a317000-0x000000007a40dfff] (0MB)
> efi: mem08: [Runtime Data       |RUN|  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000079aac000-0x000000007a316fff] (8MB)
> efi: mem09: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000075d8e000-0x00000000763fafff] (6MB)
> efi: mem10: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000074dd7000-0x0000000075bf1fff] (14MB)
> efi: mem11: [Boot Data          |RUN|  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000074dd6000-0x0000000074dd6fff] (0MB)
> efi: mem12: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000006d63a000-0x0000000074dd5fff] (119MB)
> efi: mem13: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000006d60f000-0x000000006d62afff] (0MB)
> efi: mem14: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000006d5f7000-0x000000006d60efff] (0MB)
> efi: mem15: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000006d5f5000-0x000000006d5f6fff] (0MB)
> efi: mem16: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000006d5e5000-0x000000006d5f4fff] (0MB)
> efi: mem17: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000006d5b1000-0x000000006d5e4fff] (0MB)
> efi: mem18: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000006d589000-0x000000006d5b0fff] (0MB)
> efi: mem19: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000006d572000-0x000000006d588fff] (0MB)
> efi: mem20: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000006d54d000-0x000000006d571fff] (0MB)
> efi: mem21: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000006d53f000-0x000000006d54cfff] (0MB)
> efi: mem22: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000006c0e3000-0x000000006d53efff] (20MB)
> efi: mem23: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000006c0d5000-0x000000006c0e2fff] (0MB)
> efi: mem24: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000006c0c5000-0x000000006c0d4fff] (0MB)
> efi: mem25: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000006c0c0000-0x000000006c0c4fff] (0MB)
> efi: mem26: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000006c094000-0x000000006c0bffff] (0MB)
> efi: mem27: [Boot Code          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000006c079000-0x000000006c093fff] (0MB)
> efi: mem28: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000006bd77000-0x000000006c078fff] (3MB)
> efi: mem29: [Boot Data          |   |  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000005d62b000-0x000000005d66afff] (0MB)
> Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
> Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
> mce: CPU0: Thermal monitoring enabled (TM1)
> process: using mwait in idle threads
> Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
> Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
> Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
> Spectre V2 : Mitigation: Full generic retpoline
> Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
> Spectre V2 : Enabling Restricted Speculation for firmware calls
> Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
> Spectre V2 : User space: Mitigation: STIBP via seccomp and prctl
> Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
> MDS: Vulnerable: Clear CPU buffers attempted, no microcode
> Freeing SMP alternatives memory: 24K
> TSC deadline timer enabled
> smpboot: CPU0: Intel(R) Core(TM) i7-8565U CPU @ 1.80GHz (family: 0x6, model: 0x8e, stepping: 0xb)
> Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
> ... version:                4
> ... bit width:              48
> ... generic registers:      4
> ... value mask:             0000ffffffffffff
> ... max period:             00007fffffffffff
> ... fixed-purpose events:   3
> ... event mask:             000000070000000f
> rcu: Hierarchical SRCU implementation.
> smp: Bringing up secondary CPUs ...
> x86: Booting SMP configuration:
> .... node  #0, CPUs:      #1
> [Firmware Bug]: TSC ADJUST differs within socket(s), fixing all errors
>  #2 #3 #4
> MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
>  #5 #6 #7
> smp: Brought up 1 node, 8 CPUs
> smpboot: Max logical packages: 1
> smpboot: Total of 8 processors activated (32012.80 BogoMIPS)
> devtmpfs: initialized
> PM: Registering ACPI NVS region [mem 0x799f7000-0x79aabfff] (741376 bytes)
> clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370867519511994 ns
> futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
> pinctrl core: initialized pinctrl subsystem
> NET: Registered protocol family 16
> audit: initializing netlink subsys (disabled)
> audit: type=2000 audit(1574366064.033:1): state=initialized audit_enabled=0 res=1
> cpuidle: using governor ladder
> cpuidle: using governor menu
> ACPI: bus type PCI registered
> acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> PCI: MMCONFIG for domain 0000 [bus 00-7f] at [mem 0xf0000000-0xf7ffffff] (base 0xf0000000)
> PCI: MMCONFIG at [mem 0xf0000000-0xf7ffffff] reserved in E820
> PCI: Using configuration type 1 for base access
> ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
> cryptd: max_cpu_qlen set to 1000
> ACPI: Added _OSI(Module Device)
> ACPI: Added _OSI(Processor Device)
> ACPI: Added _OSI(3.0 _SCP Extensions)
> ACPI: Added _OSI(Processor Aggregator Device)
> ACPI: Added _OSI(Linux-Dell-Video)
> ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
> ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.HS01._UPC], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.HS01._PLD], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.HS02._UPC], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.HS02._PLD], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.HS03._UPC], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.HS03._PLD], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.HS04._UPC], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.HS04._PLD], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.HS05._UPC], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.HS05._PLD], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.HS06._UPC], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.HS06._PLD], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.HS07._UPC], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.HS07._PLD], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.HS08._UPC], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.HS08._PLD], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.HS09._UPC], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.HS09._PLD], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.HS10._UPC], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.HS10._PLD], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.USR1._UPC], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.USR1._PLD], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.USR2._UPC], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.USR2._PLD], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.SS01._UPC], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.SS01._PLD], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.SS02._UPC], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.SS02._PLD], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.SS03._UPC], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.SS03._PLD], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.SS04._UPC], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.SS04._PLD], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.SS05._UPC], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.SS05._PLD], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.SS06._UPC], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.SS06._PLD], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI: 8 ACPI AML tables successfully acquired and loaded
> ACPI: EC: EC started
> ACPI: EC: interrupt blocked
> ACPI: \: Used as first EC
> ACPI: \: GPE=0x50, EC_CMD/EC_SC=0x66, EC_DATA=0x62
> ACPI: EC: Boot ECDT EC used to handle transactions
> ACPI: Dynamic OEM Table Load:
> ACPI: SSDT 0xFFFF9029AB081200 0000F4 (v02 PmRef  Cpu0Psd  00003000 INTL 20160527)
> ACPI: \_SB_.PR00: _OSC native thermal LVT Acked
> ACPI: Dynamic OEM Table Load:
> ACPI: SSDT 0xFFFF9029AB278C00 000400 (v02 PmRef  Cpu0Cst  00003001 INTL 20160527)
> ACPI: Dynamic OEM Table Load:
> ACPI: SSDT 0xFFFF9029AB365800 00053F (v02 PmRef  Cpu0Ist  00003000 INTL 20160527)
> ACPI: Dynamic OEM Table Load:
> ACPI: SSDT 0xFFFF9029AB085A00 00011B (v02 PmRef  Cpu0Hwp  00003000 INTL 20160527)
> ACPI: Dynamic OEM Table Load:
> ACPI: SSDT 0xFFFF9029AB095800 000724 (v02 PmRef  HwpLvt   00003000 INTL 20160527)
> ACPI: Dynamic OEM Table Load:
> ACPI: SSDT 0xFFFF9029AB096000 0005FC (v02 PmRef  ApIst    00003000 INTL 20160527)
> ACPI: Dynamic OEM Table Load:
> ACPI: SSDT 0xFFFF9029AB2CB000 000317 (v02 PmRef  ApHwp    00003000 INTL 20160527)
> ACPI: Dynamic OEM Table Load:
> ACPI: SSDT 0xFFFF9029AB098000 000AB0 (v02 PmRef  ApPsd    00003000 INTL 20160527)
> ACPI: Dynamic OEM Table Load:
> ACPI: SSDT 0xFFFF9029AB2CB400 00030A (v02 PmRef  ApCst    00003000 INTL 20160527)
> ACPI: Interpreter enabled
> ACPI: (supports S0 S3 S4 S5)
> ACPI: Using IOAPIC for interrupt routing
> PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> ACPI: Enabled 7 GPEs in block 00 to 7F
> ACPI: Power Resource [PXP] (on)
> ACPI: Power Resource [BTPR] (off)
> ACPI: Power Resource [USBC] (on)
> ACPI: Power Resource [V0PR] (on)
> ACPI: Power Resource [V1PR] (on)
> ACPI: Power Resource [V2PR] (on)
> ACPI: Power Resource [WRST] (on)
> ACPI: Power Resource [PIN] (off)
> ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7e])
> acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> acpi PNP0A08:00: _OSC: platform does not support [AER]
> acpi PNP0A08:00: _OSC: OS now controls [PME PCIeCapability LTR]
> PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3fff window]
> pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7fff window]
> pci_bus 0000:00: root bus resource [mem 0x000e8000-0x000ebfff window]
> pci_bus 0000:00: root bus resource [mem 0x000ec000-0x000effff window]
> pci_bus 0000:00: root bus resource [mem 0x000f0000-0x000fffff window]
> pci_bus 0000:00: root bus resource [mem 0x80000000-0xefffffff window]
> pci_bus 0000:00: root bus resource [mem 0x4000000000-0x7fffffffff window]
> pci_bus 0000:00: root bus resource [mem 0xfc800000-0xfe7fffff window]
> pci_bus 0000:00: root bus resource [bus 00-7e]
> pci 0000:00:00.0: [8086:3e34] type 00 class 0x060000
> pci 0000:00:02.0: [8086:3ea0] type 00 class 0x030000
> pci 0000:00:02.0: reg 0x10: [mem 0x604a000000-0x604affffff 64bit]
> pci 0000:00:02.0: reg 0x18: [mem 0x4000000000-0x400fffffff 64bit pref]
> pci 0000:00:02.0: reg 0x20: [io  0x3000-0x303f]
> pci 0000:00:02.0: BAR 2: assigned to efifb
> pci 0000:00:04.0: [8086:1903] type 00 class 0x118000
> pci 0000:00:04.0: reg 0x10: [mem 0x604b110000-0x604b117fff 64bit]
> pci 0000:00:08.0: [8086:1911] type 00 class 0x088000
> pci 0000:00:08.0: reg 0x10: [mem 0x604b12c000-0x604b12cfff 64bit]
> pci 0000:00:12.0: [8086:9df9] type 00 class 0x118000
> pci 0000:00:12.0: reg 0x10: [mem 0x604b12b000-0x604b12bfff 64bit]
> pci 0000:00:14.0: [8086:9ded] type 00 class 0x0c0330
> pci 0000:00:14.0: reg 0x10: [mem 0x604b100000-0x604b10ffff 64bit]
> pci 0000:00:14.0: PME# supported from D3hot D3cold
> pci 0000:00:14.2: [8086:9def] type 00 class 0x050000
> pci 0000:00:14.2: reg 0x10: [mem 0x604b120000-0x604b121fff 64bit]
> pci 0000:00:14.2: reg 0x18: [mem 0x604b12a000-0x604b12afff 64bit]
> pci 0000:00:14.3: [8086:9df0] type 00 class 0x028000
> pci 0000:00:14.3: reg 0x10: [mem 0x604b11c000-0x604b11ffff 64bit]
> pci 0000:00:14.3: PME# supported from D0 D3hot D3cold
> pci 0000:00:15.0: [8086:9de8] type 00 class 0x0c8000
> pci 0000:00:15.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
> pci 0000:00:15.1: [8086:9de9] type 00 class 0x0c8000
> pci 0000:00:15.1: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
> pci 0000:00:16.0: [8086:9de0] type 00 class 0x078000
> pci 0000:00:16.0: reg 0x10: [mem 0x604b127000-0x604b127fff 64bit]
> pci 0000:00:16.0: PME# supported from D3hot
> pci 0000:00:19.0: [8086:9dc5] type 00 class 0x0c8000
> pci 0000:00:19.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
> pci 0000:00:1c.0: [8086:9dbc] type 01 class 0x060400
> pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
> pci 0000:00:1d.0: [8086:9db4] type 01 class 0x060400
> pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
> pci 0000:00:1e.0: [8086:9da8] type 00 class 0x078000
> pci 0000:00:1e.0: reg 0x10: [mem 0x604b125000-0x604b125fff 64bit]
> pci 0000:00:1e.0: reg 0x18: [mem 0x604b124000-0x604b124fff 64bit]
> pci 0000:00:1e.2: [8086:9daa] type 00 class 0x0c8000
> pci 0000:00:1e.2: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
> pci 0000:00:1f.0: [8086:9d84] type 00 class 0x060100
> pci 0000:00:1f.3: [8086:9dc8] type 00 class 0x040380
> pci 0000:00:1f.3: reg 0x10: [mem 0x604b118000-0x604b11bfff 64bit]
> pci 0000:00:1f.3: reg 0x20: [mem 0x604b000000-0x604b0fffff 64bit]
> pci 0000:00:1f.3: PME# supported from D3hot D3cold
> pci 0000:00:1f.4: [8086:9da3] type 00 class 0x0c0500
> pci 0000:00:1f.4: reg 0x10: [mem 0x604b122000-0x604b1220ff 64bit]
> pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
> pci 0000:00:1f.5: [8086:9da4] type 00 class 0x0c8000
> pci 0000:00:1f.5: reg 0x10: [mem 0xfe010000-0xfe010fff]
> pci 0000:01:00.0: [8086:15d3] type 01 class 0x060400
> pci 0000:01:00.0: enabling Extended Tags
> pci 0000:01:00.0: supports D1 D2
> pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> pci 0000:00:1c.0: PCI bridge to [bus 01-6b]
> pci 0000:00:1c.0:   bridge window [mem 0x80000000-0xae0fffff]
> pci 0000:00:1c.0:   bridge window [mem 0x6000000000-0x6049ffffff 64bit pref]
> pci 0000:02:00.0: [8086:15d3] type 01 class 0x060400
> pci 0000:02:00.0: enabling Extended Tags
> pci 0000:02:00.0: supports D1 D2
> pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> pci 0000:02:01.0: [8086:15d3] type 01 class 0x060400
> pci 0000:02:01.0: enabling Extended Tags
> pci 0000:02:01.0: supports D1 D2
> pci 0000:02:01.0: PME# supported from D0 D1 D2 D3hot D3cold
> pci 0000:02:02.0: [8086:15d3] type 01 class 0x060400
> pci 0000:02:02.0: enabling Extended Tags
> pci 0000:02:02.0: supports D1 D2
> pci 0000:02:02.0: PME# supported from D0 D1 D2 D3hot D3cold
> pci 0000:02:04.0: [8086:15d3] type 01 class 0x060400
> pci 0000:02:04.0: enabling Extended Tags
> pci 0000:02:04.0: supports D1 D2
> pci 0000:02:04.0: PME# supported from D0 D1 D2 D3hot D3cold
> pci 0000:01:00.0: PCI bridge to [bus 02-6b]
> pci 0000:01:00.0:   bridge window [mem 0x80000000-0xae0fffff]
> pci 0000:01:00.0:   bridge window [mem 0x6000000000-0x6049ffffff 64bit pref]
> pci 0000:03:00.0: [8086:15d2] type 00 class 0x088000
> pci 0000:03:00.0: reg 0x10: [mem 0xae000000-0xae03ffff]
> pci 0000:03:00.0: reg 0x14: [mem 0xae040000-0xae040fff]
> pci 0000:03:00.0: enabling Extended Tags
> pci 0000:03:00.0: supports D1 D2
> pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> pci 0000:02:00.0: PCI bridge to [bus 03]
> pci 0000:02:00.0:   bridge window [mem 0xae000000-0xae0fffff]
> pci 0000:02:01.0: PCI bridge to [bus 04-36]
> pci 0000:02:01.0:   bridge window [mem 0x80000000-0x97efffff]
> pci 0000:02:01.0:   bridge window [mem 0x6000000000-0x601fffffff 64bit pref]
> pci 0000:37:00.0: [8086:15d4] type 00 class 0x0c0330
> pci 0000:37:00.0: reg 0x10: [mem 0x97f00000-0x97f0ffff]
> pci 0000:37:00.0: enabling Extended Tags
> pci 0000:37:00.0: supports D1 D2
> pci 0000:37:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> pci 0000:37:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s x4 link at 0000:02:02.0 (capable of 31.504 Gb/s with 8 GT/s x4 link)
> pci 0000:02:02.0: PCI bridge to [bus 37]
> pci 0000:02:02.0:   bridge window [mem 0x97f00000-0x97ffffff]
> pci 0000:02:04.0: PCI bridge to [bus 38-6b]
> pci 0000:02:04.0:   bridge window [mem 0x98000000-0xadffffff]
> pci 0000:02:04.0:   bridge window [mem 0x6020000000-0x6049ffffff 64bit pref]
> pci 0000:6c:00.0: [144d:a808] type 00 class 0x010802
> pci 0000:6c:00.0: reg 0x10: [mem 0xae200000-0xae203fff 64bit]
> pci 0000:00:1d.0: PCI bridge to [bus 6c]
> pci 0000:00:1d.0:   bridge window [mem 0xae200000-0xae2fffff]
> pci_bus 0000:00: on NUMA node 0
> ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 11 12 14 15) *0
> ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 10 11 12 14 15) *1
> ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 11 12 14 15) *0
> ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 11 12 14 15) *0
> ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 11 12 14 15) *0
> ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 11 12 14 15) *0
> ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 11 12 14 15) *0
> ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 11 12 14 15) *0
> ACPI: EC: interrupt unblocked
> ACPI: EC: event unblocked
> ACPI: \_SB_.PCI0.LPCB.EC0_: GPE=0x50, EC_CMD/EC_SC=0x66, EC_DATA=0x62
> ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC used to handle transactions and events
> pci 0000:00:02.0: vgaarb: setting as boot VGA device
> pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
> pci 0000:00:02.0: vgaarb: bridge control possible
> vgaarb: loaded
> ACPI: bus type USB registered
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> Registered efivars operations
> PCI: Using ACPI for IRQ routing
> PCI: pci_cache_line_size set to 64 bytes
> e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
> e820: reserve RAM buffer [mem 0x763fb000-0x77ffffff]
> e820: reserve RAM buffer [mem 0x7a40f000-0x7bffffff]
> e820: reserve RAM buffer [mem 0x47e000000-0x47fffffff]
> acpi PNP0C14:02: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:01)
> acpi PNP0C14:03: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:01)
> clocksource: Switched to clocksource tsc-early
> VFS: Disk quotas dquot_6.6.0
> VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> pnp: PnP ACPI init
> system 00:00: [mem 0x40000000-0x403fffff] could not be reserved
> system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
> system 00:01: [io  0x0680-0x069f] has been reserved
> system 00:01: [io  0x164e-0x164f] has been reserved
> system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
> system 00:02: [io  0x1854-0x1857] has been reserved
> system 00:02: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
> pnp 00:03: Plug and Play ACPI device, IDs ATK3001 PNP030b (active)
> system 00:04: [mem 0xfed10000-0xfed17fff] has been reserved
> system 00:04: [mem 0xfed18000-0xfed18fff] has been reserved
> system 00:04: [mem 0xfed19000-0xfed19fff] has been reserved
> system 00:04: [mem 0xf0000000-0xf7ffffff] has been reserved
> system 00:04: [mem 0xfed20000-0xfed3ffff] has been reserved
> system 00:04: [mem 0xfed90000-0xfed93fff] could not be reserved
> system 00:04: [mem 0xfed45000-0xfed8ffff] has been reserved
> system 00:04: [mem 0xfee00000-0xfeefffff] could not be reserved
> system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
> system 00:05: [io  0x1800-0x18fe] could not be reserved
> system 00:05: [mem 0xfd000000-0xfd69ffff] has been reserved
> system 00:05: [mem 0xfd6b0000-0xfd6cffff] has been reserved
> system 00:05: [mem 0xfd6f0000-0xfdffffff] has been reserved
> system 00:05: [mem 0xfe000000-0xfe01ffff] could not be reserved
> system 00:05: [mem 0xfe200000-0xfe7fffff] has been reserved
> system 00:05: [mem 0xff000000-0xffffffff] has been reserved
> system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
> system 00:06: [io  0x2000-0x20fe] has been reserved
> system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
> system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
> pnp: PnP ACPI: found 8 devices
> thermal_sys: Registered thermal governor 'fair_share'
> thermal_sys: Registered thermal governor 'step_wise'
> thermal_sys: Registered thermal governor 'user_space'
> thermal_sys: Registered thermal governor 'power_allocator'
> clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> pci 0000:02:01.0: bridge window [io  0x1000-0x0fff] to [bus 04-36] add_size 1000
> pci 0000:02:04.0: bridge window [io  0x1000-0x0fff] to [bus 38-6b] add_size 1000
> pci 0000:01:00.0: bridge window [io  0x1000-0x0fff] to [bus 02-6b] add_size 2000
> pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus 01-6b] add_size 3000
> pci 0000:00:15.0: BAR 0: assigned [mem 0x4010000000-0x4010000fff 64bit]
> pci 0000:00:15.1: BAR 0: assigned [mem 0x4010001000-0x4010001fff 64bit]
> pci 0000:00:19.0: BAR 0: assigned [mem 0x4010002000-0x4010002fff 64bit]
> pci 0000:00:1c.0: BAR 7: assigned [io  0x4000-0x6fff]
> pci 0000:00:1e.2: BAR 0: assigned [mem 0x4010003000-0x4010003fff 64bit]
> pci 0000:01:00.0: BAR 7: assigned [io  0x4000-0x5fff]
> pci 0000:02:01.0: BAR 7: assigned [io  0x4000-0x4fff]
> pci 0000:02:04.0: BAR 7: assigned [io  0x5000-0x5fff]
> pci 0000:02:00.0: PCI bridge to [bus 03]
> pci 0000:02:00.0:   bridge window [mem 0xae000000-0xae0fffff]
> pci 0000:02:01.0: PCI bridge to [bus 04-36]
> pci 0000:02:01.0:   bridge window [io  0x4000-0x4fff]
> pci 0000:02:01.0:   bridge window [mem 0x80000000-0x97efffff]
> pci 0000:02:01.0:   bridge window [mem 0x6000000000-0x601fffffff 64bit pref]
> pci 0000:02:02.0: PCI bridge to [bus 37]
> pci 0000:02:02.0:   bridge window [mem 0x97f00000-0x97ffffff]
> pci 0000:02:04.0: PCI bridge to [bus 38-6b]
> pci 0000:02:04.0:   bridge window [io  0x5000-0x5fff]
> pci 0000:02:04.0:   bridge window [mem 0x98000000-0xadffffff]
> pci 0000:02:04.0:   bridge window [mem 0x6020000000-0x6049ffffff 64bit pref]
> pci 0000:01:00.0: PCI bridge to [bus 02-6b]
> pci 0000:01:00.0:   bridge window [io  0x4000-0x5fff]
> pci 0000:01:00.0:   bridge window [mem 0x80000000-0xae0fffff]
> pci 0000:01:00.0:   bridge window [mem 0x6000000000-0x6049ffffff 64bit pref]
> pci 0000:00:1c.0: PCI bridge to [bus 01-6b]
> pci 0000:00:1c.0:   bridge window [io  0x4000-0x6fff]
> pci 0000:00:1c.0:   bridge window [mem 0x80000000-0xae0fffff]
> pci 0000:00:1c.0:   bridge window [mem 0x6000000000-0x6049ffffff 64bit pref]
> pci 0000:00:1d.0: PCI bridge to [bus 6c]
> pci 0000:00:1d.0:   bridge window [mem 0xae200000-0xae2fffff]
> pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
> pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
> pci_bus 0000:00: resource 7 [mem 0x000e0000-0x000e3fff window]
> pci_bus 0000:00: resource 8 [mem 0x000e4000-0x000e7fff window]
> pci_bus 0000:00: resource 9 [mem 0x000e8000-0x000ebfff window]
> pci_bus 0000:00: resource 10 [mem 0x000ec000-0x000effff window]
> pci_bus 0000:00: resource 11 [mem 0x000f0000-0x000fffff window]
> pci_bus 0000:00: resource 12 [mem 0x80000000-0xefffffff window]
> pci_bus 0000:00: resource 13 [mem 0x4000000000-0x7fffffffff window]
> pci_bus 0000:00: resource 14 [mem 0xfc800000-0xfe7fffff window]
> pci_bus 0000:01: resource 0 [io  0x4000-0x6fff]
> pci_bus 0000:01: resource 1 [mem 0x80000000-0xae0fffff]
> pci_bus 0000:01: resource 2 [mem 0x6000000000-0x6049ffffff 64bit pref]
> pci_bus 0000:02: resource 0 [io  0x4000-0x5fff]
> pci_bus 0000:02: resource 1 [mem 0x80000000-0xae0fffff]
> pci_bus 0000:02: resource 2 [mem 0x6000000000-0x6049ffffff 64bit pref]
> pci_bus 0000:03: resource 1 [mem 0xae000000-0xae0fffff]
> pci_bus 0000:04: resource 0 [io  0x4000-0x4fff]
> pci_bus 0000:04: resource 1 [mem 0x80000000-0x97efffff]
> pci_bus 0000:04: resource 2 [mem 0x6000000000-0x601fffffff 64bit pref]
> pci_bus 0000:37: resource 1 [mem 0x97f00000-0x97ffffff]
> pci_bus 0000:38: resource 0 [io  0x5000-0x5fff]
> pci_bus 0000:38: resource 1 [mem 0x98000000-0xadffffff]
> pci_bus 0000:38: resource 2 [mem 0x6020000000-0x6049ffffff 64bit pref]
> pci_bus 0000:6c: resource 1 [mem 0xae200000-0xae2fffff]
> NET: Registered protocol family 2
> tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes, linear)
> TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
> TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
> TCP: Hash tables configured (established 131072 bind 65536)
> UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
> UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, linear)
> NET: Registered protocol family 1
> pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
> pci 0000:01:00.0: CLS mismatch (64 != 128), using 64 bytes
> pci 0000:01:00.0: enabling device (0002 -> 0003)
> DMAR: No ATSR found
> DMAR: dmar0: Using Queued invalidation
> DMAR: dmar1: Using Queued invalidation
> pci 0000:00:00.0: Adding to iommu group 0
> pci 0000:00:02.0: Adding to iommu group 1
> pci 0000:00:04.0: Adding to iommu group 2
> pci 0000:00:08.0: Adding to iommu group 3
> pci 0000:00:12.0: Adding to iommu group 4
> pci 0000:00:14.0: Adding to iommu group 5
> pci 0000:00:14.2: Adding to iommu group 5
> pci 0000:00:14.3: Adding to iommu group 5
> pci 0000:00:15.0: Adding to iommu group 6
> pci 0000:00:15.1: Adding to iommu group 6
> pci 0000:00:16.0: Adding to iommu group 7
> pci 0000:00:19.0: Adding to iommu group 8
> pci 0000:00:1c.0: Adding to iommu group 9
> pci 0000:00:1c.0: Using iommu dma mapping
> pci 0000:00:1d.0: Adding to iommu group 10
> pci 0000:00:1e.0: Adding to iommu group 11
> pci 0000:00:1e.2: Adding to iommu group 11
> pci 0000:00:1f.0: Adding to iommu group 12
> pci 0000:00:1f.3: Adding to iommu group 12
> pci 0000:00:1f.4: Adding to iommu group 12
> pci 0000:00:1f.5: Adding to iommu group 12
> pci 0000:01:00.0: Adding to iommu group 13
> pci 0000:01:00.0: Using iommu dma mapping
> pci 0000:02:00.0: Adding to iommu group 14
> pci 0000:02:00.0: Using iommu dma mapping
> pci 0000:02:01.0: Adding to iommu group 15
> pci 0000:02:01.0: Using iommu dma mapping
> pci 0000:02:02.0: Adding to iommu group 16
> pci 0000:02:02.0: Using iommu dma mapping
> pci 0000:02:04.0: Adding to iommu group 17
> pci 0000:02:04.0: Using iommu dma mapping
> pci 0000:03:00.0: Adding to iommu group 14
> pci 0000:37:00.0: Adding to iommu group 16
> pci 0000:6c:00.0: Adding to iommu group 18
> DMAR: Intel(R) Virtualization Technology for Directed I/O
> RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters, 655360 ms ovfl timer
> RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
> RAPL PMU: hw unit of domain package 2^-14 Joules
> RAPL PMU: hw unit of domain dram 2^-14 Joules
> RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
> RAPL PMU: hw unit of domain psys 2^-14 Joules
> platform rtc_cmos: registered platform RTC device (no PNP device found)
> Initialise system trusted keyrings
> workingset: timestamp_bits=46 max_order=22 bucket_order=0
> NET: Registered protocol family 38
> Key type asymmetric registered
> Asymmetric key parser 'x509' registered
> Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
> pcieport 0000:00:1c.0: PME: Signaling with IRQ 122
> pcieport 0000:00:1d.0: PME: Signaling with IRQ 123
> pcieport 0000:02:01.0: enabling device (0002 -> 0003)
> pcieport 0000:02:04.0: enabling device (0002 -> 0003)
> efifb: probing for efifb
> efifb: framebuffer at 0x4000000000, using 8100k, total 8100k
> efifb: mode is 1920x1080x32, linelength=7680, pages=1
> efifb: scrolling: redraw
> efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
> fbcon: Deferring console take-over
> fb0: EFI VGA frame buffer device
> intel_idle: MWAIT substates: 0x11142120
> intel_idle: v0.4.1 model 0x8E
> intel_idle: lapic_timer_reliable_states 0xffffffff
> input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:19/PNP0C09:01/PNP0C0D:00/input/input0
> ACPI: Lid Switch [LID]
> input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input1
> ACPI: Sleep Button [SLPB]
> input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input2
> ACPI: Power Button [PWRB]
> input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
> ACPI: Power Button [PWRF]
> Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [drm] VT-d active for gfx access
> checking generic (4000000000 7e9000) vs hw (4000000000 10000000)
> fb0: switching to inteldrmfb from EFI VGA
> i915 0000:00:02.0: vgaarb: deactivate vga console
> [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [drm] Driver supports precise vblank timestamp query.
> i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
> [drm] Finished loading DMC firmware i915/kbl_dmc_ver1_04.bin (v1.4)
> [drm] HuC: Loaded firmware i915/kbl_huc_ver02_00_1810.bin (version 2.0)
> [drm] GuC: Loaded firmware i915/kbl_guc_32.0.3.bin (version 32.0)
> [drm] CT: enabled
> i915 0000:00:02.0: GuC firmware version 32.0
> i915 0000:00:02.0: GuC submission disabled
> i915 0000:00:02.0: HuC enabled
> [drm] Initialized i915 1.6.0 20190619 for 0000:00:02.0 on minor 0
> ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
> input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input4
> nvme nvme0: pci function 0000:6c:00.0
> i8042: PNP: PS/2 Controller [PNP030b:PS2K] at 0x60,0x64 irq 1
> i8042: PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
> serio: i8042 KBD port at 0x60,0x64 irq 1
> mousedev: PS/2 mouse device common for all mice
> device-mapper: ioctl: 4.40.0-ioctl (2019-01-18) initialised: dm-devel@redhat.com
> intel_pstate: Intel P-state driver initializing
> intel_pstate: HWP enabled
> ledtrig-cpu: registered to indicate activity on CPUs
> hidraw: raw HID events driver (C) Jiri Kosina
> asus_wmi: ASUS WMI generic driver loaded
> asus_wmi: Initialization: 0x1
> asus_wmi: BIOS WMI version: 9.0
> asus_wmi: SFUN value: 0x21
> asus-nb-wmi asus-nb-wmi: Detected ATK, not ASUSWMI, use DSTS
> asus-nb-wmi asus-nb-wmi: Detected ATK, enable event queue
> input: Asus WMI hotkeys as /devices/platform/asus-nb-wmi/input/input6
> asus_wmi: Number of fans: 0
> NET: Registered protocol family 10
> Segment Routing with IPv6
> microcode: sig=0x806eb, pf=0x80, revision=0x9a
> microcode: Microcode Update Driver: v2.2.
> AVX2 version of gcm_enc/dec engaged.
> AES CTR mode by8 optimization enabled
> input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input5
> sched_clock: Marking stable (680292057, 3858581)->(687247470, -3096832)
> registered taskstats version 1
> Loading compiled-in X.509 certificates
> Loaded X.509 cert 'uefikey: a94102dc02a4f23db70b7002f01d387559cd00fa'
> fbcon: i915drmfb (fb0) is primary device
> fbcon: Deferring console take-over
> i915 0000:00:02.0: fb0: i915drmfb frame buffer device
> Key type big_key registered
> nvme nvme0: Shutdown timeout set to 8 seconds
> nvme nvme0: 8/0/0 default/read/poll queues
>  nvme0n1: p1 p2
> Freeing unused kernel image memory: 12600K
> Write protecting the kernel read-only data: 16384k
> Freeing unused kernel image memory: 2028K
> Freeing unused kernel image memory: 1164K
> Run /init as init process
> systemd[1]: systemd 243 running in system mode. (+PAM -AUDIT -SELINUX +IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL -XZ +LZ4 +SECCOMP +BLKID -ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=unified)
> systemd[1]: Detected architecture x86-64.
> systemd[1]: Running in initial RAM disk.
> systemd[1]: Set hostname to <n>.
> systemd[1]: Created slice system-systemd\x2dcryptsetup.slice.
> systemd[1]: Created slice system-systemd\x2dhibernate\x2dresume.slice.
> systemd[1]: Reached target Slices.
> systemd[1]: Reached target Swap.
> systemd[1]: Reached target Timers.
> systemd[1]: Listening on Journal Audit Socket.
> xhci_hcd 0000:00:14.0: xHCI Host Controller
> xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
> xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x110 quirks 0x0000000000009810
> xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
> usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.03
> usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb1: Product: xHCI Host Controller
> usb usb1: Manufacturer: Linux 5.3.11-gentoo xhci-hcd
> usb usb1: SerialNumber: 0000:00:14.0
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 12 ports detected
> xhci_hcd 0000:00:14.0: xHCI Host Controller
> xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
> xhci_hcd 0000:00:14.0: Host supports USB 3.1 Enhanced SuperSpeed
> usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.03
> usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb2: Product: xHCI Host Controller
> usb usb2: Manufacturer: Linux 5.3.11-gentoo xhci-hcd
> usb usb2: SerialNumber: 0000:00:14.0
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 6 ports detected
> xhci_hcd 0000:37:00.0: xHCI Host Controller
> xhci_hcd 0000:37:00.0: new USB bus registered, assigned bus number 3
> xhci_hcd 0000:37:00.0: hcc params 0x200077c1 hci version 0x110 quirks 0x0000000200009810
> usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.03
> usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb3: Product: xHCI Host Controller
> usb usb3: Manufacturer: Linux 5.3.11-gentoo xhci-hcd
> usb usb3: SerialNumber: 0000:37:00.0
> hub 3-0:1.0: USB hub found
> hub 3-0:1.0: 2 ports detected
> xhci_hcd 0000:37:00.0: xHCI Host Controller
> xhci_hcd 0000:37:00.0: new USB bus registered, assigned bus number 4
> xhci_hcd 0000:37:00.0: Host supports USB 3.1 Enhanced SuperSpeed
> usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.03
> usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb4: Product: xHCI Host Controller
> usb usb4: Manufacturer: Linux 5.3.11-gentoo xhci-hcd
> usb usb4: SerialNumber: 0000:37:00.0
> hub 4-0:1.0: USB hub found
> hub 4-0:1.0: 2 ports detected
> random: systemd-cryptse: uninitialized urandom read (4 bytes read)
> tsc: Refined TSC clocksource calibration: 1991.999 MHz
> clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x396d4ffc055, max_idle_ns: 881590662783 ns
> clocksource: Switched to clocksource tsc
> usb 1-5: new high-speed USB device number 2 using xhci_hcd
> usb 1-5: New USB device found, idVendor=13d3, idProduct=56b9, bcdDevice=18.51
> usb 1-5: New USB device strings: Mfr=3, Product=1, SerialNumber=2
> usb 1-5: Product: USB2.0 HD UVC WebCam
> usb 1-5: Manufacturer: Azurewave
> usb 1-5: SerialNumber: 0x0001
> usb 1-9: new full-speed USB device number 3 using xhci_hcd
> usb 1-9: New USB device found, idVendor=27c6, idProduct=5201, bcdDevice= 1.00
> usb 1-9: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> usb 1-9: Product: Goodix Fingerprint Device 
> usb 1-9: Manufacturer: HTMicroelectronics
> usb 1-9: SerialNumber: HTK32
> usb 1-10: new full-speed USB device number 4 using xhci_hcd
> usb 1-10: config 1 interface 1 altsetting 0 endpoint 0x3 has wMaxPacketSize 0, skipping
> usb 1-10: config 1 interface 1 altsetting 0 endpoint 0x83 has wMaxPacketSize 0, skipping
> usb 1-10: New USB device found, idVendor=8087, idProduct=0aaa, bcdDevice= 0.02
> usb 1-10: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> random: crng init done
> EXT4-fs (dm-0): mounted filesystem with ordered data mode. Opts: (null)
> systemd-journald[247]: Received SIGTERM from PID 1 (systemd).
> printk: systemd: 24 output lines suppressed due to ratelimiting
> systemd[1]: systemd 243 running in system mode. (+PAM -AUDIT -SELINUX +IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL -XZ +LZ4 +SECCOMP +BLKID -ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=unified)
> systemd[1]: Detected architecture x86-64.
> systemd[1]: Set hostname to <n>.
> systemd[1]: initrd-switch-root.service: Succeeded.
> systemd[1]: Stopped Switch Root.
> systemd[1]: systemd-journald.service: Service has no hold-off time (RestartSec=0), scheduling restart.
> systemd[1]: systemd-journald.service: Scheduled restart job, restart counter is at 1.
> systemd[1]: Created slice system-dnsmasq\x2dlibvirt.slice.
> systemd[1]: Created slice system-getty.slice.
> systemd[1]: Created slice system-systemd\x2dfsck.slice.
> EXT4-fs (dm-0): re-mounted. Opts: (null)
> systemd-journald[560]: Received client request to flush runtime journal.
> Adding 8388604k swap on /var/swap1.  Priority:-2 extents:11 across:9035772k SS
> intel_pmc_core INT33A1:00:  initialized
> ACPI Warning: \_SB.IETM._TRT: Return Package has no elements (empty) (20190703/nsprepkg-94)
> ACPI: AC Adapter [AC0] (off-line)
> battery: ACPI: Battery Slot [BAT0] (battery present)
> thermal LNXTHERM:00: registered as thermal_zone5
> ACPI: Thermal Zone [THRM] (54 C)
> intel-lpss 0000:00:15.0: enabling device (0000 -> 0002)
> proc_thermal 0000:00:04.0: enabling device (0000 -> 0002)
> intel_rapl_common: Found RAPL domain package
> intel_rapl_common: Found RAPL domain dram
> mei_me 0000:00:16.0: enabling device (0000 -> 0002)
> cdc_acm 1-9:1.0: ttyACM0: USB ACM device
> idma64 idma64.0: Found Intel integrated DMA 64-bit
> intel-lpss 0000:00:15.1: enabling device (0000 -> 0002)
> idma64 idma64.1: Found Intel integrated DMA 64-bit
> intel-lpss 0000:00:19.0: enabling device (0000 -> 0002)
> usbcore: registered new interface driver cdc_acm
> cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
> proc_thermal 0000:00:04.0: Creating sysfs group for PROC_THERMAL_PCI
> cfg80211: Loading compiled-in X.509 certificates for regulatory database
> cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> videodev: Linux video capture interface: v2.00
> i801_smbus 0000:00:1f.4: SPD Write Disable is set
> i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
> intel-lpss 0000:00:1e.0: enabling device (0000 -> 0002)
> idma64 idma64.3: Found Intel integrated DMA 64-bit
> intel-lpss 0000:00:1e.2: enabling device (0000 -> 0002)
> idma64 idma64.4: Found Intel integrated DMA 64-bit
> Bluetooth: Core ver 2.22
> NET: Registered protocol family 31
> Bluetooth: HCI device and connection manager initialized
> Bluetooth: HCI socket layer initialized
> Bluetooth: L2CAP socket layer initialized
> Bluetooth: SCO socket layer initialized
> EFI Variables Facility v0.08 2004-May-17
> Intel(R) Wireless WiFi driver for Linux
> Copyright(c) 2003- 2015 Intel Corporation
> input: PC Speaker as /devices/platform/pcspkr/input/input7
> iwlwifi 0000:00:14.3: Found debug destination: EXTERNAL_DRAM
> iwlwifi 0000:00:14.3: Found debug configuration: 0
> iwlwifi 0000:00:14.3: loaded firmware version 46.6bf1df06.0 op_mode iwlmvm
> snd_hda_intel 0000:00:1f.3: enabling device (0000 -> 0002)
> snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops 0xffffffff93ca9a10)
> snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC294: line_outs=1 (0x17/0x0/0x0/0x0/0x0) type:speaker
> snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
> snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
> snd_hda_codec_realtek hdaudioC0D0:    inputs:
> snd_hda_codec_realtek hdaudioC0D0:      Headset Mic=0x19
> snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x12
> uvcvideo: Found UVC 1.00 device USB2.0 HD UVC WebCam (13d3:56b9)
> input: USB2.0 HD UVC WebCam: USB2.0 HD as /devices/pci0000:00/0000:00:14.0/usb1/1-5/1-5:1.0/input/input8
> usbcore: registered new interface driver uvcvideo
> USB Video Class driver (1.1.1)
> usbcore: registered new interface driver btusb
> Bluetooth: hci0: Firmware revision 0.1 build 233 week 36 2019
> intel_rapl_common: Found RAPL domain package
> intel_rapl_common: Found RAPL domain core
> intel_rapl_common: Found RAPL domain uncore
> intel_rapl_common: Found RAPL domain dram
> pstore: Using crash dump compression: deflate
> iwlwifi 0000:00:14.3: Detected Intel(R) Dual Band Wireless AC 9560, REV=0x318
> iwlwifi 0000:00:14.3: Applying debug destination EXTERNAL_DRAM
> iwlwifi 0000:00:14.3: Allocated 0x00400000 bytes for firmware monitor.
> iwlwifi 0000:00:14.3: base HW address: f4:d1:08:ad:95:94
> pstore: Registered efi as persistent store backend
> input: GDX1301:00 27C6:01F0 Mouse as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-9/i2c-GDX1301:00/0018:27C6:01F0.0001/input/input9
> input: GDX1301:00 27C6:01F0 Touchpad as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-9/i2c-GDX1301:00/0018:27C6:01F0.0001/input/input10
> hid-generic 0018:27C6:01F0.0001: input,hidraw0: I2C HID v1.00 Mouse [GDX1301:00 27C6:01F0] on i2c-GDX1301:00
> ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
> thermal thermal_zone9: failed to read out thermal zone (-61)
> iwlwifi 0000:00:14.3 wlo1: renamed from wlan0
> input: GDX1301:00 27C6:01F0 Touchpad as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-9/i2c-GDX1301:00/0018:27C6:01F0.0001/input/input13
> hid-multitouch 0018:27C6:01F0.0001: input,hidraw0: I2C HID v1.00 Mouse [GDX1301:00 27C6:01F0] on i2c-GDX1301:00
> Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> Bluetooth: BNEP filters: protocol multicast
> Bluetooth: BNEP socket layer initialized
> input: HDA Intel PCH Headset Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input15
> input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1f.3/sound/card0/input16
> input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input17
> input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input18
> input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input19
> input: HDA Intel PCH HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input20
> input: HDA Intel PCH HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input21
> kexec_file: kernel signature verification successful.
> kexec_file: Crash PT_LOAD elf header. phdr=00000000d4b931f7 vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=11 p_offset=0x0
> kexec_file: Crash PT_LOAD elf header. phdr=00000000f3da1dbd vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=12 p_offset=0x0
> kexec_file: Crash PT_LOAD elf header. phdr=0000000009bf4f09 vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=13 p_offset=0x0
> kexec_file: Crash PT_LOAD elf header. phdr=0000000011040002 vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=14 p_offset=0x0
> kexec_file: Crash PT_LOAD elf header. phdr=00000000d306bbba vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=15 p_offset=0x0
> kexec_file: Loading segment 0: buf=0x00000000ef1fddf8 bufsz=0x8 mem=0x65000000 memsz=0x9e000
> kexec_file: Loading segment 1: buf=0x00000000616da148 bufsz=0x1000 mem=0x6509e000 memsz=0x1000
> kexec_file: Loading segment 2: buf=0x000000004180c568 bufsz=0x5000 mem=0x6aff9000 memsz=0x6000
> kexec_file: Loading segment 3: buf=0x00000000250810fd bufsz=0x1240 mem=0x6aff7000 memsz=0x2000
> kexec_file: Loading segment 4: buf=0x00000000e96b7941 bufsz=0xdbc888 mem=0x69000000 memsz=0x1b50000
> tun: Universal TUN/TAP device driver, 1.6
> bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
> virbr3: port 1(virbr3-nic) entered blocking state
> virbr3: port 1(virbr3-nic) entered disabled state
> device virbr3-nic entered promiscuous mode
> virbr0: port 1(virbr0-nic) entered blocking state
> virbr0: port 1(virbr0-nic) entered disabled state
> device virbr0-nic entered promiscuous mode
> virbr2: port 1(virbr2-nic) entered blocking state
> virbr2: port 1(virbr2-nic) entered disabled state
> device virbr2-nic entered promiscuous mode
> virbr1: port 1(virbr1-nic) entered blocking state
> virbr1: port 1(virbr1-nic) entered disabled state
> device virbr1-nic entered promiscuous mode
> virbr3: port 1(virbr3-nic) entered blocking state
> virbr3: port 1(virbr3-nic) entered listening state
> virbr0: port 1(virbr0-nic) entered blocking state
> virbr0: port 1(virbr0-nic) entered listening state
> virbr2: port 1(virbr2-nic) entered blocking state
> virbr2: port 1(virbr2-nic) entered listening state
> NET: Registered protocol family 17
> virbr2: port 1(virbr2-nic) entered disabled state
> virbr0: port 1(virbr0-nic) entered disabled state
> virbr3: port 1(virbr3-nic) entered disabled state
> broken atomic modeset userspace detected, disabling atomic
> Bluetooth: RFCOMM TTY layer initialized
> Bluetooth: RFCOMM socket layer initialized
> Bluetooth: RFCOMM ver 1.11
> kexec_file: kernel signature verification successful.
> kexec_file: Loading segment 0: buf=0x00000000e99b31ad bufsz=0x5000 mem=0x91000 memsz=0x6000
> kexec_file: Loading segment 1: buf=0x00000000e45cdeb8 bufsz=0x1240 mem=0x8f000 memsz=0x2000
> kexec_file: Loading segment 2: buf=0x00000000096e6de9 bufsz=0x1133888 mem=0x73000000 memsz=0x249a000
>
> Boot messages on kexec boot:
> Linux version 5.3.11-gentoo (m@n) (gcc version 9.2.0 (Gentoo 9.2.0-r2 p3)) #29 SMP Thu Nov 21 20:40:28 CET 2019
> Command line: 
> x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
> x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
> x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
> x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
> x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
> BIOS-provided physical RAM map:
> BIOS-e820: [mem 0x0000000000000000-0x000000000009efff] usable
> BIOS-e820: [mem 0x000000000009f000-0x00000000000fffff] reserved
> BIOS-e820: [mem 0x0000000000100000-0x00000000763fafff] usable
> BIOS-e820: [mem 0x00000000763fb000-0x0000000079979fff] reserved
> BIOS-e820: [mem 0x000000007997a000-0x00000000799f6fff] ACPI data
> BIOS-e820: [mem 0x00000000799f7000-0x0000000079aabfff] ACPI NVS
> BIOS-e820: [mem 0x0000000079aac000-0x000000007a40dfff] reserved
> BIOS-e820: [mem 0x000000007a40e000-0x000000007a40efff] usable
> BIOS-e820: [mem 0x000000007a40f000-0x000000007fffffff] reserved
> BIOS-e820: [mem 0x00000000f0000000-0x00000000f7ffffff] reserved
> BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
> BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
> BIOS-e820: [mem 0x00000000fed00000-0x00000000fed03fff] reserved
> BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
> BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
> BIOS-e820: [mem 0x0000000100000000-0x000000047dffffff] usable
> NX (Execute Disable) protection: active
> e820: update [mem 0x000971d0-0x0009723f] usable ==> usable
> e820: update [mem 0x000971d0-0x0009723f] usable ==> usable
> extended physical RAM map:
> reserve setup_data: [mem 0x0000000000000000-0x00000000000971cf] usable
> reserve setup_data: [mem 0x00000000000971d0-0x000000000009723f] usable
> reserve setup_data: [mem 0x0000000000097240-0x000000000009efff] usable
> reserve setup_data: [mem 0x000000000009f000-0x00000000000fffff] reserved
> reserve setup_data: [mem 0x0000000000100000-0x00000000763fafff] usable
> reserve setup_data: [mem 0x00000000763fb000-0x0000000079979fff] reserved
> reserve setup_data: [mem 0x000000007997a000-0x00000000799f6fff] ACPI data
> reserve setup_data: [mem 0x00000000799f7000-0x0000000079aabfff] ACPI NVS
> reserve setup_data: [mem 0x0000000079aac000-0x000000007a40dfff] reserved
> reserve setup_data: [mem 0x000000007a40e000-0x000000007a40efff] usable
> reserve setup_data: [mem 0x000000007a40f000-0x000000007fffffff] reserved
> reserve setup_data: [mem 0x00000000f0000000-0x00000000f7ffffff] reserved
> reserve setup_data: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
> reserve setup_data: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
> reserve setup_data: [mem 0x00000000fed00000-0x00000000fed03fff] reserved
> reserve setup_data: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
> reserve setup_data: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
> reserve setup_data: [mem 0x0000000100000000-0x000000047dffffff] usable
> efi: EFI v2.70 by American Megatrends
> efi:  ACPI 2.0=0x79993000  ACPI=0x79993000  TPMFinalLog=0x79a35000  SMBIOS=0x7a1cf000  SMBIOS 3.0=0x7a1ce000  ESRT=0x74dd6f98  TPMEventLog=0x6d634018 
> efi: mem00: [Memory Mapped I/O  |RUN|  |  |  |  |WP|  |   |WB|WT|  |UC] range=[0x00000000ff000000-0x00000000ffffffff] (16MB)
> efi: mem01: [Memory Mapped I/O  |RUN|  |  |  |  |  |  |   |  |  |  |UC] range=[0x00000000fee00000-0x00000000fee00fff] (0MB)
> efi: mem02: [Memory Mapped I/O  |RUN|  |  |  |  |WP|  |   |WB|WT|  |UC] range=[0x00000000fed00000-0x00000000fed03fff] (0MB)
> efi: mem03: [Memory Mapped I/O  |RUN|  |  |  |  |WP|  |   |WB|WT|  |UC] range=[0x00000000fec00000-0x00000000fec00fff] (0MB)
> efi: mem04: [Memory Mapped I/O  |RUN|  |  |  |  |  |  |   |  |  |  |UC] range=[0x00000000fe000000-0x00000000fe010fff] (0MB)
> efi: mem05: [Memory Mapped I/O  |RUN|  |  |  |  |WP|  |   |WB|WT|  |UC] range=[0x00000000f0000000-0x00000000f7ffffff] (128MB)
> efi: mem06: [Runtime Code       |RUN|  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x000000007a317000-0x000000007a40dfff] (0MB)
> efi: mem07: [Runtime Data       |RUN|  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000079aac000-0x000000007a316fff] (8MB)
> efi: mem08: [Boot Data          |RUN|  |  |  |  |  |  |   |WB|WT|WC|UC] range=[0x0000000074dd6000-0x0000000074dd6fff] (0MB)
> SMBIOS 3.2.1 present.
> DMI: ASUSTeK COMPUTER INC. ZenBook UX391FA_UX391FA/UX391FA, BIOS UX391FA.301 02/14/2019
> tsc: Detected 2000.000 MHz processor
> tsc: Detected 1999.968 MHz TSC
> e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> e820: remove [mem 0x000a0000-0x000fffff] usable
> last_pfn = 0x47e000 max_arch_pfn = 0x400000000
> MTRR default type: write-back
> MTRR fixed ranges enabled:
>   00000-9FFFF write-back
>   A0000-BFFFF uncachable
>   C0000-FFFFF write-back
> MTRR variable ranges enabled:
>   0 base 0080000000 mask 7F80000000 uncachable
>   1 base 007C000000 mask 7FFC000000 uncachable
>   2 base 007B800000 mask 7FFF800000 uncachable
>   3 base 2000000000 mask 6000000000 uncachable
>   4 base 1000000000 mask 7000000000 uncachable
>   5 base 0800000000 mask 7800000000 uncachable
>   6 base 4000000000 mask 4000000000 uncachable
>   7 disabled
>   8 disabled
>   9 disabled
> x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
> last_pfn = 0x7a40f max_arch_pfn = 0x400000000
> esrt: Unsupported ESRT version 2904149718861218184.
> Using GB pages for direct mapping
> BRK [0x75201000, 0x75201fff] PGTABLE
> BRK [0x75202000, 0x75202fff] PGTABLE
> BRK [0x75203000, 0x75203fff] PGTABLE
> BRK [0x75204000, 0x75204fff] PGTABLE
> BRK [0x75205000, 0x75205fff] PGTABLE
> BRK [0x75206000, 0x75206fff] PGTABLE
> Secure boot could not be determined
> ACPI: Early table checksum verification disabled
> ACPI: RSDP 0x0000000079993000 000024 (v02 _ASUS_)
> ACPI: XSDT 0x00000000799930B0 0000E4 (v01 _ASUS_ Notebook 01072009 AMI  00010013)
> ACPI: FACP 0x00000000799D7EF8 000114 (v06 _ASUS_ Notebook 01072009 AMI  00010013)
> ACPI: DSDT 0x0000000079993228 044CCB (v02 _ASUS_ Notebook 01072009 INTL 20160527)
> ACPI: FACS 0x0000000079AAA080 000040
> ACPI: APIC 0x00000000799D8010 0000BC (v04 _ASUS_ Notebook 01072009 AMI  00010013)
> ACPI: FPDT 0x00000000799D80D0 000044 (v01 _ASUS_ Notebook 01072009 AMI  00010013)
> ACPI: FIDT 0x00000000799D8118 00009C (v01 _ASUS_ Notebook 01072009 AMI  00010013)
> ACPI: MCFG 0x00000000799D81B8 00003C (v01 _ASUS_ Notebook 01072009 MSFT 00000097)
> ACPI: ECDT 0x00000000799D81F8 0000C1 (v01 _ASUS_ Notebook 01072009 AMI. 00000005)
> ACPI: SSDT 0x00000000799D82C0 005428 (v02 DptfTa DptfTabl 00001000 INTL 20160527)
> ACPI: SSDT 0x00000000799DD6E8 001B1C (v02 CpuRef CpuSsdt  00003000 INTL 20160527)
> ACPI: MSDM 0x00000000799DF208 000055 (v03 _ASUS_ Notebook 01072009 ASUS 00000001)
> ACPI: SSDT 0x00000000799DF260 0031C6 (v02 SaSsdt SaSsdt   00003000 INTL 20160527)
> ACPI: HPET 0x00000000799E2428 000038 (v01 _ASUS_ Notebook 00000002      01000013)
> ACPI: SSDT 0x00000000799E2460 003047 (v02 INTEL  xh_whld4 00000000 INTL 20160527)
> ACPI: UEFI 0x00000000799E54A8 000042 (v01 _ASUS_ Notebook 00000002      01000013)
> ACPI: LPIT 0x00000000799E54F0 00005C (v01 _ASUS_ Notebook 00000002      01000013)
> ACPI: SSDT 0x00000000799E5550 000FFB (v02 _ASUS_ TbtTypeC 00000000 INTL 20160527)
> ACPI: DBGP 0x00000000799E6550 000034 (v01 _ASUS_ Notebook 00000002      01000013)
> ACPI: DBG2 0x00000000799E6588 000054 (v00 _ASUS_ Notebook 00000002      01000013)
> ACPI: SSDT 0x00000000799E65E0 000E0B (v02 _ASUS_ UsbCTabl 00001000 INTL 20160527)
> ACPI: SSDT 0x00000000799E73F0 000144 (v02 Intel  ADebTabl 00001000 INTL 20160527)
> ACPI: NHLT 0x00000000799E7538 00002D (v00 INTEL  EDK2     00000002      01000013)
> ACPI: BGRT 0x00000000799E7568 000038 (v01 _ASUS_ Notebook 01072009 AMI  00010013)
> ACPI: TPM2 0x00000000799E75A0 000034 (v04 _ASUS_ Notebook 00000001 AMI  00000000)
> ACPI: DMAR 0x00000000799E75D8 0000A8 (v01 INTEL  EDK2     00000002      01000013)
> ACPI: WSMT 0x00000000799E7680 000028 (v01 _ASUS_ Notebook 01072009 AMI  00010013)
> ACPI: Local APIC address 0xfee00000
> Reserving 96MB of memory at 1648MB for crashkernel (System RAM: 16195MB)
> Zone ranges:
>   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
>   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
>   Normal   [mem 0x0000000100000000-0x000000047dffffff]
> Movable zone start for each node
> Early memory node ranges
>   node   0: [mem 0x0000000000001000-0x000000000009efff]
>   node   0: [mem 0x0000000000100000-0x00000000763fafff]
>   node   0: [mem 0x000000007a40e000-0x000000007a40efff]
>   node   0: [mem 0x0000000100000000-0x000000047dffffff]
> Zeroed struct page in unavailable ranges: 40038 pages
> Initmem setup node 0 [mem 0x0000000000001000-0x000000047dffffff]
> On node 0 totalpages: 4146074
>   DMA zone: 64 pages used for memmap
>   DMA zone: 22 pages reserved
>   DMA zone: 3998 pages, LIFO batch:0
>   DMA32 zone: 7504 pages used for memmap
>   DMA32 zone: 480252 pages, LIFO batch:63
>   Normal zone: 57216 pages used for memmap
>   Normal zone: 3661824 pages, LIFO batch:63
> Reserving Intel graphics memory at [mem 0x7c000000-0x7fffffff]
> ACPI: PM-Timer IO Port: 0x1808
> ACPI: Local APIC address 0xfee00000
> ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
> ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
> ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
> ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
> ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
> ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
> ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
> IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
> ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> ACPI: IRQ0 used by override.
> ACPI: IRQ9 used by override.
> Using ACPI (MADT) for SMP configuration information
> ACPI: HPET id: 0x8086a201 base: 0xfed00000
> smpboot: Allowing 8 CPUs, 0 hotplug CPUs
> PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
> PM: Registered nosave memory: [mem 0x00097000-0x00097fff]
> PM: Registered nosave memory: [mem 0x00097000-0x00097fff]
> PM: Registered nosave memory: [mem 0x0009f000-0x000fffff]
> PM: Registered nosave memory: [mem 0x763fb000-0x79979fff]
> PM: Registered nosave memory: [mem 0x7997a000-0x799f6fff]
> PM: Registered nosave memory: [mem 0x799f7000-0x79aabfff]
> PM: Registered nosave memory: [mem 0x79aac000-0x7a40dfff]
> PM: Registered nosave memory: [mem 0x7a40f000-0x7fffffff]
> PM: Registered nosave memory: [mem 0x80000000-0xefffffff]
> PM: Registered nosave memory: [mem 0xf0000000-0xf7ffffff]
> PM: Registered nosave memory: [mem 0xf8000000-0xfdffffff]
> PM: Registered nosave memory: [mem 0xfe000000-0xfe010fff]
> PM: Registered nosave memory: [mem 0xfe011000-0xfebfffff]
> PM: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
> PM: Registered nosave memory: [mem 0xfec01000-0xfecfffff]
> PM: Registered nosave memory: [mem 0xfed00000-0xfed03fff]
> PM: Registered nosave memory: [mem 0xfed04000-0xfedfffff]
> PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
> PM: Registered nosave memory: [mem 0xfee01000-0xfeffffff]
> PM: Registered nosave memory: [mem 0xff000000-0xffffffff]
> [mem 0x80000000-0xefffffff] available for PCI devices
> clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370452778343963 ns
> setup_percpu: NR_CPUS:8 nr_cpumask_bits:8 nr_cpu_ids:8 nr_node_ids:1
> percpu: Embedded 51 pages/cpu s170776 r8192 d29928 u262144
> pcpu-alloc: s170776 r8192 d29928 u262144 alloc=1*2097152
> pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
> Built 1 zonelists, mobility grouping on.  Total pages: 4081268
> Kernel command line: root=UUID=97bd2b14-ed61-436f-94ed-e9d5d5c21be4 rd.luks.uuid=8a530094-03c0-44ab-a589-7461160dcbc3 rd.luks.allow-discards=8a530094-03c0-44ab-a589-7461160dcbc3 mem_sleep_default=deep resume=UUID=97bd2b14-ed61-436f-94ed-e9d5d5c21be4 resume_offset=96256 quiet splash rd.systemd.show_status=auto i915.enable_guc=2 i915.enable_fbc=1 i915.enable_psr=0 vt.global_cursor_default=0 crashkernel=96M efi=debug
> Setting dangerous option i915.enable_guc - tainting kernel
> Setting dangerous option i915.enable_fbc - tainting kernel
> Setting dangerous option i915.enable_psr - tainting kernel
> Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
> Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
> mem auto-init: stack:byref_all, heap alloc:on, heap free:off
> Memory: 16096644K/16584296K available (10243K kernel code, 847K rwdata, 2932K rodata, 12600K init, 2268K bss, 487652K reserved, 0K cma-reserved)
> rcu: Hierarchical RCU implementation.
> rcu: RCU calculated value of scheduler-enlistment delay is 30 jiffies.
> NR_IRQS: 4352, nr_irqs: 2048, preallocated irqs: 16
> random: get_random_bytes called from start_kernel+0x399/0x555 with crng_init=0
> Console: colour dummy device 80x25
> printk: console [tty0] enabled
> ACPI: Core revision 20190703
> clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
> APIC: Switch to symmetric I/O mode setup
> DMAR: Host address width 39
> DMAR: DRHD base: 0x000000fed90000 flags: 0x0
> DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 19e2ff0505e
> DMAR: DRHD base: 0x000000fed91000 flags: 0x1
> DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
> DMAR: RMRR base: 0x000000771e3000 end: 0x00000077202fff
> DMAR: RMRR base: 0x0000007b800000 end: 0x0000007fffffff
> DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
> DMAR-IR: HPET id 0 under DRHD base 0xfed91000
> DMAR-IR: IRQ remapping was enabled on dmar0 but we are not in kdump mode
> DMAR-IR: IRQ remapping was enabled on dmar1 but we are not in kdump mode
> DMAR-IR: Enabled IRQ remapping in xapic mode
> ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x39a8208cdd2, max_idle_ns: 881590748921 ns
> Calibrating delay loop (skipped), value calculated using timer frequency.. 4001.60 BogoMIPS (lpj=6666560)
> pid_max: default: 32768 minimum: 301
> Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
> Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
> mce: CPU0: Thermal monitoring enabled (TM1)
> process: using mwait in idle threads
> Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
> Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
> Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
> Spectre V2 : Mitigation: Full generic retpoline
> Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
> Spectre V2 : Enabling Restricted Speculation for firmware calls
> Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
> Spectre V2 : User space: Mitigation: STIBP via seccomp and prctl
> Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
> MDS: Vulnerable: Clear CPU buffers attempted, no microcode
> Freeing SMP alternatives memory: 24K
> TSC deadline timer enabled
> smpboot: CPU0: Intel(R) Core(TM) i7-8565U CPU @ 1.80GHz (family: 0x6, model: 0x8e, stepping: 0xb)
> Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
> ... version:                4
> ... bit width:              48
> ... generic registers:      4
> ... value mask:             0000ffffffffffff
> ... max period:             00007fffffffffff
> ... fixed-purpose events:   3
> ... event mask:             000000070000000f
> rcu: Hierarchical SRCU implementation.
> smp: Bringing up secondary CPUs ...
> x86: Booting SMP configuration:
> .... node  #0, CPUs:      #1 #2 #3 #4
> MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
>  #5 #6 #7
> smp: Brought up 1 node, 8 CPUs
> smpboot: Max logical packages: 1
> smpboot: Total of 8 processors activated (32012.80 BogoMIPS)
> devtmpfs: initialized
> PM: Registering ACPI NVS region [mem 0x799f7000-0x79aabfff] (741376 bytes)
> clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370867519511994 ns
> futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
> pinctrl core: initialized pinctrl subsystem
> NET: Registered protocol family 16
> audit: initializing netlink subsys (disabled)
> audit: type=2000 audit(1574366276.039:1): state=initialized audit_enabled=0 res=1
> cpuidle: using governor ladder
> cpuidle: using governor menu
> ACPI: bus type PCI registered
> acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> PCI: MMCONFIG for domain 0000 [bus 00-7f] at [mem 0xf0000000-0xf7ffffff] (base 0xf0000000)
> PCI: MMCONFIG at [mem 0xf0000000-0xf7ffffff] reserved in E820
> PCI: Using configuration type 1 for base access
> cryptd: max_cpu_qlen set to 1000
> fbcon: Taking over console
> ACPI: Added _OSI(Module Device)
> ACPI: Added _OSI(Processor Device)
> ACPI: Added _OSI(3.0 _SCP Extensions)
> ACPI: Added _OSI(Processor Aggregator Device)
> ACPI: Added _OSI(Linux-Dell-Video)
> ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
> ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.HS01._UPC], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.HS01._PLD], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.HS02._UPC], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.HS02._PLD], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.HS03._UPC], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.HS03._PLD], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.HS04._UPC], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.HS04._PLD], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.HS05._UPC], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.HS05._PLD], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.HS06._UPC], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.HS06._PLD], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.HS07._UPC], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.HS07._PLD], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.HS08._UPC], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.HS08._PLD], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.HS09._UPC], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.HS09._PLD], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.HS10._UPC], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.HS10._PLD], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.USR1._UPC], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.USR1._PLD], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.USR2._UPC], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.USR2._PLD], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.SS01._UPC], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.SS01._PLD], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.SS02._UPC], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.SS02._PLD], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.SS03._UPC], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.SS03._PLD], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.SS04._UPC], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.SS04._PLD], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.SS05._UPC], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.SS05._PLD], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.SS06._UPC], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI BIOS Error (bug): Failure creating named object [\_SB.PCI0.XHC.RHUB.SS06._PLD], AE_ALREADY_EXISTS (20190703/dswload2-323)
> ACPI Error: AE_ALREADY_EXISTS, During name lookup/catalog (20190703/psobject-220)
> ACPI: Skipping parse of AML opcode: OpcodeName unavailable (0x0014)
> ACPI: 8 ACPI AML tables successfully acquired and loaded
> ACPI: EC: EC started
> ACPI: EC: interrupt blocked
> ACPI: \: Used as first EC
> ACPI: \: GPE=0x50, EC_CMD/EC_SC=0x66, EC_DATA=0x62
> ACPI: EC: Boot ECDT EC used to handle transactions
> ACPI: Dynamic OEM Table Load:
> ACPI: SSDT 0xFFFF9B6AEB692F00 0000F4 (v02 PmRef  Cpu0Psd  00003000 INTL 20160527)
> ACPI: \_SB_.PR00: _OSC native thermal LVT Acked
> ACPI: Dynamic OEM Table Load:
> ACPI: SSDT 0xFFFF9B6AEB695C00 000400 (v02 PmRef  Cpu0Cst  00003001 INTL 20160527)
> ACPI: Dynamic OEM Table Load:
> ACPI: SSDT 0xFFFF9B6AEB6A1000 00053F (v02 PmRef  Cpu0Ist  00003000 INTL 20160527)
> ACPI: Dynamic OEM Table Load:
> ACPI: SSDT 0xFFFF9B6AEB696E00 00011B (v02 PmRef  Cpu0Hwp  00003000 INTL 20160527)
> ACPI: Dynamic OEM Table Load:
> ACPI: SSDT 0xFFFF9B6AEB6A1800 000724 (v02 PmRef  HwpLvt   00003000 INTL 20160527)
> ACPI: Dynamic OEM Table Load:
> ACPI: SSDT 0xFFFF9B6AEB6A8000 0005FC (v02 PmRef  ApIst    00003000 INTL 20160527)
> ACPI: Dynamic OEM Table Load:
> ACPI: SSDT 0xFFFF9B6AEB23CC00 000317 (v02 PmRef  ApHwp    00003000 INTL 20160527)
> ACPI: Dynamic OEM Table Load:
> ACPI: SSDT 0xFFFF9B6AEB6AB000 000AB0 (v02 PmRef  ApPsd    00003000 INTL 20160527)
> ACPI: Dynamic OEM Table Load:
> ACPI: SSDT 0xFFFF9B6AEB23C400 00030A (v02 PmRef  ApCst    00003000 INTL 20160527)
> ACPI: Interpreter enabled
> ACPI: (supports S0 S3 S4 S5)
> ACPI: Using IOAPIC for interrupt routing
> PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> ACPI: Enabled 7 GPEs in block 00 to 7F
> ACPI: Power Resource [PXP] (on)
> ACPI: Power Resource [BTPR] (on)
> ACPI: Power Resource [USBC] (on)
> ACPI: Power Resource [V0PR] (on)
> ACPI: Power Resource [V1PR] (on)
> ACPI: Power Resource [V2PR] (on)
> ACPI: Power Resource [WRST] (on)
> ACPI: Power Resource [PIN] (off)
> ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7e])
> acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> acpi PNP0A08:00: _OSC: platform does not support [AER]
> acpi PNP0A08:00: _OSC: OS now controls [PME PCIeCapability LTR]
> PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3fff window]
> pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7fff window]
> pci_bus 0000:00: root bus resource [mem 0x000e8000-0x000ebfff window]
> pci_bus 0000:00: root bus resource [mem 0x000ec000-0x000effff window]
> pci_bus 0000:00: root bus resource [mem 0x000f0000-0x000fffff window]
> pci_bus 0000:00: root bus resource [mem 0x80000000-0xefffffff window]
> pci_bus 0000:00: root bus resource [mem 0x4000000000-0x7fffffffff window]
> pci_bus 0000:00: root bus resource [mem 0xfc800000-0xfe7fffff window]
> pci_bus 0000:00: root bus resource [bus 00-7e]
> pci 0000:00:00.0: [8086:3e34] type 00 class 0x060000
> pci 0000:00:02.0: [8086:3ea0] type 00 class 0x030000
> pci 0000:00:02.0: reg 0x10: [mem 0x604a000000-0x604affffff 64bit]
> pci 0000:00:02.0: reg 0x18: [mem 0x4000000000-0x400fffffff 64bit pref]
> pci 0000:00:02.0: reg 0x20: [io  0x3000-0x303f]
> pci 0000:00:02.0: BAR 2: assigned to efifb
> pci 0000:00:04.0: [8086:1903] type 00 class 0x118000
> pci 0000:00:04.0: reg 0x10: [mem 0x604b110000-0x604b117fff 64bit]
> pci 0000:00:08.0: [8086:1911] type 00 class 0x088000
> pci 0000:00:08.0: reg 0x10: [mem 0x604b12c000-0x604b12cfff 64bit]
> pci 0000:00:12.0: [8086:9df9] type 00 class 0x118000
> pci 0000:00:12.0: reg 0x10: [mem 0x604b12b000-0x604b12bfff 64bit]
> pci 0000:00:14.0: [8086:9ded] type 00 class 0x0c0330
> pci 0000:00:14.0: reg 0x10: [mem 0x604b100000-0x604b10ffff 64bit]
> pci 0000:00:14.0: PME# supported from D3hot D3cold
> pci 0000:00:14.2: [8086:9def] type 00 class 0x050000
> pci 0000:00:14.2: reg 0x10: [mem 0x604b120000-0x604b121fff 64bit]
> pci 0000:00:14.2: reg 0x18: [mem 0x604b12a000-0x604b12afff 64bit]
> pci 0000:00:14.3: [8086:9df0] type 00 class 0x028000
> pci 0000:00:14.3: reg 0x10: [mem 0x604b11c000-0x604b11ffff 64bit]
> pci 0000:00:14.3: PME# supported from D0 D3hot D3cold
> pci 0000:00:15.0: [8086:9de8] type 00 class 0x0c8000
> pci 0000:00:15.0: reg 0x10: [mem 0x4010000000-0x4010000fff 64bit]
> pci 0000:00:15.1: [8086:9de9] type 00 class 0x0c8000
> pci 0000:00:15.1: reg 0x10: [mem 0x4010001000-0x4010001fff 64bit]
> pci 0000:00:16.0: [8086:9de0] type 00 class 0x078000
> pci 0000:00:16.0: reg 0x10: [mem 0x604b127000-0x604b127fff 64bit]
> pci 0000:00:16.0: PME# supported from D3hot
> pci 0000:00:19.0: [8086:9dc5] type 00 class 0x0c8000
> pci 0000:00:19.0: reg 0x10: [mem 0x4010002000-0x4010002fff 64bit]
> pci 0000:00:1c.0: [8086:9dbc] type 01 class 0x060400
> pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
> pci 0000:00:1d.0: [8086:9db4] type 01 class 0x060400
> pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
> pci 0000:00:1e.0: [8086:9da8] type 00 class 0x078000
> pci 0000:00:1e.0: reg 0x10: [mem 0x604b125000-0x604b125fff 64bit]
> pci 0000:00:1e.0: reg 0x18: [mem 0x604b124000-0x604b124fff 64bit]
> pci 0000:00:1e.2: [8086:9daa] type 00 class 0x0c8000
> pci 0000:00:1e.2: reg 0x10: [mem 0x4010003000-0x4010003fff 64bit]
> pci 0000:00:1f.0: [8086:9d84] type 00 class 0x060100
> pci 0000:00:1f.3: [8086:9dc8] type 00 class 0x040380
> pci 0000:00:1f.3: reg 0x10: [mem 0x604b118000-0x604b11bfff 64bit]
> pci 0000:00:1f.3: reg 0x20: [mem 0x604b000000-0x604b0fffff 64bit]
> pci 0000:00:1f.3: PME# supported from D3hot D3cold
> pci 0000:00:1f.4: [8086:9da3] type 00 class 0x0c0500
> pci 0000:00:1f.4: reg 0x10: [mem 0x604b122000-0x604b1220ff 64bit]
> pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
> pci 0000:00:1f.5: [8086:9da4] type 00 class 0x0c8000
> pci 0000:00:1f.5: reg 0x10: [mem 0xfe010000-0xfe010fff]
> pci 0000:01:00.0: [8086:15d3] type 01 class 0x060400
> pci 0000:01:00.0: supports D1 D2
> pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> pci 0000:00:1c.0: PCI bridge to [bus 01-6b]
> pci 0000:00:1c.0:   bridge window [io  0x4000-0x6fff]
> pci 0000:00:1c.0:   bridge window [mem 0x80000000-0xae0fffff]
> pci 0000:00:1c.0:   bridge window [mem 0x6000000000-0x6049ffffff 64bit pref]
> pci 0000:02:00.0: [8086:15d3] type 01 class 0x060400
> pci 0000:02:00.0: supports D1 D2
> pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> pci 0000:02:01.0: [8086:15d3] type 01 class 0x060400
> pci 0000:02:01.0: supports D1 D2
> pci 0000:02:01.0: PME# supported from D0 D1 D2 D3hot D3cold
> pci 0000:02:02.0: [8086:15d3] type 01 class 0x060400
> pci 0000:02:02.0: supports D1 D2
> pci 0000:02:02.0: PME# supported from D0 D1 D2 D3hot D3cold
> pci 0000:02:04.0: [8086:15d3] type 01 class 0x060400
> pci 0000:02:04.0: supports D1 D2
> pci 0000:02:04.0: PME# supported from D0 D1 D2 D3hot D3cold
> pci 0000:01:00.0: PCI bridge to [bus 02-6b]
> pci 0000:01:00.0:   bridge window [io  0x4000-0x5fff]
> pci 0000:01:00.0:   bridge window [mem 0x80000000-0xae0fffff]
> pci 0000:01:00.0:   bridge window [mem 0x6000000000-0x6049ffffff 64bit pref]
> pci 0000:03:00.0: [8086:15d2] type 00 class 0x088000
> pci 0000:03:00.0: reg 0x10: [mem 0xae000000-0xae03ffff]
> pci 0000:03:00.0: reg 0x14: [mem 0xae040000-0xae040fff]
> pci 0000:03:00.0: supports D1 D2
> pci 0000:03:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> pci 0000:02:00.0: PCI bridge to [bus 03]
> pci 0000:02:00.0:   bridge window [mem 0xae000000-0xae0fffff]
> pci 0000:02:01.0: PCI bridge to [bus 04-36]
> pci 0000:02:01.0:   bridge window [io  0x4000-0x4fff]
> pci 0000:02:01.0:   bridge window [mem 0x80000000-0x97efffff]
> pci 0000:02:01.0:   bridge window [mem 0x6000000000-0x601fffffff 64bit pref]
> pci 0000:37:00.0: [8086:15d4] type 00 class 0x0c0330
> pci 0000:37:00.0: reg 0x10: [mem 0x97f00000-0x97f0ffff]
> pci 0000:37:00.0: supports D1 D2
> pci 0000:37:00.0: PME# supported from D0 D1 D2 D3hot D3cold
> pci 0000:37:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s x4 link at 0000:02:02.0 (capable of 31.504 Gb/s with 8 GT/s x4 link)
> pci 0000:02:02.0: PCI bridge to [bus 37]
> pci 0000:02:02.0:   bridge window [mem 0x97f00000-0x97ffffff]
> pci 0000:02:04.0: PCI bridge to [bus 38-6b]
> pci 0000:02:04.0:   bridge window [io  0x5000-0x5fff]
> pci 0000:02:04.0:   bridge window [mem 0x98000000-0xadffffff]
> pci 0000:02:04.0:   bridge window [mem 0x6020000000-0x6049ffffff 64bit pref]
> pci 0000:6c:00.0: [144d:a808] type 00 class 0x010802
> pci 0000:6c:00.0: reg 0x10: [mem 0xae200000-0xae203fff 64bit]
> pci 0000:00:1d.0: PCI bridge to [bus 6c]
> pci 0000:00:1d.0:   bridge window [mem 0xae200000-0xae2fffff]
> pci_bus 0000:00: on NUMA node 0
> ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
> ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 10 11 12 14 15) *1, disabled.
> ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
> ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
> ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
> ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
> ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
> ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 11 12 14 15) *0, disabled.
> ACPI: EC: interrupt unblocked
> ACPI: EC: event unblocked
> ACPI: \_SB_.PCI0.LPCB.EC0_: GPE=0x50, EC_CMD/EC_SC=0x66, EC_DATA=0x62
> ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC used to handle transactions and events
> pci 0000:00:02.0: vgaarb: setting as boot VGA device
> pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
> pci 0000:00:02.0: vgaarb: bridge control possible
> vgaarb: loaded
> ACPI: bus type USB registered
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> Registered efivars operations
> PCI: Using ACPI for IRQ routing
> PCI: pci_cache_line_size set to 64 bytes
> e820: reserve RAM buffer [mem 0x000971d0-0x0009ffff]
> e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
> e820: reserve RAM buffer [mem 0x763fb000-0x77ffffff]
> e820: reserve RAM buffer [mem 0x7a40f000-0x7bffffff]
> e820: reserve RAM buffer [mem 0x47e000000-0x47fffffff]
> acpi PNP0C14:02: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:01)
> acpi PNP0C14:03: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:01)
> clocksource: Switched to clocksource tsc-early
> VFS: Disk quotas dquot_6.6.0
> VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> pnp: PnP ACPI init
> system 00:00: [mem 0x40000000-0x403fffff] could not be reserved
> system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
> system 00:01: [io  0x0680-0x069f] has been reserved
> system 00:01: [io  0x164e-0x164f] has been reserved
> system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
> system 00:02: [io  0x1854-0x1857] has been reserved
> system 00:02: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
> pnp 00:03: Plug and Play ACPI device, IDs ATK3001 PNP030b (active)
> system 00:04: [mem 0xfed10000-0xfed17fff] has been reserved
> system 00:04: [mem 0xfed18000-0xfed18fff] has been reserved
> system 00:04: [mem 0xfed19000-0xfed19fff] has been reserved
> system 00:04: [mem 0xf0000000-0xf7ffffff] has been reserved
> system 00:04: [mem 0xfed20000-0xfed3ffff] has been reserved
> system 00:04: [mem 0xfed90000-0xfed93fff] could not be reserved
> system 00:04: [mem 0xfed45000-0xfed8ffff] has been reserved
> system 00:04: [mem 0xfee00000-0xfeefffff] could not be reserved
> system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
> system 00:05: [io  0x1800-0x18fe] could not be reserved
> system 00:05: [mem 0xfd000000-0xfd69ffff] has been reserved
> system 00:05: [mem 0xfd6b0000-0xfd6cffff] has been reserved
> system 00:05: [mem 0xfd6f0000-0xfdffffff] has been reserved
> system 00:05: [mem 0xfe000000-0xfe01ffff] could not be reserved
> system 00:05: [mem 0xfe200000-0xfe7fffff] has been reserved
> system 00:05: [mem 0xff000000-0xffffffff] has been reserved
> system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
> system 00:06: [io  0x2000-0x20fe] has been reserved
> system 00:06: Plug and Play ACPI device, IDs PNP0c02 (active)
> system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
> pnp: PnP ACPI: found 8 devices
> thermal_sys: Registered thermal governor 'fair_share'
> thermal_sys: Registered thermal governor 'step_wise'
> thermal_sys: Registered thermal governor 'user_space'
> thermal_sys: Registered thermal governor 'power_allocator'
> clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> pci 0000:02:00.0: PCI bridge to [bus 03]
> pci 0000:02:00.0:   bridge window [mem 0xae000000-0xae0fffff]
> pci 0000:02:01.0: PCI bridge to [bus 04-36]
> pci 0000:02:01.0:   bridge window [io  0x4000-0x4fff]
> pci 0000:02:01.0:   bridge window [mem 0x80000000-0x97efffff]
> pci 0000:02:01.0:   bridge window [mem 0x6000000000-0x601fffffff 64bit pref]
> pci 0000:02:02.0: PCI bridge to [bus 37]
> pci 0000:02:02.0:   bridge window [mem 0x97f00000-0x97ffffff]
> pci 0000:02:04.0: PCI bridge to [bus 38-6b]
> pci 0000:02:04.0:   bridge window [io  0x5000-0x5fff]
> pci 0000:02:04.0:   bridge window [mem 0x98000000-0xadffffff]
> pci 0000:02:04.0:   bridge window [mem 0x6020000000-0x6049ffffff 64bit pref]
> pci 0000:01:00.0: PCI bridge to [bus 02-6b]
> pci 0000:01:00.0:   bridge window [io  0x4000-0x5fff]
> pci 0000:01:00.0:   bridge window [mem 0x80000000-0xae0fffff]
> pci 0000:01:00.0:   bridge window [mem 0x6000000000-0x6049ffffff 64bit pref]
> pci 0000:00:1c.0: PCI bridge to [bus 01-6b]
> pci 0000:00:1c.0:   bridge window [io  0x4000-0x6fff]
> pci 0000:00:1c.0:   bridge window [mem 0x80000000-0xae0fffff]
> pci 0000:00:1c.0:   bridge window [mem 0x6000000000-0x6049ffffff 64bit pref]
> pci 0000:00:1d.0: PCI bridge to [bus 6c]
> pci 0000:00:1d.0:   bridge window [mem 0xae200000-0xae2fffff]
> pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
> pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
> pci_bus 0000:00: resource 7 [mem 0x000e0000-0x000e3fff window]
> pci_bus 0000:00: resource 8 [mem 0x000e4000-0x000e7fff window]
> pci_bus 0000:00: resource 9 [mem 0x000e8000-0x000ebfff window]
> pci_bus 0000:00: resource 10 [mem 0x000ec000-0x000effff window]
> pci_bus 0000:00: resource 11 [mem 0x000f0000-0x000fffff window]
> pci_bus 0000:00: resource 12 [mem 0x80000000-0xefffffff window]
> pci_bus 0000:00: resource 13 [mem 0x4000000000-0x7fffffffff window]
> pci_bus 0000:00: resource 14 [mem 0xfc800000-0xfe7fffff window]
> pci_bus 0000:01: resource 0 [io  0x4000-0x6fff]
> pci_bus 0000:01: resource 1 [mem 0x80000000-0xae0fffff]
> pci_bus 0000:01: resource 2 [mem 0x6000000000-0x6049ffffff 64bit pref]
> pci_bus 0000:02: resource 0 [io  0x4000-0x5fff]
> pci_bus 0000:02: resource 1 [mem 0x80000000-0xae0fffff]
> pci_bus 0000:02: resource 2 [mem 0x6000000000-0x6049ffffff 64bit pref]
> pci_bus 0000:03: resource 1 [mem 0xae000000-0xae0fffff]
> pci_bus 0000:04: resource 0 [io  0x4000-0x4fff]
> pci_bus 0000:04: resource 1 [mem 0x80000000-0x97efffff]
> pci_bus 0000:04: resource 2 [mem 0x6000000000-0x601fffffff 64bit pref]
> pci_bus 0000:37: resource 1 [mem 0x97f00000-0x97ffffff]
> pci_bus 0000:38: resource 0 [io  0x5000-0x5fff]
> pci_bus 0000:38: resource 1 [mem 0x98000000-0xadffffff]
> pci_bus 0000:38: resource 2 [mem 0x6020000000-0x6049ffffff 64bit pref]
> pci_bus 0000:6c: resource 1 [mem 0xae200000-0xae2fffff]
> NET: Registered protocol family 2
> tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes, linear)
> TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
> TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
> TCP: Hash tables configured (established 131072 bind 65536)
> UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
> UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes, linear)
> NET: Registered protocol family 1
> pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
> pci 0000:01:00.0: CLS mismatch (64 != 128), using 64 bytes
> DMAR: No ATSR found
> DMAR: dmar0: Using Queued invalidation
> DMAR: Translation was enabled for dmar0 but we are not in kdump mode
> DMAR: dmar1: Using Queued invalidation
> DMAR: Translation was enabled for dmar1 but we are not in kdump mode
> DMAR: DRHD: handling fault status reg 2
> DMAR: [DMA Write] Request device [00:02.0] fault addr 0 [fault reason 01] Present bit in root entry is clear
> pci 0000:00:00.0: Adding to iommu group 0
> pci 0000:00:02.0: Adding to iommu group 1
> pci 0000:00:04.0: Adding to iommu group 2
> pci 0000:00:08.0: Adding to iommu group 3
> pci 0000:00:12.0: Adding to iommu group 4
> pci 0000:00:14.0: Adding to iommu group 5
> pci 0000:00:14.2: Adding to iommu group 5
> pci 0000:00:14.3: Adding to iommu group 5
> pci 0000:00:15.0: Adding to iommu group 6
> pci 0000:00:15.1: Adding to iommu group 6
> pci 0000:00:16.0: Adding to iommu group 7
> pci 0000:00:19.0: Adding to iommu group 8
> pci 0000:00:1c.0: Adding to iommu group 9
> pci 0000:00:1c.0: Using iommu dma mapping
> pci 0000:00:1d.0: Adding to iommu group 10
> pci 0000:00:1e.0: Adding to iommu group 11
> pci 0000:00:1e.2: Adding to iommu group 11
> pci 0000:00:1f.0: Adding to iommu group 12
> pci 0000:00:1f.3: Adding to iommu group 12
> pci 0000:00:1f.4: Adding to iommu group 12
> pci 0000:00:1f.5: Adding to iommu group 12
> pci 0000:01:00.0: Adding to iommu group 13
> pci 0000:01:00.0: Using iommu dma mapping
> pci 0000:02:00.0: Adding to iommu group 14
> pci 0000:02:00.0: Using iommu dma mapping
> pci 0000:02:01.0: Adding to iommu group 15
> pci 0000:02:01.0: Using iommu dma mapping
> pci 0000:02:02.0: Adding to iommu group 16
> pci 0000:02:02.0: Using iommu dma mapping
> pci 0000:02:04.0: Adding to iommu group 17
> pci 0000:02:04.0: Using iommu dma mapping
> pci 0000:03:00.0: Adding to iommu group 14
> pci 0000:37:00.0: Adding to iommu group 16
> pci 0000:6c:00.0: Adding to iommu group 18
> DMAR: Intel(R) Virtualization Technology for Directed I/O
> RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters, 655360 ms ovfl timer
> RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
> RAPL PMU: hw unit of domain package 2^-14 Joules
> RAPL PMU: hw unit of domain dram 2^-14 Joules
> RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
> RAPL PMU: hw unit of domain psys 2^-14 Joules
> platform rtc_cmos: registered platform RTC device (no PNP device found)
> Initialise system trusted keyrings
> workingset: timestamp_bits=46 max_order=22 bucket_order=0
> NET: Registered protocol family 38
> Key type asymmetric registered
> Asymmetric key parser 'x509' registered
> Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
> pcieport 0000:00:1c.0: PME: Signaling with IRQ 122
> pcieport 0000:00:1d.0: PME: Signaling with IRQ 123
> efifb: probing for efifb
> efifb: framebuffer at 0x4000000000, using 8100k, total 8100k
> efifb: mode is 1920x1080x32, linelength=7680, pages=1
> efifb: scrolling: redraw
> efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
> Console: switching to colour frame buffer device 240x67
> fb0: EFI VGA frame buffer device
> intel_idle: MWAIT substates: 0x11142120
> intel_idle: v0.4.1 model 0x8E
> intel_idle: lapic_timer_reliable_states 0xffffffff
> input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:19/PNP0C09:01/PNP0C0D:00/input/input0
> ACPI: Lid Switch [LID]
> input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input1
> ACPI: Sleep Button [SLPB]
> input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input2
> ACPI: Power Button [PWRB]
> input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
> ACPI: Power Button [PWRF]
> Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [drm] VT-d active for gfx access
> checking generic (4000000000 7e9000) vs hw (4000000000 10000000)
> fb0: switching to inteldrmfb from EFI VGA
> Console: switching to colour dummy device 80x25
> i915 0000:00:02.0: vgaarb: deactivate vga console
> [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [drm] Driver supports precise vblank timestamp query.
> i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
> [drm] Finished loading DMC firmware i915/kbl_dmc_ver1_04.bin (v1.4)
> [drm] HuC: Loaded firmware i915/kbl_huc_ver02_00_1810.bin (version 2.0)
> [drm] GuC: Loaded firmware i915/kbl_guc_32.0.3.bin (version 32.0)
> [drm] CT: enabled
> i915 0000:00:02.0: GuC firmware version 32.0
> i915 0000:00:02.0: GuC submission disabled
> i915 0000:00:02.0: HuC enabled
> [drm] Initialized i915 1.6.0 20190619 for 0000:00:02.0 on minor 0
> ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
> input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input4
> nvme nvme0: pci function 0000:6c:00.0
> i8042: PNP: PS/2 Controller [PNP030b:PS2K] at 0x60,0x64 irq 1
> i8042: PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
> serio: i8042 KBD port at 0x60,0x64 irq 1
> mousedev: PS/2 mouse device common for all mice
> device-mapper: ioctl: 4.40.0-ioctl (2019-01-18) initialised: dm-devel@redhat.com
> intel_pstate: Intel P-state driver initializing
> intel_pstate: HWP enabled
> ledtrig-cpu: registered to indicate activity on CPUs
> hidraw: raw HID events driver (C) Jiri Kosina
> asus_wmi: ASUS WMI generic driver loaded
> asus_wmi: Initialization: 0x1
> asus_wmi: BIOS WMI version: 9.0
> asus_wmi: SFUN value: 0x21
> asus-nb-wmi asus-nb-wmi: Detected ATK, not ASUSWMI, use DSTS
> asus-nb-wmi asus-nb-wmi: Detected ATK, enable event queue
> input: Asus WMI hotkeys as /devices/platform/asus-nb-wmi/input/input6
> asus_wmi: Number of fans: 0
> fbcon: i915drmfb (fb0) is primary device
> Console: switching to colour frame buffer device 240x67
> NET: Registered protocol family 10
> input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input5
> Segment Routing with IPv6
> microcode: sig=0x806eb, pf=0x80, revision=0x9a
> microcode: Microcode Update Driver: v2.2.
> AVX2 version of gcm_enc/dec engaged.
> AES CTR mode by8 optimization enabled
> i915 0000:00:02.0: fb0: i915drmfb frame buffer device
> sched_clock: Marking stable (1801349910, 5068242)->(1812938168, -6520016)
> registered taskstats version 1
> Loading compiled-in X.509 certificates
> Loaded X.509 cert 'uefikey: a94102dc02a4f23db70b7002f01d387559cd00fa'
> Key type big_key registered
> nvme nvme0: Shutdown timeout set to 8 seconds
> nvme nvme0: 8/0/0 default/read/poll queues
>  nvme0n1: p1 p2
> Freeing unused kernel image memory: 12600K
> Write protecting the kernel read-only data: 16384k
> Freeing unused kernel image memory: 2028K
> Freeing unused kernel image memory: 1164K
> Run /init as init process
> systemd[1]: systemd 243 running in system mode. (+PAM -AUDIT -SELINUX +IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL -XZ +LZ4 +SECCOMP +BLKID -ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=unified)
> systemd[1]: Detected architecture x86-64.
> systemd[1]: Running in initial RAM disk.
> systemd[1]: Set hostname to <n>.
> systemd[1]: Created slice system-systemd\x2dcryptsetup.slice.
> systemd[1]: Created slice system-systemd\x2dhibernate\x2dresume.slice.
> systemd[1]: Reached target Slices.
> systemd[1]: Reached target Swap.
> systemd[1]: Reached target Timers.
> systemd[1]: Listening on Journal Audit Socket.
> tsc: Refined TSC clocksource calibration: 1991.999 MHz
> clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x396d4ffc055, max_idle_ns: 881590662783 ns
> clocksource: Switched to clocksource tsc
> xhci_hcd 0000:00:14.0: xHCI Host Controller
> xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
> xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x110 quirks 0x0000000000009810
> xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
> usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.03
> usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb1: Product: xHCI Host Controller
> usb usb1: Manufacturer: Linux 5.3.11-gentoo xhci-hcd
> usb usb1: SerialNumber: 0000:00:14.0
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 12 ports detected
> xhci_hcd 0000:00:14.0: xHCI Host Controller
> xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
> xhci_hcd 0000:00:14.0: Host supports USB 3.1 Enhanced SuperSpeed
> usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.03
> usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb2: Product: xHCI Host Controller
> usb usb2: Manufacturer: Linux 5.3.11-gentoo xhci-hcd
> usb usb2: SerialNumber: 0000:00:14.0
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 6 ports detected
> xhci_hcd 0000:37:00.0: xHCI Host Controller
> xhci_hcd 0000:37:00.0: new USB bus registered, assigned bus number 3
> xhci_hcd 0000:37:00.0: hcc params 0x200077c1 hci version 0x110 quirks 0x0000000200009810
> usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.03
> usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb3: Product: xHCI Host Controller
> usb usb3: Manufacturer: Linux 5.3.11-gentoo xhci-hcd
> usb usb3: SerialNumber: 0000:37:00.0
> hub 3-0:1.0: USB hub found
> hub 3-0:1.0: 2 ports detected
> xhci_hcd 0000:37:00.0: xHCI Host Controller
> xhci_hcd 0000:37:00.0: new USB bus registered, assigned bus number 4
> xhci_hcd 0000:37:00.0: Host supports USB 3.1 Enhanced SuperSpeed
> usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.03
> usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> usb usb4: Product: xHCI Host Controller
> usb usb4: Manufacturer: Linux 5.3.11-gentoo xhci-hcd
> usb usb4: SerialNumber: 0000:37:00.0
> hub 4-0:1.0: USB hub found
> hub 4-0:1.0: 2 ports detected
> random: systemd-cryptse: uninitialized urandom read (4 bytes read)
> usb 1-5: new high-speed USB device number 2 using xhci_hcd
> usb 1-5: New USB device found, idVendor=13d3, idProduct=56b9, bcdDevice=18.51
> usb 1-5: New USB device strings: Mfr=3, Product=1, SerialNumber=2
> usb 1-5: Product: USB2.0 HD UVC WebCam
> usb 1-5: Manufacturer: Azurewave
> usb 1-5: SerialNumber: 0x0001
> usb 1-9: new full-speed USB device number 3 using xhci_hcd
> usb 1-9: New USB device found, idVendor=27c6, idProduct=5201, bcdDevice= 1.00
> usb 1-9: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> usb 1-9: Product: Goodix Fingerprint Device 
> usb 1-9: Manufacturer: HTMicroelectronics
> usb 1-9: SerialNumber: HTK32
> usb 1-10: new full-speed USB device number 4 using xhci_hcd
> usb 1-10: config 1 interface 1 altsetting 0 endpoint 0x3 has wMaxPacketSize 0, skipping
> usb 1-10: config 1 interface 1 altsetting 0 endpoint 0x83 has wMaxPacketSize 0, skipping
> usb 1-10: New USB device found, idVendor=8087, idProduct=0aaa, bcdDevice= 0.02
> usb 1-10: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> random: crng init done
> EXT4-fs (dm-0): mounted filesystem with ordered data mode. Opts: (null)
> systemd-journald[249]: Received SIGTERM from PID 1 (systemd).
> printk: systemd: 24 output lines suppressed due to ratelimiting
> systemd[1]: systemd 243 running in system mode. (+PAM -AUDIT -SELINUX +IMA -APPARMOR +SMACK -SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL -XZ +LZ4 +SECCOMP +BLKID -ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=unified)
> systemd[1]: Detected architecture x86-64.
> systemd[1]: Set hostname to <n>.
> systemd[1]: initrd-switch-root.service: Succeeded.
> systemd[1]: Stopped Switch Root.
> systemd[1]: systemd-journald.service: Service has no hold-off time (RestartSec=0), scheduling restart.
> systemd[1]: systemd-journald.service: Scheduled restart job, restart counter is at 1.
> systemd[1]: Created slice system-dnsmasq\x2dlibvirt.slice.
> systemd[1]: Created slice system-getty.slice.
> systemd[1]: Created slice system-systemd\x2dfsck.slice.
> EXT4-fs (dm-0): re-mounted. Opts: (null)
> systemd-journald[566]: Received client request to flush runtime journal.
> Adding 8388604k swap on /var/swap1.  Priority:-2 extents:11 across:9035772k SS
> intel_pmc_core INT33A1:00:  initialized
> ACPI Warning: \_SB.IETM._TRT: Return Package has no elements (empty) (20190703/nsprepkg-94)
> ACPI: AC Adapter [AC0] (off-line)
> battery: ACPI: Battery Slot [BAT0] (battery present)
> thermal LNXTHERM:00: registered as thermal_zone6
> ACPI: Thermal Zone [THRM] (46 C)
> intel_rapl_common: Found RAPL domain package
> intel_rapl_common: Found RAPL domain dram
> proc_thermal 0000:00:04.0: Creating sysfs group for PROC_THERMAL_PCI
> idma64 idma64.0: Found Intel integrated DMA 64-bit
> idma64 idma64.1: Found Intel integrated DMA 64-bit
> idma64 idma64.3: Found Intel integrated DMA 64-bit
> idma64 idma64.4: Found Intel integrated DMA 64-bit
> videodev: Linux video capture interface: v2.00
> cfg80211: Loading compiled-in X.509 certificates for regulatory database
> cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> Bluetooth: Core ver 2.22
> NET: Registered protocol family 31
> Bluetooth: HCI device and connection manager initialized
> Bluetooth: HCI socket layer initialized
> Bluetooth: L2CAP socket layer initialized
> Bluetooth: SCO socket layer initialized
> i801_smbus 0000:00:1f.4: SPD Write Disable is set
> i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
> input: PC Speaker as /devices/platform/pcspkr/input/input7
> cdc_acm 1-9:1.0: ttyACM0: USB ACM device
> usbcore: registered new interface driver cdc_acm
> cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
> EFI Variables Facility v0.08 2004-May-17
> Intel(R) Wireless WiFi driver for Linux
> Copyright(c) 2003- 2015 Intel Corporation
> usbcore: registered new interface driver btusb
> Bluetooth: hci0: Firmware revision 0.1 build 233 week 36 2019
> snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops 0xffffffffa6ca9a10)
> iwlwifi 0000:00:14.3: Found debug destination: EXTERNAL_DRAM
> iwlwifi 0000:00:14.3: Found debug configuration: 0
> iwlwifi 0000:00:14.3: loaded firmware version 46.6bf1df06.0 op_mode iwlmvm
> uvcvideo: Found UVC 1.00 device USB2.0 HD UVC WebCam (13d3:56b9)
> input: USB2.0 HD UVC WebCam: USB2.0 HD as /devices/pci0000:00/0000:00:14.0/usb1/1-5/1-5:1.0/input/input8
> usbcore: registered new interface driver uvcvideo
> USB Video Class driver (1.1.1)
> pstore: Using crash dump compression: deflate
> snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC294: line_outs=1 (0x17/0x0/0x0/0x0/0x0) type:speaker
> snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
> snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
> snd_hda_codec_realtek hdaudioC0D0:    inputs:
> snd_hda_codec_realtek hdaudioC0D0:      Headset Mic=0x19
> snd_hda_codec_realtek hdaudioC0D0:      Internal Mic=0x12
> pstore: Registered efi as persistent store backend
> intel_rapl_common: Found RAPL domain package
> intel_rapl_common: Found RAPL domain core
> intel_rapl_common: Found RAPL domain uncore
> intel_rapl_common: Found RAPL domain dram
> input: GDX1301:00 27C6:01F0 Mouse as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-9/i2c-GDX1301:00/0018:27C6:01F0.0001/input/input9
> input: GDX1301:00 27C6:01F0 Touchpad as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-9/i2c-GDX1301:00/0018:27C6:01F0.0001/input/input10
> hid-generic 0018:27C6:01F0.0001: input,hidraw0: I2C HID v1.00 Mouse [GDX1301:00 27C6:01F0] on i2c-GDX1301:00
> iwlwifi 0000:00:14.3: Detected Intel(R) Dual Band Wireless AC 9560, REV=0x318
> iwlwifi 0000:00:14.3: Applying debug destination EXTERNAL_DRAM
> iwlwifi 0000:00:14.3: Allocated 0x00400000 bytes for firmware monitor.
> iwlwifi 0000:00:14.3: base HW address: f4:d1:08:ad:95:94
> ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
> thermal thermal_zone9: failed to read out thermal zone (-61)
> iwlwifi 0000:00:14.3 wlo1: renamed from wlan0
> input: GDX1301:00 27C6:01F0 Touchpad as /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-9/i2c-GDX1301:00/0018:27C6:01F0.0001/input/input13
> hid-multitouch 0018:27C6:01F0.0001: input,hidraw0: I2C HID v1.00 Mouse [GDX1301:00 27C6:01F0] on i2c-GDX1301:00
> input: HDA Intel PCH Headset Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input15
> input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1f.3/sound/card0/input16
> input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input17
> input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input18
> input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input19
> input: HDA Intel PCH HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input20
> input: HDA Intel PCH HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input21
> Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> Bluetooth: BNEP filters: protocol multicast
> Bluetooth: BNEP socket layer initialized
> kexec_file: kernel signature verification successful.
> kexec_file: Crash PT_LOAD elf header. phdr=00000000dd2c128d vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=11 p_offset=0x0
> kexec_file: Crash PT_LOAD elf header. phdr=000000008dc5576a vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=12 p_offset=0x0
> kexec_file: Crash PT_LOAD elf header. phdr=00000000fbeec585 vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=13 p_offset=0x0
> kexec_file: Crash PT_LOAD elf header. phdr=00000000c76e3667 vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=14 p_offset=0x0
> kexec_file: Crash PT_LOAD elf header. phdr=0000000065d611be vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=15 p_offset=0x0
> kexec_file: Crash PT_LOAD elf header. phdr=0000000037d47d4a vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=16 p_offset=0x0
> kexec_file: Crash PT_LOAD elf header. phdr=00000000494e0db7 vaddr=0x0, paddr=0x0, sz=0x0 e_phnum=17 p_offset=0x0
> kexec_file: Loading segment 0: buf=0x00000000ef44b99f bufsz=0x8 mem=0x67000000 memsz=0x97000
> kexec_file: Loading segment 1: buf=0x000000000a87009a bufsz=0x1000 mem=0x67097000 memsz=0x1000
> kexec_file: Loading segment 2: buf=0x00000000ebb82359 bufsz=0x5000 mem=0x6cff9000 memsz=0x6000
> kexec_file: Loading segment 3: buf=0x000000009a6b52d5 bufsz=0x1240 mem=0x6cff7000 memsz=0x2000
> kexec_file: Loading segment 4: buf=0x000000005c62c21b bufsz=0xdbc888 mem=0x6b000000 memsz=0x1b50000
> tun: Universal TUN/TAP device driver, 1.6
> bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
> virbr3: port 1(virbr3-nic) entered blocking state
> virbr3: port 1(virbr3-nic) entered disabled state
> device virbr3-nic entered promiscuous mode
> virbr0: port 1(virbr0-nic) entered blocking state
> virbr0: port 1(virbr0-nic) entered disabled state
> device virbr0-nic entered promiscuous mode
> virbr2: port 1(virbr2-nic) entered blocking state
> virbr2: port 1(virbr2-nic) entered disabled state
> device virbr2-nic entered promiscuous mode
> virbr1: port 1(virbr1-nic) entered blocking state
> virbr1: port 1(virbr1-nic) entered disabled state
> device virbr1-nic entered promiscuous mode
> virbr3: port 1(virbr3-nic) entered blocking state
> virbr3: port 1(virbr3-nic) entered listening state
> virbr0: port 1(virbr0-nic) entered blocking state
> virbr0: port 1(virbr0-nic) entered listening state
> virbr2: port 1(virbr2-nic) entered blocking state
> virbr2: port 1(virbr2-nic) entered listening state
> NET: Registered protocol family 17
> virbr2: port 1(virbr2-nic) entered disabled state
> virbr0: port 1(virbr0-nic) entered disabled state
> virbr3: port 1(virbr3-nic) entered disabled state
> broken atomic modeset userspace detected, disabling atomic
> Bluetooth: RFCOMM TTY layer initialized
> Bluetooth: RFCOMM socket layer initialized
> Bluetooth: RFCOMM ver 1.11
>
> /proc/iomem:
> 00000000-00000fff : Reserved
> 00001000-0009efff : System RAM
> 0009f000-000fffff : Reserved
>   000a0000-000bffff : PCI Bus 0000:00
>   000e0000-000e3fff : PCI Bus 0000:00
>   000e4000-000e7fff : PCI Bus 0000:00
>   000e8000-000ebfff : PCI Bus 0000:00
>   000ec000-000effff : PCI Bus 0000:00
>   000f0000-000fffff : PCI Bus 0000:00
>     000f0000-000fffff : System ROM
> 00100000-763fafff : System RAM
>   00c5fffc-00c5ffff : iTCO_wdt
>   22000000-22a00fb0 : Kernel code
>   22a00fb1-230d3bff : Kernel data
>   23fca000-241fffff : Kernel bss
>   65000000-6affffff : Crash kernel
> 763fb000-79979fff : Reserved
> 7997a000-799f6fff : ACPI Tables
> 799f7000-79aabfff : ACPI Non-volatile Storage
>   79a1c000-79a1cfff : USBC000:00
> 79aac000-7a40dfff : Reserved
> 7a40e000-7a40efff : System RAM
> 7a40f000-7fffffff : Reserved
>   7c000000-7fffffff : Graphics Stolen Memory
> 80000000-efffffff : PCI Bus 0000:00
>   80000000-ae0fffff : PCI Bus 0000:01
>     80000000-ae0fffff : PCI Bus 0000:02
>       80000000-97efffff : PCI Bus 0000:04
>       97f00000-97ffffff : PCI Bus 0000:37
>         97f00000-97f0ffff : 0000:37:00.0
>           97f00000-97f0ffff : xhci-hcd
>       98000000-adffffff : PCI Bus 0000:38
>       ae000000-ae0fffff : PCI Bus 0000:03
>         ae000000-ae03ffff : 0000:03:00.0
>         ae040000-ae040fff : 0000:03:00.0
>   ae200000-ae2fffff : PCI Bus 0000:6c
>     ae200000-ae203fff : 0000:6c:00.0
>       ae200000-ae203fff : nvme
> f0000000-f7ffffff : PCI MMCONFIG 0000 [bus 00-7f]
>   f0000000-f7ffffff : Reserved
>     f0000000-f7ffffff : pnp 00:04
> fc800000-fe7fffff : PCI Bus 0000:00
>   fd000000-fd69ffff : pnp 00:05
>   fd6a0000-fd6affff : INT34BB:00
>   fd6b0000-fd6cffff : pnp 00:05
>   fd6d0000-fd6dffff : INT34BB:00
>   fd6e0000-fd6effff : INT34BB:00
>   fd6f0000-fdffffff : pnp 00:05
>   fe000000-fe010fff : Reserved
>     fe010000-fe010fff : 0000:00:1f.5
>   fe200000-fe7fffff : pnp 00:05
> fec00000-fec00fff : Reserved
>   fec00000-fec003ff : IOAPIC 0
> fed00000-fed03fff : Reserved
>   fed00000-fed003ff : HPET 0
>     fed00000-fed003ff : PNP0103:00
> fed10000-fed17fff : pnp 00:04
> fed18000-fed18fff : pnp 00:04
> fed19000-fed19fff : pnp 00:04
> fed20000-fed3ffff : pnp 00:04
> fed40000-fed44fff : MSFT0101:00
>   fed40000-fed44fff : MSFT0101:00
> fed45000-fed8ffff : pnp 00:04
> fed90000-fed90fff : dmar0
> fed91000-fed91fff : dmar1
> fee00000-fee00fff : Local APIC
>   fee00000-fee00fff : Reserved
> ff000000-ffffffff : Reserved
>   ff000000-ffffffff : pnp 00:05
> 100000000-47dffffff : System RAM
> 47e000000-47fffffff : RAM buffer
> 4000000000-7fffffffff : PCI Bus 0000:00
>   4000000000-400fffffff : 0000:00:02.0
>   4010000000-4010000fff : 0000:00:15.0
>     4010000000-40100001ff : lpss_dev
>       4010000000-40100001ff : i2c_designware.0
>     4010000200-40100002ff : lpss_priv
>     4010000800-4010000fff : idma64.0
>       4010000800-4010000fff : idma64.0
>   4010001000-4010001fff : 0000:00:15.1
>     4010001000-40100011ff : lpss_dev
>       4010001000-40100011ff : i2c_designware.1
>     4010001200-40100012ff : lpss_priv
>     4010001800-4010001fff : idma64.1
>       4010001800-4010001fff : idma64.1
>   4010002000-4010002fff : 0000:00:19.0
>     4010002000-40100021ff : lpss_dev
>       4010002000-40100021ff : i2c_designware.2
>     4010002200-40100022ff : lpss_priv
>   4010003000-4010003fff : 0000:00:1e.2
>     4010003000-40100031ff : lpss_dev
>     4010003200-40100032ff : lpss_priv
>     4010003800-4010003fff : idma64.4
>       4010003800-4010003fff : idma64.4
>   6000000000-6049ffffff : PCI Bus 0000:01
>     6000000000-6049ffffff : PCI Bus 0000:02
>       6000000000-601fffffff : PCI Bus 0000:04
>       6020000000-6049ffffff : PCI Bus 0000:38
>   604a000000-604affffff : 0000:00:02.0
>   604b000000-604b0fffff : 0000:00:1f.3
>     604b000000-604b0fffff : ICH HD audio
>   604b100000-604b10ffff : 0000:00:14.0
>     604b100000-604b10ffff : xhci-hcd
>   604b110000-604b117fff : 0000:00:04.0
>     604b110000-604b117fff : proc_thermal
>   604b118000-604b11bfff : 0000:00:1f.3
>     604b118000-604b11bfff : ICH HD audio
>   604b11c000-604b11ffff : 0000:00:14.3
>     604b11c000-604b11ffff : iwlwifi
>   604b120000-604b121fff : 0000:00:14.2
>   604b122000-604b1220ff : 0000:00:1f.4
>   604b124000-604b124fff : 0000:00:1e.0
>   604b125000-604b125fff : 0000:00:1e.0
>     604b125000-604b1251ff : lpss_dev
>     604b125200-604b1252ff : lpss_priv
>     604b125800-604b125fff : idma64.3
>       604b125800-604b125fff : idma64.3
>   604b127000-604b127fff : 0000:00:16.0
>     604b127000-604b127fff : mei_me
>   604b12a000-604b12afff : 0000:00:14.2
>   604b12b000-604b12bfff : 0000:00:12.0
>     604b12b000-604b12bfff : Intel PCH thermal driver
>   604b12c000-604b12cfff : 0000:00:08.0

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
