Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E09C83F10
	for <kexec@archiver.kernel.org>; Sun, 27 Aug 2023 10:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YOxNgVwI5rXaB8YAfigs3TR1zWC3IyzUqCCTESNKoSI=; b=XiG2pCSuLhlHBt
	QBR05dcfTGqZFJb4fzoivYyFqM9BOukvmg/DR9sqxjh7+6ODhkZUGyUJp3AGQc44DpEO9aW441TiX
	2CjBJejiSZ7Hrl4J3PGFjWcfJ/hQ592dFqRoRezvRoAVQTPOOacB7ItMdjbpIEWmE6t7WMwX3zn+2
	DzxLiGCCESp4iZVu1qf1QCwfftw59VXXtuHvpDOlS0HwANL0zQNmX3XY5TzjwkuyuOB3FKfDq98EQ
	PvyG12Gch/SYXFUU40zFYNU0FCbKIlLI56TtdYjglDJ2R656X3KDwoJ/OvpeUnZ6RrkphtYBFLn1L
	dCI7KM9qskwp+LtqBFqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qaCl7-007pLH-0t;
	Sun, 27 Aug 2023 10:12:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qaCkh-007opN-1R
	for kexec@lists.infradead.org;
	Sun, 27 Aug 2023 10:12:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693131134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H9Vqa75l+7u4j3OpciKGw2S9Ht0IvasTWkoki4mvRlQ=;
	b=dUpxPatb4VY+76RuPPKeEMkdvuIIxZe7g72x/S1E1Vc41MqzfBsjx4W6cTB4juY28TY8WU
	80V3m6ELRk1pBSaee36+N4U5403vKGFBULpKXNPineWwPmFBwSIDzSg4U2TkDqkxjnj7Zy
	xJEYyn4+GPy9gIWJ7hwi088+OljF81k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-63M_9Sk1O12-xtAXNXeGqA-1; Sun, 27 Aug 2023 06:12:10 -0400
X-MC-Unique: 63M_9Sk1O12-xtAXNXeGqA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B9662185A78F;
	Sun, 27 Aug 2023 10:12:09 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.43])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6A44A2166B25;
	Sun, 27 Aug 2023 10:12:05 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linux-riscv@lists.infradead.org,
	akpm@linux-foundation.org,
	catalin.marinas@arm.com,
	thunder.leizhen@huawei.com,
	dyoung@redhat.com,
	prudo@redhat.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH 7/8] x86: kdump: use generic interface to simplify crashkernel reservation code
Date: Sun, 27 Aug 2023 18:11:26 +0800
Message-ID: <20230827101128.70931-8-bhe@redhat.com>
In-Reply-To: <20230827101128.70931-1-bhe@redhat.com>
References: <20230827101128.70931-1-bhe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230827_031215_605269_3F613647 
X-CRM114-Status: GOOD (  26.17  )
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

1) Provide CRASH_ALIGN, CRASH_ADDR_LOW_MAX, CRASH_ADDR_HIGH_MAX and
   DEFAULT_CRASH_KERNEL_LOW_SIZE in <asm/kexec.h>;

2) Add arch_reserve_crashkernel() to call parse_crashkernel() and
   reserve_crashkernel_generic(), and do the ARCH specific work if
   needed.

3) Add ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION Kconfig in
   arch/x86/Kconfig.

When adding DEFAULT_CRASH_KERNEL_LOW_SIZE, add crash_low_size_default()
to calculate crashkernel low memory because x86_64 has special
requirement.

The old reserve_crashkernel_low() and reserve_crashkernel() can be
removed.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/Kconfig             |   3 +
 arch/x86/include/asm/kexec.h |  32 ++++++++
 arch/x86/kernel/setup.c      | 144 ++++-------------------------------
 3 files changed, 51 insertions(+), 128 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e36261b4ea14..31515b3ef55b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2073,6 +2073,9 @@ config KEXEC_FILE
 config ARCH_HAS_KEXEC_PURGATORY
 	def_bool KEXEC_FILE
 
+config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
+	def_bool CRASH_CORE
+
 config KEXEC_SIG
 	bool "Verify kernel signature during kexec_file_load() syscall"
 	depends on KEXEC_FILE
diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 5b77bbc28f96..84a7d1f6f153 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -66,6 +66,37 @@ struct kimage;
 # define KEXEC_ARCH KEXEC_ARCH_X86_64
 #endif
 
+/*
+ * --------- Crashkernel reservation ------------------------------
+ */
+
+/* 16M alignment for crash kernel regions */
+#define CRASH_ALIGN             SZ_16M
+
+/*
+ * Keep the crash kernel below this limit.
+ *
+ * Earlier 32-bits kernels would limit the kernel to the low 512 MB range
+ * due to mapping restrictions.
+ *
+ * 64-bit kdump kernels need to be restricted to be under 64 TB, which is
+ * the upper limit of system RAM in 4-level paging mode. Since the kdump
+ * jump could be from 5-level paging to 4-level paging, the jump will fail if
+ * the kernel is put above 64 TB, and during the 1st kernel bootup there's
+ * no good way to detect the paging mode of the target kernel which will be
+ * loaded for dumping.
+ */
+
+#ifdef CONFIG_X86_32
+# define CRASH_ADDR_LOW_MAX     SZ_512M
+# define CRASH_ADDR_HIGH_MAX    SZ_512M
+#else
+# define CRASH_ADDR_LOW_MAX     SZ_4G
+# define CRASH_ADDR_HIGH_MAX    SZ_64T
+#endif
+
+# define DEFAULT_CRASH_KERNEL_LOW_SIZE crash_low_size_default()
+
 /*
  * This function is responsible for capturing register states if coming
  * via panic otherwise just fix up the ss and sp if coming via kernel
@@ -209,6 +240,7 @@ typedef void crash_vmclear_fn(void);
 extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
 extern void kdump_nmi_shootdown_cpus(void);
 
+extern unsigned long crash_low_size_default(void);
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_KEXEC_H */
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 382c66d2cf71..559a5c4141db 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -474,152 +474,40 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 /*
  * --------- Crashkernel reservation ------------------------------
  */
-
-/* 16M alignment for crash kernel regions */
-#define CRASH_ALIGN		SZ_16M
-
-/*
- * Keep the crash kernel below this limit.
- *
- * Earlier 32-bits kernels would limit the kernel to the low 512 MB range
- * due to mapping restrictions.
- *
- * 64-bit kdump kernels need to be restricted to be under 64 TB, which is
- * the upper limit of system RAM in 4-level paging mode. Since the kdump
- * jump could be from 5-level paging to 4-level paging, the jump will fail if
- * the kernel is put above 64 TB, and during the 1st kernel bootup there's
- * no good way to detect the paging mode of the target kernel which will be
- * loaded for dumping.
- */
-#ifdef CONFIG_X86_32
-# define CRASH_ADDR_LOW_MAX	SZ_512M
-# define CRASH_ADDR_HIGH_MAX	SZ_512M
-#else
-# define CRASH_ADDR_LOW_MAX	SZ_4G
-# define CRASH_ADDR_HIGH_MAX	SZ_64T
-#endif
-
-static int __init reserve_crashkernel_low(void)
+unsigned long crash_low_size_default(void)
 {
 #ifdef CONFIG_X86_64
-	unsigned long long base, low_base = 0, low_size = 0;
-	unsigned long low_mem_limit;
-	int ret;
-
-	low_mem_limit = min(memblock_phys_mem_size(), CRASH_ADDR_LOW_MAX);
-
-	/* crashkernel=Y,low */
-	ret = parse_crashkernel_low(boot_command_line, low_mem_limit, &low_size, &base);
-	if (ret) {
-		/*
-		 * two parts from kernel/dma/swiotlb.c:
-		 * -swiotlb size: user-specified with swiotlb= or default.
-		 *
-		 * -swiotlb overflow buffer: now hardcoded to 32k. We round it
-		 * to 8M for other buffers that may need to stay low too. Also
-		 * make sure we allocate enough extra low memory so that we
-		 * don't run out of DMA buffers for 32-bit devices.
-		 */
-		low_size = max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20);
-	} else {
-		/* passed with crashkernel=0,low ? */
-		if (!low_size)
-			return 0;
-	}
-
-	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, 0, CRASH_ADDR_LOW_MAX);
-	if (!low_base) {
-		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
-		       (unsigned long)(low_size >> 20));
-		return -ENOMEM;
-	}
-
-	pr_info("Reserving %ldMB of low memory at %ldMB for crashkernel (low RAM limit: %ldMB)\n",
-		(unsigned long)(low_size >> 20),
-		(unsigned long)(low_base >> 20),
-		(unsigned long)(low_mem_limit >> 20));
-
-	crashk_low_res.start = low_base;
-	crashk_low_res.end   = low_base + low_size - 1;
-	insert_resource(&iomem_resource, &crashk_low_res);
-#endif
+	return max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20);
+#else
 	return 0;
