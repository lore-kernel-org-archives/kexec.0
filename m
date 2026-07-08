Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A10C44506
	for <kexec@archiver.kernel.org>; Wed,  8 Jul 2026 23:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KvwcKqkHQyZ2uoR9E1ljTn+X3nC24ulgVhMt0Kon6RQ=; b=PkQMow3SQzlxFTRQHUhuZhagHU
	yCCsfgLi83ZvoqeceW6e21I2l0HrTsyKTMc6ahHOaCEaE4OFhHeXfRa2NyZjrZ/8grTu/mw/EeVli
	XhQfcHoN6vmw5UU5iOWcep+HVRXSght2pltlldS1YTRe52GcNVi8ZrIQKgZxzK8pzVl+3jNjACdC7
	Kc5KD0wfzNGPK3VcRuDEWqLQ4bSjye7yv90Z45Tc/vR1wj+rKvoUeawDnf58kihFl/d0s2WbwQjxa
	Jygt4qN4iJBHM9VjE7l5OmneJ1oQ4Vxpr0vGgLabiqVXE92F6DLUdlkyrbjKtxSgLc0fdInqQGUwH
	BpT8A46g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whc0p-00000000d6Z-0zEX;
	Wed, 08 Jul 2026 23:49:07 +0000
Received: from mail-pg1-x549.google.com ([2607:f8b0:4864:20::549])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whc0n-00000000d1O-032W
	for kexec@lists.infradead.org;
	Wed, 08 Jul 2026 23:49:06 +0000
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-c860544c077so2471135a12.3
        for <kexec@lists.infradead.org>; Wed, 08 Jul 2026 16:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783554544; x=1784159344; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KvwcKqkHQyZ2uoR9E1ljTn+X3nC24ulgVhMt0Kon6RQ=;
        b=b2wPLJF/DpYsXj2+jOUfZWMrtgTV5/QuSpt/c/SXNepswZbWpGeVqCqFzQS/qXFNk7
         gxcUtrrC+YqDZi/TqKKGLPPmXOHrmKKpciwqik5Xh8d9/wmRITihuDmhvWfSm7htxVTO
         wy9A6NvHhtliqhhqobwCz86f/1LOjujMP4kYTiyOqu/CPmz25iMyAr65Sq+YekeOBvrt
         efPwyTcmlFWPl5fAqnTagckNIoD6/JOBQy6evb75AKkYOhP9xzEl33CHkLjGWuluOxsb
         5WSzYrV5FU4tNxUHh6kMt3PmwmLSIvltEZE5txSxNKx3zs3lDisOguAvuAdhKCVMitDd
         BeBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783554544; x=1784159344;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KvwcKqkHQyZ2uoR9E1ljTn+X3nC24ulgVhMt0Kon6RQ=;
        b=LN+7hDI4pJUy9DVVczVjRiz9JwJk78YbTsnAYitL27ZJoVwNKef8ATQ51UfYPVsLTq
         0EPxNvRW4lZ/FyYg4pCWtl0fcfBRzgCaXygLij/1uYroAUAq4cAEcTMwJdCtxCMpGssX
         pCBg2aMNzCLajIepw9FBNhb0/W5jbjAHRPq8WVT49rNHCcj6QKzADc9hCyCBl1gs89vm
         Wr4GonkrzmNS8XhNFEC/heEmGydUO6nh9eYDADgfGnTZsizA/z6TcKBI0pHHoW4QmJ9R
         0E0sg/c4U8Q1LIdvcYpMZRRtQH1P5D/OEGuWbonzW3m9q+1inBfC1LHgfc0PUz8XQ8xv
         fT4g==
X-Forwarded-Encrypted: i=1; AHgh+Rr0Ov2ap62zjT+OdRPKpnTLFc6spNoOUkdciK7wIQaXUjyYRiwQSSu3ouB4D22S0hlYSEvhuQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzkMO8U6+0JFTpM78tdil0uUChb0t/ZP35YZ4uWbjSjo5KCn6tB
	0doscHXFYpy4hR9dlSBZuKlCC0i1VCUDHkWzzIo6H6b9rlBrB5hcmk3NhQ5omvh/N8ZTnd8r2qy
	Uc1fkDjb0nZjhWw==
X-Received: from pgh2.prod.google.com ([2002:a05:6a02:4e02:b0:c93:e04b:d9ad])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:9191:b0:3bf:6c08:284d with SMTP id adf61e73a8af0-3c0bd294eb5mr5386341637.60.1783554543571;
 Wed, 08 Jul 2026 16:49:03 -0700 (PDT)
Date: Wed,  8 Jul 2026 23:48:54 +0000
In-Reply-To: <20260708234854.4044652-1-skhawaja@google.com>
Mime-Version: 1.0
References: <20260708234854.4044652-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708234854.4044652-11-skhawaja@google.com>
Subject: [RFC PATCH v2 10/10] dma-direct: Add KUnit test for liveupdate preservation
From: Samiullah Khawaja <skhawaja@google.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Samiullah Khawaja <skhawaja@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev, 
	kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_164905_072935_43496C6D 
