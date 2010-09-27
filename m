Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mailgw.miraclelinux.com ([122.212.45.247])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1P030t-0001pP-J1
	for kexec@lists.infradead.org; Mon, 27 Sep 2010 02:00:21 +0000
Message-ID: <4C9FFA9E.4080705@miraclelinux.com>
Date: Mon, 27 Sep 2010 10:59:58 +0900
From: Makito SHIOKAWA <mshiokawa@miraclelinux.com>
MIME-Version: 1.0
Subject: Can't kexec/kdump on mpc85xx
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
To: kexec@lists.infradead.org
Cc: Makito SHIOKAWA <mshiokawa@miraclelinux.com>

I'm trying to kexec/kdump on MPC8548 custom board, but second kernel doesn't
boot. (Custom board's main difference to MPC8548CDS is memory map (CCSR,
PCI-IO addresses), RAM size (1GB), FLASH size. So, I modified mpc8548cds.dts
to boot kernel.)

I followed "mpc85xx kexec howto" (kexec-tools/doc/mpc85xx.txt) instructions.

As boot/kexec/kdump kernel, I used linux-2.6.35 and set below kernel configs.

* "kexec system call (EXPERIMENTAL)" (CONFG_KEXEC)
* "Build a relocatable kernel (EXPERIMENTAL)" (CONFIG_RELOCATABLE)
(CONFIG_CRASH_DUMP, CONFIG_PROC_VMCORE weren't settable on MPC8548CDS.)

As kexec-tools, I used git commit "dbe1163152ef6fca2a1bd22e11e219f58fd40c08"
(I got error on kexec-tools-2.0.2), and cross compiled with -DDEBUG.

As boot parameter, I set "crashkernel=256M@512M". (I also tried other sizes
and @256M combinations.)

---
# cat /proc/cmdline
console=ttyS0,38400 ip=bootp root=/dev/nfs rw crashkernel=256M@512M
---


Then, when I "kexec -l", I got below debug message and seems no problem.

---
# kexec -l --command-line="console=ttyS0,38400 ip=bootp root=/dev/nfs rw
maxcpus=1 noirqdistrib reset_devices" /boot/vmlinux
0000000000000000-0000000040000000 : 0
get base memory ranges:1
sym:      .data info: 03 other: 00 shndx: 4 value: 0 size: 0
[..snip..]
Modified cmdline:console=ttyS0,38400 ip=bootp root=/dev/nfs rw maxcpus=1 noirqdi
strib reset_devices
reserve regions: 1
0: offset: 17fd000, size: 3000
debug.dtb written
---

But when I "kexec -e", second kernel doesn't boot and seems stalled.

---
# kexec -e
Starting new kernel
Bye!
---


Also, when I "kexec -p", I got below debug message and seems no problem.

---
# kexec -p --command-line="console=ttyS0,38400 ip=bootp root=/dev/nfs rw
maxcpus=1 noirqdistrib reset_devices" /boot/vmlinux
0000000000000000-0000000040000000 : 0
get base memory ranges:1
usable memory rgns size:1 base:0 size:30000000
exclude_range sorted exclude_range[0] start:0, end:41b000
setup_memory_ranges memory_range[0] start:41b001, end:30000000
CRASH MEMORY RANGES
0000000000000000-0000000000010000
0000000000010000-0000000020000000
0000000030000000-0000000040000000
Elf header: p_type = 4, p_offset = 0x1f880400 p_paddr = 0x1f880400 p_vaddr = 0x0
 p_filesz = 0x400 p_memsz = 0x400
vmcoreinfo header: p_type = 4, p_offset = 0x4044f4 p_paddr = 0x4044f4 p_vaddr =
0x0 p_filesz = 0x1000 p_memsz = 0x1000
Elf header: p_type = 1, p_offset = 0x2041b000 p_paddr = 0x0 p_vaddr = 0xc0000000
 p_filesz = 0x10000 p_memsz = 0x10000
Elf header: p_type = 1, p_offset = 0x10000 p_paddr = 0x10000 p_vaddr = 0xc001000
0 p_filesz = 0x1fff0000 p_memsz = 0x1fff0000
Elf header: p_type = 1, p_offset = 0x30000000 p_paddr = 0x30000000 p_vaddr = 0xf
fffffff p_filesz = 0x10000000 p_memsz = 0x10000000
Command line after adding elfcorehdr:  elfcorehdr=528556K
Command line after adding elfcorehdr:  elfcorehdr=528556K savemaxmem=1024M
sym:      .data info: 03 other: 00 shndx: 4 value: 0 size: 0
[..snip..]
Modified cmdline:console=ttyS0,38400 ip=bootp root=/dev/nfs rw maxcpus=1 noirqdi
strib reset_devices elfcorehdr=528556K savemaxmem=1024M
reserve regions: 2
0: offset: 217fd000, size: 3000
1: offset: 20000000, size: 432000
debug.dtb written
---

But when I "echo c > /proc/sysrq-trigger", second kernel doesn't boot and
seems stalled.

---
# echo c > /proc/sysrq-trigger
SysRq : Trigger a crash
Unable to handle kernel paging request for data at address 0x00000000
Faulting instruction address: 0xc01b7894
Oops: Kernel access of bad area, sig: 11 [#1]
MPC85xx CDS
last sysfs file: /sys/devices/system/cpu/cpu0/crash_notes
NIP: c01b7894 LR: c01b7b5c CTR: c01b7880
REGS: dfb13df0 TRAP: 0300   Not tainted  (2.6.35)
MSR: 00021000 <ME,CE>  CR: 22002442  XER: 20000000
DEAR: 00000000, ESR: 00800000
TASK = df9a7780[890] 'bash' THREAD: dfb12000
GPR00: 00000001 dfb13ea0 df9a7780 00000063 00000000 ffffffff c01bebf0 00000000
GPR08: 00002d02 00000000 00000010 00000000 22002422 1009cc80 10080000 10095a10
GPR16: 10090000 10090000 bfb3bea0 00000000 100956b0 10090000 100956c0 bfb3be90
GPR24: 00000000 00000007 c03e3488 00029000 c03e3584 c03e0000 00000000 00000063
NIP [c01b7894] sysrq_handle_crash+0x14/0x20
LR [c01b7b5c] __handle_sysrq+0xbc/0x1c0
Call Trace:
[dfb13ea0] [c01b7b44] __handle_sysrq+0xa4/0x1c0 (unreliable)
[dfb13ed0] [c01b7cbc] write_sysrq_trigger+0x5c/0x70
[dfb13ee0] [c00f1b9c] proc_reg_write+0x4c/0x70
[dfb13ef0] [c00a9380] vfs_write+0xc0/0x1a0
[dfb13f10] [c00a955c] sys_write+0x4c/0x90
[dfb13f40] [c00103b4] ret_from_syscall+0x0/0x3c
--- Exception: c01 at 0xfe1d758
    LR = 0xfdb93ec
Instruction dump:
7d6b0078 7d60492d 40a2fff4 807e0018 7c7b1b78 4bfffefc 00000000 3d20c040
38000001 9009b12c 7c0004ac 39200000 <98090000> 4e800020 60000000 3803ffd0
Bye!
---


Is there any operation mistakes, or is something not ready on current
kernel/kexec-tools?
Not just kexec, I need to make kdump work on the custom board, but currently
CONFIG_CRASH_DUMP, CONFIG_PROC_VMCORE aren't settable on MPC8548. Is there any
plan to make these options settable, or what kind of work I need to do if I
implement by myself?

I would appreciate any help to this.
Thanks,

--
Makito SHIOKAWA <mshiokawa@miraclelinux.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
