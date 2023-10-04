Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3BF6E936EB
	for <kexec@archiver.kernel.org>; Wed,  4 Oct 2023 22:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:From:Subject:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Qa7bCB6rChe/6tahNX3divOCYtmlsiUh/enmDVdexJ8=; b=vEZPKdsr8ANTzI
	fK/nAxUAnBwBRrYicbrFa9fHO5NCBLE4egAmg4JT1SYldulLfPj3YVqDV2Qkm4rkTLbVzzLxnyQbB
	6HCK5/wJPmc9geuyHxPgpMEKrENPfRKL5KUhplBLkHESLg5Vsq/fmuFtF06ER1UF0QkTHpmef/5a/
	eGykwVbBT6qsfiw6LXQNulDIaap9iLgFF9X0tVhqp81YM2qiQ0J7nqzXji26AzULzQruPkF/RQU4O
	k563Yq3OHr0kpK/GVdc7y8+A2NdwUFV1ZEv+DqAVlBTED8yUnPaR5hAVlfo2/N7utnB6c/8m+DeHE
	fbTM5UFdggYWfjBDrh/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qoAH8-0010Lx-1b;
	Wed, 04 Oct 2023 22:23:26 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qoAH5-0010Kb-1l
	for kexec@lists.infradead.org;
	Wed, 04 Oct 2023 22:23:25 +0000
Received: from skinsburskii. (c-67-170-100-148.hsd1.wa.comcast.net [67.170.100.148])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7808420B74C3;
	Wed,  4 Oct 2023 15:23:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7808420B74C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1696458202;
	bh=/kL+2ixzH9Y0/6AQP5r2LCMUwHJ2IksXHQmOSZeRk70=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=DlMtgdVrA20cf0WTlXXW5RXqRzynEKABAzw/J5WMThiJUmO+Lc0rmP1Rc1OruUeLB
	 R7bcSK9jKhK4ic0bOrJKyjziPapZ1jp5S6vb0OXKD9z7fYUH0i54ceUbwrJ/9GWA2H
	 2JA3TqJMbqo7iWRfG6KPnIaG2vLSTnd02Tf9D/w0=
Subject: [RFC PATCH v3 2/3] pmpool: Introduce persistent memory pool
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 ebiederm@xmission.com, akpm@linux-foundation.org,
 stanislav.kinsburskii@gmail.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org,
 kys@microsoft.com, jgowans@amazon.com, wei.liu@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, graf@amazon.de, pbonzini@redhat.com,
 bhe@redhat.com, dave.hansen@intel.com, kirill.shutemov@intel.com
Date: Wed, 04 Oct 2023 15:23:21 -0700
Message-ID: <169645820185.11424.12461972351107674989.stgit@skinsburskii.>
In-Reply-To: <169645773092.11424.7258549771090599226.stgit@skinsburskii.>
References: <169645773092.11424.7258549771090599226.stgit@skinsburskii.>
User-Agent: StGit/0.19
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231004_152323_699309_635D84B2 
X-CRM114-Status: GOOD (  21.11  )
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

This patch introduces a memory allocator specifically tailored for
persistent memory within the kernel. The allocator maintains
kernel-specific states like DMA passthrough device states, IOMMU state, and
more across kexec.

The current implementation provides a foundation for custom solutions that
may be developed in the future. Although the design is kept concise and
straightforward to encourage discussion and feedback, it remains fully
functional.

The persistent memory pool builds upon the continuous memory allocator
(CMA) and ensures CMA state persistency across kexec by incorporating the
CMA bitmap into the memory region.

Potential applications include:

  1. Enabling various in-kernel entities to allocate persistent pages from
     a unified memory pool, obviating the need for reserving multiple
     regions.

  2. For in-kernel components that need the allocation address to be
     retained on kernel kexec, this address can be exposed to user space
     and subsequently passed through the command line.

  3. Distinct subsystems or drivers can set aside their region, allocating
     a segment for their persistent memory pool, suitable for uses such as
     file systems, key-value stores, and other applications.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 include/linux/pmpool.h |   22 +++++++++
 mm/Kconfig             |    8 +++
 mm/Makefile            |    1 
 mm/pmpool.c            |  115 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 146 insertions(+)
 create mode 100644 include/linux/pmpool.h
 create mode 100644 mm/pmpool.c

diff --git a/include/linux/pmpool.h b/include/linux/pmpool.h
new file mode 100644
index 000000000000..b41f16fa9660
--- /dev/null
+++ b/include/linux/pmpool.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _PMPOOL_H
+#define _PMPOOL_H
+
+struct page;
+
+#if defined(CONFIG_PMPOOL)
+struct page *pmpool_alloc(unsigned long count);
+bool pmpool_release(struct page *pages, unsigned long count);
+#else
+static inline struct page *pmpool_alloc(unsigned long count)
+{
+	return NULL;
+}
+static inline bool pmpool_release(struct page *pages, unsigned long count)
+{
+	return false;
+}
+#endif
+
+#endif /* _PMPOOL_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index 09130434e30d..e7c10094fb10 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -922,6 +922,14 @@ config CMA_AREAS
 
 	  If unsure, leave the default value "7" in UMA and "19" in NUMA.
 