X-CRM114-Status: GOOD (  18.64  )
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

Use the KHO kunit stubs to mock the KHO preserve/unpreserve/restore API
and tests the preservation of DMA allocations with,

- Device being coherent or non-coherent.
- Atomic or non-atomic context.
- Various allocation sizes.
- Managed DMA allocations

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 kernel/dma/Kconfig       |   8 ++
 kernel/dma/Makefile      |   1 +
 kernel/dma/direct_test.c | 208 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 217 insertions(+)
 create mode 100644 kernel/dma/direct_test.c

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index d93958931303..48bc74af551a 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -269,3 +269,11 @@ config DMA_MAP_BENCHMARK
 config DMA_LIVEUPDATE
 	bool "Enable preservation of DMA direct allocations"
 	depends on LIVEUPDATE
+
+config DMA_LIVEUPDATE_KUNIT_TEST
+	tristate "KUnit test for DMA direct liveupdate preservation"
+	depends on KUNIT
+	depends on DMA_LIVEUPDATE
+	help
+	  This builds the KUnit tests for the DMA direct liveupdate
+	  preservation and restoration logic.
diff --git a/kernel/dma/Makefile b/kernel/dma/Makefile
index 6977033444a3..03703542ee79 100644
--- a/kernel/dma/Makefile
+++ b/kernel/dma/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_SWIOTLB)			+= swiotlb.o
 obj-$(CONFIG_DMA_COHERENT_POOL)		+= pool.o
 obj-$(CONFIG_MMU)			+= remap.o
 obj-$(CONFIG_DMA_MAP_BENCHMARK)		+= map_benchmark.o
