Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8211CD4F24
	for <kexec@archiver.kernel.org>; Tue, 12 May 2026 19:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v7TVTYRDvcEKHxiAe879U7fECAlukFuq2rcibnBNqK4=; b=fz0vbL/emdjsAj0PLXSdWj2dCC
	9E07KDNPN6chC+YNLZPeSDaoHeIlH1fE1io3/Kb60yyEuUfFuYUrgdBjAEsDii4wDp9q7y/Wbd4oo
	5GnbnH4OruxqlLZqeIoCrny+9xGXyX0IGXO7vCvD80vhYuPkfdBgbt+3X6ITqLdJQq3rKk+D7rXhs
	8/YCVhqy1oXWkLCOR3BkWcoANt1mtbwQuYHADKfvulzlbotWv4cdkIPpde3QpKfu8Bv2sgYH3b0SI
	tig7/z9xvMQ744Yj7tWvmgZmTJGmaTrq2KAKXhXF/qugi+B06X97YTIvuCByn3B8x0QfGPa84OdR9
	dQak0MiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMt8n-00000000Ghf-2OvA;
	Tue, 12 May 2026 19:51:41 +0000
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMt8l-00000000GgL-3Iom
	for kexec@lists.infradead.org;
	Tue, 12 May 2026 19:51:40 +0000
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-c82751074c8so4271994a12.0
        for <kexec@lists.infradead.org>; Tue, 12 May 2026 12:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778615498; x=1779220298; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v7TVTYRDvcEKHxiAe879U7fECAlukFuq2rcibnBNqK4=;
        b=q7k5QVI9GEBMPon67DtqxnWAsJAZJXo9JkQaSK5zLuGAmrx5+I2Z3wRAZ9oZsTCWiM
         i4NJqUKXR69HEuyyVANy4yp0btsIzwSntMYZTCXv8CDTCxJnGUd2CvqGss469F9Hcd59
         0UCYCkWtcyygwKYL/7JYQCsO8BT3Y9VAV59cjkwz+WU1xaSJUv7hwwf42snvW8unH7bW
         Wwgk/hCsXVBuwm1YvbDoFwy84MO+lldRRPCD6NCToD+1w50uf4r1viVB8XICTzAe/FxM
         /b8fOClA23z6boQ7UhCN/scNeF2CfGNywnJArVfUocKJEINEq9dQO4b+Br1b7dPwxFFb
         cL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778615498; x=1779220298;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v7TVTYRDvcEKHxiAe879U7fECAlukFuq2rcibnBNqK4=;
        b=phUYvexU7XBSCmA41yjRJryZJc5PCMdPCjslMtG7Mb33i3UULF8WVx3PuBJsJDUE4r
         9ik4HKkjoafJk5WBaTGRfNqCIsAHdX6LYJ+FhFjsV1Rjc7D+1PKTDTdp5vb9VvICRfG/
         HXV5zN0uwZDvHkeVWfdoEpR5nrGgn/L80sXMHO+ZC0k/esWa4RmWM3DR85oHNUDfEykG
         8AY4slSyXP3Db7Q8K0EmEsFQPF77++DZowfAZEBCELtx8tGpvbU3E6B3ZPDFsLsw64B9
         Er7I0wpjhw8MqIm9ZsaejBBhyMxtTrYu8cUM9UXUhPEPpZXfJDoZdkNEpjy2ngjhuuHd
         QAgQ==
X-Forwarded-Encrypted: i=1; AFNElJ8OPGyk9Kuw6QWyl/GSlUEspqrVMIOWVH/GZLVfHkqazDwFNKTUtVS1Lha/X/RhU1gSrV108Q==@lists.infradead.org
X-Gm-Message-State: AOJu0Yws0UhlIE6MKvMXIDg9YB0xHlJ5s6SSgokMPnhpJ2HHBhEk1CcF
	VUQoHxr8JPyQQYlPoYZIb16aHVujHFC2W+zaq7e8uHytqYuVdJpeAtoqB8cfoi78lDYmJvK40ho
	hz2U9xSTsai5wUg==
