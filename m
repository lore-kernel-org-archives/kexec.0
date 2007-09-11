Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IVAEY-0003dx-Bo
	for kexec@lists.infradead.org; Tue, 11 Sep 2007 19:13:14 +0100
Message-ID: <46E6DA70.8010408@redhat.com>
Date: Tue, 11 Sep 2007 14:12:00 -0400
From: Dave Anderson <anderson@redhat.com>
MIME-Version: 1.0
Subject: Re: [Crash-utility] Re: [PATCH 0/2] vmcoreinfo support for dump
	filtering #2
References: <20070907175746oomichi@mail.jp.nec.com>	<20070910113521.755d0433.rdunlap@xenotime.net>	<20070911035250.GA5053@in.ibm.com>	<46E6A03F.4010208@redhat.com>
	<20070911092523.ddff998c.rdunlap@xenotime.net>
In-Reply-To: <20070911092523.ddff998c.rdunlap@xenotime.net>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: vgoyal@in.ibm.com, kexec-ml <kexec@lists.infradead.org>, "Discussion list for crash utility usage,
	maintenance and development" <crash-utility@redhat.com>

Randy Dunlap wrote:
>
> I have the vmcoreinfo patch applied.
> Kernel is 2.6.23-rc3.
> 
> The crash debug output is below.  Please let me know if you'd like
> me to test without the vmcoreinfo patch or anything else.
> 
> ---
> 
> crash 4.0-4.6
> Copyright (C) 2002, 2003, 2004, 2005, 2006, 2007  Red Hat, Inc.
> Copyright (C) 2004, 2005, 2006  IBM Corporation
> Copyright (C) 1999-2006  Hewlett-Packard Co
> Copyright (C) 2005, 2006  Fujitsu Limited
> Copyright (C) 2006, 2007  VA Linux Systems Japan K.K.
> Copyright (C) 2005  NEC Corporation
> Copyright (C) 1999, 2002, 2007  Silicon Graphics, Inc.
> Copyright (C) 1999, 2000, 2001, 2002  Mission Critical Linux, Inc.
> This program is free software, covered by the GNU General Public License,
> and you are welcome to change it and/or distribute copies of it under
> certain conditions.  Enter "help copying" to see the conditions.
> This program has absolutely no warranty.  Enter "help warranty" for details.
>  
> vmcore_data: 
>                   flags: c0 (KDUMP_LOCAL|KDUMP_ELF64)
>                    ndfd: 3
>                     ofp: 322af48760
>             header_size: 1580
>    num_pt_load_segments: 4
>      pt_load_segment[0]:
>             file_offset: 62c
>              phys_start: 200000
>                phys_end: bda000
>               zero_fill: 0
>      pt_load_segment[1]:
>             file_offset: 9da62c
>              phys_start: 0
>                phys_end: a0000
>               zero_fill: 0
>      pt_load_segment[2]:
>             file_offset: a7a62c
>              phys_start: 100000
>                phys_end: 1000000
>               zero_fill: 0
>      pt_load_segment[3]:
>             file_offset: 197a62c
>              phys_start: 5000000
>                phys_end: 3ffc0000
>               zero_fill: 0
>              elf_header: 21b2c70
>                   elf32: 0
>                 notes32: 0
>                  load32: 0
>                   elf64: 21b2c70
>                 notes64: 21b2cb0
>                  load64: 21b2ce8
>             nt_prstatus: 21b2dc8
>             nt_prpsinfo: 0
>           nt_taskstruct: 0
>             task_struct: 0
>               page_size: 0
>            switch_stack: 0
>          xen_kdump_data: (unused)
>        num_prstatus_notes: 1
>        nt_prstatus_percpu: 00000000021b2dc8
> 
> 
> Elf64_Ehdr:
>                 e_ident: \177ELF
>       e_ident[EI_CLASS]: 2 (ELFCLASS64)
>        e_ident[EI_DATA]: 1 (ELFDATA2LSB)
>     e_ident[EI_VERSION]: 1 (EV_CURRENT)
>       e_ident[EI_OSABI]: 0 (ELFOSABI_SYSV)
>  e_ident[EI_ABIVERSION]: 0
>                  e_type: 4 (ET_CORE)
>               e_machine: 62 (EM_X86_64)
>               e_version: 1 (EV_CURRENT)
>                 e_entry: 0
>                 e_phoff: 40
>                 e_shoff: 0
>                 e_flags: 0
>                e_ehsize: 40
>             e_phentsize: 38
>                 e_phnum: 5
>             e_shentsize: 0
>                 e_shnum: 0
>              e_shstrndx: 0
> Elf64_Phdr:
>                  p_type: 4 (PT_NOTE)
>                p_offset: 344 (158)
>                 p_vaddr: 0
>                 p_paddr: 0
>                p_filesz: 1236 (4d4)
>                 p_memsz: 1236 (4d4)
>                 p_flags: 0 ()
>                 p_align: 0
> Elf64_Phdr:
>                  p_type: 1 (PT_LOAD)
>                p_offset: 1580 (62c)
>                 p_vaddr: ffffffff80200000
>                 p_paddr: 200000
>                p_filesz: 10330112 (9da000)
>                 p_memsz: 10330112 (9da000)
>                 p_flags: 7 (PF_X|PF_W|PF_R)
>                 p_align: 0
> Elf64_Phdr:
>                  p_type: 1 (PT_LOAD)
>                p_offset: 10331692 (9da62c)
>                 p_vaddr: ffff810000000000
>                 p_paddr: 0
>                p_filesz: 655360 (a0000)
>                 p_memsz: 655360 (a0000)
>                 p_flags: 7 (PF_X|PF_W|PF_R)
>                 p_align: 0
> Elf64_Phdr:
>                  p_type: 1 (PT_LOAD)
>                p_offset: 10987052 (a7a62c)
>                 p_vaddr: ffff810000100000
>                 p_paddr: 100000
>                p_filesz: 15728640 (f00000)
>                 p_memsz: 15728640 (f00000)
>                 p_flags: 7 (PF_X|PF_W|PF_R)
>                 p_align: 0
> Elf64_Phdr:
>                  p_type: 1 (PT_LOAD)
>                p_offset: 26715692 (197a62c)
>                 p_vaddr: ffff810005000000
>                 p_paddr: 5000000
>                p_filesz: 989593600 (3afc0000)
>                 p_memsz: 989593600 (3afc0000)
>                 p_flags: 7 (PF_X|PF_W|PF_R)
>                 p_align: 0
> Elf64_Nhdr:
>                n_namesz: 5 ("CORE")
>                n_descsz: 336
>                  n_type: 1 (NT_PRSTATUS)
>                          0000000000000000 0000000000000000 
>                          0000000000000000 0000000000000000 
>                          0000000000002b1a 0000000000000000 
>                          0000000000000000 0000000000000000 
>                          0000000000000000 0000000000000000 
>                          0000000000000000 0000000000000000 
>                          0000000000000000 0000000000000000 
>                          0000000000000006 0000000000000000 
>                          0000000000000063 0000000000000000 
>                          ffff810019769e48 ffffffff806aeda0 
>                          ffff81003d64eac0 ffffffff8023b1df 
>                          ffffffff8023b1df ffff810019769ca8 
>                          0000000000000000 0000000000000000 
>                          ffff8100848a9000 0000000000000000 
>                          0000000000000000 0000000000000292 
>                          ffffffff80260532 0000000000000010 
>                          0000000000000046 ffff810019769d98 
>                          0000000000000018 00002b7fb481df10 
>                          0000000000000000 0000000000000000 
>                          0000000000000000 0000000000000000 
>                          0000000000000000 0000000000000000 
> Elf64_Nhdr:
>                n_namesz: 11 ("VMCOREINFO")
>                n_descsz: 856
>                  n_type: 0 (?)
>                          41454c4552534f00 322e362e323d4553 
>                          41500a3363722d33 343d455a49534547 
>                          424d59530a363930 5f74696e69284c4f 
>                          3d29736e5f737475 6666666666666666 
>                          3036373538363038 284c4f424d59530a 
>                          6c6e6f5f65646f6e 2970616d5f656e69 
>                          666666666666663d 3432633037303866 
>                          4c4f424d59530a30 7265707061777328 
>                          297269645f67705f 666666666666663d 
>                          3030313032303866 4c4f424d59530a30 
>                          2974786574735f28 666666666666663d 
>                          3030393032303866 7028455a49530a30 
>                          0a36393d29656761 6c677028455a4953 
>                          617461645f747369 0a30323734313d29 
>                          6e6f7a28455a4953 0a343230313d2965 
>                          65726628455a4953 3d29616572615f65 
>                          28455a49530a3432 6165685f7473696c 
>                          464f0a36313d2964 6761702854455346 
>                          297367616c662e65 455346464f0a303d 
>                          5f2e656761702854 383d29746e756f63 
>                          2854455346464f0a 70616d2e65676170 
>                          34323d29676e6970 2854455346464f0a 
>                          75726c2e65676170 46464f0a30383d29 
>                          696c677028544553 2e617461645f7473 
>                          6e6f7a5f65646f6e 464f0a303d297365 
>                          6c67702854455346 617461645f747369 
>                          656e6f7a5f726e2e 30363534313d2973 
>                          2854455346464f0a 645f7473696c6770 
>                          65646f6e2e617461 70616d5f6d656d5f 
>                          0a38363534313d29 702854455346464f 
>                          61645f7473696c67 5f65646f6e2e6174 
>                          66705f7472617473 34383534313d296e 
>                          2854455346464f0a 645f7473696c6770 
>                          65646f6e2e617461 64656e6e6170735f 
>                          3d2973656761705f 464f0a3030363431 
>                          6c67702854455346 617461645f747369 
>                          64695f65646f6e2e 0a38303634313d29 
>                          7a2854455346464f 656572662e656e6f 
>                          323d29616572615f 455346464f0a3030 
>                          762e656e6f7a2854 3d29746174735f6d 
>                          5346464f0a323336 2e656e6f7a285445 
>                          5f64656e6e617073 393d297365676170 
>                          455346464f0a3633 615f656572662854 
>                          656572662e616572 303d297473696c5f 
>                          2854455346464f0a 6165685f7473696c 
>                          3d297478656e2e64 54455346464f0a30 
>                          65685f7473696c28 29766572702e6461 
>                          54474e454c0a383d 662e656e6f7a2848 
>                          616572615f656572 4d59530a31313d29 
>                          65646f6e284c4f42 663d29617461645f 
>                          3866666666666666 0a30346561303730 
>                          6e284854474e454c 617461645f65646f 
>                          4152430a34363d29 313d454d49544853 
>                          3938333339383831 
> p_vaddr: ffffffff80200000 p_paddr: 200000 -> phys_base: 0
> 
> gdb /boot/vmlinux-2.6.23-rc3 
> GNU gdb 6.1
> Copyright 2004 Free Software Foundation, Inc.
> GDB is free software, covered by the GNU General Public License, and you are
> welcome to change it and/or distribute copies of it under certain conditions.
> Type "show copying" to see the conditions.
> There is absolutely no warranty for GDB.  Type "show warranty" for details.
> This GDB was configured as "x86_64-unknown-linux-gnu"...
> 
> <readmem: ffffffff8053bc40, KVADDR, "kernel_config_data", 32768, (ROE), 3723960>
> crash: CONFIG_NR_CPUS: 8
> crash: CONFIG_HZ: 250
> WARNING: Because this kernel was compiled with gcc version 4.1.1, certain
>          commands or command options may fail unless crash is invoked with
>          the  "--readnow" command line option.
> 
> GNU_GET_DATATYPE[runqueue]: returned via gdb_error_hook (1 buffer in use)
> GNU_GET_DATATYPE[runqueue]: returned via gdb_error_hook (1 buffer in use)
> GNU_GET_DATATYPE[prio_array]: returned via gdb_error_hook (1 buffer in use)
> GNU_GET_DATATYPE[prio_array]: returned via gdb_error_hook (1 buffer in use)
> GNU_GET_DATATYPE[prio_array]: returned via gdb_error_hook (1 buffer in use)
> GNU_GET_DATATYPE[irq_desc_t]: returned via gdb_error_hook (1 buffer in use)
> GNU_GET_DATATYPE[hw_interrupt_type]: returned via gdb_error_hook (1 buffer in use)
> GNU_GET_DATATYPE[irq_cpustat_t]: returned via gdb_error_hook (1 buffer in use)
> GNU_GET_DATATYPE[irq_cpustat_t]: returned via gdb_error_hook (1 buffer in use)
> GNU_GET_DATATYPE[irq_cpustat_t]: returned via gdb_error_hook (1 buffer in use)
> GNU_GET_DATATYPE[timer_vec_root]: returned via gdb_error_hook (1 buffer in use)
> GNU_GET_DATATYPE[timer_vec]: returned via gdb_error_hook (1 buffer in use)
> GNU_GET_DATATYPE[softirq_state]: returned via gdb_error_hook (1 buffer in use)
> GNU_GET_DATATYPE[kallsyms_header]: returned via gdb_error_hook (1 buffer in use)
> GNU_GET_DATATYPE[user_regs_struct]: returned via gdb_error_hook (1 buffer in use)
> GNU_GET_DATATYPE[user_regs_struct]: returned via gdb_error_hook (1 buffer in use)
> GNU_GET_DATATYPE[user_regs_struct]: returned via gdb_error_hook (1 buffer in use)
> GNU_GET_DATATYPE[user_regs_struct]: returned via gdb_error_hook (1 buffer in use)
> GNU_GET_DATATYPE[user_regs_struct]: returned via gdb_error_hook (1 buffer in use)
> GNU_GET_DATATYPE[user_regs_struct]: returned via gdb_error_hook (1 buffer in use)
> <readmem: ffffffff80837580, KVADDR, "xtime", 16, (FOE), a09c90>
> <readmem: ffffffff80685764, KVADDR, "init_uts_ns", 390, (ROE), a0a27c>
> <readmem: ffffffff80537000, KVADDR, "accessible check", 8, (ROE|Q), 7fff10bb8dc8>
> <readmem: ffffffff80537000, KVADDR, "readstring characters", 1499, (ROE|Q), 7fff10bb7db0>
> verify_namelist:
> /proc/version:
> Linux version 2.6.23-rc3 (rddunlap@unicorn.site) (gcc version 4.1.1 20070105 (Red Hat 4.1.1-52)) #19 SMP Tue Sep 4 09:52:06 PDT 2007
> utsname version: #19 SMP Tue Sep 4 09:52:06 PDT 2007
> /boot/vmlinux-2.6.23-rc3:
> Linux version 2.6.23-rc3 (rddunlap@unicorn.site) (gcc version 4.1.1 20070105 (Red Hat 4.1.1-52)) #22 SMP Thu Sep 6 21:24:54 PDT 2007
> 
> <readmem: ffffffff80707940, KVADDR, "_cpu_pda addr", 8, (FOE), 7fff10bba538>
> <readmem: 0, KVADDR, "cpu_pda entry", 128, (FOE), a3a820>
> crash: invalid kernel virtual address: 0  type: "cpu_pda entry"

