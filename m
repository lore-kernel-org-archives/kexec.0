Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD83ECD37B0
	for <kexec@archiver.kernel.org>; Sat, 16 Sep 2023 00:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EVrS2Mp6g05NDr6LUArvTEdOVm1i9YMflJDCjjKjsPg=; b=csMQh/5Md8C7S8
	rfpVA2yB/IQOzdZLtV2z0GGJT76EbQo5MJhab4vKjZZR6Gkwbj+1rF0BDi3LYOWlKkEfYs1EHExVq
	zrKLQsPhHg7dBywWyQbvmjEoEq1cQ5E6OOTGdZJe4Fs3Pm43xbTzf/5PiIlpL4xXTdsnBuc9f276o
	JpBclLNlV20bx4uuC3gIxhv2TG7D8OaLJtA0a71EEdV92i73MFBx+pzh4EHeAG2PG4TyVq/8Wo5e8
	kzaQ41Oev++Ksz8L7d51oFIXD/yHoz0z3cAPFejYVN5OZ0TuK+al6jjqFqjQBp5UIhf63I2CQbV7c
	q1SPhaWHQQd4M6iGdiIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qhJBy-00Bc9j-2J;
	Sat, 16 Sep 2023 00:29:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qhJBt-00Bc8m-2h
	for kexec@lists.infradead.org;
	Sat, 16 Sep 2023 00:29:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694824179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VFlZ5nOYBRhVa9tbB+zfgy6vwVzlYbXq61zXTKpXiW0=;
	b=RRXLVzy+zNA8dT26TS1THS7EsEaI+XnYLJImR+repmVbTayxONog9Ct/pO6qem/BEWXPyi
	w2Q0kTQkjQuidqijZLoLf20Y3N/3AKZur+UQyOOCV/OPTv2NNIGIfr3HkVyqIK7H53jzfX
	RamzrS3JPWxBo9SEWU0EKCqHwS0OgZg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-340-V11sprw1PVCYC33g-DDKyA-1; Fri, 15 Sep 2023 20:29:36 -0400
X-MC-Unique: V11sprw1PVCYC33g-DDKyA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A10981B54D;
	Sat, 16 Sep 2023 00:29:35 +0000 (UTC)
Received: from localhost (unknown [10.72.112.6])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 26FC31D093;
	Sat, 16 Sep 2023 00:29:33 +0000 (UTC)
Date: Sat, 16 Sep 2023 08:29:30 +0800
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc: thunder.leizhen@huawei.com, catalin.marinas@arm.com,
	chenjiahao16@huawei.com, kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, x86@kernel.org
Subject: [PATCH v4 6/9] x86: kdump: use generic interface to simplify
 crashkernel reservation code
Message-ID: <ZQT26loqCPCQSjiz@MiWiFi-R3L-srv>
References: <20230914033142.676708-1-bhe@redhat.com>
 <20230914033142.676708-7-bhe@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230914033142.676708-7-bhe@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230915_172941_996756_ED1C8393 
X-CRM114-Status: GOOD (  28.98  )
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
v3->v4:
  Move crash_low_size_default() to <asm/crash_core.h> to make it a
  static inline function. This fixes the warning reported by LKP.

 arch/x86/Kconfig                  |   3 +
 arch/x86/include/asm/crash_core.h |  42 +++++++++
 arch/x86/kernel/setup.c           | 148 +++---------------------------
 3 files changed, 56 insertions(+), 137 deletions(-)
 create mode 100644 arch/x86/include/asm/crash_core.h

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 982b777eadc7..d5ebb2ad2ad6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2062,6 +2062,9 @@ config ARCH_SUPPORTS_CRASH_DUMP
 config ARCH_SUPPORTS_CRASH_HOTPLUG
 	def_bool y
 
+config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
+	def_bool CRASH_CORE
+
 config PHYSICAL_START
 	hex "Physical address where the kernel is loaded" if (EXPERT || CRASH_DUMP)
 	default "0x1000000"
diff --git a/arch/x86/include/asm/crash_core.h b/arch/x86/include/asm/crash_core.h
new file mode 100644
index 000000000000..76af98f4e801
--- /dev/null
+++ b/arch/x86/include/asm/crash_core.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _X86_CRASH_CORE_H
+#define _X86_CRASH_CORE_H
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
+extern unsigned long swiotlb_size_or_default(void);
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
+static inline unsigned long crash_low_size_default(void)
+{
+#ifdef CONFIG_X86_64
+	return max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20);
+#else
+	return 0;
+#endif
+}
+
+#endif /* _X86_CRASH_CORE_H */
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index f945d88215b4..d7baa567c68e 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -470,155 +470,29 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 	}
 }
 
-/*
- * --------- Crashkernel reservation ------------------------------
- */
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
+static void __init arch_reserve_crashkernel(void)
 {
-#ifdef CONFIG_X86_64
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
-	return 0;
-}
-
-static void __init reserve_crashkernel(void)
-{
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
-
-	crashk_res.start = crash_base;
-	crashk_res.end   = crash_base + crash_size - 1;
-	insert_resource(&iomem_resource, &crashk_res);
+	reserve_crashkernel_generic(cmdline, crash_size, crash_base,
+				    low_size, high);
 }
 
 static struct resource standard_io_resources[] = {
@@ -1232,7 +1106,7 @@ void __init setup_arch(char **cmdline_p)
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
