Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5833EE021E
	for <kexec@archiver.kernel.org>; Thu, 14 Sep 2023 03:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pSgoZQRPSAkpUfphYrnZeszS738Qbc1/odnPmzAA50c=; b=vc+7fmkty3JJwM
	adlotIYmueP4vk7eIT6/n7Tkq6dq91RqVza4qvMEVlpjnw9XBfcxzgiUyYHBNG5clS25HEXAURaxR
	BM4CgBezjgBXH0s7gWbpdmwL0d1RU2a24f8Y/WRMpAmgW8I2Af0n1FInDrEANCPqA41/762qWh07d
	gPvCxwhwnygaBUtas/HoSKKiJsC5aCIcNiOA2xwxijEGwEufWPRF/6r73CYPhgnrGFkp3fGV5DAN9
	dX8owJGCGiHf5eWeelXDVDUgWypJmqHiws3hXl474+07A26vtmhVhdfVj55Eyv75BS19AfXnxo5tv
	ltOKLS5iI4uOHBXUagww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgd7t-007HQ6-1E;
	Thu, 14 Sep 2023 03:34:45 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgd7p-007HOZ-26
	for kexec@lists.infradead.org;
	Thu, 14 Sep 2023 03:34:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694662480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z3z8Y0/D5Ez1OLIUoEmFNE1K33wop8T7RhDcPhYHEDY=;
	b=O57D3wIzWWiEhbJ2l7ipa53t2qAwr3IOy9tTtnahcdXRq9enoXAtxzBU7q5R3SzuWBMTVG
	vkjlW9cg47DhwoaLcZHzHjLL70y56f4/ARvl0YRAMvMaq2Nbv7AsRsF4kAN6ODyheTEj2c
	vWYBWrLYSujzCLV4ZiIavspgz9rSZv8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-279-Pod-qYGnNIerqy8Jh97cDA-1; Wed, 13 Sep 2023 23:32:22 -0400
X-MC-Unique: Pod-qYGnNIerqy8Jh97cDA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08E80816523;
	Thu, 14 Sep 2023 03:32:22 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.51])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D57EC10F1BE7;
	Thu, 14 Sep 2023 03:32:17 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	thunder.leizhen@huawei.com,
	catalin.marinas@arm.com,
	chenjiahao16@huawei.com,
	kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 7/9] arm64: kdump: use generic interface to simplify crashkernel reservation
Date: Thu, 14 Sep 2023 11:31:40 +0800
Message-ID: <20230914033142.676708-8-bhe@redhat.com>
In-Reply-To: <20230914033142.676708-1-bhe@redhat.com>
References: <20230914033142.676708-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230913_203441_770032_6BA4A0D0 
X-CRM114-Status: GOOD (  23.75  )
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

With the help of newly changed function parse_crashkernel() and
generic reserve_crashkernel_generic(), crashkernel reservation can be
simplified by steps:

1) Add a new header file <asm/crash_core.h>, and define CRASH_ALIGN,
   CRASH_ADDR_LOW_MAX, CRASH_ADDR_HIGH_MAX and
   DEFAULT_CRASH_KERNEL_LOW_SIZE in <asm/crash_core.h>;

2) Add arch_reserve_crashkernel() to call parse_crashkernel() and
   reserve_crashkernel_generic();

3) Add ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION Kconfig in
   arch/arm64/Kconfig.

The old reserve_crashkernel_low() and reserve_crashkernel() can be
removed.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm64/Kconfig                  |   3 +
 arch/arm64/include/asm/crash_core.h |  10 ++
 arch/arm64/mm/init.c                | 140 ++--------------------------
 3 files changed, 21 insertions(+), 132 deletions(-)
 create mode 100644 arch/arm64/include/asm/crash_core.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b10515c0200b..e7d374d994ad 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1483,6 +1483,9 @@ config ARCH_DEFAULT_KEXEC_IMAGE_VERIFY_SIG
 config ARCH_SUPPORTS_CRASH_DUMP
 	def_bool y
 
+config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
+	def_bool CRASH_CORE
+
 config TRANS_TABLE
 	def_bool y
 	depends on HIBERNATION || KEXEC_CORE
diff --git a/arch/arm64/include/asm/crash_core.h b/arch/arm64/include/asm/crash_core.h
new file mode 100644
index 000000000000..9f5c8d339f44
--- /dev/null
+++ b/arch/arm64/include/asm/crash_core.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ARM64_CRASH_CORE_H
+#define _ARM64_CRASH_CORE_H
+
+/* Current arm64 boot protocol requires 2MB alignment */
+#define CRASH_ALIGN                     SZ_2M
+
+#define CRASH_ADDR_LOW_MAX              arm64_dma_phys_limit
+#define CRASH_ADDR_HIGH_MAX             (PHYS_MASK + 1)
+#endif
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 801c59c39a8f..f2bf32e19371 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -64,15 +64,6 @@ EXPORT_SYMBOL(memstart_addr);
  */
 phys_addr_t __ro_after_init arm64_dma_phys_limit;
 
