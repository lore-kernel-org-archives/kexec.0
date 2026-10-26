Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E37C606A320
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 17:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HIGxcoR3;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=J45mM3wd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6FbknuYB2KaKiO/nAwNHeWF6UfDvsJ7xQW+UNHo6NJE=; b=HIGxcoR37d+NMnqFOzDL+P8DM2
	uaf9hkS9bG8EFn7qxeVKcrFmiBg3JmYkGtPN9Ox0w3FVW0PS/GbdcUmHDRjKEp2bUxdVhVx2ss3CZ
	0KhxmjTZoTfBqL3PZNjtd3Pa96aEV7Wwsswp6FL91ppN77HzxBLtRQzc1zgDUBR5kap50PtTxGn7j
	OkMR28pcebjy7Yl6O4pjVoPnW+Ky2NK3pzg1jzqwlfZ9ubWsJQX1FJEAuS3zc+579KQrU+FZDsBhP
	mchU3Hp9F+vODYM6UvguDe5jBJ6Dci0jMaaoj39QvFarodcWDOtxdNXYC1esqi/AD7a5hDQA7Jd5q
	ZkryyuXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLOiN-000000030Z8-3zSH;
	Mon, 26 Oct 2026 17:42:31 +0000
Received: from mail-ej1-x647.google.com ([2a00:1450:4864:20::647])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLOiJ-000000030Wv-0i1D
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 17:42:28 +0000
Received: by mail-ej1-x647.google.com with SMTP id a640c23a62f3a-c40bbd26f74so268656266b.0
        for <kexec@lists.infradead.org>; Mon, 26 Oct 2026 10:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793036545; x=1793641345; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6FbknuYB2KaKiO/nAwNHeWF6UfDvsJ7xQW+UNHo6NJE=;
        b=J45mM3wdq8GRibmKkA4N16hrcXUXs5krOnYwFHA+HB5wpkVQRBuWr6N6PJJ8MmyjNg
         Lsiu8vuwOncHi5oQn8ChAIqEx+ioYbUJKHhWsAb1gX6egobIWhtjQkJe/cUgBdHtZGmy
         YP0I3wIxEIJ7wizybT9l02+W/F6BZU8qMOIfaV2FVluonggLCnId6h4KBvnRof52H/2L
         Dsl9/hJ3s0IrziRHhS3tKBUPNuaG4IZC8BapB+5VIbjZ3wIZT3v9ORsuUHEt8uS5BMQA
         78lat3YCASAw3kiLzoTG/9ig6EmGXhYcdsSLh8j798wiG+v6O2IQ5lt18CcYlSJR+4J0
         NwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793036545; x=1793641345;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6FbknuYB2KaKiO/nAwNHeWF6UfDvsJ7xQW+UNHo6NJE=;
        b=2apBDsaU0Sa/CYV/ygdMZb4KieuR7u16qk4I7NJE6lc/kKMcj2xsKIXsziqfjdbtSh
         3rG5v7t2Q+vouNEX3ZTCa6doCth85vD0byvt57D7ig2yDXNVBPs91iqE1zkCUAKGx8Ts
         2jcV5sY2cDl3RaqUTrtYWQsLanTqtI+dsAKp/TSo74r3d3mOpdDvFJ+iC8QB+NgmFQ0r
         CU7k1ex7p3TEa860CerxnXVcdhF2t4nbksmGSd/gX2MJ9yDwYxj1mh7FlHx03j1COsO1
         /LiP499RB2TIhN08rAOqSTHm4nDPQYbTBNN9FDBOyGFD9HEnaBjP04TjYJIf0eIHi0Tf
         su4g==
X-Forwarded-Encrypted: i=1; AKwUvBwP6g7SgJFTcgqEXWhSTJN07pW/nE/kzoKlYahUEQCqv/95rUogzfMYcS3LnwvqlWoQuofEDg==@lists.infradead.org
X-Gm-Message-State: AFq9FYKwFdRA4YbhytWAITxbAmoIj3fRbPJifgI0RtKwrbJ46v2H/tBY
	9SzQmjTJQBSIh6OCYhzmQASp59Z1vMgdxSKvwA45zGkCRj3K8a4XVXEgWzdPla+Rbo5FCyn2fqn
	n1qzxe6vLpSGu9Ul1LQ==
