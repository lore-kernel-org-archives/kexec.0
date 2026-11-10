Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F83060A2601
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 05:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=K8ZnIOSC;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=RqY1cnou;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=RMg6X2mQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=uCmKHaalBs1Mwi3hIIcbxr5U+8imaxCzGUPXqbL7HOI=; b=K8ZnIOSCSSHKLqtpqWCi4kAQfl
	FRUKsQnpLTYRO2hRyotcHXm3oZAF49tcOYjfJI6ZEFv/PeS6LNDb1gxgZmwOxQ4mnCE4nFh8ElyYw
	11n9gXMnbxJeXYkW+gkB1FKCANUO9PRlsYDVyznE9XA8t7QAmsM0xXvrVQcTLJRbgYdXAzke4ljNL
	9uYq7V0FA69SSOxzW95htr8A1Wx+aHuvnI+HsCAC4eHLVLSGkxqeEpiXC3kXevJjnCLu3PC90srme
	SIS/RmcRHqito2wr3z+FwpEGjim/1Nr+/VyJgOi1mRzKbaAlqKkt74NPZ1O4tMX5zcBjAz+gchR/k
	5ix2io4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQe0L-00000002SFa-2iRA;
	Tue, 10 Nov 2026 05:02:45 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQe09-00000002Rmz-2QNf
	for kexec@bombadil.infradead.org;
	Tue, 10 Nov 2026 05:02:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uCmKHaalBs1Mwi3hIIcbxr5U+8imaxCzGUPXqbL7HOI=; b=RqY1cnouAZ3WJofqJwudr6um/b
	szqUlXpZpLfgfnytB45lHnxBOeZgnH6b+rCNA0DQ3MOQrKjXChmv+ZqlECyYmeEMm/yPU4VNO2jW5
	d5OU5Qmozm0pQySg67Ecg0PzqqRPmeE7hfrIR8tpn4kh9DWHpyB3wHtNod4kg4b6yHbFA3M9PeeS8
	1tS+oyLXzyrAKUzVR7DPl0QGlw3nCl+zlmHrLS7zF1NkFrCTm+1TuFdVTVxQsysKhFwVLiy3twOKb
	9wGPWRHiF5M09Uj1yw8TdrCVdW4Yv3NGJquswtGIcmYZhNKNazKfp3T/5zppHUyQI5IeoOe17d+l9
	/1sbg4ZQ==;
Received: from mail-ed1-x545.google.com ([2a00:1450:4864:20::545])
	by casper.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQe04-000000077pk-1dpw
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 05:02:32 +0000
Received: by mail-ed1-x545.google.com with SMTP id 4fb4d7f45d1cf-6b564783d3fso1757358a12.0
        for <kexec@lists.infradead.org>; Mon, 09 Nov 2026 21:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794286946; x=1794891746; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uCmKHaalBs1Mwi3hIIcbxr5U+8imaxCzGUPXqbL7HOI=;
        b=RMg6X2mQa6HwFLOfK0o1+p1pXBV6skbbheLRPD52evWfeHf3Z62fT3GUr6ebrLwi1m
         dw6Ld0jvFZwuu9sAeKfQQSZOMrLbYshS4H68rAK0ypgPYv0/VgCwHiKdiU7tazhvS0lG
         MFSnCm0cIEjbUsg9oiMIR4iYwVP2qynfBapi7zDXdgXXzZGu2k5pFH8sqeD41/ClyHiE
         2YIIHkOvA6/pvDv1YLCFYFrH3s+hxfYaBQYpBRk7L/SPad1MAJoE8ArLesy26OgaI1DP
         16cNJOvQNLXPaBJ3i3prU8l7zgRAvJnw79GTh4X+/IfB1ZFIxgM7rxBQNse95p6CWM5/
         NVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286946; x=1794891746;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uCmKHaalBs1Mwi3hIIcbxr5U+8imaxCzGUPXqbL7HOI=;
        b=a64+0XnU3HQz1K5V2kU4HfUo990rbQ8v5ieQIkByS9oP+49eE6T25Uh8NDHSqw+tee
         yjW10/+cH+Y00Omuihh+41w3M6CJIQBUtEk7X58srStWaUe7PrwUNIdMu1s1ZZqkxvtA
         Oy6syXXVxKK1ClU0fj+vo8gFMPku6WKFxqWodDdLiHSvSVPzq9C1KEnnGvD0IF22tpJd
         zBntmJPZJ4HGGyPnKSnBfbSyzzAnR8RF50ezMz2cJ8TPz7wPeYtawQv1AfdS8nbRP5TQ
         QPk4rbUZOvx2XhLim+QFqMj0SZ1+eXXCOzQVReGBgzYcWsLZTG2QCs47MTrBK3CsW94x
         tnwA==
