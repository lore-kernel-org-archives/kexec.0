Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8ED5CA1012
	for <kexec@archiver.kernel.org>; Thu,  4 Sep 2025 10:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c0rvQKXzPsuqYoWHl9F18lxFz+XZ3OaNwusLzUP53R8=; b=ysMCMjTMbrZZfebCkf77BuMmjq
	5VHIg8l/TZbJuKAw+hyNzvUkX9X3ggwwWDT4v8IfcjZzIZBqvDUdcXfnoK3AoTXxQSDqycJjVk08S
	2taXaXlQHlqoLr5PZmgoezQaKjA0DrZxb9MWJ9QSy4DnD6ROIo0oSwzar2q1ceRSgYpnMA9qn6zDV
	TKVBnhCSQk0Dt60pHSXxcWB6YyoUSy2MrzeQ3gcdzMSC47BavB4RBF3ofX785jsT5BaSyOt/X4CmO
	4kQuIk5cy0Z0dnqzTrfnhJGPleezVipFxKCojbAdvnjhgwOcERDqrIkIvK+IHcWUJs3lhLmXTiAVw
	8qtMAAXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uu7Vq-0000000B09N-2xxo;
	Thu, 04 Sep 2025 10:48:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uu6Qu-0000000Ac30-3uiV
	for kexec@lists.infradead.org;
	Thu, 04 Sep 2025 09:39:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756978747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c0rvQKXzPsuqYoWHl9F18lxFz+XZ3OaNwusLzUP53R8=;
	b=VqQMIMuWbgF1jmsBB89pTYXBDUoqemg633vjIWj8Z0CFya48CQtQHzwk1gdsGiqBJ+Z+wb
	Z3f6cqdwubmfdC7YtRNTrHB3/fR0YoJ5MX1LZfg+rId3+YcnsoLf+3qTb9e8zVwGksocWu
	CbNg83394LSkIeBzMuqmrToiF6psFMs=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-_xyVvnCzPimSF6WdavIESg-1; Thu, 04 Sep 2025 05:39:06 -0400
X-MC-Unique: _xyVvnCzPimSF6WdavIESg-1
X-Mimecast-MFC-AGG-ID: _xyVvnCzPimSF6WdavIESg_1756978746
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e2eb787f2so947483b3a.3
        for <kexec@lists.infradead.org>; Thu, 04 Sep 2025 02:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756978745; x=1757583545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c0rvQKXzPsuqYoWHl9F18lxFz+XZ3OaNwusLzUP53R8=;
        b=GmM0hTIUnQjr/Xv2sS6mwyWzom5m6P/c7WhbfKStnKlTLK+pFMpI8dZWVToXJqXC9P
         PSp4eD0db4aDpN8cMSbxcrZsKe+neT18PuOIyP7qSeqo2ARAn1cQ7rRMWiq1vhZhNegF
         PHpbk3PxI64jXjd1tZe2VT6115ytrbLuD0/Srqb/jVWNMhQ4mdHKZRAhU29Sn0BfFpiM
         GGNXU/p99Ac0mb0O06wAoWeAIzuZdpTnvMydAlio4HIQwlJiwyWOsN/Ez6NHQFgXq6JH
         jKphasOjl60t9CyvolCRgJeRcSYlKwvQPEn39lMRbCAvBJlvyspxmpTql8OUmIaI8Dr1
         8LSw==
X-Gm-Message-State: AOJu0YxLdx9Zj4JDx5lrGCdtp0r5L0uu+YScXJVW8cj38YqgGIGwqHu8
	2kP405JXpKDgQRP6PbDSzCWk8AatkHaABTmZji9FFJ4W+Ta569y1lU1w1n9y5TC0H0ErPHelTar
	wyE7w8naVkKJuovQZ8qSg4+fDrPaKc2DT1sezc0HTs2Edu2Cgc6BZUW2/TEdEm0oRGpLWuDw+7N
	zYV1NM49+26tN4ayyeCUElCkbPvKsVl9VzHe4oB7FgBdcjzA==
