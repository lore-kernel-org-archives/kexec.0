Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-la0-f53.google.com ([209.85.215.53])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WJM2H-0000I3-4T
 for kexec@lists.infradead.org; Fri, 28 Feb 2014 11:55:26 +0000
Received: by mail-la0-f53.google.com with SMTP id b8so2585439lan.26
 for <kexec@lists.infradead.org>; Fri, 28 Feb 2014 03:55:02 -0800 (PST)
Received: from dhcp-192-168-11-247.dev.rtsoft.ru (mail.dev.rtsoft.ru.
 [213.79.90.226])
 by mx.google.com with ESMTPSA id h7sm3596625lbj.1.2014.02.28.03.48.43
 for <kexec@lists.infradead.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Fri, 28 Feb 2014 03:48:43 -0800 (PST)
Message-ID: <5310779B.8050400@mvista.com>
Date: Fri, 28 Feb 2014 15:48:43 +0400
From: Yadviga <yadviga@mvista.com>
MIME-Version: 1.0
Subject: separate lowmem and highmem in crashdump segments for ppc32
References: <530FA89D.2010105@mvista.com>
In-Reply-To: <530FA89D.2010105@mvista.com>
Content-Type: multipart/mixed; boundary="------------030508090103070504000705"
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

This is a multi-part message in MIME format.
--------------030508090103070504000705
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Hello all
I would like to suggest the patch for ppc32 arch against kexec-2.0.5.
Could you please include it into kexec tools.

The patch separates highmem and lowmem.
Usually highmem and lowmem merges in common segment.
Virtual  addresses for this segment are invalid because code from
crashdump-elf.c set virtual address -1 for lowmem
addresses if they share segment with highmem addresses.

                 /* HIGMEM has a virtual address of -1 */

                  if (elf_info->lowmem_limit
&& (mend > (elf_info->lowmem_limit - 1)))
                          phdr->p_vaddr = -1;

The patch locates them in different segments.
So lowmem will have the valid  virtual address

This is result of gdb backtrace before applying the patch.

powerpc-montavista-linux-gnuspe-gdb vmlinux /opt/tmp/vmcore_kexec2.0.5
GNU gdb (MontaVista Linux G++ 4.7-140117041417) 7.6
Copyright (C) 2013 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later
<http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "--host=i686-pc-linux-gnu
--target=powerpc-montavista-linux-gnuspe".
For bug reporting instructions, please see:
<http://support.mvista.com/>...
Reading symbols from /home/yadviga/MVL7/mvl7kernel_jan/vmlinux...done.
[New LWP 1993]
#0  0xc033c1e0 in sysrq_handle_crash (key=99) at drivers/tty/sysrq.c:138
138             *killer = 1;
(gdb) bt
#0  0xc033c1e0 in sysrq_handle_crash (key=99) at drivers/tty/sysrq.c:138
#1  0xc033ca68 in __handle_sysrq (key=99,
      key@entry=<error reading variable: Cannot access memory at address
0xcf6a5ed4>,
      check_mask=<optimized out>) at drivers/tty/sysrq.c:533
(gdb)

Here is backtrace after aapying the patch. Backtrace looks better.

powerpc-montavista-linux-gnuspe-gdb vmlinux /opt/tmp/vmcore
GNU gdb (MontaVista Linux G++ 4.7-140117041417) 7.6
...
Reading symbols from /home/yadviga/MVL7/mvl7kernel_jan/vmlinux...done.
[New LWP 1969]
#0  0xc033c1e0 in sysrq_handle_crash (key=99) at drivers/tty/sysrq.c:138
138             *killer = 1;
(gdb) bt
#0  0xc033c1e0 in sysrq_handle_crash (key=99) at drivers/tty/sysrq.c:138
#1  0xc033ca68 in __handle_sysrq (key=99,
check_mask=check_mask@entry=false) at drivers/tty/sysrq.c:533
#2  0xc033cb24 in write_sysrq_trigger (file=<optimized out>,
buf=<optimized out>, count=2,
      ppos=<optimized out>) at drivers/tty/sysrq.c:1030
