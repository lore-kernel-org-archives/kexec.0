Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CB9CD6E4A
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 03:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SdAegEf5u3em8MUzB4xyEunyt/xoJrJRQD9FIOINoRs=; b=vqhLruKVroGw6YrrxKMOMFfCRP
	AKG6fVV1DDY0rXSgjgxoXrL1J9/y84Ib4bJ90GlYLKcgjEu8Ne6JMF3W2xufAISHOj/7NWayPw6Fm
	fBlZ9VSa6+4V5TgckD/aZOX8+ntzS0yK7Y79tAfE7zpnfoiDFPQlz2F9NSnZIPx1y7w9x05uYscsG
	ndMcuXLq2XHgDEb54TXfaEdoy+bn8PWOS1xbMpYnb0fiZpLblhbXIseCVVE9gXvPeRHKJP3r9sZje
	Z0kfU4UGCUQcI/v21LMcMAnCbNkMMizJVYX+3chqtDew5TCwkuEoeoOK3wb7YMhQ0/0/R6WJpzLcz
	G+Cq8uRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUcIJ-0000000EB8s-0nZP;
	Wed, 03 Jun 2026 03:29:27 +0000
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUcIF-0000000EB4A-47oa
	for kexec@lists.infradead.org;
	Wed, 03 Jun 2026 03:29:25 +0000
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-8ce65629acaso40116796d6.3
        for <kexec@lists.infradead.org>; Tue, 02 Jun 2026 20:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780457363; x=1781062163; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SdAegEf5u3em8MUzB4xyEunyt/xoJrJRQD9FIOINoRs=;
        b=WtvYKVr1tmtbZwR7Xwntd66TFO0/NuKnlp7VP52IqUwKbwcxLcFW4XGa3dxPvtfyGF
         FNuTKkTMsRf/Jhu8l0XZ7M7p6i9KqVry4p4HdIGMg4Wyxyjmqjav0s0trFN1AY1GdDGx
         omR/M1blMm/8wbYSYf1K8T5mvExsjU03GwAoAl83WqREmmQLGARKU/gxsVbdk+DFIgtX
         Xdi5IhL85w07jxYxs+QYOFnHMEbvv9+UXL5wyklbxJ7Bn7YK8/ctb8VbKrvWxADkJ4Gv
         cgVU6tVIrmX0gnL6SZC+7W2kGBNOgrlqe+skjRpp9twaOe4uquyBP/cZIa7c9JHsjR8d
         m8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780457363; x=1781062163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SdAegEf5u3em8MUzB4xyEunyt/xoJrJRQD9FIOINoRs=;
        b=Df36AU8AMzrhFPc7BhDzkNCFdAs9ywIdgdiGziPbd0WvQ/Nw5Bkxnytn0IRL7b/Y9Q
         xixPKZbys4LvwweLn2Nz+g8EJW9+5WR7LH6LtznqokZN7Z+s4ioRFXce3VdvhJv3+db4
         fh0ZOyjMLAhAc3x8ntVjyz+H6iBrx9OPgEF9d5ARV2hgD2oQ788W3sbK9AYcofTQHC0Y
         9l4rBA113rju/iIRKo4KIFthKMEuJ+vwY5owMg9D098+cVXIkZM25H1uyZnVAH5hTL4U
         tzpVk5DX9+Nh3b1D5WQJ7Q6wVwqrsXKzojTn8jCZ7wSKDrbmRIrQdtqxdJZNSScMRb0N
         9gdA==
X-Forwarded-Encrypted: i=1; AFNElJ8VNOz3CBBrJ+QIjlreXS1JXsTMT3jWm9ciufod4FSj39Qp8hxfeHBY94XGNNCqnpqFqC7CKA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzHDmp2omfOyUBaSfeCtRthFzMgIqQx2/jN/TIDR3coup9/arfj
	iHP3lPuQVDtMLPwKhSXW7yVUnsBjcns1Qm/jjfBNx112BDgupVeaTZkmLbdBV2s1Drg=