+obj-$(CONFIG_DMA_LIVEUPDATE_KUNIT_TEST)	+= direct_test.o
diff --git a/kernel/dma/direct_test.c b/kernel/dma/direct_test.c
new file mode 100644
index 000000000000..f8403ec47807
--- /dev/null
+++ b/kernel/dma/direct_test.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for DMA allocation live update preservation.
+ */
+
+#include <kunit/test.h>
+#include <linux/module.h>
+#include <kunit/static_stub.h>
+#include <linux/dma-map-ops.h>
+#include <linux/dma-mapping.h>
+#include <linux/dma-direct.h>
+#include <linux/kho/abi/dma_alloc.h>
+#include <linux/kexec_handover.h>
+#include <linux/slab.h>
+
+static const size_t dma_test_sizes[] = {
+	128,
+	PAGE_SIZE,
+	2 * PAGE_SIZE,
+	3 * PAGE_SIZE,
+	8 * PAGE_SIZE,
+};
+
+static void dma_size_desc(const size_t *size, char *desc)
+{
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "size=%zu", *size);
+}
+
+KUNIT_ARRAY_PARAM(dma_size, dma_test_sizes, dma_size_desc);
+
+static struct page *mock_kho_restore_pages(phys_addr_t phys, unsigned long nr_pages)
+{
+	struct page *page = phys_to_page(phys);
+
+	if (!kho_test_pages_preserved(phys, nr_pages))
+		return NULL;
+
+	kho_unpreserve_pages(page, nr_pages);
+	return page;
+}
+
+static struct folio *mock_kho_restore_folio(phys_addr_t phys)
+{
+	struct folio *folio = page_folio(phys_to_page(phys));
+
+	if (!kho_test_pages_preserved(phys, (1 << folio_order(folio))))
+		return NULL;
+
+	kho_unpreserve_folio(folio);
+	return folio;
+}
+
+static void test_dma_direct_preserve_restore_common(struct kunit *test,
+						    bool coherent,
+						    bool atomic,
+						    size_t size)
+{
+	unsigned long nr_pages = 1 << get_order(size);
+	dma_addr_t handle1, handle2;
+	int ret, expected_ret = 0;
+	struct device dev = {0};
+	gfp_t gfp = GFP_KERNEL;
+	void *addr1, *addr2;
+	u64 state;
+
+	kunit_activate_static_stub(test, kho_restore_pages, mock_kho_restore_pages);
+	kunit_activate_static_stub(test, kho_restore_folio, mock_kho_restore_folio);
+
+	device_initialize(&dev);
+	dev.coherent_dma_mask = DMA_BIT_MASK(64);
+	dev.dma_mask = &dev.coherent_dma_mask;
+#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
+    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
+    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
+	dev.dma_coherent = coherent;
+#endif
+
+	if (atomic)
+		gfp = GFP_ATOMIC;
+
+	addr1 = dma_alloc_coherent(&dev, size, &handle1, gfp);
+	if (!addr1) {
+		kunit_skip(test, "DMA allocation failed (unsupported configuration)");
+		return;
+	}
+
+	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) && dma_is_from_pool(addr1, size)) {
+		expected_ret = -EOPNOTSUPP;
+		kunit_info(test, "DMA allocation using pool, expecting -EOPNOTSUPP");
+	} else if (dma_is_from_cma(dma_to_phys(&dev, handle1), size)) {
+		expected_ret = -EOPNOTSUPP;
+		kunit_info(test, "DMA allocation using CMA, expecting -EOPNOTSUPP");
+	}
+
+	ret = dma_preserve_coherent_allocation(&dev, addr1, size, handle1, &state);
+	KUNIT_ASSERT_EQ(test, ret, expected_ret);
+
+	if (!expected_ret) {
+		KUNIT_EXPECT_TRUE_MSG(test,
+				      kho_test_pages_preserved(dma_to_phys(&dev, handle1), nr_pages),
+				      "Allocated block not tracked in KHO");
+
+		addr2 = dma_restore_coherent_allocation(&dev, size, &handle2, gfp, state);
+		KUNIT_ASSERT_NOT_NULL(test, addr2);
+
+		KUNIT_EXPECT_EQ(test, handle1, handle2);
+		dma_free_coherent(&dev, size, addr2, handle2);
+		KUNIT_EXPECT_FALSE_MSG(test,
+				       kho_test_pages_preserved(dma_to_phys(&dev, handle1), nr_pages),
+				       "Allocated block still tracked after free");
+	} else {
+		dma_free_coherent(&dev, size, addr1, handle1);
+	}
+}
+
+static void test_dma_direct_coherent(struct kunit *test)
+{
+	const size_t *size = test->param_value;
+
+	test_dma_direct_preserve_restore_common(test, true, false, *size);
+}
+
+static void test_dma_direct_non_coherent(struct kunit *test)
+{
+	const size_t *size = test->param_value;
+
+	test_dma_direct_preserve_restore_common(test, false, false, *size);
+}
+
+static void test_dma_direct_coherent_atomic(struct kunit *test)
+{
+	const size_t *size = test->param_value;
+
+	test_dma_direct_preserve_restore_common(test, true, true, *size);
+}
+
+static void test_dma_direct_non_coherent_atomic(struct kunit *test)
+{
+	const size_t *size = test->param_value;
+
+	test_dma_direct_preserve_restore_common(test, false, true, *size);
+}
+
+static void test_dmam_preservation(struct kunit *test)
+{
+	dma_addr_t handle, non_dmam_handle;
+	void *addr, *non_dmam_addr;
+	struct device dev = {0};
+	size_t size = 128;
+	u64 state;
+	int ret;
+
+	kunit_activate_static_stub(test, kho_restore_pages, mock_kho_restore_pages);
+	kunit_activate_static_stub(test, kho_restore_folio, mock_kho_restore_folio);
+
+	device_initialize(&dev);
+	dev.coherent_dma_mask = DMA_BIT_MASK(64);
+	dev.dma_mask = &dev.coherent_dma_mask;
+#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
+    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
+    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL)
+	dev.dma_coherent = true;
+#endif
+
+	non_dmam_addr = dma_alloc_coherent(&dev, size, &non_dmam_handle, GFP_KERNEL);
+	if (!non_dmam_addr) {
+		kunit_skip(test, "DMA allocation failed");
+		return;
+	}
+
+	ret = dmam_preserve_coherent_allocation(&dev, non_dmam_addr, size, non_dmam_handle, &state);
+	KUNIT_EXPECT_EQ_MSG(test, ret, -EINVAL, "Preserving non-devres allocation should fail");
+	dma_free_coherent(&dev, size, non_dmam_addr, non_dmam_handle);
+
+	addr = dmam_alloc_coherent(&dev, size, &handle, GFP_KERNEL);
+	if (!addr) {
+		kunit_skip(test, "DMA allocation failed");
+		return;
+	}
+
+	ret = dmam_preserve_coherent_allocation(&dev, addr, size, handle, &state);
+	KUNIT_ASSERT_EQ_MSG(test, ret, 0, "Failed to preserve dmam allocation");
+	KUNIT_EXPECT_TRUE(test, kho_test_pages_preserved(dma_to_phys(&dev, handle), 1));
+
+	dmam_unpreserve_coherent_allocation(&dev, addr, size, handle, state);
+	KUNIT_EXPECT_FALSE(test, kho_test_pages_preserved(dma_to_phys(&dev, handle), 1));
+
+	dmam_free_coherent(&dev, size, addr, handle);
+}
+
+static struct kunit_case dma_direct_test_cases[] = {
+	KUNIT_CASE_PARAM(test_dma_direct_coherent, dma_size_gen_params),
+	KUNIT_CASE_PARAM(test_dma_direct_non_coherent, dma_size_gen_params),
+	KUNIT_CASE_PARAM(test_dma_direct_coherent_atomic, dma_size_gen_params),
+	KUNIT_CASE_PARAM(test_dma_direct_non_coherent_atomic, dma_size_gen_params),
+	KUNIT_CASE(test_dmam_preservation),
+	{}
+};
+
+static struct kunit_suite dma_direct_test_suite = {
+	.name = "dma_direct_liveupdate",
+	.test_cases = dma_direct_test_cases,
+};
+kunit_test_suite(dma_direct_test_suite);
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+MODULE_DESCRIPTION("KUnit test for DMA direct live update preservation");
+MODULE_LICENSE("GPL");
-- 
2.55.0.795.g602f6c329a-goog


