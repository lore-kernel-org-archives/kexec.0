Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e06smtp15.uk.ibm.com ([195.75.94.111])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RkwO2-0006qk-TH
 for kexec@lists.infradead.org; Wed, 11 Jan 2012 11:30:36 +0000
Received: from /spool/local
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Wed, 11 Jan 2012 11:30:16 -0000
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q0BBUDLT2101302
 for <kexec@lists.infradead.org>; Wed, 11 Jan 2012 11:30:13 GMT
Received: from d06av11.portsmouth.uk.ibm.com (loopback [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q0BBUDpq031941
 for <kexec@lists.infradead.org>; Wed, 11 Jan 2012 04:30:13 -0700
Message-ID: <1326281412.2819.3.camel@br98xy6r>
Subject: [PATCH] kdump: Define KEXEC_NOTE_BYTES arch specific for s390x
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Date: Wed, 11 Jan 2012 12:30:12 +0100
Mime-Version: 1.0
Reply-To: holzheu@linux.vnet.ibm.com
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: akpm@linux-foundation.org
Cc: linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, schwidefsky@de.ibm.com, Vivek Goyal <vgoyal@redhat.com>

From: Michael Holzheu <holzheu@linux.vnet.ibm.com>

kdump only allocates memory for the prstatus ELF note. For s390x,
besides of prstatus multiple ELF notes for various different register
types are stored. Therefore the currently allocated memory is not
sufficient. With this patch the KEXEC_NOTE_BYTES macro can be
defined by architecture code and for s390x it is set to the correct
size now.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 arch/s390/include/asm/kexec.h |   18 ++++++++++++++++++
 include/linux/kexec.h         |    2 ++
 2 files changed, 20 insertions(+)

--- a/arch/s390/include/asm/kexec.h
+++ b/arch/s390/include/asm/kexec.h
@@ -42,6 +42,24 @@
 /* The native architecture */
 #define KEXEC_ARCH KEXEC_ARCH_S390
 
+/*
+ * Size for s390x ELF notes per CPU
+ *
+ * Seven notes plus zero note at the end: prstatus, fpregset, timer,
+ * tod_cmp, tod_reg, control regs, and prefix
+ */
+#define KEXEC_NOTE_BYTES \
+	(ALIGN(sizeof(struct elf_note), 4) * 8 + \
+	 ALIGN(sizeof("CORE"), 4) * 7 + \
+	 ALIGN(sizeof(struct elf_prstatus), 4) + \
+	 ALIGN(sizeof(elf_fpregset_t), 4) + \
+	 ALIGN(sizeof(u64), 4) + \
+	 ALIGN(sizeof(u64), 4) + \
+	 ALIGN(sizeof(u32), 4) + \
+	 ALIGN(sizeof(u64) * 16, 4) + \
+	 ALIGN(sizeof(u32), 4) \
+	)
+
 /* Provide a dummy definition to avoid build failures. */
 static inline void crash_setup_regs(struct pt_regs *newregs,
 					struct pt_regs *oldregs) { }
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -50,9 +50,11 @@
  * note header.  For kdump, the code in vmcore.c runs in the context
  * of the second kernel to combine them into one note.
  */
+#ifndef KEXEC_NOTE_BYTES
 #define KEXEC_NOTE_BYTES ( (KEXEC_NOTE_HEAD_BYTES * 2) +		\
 			    KEXEC_CORE_NOTE_NAME_BYTES +		\
 			    KEXEC_CORE_NOTE_DESC_BYTES )
+#endif
 
 /*
  * This structure is used to hold the arguments that are used when loading



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
