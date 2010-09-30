Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mailgw.miraclelinux.com ([122.212.45.247])
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1P1GFg-00088O-Nv
	for kexec@lists.infradead.org; Thu, 30 Sep 2010 10:20:38 +0000
Message-ID: <4CA46477.80704@miraclelinux.com>
Date: Thu, 30 Sep 2010 19:20:39 +0900
From: Makito SHIOKAWA <mshiokawa@miraclelinux.com>
MIME-Version: 1.0
Subject: Re: Can't kexec/kdump on mpc85xx
References: <4C9FFA9E.4080705@miraclelinux.com>
	<81FA9276-7283-4106-9155-83F17327D496@freescale.com>
	<4CA163C5.1060704@miraclelinux.com>
	<F2D9449F-2C78-4051-B1A9-32BD3CEF9366@freescale.com>
	<4CA2FAE9.3010109@miraclelinux.com>
	<1880BF7C-E151-401D-B20A-EC1113B92A6F@freescale.com>
In-Reply-To: <1880BF7C-E151-401D-B20A-EC1113B92A6F@freescale.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Matthew McClintock <msm@freescale.com>
Cc: kexec@lists.infradead.org

(2010/09/30 0:58), Matthew McClintock wrote:

> There are some other patches I sent upstream after 2.6.35 that fix these issues...

I've missed your recent patches. After applying below patches to linux-2.6.35, 
CONFIG_CRASH_DUMP, CONFIG_PROC_VMCORE were settable and second kernel booted 
normally on "kexec -p".

* powerpc/kexec: Adds correct calling convention for kexec purgatory
* powerpc/85xx: kexec for SMP 85xx BookE systems
* powerpc/crashdump: Fix issues with kexec and 36bit physical addr

And at last, I could see /proc/vmcore!

---
# gdb /boot/vmlinux /proc/vmcore
GNU gdb Red Hat Linux (6.5-16rh)
Copyright (C) 2006 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "ppc-asianux-linux-gnu"...Using host libthread_db lib
rary "/lib/libthread_db.so.1".


warning: exec file is newer than core file.
#0  0xc01b8054 in sysrq_handle_crash (key=99, tty=0x0)
     at drivers/char/sysrq.c:135
135     drivers/char/sysrq.c: No such file or directory.
         in drivers/char/sysrq.c
(gdb) bt
#0  0xc01b8054 in sysrq_handle_crash (key=99, tty=0x0)
     at drivers/char/sysrq.c:135
#1  0xc01b831c in __handle_sysrq (key=99, tty=0x0, check_mask=0)
     at drivers/char/sysrq.c:523
#2  0xc01b847c in write_sysrq_trigger (file=<value optimized out>,
     buf=<value optimized out>, count=2, ppos=0xc01bf3b0)
     at drivers/char/sysrq.c:768
#3  0xc00f1cfc in proc_reg_write (file=0x63, buf=0x0, count=4294967295,
     ppos=0xc01bf3b0) at fs/proc/inode.c:185
#4  0xc00a94e0 in vfs_write (file=0xdfb84400,
     buf=0x48020000 <Address 0x48020000 out of bounds>,
     count=<value optimized out>, pos=0xdfbbbf20) at fs/read_write.c:366
#5  0xc00a96bc in sys_write (fd=<value optimized out>,
     buf=0x48020000 <Address 0x48020000 out of bounds>, count=2)
     at fs/read_write.c:418
#6  0xc001059c in syscall_dotrace_cont ()
#7  0xc01b831c in __handle_sysrq (key=2, tty=0xfeb2ff4, check_mask=0)
     at drivers/char/sysrq.c:523
#8  0x00000000 in ?? ()
---

After all, problem was only kexec-tools' cross compiling optimization issue. 
Thanks a lot!

-- 
Makito SHIOKAWA <mshiokawa@miraclelinux.com>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