-/* Current arm64 boot protocol requires 2MB alignment */
-#define CRASH_ALIGN			SZ_2M
-
-#define CRASH_ADDR_LOW_MAX		arm64_dma_phys_limit
-#define CRASH_ADDR_HIGH_MAX		(PHYS_MASK + 1)
-#define CRASH_HIGH_SEARCH_BASE		SZ_4G
-
-#define DEFAULT_CRASH_KERNEL_LOW_SIZE	(128UL << 20)
-
 /*
  * To make optimal use of block mappings when laying out the linear
  * mapping, round down the base of physical memory to a size that can
@@ -100,140 +91,25 @@ phys_addr_t __ro_after_init arm64_dma_phys_limit;
 #define ARM64_MEMSTART_ALIGN	(1UL << ARM64_MEMSTART_SHIFT)
 #endif
 
-static int __init reserve_crashkernel_low(unsigned long long low_size)
-{
-	unsigned long long low_base;
-
-	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, 0, CRASH_ADDR_LOW_MAX);
-	if (!low_base) {
-		pr_err("cannot allocate crashkernel low memory (size:0x%llx).\n", low_size);
-		return -ENOMEM;
-	}
-
-	pr_info("crashkernel low memory reserved: 0x%08llx - 0x%08llx (%lld MB)\n",
-		low_base, low_base + low_size, low_size >> 20);
-
-	crashk_low_res.start = low_base;
-	crashk_low_res.end   = low_base + low_size - 1;
-	insert_resource(&iomem_resource, &crashk_low_res);
-
-	return 0;
-}
-
-/*
- * reserve_crashkernel() - reserves memory for crash kernel
- *
- * This function reserves memory area given in "crashkernel=" kernel command
- * line parameter. The memory reserved is used by dump capture kernel when
- * primary kernel is crashing.
- */
-static void __init reserve_crashkernel(void)
+static void __init arch_reserve_crashkernel(void)
 {
-	unsigned long long crash_low_size = 0, search_base = 0;
-	unsigned long long crash_max = CRASH_ADDR_LOW_MAX;
+	unsigned long long low_size = 0;
 	unsigned long long crash_base, crash_size;
 	char *cmdline = boot_command_line;
-	bool fixed_base = false;
 	bool high = false;
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
 		return;
 
-	/* crashkernel=X[@offset] */
 	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
-				&crash_size, &crash_base, NULL, NULL);
-	if (ret == -ENOENT) {
-		ret = parse_crashkernel_high(cmdline, 0, &crash_size, &crash_base);
-		if (ret || !crash_size)
-			return;
-
-		/*
-		 * crashkernel=Y,low can be specified or not, but invalid value
-		 * is not allowed.
-		 */
-		ret = parse_crashkernel_low(cmdline, 0, &crash_low_size, &crash_base);
-		if (ret == -ENOENT)
-			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
-		else if (ret)
-			return;
-
-		search_base = CRASH_HIGH_SEARCH_BASE;
-		crash_max = CRASH_ADDR_HIGH_MAX;
-		high = true;
-	} else if (ret || !crash_size) {
-		/* The specified value is invalid */
+				&crash_size, &crash_base,
+				&low_size, &high);
+	if (ret)
 		return;
-	}
-
-	crash_size = PAGE_ALIGN(crash_size);
-
-	/* User specifies base address explicitly. */
-	if (crash_base) {
-		fixed_base = true;
-		search_base = crash_base;
-		crash_max = crash_base + crash_size;
-	}
-
-retry:
-	crash_base = memblock_phys_alloc_range(crash_size, CRASH_ALIGN,
-					       search_base, crash_max);
-	if (!crash_base) {
-		/*
-		 * For crashkernel=size[KMG]@offset[KMG], print out failure
-		 * message if can't reserve the specified region.
-		 */
-		if (fixed_base) {
-			pr_warn("crashkernel reservation failed - memory is in use.\n");
-			return;
-		}
-
-		/*
-		 * For crashkernel=size[KMG], if the first attempt was for
-		 * low memory, fall back to high memory, the minimum required
-		 * low memory will be reserved later.
-		 */
-		if (!high && crash_max == CRASH_ADDR_LOW_MAX) {
-			crash_max = CRASH_ADDR_HIGH_MAX;
-			search_base = CRASH_ADDR_LOW_MAX;
-			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
-			goto retry;
-		}
-
-		/*
-		 * For crashkernel=size[KMG],high, if the first attempt was
-		 * for high memory, fall back to low memory.
-		 */
-		if (high && crash_max == CRASH_ADDR_HIGH_MAX) {
-			crash_max = CRASH_ADDR_LOW_MAX;
-			search_base = 0;
-			goto retry;
-		}
-		pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
-			crash_size);
-		return;
-	}
-
-	if ((crash_base >= CRASH_ADDR_LOW_MAX) && crash_low_size &&
-	     reserve_crashkernel_low(crash_low_size)) {
-		memblock_phys_free(crash_base, crash_size);
-		return;
-	}
-
-	pr_info("crashkernel reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
-		crash_base, crash_base + crash_size, crash_size >> 20);
-
-	/*
-	 * The crashkernel memory will be removed from the kernel linear
-	 * map. Inform kmemleak so that it won't try to access it.
-	 */
-	kmemleak_ignore_phys(crash_base);
-	if (crashk_low_res.end)
-		kmemleak_ignore_phys(crashk_low_res.start);
 
-	crashk_res.start = crash_base;
-	crashk_res.end = crash_base + crash_size - 1;
-	insert_resource(&iomem_resource, &crashk_res);
+	reserve_crashkernel_generic(cmdline, crash_size, crash_base,
+				    low_size, high);
 }
 
 /*
@@ -479,7 +355,7 @@ void __init bootmem_init(void)
 	 * request_standard_resources() depends on crashkernel's memory being
 	 * reserved, so do it here.
 	 */
-	reserve_crashkernel();
+	arch_reserve_crashkernel();
 
 	memblock_dump_all();
 }
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
