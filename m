Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bzkgd-00017x-WF
 for kexec@lists.infradead.org; Thu, 27 Oct 2016 13:25:43 +0000
Received: from zmail15.collab.prod.int.phx2.redhat.com
 (zmail15.collab.prod.int.phx2.redhat.com [10.5.83.17])
 by mx6-phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u9RDPIP7050511
 for <kexec@lists.infradead.org>; Thu, 27 Oct 2016 09:25:18 -0400
Date: Thu, 27 Oct 2016 09:25:18 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <2004107674.8566432.1477574718303.JavaMail.zimbra@redhat.com>
In-Reply-To: <mailman.65015.1477545113.1639.kexec@lists.infradead.org>
References: <mailman.65015.1477545113.1639.kexec@lists.infradead.org>
Subject: Re: [PATCH Makedumpfile 0/4] x86_64: Fix page_offset for randomized
 base enabled
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org



----- Original Message -----
> 
> I put the cped-vmcore/vmlinux here:
> https://people.redhat.com/~ruyang/test/
> 
> Adding Dave Anderson for any comments about the vmcore correctness from
> crash point of view..
> 

As it turns out, the vmcore.makedumpfile can be read just fine:

  $ crash vmlinux.kaslr vmcore.makedumpfile 
  
  crash 7.1.7rc9
  Copyright (C) 2002-2016  Red Hat, Inc.
  Copyright (C) 2004, 2005, 2006, 2010  IBM Corporation
  Copyright (C) 1999-2006  Hewlett-Packard Co
  Copyright (C) 2005, 2006, 2011, 2012  Fujitsu Limited
  Copyright (C) 2006, 2007  VA Linux Systems Japan K.K.
  Copyright (C) 2005, 2011  NEC Corporation
  Copyright (C) 1999, 2002, 2007  Silicon Graphics, Inc.
  Copyright (C) 1999, 2000, 2001, 2002  Mission Critical Linux, Inc.
  This program is free software, covered by the GNU General Public License,
  and you are welcome to change it and/or distribute copies of it under
  certain conditions.  Enter "help copying" to see the conditions.
  This program has absolutely no warranty.  Enter "help warranty" for details.
   
  GNU gdb (GDB) 7.6
  Copyright (C) 2013 Free Software Foundation, Inc.
  License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
  This is free software: you are free to change and redistribute it.
  There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
  and "show warranty" for details.
  This GDB was configured as "x86_64-unknown-linux-gnu"...
  
  WARNING: kernel relocated [602MB]: patching 55325 gdb minimal_symbol values
  
        KERNEL: vmlinux.kaslr                                            
      DUMPFILE: vmcore.makedumpfile  [PARTIAL DUMP]
          CPUS: 1
          DATE: Thu Oct 27 02:07:46 2016
        UPTIME: 00:00:41
  LOAD AVERAGE: 0.14, 0.04, 0.01
         TASKS: 107
      NODENAME: localhost.localdomain
       RELEASE: 4.9.0-rc2+
       VERSION: #185 SMP Wed Oct 26 11:23:54 CST 2016
       MACHINE: x86_64  (2294 Mhz)
        MEMORY: 1 GB
         PANIC: "sysrq: SysRq : Trigger a crash"
           PID: 1934
       COMMAND: "bash"
          TASK: ffff9ca3bc155e00  [THREAD_INFO: ffff9ca3bc155e00]
           CPU: 0
         STATE: TASK_RUNNING (SYSRQ)
  
  crash> bt
  PID: 1934   TASK: ffff9ca3bc155e00  CPU: 0   COMMAND: "bash"
   #0 [ffffb2df4033fa08] machine_kexec at ffffffffa6a34e09
   #1 [ffffb2df4033fa68] __crash_kexec at ffffffffa6ab945a
   #2 [ffffb2df4033fb30] __crash_kexec at ffffffffa6ab9530
   #3 [ffffb2df4033fb48] crash_kexec at ffffffffa6ab9576
   #4 [ffffb2df4033fb68] oops_end at ffffffffa6a1529f
   #5 [ffffb2df4033fb90] no_context at ffffffffa6a3f67b
   #6 [ffffb2df4033fbf8] __bad_area_nosemaphore at ffffffffa6a3f8cc
   #7 [ffffb2df4033fc48] bad_area at ffffffffa6a3fa71
   #8 [ffffb2df4033fc70] __do_page_fault at ffffffffa6a4004d
   #9 [ffffb2df4033fcd8] do_page_fault at ffffffffa6a40100
  #10 [ffffb2df4033fd08] do_async_page_fault at ffffffffa6a3bbc5
  #11 [ffffb2df4033fd20] async_page_fault at ffffffffa6f9f1e5
      [exception RIP: sysrq_handle_crash+17]
      RIP: ffffffffa6d3a101  RSP: ffffb2df4033fdd8  RFLAGS: 00010282
      RAX: 000000000000000f  RBX: 0000000000000063  RCX: 0000000000000000
      RDX: 0000000000000000  RSI: ffff9ca3be60cc28  RDI: 0000000000000063
      RBP: ffffb2df4033fdd8   R8: 0000000000000001   R9: 0000000000000006
      R10: 0000000000000001  R11: 0000000000000172  R12: 0000000000000007
      R13: 0000000000000000  R14: ffffffffa745b4a0  R15: 0000000000000000
      ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
  #12 [ffffb2df4033fde0] __handle_sysrq at ffffffffa6d3a821
  #13 [ffffb2df4033fe10] write_sysrq_trigger at ffffffffa6d3ac4a
  #14 [ffffb2df4033fe28] proc_reg_write at ffffffffa6bb73dd
  #15 [ffffb2df4033fe48] __vfs_write at ffffffffa6b55b02
  #16 [ffffb2df4033fed0] vfs_write at ffffffffa6b56dbc
  #17 [ffffb2df4033ff08] sys_write at ffffffffa6b58060
  #18 [ffffb2df4033ff50] entry_SYSCALL_64_fastpath at ffffffffa6f9dbbb
      RIP: 00007f0b401a9c20  RSP: 00007ffe38d75698  RFLAGS: 00000246
      RAX: ffffffffffffffda  RBX: 0000000000000000  RCX: 00007f0b401a9c20
      RDX: 0000000000000002  RSI: 00005577bf7de790  RDI: 0000000000000001
      RBP: 0000000000000001   R8: 00007f0b40474740   R9: 00007f0b40ab7b40
      R10: 0000000000000073  R11: 0000000000000246  R12: 0000000000000000
      R13: 00007ffe38d75c10  R14: 0000000000000000  R15: 0000000000000000
      ORIG_RAX: 0000000000000001  CS: 0033  SS: 002b
  crash> 
  