X-Gm-Gg: Acq92OEdDr1UoBAdwwaOw+mCRgK8nbc7tyLM93v9sPnWx3ev9RWxULCOOcKhFYUZJkM
	g6W+xBUGjO4ScVBtQ5wWtjnqZqg3AY4BMV62MsKH2Gn6fxpQ0U3Oz0Qql/hFKyzpVS5WZVdRJZG
	+wmDhZBFDaylpdUhZebc203BYH6GRcQnWQgIkm4EknS0lhY2zOv9Rgq3Lt6L/WawAfbgnalgF6x
	rSaF7+BeKPEyCIZ7CjPPUMQDf/6QTp7bHShBrdnuxut+0vQqeq8lytUZfkhkOe+d7nkqxnoZY3N
	ffeC5Pufd8nRqgJ8HiZCzq7/fOV6eP/4QgIneZyoizCFi5fI+qf8UKWHW5Ne+aqGqdBqc+XoRWI
	iwZTTxTXO7mITvZT9neLW+fiEesNQdKH2ULEMqVbOQPuOT9pHvM/sZc7xPEAZV5Smn90AodIw1v
	borHjEDqTNkmimbgY9A3y1UAwoCjSXIq3m1dBhkEshMvIIUtfN6wogauqa2syb8Q==
X-Received: by 2002:a05:6214:4c86:b0:8cc:f354:f47f with SMTP id 6a1803df08f44-8cecdf0ee3emr21236886d6.29.1780457362975;
        Tue, 02 Jun 2026 20:29:22 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd26b3b9sm9244566d6.45.2026.06.02.20.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 20:29:22 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	shuah@kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	pasha.tatashin@soleen.com,
	dmatlack@google.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	skhawaja@google.com,
	graf@amazon.com
Subject: [PATCH v6 11/13] selftests/liveupdate: Test session and file limit removal
Date: Wed,  3 Jun 2026 03:29:02 +0000
Message-ID: <20260603032905.344462-12-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603032905.344462-1-pasha.tatashin@soleen.com>
References: <20260603032905.344462-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_202924_031280_A897B4DF 
X-CRM114-Status: GOOD (  17.61  )
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

With the removal of static limits on the number of sessions and files per
session, the orchestrator now uses dynamic allocation.

Add new test cases to verify that the system can handle a large number of
sessions and files. These tests ensure that the dynamic block allocation
and reuse logic for session metadata and outgoing files work correctly
beyond the previous static limits.

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 .../testing/selftests/liveupdate/liveupdate.c | 75 +++++++++++++++++++
 .../selftests/liveupdate/luo_test_utils.c     | 24 ++++++
 .../selftests/liveupdate/luo_test_utils.h     |  2 +
 3 files changed, 101 insertions(+)

diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
index c7d94b9181e1..502fb3567e38 100644
--- a/tools/testing/selftests/liveupdate/liveupdate.c
+++ b/tools/testing/selftests/liveupdate/liveupdate.c
@@ -26,6 +26,7 @@
 
 #include <linux/liveupdate.h>
 
+#include "luo_test_utils.h"
 #include "../kselftest.h"
 #include "../kselftest_harness.h"
 
@@ -499,4 +500,78 @@ TEST_F(liveupdate_device, get_session_name_max_length)
 	ASSERT_EQ(close(session_fd), 0);
 }
 
