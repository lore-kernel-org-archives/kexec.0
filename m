Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1eBdIV-0008Ox-Fb
 for kexec@lists.infradead.org; Mon, 06 Nov 2017 09:02:29 +0000
Date: Mon, 6 Nov 2017 10:01:55 +0100
From: Jiri Bohac <jbohac@suse.cz>
Subject: Re: [PATCH] x86/kexec: Exclude GART aperture from vmcore
Message-ID: <20171106090155.p7jhe2m57whfxma3@dwarf.suse.cz>
References: <20171103172822.4ty6yjhewroe4z4j@dwarf.suse.cz>
 <20171106024143.GA3669@x1>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20171106024143.GA3669@x1>
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
To: Baoquan He <bhe@redhat.com>
Cc: Toshi Kani <toshi.kani@hpe.com>, David Airlie <airlied@linux.ie>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

Hi Baoquan,

On Mon, Nov 06, 2017 at 10:41:43AM +0800, Baoquan He wrote:
> Is this reproduced on a machine with GART existing and passing test with
> this patch applied? Do you have a /proc/iomem printing about the machine
> you are testing on?

I've seen this on at least three different machines. Two of them,
I am able to test things on. The one I've been using to test the
patch is not a production system, but that should not play any role here:


excerpts of /proc/cpuinfo (first CPU only):
	processor	: 0
	vendor_id	: AuthenticAMD
	cpu family	: 16
	model		: 9
	model name	: AMD Engineering Sample
	stepping	: 1
	microcode	: 0x10000c4
	cpu MHz		: 1695.829
	cache size	: 512 KB
	physical id	: 0
	siblings	: 12
	core id		: 0
	cpu cores	: 12
	flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm 3dnowext 3dnow constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid amd_dcm pni monitor cx16 popcnt lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt nodeid_msr hw_pstate vmmcall npt lbrv svm_lock nrip_save pausefilter
	bugs		: tlb_mmatch fxsave_leak sysret_ss_attrs null_seg
	address sizes	: 48 bits physical, 48 bits virtual
	power management: ts ttp tm stc 100mhzsteps hwpstate