X-Forwarded-Encrypted: i=1; AL+hErGc4H48ZOYQ/dJ+7Z95KrNLk5uRwWHDJoJfM2+HIi/d6zcSv2NGrVWaicGVG6Ja/PSBHtnilw==@lists.infradead.org
X-Gm-Message-State: APuU4Z839X+IE39gxM2Jb7h8kFvTS/r1VA34zJXjt7BsPHKLEApmYiyh
	plDUmpWTmTCd9s9cTwcGNaTKHj8/DOnngrL+d7ZHX8DTbo0/KWKKyhjB/KzEHetFn9K0WEB8f5y
	OlBv9TxS3g5S6ypBWIA==
X-Received: from ejpc8.prod.google.com ([2002:a17:906:54c8:b0:c3f:c35a:7704])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:3d0d:b0:c49:a571:c4f9 with SMTP id a640c23a62f3a-c50494b4c4fmr100815566b.13.1794286946299;
 Mon, 09 Nov 2026 21:02:26 -0800 (PST)
Date: Tue, 10 Nov 2026 05:02:02 +0000
In-Reply-To: <20261110050202.529473-1-tarunsahu@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261110050202.529473-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
Message-ID: <20261110050202.529473-20-tarunsahu@google.com>
Subject: [PATCH v4 19/19] kho: Add KUnit test for the feature header helpers
From: Tarun Sahu <tarunsahu@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, 
	maz@kernel.org, will@kernel.org, David Matlack <dmatlack@google.com>, 
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, 
	arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	Bjorn Helgaas <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, 
	gle.com@google.com, pbonzini@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: kvmarm@lists.linux.dev, linux-pci@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	skhawaja@google.com, sagis@google.com, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_050228_976650_0CD6DC21 
X-CRM114-Status: GOOD (  17.62  )
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
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a KUnit test suite in lib/tests/kho_feature_kunit.c covering
the Kexec HandOver feature header declared in
include/linux/kho/abi/feature.h.

The suite contains three focused test cases:
- kho_ser_hdr_zero_flags_test: verifies zero-feature header
  initialization, payload sizing, and empty feature queries.
- kho_ser_hdr_set_get_test: verifies DECLARE_KHO_SER structure sizing,
  header initialization, payload pointer resolution, and 1-bit
  feature flag setting and retrieval across flags entry boundaries,
  including out-of-range queries.
- kho_ser_hdr_validate_test: verifies __kho_ser_validate rejecting
  unsupported required feature flags while ignoring optional flags.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 MAINTAINERS                   |   1 +
 lib/Kconfig.debug             |  13 +++
 lib/tests/Makefile            |   1 +
 lib/tests/kho_feature_kunit.c | 184 ++++++++++++++++++++++++++++++++++
 4 files changed, 199 insertions(+)
 create mode 100644 lib/tests/kho_feature_kunit.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1572f6c905aa..0b50de45140f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14786,6 +14786,7 @@ F:	include/linux/kho/
 F:	include/linux/kho_block.h
 F:	kernel/liveupdate/kexec_handover*
 F:	lib/test_kho.c
+F:	lib/tests/kho_feature_kunit.c
 F:	tools/testing/selftests/kho/
 
 KEYS-ENCRYPTED
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2d22638ec13a..3d74d32b181d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2967,6 +2967,19 @@ config DIMLIB_KUNIT_TEST
 	  For more information on KUnit and unit tests in general please refer
 	  to the KUnit documentation in Documentation/dev-tools/kunit/.
 