+/*
+ * Test Case: Manage Many Sessions
+ *
+ * Verifies that a large number of sessions can be created and then
+ * destroyed during normal system operation. This specifically tests the
+ * dynamic block allocation and reuse logic for session metadata management
+ * without preserving any files.
+ */
+TEST_F(liveupdate_device, preserve_many_sessions)
+{
+#define MANY_SESSIONS 2000
+	int session_fds[MANY_SESSIONS];
+	int ret, i;
+
+	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
+	if (self->fd1 < 0 && errno == ENOENT)
+		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
+	ASSERT_GE(self->fd1, 0);
+
+	ret = luo_ensure_nofile_limit(MANY_SESSIONS);
+	if (ret == -EPERM)
+		SKIP(return, "Insufficient privileges to set RLIMIT_NOFILE");
+	ASSERT_EQ(ret, 0);
+
+	for (i = 0; i < MANY_SESSIONS; i++) {
+		char name[64];
+
+		snprintf(name, sizeof(name), "many-session-%d", i);
+		session_fds[i] = create_session(self->fd1, name);
+		ASSERT_GE(session_fds[i], 0);
+	}
+
+	for (i = 0; i < MANY_SESSIONS; i++)
+		ASSERT_EQ(close(session_fds[i]), 0);
+}
+
+/*
+ * Test Case: Preserve Many Files
+ *
+ * Verifies that a large number of files can be preserved in a single session
+ * and then destroyed during normal system operation. This tests the dynamic
+ * block allocation and management for outgoing files.
+ */
+TEST_F(liveupdate_device, preserve_many_files)
+{
+#define MANY_FILES 500
+	int mem_fds[MANY_FILES];
+	int session_fd, ret, i;
+
+	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
+	if (self->fd1 < 0 && errno == ENOENT)
+		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
+	ASSERT_GE(self->fd1, 0);
+
+	session_fd = create_session(self->fd1, "many-files-test");
+	ASSERT_GE(session_fd, 0);
+
+	ret = luo_ensure_nofile_limit(MANY_FILES + 10);
+	if (ret == -EPERM)
+		SKIP(return, "Insufficient privileges to set RLIMIT_NOFILE");
+	ASSERT_EQ(ret, 0);
+
+	for (i = 0; i < MANY_FILES; i++) {
+		mem_fds[i] = memfd_create("test-memfd", 0);
+		ASSERT_GE(mem_fds[i], 0);
+		ASSERT_EQ(preserve_fd(session_fd, mem_fds[i], i), 0);
+	}
+
+	for (i = 0; i < MANY_FILES; i++)
+		ASSERT_EQ(close(mem_fds[i]), 0);
+
+	ASSERT_EQ(close(session_fd), 0);
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/liveupdate/luo_test_utils.c b/tools/testing/selftests/liveupdate/luo_test_utils.c
index 3c8721c505df..333a3530051b 100644
--- a/tools/testing/selftests/liveupdate/luo_test_utils.c
+++ b/tools/testing/selftests/liveupdate/luo_test_utils.c
@@ -17,6 +17,7 @@
 #include <sys/syscall.h>
 #include <sys/mman.h>
 #include <sys/types.h>
+#include <sys/resource.h>
 #include <sys/stat.h>
 #include <errno.h>
 #include <stdarg.h>
@@ -28,6 +29,29 @@ int luo_open_device(void)
 	return open(LUO_DEVICE, O_RDWR);
 }
 
+int luo_ensure_nofile_limit(long min_limit)
+{
+	struct rlimit hl;
+
+	/* Allow to extra files to be used by test itself */
+	min_limit += 32;
+
+	if (getrlimit(RLIMIT_NOFILE, &hl) < 0)
+		return -errno;
+
+	if (hl.rlim_cur >= min_limit)
+		return 0;
+
+	hl.rlim_cur = min_limit;
+	if (hl.rlim_cur > hl.rlim_max)
+		hl.rlim_max = hl.rlim_cur;
+
+	if (setrlimit(RLIMIT_NOFILE, &hl) < 0)
+		return -errno;
+
+	return 0;
+}
+
 int luo_create_session(int luo_fd, const char *name)
 {
 	struct liveupdate_ioctl_create_session arg = { .size = sizeof(arg) };
diff --git a/tools/testing/selftests/liveupdate/luo_test_utils.h b/tools/testing/selftests/liveupdate/luo_test_utils.h
index 90099bf49577..6a0d85386613 100644
--- a/tools/testing/selftests/liveupdate/luo_test_utils.h
+++ b/tools/testing/selftests/liveupdate/luo_test_utils.h
@@ -26,6 +26,8 @@ int luo_create_session(int luo_fd, const char *name);
 int luo_retrieve_session(int luo_fd, const char *name);
 int luo_session_finish(int session_fd);
 
+int luo_ensure_nofile_limit(long min_limit);
+
 int create_and_preserve_memfd(int session_fd, int token, const char *data);
 int restore_and_verify_memfd(int session_fd, int token, const char *expected_data);
 
-- 
2.53.0


