Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-ie0-x230.google.com ([2607:f8b0:4001:c03::230])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uma8C-0002Kq-5t
 for kexec@lists.infradead.org; Wed, 12 Jun 2013 01:45:50 +0000
Received: by mail-ie0-f176.google.com with SMTP id ar20so19231547iec.21
 for <kexec@lists.infradead.org>; Tue, 11 Jun 2013 18:45:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <E1UmXSQ-0008Nq-27@eag09.americas.sgi.com>
References: <E1UmXSQ-0008Nq-27@eag09.americas.sgi.com>
Date: Tue, 11 Jun 2013 18:45:25 -0700
Message-ID: <CAE9FiQWaAqGi5iGj+=ET4_D3OxuSjpHpMKAmOk--YHXMx_wJ-A@mail.gmail.com>
Subject: Re: kexec: purgatory hang
From: Yinghai Lu <yinghai@kernel.org>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Cliff Wickman <cpw@sgi.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>

On Tue, Jun 11, 2013 at 3:54 PM, Cliff Wickman <cpw@sgi.com> wrote:
>
> I'm getting a hang when trying to enter a high-memory crash kernel,
> and I'm at a loss as to how to debug this.
>
> This is a 3.10.0-rc3 kernel, and set up as the crash kernel by kexec 2.0.4.
> The machine is an SGI UV1000.

what is your mem size?

Just tried on one 3T system, it works well...

in first kernel:
sca05-0a81fd78:~ # cat /proc/iomem
00000000-00000fff : reserved
00001000-0009afff : System RAM
0009b000-0009ffff : reserved
000a0000-000bffff : PCI Bus 0000:00
000c0000-000c7fff : Video ROM
000c8000-000ce7ff : Adapter ROM
000ce800-000cf7ff : Adapter ROM
000cf800-000d07ff : Adapter ROM
000e0000-000fffff : reserved
  000f0000-000fffff : System ROM
00100000-68ad0fff : System RAM
  01000000-020b7d40 : Kernel code
  020b7d41-02bd47ff : Kernel data
  02f80000-03c20fff : Kernel bss
68ad1000-69265fff : reserved
69266000-69355fff : ACPI Tables
69356000-6a0e4fff : ACPI Non-volatile Storage
6a0e5000-6bd68fff : reserved
6bd69000-6bd98fff : System RAM
6bd99000-6bd99fff : reserved
6bd9a000-7bffffff : System RAM
  74000000-7bffffff : Crash kernel
...
100000000-3007fffffff : System RAM
  30040000000-3007fffffff : Crash kernel

boot command line:
console=uart8250,io,0x3f8,115200n8 initrd=kernel.org/x.xz rw
root=/dev/ram0 debug ignore_loglevel unknown_nmi_panic
crashkernel=1024M,high crashkernel=128M,low pci=routeirq ip=dhcp
load_ramdisk=1 BOOT_IMAGE=kernel.org/bzImage_3.10_k8.2

kexec second kernel:

# ./kexec -p $VMLINUZ --command-line="initcall_debug nr_cpus=1
pci=routeirq ignore
_loglevel unknown_nmi_panic apic=debug ramdisk_size=$RDSZ root=/dev/ram0 rw ip=d
hcp $CONSOLE" --ramdisk=$INITRD


add_buffer: base:3007ff65000 bufsz:9a000 memsz:9a000
add_buffer: base:3007ff60000 bufsz:3800 memsz:4000
add_buffer: base:3007ff55000 bufsz:80e0 memsz:a000
add_buffer: base:3007ff4f000 bufsz:437a memsz:437a
add_buffer: base:3007d000000 bufsz:8fd240 memsz:2c1f000
add_buffer: base:30079562000 bufsz:3a9ca12 memsz:3a9ca12