excerpts of dmesg:
	[    0.000000] Linux version 4.14.0-rc7-test-default (geeko@buildhost) (gcc version 4.8.5 (SUSE Linux)) #1 SMP PREEMPT Tue Oct 31 14:21:34 UTC 2017 (e7b14aa)
	[    0.000000] Command line: root=/dev/sda2 console=tty0 console=ttyS0,115200 audit=0 vga=6 showopts crashkernel=101M,high crashkernel=72M,low memblock=debug
	[    0.000000] x86/fpu: x87 FPU will use FXSAVE
	[    0.000000] e820: BIOS-provided physical RAM map:
	[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009d7ff] usable
	[    0.000000] BIOS-e820: [mem 0x000000000009d800-0x000000000009ffff] reserved
	[    0.000000] BIOS-e820: [mem 0x00000000000ce000-0x00000000000fffff] reserved
	[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000c7e7ffff] usable
	[    0.000000] BIOS-e820: [mem 0x00000000c7e80000-0x00000000c7e8afff] ACPI data
	[    0.000000] BIOS-e820: [mem 0x00000000c7e8b000-0x00000000c7e8cfff] ACPI NVS
	[    0.000000] BIOS-e820: [mem 0x00000000c7e8d000-0x00000000c7ffffff] reserved
	[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000efffffff] reserved
	[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec0ffff] reserved
	[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
	[    0.000000] BIOS-e820: [mem 0x00000000fff00000-0x00000000ffffffff] reserved
	[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x0000000837ffffff] usable
	[    0.000000] NX (Execute Disable) protection: active
	[    0.000000] random: fast init done
	[    0.000000] SMBIOS 2.5 present.
	[    0.000000] DMI: AMD Dinar/Dinar, BIOS PDNAX2-0 07/12/2010
	[    0.000000] tsc: Fast TSC calibration using PIT
	[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
	[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
	[    0.000000] AGP: No AGP bridge found
	[    0.000000] e820: last_pfn = 0x838000 max_arch_pfn = 0x400000000
	[    0.000000] MTRR default type: uncachable
	[    0.000000] MTRR fixed ranges enabled:
	[    0.000000]   00000-9FFFF write-back
	[    0.000000]   A0000-BFFFF uncachable
	[    0.000000]   C0000-CFFFF write-protect
	[    0.000000]   D0000-DFFFF uncachable
	[    0.000000]   E0000-FFFFF write-protect
	[    0.000000] MTRR variable ranges enabled:
	[    0.000000]   0 base 000000000000 mask FFFF80000000 write-back
	[    0.000000]   1 base 000080000000 mask FFFFC0000000 write-back
	[    0.000000]   2 base 0000C0000000 mask FFFFF8000000 write-back
	[    0.000000]   3 disabled
	[    0.000000]   4 disabled
	[    0.000000]   5 disabled
	[    0.000000]   6 disabled
	[    0.000000]   7 disabled
	[    0.000000] TOM2: 0000000838000000 aka 33664M
	[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
	[    0.000000] e820: update [mem 0xc8000000-0xffffffff] usable ==> reserved
	[    0.000000] e820: last_pfn = 0xc7e80 max_arch_pfn = 0x400000000
	[    0.000000] found SMP MP-table at [mem 0x000f7980-0x000f798f] mapped at [ffffffffff000980]
	[    0.000000] memblock_reserve: [0x00000000000f7980-0x00000000000f798f] smp_scan_config+0xd0/0x102
	[    0.000000] memblock_reserve: [0x000000000009ddb1-0x000000000009e0b4] smp_scan_config+0xed/0x102
	[    0.000000] memblock_reserve: [0x00000004e03c9000-0x00000004e03d5fff] setup_arch+0x5dc/0xcba
	[    0.000000] memblock_add: [0x0000000000001000-0x000000000009d7ff] e820__memblock_setup+0x42/0x61
	[    0.000000] memblock_add: [0x0000000000100000-0x00000000c7e7ffff] e820__memblock_setup+0x42/0x61
	[    0.000000] memblock_add: [0x0000000100000000-0x0000000837ffffff] e820__memblock_setup+0x42/0x61
	[    0.000000] MEMBLOCK configuration:
	[    0.000000]  memory size = 0x00000007ffe1c800 reserved size = 0x00000000029b0314
	[    0.000000]  memory.cnt  = 0x3
	[    0.000000]  memory[0x0]	[0x0000000000001000-0x000000000009cfff], 0x000000000009c000 bytes flags: 0x0
	[    0.000000]  memory[0x1]	[0x0000000000100000-0x00000000c7e7ffff], 0x00000000c7d80000 bytes flags: 0x0
	[    0.000000]  memory[0x2]	[0x0000000100000000-0x0000000837ffffff], 0x0000000738000000 bytes flags: 0x0
	[    0.000000]  reserved.cnt  = 0x4
	[    0.000000]  reserved[0x0]	[0x000000000009ddb1-0x000000000009e0b4], 0x0000000000000304 bytes flags: 0x0
	[    0.000000]  reserved[0x1]	[0x00000000000f7980-0x00000000000f798f], 0x0000000000000010 bytes flags: 0x0
	[    0.000000]  reserved[0x2]	[0x0000000036a16000-0x0000000037feffff], 0x00000000015da000 bytes flags: 0x0
	[    0.000000]  reserved[0x3]	[0x00000004df000000-0x00000004e03d5fff], 0x00000000013d6000 bytes flags: 0x0
	[    0.000000] memblock_reserve: [0x000000000009d800-0x00000000000fffff] setup_arch+0x60e/0xcba
	[    0.000000] memblock_reserve: [0x0000000000001000-0x000000000000ffff] setup_bios_corruption_check+0xfa/0x195
	[    0.000000] Scanning 1 areas for low memory corruption
	[    0.000000] memblock_reserve: [0x0000000000097000-0x000000000009cfff] reserve_real_mode+0x6a/0x7a
	[    0.000000] Base memory trampoline at [ffff9154c0097000] 97000 size 24576
	[    0.000000] memblock_reserve: [0x0000000000000000-0x000000000000ffff] setup_arch+0x6f7/0xcba
	[    0.000000] Using GB pages for direct mapping
	[    0.000000] BRK [0x4e03ca000, 0x4e03cafff] PGTABLE
	[    0.000000] BRK [0x4e03cb000, 0x4e03cbfff] PGTABLE
	[    0.000000] BRK [0x4e03cc000, 0x4e03ccfff] PGTABLE
	[    0.000000] BRK [0x4e03cd000, 0x4e03cdfff] PGTABLE
	[    0.000000] BRK [0x4e03ce000, 0x4e03cefff] PGTABLE
	[    0.000000] BRK [0x4e03cf000, 0x4e03cffff] PGTABLE
	[    0.000000] BRK [0x4e03d0000, 0x4e03d0fff] PGTABLE
	[    0.000000] RAMDISK: [mem 0x36a16000-0x37feffff]
	[    0.000000] ACPI: Early table checksum verification disabled
	[    0.000000] ACPI: RSDP 0x00000000000F7900 000024 (v02 PTLTD )
	[    0.000000] ACPI: XSDT 0x00000000C7E8081A 00006C (v01 PTLTD  ? XSDT   06040000  LTP 00000000)
	[    0.000000] ACPI: FACP 0x00000000C7E86C3F 0000F4 (v03 AMD    Dinar    06040000 AMD  000F4240)
	[    0.000000] ACPI: DSDT 0x00000000C7E80886 0063B9 (v02 AMD    SB700    06040000 MSFT 03000000)
	[    0.000000] ACPI: FACS 0x00000000C7E8CFC0 000040
	[    0.000000] ACPI: FACS 0x00000000C7E8CFC0 000040
	[    0.000000] ACPI: TCPA 0x00000000C7E86DA7 000032 (v02 AMD             06040000 PTEC 00000000)
	[    0.000000] ACPI: SLIT 0x00000000C7E86DD9 00003C (v01 AMD    F10      06040000 AMD  00000001)
	[    0.000000] ACPI: SRAT 0x00000000C7E86E15 000278 (v02 AMD    F10      06040000 AMD  00000001)
	[    0.000000] ACPI: SSDT 0x00000000C7E8708D 003C6C (v01 AMD    POWERNOW 06040000 AMD  00000001)
	[    0.000000] ACPI: SSDT 0x00000000C7E8ACF9 0000F5 (v01 AMD-K8 AMD-ACPI 06040000  AMD 00000001)
	[    0.000000] ACPI: APIC 0x00000000C7E8ADEE 00019E (v01 PTLTD  ? APIC   06040000  LTP 00000000)
	[    0.000000] ACPI: MCFG 0x00000000C7E8AF8C 00003C (v01 PTLTD    MCFG   06040000  LTP 00000000)
	[    0.000000] ACPI: HPET 0x00000000C7E8AFC8 000038 (v01 PTLTD  HPETTBL  06040000  LTP 00000001)
	[    0.000000] ACPI: Local APIC address 0xfee00000
...
	[    0.000000] memblock_reserve: [0x0000000837fff000-0x0000000837fff00f] numa_set_distance+0x102/0x1f6
	[    0.000000] NUMA: Initialized distance table, cnt=4
	[    0.000000] NUMA: Node 0 [mem 0x00000000-0x0009ffff] + [mem 0x00100000-0xc7ffffff] -> [mem 0x00000000-0xc7ffffff]
	[    0.000000] NUMA: Node 0 [mem 0x00000000-0xc7ffffff] + [mem 0x100000000-0x2b7ffffff] -> [mem 0x00000000-0x2b7ffffff]
	[    0.000000] memblock_reserve: [0x00000002b7fea000-0x00000002b7ffffff] memblock_alloc_range_nid+0x32/0x3c
	[    0.000000] NODE_DATA(0) allocated [mem 0x2b7fea000-0x2b7ffffff]
	[    0.000000] memblock_reserve: [0x00000003b7fea000-0x00000003b7ffffff] memblock_alloc_range_nid+0x32/0x3c
	[    0.000000] NODE_DATA(1) allocated [mem 0x3b7fea000-0x3b7ffffff]
	[    0.000000] memblock_reserve: [0x0000000837fe9000-0x0000000837ffefff] memblock_alloc_range_nid+0x32/0x3c
	[    0.000000] NODE_DATA(2) allocated [mem 0x837fe9000-0x837ffefff]
	[    0.000000] MEMBLOCK configuration:
	[    0.000000]  memory size = 0x00000007ffe1c800 reserved size = 0x0000000002a6a810
	[    0.000000]  memory.cnt  = 0x5
	[    0.000000]  memory[0x0]	[0x0000000000001000-0x000000000009cfff], 0x000000000009c000 bytes on node 0 flags: 0x0
	[    0.000000]  memory[0x1]	[0x0000000000100000-0x00000000c7e7ffff], 0x00000000c7d80000 bytes on node 0 flags: 0x0
	[    0.000000]  memory[0x2]	[0x0000000100000000-0x00000002b7ffffff], 0x00000001b8000000 bytes on node 0 flags: 0x0
	[    0.000000]  memory[0x3]	[0x00000002b8000000-0x00000003b7ffffff], 0x0000000100000000 bytes on node 1 flags: 0x0
	[    0.000000]  memory[0x4]	[0x00000003b8000000-0x0000000837ffffff], 0x0000000480000000 bytes on node 2 flags: 0x0
	[    0.000000]  reserved.cnt  = 0x9
	[    0.000000]  reserved[0x0]	[0x0000000000000000-0x000000000000ffff], 0x0000000000010000 bytes on node 0 flags: 0x0
	[    0.000000]  reserved[0x1]	[0x0000000000097000-0x000000000009cfff], 0x0000000000006000 bytes on node 0 flags: 0x0
	[    0.000000]  reserved[0x2]	[0x000000000009d800-0x00000000000fffff], 0x0000000000062800 bytes on node 0 flags: 0x0
	[    0.000000]  reserved[0x3]	[0x0000000036a16000-0x0000000037feffff], 0x00000000015da000 bytes on node 0 flags: 0x0
	[    0.000000]  reserved[0x4]	[0x00000002b7fea000-0x00000002b7ffffff], 0x0000000000016000 bytes flags: 0x0
	[    0.000000]  reserved[0x5]	[0x00000003b7fea000-0x00000003b7ffffff], 0x0000000000016000 bytes flags: 0x0
	[    0.000000]  reserved[0x6]	[0x00000004df000000-0x00000004e03d5fff], 0x00000000013d6000 bytes on node 2 flags: 0x0
	[    0.000000]  reserved[0x7]	[0x0000000837fe9000-0x0000000837ffefff], 0x0000000000016000 bytes flags: 0x0
	[    0.000000]  reserved[0x8]	[0x0000000837fff000-0x0000000837fff00f], 0x0000000000000010 bytes on node 2 flags: 0x0
	[    0.000000] memblock_reserve: [0x0000000831000000-0x00000008374fffff] setup_arch+0xa4a/0xcba
	[    0.000000] memblock_reserve: [0x00000000c3000000-0x00000000c77fffff] setup_arch+0xb1e/0xcba
	[    0.000000] Reserving 72MB of low memory at 3120MB for crashkernel (System low RAM: 3198MB)
	[    0.000000] Reserving 101MB of memory at 33552MB for crashkernel (System RAM: 32766MB)
	[    0.000000] memblock_virt_alloc_try_nid: 4096 bytes align=0x0 nid=0 from=0x0 max_addr=0x0 memory_present+0x67/0xb0
	[    0.000000] memblock_reserve: [0x00000002b7fe9000-0x00000002b7fe9fff] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] memblock_virt_alloc_try_nid: 4096 bytes align=0x0 nid=2 from=0x0 max_addr=0x0 memory_present+0x67/0xb0
	[    0.000000] memblock_reserve: [0x0000000837fe8000-0x0000000837fe8fff] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] memblock_virt_alloc_try_nid: 4194304 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 sparse_init+0x22/0x14b
	[    0.000000] memblock_reserve: [0x0000000837be8000-0x0000000837fe7fff] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] memblock_virt_alloc_try_nid_nopanic: 2560 bytes align=0x40 nid=0 from=0x2b0000000 max_addr=0x2b8000000 sparse_early_usemaps_alloc_node+0x8d/0x202
	[    0.000000] memblock_reserve: [0x00000002b7fe8600-0x00000002b7fe8fff] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] memblock_virt_alloc_try_nid_nopanic: 1024 bytes align=0x40 nid=1 from=0x3b0000000 max_addr=0x3b8000000 sparse_early_usemaps_alloc_node+0x8d/0x202
	[    0.000000] memblock_reserve: [0x00000003b7fe9c00-0x00000003b7fe9fff] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] memblock_virt_alloc_try_nid_nopanic: 4608 bytes align=0x40 nid=2 from=0x830000000 max_addr=0x838000000 sparse_early_usemaps_alloc_node+0x8d/0x202
	[    0.000000] memblock_reserve: [0x0000000837be6e00-0x0000000837be7fff] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] memblock_virt_alloc_try_nid: 4194304 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 sparse_init+0x5b/0x14b
	[    0.000000] memblock_reserve: [0x00000008377e6e00-0x0000000837be6dff] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] memblock_virt_alloc_try_nid: 167772160 bytes align=0x200000 nid=0 from=0x1000000 max_addr=0x0 sparse_mem_maps_populate_node+0x66/0x168
	[    0.000000] memblock_reserve: [0x00000002ade00000-0x00000002b7dfffff] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] memblock_virt_alloc_try_nid: 4096 bytes align=0x1000 nid=0 from=0x1000000 max_addr=0x0 vmemmap_p4d_populate+0x23/0xaf
	[    0.000000] memblock_reserve: [0x00000002b7fe7000-0x00000002b7fe7fff] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] memblock_virt_alloc_try_nid: 4096 bytes align=0x1000 nid=0 from=0x1000000 max_addr=0x0 vmemmap_pud_populate+0x5b/0xe9
	[    0.000000] memblock_reserve: [0x00000002b7fe6000-0x00000002b7fe6fff] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] __memblock_free_early: [0x000002b7e00000-0x000002b7dfffff] sparse_mem_maps_populate_node+0xf9/0x168
	[    0.000000] memblock_virt_alloc_try_nid: 67108864 bytes align=0x200000 nid=1 from=0x1000000 max_addr=0x0 sparse_mem_maps_populate_node+0x66/0x168
	[    0.000000] memblock_reserve: [0x00000003b3e00000-0x00000003b7dfffff] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] __memblock_free_early: [0x000003b7e00000-0x000003b7dfffff] sparse_mem_maps_populate_node+0xf9/0x168
	[    0.000000] memblock_virt_alloc_try_nid: 301989888 bytes align=0x200000 nid=2 from=0x1000000 max_addr=0x0 sparse_mem_maps_populate_node+0x66/0x168
	[    0.000000] memblock_reserve: [0x000000081f000000-0x0000000830ffffff] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] __memblock_free_early: [0x00000831000000-0x00000830ffffff] sparse_mem_maps_populate_node+0xf9/0x168
	[    0.000000] __memblock_free_early: [0x000008377e6e00-0x00000837be6dff] sparse_init+0x119/0x14b
	[    0.000000] __memblock_free_early: [0x00000837be8000-0x00000837fe7fff] paging_init+0x14/0x31
	[    0.000000] Zone ranges:
	[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
	[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
	[    0.000000]   Normal   [mem 0x0000000100000000-0x0000000837ffffff]
	[    0.000000]   Device   empty
	[    0.000000] Movable zone start for each node
	[    0.000000] Early memory node ranges
	[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009cfff]
	[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000c7e7ffff]
	[    0.000000]   node   0: [mem 0x0000000100000000-0x00000002b7ffffff]
	[    0.000000]   node   1: [mem 0x00000002b8000000-0x00000003b7ffffff]
	[    0.000000]   node   2: [mem 0x00000003b8000000-0x0000000837ffffff]
	[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x00000002b7ffffff]
	[    0.000000] On node 0 totalpages: 2620956
	[    0.000000]   DMA zone: 64 pages used for memmap
	[    0.000000]   DMA zone: 21 pages reserved
	[    0.000000]   DMA zone: 3996 pages, LIFO batch:0
	[    0.000000]   DMA32 zone: 12730 pages used for memmap
	[    0.000000]   DMA32 zone: 814720 pages, LIFO batch:31
	[    0.000000]   Normal zone: 28160 pages used for memmap
	[    0.000000]   Normal zone: 1802240 pages, LIFO batch:31
	[    0.000000] Initmem setup node 1 [mem 0x00000002b8000000-0x00000003b7ffffff]
	[    0.000000] On node 1 totalpages: 1048576
	[    0.000000]   Normal zone: 16384 pages used for memmap
	[    0.000000]   Normal zone: 1048576 pages, LIFO batch:31
	[    0.000000] Initmem setup node 2 [mem 0x00000003b8000000-0x0000000837ffffff]
	[    0.000000] On node 2 totalpages: 4718592
	[    0.000000]   Normal zone: 73728 pages used for memmap
	[    0.000000]   Normal zone: 4718592 pages, LIFO batch:31
	[    0.000000] memblock_reserve: [0x0000000837fe7000-0x0000000837fe7fff] __alloc_memory_core_early+0x84/0xac
...
	[    0.000000] IOAPIC[0]: apic_id 0, version 33, address 0xfec00000, GSI 0-23
	[    0.000000] IOAPIC[1]: apic_id 1, version 33, address 0xc8000000, GSI 24-55
	[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 low level)
	[    0.000000] ACPI: IRQ0 used by override.
	[    0.000000] ACPI: IRQ9 used by override.
	[    0.000000] Using ACPI (MADT) for SMP configuration information
	[    0.000000] ACPI: HPET id: 0x43538301 base: 0xfed00000
	[    0.000000] memblock_reserve: [0x0000000837ffff80-0x0000000837ffffc8] __alloc_memory_core_early+0x84/0xac
	[    0.000000] smpboot: Allowing 24 CPUs, 0 hotplug CPUs
	[    0.000000] memblock_reserve: [0x0000000837fd1000-0x0000000837fe6fff] memblock_alloc_range_nid+0x32/0x3c
	[    0.000000] NODE_DATA(3) allocated [mem 0x837fd1000-0x837fe6fff]
	[    0.000000]     NODE_DATA(3) on node 2
	[    0.000000] Initmem setup node 3 [mem 0x0000000000000000-0x0000000000000000]
	[    0.000000] On node 3 totalpages: 0
	[    0.000000] memblock_reserve: [0x0000000837fffec0-0x0000000837ffff55] __alloc_memory_core_early+0x84/0xac
	[    0.000000] memblock_reserve: [0x0000000837fffb80-0x0000000837fffebf] __alloc_memory_core_early+0x84/0xac
	[    0.000000] memblock_virt_alloc_try_nid: 104 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 firmware_map_add_early+0x26/0x4c
	[    0.000000] memblock_reserve: [0x0000000837fffb00-0x0000000837fffb67] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] memblock_virt_alloc_try_nid: 104 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 firmware_map_add_early+0x26/0x4c
	[    0.000000] memblock_reserve: [0x0000000837fffa80-0x0000000837fffae7] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] memblock_virt_alloc_try_nid: 104 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 firmware_map_add_early+0x26/0x4c
	[    0.000000] memblock_reserve: [0x0000000837fffa00-0x0000000837fffa67] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] memblock_virt_alloc_try_nid: 104 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 firmware_map_add_early+0x26/0x4c
	[    0.000000] memblock_reserve: [0x0000000837fff980-0x0000000837fff9e7] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] memblock_virt_alloc_try_nid: 104 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 firmware_map_add_early+0x26/0x4c
	[    0.000000] memblock_reserve: [0x0000000837fff900-0x0000000837fff967] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] memblock_virt_alloc_try_nid: 104 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 firmware_map_add_early+0x26/0x4c
	[    0.000000] memblock_reserve: [0x0000000837fff880-0x0000000837fff8e7] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] memblock_virt_alloc_try_nid: 104 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 firmware_map_add_early+0x26/0x4c
	[    0.000000] memblock_reserve: [0x0000000837fff800-0x0000000837fff867] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] memblock_virt_alloc_try_nid: 104 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 firmware_map_add_early+0x26/0x4c
	[    0.000000] memblock_reserve: [0x0000000837fff780-0x0000000837fff7e7] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] memblock_virt_alloc_try_nid: 104 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 firmware_map_add_early+0x26/0x4c
	[    0.000000] memblock_reserve: [0x0000000837fff700-0x0000000837fff767] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] memblock_virt_alloc_try_nid: 104 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 firmware_map_add_early+0x26/0x4c
	[    0.000000] memblock_reserve: [0x0000000837fff680-0x0000000837fff6e7] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] memblock_virt_alloc_try_nid: 104 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 firmware_map_add_early+0x26/0x4c
	[    0.000000] memblock_reserve: [0x0000000837fff600-0x0000000837fff667] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] memblock_virt_alloc_try_nid: 104 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 firmware_map_add_early+0x26/0x4c
	[    0.000000] memblock_reserve: [0x0000000837fff580-0x0000000837fff5e7] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] memblock_virt_alloc_try_nid: 32 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 __register_nosave_region+0x74/0xdd
	[    0.000000] memblock_reserve: [0x0000000837fff540-0x0000000837fff55f] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
	[    0.000000] memblock_virt_alloc_try_nid: 32 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 __register_nosave_region+0x74/0xdd
	[    0.000000] memblock_reserve: [0x0000000837fff500-0x0000000837fff51f] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] PM: Registered nosave memory: [mem 0x0009d000-0x0009dfff]
	[    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009ffff]
	[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000cdfff]
	[    0.000000] PM: Registered nosave memory: [mem 0x000ce000-0x000fffff]
	[    0.000000] memblock_virt_alloc_try_nid: 32 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 __register_nosave_region+0x74/0xdd
	[    0.000000] memblock_reserve: [0x0000000837fff4c0-0x0000000837fff4df] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] PM: Registered nosave memory: [mem 0xc7e80000-0xc7e8afff]
	[    0.000000] PM: Registered nosave memory: [mem 0xc7e8b000-0xc7e8cfff]
	[    0.000000] PM: Registered nosave memory: [mem 0xc7e8d000-0xc7ffffff]
	[    0.000000] PM: Registered nosave memory: [mem 0xc8000000-0xdfffffff]
	[    0.000000] PM: Registered nosave memory: [mem 0xe0000000-0xefffffff]
	[    0.000000] PM: Registered nosave memory: [mem 0xf0000000-0xfebfffff]
	[    0.000000] PM: Registered nosave memory: [mem 0xfec00000-0xfec0ffff]
	[    0.000000] PM: Registered nosave memory: [mem 0xfec10000-0xfedfffff]
	[    0.000000] PM: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
	[    0.000000] PM: Registered nosave memory: [mem 0xfee01000-0xffefffff]
	[    0.000000] PM: Registered nosave memory: [mem 0xfff00000-0xffffffff]
	[    0.000000] e820: [mem 0xc8000000-0xdfffffff] available for PCI devices
	[    0.000000] Booting paravirtualized kernel on bare hardware
	[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
	[    0.000000] memblock_virt_alloc_try_nid: 129 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 start_kernel+0x107/0x4b0
	[    0.000000] memblock_reserve: [0x0000000837fff400-0x0000000837fff480] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] memblock_virt_alloc_try_nid: 129 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 start_kernel+0x130/0x4b0
	[    0.000000] memblock_reserve: [0x0000000837fff340-0x0000000837fff3c0] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] memblock_virt_alloc_try_nid: 129 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 start_kernel+0x159/0x4b0
	[    0.000000] memblock_reserve: [0x0000000837fff280-0x0000000837fff300] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512 nr_cpu_ids:24 nr_node_ids:4
	[    0.000000] memblock_virt_alloc_try_nid_nopanic: 4096 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_alloc_alloc_info+0x3f/0x74
	[    0.000000] memblock_reserve: [0x0000000837fd0000-0x0000000837fd0fff] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] memblock_virt_alloc_try_nid_nopanic: 4096 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_embed_first_chunk+0x7d/0x2e5
	[    0.000000] memblock_reserve: [0x0000000837fcf000-0x0000000837fcffff] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] memblock_reserve: [0x00000002adc00000-0x00000002addfffff] __alloc_memory_core_early+0x84/0xac
	[    0.000000] memblock_reserve: [0x00000003b3c00000-0x00000003b3dfffff] __alloc_memory_core_early+0x84/0xac
	[    0.000000] memblock_reserve: [0x0000000837c00000-0x0000000837dfffff] __alloc_memory_core_early+0x84/0xac
	[    0.000000] memblock_reserve: [0x0000000837800000-0x00000008379fffff] __alloc_memory_core_early+0x84/0xac
	[    0.000000]    memblock_free: [0x00000002adc27000-0x00000002adc3ffff] pcpu_embed_first_chunk+0x1f7/0x2e5
	[    0.000000]    memblock_free: [0x00000002adc67000-0x00000002adc7ffff] pcpu_embed_first_chunk+0x1f7/0x2e5
	[    0.000000]    memblock_free: [0x00000002adca7000-0x00000002adcbffff] pcpu_embed_first_chunk+0x1f7/0x2e5
	[    0.000000]    memblock_free: [0x00000002adce7000-0x00000002adcfffff] pcpu_embed_first_chunk+0x1f7/0x2e5
	[    0.000000]    memblock_free: [0x00000002add27000-0x00000002add3ffff] pcpu_embed_first_chunk+0x1f7/0x2e5
	[    0.000000]    memblock_free: [0x00000002add67000-0x00000002add7ffff] pcpu_embed_first_chunk+0x1f7/0x2e5
	[    0.000000]    memblock_free: [0x00000002add80000-0x00000002addbffff] pcpu_embed_first_chunk+0x1a3/0x2e5
	[    0.000000]    memblock_free: [0x00000002addc0000-0x00000002addfffff] pcpu_embed_first_chunk+0x1a3/0x2e5
	[    0.000000]    memblock_free: [0x00000003b3c27000-0x00000003b3c3ffff] pcpu_embed_first_chunk+0x1f7/0x2e5
	[    0.000000]    memblock_free: [0x00000003b3c67000-0x00000003b3c7ffff] pcpu_embed_first_chunk+0x1f7/0x2e5
	[    0.000000]    memblock_free: [0x00000003b3ca7000-0x00000003b3cbffff] pcpu_embed_first_chunk+0x1f7/0x2e5
	[    0.000000]    memblock_free: [0x00000003b3ce7000-0x00000003b3cfffff] pcpu_embed_first_chunk+0x1f7/0x2e5
	[    0.000000]    memblock_free: [0x00000003b3d27000-0x00000003b3d3ffff] pcpu_embed_first_chunk+0x1f7/0x2e5
	[    0.000000]    memblock_free: [0x00000003b3d67000-0x00000003b3d7ffff] pcpu_embed_first_chunk+0x1f7/0x2e5
	[    0.000000]    memblock_free: [0x00000003b3d80000-0x00000003b3dbffff] pcpu_embed_first_chunk+0x1a3/0x2e5
	[    0.000000]    memblock_free: [0x00000003b3dc0000-0x00000003b3dfffff] pcpu_embed_first_chunk+0x1a3/0x2e5
	[    0.000000]    memblock_free: [0x0000000837c27000-0x0000000837c3ffff] pcpu_embed_first_chunk+0x1f7/0x2e5
	[    0.000000]    memblock_free: [0x0000000837c67000-0x0000000837c7ffff] pcpu_embed_first_chunk+0x1f7/0x2e5
	[    0.000000]    memblock_free: [0x0000000837ca7000-0x0000000837cbffff] pcpu_embed_first_chunk+0x1f7/0x2e5
	[    0.000000]    memblock_free: [0x0000000837ce7000-0x0000000837cfffff] pcpu_embed_first_chunk+0x1f7/0x2e5
	[    0.000000]    memblock_free: [0x0000000837d27000-0x0000000837d3ffff] pcpu_embed_first_chunk+0x1f7/0x2e5
	[    0.000000]    memblock_free: [0x0000000837d67000-0x0000000837d7ffff] pcpu_embed_first_chunk+0x1f7/0x2e5
	[    0.000000]    memblock_free: [0x0000000837d80000-0x0000000837dbffff] pcpu_embed_first_chunk+0x1a3/0x2e5
	[    0.000000]    memblock_free: [0x0000000837dc0000-0x0000000837dfffff] pcpu_embed_first_chunk+0x1a3/0x2e5
	[    0.000000]    memblock_free: [0x0000000837827000-0x000000083783ffff] pcpu_embed_first_chunk+0x1f7/0x2e5
	[    0.000000]    memblock_free: [0x0000000837867000-0x000000083787ffff] pcpu_embed_first_chunk+0x1f7/0x2e5
	[    0.000000]    memblock_free: [0x00000008378a7000-0x00000008378bffff] pcpu_embed_first_chunk+0x1f7/0x2e5
	[    0.000000]    memblock_free: [0x00000008378e7000-0x00000008378fffff] pcpu_embed_first_chunk+0x1f7/0x2e5
	[    0.000000]    memblock_free: [0x0000000837927000-0x000000083793ffff] pcpu_embed_first_chunk+0x1f7/0x2e5
	[    0.000000]    memblock_free: [0x0000000837967000-0x000000083797ffff] pcpu_embed_first_chunk+0x1f7/0x2e5
	[    0.000000]    memblock_free: [0x0000000837980000-0x00000008379bffff] pcpu_embed_first_chunk+0x1a3/0x2e5
	[    0.000000]    memblock_free: [0x00000008379c0000-0x00000008379fffff] pcpu_embed_first_chunk+0x1a3/0x2e5
	[    0.000000] percpu: Embedded 39 pages/cpu @ffff91576dc00000 s121752 r8192 d29800 u262144
	[    0.000000] memblock_virt_alloc_try_nid: 32 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x310/0x6a9
	[    0.000000] memblock_reserve: [0x0000000837fff240-0x0000000837fff25f] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] memblock_virt_alloc_try_nid: 32 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x320/0x6a9
	[    0.000000] memblock_reserve: [0x0000000837fff200-0x0000000837fff21f] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] memblock_virt_alloc_try_nid: 96 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x332/0x6a9
	[    0.000000] memblock_reserve: [0x0000000837fff180-0x0000000837fff1df] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] memblock_virt_alloc_try_nid: 192 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x344/0x6a9
	[    0.000000] memblock_reserve: [0x0000000837fff0c0-0x0000000837fff17f] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] pcpu-alloc: s121752 r8192 d29800 u262144 alloc=1*2097152
	[    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 -- -- [1] 06 07 08 09 10 11 -- -- 
	[    0.000000] pcpu-alloc: [2] 12 13 14 15 16 17 -- -- [3] 18 19 20 21 22 23 -- -- 
	[    0.000000] memblock_virt_alloc_try_nid: 288 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_setup_first_chunk+0x602/0x6a9
	[    0.000000] memblock_reserve: [0x0000000837fceec0-0x0000000837fcefdf] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] memblock_virt_alloc_try_nid: 105 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_alloc_first_chunk+0x6a/0x215
	[    0.000000] memblock_reserve: [0x0000000837fff040-0x0000000837fff0a8] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] memblock_virt_alloc_try_nid: 384 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_alloc_first_chunk+0xa5/0x215
	[    0.000000] memblock_reserve: [0x0000000837fced40-0x0000000837fceebf] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] memblock_virt_alloc_try_nid: 392 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_alloc_first_chunk+0xc1/0x215
	[    0.000000] memblock_reserve: [0x0000000837fceb80-0x0000000837fced07] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] memblock_virt_alloc_try_nid: 60 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_alloc_first_chunk+0xd2/0x215
	[    0.000000] memblock_reserve: [0x0000000837fceb40-0x0000000837fceb7b] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] memblock_virt_alloc_try_nid: 105 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_alloc_first_chunk+0x6a/0x215
	[    0.000000] memblock_reserve: [0x0000000837fceac0-0x0000000837fceb28] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] memblock_virt_alloc_try_nid: 1024 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_alloc_first_chunk+0xa5/0x215
	[    0.000000] memblock_reserve: [0x0000000837fce6c0-0x0000000837fceabf] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] memblock_virt_alloc_try_nid: 1032 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_alloc_first_chunk+0xc1/0x215
	[    0.000000] memblock_reserve: [0x0000000837fce280-0x0000000837fce687] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] memblock_virt_alloc_try_nid: 160 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 pcpu_alloc_first_chunk+0xd2/0x215
	[    0.000000] memblock_reserve: [0x0000000837fce1c0-0x0000000837fce25f] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] __memblock_free_early: [0x00000837fd0000-0x00000837fd0fff] pcpu_embed_first_chunk+0x29c/0x2e5
	[    0.000000] __memblock_free_early: [0x00000837fcf000-0x00000837fcffff] pcpu_embed_first_chunk+0x2d4/0x2e5
	[    0.000000] Built 4 zonelists, mobility grouping on.  Total pages: 8257037
	[    0.000000] Policy zone: Normal
	[    0.000000] Kernel command line: root=/dev/sda2 console=tty0 console=ttyS0,115200 audit=0 vga=6 showopts crashkernel=101M,high crashkernel=72M,low memblock=debug
	[    0.000000] audit: disabled (until reboot)
	[    0.000000] log_buf_len individual max cpu contribution: 32768 bytes
	[    0.000000] log_buf_len total cpu_extra contributions: 753664 bytes
	[    0.000000] log_buf_len min size: 262144 bytes
	[    0.000000] memblock_virt_alloc_try_nid_nopanic: 1048576 bytes align=0x4 nid=-1 from=0x0 max_addr=0x0 setup_log_buf+0xd6/0x1df
	[    0.000000] memblock_reserve: [0x0000000837ece1c0-0x0000000837fce1bf] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] log_buf_len: 1048576 bytes
	[    0.000000] early log buf free: 227236(86%)
	[    0.000000] memblock_virt_alloc_try_nid_nopanic: 32768 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 alloc_large_system_hash+0x15c/0x24b
	[    0.000000] memblock_reserve: [0x0000000837ec61c0-0x0000000837ece1bf] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
	[    0.000000] memblock_virt_alloc_try_nid_nopanic: 67108864 bytes align=0x1000 nid=-1 from=0x0 max_addr=0xffffffff swiotlb_init+0x46/0xa5
	[    0.000000] memblock_reserve: [0x00000000bf000000-0x00000000c2ffffff] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] memblock_virt_alloc_try_nid_nopanic: 32768 bytes align=0x1000 nid=-1 from=0x0 max_addr=0xffffffff swiotlb_init_with_tbl+0x60/0x172
	[    0.000000] memblock_reserve: [0x00000000c7e78000-0x00000000c7e7ffff] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] memblock_virt_alloc_try_nid: 131072 bytes align=0x1000 nid=-1 from=0x0 max_addr=0x0 swiotlb_init_with_tbl+0xc4/0x172
	[    0.000000] memblock_reserve: [0x0000000837ea6000-0x0000000837ec5fff] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] memblock_virt_alloc_try_nid: 262144 bytes align=0x1000 nid=-1 from=0x0 max_addr=0x0 swiotlb_init_with_tbl+0xf3/0x172
	[    0.000000] memblock_reserve: [0x0000000837e66000-0x0000000837ea5fff] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] AGP: Checking aperture...
	[    0.000000] AGP: No AGP bridge found
	[    0.000000] AGP: Node 0: aperture [bus addr 0xac000000-0xadffffff] (32MB)
	[    0.000000] Aperture pointing to e820 RAM. Ignoring.
	[    0.000000] AGP: Your BIOS doesn't leave an aperture memory hole
	[    0.000000] AGP: Please enable the IOMMU option in the BIOS setup
	[    0.000000] AGP: This costs you 64MB of RAM
	[    0.000000] memblock_reserve: [0x00000000b8000000-0x00000000bbffffff] gart_iommu_hole_init+0x396/0x4b6
	[    0.000000] AGP: Mapping aperture over RAM [mem 0xb8000000-0xbbffffff] (65536KB)
