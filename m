Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226] helo=dev.rtsoft.ru)
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WQxB3-0000CE-9h
 for kexec@lists.infradead.org; Fri, 21 Mar 2014 10:59:54 +0000
Message-ID: <532C1B71.2080406@dev.rtsoft.ru>
Date: Fri, 21 Mar 2014 14:58:57 +0400
From: Nikita Yushchenko <nyushchenko@dev.rtsoft.ru>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec/ppc: cleanup crash regions creation
References: <1394178033-501-1-git-send-email-nyushchenko@dev.rtsoft.ru>
In-Reply-To: <1394178033-501-1-git-send-email-nyushchenko@dev.rtsoft.ru>
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
To: kexec@lists.infradead.org
Cc: yadviga@dev.rtsoft.ru, lugovskoy@dev.rtsoft.ru

> Move filling crash_memory_range table entries into a separate routine,
> which saves quite a few lines of code.
> 
> In this routine, if range spawns over lowmem-highmem border, split range
> into two. This is needed to get proper virtual address for lowmem part.
> Similar thing is already done for x86. Credits to Yadviga Grigorieva
> <yadviga@dev.rtsoft.ru> for tracking down this issue for ppc.
> 
> Also this patch makes excluding crash kernel region a bit shorter, and
> removes unused variable to get rid of compiler warning.
> 
> Signed-off-by: Nikita Yushchenko <nyushchenko@dev.rtsoft.ru>
> ---
>  kexec/arch/ppc/crashdump-powerpc.c |  108 +++++++++++++++++-------------------
>  1 files changed, 51 insertions(+), 57 deletions(-)

Hi

Any followup on this?

Without this patch, vmcore files extracted with kdump is not very useful with gdb:

root@freescale-p2020ds:~# gdb ./vmlinux /mnt/vmcore 
--command=/usr/share/gdb/macros/gdb-kdump-helpers/gdbinit_commit
GNU gdb (GDB) 7.6
Copyright (C) 2013 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "powerpc-montavista-linux-gnuspe".
For bug reporting instructions, please see:
<http://www.gnu.org/software/gdb/bugs/>...
Reading symbols from /home/root/vmlinux...done.
[New LWP 2720]
#0  0xc035ae4c in sysrq_handle_crash (key=99) at drivers/tty/sysrq.c:138
138     drivers/tty/sysrq.c: No such file or directory.
(gdb) bt
#0  0xc035ae4c in sysrq_handle_crash (key=99) at drivers/tty/sysrq.c:138
#1  0xc035b6dc in __handle_sysrq (key=99,
    key@entry=<error reading variable: Cannot access memory at address
0xed679ed4>, check_mask=<optimized out>) at drivers/tty/sysrq.c:533
(gdb) ps
PID      tty     CMD
Cannot access memory at address 0xef85858c
(gdb)

With this patch, things are much better:

(gdb) bt
#0  0xc033c1e0 in sysrq_handle_crash (key=99) at drivers/tty/sysrq.c:138
#1  0xc033ca68 in __handle_sysrq (key=99, check_mask=check_mask@entry=false)
    at drivers/tty/sysrq.c:533
#2  0xc033cb24 in write_sysrq_trigger (file=<optimized out>, buf=<optimized
out>, 
    count=2, ppos=<optimized out>) at drivers/tty/sysrq.c:1030
#3  0xc0192654 in proc_reg_write (file=<optimized out>, buf=<optimized out>, 
    count=<optimized out>, ppos=<optimized out>) at fs/proc/inode.c:224
#4  0xc0135dd4 in vfs_write (file=file@entry=0xcfa78240, 
    buf=buf@entry=0x1011b408 <Address 0x1011b408 out of bounds>,
count=count@entry=2, 
    pos=pos@entry=0xcf71ff18) at fs/read_write.c:446
#5  0xc0136258 in SYSC_write (count=2, 
    buf=0x1011b408 <Address 0x1011b408 out of bounds>, fd=<optimized out>)
    at fs/read_write.c:494
#6  SyS_write (fd=<optimized out>, buf=269595656, count=2) at
fs/read_write.c:487
#7  0xc000ed08 in syscall_dotrace_cont () at arch/powerpc/kernel/entry_32.S:385
Backtrace stopped: frame did not save the PC


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
