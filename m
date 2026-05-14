Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70541CD4F39
	for <kexec@archiver.kernel.org>; Thu, 14 May 2026 22:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=14TtfdaLNy/StuYSb6NEiZW+KT+gZJT0aVK824S/d4k=; b=hR2mWqzhMQ8SPJYN7qpINyfO0b
	K2234M3klL0TiK8whJFWtlJsfosKLLxqsMUOEO9181J6t5jdZ/uIjdhQ4zQBHQxLMSMD85b8rxA0I
	dvWIy/oSsrd9LFSJb7rOh8WKG9pwf9GUoGRu6mt6qkM0I4syv2X8ELumW18AsgHTZ9ctMSByM9Ny0
	DjwSfZdJwdjW/YesByiADSyRBTGxRMG/+WqdUjYvvfZ0IuGs1oXLwpEUCgcit4iW/EkUDAdx9t5cA
	c+5knYFWnlIEhrtvPt4jeXAp7tbikwnJBiq+9KZPKrKDkthg4SPEReotijeldMg9l5c3EIq4AdA9H
	NTULYN3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNeW1-00000006iPr-2qIj;
	Thu, 14 May 2026 22:26:49 +0000
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNeVy-00000006iMm-3md2
	for kexec@lists.infradead.org;
	Thu, 14 May 2026 22:26:48 +0000
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-512f09ecc67so59903951cf.3
        for <kexec@lists.infradead.org>; Thu, 14 May 2026 15:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1778797606; x=1779402406; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=14TtfdaLNy/StuYSb6NEiZW+KT+gZJT0aVK824S/d4k=;
        b=EYS14kyZ5R2c0U3RzP6YHUhk2G6r1K9XQ71/hMirr15wN4O+Ygud34XWNbkuSe2Pja
         McOfA05ZG18w5AkktWndDUTQnUg+6QGgta0Jxt4CyjsnvsizUPNd3RqHwYBq1tImc4fO
         54lp6eFrBqL7AWvyW80wTpSL31thTfQc0H9ZXBX96tmbjKcxXYzdzBCgxNxOW+bRiITD
         ZA7d5vzIEI9+x6RBrVZzSjsrytYMYYzt2SmanJtjsKvYWYAtmdMv7SOI7j3ZBsbo7ihi
         Q4hA0KAsLQzcIYfjYMqPDKlyfCosPybRT5lhD98g06ZG1jnQ21x3pfFGj1UGxroohdv/
         0NHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778797606; x=1779402406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=14TtfdaLNy/StuYSb6NEiZW+KT+gZJT0aVK824S/d4k=;
        b=j3AP8eQIx/2QP3XY5kFjgXgwxnMl28eWkLqikJEaWWVrMmuTPr7cyNSnibOm+3o35S
         1kt10igioX70gLmnvRVPyLpfytWEMB1U6hjy4TSbwzgBHmc7QjOM0zNV89qIUQmWv0N2
         03P8d562Zy255hTCwsvavnpkszEWzqPEJVFSGk/X4sBjOR4l7K5D9xAFAbRKElh5wKQo
         +X0G7hv9iGDEr7cSASUjYp3V0e6d0byMNwlc13jy3ivvHlz7+y0kBf/+1j7y2xu2kIc0
         8IkFGQgH7tyRl9TU+tbvCAIB62jHeH/d6YRWKy6ZUs77sPRBxhdWRWiPtttjtsXGrmKi
         jhgg==
X-Forwarded-Encrypted: i=1; AFNElJ8VYhWcnYTIpqy6dR7GoN2kZuaWZLY7c9xGWS3CNWxS06Ds4ANnwFnzsxL1XjA8VOKHc8fFyw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwB11FUYqVOE8V4cHoI2okpShRxoyNvafEJuXmNubPt6qYOoVke
	TS28ciLCDZFHiXbu8HTweq9fWZ4S5D7/SCOZTzMV/K/uYoUe7ye7w+65P8I/6g94HGg=
X-Gm-Gg: Acq92OEVqFJHgfUbcT5DT6LJSRWldS0BDRFdaRfd6XmWmoYw6Wa4kp47FmLbu1CTr5w
	ZpJGcTVzCSpw0at5+YfuHk1bYcgc3Fnuj21xhRkTTOh24e7idL+d9xxnse1HY/NWkFH3JbDWeyd
	8EsmALka4N/pHaeu+XF+JuxZzdEM6lpM4RcQWBEogpwWbwSYVzKE8DL4wCqlWZ3xYs/iOUpqFug
	4bsmDGlI7++a+gN9XM33Gw8wTyv9SdI5Zwt28L/npF8dHDVWGOVDJJyjo2IQq80tCLG4qBeauxi
	lMse8zY0IA/RdxF/wD9iYhdcR1+iXsC8x135JsZ7FJBGB5yLXuy4eUe03wj/tjv9TQTi2o9FuGg
	hvP3MlynpVz2xZZIAYlfTvTmpGQ8QmcxoRJ80XLrujYAl04v9ehEkrSE6X21Ca0AveFE5ZnrMBT
	bHSYs1YnpAIQMWoxTrE6mcWBPHfOnr2ftPoCMtvmoppJQBqWoSeLusy/xGs0Mc4A==
X-Received: by 2002:a05:622a:59cc:b0:50d:7406:8f05 with SMTP id d75a77b69052e-5165a0010a3mr18527381cf.9.1778797605925;
        Thu, 14 May 2026 15:26:45 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456ba92fsm28671901cf.9.2026.05.14.15.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 15:26:45 -0700 (PDT)
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
Subject: [PATCH v2 08/10] selftests/liveupdate: Test session and file limit removal
Date: Thu, 14 May 2026 22:26:26 +0000
Message-ID: <20260514222628.931312-9-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260514222628.931312-1-pasha.tatashin@soleen.com>
References: <20260514222628.931312-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_152646_977061_835BF45F 
X-CRM114-Status: GOOD (  17.35  )
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