+config KHO_FEATURE_KUNIT_TEST
+	tristate "KUnit test for the Kexec HandOver feature header helpers" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This option enables the KUnit test suite for the Kexec HandOver
+	  feature header helpers defined in include/linux/kho/abi/feature.h.
+	  It checks the feature flag encoding, the flags array sizing, the
+	  feature bit helpers, and header validation rules.
+
+	  The helpers are self-contained, so the test does not depend on
+	  CONFIG_KEXEC_HANDOVER and can also run under UML.
+
 	  If unsure, say N.
 
 config CMDLINE_KUNIT_TEST
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index df0537e1b91f..f22a4552f755 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_KFIFO_KUNIT_TEST) += kfifo_kunit.o
 obj-$(CONFIG_TEST_LIST_SORT) += test_list_sort.o
 obj-$(CONFIG_LINEAR_RANGES_TEST) += test_linear_ranges.o
 obj-$(CONFIG_LIVEUPDATE_TEST) += liveupdate.o
+obj-$(CONFIG_KHO_FEATURE_KUNIT_TEST) += kho_feature_kunit.o
 
 CFLAGS_longest_symbol_kunit.o += $(call cc-disable-warning, missing-prototypes)
 obj-$(CONFIG_LONGEST_SYM_KUNIT_TEST) += longest_symbol_kunit.o
