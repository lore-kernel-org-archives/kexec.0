Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate1.uk.ibm.com ([194.196.100.161])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1R61PD-00074v-Q0
	for kexec@lists.infradead.org; Tue, 20 Sep 2011 14:34:40 +0000
Received: from d06nrmr1507.portsmouth.uk.ibm.com
	(d06nrmr1507.portsmouth.uk.ibm.com [9.149.38.233])
	by mtagate1.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p8KEYbrV022256
	for <kexec@lists.infradead.org>; Tue, 20 Sep 2011 14:34:37 GMT
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
	[9.149.37.248])
	by d06nrmr1507.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p8KEYbsM2605192
	for <kexec@lists.infradead.org>; Tue, 20 Sep 2011 15:34:37 +0100
Received: from d06av07.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av07.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p8KEYaMZ004234
	for <kexec@lists.infradead.org>; Tue, 20 Sep 2011 08:34:37 -0600
Message-Id: <20110920143436.224880681@linux.vnet.ibm.com>
Date: Tue, 20 Sep 2011 16:34:02 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: [patch 2/2] s390: Export vmcoreinfo note
References: <20110920143400.776127689@linux.vnet.ibm.com>
Content-Disposition: inline; filename=s390-kdump-arch-vmcoreinfo.patch
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
To: akpm@linux-foundation.org
Cc: linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, ebiederm@xmission.com, schwidefsky@de.ibm.com, kexec@lists.infradead.org, vgoyal@redhat.com

From: Michael Holzheu <holzheu@linux.vnet.ibm.com>

This patch defines for s390 an ABI defined pointer to the vmcoreinfo note at
a well known address. With this patch tools are able to find this information
in dumps created by stand-alone or hypervisor dump tools.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 arch/s390/include/asm/lowcore.h |    3 ++-
 arch/s390/kernel/setup.c        |    8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

--- a/arch/s390/include/asm/lowcore.h
+++ b/arch/s390/include/asm/lowcore.h
@@ -287,7 +287,8 @@ struct _lowcore {
 	 */
 	__u64	ipib;				/* 0x0e00 */
 	__u32	ipib_checksum;			/* 0x0e08 */
-	__u8	pad_0x0e0c[0x0f00-0x0e0c];	/* 0x0e0c */
+	__u64	vmcore_info;			/* 0x0e0c */
+	__u8	pad_0x0e14[0x0f00-0x0e14];	/* 0x0e14 */
 
 	/* Extended facility list */
 	__u64	stfle_fac_list[32];		/* 0x0f00 */
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -559,6 +559,13 @@ static void __init setup_restart_psw(voi
 	copy_to_absolute_zero(&S390_lowcore.restart_psw, &psw, sizeof(psw));
 }
 
+static void __init setup_vmcoreinfo(void)
+{
+	unsigned long ptr = paddr_vmcoreinfo_note();
+
+	copy_to_absolute_zero(&S390_lowcore.vmcore_info, &ptr, sizeof(ptr));
+}
+
 #ifdef CONFIG_CRASH_DUMP
 
 /*
@@ -1019,6 +1026,7 @@ setup_arch(char **cmdline_p)
 	reserve_crashkernel();
 	setup_memory();
 	setup_resources();
+	setup_vmcoreinfo();
 	setup_restart_psw();
 	setup_lowcore();
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
