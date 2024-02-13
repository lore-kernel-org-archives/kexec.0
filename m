Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB878C48260
	for <kexec@archiver.kernel.org>; Tue, 13 Feb 2024 11:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nOjNFXw0dnVcqHQuFlm1soXw+3NAD4cjvPAOEXMpW2c=; b=K2iv4rmeGC0fhU
	iumkrmN1UzZgmua9L09Vla77GCZi7zcvOGvTfPG7nk6qM5mcd7TSnvBrYh+wcHmSzuMmg1I9qZ9OJ
	KBs1s6yloQFiZU3Ncqd99/FYqNr22T4JdySbIAJ4c+xZduu4G9s7xYSEG+DdJhSfdlMjY29SOZwIM
	ComMweU4jvnlxXEF9ruI43sfBUEb9j1uCetkwKwEkdu2pnR2OEjQnvJj5TWREwuk0cyU1huCOMxzk
	vTRO+UTf3WTSp+Jzi5oH4aPt/7szJ5787einZL9dLo8sOGmkoTxtN5tnZpoMvpTzLkQtW/0BLflej
	v3AWz7IxiBYiy2YTI4jA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZr1Q-000000091oV-28To;
	Tue, 13 Feb 2024 11:32:20 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZr1N-000000091mh-2PRO
	for kexec@lists.infradead.org;
	Tue, 13 Feb 2024 11:32:19 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41DAClhE021995;
	Tue, 13 Feb 2024 11:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=rkM0KIJapB2h/7qTUebxZGeQkiPn9ELVSgWzge8S9BU=;
 b=L/9GOEh83xmvz8N+Nzt/nH/0MrfN2gk06Uf47+BgHyZzUvx44PSUwRw8wBZAPObVhI7R
 ZBukjc7YgHTiRl3cK9OuUULDTiNfb0P4wiyVeeJ9LXvSBhPqm6lTyqTUZnFP4PWgKjl9
 kiM0KOrSdfBj6jL3r6MBfG+5jaNU8j9DdBbBlsv1iexzp56YGdRWgzQqCQovpg2+WFfy
 mrw2deo6Zq4aSjoILbvn1doHAE3hnirvMO8KP4sEW20WgFbnev9RWzWsDd6VNlZCmhfq
 sEXsSgPsuRz/gkqruoPKcU+Dbp/yMVyeTFDoRVyIk/0mWiXKV5yUQzXp8bTS9kZ2BmAx Zw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w86fk26g2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 11:32:09 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41DBPWJR024995;
	Tue, 13 Feb 2024 11:32:08 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w86fk26fr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 11:32:08 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41D8bk1n024877;
	Tue, 13 Feb 2024 11:32:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6mfp70xh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 11:32:08 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41DBW3F21704614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 11:32:05 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E6A12005A;
	Tue, 13 Feb 2024 11:32:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A70C320040;
	Tue, 13 Feb 2024 11:32:00 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.in.ibm.com (unknown [9.203.115.195])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Feb 2024 11:32:00 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Kexec-ml <kexec@lists.infradead.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH linux-next 3/3] powerpc/kdump: Split KEXEC_CORE and CRASH_DUMP dependency