...
# echo c > /proc/sysrq-trigger
[  707.078371] SysRq : Trigger a crash
[  707.082358] BUG: unable to handle kernel NULL pointer dereference
at           (null)
[  707.091232] IP: [<ffffffff815e4b06>] sysrq_handle_crash+0x16/0x20
[  707.098170] PGD 0
[  707.100533] Oops: 0002 [#1] SMP
[  707.104262] Modules linked in:
[  707.107753] CPU: 11 PID: 20796 Comm: bash Tainted: G          I
3.10.0-rc5-yh-00891-g188560d-dirty #1736
[  707.128620] task: ffff89de66e1a5a0 ti: ffff89de68bec000 task.ti:
ffff89de68bec000
[  707.137014] RIP: 0010:[<ffffffff815e4b06>]  [<ffffffff815e4b06>]
sysrq_handle_crash+0x16/0x20
[  707.146651] RSP: 0018:ffff89de68bede48  EFLAGS: 00010096
[  707.152634] RAX: 000000000000000f RBX: ffffffff82af27e0 RCX: ffff885efd9cf130
[  707.160656] RDX: 0000000000000001 RSI: ffffffff8108edb0 RDI: 0000000000000063
[  707.168687] RBP: ffff89de68bede48 R08: 0000000000000001 R09: 0000000000000001
[  707.176716] R10: 0000000000000001 R11: 0000000000000002 R12: 0000000000000063
[  707.184745] R13: 0000000000000286 R14: 0000000000000000 R15: 0000000000000001
[  707.192774] FS:  00007f89bd578700(0000) GS:ffff885efd800000(0000)
knlGS:0000000000000000
[  707.201863] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  707.208342] CR2: 0000000000000000 CR3: 0000023e66deb000 CR4: 00000000001407e0
[  707.216364] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  707.224390] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
[  707.232418] Stack:
[  707.234722]  ffff89de68bede88 ffffffff815e52a2 ffff89de68bede88
0000000000000002
[  707.243252]  0000000000000002 00007f89bd57d000 ffff89de68bedf50
0000000000000000
[  707.251751]  ffff89de68bedeb8 ffffffff815e53d0 00007f89bd86e290
00007f89bd57d000
[  707.260235] Call Trace:
[  707.262996]  [<ffffffff815e52a2>] __handle_sysrq+0xc2/0x1b0
[  707.269278]  [<ffffffff815e53d0>] write_sysrq_trigger+0x40/0x50
[  707.275948]  [<ffffffff81220f42>] proc_reg_write+0x42/0x80
[  707.282133]  [<ffffffff811c03eb>] vfs_write+0xeb/0x1c0
[  707.287911]  [<ffffffff811c0865>] SyS_write+0x55/0xb0
[  707.293610]  [<ffffffff820b23da>] tracesys+0xd4/0xd9
[  707.299166] Code: f0 4c 8b 65 f8 c9 c3 66 2e 0f 1f 84 00 00 00 00
00 0f 1f 40 00 0f 1f 44 00 00 55 c7 05 cc ff a1 01 01 00 00 00 48 89
e5 0f ae f8 <c6> 04 25 00 00 00 00 01 5d c3 0f 1f 44 00 00 55 48 89 e5
53 48
[  707.321648] RIP  [<ffffffff815e4b06>] sysrq_handle_crash+0x16/0x20
[  707.328623]  RSP <ffff89de68bede48>
[  707.332573] CR2: 0000000000000000
early console in decompress_kernel
decompress_kernel:
  input: [0x3007ea682c2-0x3007f35d8f5], output: 0x3007d000000, heap:
[0x3007f365240-0x3007f36d23f]