X-Received: from ejczw1-n1.prod.google.com ([2002:a17:907:e001:10b0:c42:73df:9346])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:f585:b0:c41:e75e:5889 with SMTP id a640c23a62f3a-c46bde3a942mr794298266b.33.1793036543707;
 Mon, 26 Oct 2026 10:42:23 -0700 (PDT)
Date: Mon, 26 Oct 2026 17:42:17 +0000
In-Reply-To: <20261026174217.603114-1-tarunsahu@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261026174217.603114-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261026174217.603114-5-tarunsahu@google.com>
Subject: [RFC PATCH v3 4/4] liveupdate: Add KUnit test for the feature header helpers
From: Tarun Sahu <tarunsahu@google.com>
To: loganodell@google.com, alex@shazbot.org, dwmw2@infradead.org, 
	seanjc@google.com, Mike Rapoport <rppt@kernel.org>, will@kernel.org, pbonzini@redhat.com, 
	jgg@nvidia.com, Pasha Tatashin <pasha.tatashin@soleen.com>, arnd@arndb.de, 
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, oupton@kernel.org, 
	baolu.lu@linux.intel.com, David Matlack <dmatlack@google.com>, robin.murphy@arm.com, 
	maz@kernel.org, Alexander Graf <graf@amazon.com>, joro@8bytes.org, 
	Bjorn Helgaas <bhelgaas@google.com>, kevin.tian@intel.com, 
	Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261026_104227_271912_887A69E4 
X-CRM114-Status: GOOD (  19.15  )
X-Spam-Score: -9.5 (---------)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-26.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a KUnit test suite in lib/tests/liveupdate_feature_kunit.c covering
the Live Update feature header declared in include/linux/kho/abi/luo.h.

The suite contains two focused test cases:
- luo_ser_hdr_set_get_test: verifies DECLARE_LUO_SER_WRAP structure
  sizing, header initialization, payload pointer resolution, and 2-bit
  feature flag setting and retrieval across flags entry boundaries,
  including out-of-range queries.
- luo_ser_hdr_truth_table_test: verifies luo_ser_hdr_validate against
  all rows of the feature state truth table (absent, optional,
  required, and reserved 0b10 encodings), as well as empty supported
  tables.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 MAINTAINERS                          |   1 +
 lib/Kconfig.debug                    |  16 ++++
 lib/tests/Makefile                   |   1 +
 lib/tests/liveupdate_feature_kunit.c | 118 +++++++++++++++++++++++++++
 4 files changed, 136 insertions(+)
 create mode 100644 lib/tests/liveupdate_feature_kunit.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5d1b58271989..dad09961c275 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15191,6 +15191,7 @@ F:	include/linux/liveupdate.h
 F:	include/uapi/linux/liveupdate.h
 F:	kernel/liveupdate/
 F:	lib/tests/liveupdate.c
+F:	lib/tests/liveupdate_feature_kunit.c
 F:	mm/memfd_luo.c
 F:	tools/testing/selftests/liveupdate/
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 134b15a44625..d8208f3f4515 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2906,6 +2906,22 @@ config LIVEUPDATE_TEST
 
 	  If unsure, say N
 
+config LIVEUPDATE_FEATURE_KUNIT_TEST
+	tristate "KUnit test for the Live Update feature header helpers" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This option enables the KUnit test suite for the Live Update
+	  Orchestrator feature header helpers defined in
+	  include/linux/kho/abi/luo.h. It checks the feature flag encoding,
+	  the flags array sizing, the source/target kernel validation
+	  truth table, header initialization and the payload size checks.
+
+	  The helpers are self-contained, so the test does not depend on
+	  CONFIG_LIVEUPDATE and can also run under UML.
+
+	  If unsure, say N.
+
 config CMDLINE_KUNIT_TEST
 	tristate "KUnit test for cmdline API" if !KUNIT_ALL_TESTS
 	depends on KUNIT
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index 3cac3b63a752..2f1f1f765617 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_KFIFO_KUNIT_TEST) += kfifo_kunit.o
 obj-$(CONFIG_TEST_LIST_SORT) += test_list_sort.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
 obj-$(CONFIG_LIVEUPDATE_TEST) += liveupdate.o