Date: Tue, 13 Feb 2024 17:01:49 +0530
Message-ID: <20240213113150.1148276-4-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213113150.1148276-1-hbathini@linux.ibm.com>
References: <20240213113150.1148276-1-hbathini@linux.ibm.com>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XnpaRIX_fq62O_IMSELjFxaWvwGiI1Jg
X-Proofpoint-GUID: 5-9uYdjUIQbZoRUgCym30icrALlJ4NQs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_06,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0
 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130091
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240213_033217_825283_60DD2BD5 
X-CRM114-Status: GOOD (  26.50  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Remove CONFIG_CRASH_DUMP dependency on CONFIG_KEXEC. CONFIG_KEXEC_CORE
was used at places where CONFIG_CRASH_DUMP or CONFIG_CRASH_RESERVE was
appropriate. Replace with appropriate #ifdefs to support CONFIG_KEXEC
and !CONFIG_CRASH_DUMP configuration option. Also, make CONFIG_FA_DUMP
dependent on CONFIG_CRASH_DUMP to avoid unmet dependencies for FA_DUMP
with !CONFIG_KEXEC_CORE configuration option.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---
 arch/powerpc/Kconfig               |  9 +--
 arch/powerpc/include/asm/kexec.h   | 98 +++++++++++++++---------------
 arch/powerpc/kernel/prom.c         |  2 +-
 arch/powerpc/kernel/setup-common.c |  2 +-
 arch/powerpc/kernel/smp.c          |  4 +-
 arch/powerpc/kexec/Makefile        |  3 +-
 arch/powerpc/kexec/core.c          |  4 ++
 7 files changed, 60 insertions(+), 62 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 5cf8ad8d7e8e..e377deefa2dc 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -607,11 +607,6 @@ config PPC64_SUPPORTS_MEMORY_FAILURE
 config ARCH_SUPPORTS_KEXEC
 	def_bool PPC_BOOK3S || PPC_E500 || (44x && !SMP)
 
-config ARCH_SELECTS_KEXEC
-	def_bool y
-	depends on KEXEC
-	select CRASH_DUMP
-
 config ARCH_SUPPORTS_KEXEC_FILE
 	def_bool PPC64
 
@@ -622,7 +617,6 @@ config ARCH_SELECTS_KEXEC_FILE
 	def_bool y
 	depends on KEXEC_FILE
 	select KEXEC_ELF
-	select CRASH_DUMP
 	select HAVE_IMA_KEXEC if IMA
 
 config PPC64_BIG_ENDIAN_ELF_ABI_V2
@@ -694,8 +688,7 @@ config ARCH_SELECTS_CRASH_DUMP
 
 config FA_DUMP
 	bool "Firmware-assisted dump"
-	depends on PPC64 && (PPC_RTAS || PPC_POWERNV)
-	select CRASH_DUMP
+	depends on CRASH_DUMP && PPC64 && (PPC_RTAS || PPC_POWERNV)
 	help
 	  A robust mechanism to get reliable kernel crash dump with
 	  assistance from firmware. This approach does not use kexec,
diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index e1b43aa12175..fdb90e24dc74 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -55,59 +55,18 @@
 typedef void (*crash_shutdown_t)(void);
 
 #ifdef CONFIG_KEXEC_CORE
-
-/*
- * This function is responsible for capturing register states if coming
- * via panic or invoking dump using sysrq-trigger.
- */
-static inline void crash_setup_regs(struct pt_regs *newregs,
-					struct pt_regs *oldregs)
-{
-	if (oldregs)
-		memcpy(newregs, oldregs, sizeof(*newregs));
-	else
-		ppc_save_regs(newregs);
-}
+struct kimage;
+struct pt_regs;
 
 extern void kexec_smp_wait(void);	/* get and clear naca physid, wait for
 					  master to copy new code to 0 */
-extern int crashing_cpu;
-extern void crash_send_ipi(void (*crash_ipi_callback)(struct pt_regs *));
-extern void crash_ipi_callback(struct pt_regs *);
-extern int crash_wake_offline;
-
-struct kimage;
-struct pt_regs;
 extern void default_machine_kexec(struct kimage *image);
-extern void default_machine_crash_shutdown(struct pt_regs *regs);
-extern int crash_shutdown_register(crash_shutdown_t handler);
-extern int crash_shutdown_unregister(crash_shutdown_t handler);
-
-extern void crash_kexec_prepare(void);
-extern void crash_kexec_secondary(struct pt_regs *regs);
-int __init overlaps_crashkernel(unsigned long start, unsigned long size);
-extern void reserve_crashkernel(void);
 extern void machine_kexec_mask_interrupts(void);
 
-static inline bool kdump_in_progress(void)
-{
-	return crashing_cpu >= 0;
-}
-
 void relocate_new_kernel(unsigned long indirection_page, unsigned long reboot_code_buffer,
 			 unsigned long start_address) __noreturn;
-
 void kexec_copy_flush(struct kimage *image);
 
-#if defined(CONFIG_CRASH_DUMP)
-bool is_kdump_kernel(void);
-#define is_kdump_kernel			is_kdump_kernel
-#if defined(CONFIG_PPC_RTAS)
-void crash_free_reserved_phys_range(unsigned long begin, unsigned long end);
-#define crash_free_reserved_phys_range crash_free_reserved_phys_range
-#endif /* CONFIG_PPC_RTAS */
-#endif /* CONFIG_CRASH_DUMP */
-
 #ifdef CONFIG_KEXEC_FILE
 extern const struct kexec_file_ops kexec_elf64_ops;
 
@@ -152,15 +111,56 @@ int setup_new_fdt_ppc64(const struct kimage *image, void *fdt,
 
 #endif /* CONFIG_KEXEC_FILE */
 
-#else /* !CONFIG_KEXEC_CORE */
-static inline void crash_kexec_secondary(struct pt_regs *regs) { }
+#endif /* CONFIG_KEXEC_CORE */
+
+#ifdef CONFIG_CRASH_RESERVE
+int __init overlaps_crashkernel(unsigned long start, unsigned long size);
+extern void reserve_crashkernel(void);
+#else
+static inline void reserve_crashkernel(void) {}
+static inline int overlaps_crashkernel(unsigned long start, unsigned long size) { return 0; }
+#endif
 
-static inline int overlaps_crashkernel(unsigned long start, unsigned long size)
+#if defined(CONFIG_CRASH_DUMP)
+/*
+ * This function is responsible for capturing register states if coming
+ * via panic or invoking dump using sysrq-trigger.
+ */
+static inline void crash_setup_regs(struct pt_regs *newregs,
+					struct pt_regs *oldregs)
 {
-	return 0;
+	if (oldregs)
+		memcpy(newregs, oldregs, sizeof(*newregs));
+	else
+		ppc_save_regs(newregs);
+}
+
+extern int crashing_cpu;
+extern void crash_send_ipi(void (*crash_ipi_callback)(struct pt_regs *));
+extern void crash_ipi_callback(struct pt_regs *regs);
+extern int crash_wake_offline;
+
+extern int crash_shutdown_register(crash_shutdown_t handler);
+extern int crash_shutdown_unregister(crash_shutdown_t handler);
+extern void default_machine_crash_shutdown(struct pt_regs *regs);
+
+extern void crash_kexec_prepare(void);
+extern void crash_kexec_secondary(struct pt_regs *regs);
+
+static inline bool kdump_in_progress(void)
+{
+	return crashing_cpu >= 0;
 }
 
-static inline void reserve_crashkernel(void) { ; }
+bool is_kdump_kernel(void);
+#define is_kdump_kernel			is_kdump_kernel
+#if defined(CONFIG_PPC_RTAS)
+void crash_free_reserved_phys_range(unsigned long begin, unsigned long end);
+#define crash_free_reserved_phys_range crash_free_reserved_phys_range
+#endif /* CONFIG_PPC_RTAS */
+
+#else /* !CONFIG_CRASH_DUMP */
+static inline void crash_kexec_secondary(struct pt_regs *regs) { }
 
 static inline int crash_shutdown_register(crash_shutdown_t handler)
 {
@@ -183,7 +183,7 @@ static inline void crash_send_ipi(void (*crash_ipi_callback)(struct pt_regs *))
 {
 }
 
-#endif /* CONFIG_KEXEC_CORE */
+#endif /* CONFIG_CRASH_DUMP */
 
 #ifdef CONFIG_PPC_BOOK3S_64
 #include <asm/book3s/64/kexec.h>
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 0b5878c3125b..1edc34b711ba 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -453,7 +453,7 @@ static int __init early_init_dt_scan_chosen_ppc(unsigned long node,
 		tce_alloc_end = *lprop;
 #endif
 
-#ifdef CONFIG_KEXEC_CORE
+#ifdef CONFIG_CRASH_RESERVE
 	lprop = of_get_flat_dt_prop(node, "linux,crashkernel-base", NULL);
 	if (lprop)
 		crashk_res.start = *lprop;
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 733f210ffda1..35cac3eaaf75 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -109,7 +109,7 @@ int ppc_do_canonicalize_irqs;
 EXPORT_SYMBOL(ppc_do_canonicalize_irqs);
 #endif
 
-#ifdef CONFIG_VMCORE_INFO
+#ifdef CONFIG_CRASH_DUMP
 /* This keeps a track of which one is the crashing cpu. */
 int crashing_cpu = -1;
 #endif
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 693334c20d07..aa81c95c73a4 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -588,7 +588,7 @@ void smp_send_debugger_break(void)
 }
 #endif
 
-#ifdef CONFIG_KEXEC_CORE
+#ifdef CONFIG_CRASH_DUMP
 void crash_send_ipi(void (*crash_ipi_callback)(struct pt_regs *))
 {
 	int cpu;
@@ -631,7 +631,7 @@ void crash_smp_send_stop(void)
 
 	stopped = true;
 
-#ifdef CONFIG_KEXEC_CORE
+#ifdef CONFIG_CRASH_DUMP
 	if (kexec_crash_image) {
 		crash_kexec_prepare();
 		return;
diff --git a/arch/powerpc/kexec/Makefile b/arch/powerpc/kexec/Makefile
index 91e96f5168b7..8e469c4da3f8 100644
--- a/arch/powerpc/kexec/Makefile
+++ b/arch/powerpc/kexec/Makefile
@@ -3,12 +3,13 @@
 # Makefile for the linux kernel.
 #
 
-obj-y				+= core.o crash.o core_$(BITS).o
+obj-y				+= core.o core_$(BITS).o
 
 obj-$(CONFIG_PPC32)		+= relocate_32.o
 
 obj-$(CONFIG_KEXEC_FILE)	+= file_load.o ranges.o file_load_$(BITS).o elf_$(BITS).o
 obj-$(CONFIG_VMCORE_INFO)	+= vmcore_info.o
+obj-$(CONFIG_CRASH_DUMP)	+= crash.o
 
 # Disable GCOV, KCOV & sanitizers in odd or sensitive code
 GCOV_PROFILE_core_$(BITS).o := n
diff --git a/arch/powerpc/kexec/core.c b/arch/powerpc/kexec/core.c
index 3ff4411ed496..b8333a49ea5d 100644
--- a/arch/powerpc/kexec/core.c
+++ b/arch/powerpc/kexec/core.c
@@ -44,10 +44,12 @@ void machine_kexec_mask_interrupts(void) {
 	}
 }
 
+#ifdef CONFIG_CRASH_DUMP
 void machine_crash_shutdown(struct pt_regs *regs)
 {
 	default_machine_crash_shutdown(regs);
 }
+#endif
 
 void machine_kexec_cleanup(struct kimage *image)
 {
@@ -77,6 +79,7 @@ void machine_kexec(struct kimage *image)
 	for(;;);
 }
 
+#ifdef CONFIG_CRASH_RESERVE
 void __init reserve_crashkernel(void)
 {
 	unsigned long long crash_size, crash_base, total_mem_sz;
@@ -251,3 +254,4 @@ static int __init kexec_setup(void)
 	return 0;
 }
 late_initcall(kexec_setup);
+#endif /* CONFIG_CRASH_RESERVE */
-- 
2.43.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