^^^^^
	[    0.000000] memblock_virt_alloc_try_nid: 32 bytes align=0x0 nid=-1 from=0x0 max_addr=0x0 __register_nosave_region+0x74/0xdd
	[    0.000000] memblock_reserve: [0x0000000837fd0fc0-0x0000000837fd0fdf] memblock_virt_alloc_internal+0xc4/0x14f
	[    0.000000] PM: Registered nosave memory: [mem 0xb8000000-0xbbffffff]
	[    0.000000] Memory: 9601172K/33552496K available (7755K kernel code, 1397K rwdata, 3352K rodata, 1924K init, 1364K bss, 880900K reserved, 0K cma-reserved)
...
	[    3.072003] bus: [bus 00-bf] on node 0 link 3
	[    3.072005] bus: 00 [io  0x0000-0xffff]
	[    3.072006] bus: 00 [mem 0xc8000000-0xcfffffff]
	[    3.072007] bus: 00 [mem 0xd0000000-0xdfffffff]
	[    3.072008] bus: 00 [mem 0xf0000000-0xffffffff]
	[    3.072009] bus: 00 [mem 0x838000000-0xfcffffffff]
	[    3.076097] ACPI: bus type PCI registered
	[    3.080008] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
	[    3.084163] PCI: MMCONFIG for domain 0000 [bus 00-02] at [mem 0xe0000000-0xe02fffff] (base 0xe0000000)
	[    3.096006] PCI: MMCONFIG at [mem 0xe0000000-0xe02fffff] reserved in E820
	[    3.100022] PCI: Using configuration type 1 for base access
