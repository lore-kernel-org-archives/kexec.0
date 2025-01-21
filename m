Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 587FAC0218B
	for <kexec@archiver.kernel.org>; Tue, 21 Jan 2025 11:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y3og00CYYUHHhfJdoglwsSlB8Uwxf5EtrD39C7pdlnQ=; b=iycN4PXvf1P4h4CRE09Ng0EGkt
	sH15rLUvJHzSQ4AH9dcQbq43TaIHWE1X8Or8NUfY5EID7CfO9J7BY0fXB+8dDw/nUVJ1M6KXyu6a7
	0AGPJbxaZJjTmGaJxlA24AwgunrGKgW0S8/IJaNoy8ANGGdDn3FH2yjLQD4FKNpmKIYahLcL5MBPJ
	3qwXTsnJY4ueq+ntbcOsg5DxlLyIk21CQrVT0sUzjUItk8SwXWyBfwq837AIl4GHsErl2QdQt99ZN
	0nDS8+ar51+qsa46aPjGjNU+3WME1bTxEI9wchb6SgAH4zxQmFhmFq23Cr7w0P+ym0ixeVfBmySxN
	+OOwI0iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1taCqq-00000007nVJ-0NjK;
	Tue, 21 Jan 2025 11:55:24 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1taCqn-00000007nT1-3RzM
	for kexec@lists.infradead.org;
	Tue, 21 Jan 2025 11:55:23 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50L762R8014707;
	Tue, 21 Jan 2025 11:55:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Y3og00CYYUHHhfJdo
	glwsSlB8Uwxf5EtrD39C7pdlnQ=; b=joWyVAIT5rn+FpAfvM7ls4VP8SmrG6MYs
	FckqYA3pYrknhmcf3sFgQp+ehn7QDgDwQUDB0WoJ3/m7HQPGTL3d+uHVMcoKOeet
	qjb76CYisAwxnakhafOp7/hUf1hJjgJI7zyNcncxrILnzorlHMJuoTgcatncEI+v
	cD+an+U8HzLpcEMi+34RUdInn91Nvn1hJhfsO0gA99hX3fQyDTVX6Pq7aIrAihC6
	Fe8r8LPfxQ/6Kvf7GlPjK3Bie1xx01Oy66uFrRZdAl2fGZ6T5uX+xvtYc8xQH28Y
	B2FYrFPaowQmwROSj46BDfsAObjxwRvzbzgBteqvgkLzXETEXhM6w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 449sat48hx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 11:55:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50LA4d7Q029610;
	Tue, 21 Jan 2025 11:55:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448qmnayqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 11:55:12 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50LBt8GL17367538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jan 2025 11:55:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F4262004B;
	Tue, 21 Jan 2025 11:55:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A44D620040;
	Tue, 21 Jan 2025 11:55:05 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.ibm.com.com (unknown [9.43.54.128])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Jan 2025 11:55:05 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, Baoquan he <bhe@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mahesh Salgaonkar <mahesh@linux.ibm.com>
