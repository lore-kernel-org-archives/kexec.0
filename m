Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1RAceC-0000Vm-Ed
	for kexec@lists.infradead.org; Mon, 03 Oct 2011 07:09:10 +0000
Received: from /spool/local by au.ibm.com with XMail ESMTP
	for <kexec@lists.infradead.org> from <prasad@linux.vnet.ibm.com>;
	Mon, 3 Oct 2011 08:04:45 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p9377fV02445392
	for <kexec@lists.infradead.org>; Mon, 3 Oct 2011 18:07:41 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p9377eMJ030436
	for <kexec@lists.infradead.org>; Mon, 3 Oct 2011 18:07:41 +1100
Date: Mon, 3 Oct 2011 12:37:35 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: [Patch 0/4] Slimdump framework using NT_NOCOREDUMP elf-note
Message-ID: <20111003070735.GJ2223@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Reply-To: prasad@linux.vnet.ibm.com
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, crash-utility@redhat.com, kexec@lists.infradead.org
Cc: oomichi@mxs.nes.nec.co.jp, "Luck, Tony" <tony.luck@intel.com>, tachibana@mxm.nes.nec.co.jp, Andi Kleen <andi@firstfloor.org>, anderson@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

Hi All,
	Please find a set of patches that introduce a 'slimdump'
framework. Details as described below.

Problem
--------
A system configured with kdump, captures the kernel memory
for all types of crashes even when it doesn't make much sense to do so.
For instance, system crashes triggered due to hardware errors don't need
a complete dump of the memory for investigation.

In the case of crashes triggered by fatal machine check exceptions (MCE)
due to unrecoverable memory errors, it is even dangerous to read the
crashing kernel's memory. When the kexec kernel reads the crashing
kernel's memory, it 'consumes' the data from the faulty memory location,
potentially causing a recursion of faults.

This problem was previously discussed in the kernel community, with a
proposal to leave out kernel memory regions from /proc/vmcore (refer:
mail threads pertaining to
http://article.gmane.org/gmane.linux.kernel/1148266). However there were
suggestions against making this behaviour a kernel policy.

Solution
---------
Since capturing of crashing kernel's memory for hardware error induced
crashes isn't required or is dangerous, we introduce a mechanism to
generate 'slimdump'.

Basically, a new elf-note of type NT_NOCOREDUMP type is added by the
kernel to the vmcore, which is recognised by all tools in the kdump chain
to generate and save a 'slimdump' that contains only elf-headers and the
elf-note section. The elf-note section may be used to add description
about the cause of the error.

The enclosed set of patches make changes to kernel, kexec, makedumpfile
and crash tool to make them recognise the NT_NOCOREDUMP elf-note and
generate a 'slimdump'. Also, fatal MCEs in the kernel is turned into a
consumer of the slimdump mechanism to prevent collection of normal
kdump.

Alternatively, the user has an option (through suitable makedumpfile or
kdump configuration options) to collect the complete vmcore or to
extract the 'dmesg' from /proc/vmcore.

Screen logs
-------------
# mce-inject ~/mce/mce-test/cases/soft-inj/panic_ucr/data/srar_over
[ 4934.748416] [Hardware Error]: CPU 0: Machine Check Exception: 6 Bank
2: f580000000000000
[ 4934.749079] [Hardware Error]: RIP 73:<000000001eadbabe> 
[ 4934.749079] [Hardware Error]: TSC ef029a23417 ADDR 1234 
[ 4934.749079] [Hardware Error]: PROCESSOR 0:663 TIME 1317149322 SOCKET
0 APIC 0
[ 4934.749079] [Hardware Error]: Run the above through 'mcelog --ascii'
[ 4934.749079] [Hardware Error]: Machine check: Overflowed uncorrected
[ 4934.749079] Kernel panic - not syncing: Fatal machine check on
current CPU
[ 4934.749079] Pid: 1379, comm: mce-inject Tainted: G   M
3.1.0-rc4.slimdump+ #34
[ 4934.749079] Call Trace:
[ 4934.749079]  [<ffffffff81084922>] panic+0xbc/0x1cf
[ 4934.749079]  [<ffffffff810858ff>] ? printk+0x6c/0x6e
[ 4934.749079]  [<ffffffff8104c43b>] mce_panic+0x187/0x1a4
[ 4934.749079]  [<ffffffff8104d525>] do_machine_check+0x5ec/0x6c3
[ 4934.749079]  [<ffffffff8104e4e1>] raise_exception+0x5c/0x84
[ 4934.749079]  [<ffffffff8104e5e9>] raise_local+0x5a/0xcc
[ 4934.749079]  [<ffffffff8104e8ee>] mce_write+0x218/0x24e
[ 4934.749079]  [<ffffffff8115abee>] vfs_write+0xb0/0x108
[ 4934.749079]  [<ffffffff8115ad0a>] sys_write+0x4c/0x71
[ 4934.749079]  [<ffffffff815bf12b>] system_call_fastpath+0x16/0x1b
[    0.817861] kvm: no hardware support
..............
................
.................
# ls
vmcore
# ls -lh vmcore
-r-------- 1 root root 1.8G Sep 27 13:20 vmcore
# ~/makedumpfile.slimdump/makedumpfile vmcore vmcore.makedumpfile.review
The kernel version is not supported.
The created dumpfile may be incomplete.
Copying data                       : [100 %] 

The dumpfile is saved to vmcore.makedumpfile.review.

makedumpfile Completed.
# ls -lh vmcore.makedumpfile.review
-rw------- 1 root root 3.9K Sep 28 01:40 vmcore.makedumpfile.review
# eu-readelf -n
vmcore.makedumpfile.review

Note segment of 3592 bytes at offset 0x158:
  Owner          Data size  Type
  CORE                 336  PRSTATUS
    info.si_signo: 0, info.si_code: 0, info.si_errno: 0, cursig: 0
    sigpend: <>
..........
.............
.........
    NUMBER(PG_private)=11
    NUMBER(PG_swapcache)=16
    SYMBOL(phys_base)=ffffffff81a0e010
    SYMBOL(init_level4_pgt)=ffffffff81a06000
    SYMBOL(node_data)=ffffffff81b70b80
    LENGTH(node_data)=512
    CRASHTIME=1317621133

  PANIC_MCE             49  <unknown>: 21
# crash -S ~/linux-2.6.slimdump/System.map ~/linux-2.6.slimdump/vmlinux vmcore.makedumpfile.review

crash 5.1.8
Copyright (C) 2002-2011  Red Hat, Inc.
Copyright (C) 2004, 2005, 2006  IBM Corporation
Copyright (C) 1999-2006  Hewlett-Packard Co
Copyright (C) 2005, 2006  Fujitsu Limited
Copyright (C) 2006, 2007  VA Linux Systems Japan K.K.
Copyright (C) 2005  NEC Corporation
Copyright (C) 1999, 2002, 2007  Silicon Graphics, Inc.
Copyright (C) 1999, 2000, 2001, 2002  Mission Critical Linux, Inc.
This program is free software, covered by the GNU General Public
License,
and you are welcome to change it and/or distribute copies of it under
certain conditions.  Enter "help copying" to see the conditions.
This program has absolutely no warranty.  Enter "help warranty" for
details.
 
crash: overriding /boot/System.map with
/home/prasadkr/linux-2.6.slimdump/System.map
"System crashed due to a hardware memory error. No coredump available."
Nocoredump Reason: PANIC_MCE
crash: Elf64_Phdr pointer: 1c46170  ELF header end: 1c46130

-------
Thanks,
K.Prasad


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
