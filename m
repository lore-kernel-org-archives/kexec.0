Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1U0a9I-00015c-ST
 for kexec@lists.infradead.org; Wed, 30 Jan 2013 16:04:34 +0000
From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 0/3] Make use of new memmap= kernel parameter syntax
Date: Wed, 30 Jan 2013 17:03:42 +0100
References: <1358866935-18458-1-git-send-email-trenn@suse.de>
 <20130130043100.GO28230@verge.net.au>
 <bfc13f3d-3ee2-4b7c-8d25-04718536a05a@email.android.com>
In-Reply-To: <bfc13f3d-3ee2-4b7c-8d25-04718536a05a@email.android.com>
MIME-Version: 1.0
Message-Id: <201301301703.42601.trenn@suse.de>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: yinghai@kernel.org, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, x86@kernel.org, vgoyal@redhat.com

On Wednesday, January 30, 2013 06:40:46 AM H. Peter Anvin wrote:
> The right thing to do as I have discussed with the people involved is to
> modify the memory map data structure to have a new memory type ID for
> memory which is to be dumped.  That eliminates the need to put all this
> info into the command line.
As said before..., after looking closely into this I am convinced that
passing a kexec-tools modified e820 table makes things unnecessary complex.

So I suggest to still pass the original e820 table and kexec-tools
only needs to pass the memory to use (usable) where the kdump kernel
resides in via memmap=X@Y.
This:
  - heavily cleans up the unnecesary reserved memory passing via memmap=
  - still provides a clean way of passing a valid e820 table through boot
    structures (no Linux kernel made up e820 type passing)
  - fixes mmconf and possible other bugs
  - provides the kdump kernel with all availabe info, it then knows about:
    original e820 map (all reserved, usable, etc. as specified by BIOS)
    kdump kernel memory area, former (crashed kernel) usable memory.
  - Keeps complexity as low as possible and at one place and does not
    involve kexec-tools as another error source (passing a badly
    mangled e820 table or not being able to consider stuff the kernel
    can when mangeling).

Having that said I will reply to this mail with two kernel patches
which implement this.
The 3 kexec-tools patches would be more or less the same, only the
string memmap=resetusable has to be exchanged to
memmap=kdump_reserve_usable
I wait until the kernel patches are in x86-tip and queued for
3.9 and will resend them then.

Please consider to apply the two kernel patches already.
But I can also resend in a new thread.

   Thomas

Ah yes, here the test results:
Kdump specific boot parameter appends before:
---------------------------------------------
memmap=exactmap memmap=559K@64K memmap=261560K@638976K elfcorehdr=900536K memmap=488K#3034988K memmap=3076K#3067744K memmap=2048K#3106804K memmap=676K#3110812K 
memmap=4K#3111488K memmap=476K#3111492K memmap=4K#3111968K memmap=8K#3111972K memmap=4K#3111980K memmap=4K#3111984K memmap=92K#3111988K memmap=564K#3112080K

Kdump specific boot parameter appends now:
------------------------------------------
memmap=kdump_reserve_usable,559K@64K,261560K@638976K elfcorehdr=900536K