...
	[    3.257874] PCI host bridge to bus 0000:00
	[    3.264005] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
	[    3.268003] pci_bus 0000:00: root bus resource [io  0x0d00-0x3fff window]
	[    3.276003] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
	[    3.284003] pci_bus 0000:00: root bus resource [mem 0xd0000000-0xd7ffffff window]
	[    3.292003] pci_bus 0000:00: root bus resource [mem 0xc8000000-0xce0fffff window]
	[    3.300003] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000cafff window]
	[    3.308003] pci_bus 0000:00: root bus resource [mem 0xfed40000-0xfed45000 window]
	[    3.316003] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
	[    3.320003] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
	[    3.328004] pci_bus 0000:00: root bus resource [bus 00-bf]
	[    3.336013] pci 0000:00:00.0: [1002:5a10] type 00 class 0x060000
	[    3.336197] pci 0000:00:04.0: [1002:5a18] type 01 class 0x060400
	[    3.336215] pci 0000:00:04.0: enabling Extended Tags
	[    3.340027] pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
	[    3.340222] pci 0000:00:11.0: [1002:4390] type 00 class 0x01018f
	[    3.340244] pci 0000:00:11.0: reg 0x10: [io  0x2430-0x2437]
	[    3.340253] pci 0000:00:11.0: reg 0x14: [io  0x2424-0x2427]
	[    3.340262] pci 0000:00:11.0: reg 0x18: [io  0x2428-0x242f]
	[    3.340271] pci 0000:00:11.0: reg 0x1c: [io  0x2420-0x2423]
	[    3.340280] pci 0000:00:11.0: reg 0x20: [io  0x2400-0x240f]
	[    3.340289] pci 0000:00:11.0: reg 0x24: [mem 0xc8014000-0xc80143ff]
	[    3.340314] pci 0000:00:11.0: set SATA to AHCI mode
	[    3.344192] pci 0000:00:12.0: [1002:4397] type 00 class 0x0c0310
	[    3.344210] pci 0000:00:12.0: reg 0x10: [mem 0xc8015000-0xc8015fff]
	[    3.344431] pci 0000:00:12.1: [1002:4398] type 00 class 0x0c0310
	[    3.344449] pci 0000:00:12.1: reg 0x10: [mem 0xc8016000-0xc8016fff]
	[    3.344674] pci 0000:00:12.2: [1002:4396] type 00 class 0x0c0320
	[    3.344695] pci 0000:00:12.2: reg 0x10: [mem 0xc8014400-0xc80144ff]
	[    3.344773] pci 0000:00:12.2: supports D1 D2
	[    3.344775] pci 0000:00:12.2: PME# supported from D0 D1 D2 D3hot
	[    3.344949] pci 0000:00:13.0: [1002:4397] type 00 class 0x0c0310
	[    3.344967] pci 0000:00:13.0: reg 0x10: [mem 0xc8017000-0xc8017fff]
	[    3.345186] pci 0000:00:13.1: [1002:4398] type 00 class 0x0c0310
	[    3.345204] pci 0000:00:13.1: reg 0x10: [mem 0xc8018000-0xc8018fff]
	[    3.345425] pci 0000:00:13.2: [1002:4396] type 00 class 0x0c0320
	[    3.345446] pci 0000:00:13.2: reg 0x10: [mem 0xc8014800-0xc80148ff]
	[    3.345525] pci 0000:00:13.2: supports D1 D2
	[    3.345527] pci 0000:00:13.2: PME# supported from D0 D1 D2 D3hot
	[    3.345701] pci 0000:00:14.0: [1002:4385] type 00 class 0x0c0500
	[    3.345948] pci 0000:00:14.1: [1002:439c] type 00 class 0x01018a
	[    3.345968] pci 0000:00:14.1: reg 0x10: [io  0x01f0-0x01f7]
	[    3.345977] pci 0000:00:14.1: reg 0x14: [io  0x03f4-0x03f7]
	[    3.345987] pci 0000:00:14.1: reg 0x18: [io  0x0170-0x0177]
	[    3.345995] pci 0000:00:14.1: reg 0x1c: [io  0x0374-0x0377]
	[    3.346004] pci 0000:00:14.1: reg 0x20: [io  0x2410-0x241f]
	[    3.346024] pci 0000:00:14.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
	[    3.352003] pci 0000:00:14.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
	[    3.360003] pci 0000:00:14.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
	[    3.368002] pci 0000:00:14.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
	[    3.376185] pci 0000:00:14.3: [1002:439d] type 00 class 0x060100
	[    3.376412] pci 0000:00:14.4: [1002:4384] type 01 class 0x060401
	[    3.376619] pci 0000:00:14.5: [1002:4399] type 00 class 0x0c0310
	[    3.376637] pci 0000:00:14.5: reg 0x10: [mem 0xc8019000-0xc8019fff]
	[    3.376859] pci 0000:00:18.0: [1022:1200] type 00 class 0x060000
	[    3.377000] pci 0000:00:18.1: [1022:1201] type 00 class 0x060000
	[    3.377122] pci 0000:00:18.2: [1022:1202] type 00 class 0x060000
	[    3.377247] pci 0000:00:18.3: [1022:1203] type 00 class 0x060000
	[    3.377373] pci 0000:00:18.4: [1022:1204] type 00 class 0x060000
	[    3.377373] pci 0000:00:19.0: [1022:1200] type 00 class 0x060000
	[    3.377373] pci 0000:00:19.1: [1022:1201] type 00 class 0x060000
	[    3.377373] pci 0000:00:19.2: [1022:1202] type 00 class 0x060000
	[    3.377373] pci 0000:00:19.3: [1022:1203] type 00 class 0x060000
	[    3.377373] pci 0000:00:19.4: [1022:1204] type 00 class 0x060000
	[    3.377373] pci 0000:00:1a.0: [1022:1200] type 00 class 0x060000
	[    3.377373] pci 0000:00:1a.1: [1022:1201] type 00 class 0x060000
	[    3.377373] pci 0000:00:1a.2: [1022:1202] type 00 class 0x060000
	[    3.377373] pci 0000:00:1a.3: [1022:1203] type 00 class 0x060000
	[    3.377373] pci 0000:00:1a.4: [1022:1204] type 00 class 0x060000
	[    3.377373] pci 0000:00:1b.0: [1022:1200] type 00 class 0x060000
	[    3.377457] pci 0000:00:1b.1: [1022:1201] type 00 class 0x060000
	[    3.377584] pci 0000:00:1b.2: [1022:1202] type 00 class 0x060000
	[    3.377709] pci 0000:00:1b.3: [1022:1203] type 00 class 0x060000
	[    3.377843] pci 0000:00:1b.4: [1022:1204] type 00 class 0x060000
	[    3.378063] pci 0000:01:00.0: [14e4:1639] type 00 class 0x020000
	[    3.378120] pci 0000:01:00.0: reg 0x10: [mem 0xca000000-0xcbffffff 64bit]
	[    3.378148] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
	[    3.378208] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
	[    3.378287] pci 0000:01:00.1: [14e4:1639] type 00 class 0x020000
	[    3.378307] pci 0000:01:00.1: reg 0x10: [mem 0xcc000000-0xcdffffff 64bit]
	[    3.378335] pci 0000:01:00.1: reg 0x30: [mem 0x00000000-0x0001ffff pref]
	[    3.378394] pci 0000:01:00.1: PME# supported from D0 D3hot D3cold
	[    3.392042] pci 0000:00:04.0: PCI bridge to [bus 01]
	[    3.396007] pci 0000:00:04.0:   bridge window [mem 0xca000000-0xcdffffff]
	[    3.396089] pci 0000:02:06.0: [1002:515e] type 00 class 0x030000
	[    3.396116] pci 0000:02:06.0: reg 0x10: [mem 0xd0000000-0xd7ffffff pref]
	[    3.396128] pci 0000:02:06.0: reg 0x14: [io  0x3000-0x30ff]
	[    3.396140] pci 0000:02:06.0: reg 0x18: [mem 0xce000000-0xce00ffff]
	[    3.396183] pci 0000:02:06.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
	[    3.396235] pci 0000:02:06.0: supports D1 D2
	[    3.396360] pci 0000:00:14.4: PCI bridge to [bus 02] (subtractive decode)
	[    3.404006] pci 0000:00:14.4:   bridge window [io  0x3000-0x3fff]
	[    3.404010] pci 0000:00:14.4:   bridge window [mem 0xce000000-0xce0fffff]
	[    3.404014] pci 0000:00:14.4:   bridge window [mem 0xd0000000-0xd7ffffff pref]
	[    3.404017] pci 0000:00:14.4:   bridge window [io  0x03b0-0x03df window] (subtractive decode)
	[    3.404019] pci 0000:00:14.4:   bridge window [io  0x0d00-0x3fff window] (subtractive decode)
	[    3.404021] pci 0000:00:14.4:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
	[    3.404023] pci 0000:00:14.4:   bridge window [mem 0xd0000000-0xd7ffffff window] (subtractive decode)
	[    3.404025] pci 0000:00:14.4:   bridge window [mem 0xc8000000-0xce0fffff window] (subtractive decode)
	[    3.404026] pci 0000:00:14.4:   bridge window [mem 0x000c0000-0x000cafff window] (subtractive decode)
	[    3.404028] pci 0000:00:14.4:   bridge window [mem 0xfed40000-0xfed45000 window] (subtractive decode)
	[    3.404030] pci 0000:00:14.4:   bridge window [io  0x0000-0x03af window] (subtractive decode)
	[    3.404032] pci 0000:00:14.4:   bridge window [io  0x03e0-0x0cf7 window] (subtractive decode)