X-Received: from pfbcg6.prod.google.com ([2002:a05:6a00:2906:b0:836:ed4a:203f])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:298f:b0:82f:390a:69c7 with SMTP id d2e1a72fcca58-83f0429e3c3mr90865b3a.33.1778615498220;
 Tue, 12 May 2026 12:51:38 -0700 (PDT)
Date: Tue, 12 May 2026 19:51:35 +0000
In-Reply-To: <20260512195135.804833-1-skhawaja@google.com>
Mime-Version: 1.0
References: <20260512195135.804833-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512195135.804833-4-skhawaja@google.com>
Subject: [PATCH 3/3] kho: Add kunit test to verify preserve/restore pages and folio
From: Samiullah Khawaja <skhawaja@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, David Matlack <dmatlack@google.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KEXEC HANDOVER (KHO)" <kexec@lists.infradead.org>, 
	"open list:KEXEC HANDOVER (KHO)" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260512_125139_832427_6ABE8F8E 
X-CRM114-Status: GOOD (  18.63  )
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

Add a kunit test to verify the preserve/unpreserve and restore of pages
and folios by mocking the kho kunit restore stubs.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 kernel/liveupdate/Kconfig               |  10 ++
 kernel/liveupdate/Makefile              |   1 +
 kernel/liveupdate/kexec_handover_test.c | 130 ++++++++++++++++++++++++
 3 files changed, 141 insertions(+)
 create mode 100644 kernel/liveupdate/kexec_handover_test.c

diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
index c13af38ba23a..ffdfdc4080ef 100644
--- a/kernel/liveupdate/Kconfig
+++ b/kernel/liveupdate/Kconfig
@@ -49,6 +49,16 @@ config KEXEC_HANDOVER_ENABLE_DEFAULT
 	  The default behavior can still be overridden at boot time by
 	  passing 'kho=off'.
 
+config KEXEC_HANDOVER_KUNIT_TEST
+	tristate "KUnit test for Kexec Handover (KHO)"
+	depends on KEXEC_HANDOVER && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Enable Kunit tests for Kexec Handover to verify preservation and
+	  unpreservation of memory using KHO API without triggering kexec.
+
+	  If unsure, say N.
+
 config LIVEUPDATE
 	bool "Live Update Orchestrator"
 	depends on KEXEC_HANDOVER
diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
index d2f779cbe279..ed798b2401a8 100644
--- a/kernel/liveupdate/Makefile
+++ b/kernel/liveupdate/Makefile
@@ -9,5 +9,6 @@ luo-y :=								\
 obj-$(CONFIG_KEXEC_HANDOVER)		+= kexec_handover.o
 obj-$(CONFIG_KEXEC_HANDOVER_DEBUG)	+= kexec_handover_debug.o
 obj-$(CONFIG_KEXEC_HANDOVER_DEBUGFS)	+= kexec_handover_debugfs.o
+obj-$(CONFIG_KEXEC_HANDOVER_KUNIT_TEST) += kexec_handover_test.o
 
 obj-$(CONFIG_LIVEUPDATE)		+= luo.o
