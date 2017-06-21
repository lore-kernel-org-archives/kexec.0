Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dNjgX-0001qn-Od
 for kexec@lists.infradead.org; Wed, 21 Jun 2017 17:44:59 +0000
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5LHhmpL114166
 for <kexec@lists.infradead.org>; Wed, 21 Jun 2017 13:44:33 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b7qcm45s9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 21 Jun 2017 13:44:33 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Wed, 21 Jun 2017 18:44:30 +0100
Date: Wed, 21 Jun 2017 19:44:23 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH] s390/crash: Fix KEXEC_NOTE_BYTES definition
In-Reply-To: <1496974625-10891-1-git-send-email-xlpang@redhat.com>
References: <1496974625-10891-1-git-send-email-xlpang@redhat.com>
MIME-Version: 1.0
Message-Id: <20170621194423.2d0318d7@TP-holzheu>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Xunlei Pang <xlpang@redhat.com>
Cc: linux-s390@vger.kernel.org, Baoquan He <bhe@redhat.com>, Gustavo Luiz Duarte <gustavold@linux.vnet.ibm.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Dave Anderson <anderson@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Hari Bathini <hbathini@linux.vnet.ibm.com>, Mikhail Zaslonko <zaslonko@linux.vnet.ibm.com>, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>

Am Fri,  9 Jun 2017 10:17:05 +0800
schrieb Xunlei Pang <xlpang@redhat.com>:

> S390 KEXEC_NOTE_BYTES is not used by note_buf_t as before, which
> is now defined as follows:
>     typedef u32 note_buf_t[CRASH_CORE_NOTE_BYTES/4];
> It was changed by the CONFIG_CRASH_CORE feature.
> 
> This patch gets rid of all the old KEXEC_NOTE_BYTES stuff, and
> renames KEXEC_NOTE_BYTES to CRASH_CORE_NOTE_BYTES for S390.
> 
> Fixes: 692f66f26a4c ("crash: move crashkernel parsing and vmcore related code under CONFIG_CRASH_CORE")
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Dave Anderson <anderson@redhat.com>
> Cc: Hari Bathini <hbathini@linux.vnet.ibm.com>
> Cc: Gustavo Luiz Duarte <gustavold@linux.vnet.ibm.com>
> Signed-off-by: Xunlei Pang <xlpang@redhat.com>

Hello Xunlei,

As you already know on s390 we create the ELF header in the new kernel.
Therefore we don't use the per-cpu buffers for ELF notes to store
the register state.

For RHEL7 we still store the registers in machine_kexec.c:add_elf_notes().
Though we also use the ELF header from new kernel ...

We assume your original problem with the "kmem -s" failure
was caused by the memory overwrite due to the invalid size of the
"crash_notes" per-cpu buffers.

Therefore your patch looks good for RHEL7 but for upstream we propose the
patch below.
---
[PATCH] s390/crash: Remove unused KEXEC_NOTE_BYTES

After commmit 692f66f26a4c19 ("crash: move crashkernel parsing and vmcore
related code under CONFIG_CRASH_CORE") the KEXEC_NOTE_BYTES macro is not
used anymore and for s390 we create the ELF header in the new kernel
anyway. Therefore remove the macro.

Reported-by: Xunlei Pang <xpang@redhat.com>
Reviewed-by: Mikhail Zaslonko <zaslonko@linux.vnet.ibm.com>
Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
---
 arch/s390/include/asm/kexec.h | 18 ------------------
 include/linux/crash_core.h    |  5 +++++
 include/linux/kexec.h         |  9 ---------
 3 files changed, 5 insertions(+), 27 deletions(-)

diff --git a/arch/s390/include/asm/kexec.h b/arch/s390/include/asm/kexec.h
index 2f924bc30e35..dccf24ee26d3 100644
--- a/arch/s390/include/asm/kexec.h
+++ b/arch/s390/include/asm/kexec.h
@@ -41,24 +41,6 @@
 /* The native architecture */
 #define KEXEC_ARCH KEXEC_ARCH_S390
 
-/*
- * Size for s390x ELF notes per CPU
- *
- * Seven notes plus zero note at the end: prstatus, fpregset, timer,
- * tod_cmp, tod_reg, control regs, and prefix
- */
-#define KEXEC_NOTE_BYTES \
-	(ALIGN(sizeof(struct elf_note), 4) * 8 + \
-	 ALIGN(sizeof("CORE"), 4) * 7 + \
-	 ALIGN(sizeof(struct elf_prstatus), 4) + \
-	 ALIGN(sizeof(elf_fpregset_t), 4) + \
-	 ALIGN(sizeof(u64), 4) + \
-	 ALIGN(sizeof(u64), 4) + \
-	 ALIGN(sizeof(u32), 4) + \
-	 ALIGN(sizeof(u64) * 16, 4) + \
-	 ALIGN(sizeof(u32), 4) \
-	)
-
 /* Provide a dummy definition to avoid build failures. */
 static inline void crash_setup_regs(struct pt_regs *newregs,
 					struct pt_regs *oldregs) { }
diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index 541a197ba4a2..4090a42578a8 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -10,6 +10,11 @@
 #define CRASH_CORE_NOTE_NAME_BYTES ALIGN(sizeof(CRASH_CORE_NOTE_NAME), 4)
 #define CRASH_CORE_NOTE_DESC_BYTES ALIGN(sizeof(struct elf_prstatus), 4)
 
+/*
+ * The per-cpu notes area is a list of notes terminated by a "NULL"
+ * note header.  For kdump, the code in vmcore.c runs in the context
+ * of the second kernel to combine them into one note.
+ */
 #define CRASH_CORE_NOTE_BYTES	   ((CRASH_CORE_NOTE_HEAD_BYTES * 2) +	\
 				     CRASH_CORE_NOTE_NAME_BYTES +	\
 				     CRASH_CORE_NOTE_DESC_BYTES)
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index c9481ebcbc0c..65888418fb69 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -63,15 +63,6 @@
 #define KEXEC_CORE_NOTE_NAME	CRASH_CORE_NOTE_NAME
 
 /*
- * The per-cpu notes area is a list of notes terminated by a "NULL"
- * note header.  For kdump, the code in vmcore.c runs in the context
- * of the second kernel to combine them into one note.
- */
-#ifndef KEXEC_NOTE_BYTES
-#define KEXEC_NOTE_BYTES	CRASH_CORE_NOTE_BYTES
-#endif
-
-/*
  * This structure is used to hold the arguments that are used when loading
  * kernel binaries.
  */
-- 
2.11.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