X-Gm-Gg: ASbGncsMYnJ3n3z5ql7KjdshxtFtOAf2rd1VBbLftKBFMGNf+LKyDoJc5J0jaxdi9Az
	h+H8/Sz4n1ZWXaAn9mixmD/mcUFzpgvwSagdBkQOpPaTrvX9tXKJTSBL6otOlbCozM6y5QnM4/b
	xT1qqs2ISKg5Wzw8pp8Jyt3baHxZ8oPabWBNFhNsvWPuKoZY/v+D3SD22/4iQHF8r289qsIVUf5
	re95d9aGlbfED1OtHu2JSRcLzL8wW3xr1wYyncnfLa73RH+lp/2evuF5+1IrV3wBE37wfxYhveu
	jaXEurEwUSIJb5lK8lVnHKrgm89bTiA=
X-Received: by 2002:a05:6a20:6a09:b0:24b:bae4:9c7f with SMTP id adf61e73a8af0-24bbaf3e666mr2199362637.39.1756978745321;
        Thu, 04 Sep 2025 02:39:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKYbyG0cgqN5tuhgCwbhJAPJzkArpNfN7KHV1CCe7rYznCJ7EREuG5frfE+WvBeDVCfK1s1w==
X-Received: by 2002:a05:6a20:6a09:b0:24b:bae4:9c7f with SMTP id adf61e73a8af0-24bbaf3e666mr2199323637.39.1756978744689;
        Thu, 04 Sep 2025 02:39:04 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26abdesm18571779b3a.1.2025.09.04.02.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 02:39:04 -0700 (PDT)
From: Coiby Xu <coxu@redhat.com>
To: kexec@lists.infradead.org
Cc: fuqiang wang <fuqiang.wang@easystack.cn>,
	x86@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 2/2] crash: Add KUnit tests for crash_exclude_mem_range
Date: Thu,  4 Sep 2025 17:38:53 +0800
Message-ID: <20250904093855.1180154-2-coxu@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250904093855.1180154-1-coxu@redhat.com>
References: <20250904093855.1180154-1-coxu@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5wjgoc9ae4d19f2yVp3Xa7Qr4E17IJRSgpPgTBu8hxY_1756978746
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250904_023909_120664_408B996E 
X-CRM114-Status: GOOD (  31.22  )
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

