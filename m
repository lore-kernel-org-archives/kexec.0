Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D55C3271E
	for <kexec@archiver.kernel.org>; Mon,  8 Jul 2024 13:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=n4EtD77eaKTh6N07QYE1A1PMXVp6p41aTximO2kbpLg=; b=yJAB6sCFqtWwoi
	H53ccEZ7EPTP61u2Fz9nrPoqYu10gE0LGRuG39egmhst59+Nt307T9ayRywN+noEl8a5Ii6ccFXBu
	66R1AuhRzWb7bxlArKQ9cISNPZkcbZmvI1/GBq7thnjYxwhTkSUQFO7+9kM2qZqDbM9+tBDR6uGmb
	UfZoFXwNa8WD/CZTKHoARm+3gBg6eVoMU309t6TdgmB/c8ntf3xrvwV+McZtwePR/bhtHj+xayc6e
	p/24ujvm+FnQGEK1M5kVfYIpCVahGtjLfHBtYoQ2qcgUU3OolAuPEsUFI2Zuw3R84XdU0aSrPr7BO
	BQEN6Hjwhrw4FQZ7pS0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQoRk-00000003uth-1Xln;
	Mon, 08 Jul 2024 13:30:24 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQoRG-00000003ugd-0oz1;
	Mon, 08 Jul 2024 13:29:57 +0000
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WHlHm4ZpBzQktx;
	Mon,  8 Jul 2024 21:25:56 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 5CB6B14022D;
	Mon,  8 Jul 2024 21:29:50 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 8 Jul
 2024 21:29:49 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <linux@armlinux.org.uk>, <bhe@redhat.com>, <vgoyal@redhat.com>,
	<dyoung@redhat.com>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <arnd@arndb.de>, <afd@ti.com>,
	<akpm@linux-foundation.org>, <rmk+kernel@armlinux.org.uk>,
	<linus.walleij@linaro.org>, <eric.devolder@oracle.com>,
	<gregkh@linuxfoundation.org>, <deller@gmx.de>, <javierm@redhat.com>,
	<robh@kernel.org>, <thunder.leizhen@huawei.com>, <austindh.kim@gmail.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kexec@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH 3/3] ARM: Use generic interface to simplify crashkernel reservation
Date: Mon, 8 Jul 2024 21:33:48 +0800
Message-ID: <20240708133348.3592667-4-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240708133348.3592667-1-ruanjinjie@huawei.com>
References: <20240708133348.3592667-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi100008.china.huawei.com (7.221.188.57)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240708_062954_637860_E6C6A090 
X-CRM114-Status: GOOD (  21.02  )
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

Currently, x86, arm64, riscv and loongarch has been switched to generic
crashkernel reservation. With the help of function parse_crashkernel()
and generic reserve_crashkernel_generic(), arm32 crashkernel reservation
can also be simplified by steps:

1) Add a new header file <asm/crash_reserve.h>, and define CRASH_ALIGN,
   CRASH_ADDR_LOW_MAX, CRASH_ADDR_HIGH_MAX in it;

2) Add arch_reserve_crashkernel() to call parse_crashkernel() and
   reserve_crashkernel_generic();

3) Add ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION Kconfig in
   arch/arm/Kconfig.

The old reserve_crashkernel() can be removed.

Following test cases have been performed as expected on QEMU vexpress-a9
(1GB system memory):

1) crashkernel=4G,high				// invalid
2) crashkernel=1G,high				// invalid
3) crashkernel=1G,high crashkernel=0M,low	// invalid
4) crashkernel=256M,high			// invalid
5) crashkernel=256M,low				// invalid
6) crashkernel=256M crashkernel=256M,high	// high is ignored, ok
7) crashkernel=256M crashkernel=256M,low	// low is ignored, ok
8) crashkernel=256M,high crashkernel=256M,low	// invalid
9) crashkernel=256M,high crashkernel=4G,low	// invalid
10) crashkernel=256M				// ok
11) crashkernel=512M				// ok
12) crashkernel=256M@0x88000000			// ok
13) crashkernel=256M@0x78000000			// ok
14) crashkernel=512M@0x78000000			// ok

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm/Kconfig                     |  3 ++
 arch/arm/include/asm/crash_reserve.h | 24 +++++++++++
 arch/arm/kernel/setup.c              | 62 ++++------------------------
 3 files changed, 36 insertions(+), 53 deletions(-)
 create mode 100644 arch/arm/include/asm/crash_reserve.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 68990e1645d5..02e620e185c0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1596,6 +1596,9 @@ config ATAGS_PROC
 config ARCH_SUPPORTS_CRASH_DUMP
 	def_bool y
 
+config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
+	def_bool CRASH_RESERVE
+
 config AUTO_ZRELADDR
 	bool "Auto calculation of the decompressed kernel image address" if !ARCH_MULTIPLATFORM
 	default !(ARCH_FOOTBRIDGE || ARCH_RPC || ARCH_SA1100)