...
	[    3.672074] e820: reserve RAM buffer [mem 0x0009d800-0x0009ffff]
	[    3.672077] e820: reserve RAM buffer [mem 0xc7e80000-0xc7ffffff]
...
	[    3.751327] system 00:00: [mem 0xe0000000-0xefffffff] has been reserved
	[    3.758121] system 00:00: [mem 0xfec00000-0xfec00fff] could not be reserved
	[    3.765226] system 00:00: [mem 0xfee00000-0xfee00fff] has been reserved
	[    3.771982] system 00:00: [mem 0xc8000000-0xc8007fff] could not be reserved
	[    3.779098] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
	[    3.780205] pnp 00:01: Plug and Play ACPI device, IDs PNP0b00 (active)
	[    3.780262] pnp 00:02: Plug and Play ACPI device, IDs PNP0303 (active)
	[    3.780310] pnp 00:03: Plug and Play ACPI device, IDs PNP0f13 (active)
	[    3.780426] system 00:04: [io  0x0220-0x022f] has been reserved
	[    3.790998] system 00:04: [io  0x040b] has been reserved
	[    3.796453] system 00:04: [io  0x04d0-0x04d1] has been reserved
	[    3.802514] system 00:04: [io  0x04d6] has been reserved
	[    3.807968] system 00:04: [io  0x0530-0x0537] has been reserved
	[    3.814030] system 00:04: [io  0x0c00-0x0c01] has been reserved
	[    3.820093] system 00:04: [io  0x0c14] has been reserved
	[    3.825548] system 00:04: [io  0x0c50-0x0c52] has been reserved
	[    3.831610] system 00:04: [io  0x0c6c] has been reserved
	[    3.837065] system 00:04: [io  0x0c6f] has been reserved
	[    3.842542] system 00:04: [io  0x0ca0-0x0caf] has been reserved
	[    3.848604] system 00:04: [io  0x0cd0-0x0cd1] has been reserved
	[    3.854667] system 00:04: [io  0x0cd2-0x0cd3] has been reserved
	[    3.860730] system 00:04: [io  0x0cd4-0x0cd5] has been reserved
	[    3.866793] system 00:04: [io  0x0cd6-0x0cd7] has been reserved
	[    3.872856] system 00:04: [io  0x0cd8-0x0cdf] has been reserved
	[    3.878918] system 00:04: [io  0x2000-0x205f] has been reserved
	[    3.884981] system 00:04: [io  0x2100-0x21ff window] has been reserved
	[    3.891650] system 00:04: [io  0x2200-0x22ff window] has been reserved
	[    3.898321] system 00:04: [io  0x0f40-0x0f47] has been reserved
	[    3.904383] system 00:04: [io  0x087f] has been reserved
	[    3.909844] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
	[    3.910055] system 00:05: [mem 0x000e0000-0x000fffff] could not be reserved
	[    3.917194] system 00:05: [mem 0xfff00000-0xffffffff] has been reserved
	[    3.923950] system 00:05: [mem 0xfec10000-0xfec1001f] has been reserved
	[    3.930710] system 00:05: Plug and Play ACPI device, IDs PNP0c01 (active)
	[    3.931208] pnp 00:06: Plug and Play ACPI device, IDs PNP0501 (active)
	[    3.931939] pnp: PnP ACPI: found 7 devices
	[    3.953364] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
	[    3.962499] pci 0000:01:00.0: BAR 6: no space for [mem size 0x00020000 pref]
	[    3.969693] pci 0000:01:00.0: BAR 6: failed to assign [mem size 0x00020000 pref]
	[    3.977318] pci 0000:01:00.1: BAR 6: no space for [mem size 0x00020000 pref]
	[    3.984507] pci 0000:01:00.1: BAR 6: failed to assign [mem size 0x00020000 pref]
	[    3.992134] pci 0000:00:04.0: PCI bridge to [bus 01]
	[    3.997243] pci 0000:00:04.0:   bridge window [mem 0xca000000-0xcdffffff]
	[    4.004181] pci 0000:02:06.0: BAR 6: assigned [mem 0xce020000-0xce03ffff pref]
	[    4.011634] pci 0000:00:14.4: PCI bridge to [bus 02]
	[    4.016743] pci 0000:00:14.4:   bridge window [io  0x3000-0x3fff]
	[    4.022982] pci 0000:00:14.4:   bridge window [mem 0xce000000-0xce0fffff]
	[    4.029915] pci 0000:00:14.4:   bridge window [mem 0xd0000000-0xd7ffffff pref]
	[    4.037375] pci_bus 0000:00: resource 4 [io  0x03b0-0x03df window]
	[    4.037377] pci_bus 0000:00: resource 5 [io  0x0d00-0x3fff window]
	[    4.037379] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
	[    4.037380] pci_bus 0000:00: resource 7 [mem 0xd0000000-0xd7ffffff window]
	[    4.037382] pci_bus 0000:00: resource 8 [mem 0xc8000000-0xce0fffff window]
	[    4.037384] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000cafff window]
	[    4.037386] pci_bus 0000:00: resource 10 [mem 0xfed40000-0xfed45000 window]
	[    4.037388] pci_bus 0000:00: resource 11 [io  0x0000-0x03af window]
	[    4.037390] pci_bus 0000:00: resource 12 [io  0x03e0-0x0cf7 window]
	[    4.037392] pci_bus 0000:01: resource 1 [mem 0xca000000-0xcdffffff]
	[    4.037394] pci_bus 0000:02: resource 0 [io  0x3000-0x3fff]
	[    4.037396] pci_bus 0000:02: resource 1 [mem 0xce000000-0xce0fffff]
	[    4.037398] pci_bus 0000:02: resource 2 [mem 0xd0000000-0xd7ffffff pref]
	[    4.037400] pci_bus 0000:02: resource 4 [io  0x03b0-0x03df window]
	[    4.037401] pci_bus 0000:02: resource 5 [io  0x0d00-0x3fff window]
	[    4.037403] pci_bus 0000:02: resource 6 [mem 0x000a0000-0x000bffff window]
	[    4.037405] pci_bus 0000:02: resource 7 [mem 0xd0000000-0xd7ffffff window]
	[    4.037406] pci_bus 0000:02: resource 8 [mem 0xc8000000-0xce0fffff window]
	[    4.037408] pci_bus 0000:02: resource 9 [mem 0x000c0000-0x000cafff window]
	[    4.037410] pci_bus 0000:02: resource 10 [mem 0xfed40000-0xfed45000 window]
	[    4.037412] pci_bus 0000:02: resource 11 [io  0x0000-0x03af window]
	[    4.037413] pci_bus 0000:02: resource 12 [io  0x03e0-0x0cf7 window]