crash_exclude_mem_range seems to be a simple function but there have been
multiple attempts to fix it,
 - commit a2e9a95d2190 ("kexec: Improve & fix crash_exclude_mem_range()
   to handle overlapping ranges")
 - commit 6dff31597264 ("crash_core: fix and simplify the logic of
   crash_exclude_mem_range()")

So add a set of unit tests to verify the correctness of current
implementation. Shall we change the function in the future, the unit
tests can also help prevent any regression. For example, we may make the
function smarter by allocating extra crash_mem range on demand thus
there is no need for the caller to foresee any memory range split or
address -ENOMEM failure.

The testing strategy is to verify the correctness of base case. The
base case is there is one to-be-excluded range A and one existing range
B. Then we can exhaust all possibilities of the position of A regarding
B. For example, here are two combinations,
    Case: A is completely inside B (causes split)
      Original:       [----B----]
      Exclude:          {--A--}
      Result:         [B1] .. [B2]

    Case: A overlaps B's left part
      Original:       [----B----]
      Exclude:  {---A---}
      Result:           [..B..]

In theory we can prove the correctness by induction,
   - Base case: crash_exclude_mem_range is correct in the case where n=1
     (n is the number of existing ranges).
   - Inductive step: If crash_exclude_mem_range is correct for n=k
     existing ranges, then the it's also correct for n=k+1 ranges.

But for the sake of simplicity, simply use unit tests to cover the base
case together with two regression tests.

Note most of exclude_single_range_test code is generated by Google
Gemini with some small tweaks. The function specification, function body
and the exhausting test strategy are presented as prompts.

Signed-off-by: Coiby Xu <coxu@redhat.com>
Assisted-by: Google Gemini
---
 kernel/Kconfig.kexec     |  11 ++
 kernel/Makefile          |   1 +
 kernel/crash_core.c      |  14 ++
 kernel/crash_core_test.c | 343 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 369 insertions(+)
 create mode 100644 kernel/crash_core_test.c

diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 1224dd937df0..422270d64820 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -148,6 +148,17 @@ config CRASH_DM_CRYPT_CONFIGS
 	  CRASH_DM_CRYPT cannot directly select CONFIGFS_FS, because that
 	  is required to be built-in.
 
+config CRASH_DUMP_KUNIT_TEST
+	tristate "Unit Tests for kernel crash dumps" if !KUNIT_ALL_TESTS
+	depends on CRASH_DUMP && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This option builds KUnit unit tests for kernel crash dumps. The unit
+	  tests will be used to verify the correctness of covered functions and
+	  also prevent any regression.
+
+	  If unsure, say N.
+
 config CRASH_HOTPLUG
 	bool "Update the crash elfcorehdr on system configuration changes"
 	default y
diff --git a/kernel/Makefile b/kernel/Makefile
index c60623448235..216a7dfc3a68 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -78,6 +78,7 @@ obj-$(CONFIG_CRASH_RESERVE) += crash_reserve.o
 obj-$(CONFIG_KEXEC_CORE) += kexec_core.o
 obj-$(CONFIG_CRASH_DUMP) += crash_core.o
 obj-$(CONFIG_CRASH_DM_CRYPT) += crash_dump_dm_crypt.o
+obj-$(CONFIG_CRASH_DUMP_KUNIT_TEST) += crash_core_test.o
 obj-$(CONFIG_KEXEC) += kexec.o
 obj-$(CONFIG_KEXEC_FILE) += kexec_file.o
 obj-$(CONFIG_KEXEC_ELF) += kexec_elf.o
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index a4ef79591eb2..961a035aaea7 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -274,6 +274,20 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
 	return 0;
 }
 
+/**
+ * crash_exclude_mem_range - exclude a mem range for existing ranges
+ * @mem: mem->range contains an array of ranges sorted in ascending order
+ * @mstart: the start of to-be-excluded range
+ * @mend: the start of to-be-excluded range
+ *
+ * If you are unsure if a range split will happen, to avoid function call
+ * failure because of -ENOMEM, always make sure
+ *    mem->max_nr_ranges == mem->nr_ranges + 1
+ * before calling the function each time.
+ *
+ * returns 0 if a memory range is excluded successfully
+ * return -ENOMEM if mem->ranges doesn't have space to hold split ranges
+ */
 int crash_exclude_mem_range(struct crash_mem *mem,
 			    unsigned long long mstart, unsigned long long mend)
 {
diff --git a/kernel/crash_core_test.c b/kernel/crash_core_test.c
new file mode 100644
index 000000000000..8aadf6801530
--- /dev/null
+++ b/kernel/crash_core_test.c
@@ -0,0 +1,343 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <kunit/test.h>
+#include <linux/crash_core.h> // For struct crash_mem and struct range if defined there
+
+// Helper to create and initialize crash_mem
+static struct crash_mem *create_crash_mem(struct kunit *test, unsigned int max_ranges,
+					  unsigned int nr_initial_ranges,
+					  const struct range *initial_ranges)
+{
+	struct crash_mem *mem;
+	size_t alloc_size;
+
+	// Check if max_ranges can even hold initial_ranges
+	if (max_ranges < nr_initial_ranges) {
+		kunit_err(test, "max_ranges (%u) < nr_initial_ranges (%u)\n",
+			  max_ranges, nr_initial_ranges);
+		return NULL;
+	}
+
+	alloc_size = sizeof(struct crash_mem) + (size_t)max_ranges * sizeof(struct range);
+	mem = kunit_kzalloc(test, alloc_size, GFP_KERNEL);
+	if (!mem) {
+		kunit_err(test, "Failed to allocate crash_mem\n");
+		return NULL;
+	}
+
+	mem->max_nr_ranges = max_ranges;
+	mem->nr_ranges = nr_initial_ranges;
+	if (initial_ranges && nr_initial_ranges > 0) {
+		memcpy(mem->ranges, initial_ranges,
+		       nr_initial_ranges * sizeof(struct range));
+	}
+
+	return mem;
+}
+
+// Helper to compare ranges for assertions
+static void assert_ranges_equal(struct kunit *test,
+				const struct range *actual_ranges,
+				unsigned int actual_nr_ranges,
+				const struct range *expected_ranges,
+				unsigned int expected_nr_ranges,
+				const char *case_name)
+{
+	unsigned int i;
+
+	KUNIT_ASSERT_EQ_MSG(test, expected_nr_ranges, actual_nr_ranges,
+			    "%s: Number of ranges mismatch.", case_name);
+
+	for (i = 0; i < expected_nr_ranges; i++) {
+		KUNIT_ASSERT_EQ_MSG(test, expected_ranges[i].start, actual_ranges[i].start,
+				    "%s: Range %u start mismatch.", case_name, i);
+		KUNIT_ASSERT_EQ_MSG(test, expected_ranges[i].end, actual_ranges[i].end,
+				    "%s: Range %u end mismatch.", case_name, i);
+	}
+}
+
+// Structure for test parameters
+struct exclude_test_param {
+	const char *description;
+	unsigned long long exclude_start;
+	unsigned long long exclude_end;
+	unsigned int initial_max_ranges;
+	const struct range *initial_ranges;
+	unsigned int initial_nr_ranges;
+	const struct range *expected_ranges;
+	unsigned int expected_nr_ranges;
+	int expected_ret;
+};
+
+static void run_exclude_test_case(struct kunit *test, const struct exclude_test_param *params)
+{
+	struct crash_mem *mem;
+	int ret;
+
+	kunit_info(test, "%s", params->description);
+
+	mem = create_crash_mem(test, params->initial_max_ranges,
+			       params->initial_nr_ranges, params->initial_ranges);
+	if (!mem)
+		return; // Error already logged by create_crash_mem or kunit_kzalloc
+
+	ret = crash_exclude_mem_range(mem, params->exclude_start, params->exclude_end);
+
+	KUNIT_ASSERT_EQ_MSG(test, params->expected_ret, ret,
+			    "%s: Return value mismatch.", params->description);
+
+	if (params->expected_ret == 0) {
+		assert_ranges_equal(test, mem->ranges, mem->nr_ranges,
+				    params->expected_ranges, params->expected_nr_ranges,
+				    params->description);
+	} else {
+		// If an error is expected, nr_ranges might still be relevant to check
+		// depending on the exact point of failure. For ENOMEM on split,
+		// nr_ranges shouldn't have changed.
+		KUNIT_ASSERT_EQ_MSG(test, params->initial_nr_ranges,
+				    mem->nr_ranges,
+				    "%s: Number of ranges mismatch on error.",
+				    params->description);
+	}
+}
+
+/*
+ * Test Strategy 1: One to-be-excluded range A and one existing range B.
+ *
+ * Exhaust all possibilities of the position of A regarding B.
+ */
+
+static const struct range single_range_b = { .start = 100, .end = 199 };
+
+static const struct exclude_test_param exclude_single_range_test_data[] = {
+	{
+		.description = "1.1: A is left of B, no overlap",
+		.exclude_start = 10, .exclude_end = 50,
+		.initial_max_ranges = 1,
+		.initial_ranges = &single_range_b, .initial_nr_ranges = 1,
+		.expected_ranges = &single_range_b, .expected_nr_ranges = 1,
+		.expected_ret = 0,
+	},
+	{
+		.description = "1.2: A's right boundary touches B's left boundary",
+		.exclude_start = 10, .exclude_end = 99,
+		.initial_max_ranges = 1,
+		.initial_ranges = &single_range_b, .initial_nr_ranges = 1,
+		.expected_ranges = &single_range_b, .expected_nr_ranges = 1,
+		.expected_ret = 0,
+	},
+	{
+		.description = "1.3: A overlaps B's left part",
+		.exclude_start = 50, .exclude_end = 149,
+		.initial_max_ranges = 1,
+		.initial_ranges = &single_range_b, .initial_nr_ranges = 1,
+		.expected_ranges = (const struct range[]){{ .start = 150, .end = 199 }},
+		.expected_nr_ranges = 1,
+		.expected_ret = 0,
+	},
+	{
+		.description = "1.4: A is completely inside B",
+		.exclude_start = 120, .exclude_end = 179,
+		.initial_max_ranges = 2, // Needs space for split
+		.initial_ranges = &single_range_b, .initial_nr_ranges = 1,
+		.expected_ranges = (const struct range[]){
+			{ .start = 100, .end = 119 },
+			{ .start = 180, .end = 199 }
+		},
+		.expected_nr_ranges = 2,
+		.expected_ret = 0,
+	},
+	{
+		.description = "1.5: A overlaps B's right part",
+		.exclude_start = 150, .exclude_end = 249,
+		.initial_max_ranges = 1,
+		.initial_ranges = &single_range_b, .initial_nr_ranges = 1,
+		.expected_ranges = (const struct range[]){{ .start = 100, .end = 149 }},
+		.expected_nr_ranges = 1,
+		.expected_ret = 0,
+	},
+	{
+		.description = "1.6: A's left boundary touches B's right boundary",
+		.exclude_start = 200, .exclude_end = 250,
+		.initial_max_ranges = 1,
+		.initial_ranges = &single_range_b, .initial_nr_ranges = 1,
+		.expected_ranges = &single_range_b, .expected_nr_ranges = 1,
+		.expected_ret = 0,
+	},
+	{
+		.description = "1.7: A is right of B, no overlap",
+		.exclude_start = 250, .exclude_end = 300,
+		.initial_max_ranges = 1,
+		.initial_ranges = &single_range_b, .initial_nr_ranges = 1,
+		.expected_ranges = &single_range_b, .expected_nr_ranges = 1,
+		.expected_ret = 0,
+	},
+	{
+		.description = "1.8: A completely covers B and extends beyond",
+		.exclude_start = 50, .exclude_end = 250,
+		.initial_max_ranges = 1,
+		.initial_ranges = &single_range_b, .initial_nr_ranges = 1,
+		.expected_ranges = NULL, .expected_nr_ranges = 0,
+		.expected_ret = 0,
+	},
+	{
+		.description = "1.9: A covers B and extends to the left",
+		.exclude_start = 50, .exclude_end = 199, // A ends exactly where B ends
+		.initial_max_ranges = 1,
+		.initial_ranges = &single_range_b, .initial_nr_ranges = 1,
+		.expected_ranges = NULL, .expected_nr_ranges = 0,
+		.expected_ret = 0,
+	},
+	{
+		.description = "1.10: A covers B and extends to the right",
+		.exclude_start = 100, .exclude_end = 250, // A starts exactly where B starts
+		.initial_max_ranges = 1,
+		.initial_ranges = &single_range_b, .initial_nr_ranges = 1,
+		.expected_ranges = NULL, .expected_nr_ranges = 0,
+		.expected_ret = 0,
+	},
+	{
+		.description = "1.11: A is identical to B",
+		.exclude_start = 100, .exclude_end = 199,
+		.initial_max_ranges = 1,
+		.initial_ranges = &single_range_b, .initial_nr_ranges = 1,
+		.expected_ranges = NULL, .expected_nr_ranges = 0,
+		.expected_ret = 0,
+	},
+	{
+		.description = "1.12: A is a point, left of B, no overlap",
+		.exclude_start = 10, .exclude_end = 10,
+		.initial_max_ranges = 1,
+		.initial_ranges = &single_range_b, .initial_nr_ranges = 1,
+		.expected_ranges = &single_range_b, .expected_nr_ranges = 1,
+		.expected_ret = 0,
+	},
+	{
+		.description = "1.13: A is a point, at start of B",
+		.exclude_start = 100, .exclude_end = 100,
+		.initial_max_ranges = 1,
+		.initial_ranges = &single_range_b, .initial_nr_ranges = 1,
+		.expected_ranges = (const struct range[]){{ .start = 101, .end = 199 }},
+		.expected_nr_ranges = 1,
+		.expected_ret = 0,
+	},
+	{
+		.description = "1.14: A is a point, in middle of B (causes split)",
+		.exclude_start = 150, .exclude_end = 150,
+		.initial_max_ranges = 2, // Needs space for split
+		.initial_ranges = &single_range_b, .initial_nr_ranges = 1,
+		.expected_ranges = (const struct range[]){
+			{ .start = 100, .end = 149 },
+			{ .start = 151, .end = 199 }
+		},
+		.expected_nr_ranges = 2,
+		.expected_ret = 0,
+	},
+	{
+		.description = "1.15: A is a point, at end of B",
+		.exclude_start = 199, .exclude_end = 199,
+		.initial_max_ranges = 1,
+		.initial_ranges = &single_range_b, .initial_nr_ranges = 1,
+		.expected_ranges = (const struct range[]){{ .start = 100, .end = 198 }},
+		.expected_nr_ranges = 1,
+		.expected_ret = 0,
+	},
+	{
+		.description = "1.16: A is a point, right of B, no overlap",
+		.exclude_start = 250, .exclude_end = 250,
+		.initial_max_ranges = 1,
+		.initial_ranges = &single_range_b, .initial_nr_ranges = 1,
+		.expected_ranges = &single_range_b, .expected_nr_ranges = 1,
+		.expected_ret = 0,
+	},
+	// ENOMEM case for single range split
+	{
+		.description = "1.17: A completely inside B (split), no space (ENOMEM)",
+		.exclude_start = 120, .exclude_end = 179,
+		.initial_max_ranges = 1, // Not enough for split
+		.initial_ranges = &single_range_b, .initial_nr_ranges = 1,
+		.expected_ranges = NULL, // Not checked on error by assert_ranges_equal for content
+		.expected_nr_ranges = 1, // Should remain unchanged
+		.expected_ret = -ENOMEM,
+	},
+};
+
+
+static void exclude_single_range_test(struct kunit *test)
+{
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(exclude_single_range_test_data); i++) {
+		kunit_log(KERN_INFO, test, "Running: %s", exclude_single_range_test_data[i].description);
+		run_exclude_test_case(test, &exclude_single_range_test_data[i]);
+		// KUnit will stop on first KUNIT_ASSERT failure within run_exclude_test_case
+	}
+}
+
+/*
+ * Test Strategy 2: Regression test.
+ */
+
+static const struct exclude_test_param exclude_range_regression_test_data[] = {
+	// Test data from commit a2e9a95d2190
+	{
+		.description = "2.1: exclude low 1M",
+		.exclude_start = 0, .exclude_end = (1 << 20) - 1,
+		.initial_max_ranges = 3,
+		.initial_ranges = (const struct range[]){
+			{ .start = 0, .end = 0x3efff },
+			{ .start = 0x3f000, .end = 0x3ffff },
+			{ .start = 0x40000, .end = 0x9ffff }
+		},
+		.initial_nr_ranges = 3,
+		.expected_nr_ranges = 0,
+		.expected_ret = 0,
+	},
+	// Test data from https://lore.kernel.org/all/ZXrY7QbXAlxydsSC@MiWiFi-R3L-srv/T/#u
+	{
+		.description = "2.2: when range out of bound",
+		.exclude_start = 100, .exclude_end = 200,
+		.initial_max_ranges = 3,
+		.initial_ranges = (const struct range[]){
+			{ .start = 1, .end = 299 },
+			{ .start = 401, .end = 1000 },
+			{ .start = 1001, .end = 2000 }
+		},
+		.initial_nr_ranges = 3,
+		.expected_ranges = NULL, // Not checked on error by assert_ranges_equal for content
+		.expected_nr_ranges = 3, // Should remain unchanged
+		.expected_ret = -ENOMEM
+	},
+
+};
+
+
+static void exclude_range_regression_test(struct kunit *test)
+{
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(exclude_range_regression_test_data); i++) {
+		kunit_log(KERN_INFO, test, "Running: %s", exclude_range_regression_test_data[i].description);
+		run_exclude_test_case(test, &exclude_range_regression_test_data[i]);
+		// KUnit will stop on first KUNIT_ASSERT failure within run_exclude_test_case
+	}
+}
+
+/*
+ * KUnit Test Suite
+ */
+static struct kunit_case crash_exclude_mem_range_test_cases[] = {
+	KUNIT_CASE(exclude_single_range_test),
+	KUNIT_CASE(exclude_range_regression_test),
+	{}
+};
+
+static struct kunit_suite crash_exclude_mem_range_suite = {
+	.name = "crash_exclude_mem_range_tests",
+	.test_cases = crash_exclude_mem_range_test_cases,
+	// .init and .exit can be NULL if not needed globally for the suite
+};
+
+kunit_test_suite(crash_exclude_mem_range_suite);
+
+MODULE_DESCRIPTION("crash dump KUnit test suite");
+MODULE_LICENSE("GPL");
-- 
2.51.0