+#endif
 }
 
-static void __init reserve_crashkernel(void)
+static void __init arch_reserve_crashkernel(void)
 {
-	unsigned long long crash_size, crash_base, total_mem;
+	unsigned long long crash_base, crash_size, low_size = 0;
+	char *cmdline = boot_command_line;
 	bool high = false;
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
 		return;
 
-	total_mem = memblock_phys_mem_size();
-
-	/* crashkernel=XM */
-	ret = parse_crashkernel(boot_command_line, total_mem,
-				&crash_size, &crash_base, NULL, NULL);
-	if (ret != 0 || crash_size <= 0) {
-		/* crashkernel=X,high */
-		ret = parse_crashkernel_high(boot_command_line, total_mem,
-					     &crash_size, &crash_base);
-		if (ret != 0 || crash_size <= 0)
-			return;
-		high = true;
-	}
+	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
+				&crash_size, &crash_base,
+				&low_size, &high);
+	if (ret)
+		return;
 
 	if (xen_pv_domain()) {
 		pr_info("Ignoring crashkernel for a Xen PV domain\n");
 		return;
 	}
 
-	/* 0 means: find the address automatically */
-	if (!crash_base) {
-		/*
-		 * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
-		 * crashkernel=x,high reserves memory over 4G, also allocates
-		 * 256M extra low memory for DMA buffers and swiotlb.
-		 * But the extra memory is not required for all machines.
-		 * So try low memory first and fall back to high memory
-		 * unless "crashkernel=size[KMG],high" is specified.
-		 */
-		if (!high)
-			crash_base = memblock_phys_alloc_range(crash_size,
-						CRASH_ALIGN, CRASH_ALIGN,
-						CRASH_ADDR_LOW_MAX);
-		if (!crash_base)
-			crash_base = memblock_phys_alloc_range(crash_size,
-						CRASH_ALIGN, CRASH_ALIGN,
-						CRASH_ADDR_HIGH_MAX);
-		if (!crash_base) {
-			pr_info("crashkernel reservation failed - No suitable area found.\n");
-			return;
-		}
-	} else {
-		unsigned long long start;
-
-		start = memblock_phys_alloc_range(crash_size, SZ_1M, crash_base,
-						  crash_base + crash_size);
-		if (start != crash_base) {
-			pr_info("crashkernel reservation failed - memory is in use.\n");
-			return;
-		}
-	}
-
-	if (crash_base >= (1ULL << 32) && reserve_crashkernel_low()) {
-		memblock_phys_free(crash_base, crash_size);
-		return;
-	}
-
-	pr_info("Reserving %ldMB of memory at %ldMB for crashkernel (System RAM: %ldMB)\n",
-		(unsigned long)(crash_size >> 20),
-		(unsigned long)(crash_base >> 20),
-		(unsigned long)(total_mem >> 20));
+	reserve_crashkernel_generic(cmdline, crash_size, crash_base,
+				    low_size, high);
 
-	crashk_res.start = crash_base;
-	crashk_res.end   = crash_base + crash_size - 1;
-	insert_resource(&iomem_resource, &crashk_res);
+	return;
 }
 
 static struct resource standard_io_resources[] = {
@@ -1231,7 +1119,7 @@ void __init setup_arch(char **cmdline_p)
 	 * Reserve memory for crash kernel after SRAT is parsed so that it
 	 * won't consume hotpluggable memory.
 	 */
-	reserve_crashkernel();
+	arch_reserve_crashkernel();
 
 	memblock_find_dma_reserve();
 
-- 
2.41.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