But the ELF vmcore fails:
  
  $ crash vmlinux.kaslr vmcore
  
  crash 7.1.7rc9
  Copyright (C) 2002-2016  Red Hat, Inc.
  Copyright (C) 2004, 2005, 2006, 2010  IBM Corporation
  Copyright (C) 1999-2006  Hewlett-Packard Co
  Copyright (C) 2005, 2006, 2011, 2012  Fujitsu Limited
  Copyright (C) 2006, 2007  VA Linux Systems Japan K.K.
  Copyright (C) 2005, 2011  NEC Corporation
  Copyright (C) 1999, 2002, 2007  Silicon Graphics, Inc.
  Copyright (C) 1999, 2000, 2001, 2002  Mission Critical Linux, Inc.
  This program is free software, covered by the GNU General Public License,
  and you are welcome to change it and/or distribute copies of it under
  certain conditions.  Enter "help copying" to see the conditions.
  This program has absolutely no warranty.  Enter "help warranty" for details.
   
  GNU gdb (GDB) 7.6
  Copyright (C) 2013 Free Software Foundation, Inc.
  License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
  This is free software: you are free to change and redistribute it.
  There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
  and "show warranty" for details.
  This GDB was configured as "x86_64-unknown-linux-gnu"...
  
  WARNING: kernel relocated [602MB]: patching 55325 gdb minimal_symbol values
  
  WARNING: could not find MAGIC_START!                                   
  WARNING: cannot read linux_banner string
  crash: vmlinux.kaslr and vmcore do not match!
  
  Usage:
  
    crash [OPTION]... NAMELIST MEMORY-IMAGE[@ADDRESS]	(dumpfile form)
    crash [OPTION]... [NAMELIST]             		(live system form)
  
  Enter "crash -h" for details.
  $
  
