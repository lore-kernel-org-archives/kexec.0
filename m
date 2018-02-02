Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.89 #1 (Red Hat Linux))
 id 1ehb4J-0007su-3f
 for kexec@lists.infradead.org; Fri, 02 Feb 2018 13:08:00 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w12D5lJD015397
 for <kexec@lists.infradead.org>; Fri, 2 Feb 2018 08:07:41 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2fvqq2jfnr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 02 Feb 2018 08:07:40 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <prudo@linux.vnet.ibm.com>;
 Fri, 2 Feb 2018 13:07:39 -0000
From: Philipp Rudo <prudo@linux.vnet.ibm.com>
Subject: [PATCH 12/17] s390/kexec_file: Prepare setup.h for kexec_file_load
Date: Fri,  2 Feb 2018 14:07:13 +0100
In-Reply-To: <20180202130718.35509-1-prudo@linux.vnet.ibm.com>
References: <20180202130718.35509-1-prudo@linux.vnet.ibm.com>
Message-Id: <20180202130718.35509-13-prudo@linux.vnet.ibm.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org, linux-s390@vger.kernel.org
Cc: prudo@linux.vnet.ibm.com, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Eric Biederman <ebiederm@xmission.com>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Vivek Goyal <vgoyal@redhat.com>

kexec_file_load needs to prepare the new kernels before they are loaded.
For that it has to know the offsets in head.S, e.g. to register the new
command line. Unfortunately there are no macros right now defining those
offsets. Define them now.

Signed-off-by: Philipp Rudo <prudo@linux.vnet.ibm.com>
---
 arch/s390/include/asm/setup.h | 40 +++++++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/arch/s390/include/asm/setup.h b/arch/s390/include/asm/setup.h
index 2eb0c8a7b664..75b354e774eb 100644
--- a/arch/s390/include/asm/setup.h
+++ b/arch/s390/include/asm/setup.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  *  S390 version
- *    Copyright IBM Corp. 1999, 2010
+ *    Copyright IBM Corp. 1999, 2017
  */
 #ifndef _ASM_S390_SETUP_H
 #define _ASM_S390_SETUP_H
@@ -38,17 +38,31 @@
 #define LPP_MAGIC		_BITUL(31)
 #define LPP_PID_MASK		_AC(0xffffffff, UL)
 
+/* Offsets to entry points in kernel/head.S  */
+
+#define STARTUP_NORMAL_OFFSET	0x10000
+#define STARTUP_KDUMP_OFFSET	0x10010
+
+/* Offsets to parameters in kernel/head.S  */
+
+#define IPL_DEVICE_OFFSET	0x10400
+#define INITRD_START_OFFSET	0x10408
+#define INITRD_SIZE_OFFSET	0x10410
+#define OLDMEM_BASE_OFFSET	0x10418
+#define OLDMEM_SIZE_OFFSET	0x10420
+#define COMMAND_LINE_OFFSET	0x10480
+
 #ifndef __ASSEMBLY__
 
 #include <asm/lowcore.h>
 #include <asm/types.h>
 
-#define IPL_DEVICE        (*(unsigned long *)  (0x10400))
-#define INITRD_START      (*(unsigned long *)  (0x10408))
-#define INITRD_SIZE       (*(unsigned long *)  (0x10410))
-#define OLDMEM_BASE	  (*(unsigned long *)  (0x10418))
-#define OLDMEM_SIZE	  (*(unsigned long *)  (0x10420))
-#define COMMAND_LINE      ((char *)            (0x10480))
+#define IPL_DEVICE	(*(unsigned long *)  (IPL_DEVICE_OFFSET))
+#define INITRD_START	(*(unsigned long *)  (INITRD_START_OFFSET))
+#define INITRD_SIZE	(*(unsigned long *)  (INITRD_SIZE_OFFSET))
+#define OLDMEM_BASE	(*(unsigned long *)  (OLDMEM_BASE_OFFSET))
+#define OLDMEM_SIZE	(*(unsigned long *)  (OLDMEM_SIZE_OFFSET))
+#define COMMAND_LINE	((char *)	     (COMMAND_LINE_OFFSET))
 
 extern int memory_end_set;
 extern unsigned long memory_end;
@@ -123,12 +137,12 @@ extern void (*_machine_power_off)(void);
 
 #else /* __ASSEMBLY__ */
 
-#define IPL_DEVICE        0x10400
-#define INITRD_START      0x10408
-#define INITRD_SIZE       0x10410
-#define OLDMEM_BASE	  0x10418
-#define OLDMEM_SIZE	  0x10420
-#define COMMAND_LINE      0x10480
+#define IPL_DEVICE	(IPL_DEVICE_OFFSET)
+#define INITRD_START	(INITRD_START_OFFSET)
+#define INITRD_SIZE	(INITRD_SIZE_OFFSET)
+#define OLDMEM_BASE	(OLDMEM_BASE_OFFSET)
+#define OLDMEM_SIZE	(OLDMEM_SIZE_OFFSET)
+#define COMMAND_LINE	(COMMAND_LINE_OFFSET)
 
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_S390_SETUP_H */
-- 
2.13.5


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
