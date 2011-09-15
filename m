Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R48bc-0008Gh-Jc
	for kexec@lists.infradead.org; Thu, 15 Sep 2011 09:51:43 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 284F33EE0AE
	for <kexec@lists.infradead.org>; Thu, 15 Sep 2011 18:51:32 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
	by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 1225845DEB3
	for <kexec@lists.infradead.org>; Thu, 15 Sep 2011 18:51:32 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
	by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id F07D945DE7E
	for <kexec@lists.infradead.org>; Thu, 15 Sep 2011 18:51:31 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id E0FFD1DB8037
	for <kexec@lists.infradead.org>; Thu, 15 Sep 2011 18:51:31 +0900 (JST)
Received: from m105.s.css.fujitsu.com (m105.s.css.fujitsu.com [10.240.81.145])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 96DA01DB8038
	for <kexec@lists.infradead.org>; Thu, 15 Sep 2011 18:51:31 +0900 (JST)
Received: from m105.css.fujitsu.com (m105 [127.0.0.1])
	by m105.s.css.fujitsu.com (Postfix) with ESMTP id 4A9D09C8007
	for <kexec@lists.infradead.org>; Thu, 15 Sep 2011 18:51:31 +0900 (JST)
Received: from localhost (unknown [10.124.102.140])
	by m105.s.css.fujitsu.com (Postfix) with ESMTP id C3B779C8009
	for <kexec@lists.infradead.org>; Thu, 15 Sep 2011 18:51:30 +0900 (JST)
Date: Thu, 15 Sep 2011 18:51:24 +0900 (   )
Message-Id: <20110915.185124.233671810.d.hatayama@jp.fujitsu.com>
Subject: Question: How to find 640kB backup region from vmcore?
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
	boundary="--Next_Part(Thu_Sep_15_18_51_24_2011_822)--"
Content-Transfer-Encoding: 7bit
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

----Next_Part(Thu_Sep_15_18_51_24_2011_822)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

kdump saves the first 640kB physical memory in some backup region. The
question of mine is how to find the backup region from vmcore.

First let me explain why I have such question.

Fujitsu has sadump, Stand Alone Dump, which runs independently of
kernel logic, and the generated vmcore contains a whole part of
physical memory.

The issue happens when sadump is triggered after kdump has run and
passed the processing of saving the 640 kB memory in some backup
region. The 640 kB memory contains the data used for paging, and if
it's unavailable, we cannot access the region not straight mapped, for
example, the regions allocated using valloc() such as kernel module
data.

