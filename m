Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate3.uk.ibm.com ([194.196.100.163])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1Qrs6w-0001x2-Pk
	for kexec@lists.infradead.org; Fri, 12 Aug 2011 13:49:21 +0000
Received: from d06nrmr1707.portsmouth.uk.ibm.com
	(d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate3.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p7CDn9Hw029982
	for <kexec@lists.infradead.org>; Fri, 12 Aug 2011 13:49:09 GMT
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
	[9.149.37.247])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p7CDn8nY1499366
	for <kexec@lists.infradead.org>; Fri, 12 Aug 2011 14:49:08 +0100
Received: from d06av12.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av12.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p7CDn7CO001275
	for <kexec@lists.infradead.org>; Fri, 12 Aug 2011 07:49:08 -0600
Message-Id: <20110812134907.325789470@linux.vnet.ibm.com>
Date: Fri, 12 Aug 2011 15:48:52 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [patch v3 3/8] kdump: Add size to elfcorehdr kernel parameter
References: <20110812134849.748973593@linux.vnet.ibm.com>
Content-Disposition: inline; filename=s390-kdump-common-elfcorehdr-parm.patch
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
To: vgoyal@redhat.com
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, horms@verge.net.au, ebiederm@xmission.com, schwidefsky@de.ibm.com, kexec@lists.infradead.org

From: Michael Holzheu <holzheu@linux.vnet.ibm.com>

Currently only the address of the pre-allocated ELF header is passed with
the elfcorehdr= kernel parameter. In order to reserve memory for the header
in the 2nd kernel also the size is required. Current kdump architecture
backends use different methods to do that, e.g. x86 uses the memmap= kernel
parameter. On s390 there is no easy way to transfer this information.
Therefore the elfcorehdr kernel parameter is extended to also pass the size.
This now can also be used as standard mechanism by all future kdump
architecture backends.

The syntax of the kernel parameter is extended as follows:

elfcorehdr=[size[KMG]@]offset[KMG]

This change is backward compatible because elfcorehdr=size is still allowed.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 Documentation/kernel-parameters.txt |    6 +++---
 include/linux/crash_dump.h          |    1 +
 kernel/crash_dump.c                 |   11 +++++++++++
 3 files changed, 15 insertions(+), 3 deletions(-)

--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -725,10 +725,10 @@ bytes respectively. Such letter suffixes
 			See Documentation/block/as-iosched.txt and
 			Documentation/block/deadline-iosched.txt for details.
 
-	elfcorehdr=	[IA64,PPC,SH,X86]
+	elfcorehdr=[size[KMG]@]offset[KMG] [IA64,PPC,SH,X86,S390]
 			Specifies physical address of start of kernel core
-			image elf header. Generally kexec loader will
-			pass this option to capture kernel.
+			image elf header and optionally the size. Generally
+			kexec loader will pass this option to capture kernel.
 			See Documentation/kdump/kdump.txt for details.
 
 	enable_mtrr_cleanup [X86]
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -10,6 +10,7 @@
 #define ELFCORE_ADDR_ERR	(-2ULL)
 
 extern unsigned long long elfcorehdr_addr;
+extern unsigned long long elfcorehdr_size;
 
 extern ssize_t copy_oldmem_page(unsigned long, char *, size_t,
 						unsigned long, int);
--- a/kernel/crash_dump.c
+++ b/kernel/crash_dump.c
@@ -20,8 +20,15 @@ unsigned long saved_max_pfn;
 unsigned long long elfcorehdr_addr = ELFCORE_ADDR_MAX;
 
 /*
+ * stores the size of elf header of crash image
+ */
+unsigned long long elfcorehdr_size;
+
+/*
  * elfcorehdr= specifies the location of elf core header stored by the crashed
  * kernel. This option will be passed by kexec loader to the capture kernel.
+ *
+ * Syntax: elfcorehdr=[size[KMG]@]offset[KMG]
  */
 static int __init setup_elfcorehdr(char *arg)
 {
@@ -29,6 +36,10 @@ static int __init setup_elfcorehdr(char
 	if (!arg)
 		return -EINVAL;
 	elfcorehdr_addr = memparse(arg, &end);
+	if (*end == '@') {
+		elfcorehdr_size = elfcorehdr_addr;
+		elfcorehdr_addr = memparse(end + 1, &end);
+	}
 	return end > arg ? 0 : -EINVAL;
 }
 early_param("elfcorehdr", setup_elfcorehdr);


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