diff --git a/kernel/liveupdate/kexec_handover_test.c b/kernel/liveupdate/kexec_handover_test.c
new file mode 100644
index 000000000000..1113007f9ac5
--- /dev/null
+++ b/kernel/liveupdate/kexec_handover_test.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026, Google LLC
+ * Author: Samiullah Khawaja <skhawaja@google.com>
+ */
+
+#include <kunit/test.h>
+#include <kunit/static_stub.h>
+#include <linux/kexec_handover.h>
+#include <linux/gfp.h>
+#include <linux/mm.h>
+
+static struct page *kho_test_restore_pages_mock(phys_addr_t phys,
+						unsigned long nr_pages)
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
+static struct folio *kho_test_restore_folio_mock(phys_addr_t phys)
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
+static int kho_test_init(struct kunit *test)
+{
+	kunit_activate_static_stub(test, kho_restore_pages,
+				   kho_test_restore_pages_mock);
+	kunit_activate_static_stub(test, kho_restore_folio,
+				   kho_test_restore_folio_mock);
+	return 0;
+}
+
+static void kho_test_alloc_preserve(struct kunit *test)
+{
+	void *mem;
+
+	mem = kho_alloc_preserve(PAGE_SIZE);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, mem);
+
+	/* Verify if memory is preserved */
+	KUNIT_EXPECT_TRUE(test, kho_test_pages_preserved(__pa(mem), 1));
+
+	kho_restore_free(mem);
+
+	/* Memory should be unpreserved after restore_free */
+	KUNIT_EXPECT_FALSE(test, kho_test_pages_preserved(__pa(mem), 1));
+}
+
+static void kho_test_preserve_pages(struct kunit *test)
+{
+	struct page *restored;
+	struct page *page;
+	int err;
+
+	page = alloc_pages(GFP_KERNEL | __GFP_ZERO, 1);
+	KUNIT_ASSERT_NOT_NULL(test, page);
+
+	/* Preserve and verify that pages are preserved */
+	err = kho_preserve_pages(page, 2);
+	KUNIT_EXPECT_EQ(test, err, 0);
+	KUNIT_EXPECT_TRUE(test,
+			  kho_test_pages_preserved(page_to_phys(page), 2));
+
+	restored = kho_restore_pages(page_to_phys(page), 2);
+	KUNIT_EXPECT_NOT_NULL(test, restored);
+	KUNIT_EXPECT_PTR_EQ(test, restored, page);
+
+	/* Verify that the pages are not preserved */
+	KUNIT_EXPECT_FALSE(test, kho_test_pages_preserved(page_to_phys(page), 2));
+
+	__free_pages(page, 1);
+}
+
+static void kho_test_preserve_folio(struct kunit *test)
+{
+	struct folio *restored;
+	unsigned long nr_pages;
+	struct folio *folio;
+	int err;
+
+	folio = folio_alloc(GFP_KERNEL | __GFP_ZERO, 1);
+	KUNIT_ASSERT_NOT_NULL(test, folio);
+
+	nr_pages = 1 << folio_order(folio);
+
+	/* Preserve and verify that folio is preserved */
+	err = kho_preserve_folio(folio);
+	KUNIT_EXPECT_EQ(test, err, 0);
+	KUNIT_EXPECT_TRUE(test, kho_test_pages_preserved(PFN_PHYS(folio_pfn(folio)), nr_pages));
+
+	restored = kho_restore_folio(PFN_PHYS(folio_pfn(folio)));
+	KUNIT_EXPECT_NOT_NULL(test, restored);
+	KUNIT_EXPECT_PTR_EQ(test, restored, folio);
+
+	/* Verify that the folio is not preserved */
+	KUNIT_EXPECT_FALSE(test, kho_test_pages_preserved(PFN_PHYS(folio_pfn(folio)), nr_pages));
+
+	folio_put(folio);
+}
+
+static struct kunit_case kho_test_cases[] = {
+	KUNIT_CASE(kho_test_alloc_preserve),
+	KUNIT_CASE(kho_test_preserve_pages),
+	KUNIT_CASE(kho_test_preserve_folio),
+	{}
+};
+
+static struct kunit_suite kho_test_suite = {
+	.name = "kho_test",
+	.init = kho_test_init,
+	.test_cases = kho_test_cases,
+};
+
+kunit_test_suite(kho_test_suite);
+
+MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
+MODULE_DESCRIPTION("KUnit tests for Kexec Handover");
+MODULE_LICENSE("GPL");
-- 
2.54.0.563.g4f69b47b94-goog