A few things come to mind.  Walking through the debug data above...

The very first readmem() from the dumpfile is from the kernel symbol 
"kernel_config_data", where you can see that it found the CONFIG_HZ and
CONFIG_NR_CPUS values.  The next readmem()'s are of "xtime" and then 
"init_uts_ns".  We don't know what was read from the "xtime" location,
but the utsname data from "init_uts_ns" gets displayed later on here:

 > utsname version: #19 SMP Tue Sep 4 09:52:06 PDT 2007

And then the "linux_banner" address of ffffffff80537000 is first
checked for accessibility (OK), and then it is read successfully,
and its contents are displayed here:

 > /proc/version:
 > Linux version 2.6.23-rc3 (rddunlap@unicorn.site) (gcc version 4.1.1 20070105 
(Red Hat 4.1.1-52)) #19 SMP Tue Sep 4 09:52:06 PDT 2007

The string above from the dumpfile is correlated against the
linux_banner string in the vmlinux file, which is subsequently
displayed here:

 > /boot/vmlinux-2.6.23-rc3:
 > Linux version 2.6.23-rc3 (rddunlap@unicorn.site) (gcc version 4.1.1 20070105 
(Red Hat 4.1.1-52)) #22 SMP Thu Sep 6 21:24:54 PDT 2007