Decompressing Linux... xz... Parsing ELF... done.
Booting the kernel.
[    0.000000] bootconsole [uart0] enabled
[    0.000000]    real_mode_data :      phys 000003007ff4f000
[    0.000000]    real_mode_data :      virt ffff8b007ff4f000
[    0.000000]       boot_params : init virt ffffffff82f509e0
[    0.000000]       boot_params :      phys 000003007ef509e0
[    0.000000]       boot_params :      virt ffff8b007ef509e0
[    0.000000] boot_command_line : init virt ffffffff82e24020
[    0.000000] boot_command_line :      phys 000003007ee24020
[    0.000000] boot_command_line :      virt ffff8b007ee24020
[    0.000000] Kernel Layout:
[    0.000000]   .text: [0x3007d000000-0x3007e0bfde0]
[    0.000000] .rodata: [0x3007e200000-0x3007e9c1fff]
[    0.000000]   .data: [0x3007ea00000-0x3007ebb9abf]
[    0.000000]   .init: [0x3007ebbb000-0x3007ef3bfff]
[    0.000000]    .bss: [0x3007ef4a000-0x3007fbf9fff]
[    0.000000]    .brk: [0x3007fbfa000-0x3007fc1efff]
[    0.000000] memblock_reserve: [0x0009ac00-0x000fffff] * BIOS reserved
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.9.0-yh-02267-g2413a4c-dirty
(yhlu@linux-siqj.site) (gcc version 4.7.2 20130108 [gcc-4_7-branch
revision 195012] (SUSE Linux) ) #1507 SMP Mon Apr 29 10:52:45 PDT 2013
[    0.000000] memblock_reserve: [0x3007d000000-0x3007fbf9fff] TEXT DATA BSS
[    0.000000] memblock_reserve: [0x30079562000-0x3007cffefff] RAMDISK
[    0.000000] Command line: initcall_debug nr_cpus=1 pci=routeirq
ignore_loglevel unknown_nmi_panic apic=debug ramdisk_size=262144
root=/dev/ram0 rw ip=dhcp console=uart8250,io,0x3f8,115200n8
memmap=exactmap memmap=616K@4K memmap=131072K@1900544K
memmap=1047936K@3222274048K elfcorehdr=3223321984K
memmap=960K#1722776K memmap=13884K#1723736K
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] Physical RAM map:
[    0.000000] raw: [mem 0x0000000000000100-0x000000000009afff] usable
[    0.000000] raw: [mem 0x000000000009b000-0x000000000009ffff] reserved
[    0.000000] raw: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] raw: [mem 0x0000000000100000-0x0000000068ad0fff] usable
[    0.000000] raw: [mem 0x0000000068ad1000-0x0000000069265fff] reserved
[    0.000000] raw: [mem 0x0000000069266000-0x0000000069355fff] ACPI data
[    0.000000] raw: [mem 0x0000000069356000-0x000000006a0e4fff] ACPI NVS
[    0.000000] raw: [mem 0x000000006a0e5000-0x000000006bd68fff] reserved
[    0.000000] raw: [mem 0x000000006bd69000-0x000000006bd98fff] usable
[    0.000000] raw: [mem 0x000000006bd99000-0x000000006bd99fff] reserved
[    0.000000] raw: [mem 0x000000006bd9a000-0x000000007bffffff] usable
[    0.000000] raw: [mem 0x0000000080000000-0x000000008fffffff] reserved
[    0.000000] raw: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] raw: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] raw: [mem 0x0000000100000000-0x000003007fffffff] usable
[    0.000000] e820: BIOS-provided physical RAM map (sanitized by setup):
[    0.000000] BIOS-e820: [mem 0x0000000000000100-0x000000000009afff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009b000-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000068ad0fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000068ad1000-0x0000000069265fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000069266000-0x0000000069355fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000069356000-0x000000006a0e4fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000006a0e5000-0x000000006bd68fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000006bd69000-0x000000006bd98fff] usable
[    0.000000] BIOS-e820: [mem 0x000000006bd99000-0x000000006bd99fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000006bd9a000-0x000000007bffffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000080000000-0x000000008fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000003007fffffff] usable
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] e820: last_pfn = 0x30080000 max_arch_pfn = 0x400000000
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] e820: user-defined physical RAM map:
[    0.000000] user: [mem 0x0000000000001000-0x000000000009afff] usable
[    0.000000] user: [mem 0x0000000069266000-0x000000006a0e4fff] ACPI data
[    0.000000] user: [mem 0x0000000074000000-0x000000007bffffff] usable
[    0.000000] user: [mem 0x0000030040000000-0x000003007ff5ffff] usable
...

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