Subject: [PATCH v2 5/6] powerpc/crash: use generic crashkernel reservation
Date: Tue, 21 Jan 2025 17:24:41 +0530
Message-ID: <20250121115442.1278458-6-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121115442.1278458-1-sourabhjain@linux.ibm.com>
References: <20250121115442.1278458-1-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SKkDRHO4VECGhv8jfzoCgzQgm2zsGkHk
X-Proofpoint-ORIG-GUID: SKkDRHO4VECGhv8jfzoCgzQgm2zsGkHk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_05,2025-01-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501210095
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250121_035521_987449_CF6967C7 
X-CRM114-Status: GOOD (  31.28  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Commit 0ab97169aa05 ("crash_core: add generic function to do
reservation") added a generic function to reserve crashkernel memory.
So let's use the same function on powerpc and remove the
architecture-specific code that essentially does the same thing.

The generic crashkernel reservation also provides a way to split the
crashkernel reservation into high and low memory reservations, which can
be enabled for powerpc in the future.

Along with moving to the generic crashkernel reservation, the code
related to finding the base address for the crashkernel has been
separated into its own function name get_crash_base() for better
readability and maintainability.

To prevent crashkernel memory from being added to iomem_resource, the
function arch_add_crash_res_to_iomem() has been introduced. For further
details on why this should not be done for the PowerPC architecture,
please refer to the previous commit titled "crash: let arch decide crash
memory export to iomem_resource.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan he <bhe@redhat.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>
CC: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/Kconfig                     |  3 +
 arch/powerpc/include/asm/crash_reserve.h | 18 +++++
 arch/powerpc/include/asm/kexec.h         |  4 +-
 arch/powerpc/kernel/prom.c               |  2 +-
 arch/powerpc/kexec/core.c                | 90 ++++++++++--------------
 5 files changed, 63 insertions(+), 54 deletions(-)
 create mode 100644 arch/powerpc/include/asm/crash_reserve.h

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index db9f7b2d07bf..880d35fadf40 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -718,6 +718,9 @@ config ARCH_SUPPORTS_CRASH_HOTPLUG
 	def_bool y
 	depends on PPC64
 
+config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
+	def_bool CRASH_RESERVE
+
 config FA_DUMP
 	bool "Firmware-assisted dump"
 	depends on CRASH_DUMP && PPC64 && (PPC_RTAS || PPC_POWERNV)
diff --git a/arch/powerpc/include/asm/crash_reserve.h b/arch/powerpc/include/asm/crash_reserve.h
new file mode 100644
index 000000000000..f5e60721de41
--- /dev/null
+++ b/arch/powerpc/include/asm/crash_reserve.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_POWERPC_CRASH_RESERVE_H
+#define _ASM_POWERPC_CRASH_RESERVE_H
+
+/* crash kernel regions are Page size agliged */
+#define CRASH_ALIGN             PAGE_SIZE
+
+#ifdef CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
+
+static inline bool arch_add_crash_res_to_iomem(void)
+{
+	return false;
+}
+#define arch_add_crash_res_to_iomem arch_add_crash_res_to_iomem
+#endif
+
+#endif /* _ASM_POWERPC_CRASH_RESERVE_H */
+
diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index 270ee93a0f7d..64741558071f 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -113,9 +113,9 @@ int setup_new_fdt_ppc64(const struct kimage *image, void *fdt, struct crash_mem
 
 #ifdef CONFIG_CRASH_RESERVE
 int __init overlaps_crashkernel(unsigned long start, unsigned long size);
-extern void reserve_crashkernel(void);
+extern void arch_reserve_crashkernel(void);
 #else
-static inline void reserve_crashkernel(void) {}
+static inline void arch_reserve_crashkernel(void) {}
 static inline int overlaps_crashkernel(unsigned long start, unsigned long size) { return 0; }
 #endif
 
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index e0059842a1c6..9ed9dde7d231 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -860,7 +860,7 @@ void __init early_init_devtree(void *params)
 	 */
 	if (fadump_reserve_mem() == 0)
 #endif
-		reserve_crashkernel();
+		arch_reserve_crashkernel();
 	early_reserve_mem();
 
 	if (memory_limit > memblock_phys_mem_size())
diff --git a/arch/powerpc/kexec/core.c b/arch/powerpc/kexec/core.c
index 4945b33322ae..b21cfa814492 100644
--- a/arch/powerpc/kexec/core.c
+++ b/arch/powerpc/kexec/core.c
@@ -80,38 +80,20 @@ void machine_kexec(struct kimage *image)
 }
 
 #ifdef CONFIG_CRASH_RESERVE
-void __init reserve_crashkernel(void)
-{
-	unsigned long long crash_size, crash_base, total_mem_sz;
-	int ret;
 
-	total_mem_sz = memory_limit ? memory_limit : memblock_phys_mem_size();
-	/* use common parsing */
-	ret = parse_crashkernel(boot_command_line, total_mem_sz,
-			&crash_size, &crash_base, NULL, NULL);
-	if (ret == 0 && crash_size > 0) {
-		crashk_res.start = crash_base;
-		crashk_res.end = crash_base + crash_size - 1;
-	}
-
-	if (crashk_res.end == crashk_res.start) {
-		crashk_res.start = crashk_res.end = 0;
-		return;
-	}
-
-	/* We might have got these values via the command line or the
-	 * device tree, either way sanitise them now. */
-
-	crash_size = resource_size(&crashk_res);
+static unsigned long long __init get_crash_base(unsigned long long crash_base)
+{
 
 #ifndef CONFIG_NONSTATIC_KERNEL
-	if (crashk_res.start != KDUMP_KERNELBASE)
+	if (crash_base != KDUMP_KERNELBASE)
 		printk("Crash kernel location must be 0x%x\n",
 				KDUMP_KERNELBASE);
 
-	crashk_res.start = KDUMP_KERNELBASE;
+	return KDUMP_KERNELBASE;
 #else
-	if (!crashk_res.start) {
+	unsigned long long crash_base_align;
+
+	if (!crash_base) {
 #ifdef CONFIG_PPC64
 		/*
 		 * On the LPAR platform place the crash kernel to mid of
@@ -123,45 +105,51 @@ void __init reserve_crashkernel(void)
 		 * kernel starts at 128MB offset on other platforms.
 		 */
 		if (firmware_has_feature(FW_FEATURE_LPAR))
-			crashk_res.start = min_t(u64, ppc64_rma_size / 2, SZ_512M);
+			crash_base = min_t(u64, ppc64_rma_size / 2, SZ_512M);
 		else
-			crashk_res.start = min_t(u64, ppc64_rma_size / 2, SZ_128M);
+			crash_base = min_t(u64, ppc64_rma_size / 2, SZ_128M);
 #else
-		crashk_res.start = KDUMP_KERNELBASE;
+		crash_base = KDUMP_KERNELBASE;
 #endif
 	}
 
-	crash_base = PAGE_ALIGN(crashk_res.start);
-	if (crash_base != crashk_res.start) {
-		printk("Crash kernel base must be aligned to 0x%lx\n",
-				PAGE_SIZE);
-		crashk_res.start = crash_base;
-	}
+	crash_base_align = PAGE_ALIGN(crash_base);
+	if (crash_base != crash_base_align)
+		pr_warn("Crash kernel base must be aligned to 0x%lx\n", PAGE_SIZE);
 
+	return crash_base_align;
 #endif
-	crash_size = PAGE_ALIGN(crash_size);
-	crashk_res.end = crashk_res.start + crash_size - 1;
+}
 
-	/* The crash region must not overlap the current kernel */
-	if (overlaps_crashkernel(__pa(_stext), _end - _stext)) {
-		printk(KERN_WARNING
-			"Crash kernel can not overlap current kernel\n");
-		crashk_res.start = crashk_res.end = 0;
+void __init arch_reserve_crashkernel(void)
+{
+	unsigned long long crash_size, crash_base, crash_end;
+	unsigned long long kernel_start, kernel_size;
+	unsigned long long total_mem_sz;
+	int ret;
+
+	total_mem_sz = memory_limit ? memory_limit : memblock_phys_mem_size();
+
+	/* use common parsing */
+	ret = parse_crashkernel(boot_command_line, total_mem_sz, &crash_size,
+				&crash_base, NULL, NULL);
+
+	if (ret)
 		return;
-	}
 
-	printk(KERN_INFO "Reserving %ldMB of memory at %ldMB "
-			"for crashkernel (System RAM: %ldMB)\n",
-			(unsigned long)(crash_size >> 20),
-			(unsigned long)(crashk_res.start >> 20),
-			(unsigned long)(total_mem_sz >> 20));
+	crash_base = get_crash_base(crash_base);
+	crash_end = crash_base + crash_size - 1;
 
-	if (!memblock_is_region_memory(crashk_res.start, crash_size) ||
-	    memblock_reserve(crashk_res.start, crash_size)) {
-		pr_err("Failed to reserve memory for crashkernel!\n");
-		crashk_res.start = crashk_res.end = 0;
+	kernel_start = __pa(_stext);
+	kernel_size = _end - _stext;
+
+	/* The crash region must not overlap the current kernel */
+	if ((kernel_start + kernel_size > crash_base) && (kernel_start <= crash_end)) {
+		pr_warn("Crash kernel can not overlap current kernel\n");
 		return;
 	}
+
+	reserve_crashkernel_generic(crash_size, crash_base, 0, false);
 }
 
 int __init overlaps_crashkernel(unsigned long start, unsigned long size)
-- 
2.47.1