According to a part of kexec-tools/kexec/crashdump-elf.c below,
PT_LOAD entry in ELF segment corresponding to the 640kB backup region
has offset to the backup region in p_offset.

        /* Setup PT_LOAD type program header for every system RAM chunk.
         * A seprate program header for Backup Region*/
        for (i = 0; i < ranges; i++, range++) {
                unsigned long long mstart, mend;
                if (range->type != RANGE_RAM)
                        continue;
                mstart = range->start;
                mend = range->end;
                if (!mstart && !mend)
                        continue;
                phdr = (PHDR *) bufp;
                bufp += sizeof(PHDR);
                phdr->p_type    = PT_LOAD;
                phdr->p_flags   = PF_R|PF_W|PF_X;
                phdr->p_offset  = mstart;

                if (mstart == info->backup_src_start
                    && (mend - mstart + 1) == info->backup_src_size)
                        phdr->p_offset  = info->backup_start;

                /* We already prepared the header for kernel text. Map
                 * rest of the memory segments to kernel linearly mapped
                 * memory region.
                 */
                phdr->p_paddr = mstart;

I've confirmed this on most of RHEL versions. But strangely, on RHEL6,
kernel 2.6.32-71.34.1.el6.i686, I cannot find the PT_LOAD
corresponding to the backup region.

Here are sample ouput of crash utility. Complete ones are attached to
this mail and contains all commands to search vmcore for the PT_LOAD
corresponding to backup region.

* 2.6.18-238.el5PAE RHEL5.6

struct elf64_phdr {
  p_type = 0x1,
  p_flags = 0x7,
  p_offset = 0x20f60000,
  p_vaddr = 0xc0000000,
  p_paddr = 0x0,
  p_filesz = 0xa0000,
  p_memsz = 0xa0000,
  p_align = 0x0
}

* 2.6.32-71.34.1.el6.i686 RHEL6.0

struct elf64_phdr {
  p_type = 0x1,
  p_flags = 0x7,
  p_offset = 0x1000,
  p_vaddr = 0xc0001000,
  p_paddr = 0x1000,
  p_filesz = 0x98c00,
  p_memsz = 0x98c00,
  p_align = 0x0
}

The above RHEL 5.6 kernel is just as I expect, but the below RHEL6.0
is different in that p_offset has the same value as p_paddr, and it is
not the address of 640kB backup region.

I don't know what's happening on RHEL6.0. Could anyone tell me this?

Thanks.
HATAYAMA, Daisuke

----Next_Part(Thu_Sep_15_18_51_24_2011_822)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="log_2.6.18-238.el5PAE.txt"

$ crash-5.1.6.X86 /usr/lib/debug/lib/modules/2.6.18-238.el5PAE/vmlinux ./vmcore

crash-5.1.6.X86 5.1.6
Copyright (C) 2002-2011  Red Hat, Inc.
Copyright (C) 2004, 2005, 2006  IBM Corporation
Copyright (C) 1999-2006  Hewlett-Packard Co
Copyright (C) 2005, 2006  Fujitsu Limited
Copyright (C) 2006, 2007  VA Linux Systems Japan K.K.
Copyright (C) 2005  NEC Corporation
Copyright (C) 1999, 2002, 2007  Silicon Graphics, Inc.
Copyright (C) 1999, 2000, 2001, 2002  Mission Critical Linux, Inc.
This program is free software, covered by the GNU General Public License,
and you are welcome to change it and/or distribute copies of it under
certain conditions.  Enter "help copying" to see the conditions.
This program has absolutely no warranty.  Enter "help warranty" for details.
 
GNU gdb (GDB) 7.0
Copyright (C) 2009 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "--host=x86_64-unknown-linux-gnu --target=i686-pc-linux-gnu"...

      KERNEL: /usr/lib/debug/lib/modules/2.6.18-238.el5PAE/vmlinux
    DUMPFILE: ./vmcore  [PARTIAL DUMP]
        CPUS: 24
        DATE: Mon Jun 27 15:27:59 2011
      UPTIME: 00:14:13
LOAD AVERAGE: 0.72, 0.53, 0.43
       TASKS: 375
    NODENAME: localhost.localdomain
     RELEASE: 2.6.18-238.el5PAE
     VERSION: #1 SMP Sun Dec 19 14:42:44 EST 2010
     MACHINE: i686  (2000 Mhz)
      MEMORY: 34 GB
       PANIC: ""
         PID: 0
     COMMAND: "swapper"
        TASK: c068d3c0  (1 of 24)  [THREAD_INFO: c0706000]
         CPU: 0
       STATE: TASK_RUNNING 
     WARNING: panic task not found

crash-5.1.6.X86> sf
WARNING: terminal is not fully functional
-  (press RETURN)
scroll: off (/usr/bin/less)
crash-5.1.6.X86> 
crash-5.1.6.X86> hex
output radix: 16 (hex)
crash-5.1.6.X86> p kexec_crash_image->segment
$2 = {{
    buf = 0xb7bd9008, 
    bufsz = 0x1ca1f4, 
    mem = 0x1000000, 
    memsz = 0x47a000
  }, {
    buf = 0x9d5bec0, 
    bufsz = 0x7100, 
    mem = 0x147a000, 
    memsz = 0x9000
  }, {
    buf = 0x9d62ff0, 
    bufsz = 0x2180, 
    mem = 0x1483000, 
    memsz = 0x4000
  }, {
    buf = 0xb78db008, 
    bufsz = 0x2fbd73, 
    mem = 0x20c5e000, 
    memsz = 0x2fc000
  }, {
    buf = 0x9d654b8, 
    bufsz = 0x800, 
    mem = 0x20f5b000, 
    memsz = 0x4000
  }, {
    buf = 0xb783a008, 
    bufsz = 0xa0000, 
    mem = 0x20f60000, 
    memsz = 0xa0000
  }, {
    buf = 0x0, 
    bufsz = 0x0, 
    mem = 0x0, 
    memsz = 0x0
  }, {
    buf = 0x0, 
    bufsz = 0x0, 
    mem = 0x0, 
    memsz = 0x0
  }, {
    buf = 0x0, 
    bufsz = 0x0, 
    mem = 0x0, 
    memsz = 0x0
  }, {
    buf = 0x0, 
    bufsz = 0x0, 
    mem = 0x0, 
    memsz = 0x0
  }, {
    buf = 0x0, 
    bufsz = 0x0, 
    mem = 0x0, 
    memsz = 0x0
  }, {
    buf = 0x0, 
    bufsz = 0x0, 
    mem = 0x0, 
    memsz = 0x0
  }, {
    buf = 0x0, 
    bufsz = 0x0, 
    mem = 0x0, 
    memsz = 0x0
  }, {
    buf = 0x0, 
    bufsz = 0x0, 
    mem = 0x0, 
    memsz = 0x0
  }, {
    buf = 0x0, 
    bufsz = 0x0, 
    mem = 0x0, 
    memsz = 0x0
  }, {
    buf = 0x0, 
    bufsz = 0x0, 
    mem = 0x0, 
    memsz = 0x0
  }}
crash-5.1.6.X86> rd -p 0x20f5b000
20f5b000:  464c457f                              .ELF
crash-5.1.6.X86> ptov 0x20f5b000
VIRTUAL   PHYSICAL
e0f5b000  20f5b000
crash-5.1.6.X86> struct elf64_hdr 0xe0f5b000
struct elf64_hdr {
  e_ident = "\177ELF\002\001\001\000\000\000\000\000\000\000\000", 
  e_type = 0x4, 
  e_machine = 0x3, 
  e_version = 0x1, 
  e_entry = 0x0, 
  e_phoff = 0x40, 
  e_shoff = 0x0, 
  e_flags = 0x0, 
  e_ehsize = 0x40, 
  e_phentsize = 0x38, 
  e_phnum = 0x1f, 
  e_shentsize = 0x0, 
  e_shnum = 0x0, 
  e_shstrndx = 0x0
}
crash-5.1.6.X86> struct elf64_phdr 0xe0f5b040 0x1f
struct elf64_phdr {
  p_type = 0x4, 
  p_flags = 0x0, 
  p_offset = 0x32365c00, 
  p_vaddr = 0x0, 
  p_paddr = 0x32365c00, 
  p_filesz = 0x400, 
  p_memsz = 0x400, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x4, 
  p_flags = 0x0, 
  p_offset = 0x32365800, 
  p_vaddr = 0x0, 
  p_paddr = 0x32365800, 
  p_filesz = 0x400, 
  p_memsz = 0x400, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x4, 
  p_flags = 0x0, 
  p_offset = 0x32365400, 
  p_vaddr = 0x0, 
  p_paddr = 0x32365400, 
  p_filesz = 0x400, 
  p_memsz = 0x400, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x4, 
  p_flags = 0x0, 
  p_offset = 0x32365000, 
  p_vaddr = 0x0, 
  p_paddr = 0x32365000, 
  p_filesz = 0x400, 
  p_memsz = 0x400, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x4, 
  p_flags = 0x0, 
  p_offset = 0x37b47c00, 
  p_vaddr = 0x0, 
  p_paddr = 0x37b47c00, 
  p_filesz = 0x400, 
  p_memsz = 0x400, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x4, 
  p_flags = 0x0, 
  p_offset = 0x37b47800, 
  p_vaddr = 0x0, 
  p_paddr = 0x37b47800, 
  p_filesz = 0x400, 
  p_memsz = 0x400, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x4, 
  p_flags = 0x0, 
  p_offset = 0x37b47400, 
  p_vaddr = 0x0, 
  p_paddr = 0x37b47400, 
  p_filesz = 0x400, 
  p_memsz = 0x400, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x4, 
  p_flags = 0x0, 
  p_offset = 0x37b47000, 
  p_vaddr = 0x0, 
  p_paddr = 0x37b47000, 
  p_filesz = 0x400, 
  p_memsz = 0x400, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x4, 
  p_flags = 0x0, 
  p_offset = 0x37b48c00, 
  p_vaddr = 0x0, 
  p_paddr = 0x37b48c00, 
  p_filesz = 0x400, 
  p_memsz = 0x400, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x4, 
  p_flags = 0x0, 
  p_offset = 0x37b48800, 
  p_vaddr = 0x0, 
  p_paddr = 0x37b48800, 
  p_filesz = 0x400, 
  p_memsz = 0x400, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x4, 
  p_flags = 0x0, 
  p_offset = 0x37b48400, 
  p_vaddr = 0x0, 
  p_paddr = 0x37b48400, 
  p_filesz = 0x400, 
  p_memsz = 0x400, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x4, 
  p_flags = 0x0, 
  p_offset = 0x37b48000, 
  p_vaddr = 0x0, 
  p_paddr = 0x37b48000, 
  p_filesz = 0x400, 
  p_memsz = 0x400, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x4, 
  p_flags = 0x0, 
  p_offset = 0x37b49c00, 
  p_vaddr = 0x0, 
  p_paddr = 0x37b49c00, 
  p_filesz = 0x400, 
  p_memsz = 0x400, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x4, 
  p_flags = 0x0, 
  p_offset = 0x37b49800, 
  p_vaddr = 0x0, 
  p_paddr = 0x37b49800, 
  p_filesz = 0x400, 
  p_memsz = 0x400, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x4, 
  p_flags = 0x0, 
  p_offset = 0x37b49400, 
  p_vaddr = 0x0, 
  p_paddr = 0x37b49400, 
  p_filesz = 0x400, 
  p_memsz = 0x400, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x4, 
  p_flags = 0x0, 
  p_offset = 0x37b49000, 
  p_vaddr = 0x0, 
  p_paddr = 0x37b49000, 
  p_filesz = 0x400, 
  p_memsz = 0x400, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x4, 
  p_flags = 0x0, 
  p_offset = 0x37b4ac00, 
  p_vaddr = 0x0, 
  p_paddr = 0x37b4ac00, 
  p_filesz = 0x400, 
  p_memsz = 0x400, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x4, 
  p_flags = 0x0, 
  p_offset = 0x37b4a800, 
  p_vaddr = 0x0, 
  p_paddr = 0x37b4a800, 
  p_filesz = 0x400, 
  p_memsz = 0x400, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x4, 
  p_flags = 0x0, 
  p_offset = 0x37b4a400, 
  p_vaddr = 0x0, 
  p_paddr = 0x37b4a400, 
  p_filesz = 0x400, 
  p_memsz = 0x400, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x4, 
  p_flags = 0x0, 
  p_offset = 0x37b4a000, 
  p_vaddr = 0x0, 
  p_paddr = 0x37b4a000, 
  p_filesz = 0x400, 
  p_memsz = 0x400, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x4, 
  p_flags = 0x0, 
  p_offset = 0x37b4bc00, 
  p_vaddr = 0x0, 
  p_paddr = 0x37b4bc00, 
  p_filesz = 0x400, 
  p_memsz = 0x400, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x4, 
  p_flags = 0x0, 
  p_offset = 0x37b4b800, 
  p_vaddr = 0x0, 
  p_paddr = 0x37b4b800, 
  p_filesz = 0x400, 
  p_memsz = 0x400, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x4, 
  p_flags = 0x0, 
  p_offset = 0x37b4b400, 
  p_vaddr = 0x0, 
  p_paddr = 0x37b4b400, 
  p_filesz = 0x400, 
  p_memsz = 0x400, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x4, 
  p_flags = 0x0, 
  p_offset = 0x37b4b000, 
  p_vaddr = 0x0, 
  p_paddr = 0x37b4b000, 
  p_filesz = 0x400, 
  p_memsz = 0x400, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x4, 
  p_flags = 0x0, 
  p_offset = 0x8222a0, 
  p_vaddr = 0x0, 
  p_paddr = 0x8222a0, 
  p_filesz = 0x1000, 
  p_memsz = 0x1000, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x1, 
  p_flags = 0x7, 
  p_offset = 0x20f60000, 
  p_vaddr = 0xc0000000, 
  p_paddr = 0x0, 
  p_filesz = 0xa0000, 
  p_memsz = 0xa0000, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x1, 
  p_flags = 0x7, 
  p_offset = 0x100000, 
  p_vaddr = 0xc0100000, 
  p_paddr = 0x100000, 
  p_filesz = 0xf00000, 
  p_memsz = 0xf00000, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x1, 
  p_flags = 0x7, 
  p_offset = 0x21000000, 
  p_vaddr = 0xe1000000, 
  p_paddr = 0x21000000, 
  p_filesz = 0x17000000, 
  p_memsz = 0x17000000, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x1, 
  p_flags = 0x7, 
  p_offset = 0x38000000, 
  p_vaddr = 0xffffffffffffffff, 
  p_paddr = 0x38000000, 
  p_filesz = 0x316fc000, 
  p_memsz = 0x316fc000, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x1, 
  p_flags = 0x7, 
  p_offset = 0x6b700000, 
  p_vaddr = 0xffffffffffffffff, 
  p_paddr = 0x6b700000, 
  p_filesz = 0x4df8000, 
  p_memsz = 0x4df8000, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x1, 
  p_flags = 0x7, 
  p_offset = 0x100000000, 
  p_vaddr = 0xffffffffffffffff, 
  p_paddr = 0x100000000, 
  p_filesz = 0x780000000, 
  p_memsz = 0x780000000, 
  p_align = 0x0
}

----Next_Part(Thu_Sep_15_18_51_24_2011_822)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="log_2.6.32-71.34.1.el6.i686.txt"

$ /media/pub/debuginfos/vmlinux-2.6.32-71.34.1.el6.i686.gz /media/pub/vmcores/sadump-2.6.32-71.34.1.el6.i686 
Starting program: crash /media/pub/debuginfos/vmlinux-2.6.32-71.34.1.el6.i686.gz /media/pub/vmcores/sadump-2.6.32-71.34.1.el6.i686

crash 5.1.7
Copyright (C) 2002-2011  Red Hat, Inc.
Copyright (C) 2004, 2005, 2006  IBM Corporation
Copyright (C) 1999-2006  Hewlett-Packard Co
Copyright (C) 2005, 2006  Fujitsu Limited
Copyright (C) 2006, 2007  VA Linux Systems Japan K.K.
Copyright (C) 2005  NEC Corporation
Copyright (C) 1999, 2002, 2007  Silicon Graphics, Inc.
Copyright (C) 1999, 2000, 2001, 2002  Mission Critical Linux, Inc.
This program is free software, covered by the GNU General Public License,
and you are welcome to change it and/or distribute copies of it under
certain conditions.  Enter "help copying" to see the conditions.
This program has absolutely no warranty.  Enter "help warranty" for details.
 
please wait... (uncompressing /media/pub/debuginfos/vmlinux-2.6.32-71.34.1.el6.i686.gz)Detaching after fork from child process 30845.
Detaching after fork from child process 30847.
Detaching after fork from child process 30848.
GNU gdb (GDB) 7.0
Copyright (C) 2009 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "i686-pc-linux-gnu"...
Redefine command "runcrash_el6"? (y or n) [answered Y; input not from terminal]

Detaching after fork from child process 30849.
please wait... (gathering module symbol data)
WARNING: cannot access vmalloc'd module memory

      KERNEL: /media/pub/debuginfos/vmlinux-2.6.32-71.34.1.el6.i686.gz
    DUMPFILE: /media/pub/vmcores/sadump-2.6.32-71.34.1.el6.i686
        CPUS: 12
        DATE: Tue Sep  6 21:35:38 2011
      UPTIME: 00:10:05
LOAD AVERAGE: 0.00, 0.06, 0.05
       TASKS: 332
    NODENAME: RH60x86
     RELEASE: 2.6.32-71.34.1.el6.i686
     VERSION: #1 SMP Fri Jul 15 03:58:20 EDT 2011
     MACHINE: i686  (1999 Mhz)
      MEMORY: 13.7 GB
       PANIC: "Oops: 0002 [#1] SMP " (check log for details)
         PID: 28346
     COMMAND: "bash"
        TASK: e7cd6030  [THREAD_INFO: e7c96000]
         CPU: 0
       STATE: TASK_RUNNING (PANIC)

crash> set scroll off
scroll: off (/usr/bin/less)
crash> sf
scroll: off (/usr/bin/less)
crash> hex
output radix: 16 (hex)
crash> p kexec_crash_image->segment
$3 = {{
    buf = 0x99780e0, 
    bufsz = 0x38bb, 
    mem = 0x2000000, 
    memsz = 0x4000
  }, {
    buf = 0xb6f9f608, 
    bufsz = 0x37cd60, 
    mem = 0x2400000, 
    memsz = 0x37d000
  }, {
    buf = 0xb6b86008, 
    bufsz = 0x415a77, 
    mem = 0x9b39000, 
    memsz = 0x416000
  }, {
    buf = 0x9971040, 
    bufsz = 0x7060, 
    mem = 0x9f50000, 
    memsz = 0x9000
  }, {
    buf = 0x9970240, 
    bufsz = 0x800, 
    mem = 0x9f5a000, 
    memsz = 0x4000
  }, {
    buf = 0xb6ae5008, 
    bufsz = 0xa0000, 
    mem = 0x9f5f000, 
    memsz = 0xa0000
  }, {
    buf = 0x0, 
    bufsz = 0x0, 
    mem = 0x0, 
    memsz = 0x0
  }, {
    buf = 0x0, 
    bufsz = 0x0, 
    mem = 0x0, 
    memsz = 0x0
  }, {
    buf = 0x0, 
    bufsz = 0x0, 
    mem = 0x0, 
    memsz = 0x0
  }, {
    buf = 0x0, 
    bufsz = 0x0, 
    mem = 0x0, 
    memsz = 0x0
  }, {
    buf = 0x0, 
    bufsz = 0x0, 
    mem = 0x0, 
    memsz = 0x0
  }, {
    buf = 0x0, 
    bufsz = 0x0, 
    mem = 0x0, 
    memsz = 0x0
  }, {
    buf = 0x0, 
    bufsz = 0x0, 
    mem = 0x0, 
    memsz = 0x0
  }, {
    buf = 0x0, 
    bufsz = 0x0, 
    mem = 0x0, 
    memsz = 0x0
  }, {
    buf = 0x0, 
    bufsz = 0x0, 
    mem = 0x0, 
    memsz = 0x0
  }, {
    buf = 0x0, 
    bufsz = 0x0, 
    mem = 0x0, 
    memsz = 0x0
  }}
crash> rd -p 0x9f5a000
 9f5a000:  464c457f                              .ELF
crash> vtop 0x9f5a000
VIRTUAL   PHYSICAL
9f5a000   (not accessible)

crash> ptov 0x9f5a000
VIRTUAL   PHYSICAL
c9f5a000  9f5a000 
crash> struct elf64_hdr 0xc9f5a000
struct elf64_hdr {
  e_ident = "\177ELF\002\001\001\000\000\000\000\000\000\000\000", 
  e_type = 0x4, 
  e_machine = 0x3, 
  e_version = 0x1, 
  e_entry = 0x0, 
  e_phoff = 0x40, 
  e_shoff = 0x0, 
  e_flags = 0x0, 
  e_ehsize = 0x40, 
  e_phentsize = 0x38, 
  e_phnum = 0x13, 
  e_shentsize = 0x0, 
  e_shnum = 0x0, 
  e_shstrndx = 0x0
}
crash> struct elf64_phdr 0xc9f5a040 0x13
struct elf64_phdr {
  p_type = 0x4, 
  p_flags = 0x0, 
  p_offset = 0x1e0c218, 
  p_vaddr = 0x0, 
  p_paddr = 0x1e0c218, 
  p_filesz = 0x400, 
  p_memsz = 0x400, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x4, 
  p_flags = 0x0, 
  p_offset = 0x1e1c218, 
  p_vaddr = 0x0, 
  p_paddr = 0x1e1c218, 
  p_filesz = 0x400, 
  p_memsz = 0x400, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x4, 
  p_flags = 0x0, 
  p_offset = 0x1e2c218, 
  p_vaddr = 0x0, 
  p_paddr = 0x1e2c218, 
  p_filesz = 0x400, 
  p_memsz = 0x400, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x4, 
  p_flags = 0x0, 
  p_offset = 0x1e3c218, 
  p_vaddr = 0x0, 
  p_paddr = 0x1e3c218, 
  p_filesz = 0x400, 
  p_memsz = 0x400, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x4, 
  p_flags = 0x0, 
  p_offset = 0x1e4c218, 
  p_vaddr = 0x0, 
  p_paddr = 0x1e4c218, 
  p_filesz = 0x400, 
  p_memsz = 0x400, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x4, 
  p_flags = 0x0, 
  p_offset = 0x1e5c218, 
  p_vaddr = 0x0, 
  p_paddr = 0x1e5c218, 
  p_filesz = 0x400, 
  p_memsz = 0x400, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x4, 
  p_flags = 0x0, 
  p_offset = 0x1e6c218, 
  p_vaddr = 0x0, 
  p_paddr = 0x1e6c218, 
  p_filesz = 0x400, 
  p_memsz = 0x400, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x4, 
  p_flags = 0x0, 
  p_offset = 0x1e7c218, 
  p_vaddr = 0x0, 
  p_paddr = 0x1e7c218, 
  p_filesz = 0x400, 
  p_memsz = 0x400, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x4, 
  p_flags = 0x0, 
  p_offset = 0x1e8c218, 
  p_vaddr = 0x0, 
  p_paddr = 0x1e8c218, 
  p_filesz = 0x400, 
  p_memsz = 0x400, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x4, 
  p_flags = 0x0, 
  p_offset = 0x1e9c218, 
  p_vaddr = 0x0, 
  p_paddr = 0x1e9c218, 
  p_filesz = 0x400, 
  p_memsz = 0x400, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x4, 
  p_flags = 0x0, 
  p_offset = 0x1eac218, 
  p_vaddr = 0x0, 
  p_paddr = 0x1eac218, 
  p_filesz = 0x400, 
  p_memsz = 0x400, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x4, 
  p_flags = 0x0, 
  p_offset = 0x1ebc218, 
  p_vaddr = 0x0, 
  p_paddr = 0x1ebc218, 
  p_filesz = 0x400, 
  p_memsz = 0x400, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x4, 
  p_flags = 0x0, 
  p_offset = 0xb75200, 
  p_vaddr = 0x0, 
  p_paddr = 0xb75200, 
  p_filesz = 0x1000, 
  p_memsz = 0x1000, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x1, 
  p_flags = 0x7, 
  p_offset = 0x1000, 
  p_vaddr = 0xc0001000, 
  p_paddr = 0x1000, 
  p_filesz = 0x98c00, 
  p_memsz = 0x98c00, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x1, 
  p_flags = 0x7, 
  p_offset = 0x100000, 
  p_vaddr = 0xc0100000, 
  p_paddr = 0x100000, 
  p_filesz = 0x1f00000, 
  p_memsz = 0x1f00000, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x1, 
  p_flags = 0x7, 
  p_offset = 0xa000000, 
  p_vaddr = 0xca000000, 
  p_paddr = 0xa000000, 
  p_filesz = 0x2e000000, 
  p_memsz = 0x2e000000, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x1, 
  p_flags = 0x7, 
  p_offset = 0x38000000, 
  p_vaddr = 0xffffffffffffffff, 
  p_paddr = 0x38000000, 
  p_filesz = 0x316fc000, 
  p_memsz = 0x316fc000, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x1, 
  p_flags = 0x7, 
  p_offset = 0x6b700000, 
  p_vaddr = 0xffffffffffffffff, 
  p_paddr = 0x6b700000, 
  p_filesz = 0x4e63000, 
  p_memsz = 0x4e63000, 
  p_align = 0x0
}

struct elf64_phdr {
  p_type = 0x1, 
  p_flags = 0x7, 
  p_offset = 0x100000000, 
  p_vaddr = 0xffffffffffffffff, 
  p_paddr = 0x100000000, 
  p_filesz = 0x380000000, 
  p_memsz = 0x380000000, 
  p_align = 0x0
}

----Next_Part(Thu_Sep_15_18_51_24_2011_822)--
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

----Next_Part(Thu_Sep_15_18_51_24_2011_822)----