#3  0xc0192654 in proc_reg_write (file=<optimized out>, buf=<optimized
out>, count=<optimized out>,
      ppos=<optimized out>) at fs/proc/inode.c:224
#4  0xc0135dd4 in vfs_write (file=file@entry=0xcfb2e480,
      buf=buf@entry=0x1011b408 <Address 0x1011b408 out of bounds>,
count=count@entry=2,
      pos=pos@entry=0xcf063f18) at fs/read_write.c:446
#5  0xc0136258 in SYSC_write (count=2, buf=0x1011b408 <Address
0x1011b408 out of bounds>, fd=<optimized out>)
      at fs/read_write.c:494
#6  SyS_write (fd=<optimized out>, buf=269595656, count=2) at
fs/read_write.c:487
#7  0xc000ed08 in syscall_dotrace_cont () at
arch/powerpc/kernel/entry_32.S:385
Backtrace stopped: frame did not save the PC
(gdb)

Best regards
Yadviga





--------------030508090103070504000705
Content-Type: text/plain; charset=UTF-8;
 name="separate-highmem-lowmem.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="separate-highmem-lowmem.patch"

From f8454324a060b997b652362fdaa2f01a7c548cc0 Mon Sep 17 00:00:00 2001
From: Yadviga Grigoryeva <yadviga@mvista.com>
Date: Fri, 28 Feb 2014 00:49:59 +0400
Subject: [PATCH] separate highmem and lowmem for ppc32

The patch separates highmem and lowmem.
Usually highmem and lowmem merges in common segment.
Virtual  addresses for this segment are invalid because
 code from crashdump-elf.c set virtual address -1 for lowmem 
addresses if they share segment with highmem addresses

               /* HIGMEM has a virtual address of -1 */

                if (elf_info->lowmem_limit
                   && (mend > (elf_info->lowmem_limit - 1)))
                        phdr->p_vaddr = -1;

The patch locates them in different segments.
So lowmem will have the valid  virtual address

Signed-off-by: Yadviga Grigoryeva <yadviga@mvista.com>
---
 kexec/arch/ppc/crashdump-powerpc.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/kexec/arch/ppc/crashdump-powerpc.c b/kexec/arch/ppc/crashdump-powerpc.c
index c06d310..39a12ca 100644
--- a/kexec/arch/ppc/crashdump-powerpc.c
+++ b/kexec/arch/ppc/crashdump-powerpc.c
@@ -214,6 +214,34 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 		crash_memory_range[memory_ranges++].end = cend;
 	}
 
+#ifndef CONFIG_PPC64
+	/* separate lowmem and highmem in segment */
+	if (memory_ranges < crash_max_memory_ranges ) {
+		int k,l;
+		for (l=0; l<memory_ranges; l++) {
+			if (crash_memory_range[l].start <
+			    elf_info32.lowmem_limit &&
+			    crash_memory_range[l].end >
+			    elf_info32.lowmem_limit) {
+				/* shift crash_memory_range */
+				for (k=memory_ranges; k>l; k--) {
+					crash_memory_range[k].start
+						= crash_memory_range[k-1].start;
+					crash_memory_range[k].end
+						= crash_memory_range[k-1].end;
+					crash_memory_range[k].type
+						= crash_memory_range[k-1].type;
+				}
+				memory_ranges++;
+				crash_memory_range[l].end
+					= elf_info32.lowmem_limit;
+				crash_memory_range[l+1].start
+					= elf_info32.lowmem_limit;
+			break;
+			}
+		}
+	}
+#endif
 	*range = crash_memory_range;
 	*ranges = memory_ranges;
 
-- 
1.6.3.3.334.gb7e98.dirty



--------------030508090103070504000705
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--------------030508090103070504000705--

