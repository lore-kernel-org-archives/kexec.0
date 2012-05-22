Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SWpH5-0005UA-Tz
 for kexec@lists.infradead.org; Tue, 22 May 2012 13:37:21 +0000
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <suzuki@in.ibm.com>;
 Tue, 22 May 2012 12:37:19 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q4MCZNAE9109544
 for <kexec@lists.infradead.org>; Tue, 22 May 2012 22:35:23 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q4MCgOND003976
 for <kexec@lists.infradead.org>; Tue, 22 May 2012 22:42:25 +1000
Message-ID: <4FBB89A2.90709@in.ibm.com>
Date: Tue, 22 May 2012 18:12:10 +0530
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
MIME-Version: 1.0
Subject: Handling spin table in kdump
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
To: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Cc: Matthew McClintock <msm@freescale.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Hi

I came across the following issue while testing Kdump on an SMP 
board(Currituck) running a non-SMP kernel. Even though the kernel is UP,
the device-tree has the nodes for second CPU and the related details.


The kexec tool adds the spin table area as a reserved section in the 
device tree for the dump capture kernel. This value is read from the 
'cpu-release-addr'.

But now, if the spin table is not located within the 'Reserved region' 
for the crash kernel, the dump capture kernel would fail to boot, 
hitting a BUG in mm/bootmem.c as in [1].

This is because we try to reserve a region which is not available to the 
kernel.

So I am wondering how is this handled really on an SMP board (Fsl_bookE).

There are two possible solutions :
1) Do not reserve the regions for the spin-table, as we will use
only the crashing CPU in the second kernel(maxcpus=1).


2) Add the spin-table region to the available memory regions passed
to the kernel by kexec-tools.

I have tested (1) and it works fine for me. Yet to test (2).


Thoughts ?


Thanks
Suzuki



[1] Kernel Bug
----------------


Linux version 3.3.0-rc5 (root@suzukikp.in.ibm.com) (gcc version 4.3.4 
[gcc-4_3-branch revision 152973] (GCC) ) #12 Tue May 22 18:03:01 IST2
Found legacy serial port 0 for /plb/opb/serial@10000000
   mem=20010000000, taddr=20010000000, irq=0, clk=1851851, speed=115200
------------[ cut here ]------------
kernel BUG at mm/bootmem.c:351!
Vector: 700 (Program Check) at [c8a61e90]
     pc: c847f91c: mark_bootmem+0xa0/0x14c
     lr: c8472670: do_init_bootmem+0x1ac/0x218
     sp: c8a61f40
    msr: 21000
   current = 0xc8a4a500
     pid   = 0, comm = swapper
kernel BUG at mm/bootmem.c:351!
enter ? for help
[c8a61f70] c8472670 do_init_bootmem+0x1ac/0x218
[c8a61f90] c847025c setup_arch+0x1bc/0x234
[c8a61fb0] c846b62c start_kernel+0x98/0x358
[c8a61ff0] c80000b4 _start+0xb4/0xf8


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