Since the data being read was bogus, the first thing I checked was whether
the phys_base value was being calculated correctly.  I manually applied 
the phys_base that was stored in the compressed dump header, and the ELF
vmcore can be read:

  $ crash --machdep phys_base=ffffffffdf400000 vmlinux.kaslr vmcore 
  
  crash 7.1.7rc9
  Copyright (C) 2002-2016  Red Hat, Inc.
  Copyright (C) 2004, 2005, 2006, 2010  IBM Corporation
  Copyright (C) 1999-2006  Hewlett-Packard Co
  Copyright (C) 2005, 2006, 2011, 2012  Fujitsu Limited
  Copyright (C) 2006, 2007  VA Linux Systems Japan K.K.
  Copyright (C) 2005, 2011  NEC Corporation
  Copyright (C) 1999, 2002, 2007  Silicon Graphics, Inc.
  Copyright (C) 1999, 2000, 2001, 2002  Mission Critical Linux, Inc.
  This program is free software, covered by the GNU General Public License,
  and you are welcome to change it and/or distribute copies of it under
  certain conditions.  Enter "help copying" to see the conditions.
  This program has absolutely no warranty.  Enter "help warranty" for details.
   
  NOTE: setting phys_base to: 0xffffffffdf400000
  
  GNU gdb (GDB) 7.6
  Copyright (C) 2013 Free Software Foundation, Inc.
  License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
  This is free software: you are free to change and redistribute it.
  There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
  and "show warranty" for details.
  This GDB was configured as "x86_64-unknown-linux-gnu"...
  
  WARNING: kernel relocated [602MB]: patching 55325 gdb minimal_symbol values
  
        KERNEL: vmlinux.kaslr                                            
      DUMPFILE: vmcore
          CPUS: 1
          DATE: Thu Oct 27 02:07:46 2016
        UPTIME: 00:00:41
  LOAD AVERAGE: 0.14, 0.04, 0.01
         TASKS: 107
      NODENAME: localhost.localdomain
       RELEASE: 4.9.0-rc2+
       VERSION: #185 SMP Wed Oct 26 11:23:54 CST 2016
       MACHINE: x86_64  (2294 Mhz)
        MEMORY: 1 GB
         PANIC: "sysrq: SysRq : Trigger a crash"
           PID: 1934
       COMMAND: "bash"
          TASK: ffff9ca3bc155e00  [THREAD_INFO: ffff9ca3bc155e00]
           CPU: 0
         STATE: TASK_RUNNING (SYSRQ)
  
  crash> 
  
That being said, my recent 4.8 and 4.9 KASLR testing has been on live
systems and compressed kdumps, so the old tried-and-true manner of
calculating the phys_base from the ELF PT_LOAD segments apparently
no longer works with KASLR.  

It would be so much more helpful if the VMCOREINFO data in the ELF 
header stored the actual phys_base value instead of its symbol value:

  crash> help -D
  ...
  SYMBOL(phys_base)=ffffffffa740b010
  ...

which is completely useless unless the phys_base value is known.

Anyway, can you send me the makedumpfile code that calculates the 
phys_base value?

Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