...
	[    4.088124] pci 0000:02:06.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
	[    4.096709] PCI: CLS 32 bytes, default 64
	[    4.096791] Unpacking initramfs...
	[    7.106451] Freeing initrd memory: 22376K
	[    7.113357] PCI-DMA: Disabling AGP.
	[    7.117189] PCI-DMA: aperture base @ b8000000 size 65536 KB
	[    7.122931] PCI-DMA: using GART IOMMU.
	[    7.126826] PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
	[    7.137697] __memblock_free_late: [0x000000c7e78000-0x000000c7e7ffff] swiotlb_free+0xc0/0x188
	[    7.146503] __memblock_free_late: [0x00000837e66000-0x00000837ea5fff] swiotlb_free+0x106/0x188
	[    7.155355] __memblock_free_late: [0x00000837ea6000-0x00000837ec5fff] swiotlb_free+0x14c/0x188
	[    7.164201] __memblock_free_late: [0x000000bf000000-0x000000c2ffffff] swiotlb_free+0x171/0x188
...
	[    9.218654] resource sanity check: requesting [mem 0x000c0000-0x000dffff], which spans more than PCI Bus 0000:00 [mem 0x000c0000-0x000cafff window]
	[    9.218661] caller pci_map_rom+0x58/0xe0 mapping multiple BARs
	[    9.218773] radeon 0000:02:06.0: VRAM: 128M 0x00000000D0000000 - 0x00000000D7FFFFFF (32M used)
	[    9.218775] radeon 0000:02:06.0: GTT: 512M 0x00000000B0000000 - 0x00000000CFFFFFFF
	[    9.218784] [drm] Detected VRAM RAM=128M, BAR=128M
	[    9.218785] [drm] RAM width 16bits DDR
	[    9.218905] [TTM] Zone  kernel: Available graphics memory: 16381524 kiB
	[    9.218906] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
	[    9.218907] [TTM] Initializing pool allocator
	[    9.218914] [TTM] Initializing DMA pool allocator
	[    9.218948] [drm] radeon: 32M of VRAM memory ready
	[    9.218949] [drm] radeon: 512M of GTT memory ready.
	[    9.218962] [drm] GART: num cpu pages 131072, num gpu pages 131072
	[    9.253710] [drm] PCI GART of 512M enabled (table at 0x00000000C2880000).
	[    9.253734] radeon 0000:02:06.0: WB disabled
	[    9.253739] radeon 0000:02:06.0: fence driver on ring 0 use gpu addr 0x00000000b0000000 and cpu addr 0xffff91558280f000
	[    9.253742] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
	[    9.253742] [drm] Driver supports precise vblank timestamp query.
	[    9.253790] [drm] radeon: irq initialized.
	[    9.253802] [drm] Loading R100 Microcode
	[    9.253826] radeon 0000:02:06.0: Direct firmware load for radeon/R100_cp.bin failed with error -2
	[    9.253828] radeon_cp: Failed to load firmware "radeon/R100_cp.bin"
	[    9.253919] [drm:r100_cp_init [radeon]] *ERROR* Failed to load firmware!
	[    9.253921] radeon 0000:02:06.0: failed initializing CP (-2).
	[    9.253923] radeon 0000:02:06.0: Disabling GPU acceleration