+config PMPOOL
+	bool "Persistent memory pool support"
+	select CMA
+	help
+	  This option adds support for CMA-based persistent memory pool
+	  feature, which provides pages allocation and freeing from a set of
+	  persistent memory ranges, deposited to the memory pool.
+
 config MEM_SOFT_DIRTY
 	bool "Track memory changes"
 	depends on CHECKPOINT_RESTORE && HAVE_ARCH_SOFT_DIRTY && PROC_FS
diff --git a/mm/Makefile b/mm/Makefile
index 678530a07326..8d3579e58c2c 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -139,3 +139,4 @@ obj-$(CONFIG_IO_MAPPING) += io-mapping.o
 obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) += bootmem_info.o
 obj-$(CONFIG_GENERIC_IOREMAP) += ioremap.o
 obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
+obj-$(CONFIG_PMPOOL) += pmpool.o
diff --git a/mm/pmpool.c b/mm/pmpool.c
new file mode 100644
index 000000000000..c74f09b99283
--- /dev/null
+++ b/mm/pmpool.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define pr_fmt(fmt) "pmpool: " fmt
+
+#include <linux/bitmap.h>
+#include <linux/cma.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/kexec.h>
+#include <linux/memblock.h>
+#include <linux/mm.h>
+#include <linux/pmpool.h>
+
+#include "cma.h"
+
+struct pmpool {
+	struct resource resource;
+	struct cma *cma;
+};
+
+static struct pmpool *default_pmpool;
+
+bool pmpool_release(struct page *pages, unsigned long count)
+{
+	if (!default_pmpool)
+		return false;
+
+	return cma_release(default_pmpool->cma, pages, count);
+}
+
+struct page *pmpool_alloc(unsigned long count)
+{
+	if (!default_pmpool)
+		return NULL;
+
+	return cma_alloc(default_pmpool->cma, count, 0, true);
+}
+
+static void pmpool_cma_accomodate_bitmap(struct cma *cma)
+{
+	unsigned long bitmap_size;
+
+	bitmap_free(cma->bitmap);
+	cma->bitmap = phys_to_virt(PFN_PHYS(cma->base_pfn));
+
+	bitmap_size = BITS_TO_LONGS(cma_bitmap_maxno(cma));
+	memset(cma->bitmap, 0, bitmap_size);
+	bitmap_set(cma->bitmap, 0, PAGE_ALIGN(bitmap_size) >> PAGE_SHIFT);
+
+	pr_info("CMA bitmap moved to %#llx\n", virt_to_phys(cma->bitmap));
+}
+
+static int __init default_pmpool_fixup(void)
+{
+	if (!default_pmpool)
+		return 0;
+
+	if (insert_resource(&iomem_resource, &default_pmpool->resource))
+		pr_err("failed to insert resource\n");
+
+	pmpool_cma_accomodate_bitmap(default_pmpool->cma);
+	return 0;
+}
+postcore_initcall(default_pmpool_fixup);
+
+static int __init parse_pmpool_opt(char *str)
+{
+	static struct pmpool pmpool = {
+		.resource = {
+			.name  = "Persistent Memory Pool",
+			.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
+			.desc  = IORES_DESC_CXL
+		}
+	};
+	phys_addr_t base, size, end;
+	int err;
+
+	/* Format is pmpool=<base>,<size> */
+	base = memparse(str, &str);
+	size = memparse(str + 1, NULL);
+	end = base + size - 1;
+
+	err = memblock_is_region_reserved(base, size);
+	if (err) {
+		pr_err("memory block overlaps with another one: %d\n", err);
+		return 0;
+	}
+
+	err = memblock_reserve(base, size);
+	if (err) {
+		pr_err("failed to reserve memory block: %d\n", err);
+		return 0;
+	}
+
+	err = cma_init_reserved_mem(base, size, 0, "pmpool", &pmpool.cma);
+	if (err) {
+		pr_err("failed to initialize CMA: %d\n", err);
+		goto free_memblock;
+	}
+
+	pmpool.resource.start = base;
+	pmpool.resource.end = end;
+
+	pr_info("default memory pool is created: %#llx-%#llx\n",
+		base, end);
+
+	default_pmpool = &pmpool;
+
+	return 0;
+
+free_memblock:
+	memblock_phys_free(base, size);
+	return 0;
+}
+early_param("pmpool", parse_pmpool_opt);



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
