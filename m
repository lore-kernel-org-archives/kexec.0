Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 378B1CD5BAC
	for <kexec@archiver.kernel.org>; Thu, 21 May 2026 19:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ncOCeCfKsOq2argSmTVmNq9obkxAz4X3VwJeLEeWDgg=; b=D4zqus2fv4KS6gZkok4Fiw9o7j
	qNtvcDIi3QgonbpPFXjTay2a4ObldI3bCaalw4bjEHcNWN/+iN9Xq/58K1J4ugRzY+a4grqrtA96D
	VQ8vUGlgmveTPfn9xg2OXJW+B1ZH6L2lRqQ29yFW7g8aR33PiYKGjwUDvVm571k+3vSwwpRhXAJ7b
	DbRbIxx64NYasWkN8hBgxMpIX5KgnXt/gIPb86z4d0uhF5P/MFxVXRQ67T/FNKbLouy9m6hRz5zBm
	9vhEd5gLVPG3hG/PP8TmUWZvN+eXo/XoYOw3g5cl4BuKlzMYk85N3ULl28Sr0xdLorseJxwaPCiRX
	+0AEZuMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ97u-00000008uz6-1BQZ;
	Thu, 21 May 2026 19:32:14 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ97s-00000008uxt-2U2c
	for kexec@bombadil.infradead.org;
	Thu, 21 May 2026 19:32:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ncOCeCfKsOq2argSmTVmNq9obkxAz4X3VwJeLEeWDgg=; b=YggAnsIYVM+ylUzvzDH4W7gA3b
	QORQRKqNCDDJy/u81NQ7czrwr0GPAcJGmyHhkby3+9Pg2ZCCR2bR8oY7gt6lONy6VTP1uL1fvbQ4D
	xV5dN0cZV2PC8y7uBzPxSe21+YJzrRnvGoSrYACQbBaN6K5Qccs8wf3R+Wng2knkSgeYs5O2zGkcj
	Nt0dj2w3fK+JHEGUEknw+/eKbDh4TQ75r1fKtL2hhIbhADbqUMXTMbl4XhK8X/LvhcA/ToKb/EioB
	BNC/r6vqcQY+pOt7cKWPXSl5R8i0dtvspA+XRFeYl/ttDa7PZEbJDSiTZ/9yQil9TnN7mevLm5yNM
	yYXyFBNQ==;
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ97o-00000002omB-1Miq
	for kexec@lists.infradead.org;
	Thu, 21 May 2026 19:32:11 +0000
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-836cfd84728so3338430b3a.0
        for <kexec@lists.infradead.org>; Thu, 21 May 2026 12:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779391926; x=1779996726; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ncOCeCfKsOq2argSmTVmNq9obkxAz4X3VwJeLEeWDgg=;
        b=aJ7qITsHzLrB4H96c8gZZSWe3L3Is3ar+QOAkRikgYdr9d035oE/bhWpYbT1fFtCQv
         2BCGhSIrk+BHfkFilYt7R9u1fZPDOOIhoolTkjj6ptCAci8SdI4I6uM5iK57kWcmT0mr
         hXyNMwuAaY6EAsYgDlG5xQaKgtG8A55PTbrVOpKBP668UAp1EemByG6v097kTYNG7E9t
         3w+dS7pXHX0HzfAHewVmldoF4ao91fipelpV+GPnMO9VAnRVm6OiI4JOrPYuPT5SbB56
         piqL+i0yOgLMxIb1exu8SSzKXCpxkyNijxYFy2ffcHGhQrP7U9XlMqCY/ROk9XPaIrE9
         Xg9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779391926; x=1779996726;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ncOCeCfKsOq2argSmTVmNq9obkxAz4X3VwJeLEeWDgg=;
        b=PwmP+tYn33UTozN80J5SyjKkxgNUjOjUlE3SPzl2cV74I2BRSz/6eA2D7t842xhxhR
         HV5KCUrYCSGixrMgn7ZoURQF5vTbew0t/lDINrUZdBg6qKRfrH1qMMZqWSIpyjieuDwH
         NLpYgcCwMxEp6Uy0enbXwS+lt9324G2AH+yM72clJCcM78+YWRZHgREgLfkpKiEHTR5s
         vf+O7gPElkbIrozEz6KbO+LL4Hsy8TvJZgPFt3oc9QblJMvRYpuCywShzNU/mLqOuiSk
         Cpyq0ct6FNFFEguMigXyu9eXx46a4vMzicdrk0ACIGUXxDwan1QuSH5kzae3gNWQC/RP
         UzWg==
X-Forwarded-Encrypted: i=1; AFNElJ/091zQ09aeSnmT4oE5yDfmjmTj8gOhUNuTByVZtxNB3bsrNNoSssyz3jwohypSXuGaKZUIWw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz+JxILkZ/Bi1ZT2GsyEQBg6NrAj1e0qeIIC0mZAhWOQRDHd5xG
	lvu8QKtY6wMkEIt/X8eqJkw2G+gonlRdxV6JY4ZRNxlHNwlq8hFYJpXg4qQJUloG9m8Nx/6KCtR
	U5Ncurx1oPKW1UQ==
X-Received: from pfll21.prod.google.com ([2002:a05:6a00:1595:b0:82f:93e5:c64c])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:847:b0:82c:7420:82bf with SMTP id d2e1a72fcca58-84161176bddmr117690b3a.19.1779391925396;
 Thu, 21 May 2026 12:32:05 -0700 (PDT)
Date: Thu, 21 May 2026 19:32:02 +0000
In-Reply-To: <20260521193202.746810-1-skhawaja@google.com>
Mime-Version: 1.0
References: <20260521193202.746810-1-skhawaja@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260521193202.746810-4-skhawaja@google.com>
Subject: [PATCH v2 3/3] kho: Add kunit test to verify preserve/restore pages
 and folio
From: Samiullah Khawaja <skhawaja@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: Samiullah Khawaja <skhawaja@google.com>, David Matlack <dmatlack@google.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KEXEC HANDOVER (KHO)" <kexec@lists.infradead.org>, 
	"open list:KEXEC HANDOVER (KHO)" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_203209_369413_C5A6C77C 
X-CRM114-Status: GOOD (  18.23  )
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
 kernel/liveupdate/kexec_handover_test.c | 131 ++++++++++++++++++++++++
 3 files changed, 142 insertions(+)
 create mode 100644 kernel/liveupdate/kexec_handover_test.c

diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
index 1a8513f16ef7..d2623f60c0dd 100644
--- a/kernel/liveupdate/Kconfig
+++ b/kernel/liveupdate/Kconfig
@@ -51,6 +51,16 @@ config KEXEC_HANDOVER_ENABLE_DEFAULT
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
index 000000000000..9e6dca45c3f3
--- /dev/null
+++ b/kernel/liveupdate/kexec_handover_test.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026, Google LLC
+ * Author: Samiullah Khawaja <skhawaja@google.com>
+ */
+
+#include <kunit/test.h>
+#include <kunit/static_stub.h>
+
+#include <linux/gfp.h>
+#include <linux/kexec_handover.h>
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
2.54.0.746.g67dd491aae-goog