...
	[    9.253929] [drm] radeon: cp finalized
	[    9.255032] [drm] No TV DAC info found in BIOS
	[    9.255079] [drm] Radeon Display Connectors
	[    9.255080] [drm] Connector 0:
	[    9.255081] [drm]   VGA-1
	[    9.255083] [drm]   DDC: 0x60 0x60 0x60 0x60 0x60 0x60 0x60 0x60
	[    9.255083] [drm]   Encoders:
	[    9.255084] [drm]     CRT1: INTERNAL_DAC1
	[    9.255086] [drm] Connector 1:
	[    9.255086] [drm]   DVI-I-1
	[    9.255087] [drm]   HPD2
	[    9.255089] [drm]   DDC: 0x6c 0x6c 0x6c 0x6c 0x6c 0x6c 0x6c 0x6c
	[    9.255089] [drm]   Encoders:
	[    9.255090] [drm]     CRT2: INTERNAL_DAC2
	[    9.255091] [drm]     DFP2: INTERNAL_DVO1
	[    9.398386] [drm] fb mappable at 0xD0040000
	[    9.398387] [drm] vram apper at 0xD0000000
	[    9.398388] [drm] size 1572864
	[    9.398388] [drm] fb depth is 16
	[    9.398389] [drm]    pitch is 2048

