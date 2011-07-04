Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate4.uk.ibm.com ([194.196.100.164])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1Qdmen-0001dh-VQ
	for kexec@lists.infradead.org; Mon, 04 Jul 2011 17:10:09 +0000
Received: from d06nrmr1507.portsmouth.uk.ibm.com
	(d06nrmr1507.portsmouth.uk.ibm.com [9.149.38.233])
	by mtagate4.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p64H9tQD021146
	for <kexec@lists.infradead.org>; Mon, 4 Jul 2011 17:09:55 GMT
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
	[9.149.37.247])
	by d06nrmr1507.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p64H9tjo2519152
	for <kexec@lists.infradead.org>; Mon, 4 Jul 2011 18:09:55 +0100
Received: from d06av12.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av12.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p64H9sgP021522
	for <kexec@lists.infradead.org>; Mon, 4 Jul 2011 11:09:55 -0600
Message-Id: <20110704170922.976299676@linux.vnet.ibm.com>
Date: Mon, 04 Jul 2011 19:09:22 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [patch 0/9] kdump: Patch series for s390 support
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: ebiederm@xmission.com, vgoyal@redhat.com, hbabu@us.ibm.com, mahesh@linux.vnet.ibm.com
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, kexec@lists.infradead.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, horms@verge.net.au, schwidefsky@de.ibm.com

This patch series adds kdump support for the s390 architecture (64 bit). There
are a few common code changes necessary because the s390 implementation is
different to other architectures in some points. Especially these common code
patches (1-7) should be reviewed. Patch 8 "s390: kdump backend code" contains
the s390 specific part. Patch 9 includes the necessary changes for the kexec
tool.

In the following I describe the main differences of the s390 implementation:

The s390 kernel is not relocatable therefore the crashkernel memory is swapped
with the area [0 - crashkernel memory] before the kdump kernel is started.
Architectures other than s390 run the kdump kernel at a memory location that is
disjunct to the standard location for the kernel image and to all memory that
might be in use for I/O by the production system. The main reason for this
seems to be that these architectures do not have a means to clear all ongoing
I/O. If active memory of the production system is reused by the kdump kernel
they run into memory corruption issues. On s390 with diagnose call 308 or boot
(IPL) there is the possibility to stop all ongoing I/O. Therefore we can safely
run the kdump kernel at the old location.

On s390 we do not create page tables for the crashkernel memory and use a
memcpy_real() function to load the kdump kernel and ramdisk in kexec_load()
system call.

On s390 we have external kdump triggers. For example stand-alone dump tools.
The address range information of crashkernel memory is stored at a well defined
storage location that can be used by the external dump triggers to find the
kdump entry point. To export the address range for the crashkernel memory we
introduce a new mechanism that we call meminfo. This allows to define checksum
secured information in memory that is accessible via an s390 ABI defined
storage address. The following information is currently stored via meminfo:
* Crashkernel memory range
* kexec segments for kdump
* Pointer to vmcoreinfo note

Checksums for the loaded kexec segments are stored. This can be used to verify
that kdump is not corrupted. The check is done e.g. by the s390 stand-alone
dump tools via meminfo. If kdump has NOT been overwritten, the checksums are
valid and kdump is started, otherwise a full-blown s390 stand-alone dump is
created as backup dump mechanism.

On s390 the ELF header is created dynamically at kdump startup in the kdump
(2nd) kernel. This is possible, because the memory detection and collection of
the CPU register sets can be done on s390 in the 2nd kernel. Therefore on s390
the ELF header is NOT prepared by the kexec tool. The address for vmcoreinfo
can be found via meminfo and is used by the kdump kernel for ELF header
initialization.

On s390 no additional kernel parameter is needed for kdump. Everything kdump
needs to know can be determined dynamically when the 2nd kernel starts.

If you agree with the approach of this patch series, how should this go
upstream?

Thanks,

Michael

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