+obj-$(CONFIG_LIVEUPDATE_FEATURE_KUNIT_TEST) += liveupdate_feature_kunit.o
 
 CFLAGS_longest_symbol_kunit.o += $(call cc-disable-warning, missing-prototypes)
 obj-$(CONFIG_LONGEST_SYM_KUNIT_TEST) += longest_symbol_kunit.o
diff --git a/lib/tests/liveupdate_feature_kunit.c b/lib/tests/liveupdate_feature_kunit.c
new file mode 100644
index 000000000000..fc9d2de263d9
--- /dev/null
+++ b/lib/tests/liveupdate_feature_kunit.c
@@ -0,0 +1,118 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for the Live Update Orchestrator feature header helpers
+ * in include/linux/kho/abi/luo.h.
+ *
+ * Copyright (c) 2026, Google LLC.
+ * Tarun Sahu <tarunsahu@google.com>
+ */
+
+#include <kunit/test.h>
+#include <linux/kho/abi/luo.h>
+#include <linux/module.h>
+
+struct luo_test_multi_ser {
+	u64 val;
+};
+
+static_assert(sizeof(struct luo_test_multi_ser) == 8);
+DECLARE_LUO_SER_WRAP(luo_test_multi_ser, 32, 35);
+
+struct luo_test_one_ser {
+	u64 val;
+};
+
+static_assert(sizeof(struct luo_test_one_ser) == 8);
+DECLARE_LUO_SER_WRAP(luo_test_one_ser, 24, 1);
+
+struct luo_test_zero_ser {
+	u64 val;
+};
+
+static_assert(sizeof(struct luo_test_zero_ser) == 8);
+DECLARE_LUO_SER_WRAP(luo_test_zero_ser, 16, 0);
+
+static void luo_ser_hdr_set_get_test(struct kunit *test)
+{
+	struct luo_test_multi_ser_wrap out;
+	struct luo_test_zero_ser_wrap zero;
+
+	memset(&out, 0, sizeof(out));
+	luo_test_multi_ser_wrap_init(&out);
+
+	KUNIT_EXPECT_EQ(test, out.hdr.size, 32U);
+	KUNIT_EXPECT_EQ(test, out.hdr.nr_features, 35U);
+	KUNIT_EXPECT_EQ(test, LUO_SER_NR_FLAGS(out.hdr.nr_features), 2U);
+	KUNIT_EXPECT_EQ(test, luo_ser_hdr_size(&out.hdr), 24UL);
+	KUNIT_EXPECT_PTR_EQ(test, luo_ser_payload(&out.hdr), (void *)&out.ser);
+
+	/* 0, 31 in flags[0]; 32, 34 in flags[1] */
+	luo_ser_set_feat(&out.hdr, 0, LUO_FEAT_REQUIRED);
+	luo_ser_set_feat(&out.hdr, 31, LUO_FEAT_OPTIONAL);
+	luo_ser_set_feat(&out.hdr, 32, LUO_FEAT_REQUIRED);
+	luo_ser_set_feat(&out.hdr, 34, LUO_FEAT_OPTIONAL);
+
+	KUNIT_EXPECT_EQ(test, (int)luo_ser_get_feat(&out.hdr, 0), (int)LUO_FEAT_REQUIRED);
+	KUNIT_EXPECT_EQ(test, (int)luo_ser_get_feat(&out.hdr, 1), (int)LUO_FEAT_ABSENT);
+	KUNIT_EXPECT_EQ(test, (int)luo_ser_get_feat(&out.hdr, 31), (int)LUO_FEAT_OPTIONAL);
+	KUNIT_EXPECT_EQ(test, (int)luo_ser_get_feat(&out.hdr, 32), (int)LUO_FEAT_REQUIRED);
+	KUNIT_EXPECT_EQ(test, (int)luo_ser_get_feat(&out.hdr, 33), (int)LUO_FEAT_ABSENT);
+	KUNIT_EXPECT_EQ(test, (int)luo_ser_get_feat(&out.hdr, 34), (int)LUO_FEAT_OPTIONAL);
+
+	KUNIT_EXPECT_EQ(test, (int)luo_ser_get_feat(&out.hdr, 35), (int)LUO_FEAT_ABSENT);
+	KUNIT_EXPECT_EQ(test, (int)luo_ser_get_feat(&out.hdr, 100), (int)LUO_FEAT_ABSENT);
+
+	memset(&zero, 0, sizeof(zero));
+	luo_test_zero_ser_wrap_init(&zero);
+	KUNIT_EXPECT_EQ(test, sizeof(struct luo_ser_hdr), 8UL);
+	KUNIT_EXPECT_EQ(test, luo_ser_hdr_size(&zero.hdr), 8UL);
+	KUNIT_EXPECT_PTR_EQ(test, luo_ser_payload(&zero.hdr), (void *)&zero.ser);
+	KUNIT_EXPECT_EQ(test, luo_ser_hdr_validate(&zero.hdr, NULL, 0), 0);
+}
+
+static void luo_ser_hdr_truth_table_test(struct kunit *test)
+{
+	struct luo_test_one_ser_wrap out;
+	bool supp_yes[1] = { true };
+	bool supp_no[1] = { false };
+
+	memset(&out, 0, sizeof(out));
+	luo_test_one_ser_wrap_init(&out);
+	luo_ser_set_feat(&out.hdr, 0, LUO_FEAT_ABSENT);
+	KUNIT_EXPECT_EQ(test, luo_ser_hdr_validate(&out.hdr, supp_no, 1), 0);
+
+	luo_ser_set_feat(&out.hdr, 0, LUO_FEAT_OPTIONAL);
+	KUNIT_EXPECT_EQ(test, luo_ser_hdr_validate(&out.hdr, supp_no, 1), 0);
+	KUNIT_EXPECT_EQ(test, luo_ser_hdr_validate(&out.hdr, supp_yes, 1), 0);
+
+	luo_ser_set_feat(&out.hdr, 0, LUO_FEAT_REQUIRED);
+	KUNIT_EXPECT_EQ(test, luo_ser_hdr_validate(&out.hdr, supp_no, 1),
+			-EOPNOTSUPP);
+	KUNIT_EXPECT_EQ(test, luo_ser_hdr_validate(&out.hdr, supp_yes, 1), 0);
+
+	out.flags[0] = (u64)LUO_FEAT_RESERVED;
+	KUNIT_EXPECT_EQ(test, luo_ser_hdr_validate(&out.hdr, supp_no, 1), 0);
+	KUNIT_EXPECT_EQ(test, luo_ser_hdr_validate(&out.hdr, supp_yes, 1), 0);
+
+	luo_ser_set_feat(&out.hdr, 0, LUO_FEAT_REQUIRED);
+	KUNIT_EXPECT_EQ(test, luo_ser_hdr_validate(&out.hdr, NULL, 0),
+			-EOPNOTSUPP);
+	luo_ser_set_feat(&out.hdr, 0, LUO_FEAT_OPTIONAL);
+	KUNIT_EXPECT_EQ(test, luo_ser_hdr_validate(&out.hdr, NULL, 0), 0);
+}
+
+static struct kunit_case luo_feature_test_cases[] = {
+	KUNIT_CASE(luo_ser_hdr_set_get_test),
+	KUNIT_CASE(luo_ser_hdr_truth_table_test),
+	{}
+};
+
+static struct kunit_suite luo_feature_test_suite = {
+	.name = "liveupdate_feature",
+	.test_cases = luo_feature_test_cases,
+};
+
+kunit_test_suite(luo_feature_test_suite);
+
+MODULE_DESCRIPTION("KUnit tests for the Live Update feature header helpers");
+MODULE_LICENSE("GPL");
-- 
2.56.0.307.g5fe7bd680c-goog


