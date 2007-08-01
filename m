Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IGH0b-00079W-F2
	for kexec@lists.infradead.org; Wed, 01 Aug 2007 12:25:15 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com
	[172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l71GPBmN007584
	for <kexec@lists.infradead.org>; Wed, 1 Aug 2007 12:25:11 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id
	l71GPAuc019507
	for <kexec@lists.infradead.org>; Wed, 1 Aug 2007 12:25:11 -0400
Received: from redhat.com (crash.boston.redhat.com [172.16.80.17])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id l71GPAsk031375
	for <kexec@lists.infradead.org>; Wed, 1 Aug 2007 12:25:10 -0400
Message-ID: <46B0B507.5090704@redhat.com>
Date: Wed, 01 Aug 2007 12:29:59 -0400
From: Dave Anderson <anderson@redhat.com>
MIME-Version: 1.0
Subject: Question re: mem= usage and resultant vmcore
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
To: kexec@lists.infradead.org


On an 4GB x86_64 kernel, with memory restricted with "mem=" like so:

   kernel /vmlinuz-2.6.18-36.el5 ro root=/dev/VolGroup00/LogVol00
   console=ttyS0,115200 mem=2000m crashkernel=128M@16M

The secondary kernel boots fine with this:

   Kernel command line: ro root=/dev/VolGroup00/LogVol00 console=ttyS0,115200
   mem=2000m  irqpoll maxcpus=1 memmap=exactmap memmap=640K@0K
   memmap=5048K@16384K memmap=125368K@22072K elfcorehdr=147440K
   memmap=76K#3406720K memmap=564K#3406796K

The /proc/vmcore shows 4GB:

   # ls -l /proc/vmcore
   -r-------- 1 root root 4164192032 Aug  1 10:57 /proc/vmcore
   #

I'm not sure whether that's supposed to reflect the "mem=2000m" size
or not?

Anyway, when copied to /var/crash, the "cp" command in the kdump init
file returns a 1, and the vmcore file is kept named as "vmcore-incomplete".

But the vmcore-incomplete looks to be the "right" size, and is functional
as a vmcore file:

   # crash /usr/lib/debug/lib/modules/2.6.18-36.el5/vmlinux vmcore-incomplete

   crash 4.0-4.3.1
   Copyright (C) 2002, 2003, 2004, 2005, 2006, 2007  Red Hat, Inc.
   Copyright (C) 2004, 2005, 2006  IBM Corporation
   Copyright (C) 1999-2006  Hewlett-Packard Co
   Copyright (C) 2005, 2006  Fujitsu Limited
   Copyright (C) 2006, 2007  VA Linux Systems Japan K.K.
   Copyright (C) 2005  NEC Corporation
   Copyright (C) 1999, 2002  Silicon Graphics, Inc.
   Copyright (C) 1999, 2000, 2001, 2002  Mission Critical Linux, Inc.
   This program is free software, covered by the GNU General Public License,
   and you are welcome to change it and/or distribute copies of it under
   certain conditions.  Enter "help copying" to see the conditions.
   This program has absolutely no warranty.  Enter "help warranty" for details.

   GNU gdb 6.1
   Copyright 2004 Free Software Foundation, Inc.
   GDB is free software, covered by the GNU General Public License, and you are
   welcome to change it and/or distribute copies of it under certain conditions.
   Type "show copying" to see the conditions.
   There is absolutely no warranty for GDB.  Type "show warranty" for details.
   This GDB was configured as "x86_64-unknown-linux-gnu"...

         KERNEL: /usr/lib/debug/lib/modules/2.6.18-36.el5/vmlinux
       DUMPFILE: vmcore-incomplete
           CPUS: 4
           DATE: Wed Aug  1 11:47:13 2007
         UPTIME: 00:02:15
   LOAD AVERAGE: 0.16, 0.14, 0.06
          TASKS: 118
       NODENAME: nec-em17.rhts.boston.redhat.com
        RELEASE: 2.6.18-36.el5
        VERSION: #1 SMP Fri Jul 20 14:26:46 EDT 2007
        MACHINE: x86_64  (2992 Mhz)
         MEMORY: 1.9 GB
          PANIC: "SysRq : Trigger a crashdump"
            PID: 3044
        COMMAND: "bash"
           TASK: ffff8100794f0100  [THREAD_INFO: ffff8100656dc000]
            CPU: 0
          STATE: TASK_RUNNING (SYSRQ)

   crash>

So two questions -- should the /proc/vmcore on the secondary kernel
reflect the restricted size, and what would cause the "cp" to
only copy the "correct" amount, while returning an error code?

Dave



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