The utsname data and the linux_banner string from the dumpfile
are from "Tue Sep 4 09:52:06 PDT 2007", whereas the vmlinux file
was built 2 days later at "Thu Sep 6 21:24:54 PDT 2007".  I don't
know whether that's the issue or not.  Is there a reason that
you are *not* using the same vmlinux that the dumpfile was created
from?

So the first thing to verify is that you use the same vmlinux
that was booted and dumped.  If you cannot dig up the original
vmlinux file, get the System.map file from the dumped kernel,
and throw that on the command line, and see if that helps:

  $ crash vmlinux vmcore System.map

Anyway, next it reads the _cpu_pda[0] at address ffffffff80707940 to
find the address of cpu 0's x8664_pda structure:

 > <readmem: ffffffff80707940, KVADDR, "_cpu_pda addr", 8, (FOE), 7fff10bba538>

But it finds a zero there:

 > <readmem: 0, KVADDR, "cpu_pda entry", 128, (FOE), a3a820>
 > crash: invalid kernel virtual address: 0  type: "cpu_pda entry"

At this point crash is done, the readmem() is "FOE" (fault-on-error),
because there's no sense in continuing.

If the vmlinux and dumpfile are different, it's possible that the
_cpu_pda[] array, which is the highest address read so far, (the
xtime data which is even higher may be garbage as well), may
have been "pushed up" by some other changes in the kernel?

Or, if they do "line up", something may have changed with respect
to the kernel's _cpu_pda[] handling or its data declaration

Or, it actually read zeroes from the dumpfile.

But, for now let's suppose that the two kernels are identical except
for the date in the linux_banner strings.  I don't have a 2.6.23
kernel source tree handy, but at least as of 2.6.22-5, it was still
declared statically like so:

   struct x8664_pda *_cpu_pda[NR_CPUS] __read_mostly;

Has that changed?

If not, it would be worth checking a dumpfile with no pages
excluded with makedumpfile.  I wouldn't think the in-kernel
part of the vmcoreinfo patches would make a difference, but
I suppose anything's possible.

You also mentioned that gdb worked OK.  What happens when
you enter this:

   (gdb) p _cpu_pda[0]

And if you enter:

   (gdb) p &_cpu_pda[0]

does it show 0xffffffff80707940?  Which is what crash thinks is
the correct address:

 > <readmem: ffffffff80707940, KVADDR, "_cpu_pda addr", 8, (FOE), 7fff10bba538>

But again -- the very first thing to do is make sure that you
are using the exact same vmlinux as was booted/dumped.

Dave






_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
