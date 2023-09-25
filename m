Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FD9CE79A1
	for <kexec@archiver.kernel.org>; Mon, 25 Sep 2023 21:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:From:Subject:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1Ui+VmSA7q1yzp6Jpo7EnqHkwsaXe706pevAS8wGmts=; b=tDECNipIDNW+y3
	dqyw9Lw8YqBgo70OjdsR4HoUQb7ohyyYg+fjt99tdFw49QJ+dThrxhaO5I706KYwhlhKjb8ksDPnm
	WJdBiZvHuICN2g50WtiJqGGlb6/X53/+V/ZGKvhSR7o7tRWMKc5nQHgKy47UkCX+H+BhpU+mvcVZZ
	+Xjso6LjMLVZwTphDfyhLHAEqUvCF3RPGKgzhSAE37XwAvf+2gSFREzK7HSBI3/+c7cRVSS69V3j4
	FDSsVdXHRYQhCgaJItNYDWJ7feLbVF/YiRQwIW2/3uZHPlmD63977ikR06MgLhwkzyRMfRc8I/xR6
	qcckug0b4/utWB5TCPzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qkt7n-00F3Qf-1g;
	Mon, 25 Sep 2023 21:28:15 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qkt7j-00F3OS-1b
	for kexec@lists.infradead.org;
	Mon, 25 Sep 2023 21:28:13 +0000
Received: from skinsburskii. (c-67-170-100-148.hsd1.wa.comcast.net [67.170.100.148])
	by linux.microsoft.com (Postfix) with ESMTPSA id 86DD1212C81C;
	Mon, 25 Sep 2023 14:28:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 86DD1212C81C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1695677291;
	bh=+rq2deN+a4hM/V5imypqZgNWtOmdjsP2ToFxAhOZYp4=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=e8sIvgnjvKkRGvg4avEhFTndLU4vLLOa15fS9Us3dnO+2i0QYibFYvZ8esTSOV86L
	 TlWVjndBFC+3YMx5igZ88kv2Y4AoIVdvfbaxSI6ifkALnqIfGeLfZmAifRBQTjd3s9
	 w2+h3Ly5Y5vtIQsq2MQ/yQhA23hlVdsrIyi3HnBY=
Subject: [RFC PATCH v2 4/7] pmpool: Introduce persistent memory pool
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 ebiederm@xmission.com, akpm@linux-foundation.org,
 stanislav.kinsburskii@gmail.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org,
 kys@microsoft.com, jgowans@amazon.com, wei.liu@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, graf@amazon.de, pbonzini@redhat.com
Date: Mon, 25 Sep 2023 14:28:09 -0700
Message-ID: <169567728905.19708.12668538787634109172.stgit@skinsburskii.>
In-Reply-To: <169567722094.19708.3583735425859054859.stgit@skinsburskii.>
References: <169567722094.19708.3583735425859054859.stgit@skinsburskii.>
User-Agent: StGit/0.19
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230925_142811_604598_443FEDE9 
X-CRM114-Status: GOOD (  19.75  )
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

From: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>

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
 include/linux/pmpool.h |   22 +++++++++++
 mm/Kconfig             |    8 ++++
 mm/Makefile            |    1 
 mm/pmpool.c            |  100 ++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 131 insertions(+)
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
index 000000000000..12a8cac75558
--- /dev/null
+++ b/mm/pmpool.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define pr_fmt(fmt) "pmpool: " fmt
+
+#include <linux/bitmap.h>
+#include <linux/cma.h>
+#include <linux/io.h>
+#include <linux/kexec.h>
+#include <linux/memblock.h>
+#include <linux/mm.h>
+#include <linux/pmpool.h>
+
+#include "cma.h"
+
+struct pmpool {
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
+static void pmpool_fixup_cma(struct cma *cma)
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
+static int __init default_pmpool_fixup_cma(void)
+{
+	if (!default_pmpool)
+		return 0;
+
+	pmpool_fixup_cma(default_pmpool->cma);
+	return 0;
+}
+postcore_initcall(default_pmpool_fixup_cma);
+
+static int __init parse_pmpool_opt(char *str)
+{
+	static struct pmpool pmpool;
+	phys_addr_t base, size;
+	int err;
+
+	/* Format is pmpool=<base>,<size> */
+	base = memparse(str, &str);
+	size = memparse(str + 1, NULL);
+
+	err = memblock_is_region_reserved(base, size);
+	if (err) {
+		pr_err("memory block overlaps with another one: %d\n", err);
+		return 0;
+	}
+
+	err = memblock_reserve(base, size);
+	if (err) {
+		pr_err("failed to reerve memory block: %d\n", err);
+		return 0;
+	}
+
+	err = cma_init_reserved_mem(base, size, 0, "pmpool", &pmpool.cma);
+	if (err) {
+		pr_err("failed to initialize CMA: %d\n", err);
+		goto free_memblock;
+	}
+
+	pr_info("default memory pool is created: %#llx-%#llx\n",
+		base, base + size);
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