diff --git a/lib/tests/kho_feature_kunit.c b/lib/tests/kho_feature_kunit.c
new file mode 100644
index 000000000000..db36895d53f5
--- /dev/null
+++ b/lib/tests/kho_feature_kunit.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for the Kexec HandOver feature header helpers
+ * in include/linux/kho/abi/feature.h.
+ *
+ * Copyright (c) 2026, Google LLC.
+ * Tarun Sahu <tarunsahu@google.com>
+ */
+
+#include <kunit/test.h>
+#include <linux/kho/abi/feature.h>
+#include <linux/module.h>
+
+struct test_kho_payload {
+	u64 val;
+};
+
+enum test_kho_req_feat {
+	TEST_KHO_REQ_0 = 0,
+	TEST_KHO_REQ_63 = 63,
+	TEST_KHO_REQ_64 = 64,
+	TEST_KHO_REQ_69 = 69,
+	TEST_KHO_NR_REQUIRED = 70,
+};
+
+enum test_kho_opt_feat {
+	TEST_KHO_OPT_0 = 0,
+	TEST_KHO_OPT_63 = 63,
+	TEST_KHO_OPT_64 = 64,
+	TEST_KHO_OPT_69 = 69,
+	TEST_KHO_NR_OPTIONAL = 70,
+};
+
+DECLARE_KHO_SER(test_kho_payload, 8, TEST_KHO_NR_REQUIRED, TEST_KHO_NR_OPTIONAL);
+
+struct test_kho_zero {
+	u64 val;
+};
+
+DECLARE_KHO_SER(test_kho_zero, 8, 0, 0);
+
+static void kho_ser_hdr_zero_flags_test(struct kunit *test)
+{
+	DECLARE_KHO_SER_HDR(test_kho_zero, *fhdr);
+	const DECLARE_KHO_SER_HDR(test_kho_zero, *const_fhdr);
+	u8 buf[kho_ser_size(test_kho_zero)] __aligned(8);
+	struct test_kho_zero *p;
+
+	KUNIT_EXPECT_EQ(test, sizeof(struct kho_ser_hdr), 8UL);
+	KUNIT_EXPECT_EQ(test, sizeof(*fhdr), sizeof(struct kho_ser_hdr));
+	KUNIT_EXPECT_EQ(test, kho_ser_size(test_kho_zero), 16UL);
+
+	fhdr = (void *)buf;
+	kho_ser_init(fhdr, test_kho_zero);
+	KUNIT_EXPECT_EQ(test, fhdr->size, 16U);
+	KUNIT_EXPECT_EQ(test, fhdr->nr_required, 0U);
+	KUNIT_EXPECT_EQ(test, fhdr->nr_optional, 0U);
+	KUNIT_EXPECT_EQ(test, kho_ser_hdr_size(fhdr), 8UL);
+
+	const_fhdr = fhdr;
+	KUNIT_EXPECT_EQ(test, const_fhdr->size, 16U);
+
+	p = kho_ser_payload(fhdr, test_kho_zero);
+	KUNIT_EXPECT_PTR_EQ(test, p, (void *)(buf + 8));
+
+	p = kho_ser_payload(const_fhdr, test_kho_zero);
+	KUNIT_EXPECT_PTR_EQ(test, p, (void *)(buf + 8));
+
+	KUNIT_EXPECT_FALSE(test, kho_ser_has_required(fhdr, 0));
+	KUNIT_EXPECT_FALSE(test, kho_ser_has_optional(fhdr, 0));
+	KUNIT_EXPECT_EQ(test, kho_ser_validate(fhdr, test_kho_zero), 0);
+	KUNIT_EXPECT_EQ(test, kho_ser_validate(const_fhdr, test_kho_zero), 0);
+}
+
+static void kho_ser_hdr_set_get_test(struct kunit *test)
+{
+	DECLARE_KHO_SER_HDR(test_kho_payload, *fhdr);
+	const DECLARE_KHO_SER_HDR(test_kho_payload, *const_fhdr);
+	u8 buf[kho_ser_size(test_kho_payload)] __aligned(8);
+	struct test_kho_payload *p;
+
+	KUNIT_EXPECT_EQ(test, kho_ser_size(test_kho_payload), 40UL);
+
+	fhdr = (void *)buf;
+	kho_ser_init(fhdr, test_kho_payload);
+	KUNIT_EXPECT_EQ(test, fhdr->size, 40U);
+	KUNIT_EXPECT_EQ(test, fhdr->nr_required, 70U);
+	KUNIT_EXPECT_EQ(test, fhdr->nr_optional, 70U);
+	KUNIT_EXPECT_EQ(test, kho_ser_hdr_size(fhdr), 32UL);
+
+	const_fhdr = fhdr;
+	KUNIT_EXPECT_EQ(test, const_fhdr->size, 40U);
+	KUNIT_EXPECT_EQ(test, const_fhdr->nr_required, 70U);
+	KUNIT_EXPECT_EQ(test, const_fhdr->nr_optional, 70U);
+
+	p = kho_ser_payload(fhdr, test_kho_payload);
+	KUNIT_EXPECT_PTR_EQ(test, p, (void *)(buf + 32));
+
+	p = kho_ser_payload(const_fhdr, test_kho_payload);
+	KUNIT_EXPECT_PTR_EQ(test, p, (void *)(buf + 32));
+
+	kho_ser_set_required(fhdr, TEST_KHO_REQ_0);
+	kho_ser_set_required(fhdr, TEST_KHO_REQ_63);
+	kho_ser_set_required(fhdr, TEST_KHO_REQ_64);
+	kho_ser_set_required(fhdr, TEST_KHO_REQ_69);
+
+	KUNIT_EXPECT_TRUE(test, kho_ser_has_required(fhdr, TEST_KHO_REQ_0));
+	KUNIT_EXPECT_FALSE(test, kho_ser_has_required(fhdr, 1));
+	KUNIT_EXPECT_TRUE(test, kho_ser_has_required(fhdr, TEST_KHO_REQ_63));
+	KUNIT_EXPECT_TRUE(test, kho_ser_has_required(fhdr, TEST_KHO_REQ_64));
+	KUNIT_EXPECT_FALSE(test, kho_ser_has_required(fhdr, 65));
+	KUNIT_EXPECT_TRUE(test, kho_ser_has_required(fhdr, TEST_KHO_REQ_69));
+
+	KUNIT_EXPECT_TRUE(test, !!(fhdr->flags[0] & (1ULL << 0)));
+	KUNIT_EXPECT_TRUE(test, !!(fhdr->flags[0] & (1ULL << 63)));
+	KUNIT_EXPECT_TRUE(test, !!(fhdr->flags[1] & (1ULL << 0)));
+	KUNIT_EXPECT_TRUE(test, !!(fhdr->flags[1] & (1ULL << 5)));
+
+	kho_ser_set_optional(fhdr, TEST_KHO_OPT_0);
+	kho_ser_set_optional(fhdr, TEST_KHO_OPT_63);
+	kho_ser_set_optional(fhdr, TEST_KHO_OPT_64);
+	kho_ser_set_optional(fhdr, TEST_KHO_OPT_69);
+
+	KUNIT_EXPECT_TRUE(test, kho_ser_has_optional(fhdr, TEST_KHO_OPT_0));
+	KUNIT_EXPECT_FALSE(test, kho_ser_has_optional(fhdr, 1));
+	KUNIT_EXPECT_TRUE(test, kho_ser_has_optional(fhdr, TEST_KHO_OPT_63));
+	KUNIT_EXPECT_TRUE(test, kho_ser_has_optional(fhdr, TEST_KHO_OPT_64));
+	KUNIT_EXPECT_FALSE(test, kho_ser_has_optional(fhdr, 65));
+	KUNIT_EXPECT_TRUE(test, kho_ser_has_optional(fhdr, TEST_KHO_OPT_69));
+
+	KUNIT_EXPECT_TRUE(test, !!(fhdr->flags[1] & (1ULL << 6)));
+	KUNIT_EXPECT_TRUE(test, !!(fhdr->flags[2] & (1ULL << 5)));
+	KUNIT_EXPECT_TRUE(test, !!(fhdr->flags[2] & (1ULL << 6)));
+	KUNIT_EXPECT_TRUE(test, !!(fhdr->flags[2] & (1ULL << 11)));
+
+	KUNIT_EXPECT_FALSE(test, kho_ser_has_required(fhdr, 70));
+	KUNIT_EXPECT_FALSE(test, kho_ser_has_required(fhdr, 100));
+	KUNIT_EXPECT_FALSE(test, kho_ser_has_optional(fhdr, 70));
+	KUNIT_EXPECT_FALSE(test, kho_ser_has_optional(fhdr, 100));
+}
+
+static void kho_ser_hdr_validate_test(struct kunit *test)
+{
+	u8 buf[sizeof(struct kho_ser_hdr) + sizeof(u64) * 2] __aligned(8);
+	struct kho_ser_hdr *fhdr = (void *)buf;
+
+	__kho_ser_init(fhdr, 0, 4, 10);
+	KUNIT_EXPECT_EQ(test, __kho_ser_validate(fhdr, 4), 0);
+	KUNIT_EXPECT_EQ(test, __kho_ser_validate(fhdr, 2), 0);
+
+	kho_ser_set_optional(fhdr, 0);
+	kho_ser_set_optional(fhdr, 9);
+	KUNIT_EXPECT_EQ(test, __kho_ser_validate(fhdr, 2), 0);
+
+	kho_ser_set_required(fhdr, 0);
+	kho_ser_set_required(fhdr, 1);
+	KUNIT_EXPECT_EQ(test, __kho_ser_validate(fhdr, 2), 0);
+
+	kho_ser_set_required(fhdr, 2);
+	KUNIT_EXPECT_EQ(test, __kho_ser_validate(fhdr, 2), -EOPNOTSUPP);
+
+	kho_ser_clear_required(fhdr, 2);
+	KUNIT_EXPECT_EQ(test, __kho_ser_validate(fhdr, 2), 0);
+
+	kho_ser_set_required(fhdr, 3);
+	KUNIT_EXPECT_EQ(test, __kho_ser_validate(fhdr, 2), -EOPNOTSUPP);
+}
+
+static struct kunit_case kho_feature_test_cases[] = {
+	KUNIT_CASE(kho_ser_hdr_zero_flags_test),
+	KUNIT_CASE(kho_ser_hdr_set_get_test),
+	KUNIT_CASE(kho_ser_hdr_validate_test),
+	{}
+};
+
+static struct kunit_suite kho_feature_test_suite = {
+	.name = "kho_feature",
+	.test_cases = kho_feature_test_cases,
+};
+
+kunit_test_suite(kho_feature_test_suite);
+
+MODULE_DESCRIPTION("KUnit tests for the Kexec HandOver feature header helpers");
+MODULE_LICENSE("GPL");
-- 
2.56.0.506.g506a7eabc5-goog