/proc/iomem:
	00000000-00000fff : Reserved
	00001000-0009d7ff : System RAM
	0009d800-0009ffff : Reserved
	000a0000-000bffff : PCI Bus 0000:00
	000c0000-000cafff : PCI Bus 0000:00
	  000c0000-000cafff : Video ROM
	000cb000-000ccfff : Adapter ROM
	000ce000-000fffff : Reserved
	  000f0000-000fffff : System ROM
	00100000-c7e7ffff : System RAM
	  0b000000-0b792eb5 : Kernel code
	  0b792eb6-0bd5d47f : Kernel data
	  0c274000-0c3c8fff : Kernel bss
	  b7000000-c6ffffff : Crash kernel
	c7e80000-c7e8afff : ACPI Tables
	c7e8b000-c7e8cfff : ACPI Non-volatile Storage
	c7e8d000-c7ffffff : Reserved
	c8000000-ce0fffff : PCI Bus 0000:00
	  c8000000-c80003ff : IOAPIC 1
	  c8014000-c80143ff : 0000:00:11.0
	    c8014000-c80143ff : ahci
	  c8014400-c80144ff : 0000:00:12.2
	    c8014400-c80144ff : ehci_hcd
	  c8014800-c80148ff : 0000:00:13.2
	    c8014800-c80148ff : ehci_hcd
	  c8015000-c8015fff : 0000:00:12.0
	    c8015000-c8015fff : ohci_hcd
	  c8016000-c8016fff : 0000:00:12.1
	    c8016000-c8016fff : ohci_hcd
	  c8017000-c8017fff : 0000:00:13.0
	    c8017000-c8017fff : ohci_hcd
	  c8018000-c8018fff : 0000:00:13.1
	    c8018000-c8018fff : ohci_hcd
	  c8019000-c8019fff : 0000:00:14.5
	    c8019000-c8019fff : ohci_hcd
	  ca000000-cdffffff : PCI Bus 0000:01
	    ca000000-cbffffff : 0000:01:00.0
	      ca000000-cbffffff : bnx2
	    cc000000-cdffffff : 0000:01:00.1
	      cc000000-cdffffff : bnx2
	  ce000000-ce0fffff : PCI Bus 0000:02
	    ce000000-ce00ffff : 0000:02:06.0
	d0000000-d7ffffff : PCI Bus 0000:00
	  d0000000-d7ffffff : PCI Bus 0000:02
	    d0000000-d7ffffff : 0000:02:06.0
	e0000000-efffffff : Reserved
	  e0000000-efffffff : pnp 00:00
	    e0000000-e02fffff : PCI MMCONFIG 0000 [bus 00-02]
	fec00000-fec0ffff : Reserved
	  fec00000-fec003ff : IOAPIC 0
	fec10000-fec1001f : pnp 00:05
	fed00000-fed003ff : HPET 2
	  fed00000-fed003ff : PNP0103:00
	fed40000-fed45000 : PCI Bus 0000:00
	fee00000-fee00fff : Local APIC
	  fee00000-fee00fff : Reserved
	    fee00000-fee00fff : pnp 00:00
	fff00000-ffffffff : Reserved
	  fff00000-ffffffff : pnp 00:05
	100000000-837ffffff : System RAM
	  831000000-8374fffff : Crash kernel

Without the patch, the machine hangs as soon as I touch one of the first 10
pages of /proc/vmcore that are mapped to the GART region. (On a different
mechine, this caused a strange MCE and reboot.)

With the patch, I was able to read the full /proc/vmcore.
I manually verified the ELF header of /proc/vmcore and the patch works as intended
(the section containing the GART region hsa been split in two to exclude GART).

> If this patch works, then I am wondering how we shold deal with the old
> way in which no '-s' is specified. Since no GART information is exported
> to /proc/iomem.
> 
> Do we have a way to pick GART region away from iomem_resource to not let
> the aperture seen from /proc/iomem?

I haven't given this any thought yet. I can look at it later...

Thanks,

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