important parts of the serial console output of the
---------------------------------------------------
modified kdump kernel:
----------------------
[691036.954392] RIP  [<ffffffff812f368d>] sysrq_handle_crash+0xd/0x20
[691036.968140]  RSP <ffff88042473de90>
[691036.976113] CR2: 0000000000000000
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.8.0-rc5-default+ (trenn@ett) (gcc version 4.5.1 20101208 [gcc-4_5-branch revision 167585] (SUSE Linux) ) #4 SMP Wed Jan 30 15:45:36 
CET 2013
[    0.000000] Command line: root=/dev/disk/by-id/ata-Hitachi_HDS721016CLA382_JPAB40HM2KUK6B-part6 console=tty0 console=ttyS0,57600 sysrq_always_enabled panic=100 
ignore_loglevel resume=/dev/disk/by-id/ata-Hitachi_HDS721016CLA382_JPAB40HM2KUK6B-part2 apic=verbose debug vga=normal elevator=deadline sysrq=yes reset_devices 
irqpoll maxcpus=1   memmap=kdump_reserve_usable,559K@64K,261560K@638976K elfcorehdr=900536K
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000100-0x000000000009bbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009bc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000b93dafff] usable
[    0.000000] BIOS-e820: [mem 0x00000000b93db000-0x00000000b9454fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000b9455000-0x00000000bb155fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bb156000-0x00000000bb166fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000bb167000-0x00000000bb3d7fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bb3d8000-0x00000000bb6d8fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bb6d9000-0x00000000bd9fcfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bd9fd000-0x00000000bdbfcfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bdbfd000-0x00000000bdcdcfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bdcdd000-0x00000000bdde6fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000bdde7000-0x00000000bde8ffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bde90000-0x00000000bde90fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000bde91000-0x00000000bdf07fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bdf08000-0x00000000bdf08fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000bdf09000-0x00000000bdf0afff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bdf0b000-0x00000000bdf0bfff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000bdf0c000-0x00000000bdf0cfff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bdf0d000-0x00000000bdf23fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000bdf24000-0x00000000bdfb0fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bdfb1000-0x00000000bdffffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000be000000-0x00000000cfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed19000-0x00000000fed19fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffa20000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000083fffffff] usable
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] e820: last_pfn = 0x840000 max_arch_pfn = 0x400000000
[    0.000000] e820: update [mem 0x00000000-0xfffffffffffffffe] usable ==> kdump reserved
[    0.000000] e820: remove [mem 0x00010000-0x0009bbff] 
[    0.000000] e820: remove [mem 0x27000000-0x36f6dfff] 
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] e820: user-defined physical RAM map:
[    0.000000] user: [mem 0x0000000000000100-0x000000000000ffff] kdump reserved
[    0.000000] user: [mem 0x0000000000010000-0x000000000009bbff] usable
[    0.000000] user: [mem 0x000000000009bc00-0x000000000009ffff] reserved
[    0.000000] user: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] user: [mem 0x0000000000100000-0x0000000026ffffff] kdump reserved
[    0.000000] user: [mem 0x0000000027000000-0x0000000036f6dfff] usable
[    0.000000] user: [mem 0x0000000036f6e000-0x00000000b93dafff] kdump reserved
[    0.000000] user: [mem 0x00000000b93db000-0x00000000b9454fff] ACPI data
[    0.000000] user: [mem 0x00000000b9455000-0x00000000bb155fff] kdump reserved
[    0.000000] user: [mem 0x00000000bb156000-0x00000000bb166fff] reserved
[    0.000000] user: [mem 0x00000000bb167000-0x00000000bb3d7fff] kdump reserved
[    0.000000] user: [mem 0x00000000bb3d8000-0x00000000bb6d8fff] ACPI NVS
[    0.000000] user: [mem 0x00000000bb6d9000-0x00000000bd9fcfff] kdump reserved
[    0.000000] user: [mem 0x00000000bd9fd000-0x00000000bdbfcfff] ACPI NVS
[    0.000000] user: [mem 0x00000000bdbfd000-0x00000000bdcdcfff] kdump reserved
[    0.000000] user: [mem 0x00000000bdcdd000-0x00000000bdde6fff] reserved
[    0.000000] user: [mem 0x00000000bdde7000-0x00000000bde8ffff] ACPI NVS
[    0.000000] user: [mem 0x00000000bde90000-0x00000000bde90fff] ACPI data
[    0.000000] user: [mem 0x00000000bde91000-0x00000000bdf07fff] ACPI NVS
[    0.000000] user: [mem 0x00000000bdf08000-0x00000000bdf08fff] ACPI data
[    0.000000] user: [mem 0x00000000bdf09000-0x00000000bdf0afff] ACPI NVS
[    0.000000] user: [mem 0x00000000bdf0b000-0x00000000bdf0bfff] ACPI data
[    0.000000] user: [mem 0x00000000bdf0c000-0x00000000bdf0cfff] ACPI NVS
[    0.000000] user: [mem 0x00000000bdf0d000-0x00000000bdf23fff] ACPI data
[    0.000000] user: [mem 0x00000000bdf24000-0x00000000bdfb0fff] ACPI NVS
[    0.000000] user: [mem 0x00000000bdfb1000-0x00000000bdffffff] kdump reserved
[    0.000000] user: [mem 0x00000000be000000-0x00000000cfffffff] reserved
[    0.000000] user: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] user: [mem 0x00000000fed19000-0x00000000fed19fff] reserved
[    0.000000] user: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] user: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] user: [mem 0x00000000ffa20000-0x00000000ffffffff] reserved
[    0.000000] user: [mem 0x0000000100000000-0x000000083fffffff] kdump reserved
[    0.000000] SMBIOS 2.6 present.
[    0.000000] DMI: Intel Corporation S2600CP/S2600CP, BIOS SE5C600.86B.99.99.x040.111920110024 11/19/2011
[    0.000000] e820: update [mem 0x00000000-0x0000ffff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] No AGP bridge found
...
[    2.220298] ACPI: bus type pci registered
[    2.229486] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0xc0000000-0xcfffffff] (base 0xc0000000)
[    2.250283] PCI: MMCONFIG at [mem 0xc0000000-0xcfffffff] reserved in E820
[    2.349583] PCI: Using configuration type 1 for base access
...
Copying data                       : [100 %]
The dumpfile is saved to /root/abuild/dumps/2013-01-30-15:52/vmcore.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