diff --git a/arch/arm/include/asm/crash_reserve.h b/arch/arm/include/asm/crash_reserve.h
new file mode 100644
index 000000000000..85c9298bd3b7
--- /dev/null
+++ b/arch/arm/include/asm/crash_reserve.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ARM_CRASH_RESERVE_H
+#define _ARM_CRASH_RESERVE_H
+
+/*
+ * The crash region must be aligned to 128MB to avoid
+ * zImage relocating below the reserved region.
+ */
+#define CRASH_ALIGN			(128 << 20)
+
+#define CRASH_ADDR_LOW_MAX		crash_addr_low_max()
+#define CRASH_ADDR_HIGH_MAX		memblock_end_of_DRAM()
+
+static inline unsigned long crash_addr_low_max(void)
+{
+	unsigned long long crash_max = idmap_to_phys((u32)~0);
+	unsigned long long lowmem_max = __pa(high_memory - 1) + 1;
+
+	return (crash_max > lowmem_max) ? lowmem_max : crash_max;
+}
+
+
+#define HAVE_ARCH_ADD_CRASH_RES_TO_IOMEM_EARLY
+#endif
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 59e1a13b5cf6..3a8b6f08f4ec 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -979,13 +979,6 @@ static int __init init_machine_late(void)
 }
 late_initcall(init_machine_late);
 
-#ifdef CONFIG_CRASH_RESERVE
-/*
- * The crash region must be aligned to 128MB to avoid
- * zImage relocating below the reserved region.
- */
-#define CRASH_ALIGN	(128 << 20)
-
 static inline unsigned long long get_total_mem(void)
 {
 	unsigned long total;
@@ -994,61 +987,27 @@ static inline unsigned long long get_total_mem(void)
 	return total << PAGE_SHIFT;
 }
 
-/**
- * reserve_crashkernel() - reserves memory are for crash kernel
- *
- * This function reserves memory area given in "crashkernel=" kernel command
- * line parameter. The memory reserved is used by a dump capture kernel when
- * primary kernel is crashing.
- */
-static void __init reserve_crashkernel(void)
+static void __init arch_reserve_crashkernel(void)
 {
 	unsigned long long crash_size, crash_base;
+	unsigned long long low_size = 0;
 	unsigned long long total_mem;
+	bool high = false;
 	int ret;
 
+	if (!IS_ENABLED(CONFIG_CRASH_RESERVE))
+		return;
+
 	total_mem = get_total_mem();
 	ret = parse_crashkernel(boot_command_line, total_mem,
 				&crash_size, &crash_base,
-				NULL, NULL);
+				&low_size, &high);
 	/* invalid value specified or crashkernel=0 */
 	crash_size = (phys_addr_t)crash_size;
 	if (ret || !crash_size)
 		return;
 
-	if (crash_base <= 0) {
-		unsigned long long crash_max = idmap_to_phys((u32)~0);
-		unsigned long long lowmem_max = __pa(high_memory - 1) + 1;
-		if (crash_max > lowmem_max)
-			crash_max = lowmem_max;
-
-		crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
-						       CRASH_ALIGN, crash_max);
-		if (!crash_base) {
-			pr_err("crashkernel reservation failed - No suitable area found.\n");
-			return;
-		}
-	} else {
-		unsigned long long crash_max = crash_base + crash_size;
-		unsigned long long start;
-
-		start = memblock_phys_alloc_range(crash_size, SECTION_SIZE,
-						  crash_base, crash_max);
-		if (!start) {
-			pr_err("crashkernel reservation failed - memory is in use.\n");
-			return;
-		}
-	}
-
-	pr_info("Reserving %ldMB of memory at %ldMB for crashkernel (System RAM: %ldMB)\n",
-		(unsigned long)(crash_size >> 20),
-		(unsigned long)(crash_base >> 20),
-		(unsigned long)(total_mem >> 20));
-
-	/* The crashk resource must always be located in normal mem */
-	crashk_res.start = crash_base;
-	crashk_res.end = crash_base + crash_size - 1;
-	insert_resource(&iomem_resource, &crashk_res);
+	reserve_crashkernel_generic(boot_command_line, crash_size, crash_base, low_size, high);
 
 	if (arm_has_idmap_alias()) {
 		/*
@@ -1065,9 +1024,6 @@ static void __init reserve_crashkernel(void)
 		insert_resource(&iomem_resource, &crashk_boot_res);
 	}
 }
-#else
-static inline void reserve_crashkernel(void) {}
-#endif /* CONFIG_CRASH_RESERVE*/
 
 void __init hyp_mode_check(void)
 {
@@ -1190,7 +1146,7 @@ void __init setup_arch(char **cmdline_p)
 	if (!is_smp())
 		hyp_mode_check();
 
-	reserve_crashkernel();
+	arch_reserve_crashkernel();
 
 #ifdef CONFIG_VT
 #if defined(CONFIG_VGA_CONSOLE)
-- 
2.34.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
