Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WJMle-0001kn-9H
 for kexec@lists.infradead.org; Fri, 28 Feb 2014 12:42:18 +0000
Received: from /spool/local
 by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Fri, 28 Feb 2014 12:41:53 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 20F7C219004D
 for <kexec@lists.infradead.org>; Fri, 28 Feb 2014 12:41:47 +0000 (GMT)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1SCfcfK49742006
 for <kexec@lists.infradead.org>; Fri, 28 Feb 2014 12:41:38 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1SCfnSJ021552
 for <kexec@lists.infradead.org>; Fri, 28 Feb 2014 05:41:50 -0700
Date: Fri, 28 Feb 2014 13:41:48 +0100
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: makedumpfile: get_max_mapnr() from ELF header problem
Message-ID: <20140228134148.15b60ceb@holzheu>
Mime-Version: 1.0
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: d.hatayama@jp.fujitsu.com, kexec@lists.infradead.org

Hello Atsushi,

On s390 we have the following little problem:

We use hypervisor or stand-alone dump tools to create Linux system
dumps. These tools do not know the kernel parameter line and dump the
full physical memory.

We use makedumpfile to filter those dumps.

If a Linux system has specified the "mem=" parameter, the dump tools
still dump the whole phypsical memory.

Unfortunately in "get_max_mapnr()" makedumpfile uses the ELF header to
get the maxmimum page frame number. Since this is not the correct value
in our case makedumpfile fails to filter the dump.

We get the following error on s390 with makedumpfile version 1.5.3:

makedumpfile -c -d 31 vmcore dump.kdump
cyclic buffer size has been changed: 22156083 => 22156032
Excluding unnecessary pages        : [ 21 %] vtop_s390x: Address too big for the number of page table levels.
readmem: Can't convert a virtual address(8000180104670) to physical address.
readmem: type_addr: 0, addr:8000180104670, size:32768
__exclude_unnecessary_pages: Can't read the buffer of struct page.
Excluding unnecessary pages        : [ 23 %] vtop_s390x: Address too big for the number of page table levels. readmem: Can't convert a
virtual address(8000180104670) to physical address. readmem: type_addr:
0, addr:8000180104670, size:327681.5.5 __exclude_unnecessary_pages: 
Can't read the buffer of struct page.

Since version 1.5.4 makedumpfile seems to loop in __exclude_unnecessary_pages().

We thought about several ways to fix this problem but have not found a
good solution up to now.

Do you have an idea how we could fix that?

Best Regards,
Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
