Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D60BACD6E66
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 03:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SdAegEf5u3em8MUzB4xyEunyt/xoJrJRQD9FIOINoRs=; b=GNASflkVIJ+HhtQq2DH567VhUo
	yUW5saYLalE8SK6MOQ3+TivmEcHzLSKlgWJyXYgUqOt/z9ljtHWwHX6U5S7FRrStvNlIdcFBQJJWz
	4NkmOKWzvVFRAX1nMs5WXl5iFFTYV5FuOo3IAqmN7yoSjHoXsQVhCjXolAY5P4aBI0hj/8246cRWj
	WW9PHLn4ly6+BecktKWq3KiFyZf8U87WDXwh/My5FYBLHbL+x2VMQm2qrDcLVsKUb+uP7tJoJSsJz
	F4V5QxDjdwnF3SgX/6tQIpno+5Bx3R9u2cQL+FAhRwEVUnEApa2Z04vnoCy2NbcY+zJtsmUw9FWMm
	6pn7djZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUFdN-0000000CDPx-04Zz;
	Tue, 02 Jun 2026 03:17:41 +0000
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUFdH-0000000CDJX-40WB
	for kexec@lists.infradead.org;
	Tue, 02 Jun 2026 03:17:38 +0000
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-5176d4c14f5so1009131cf.0
        for <kexec@lists.infradead.org>; Mon, 01 Jun 2026 20:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780370255; x=1780975055; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SdAegEf5u3em8MUzB4xyEunyt/xoJrJRQD9FIOINoRs=;
        b=PidleqW1Hk6tLTdRGLzY96ZlSQ8yIPjxjTvBgWkZxIWMIbApMzm01o4KxsBl/xhEez
         qW0DwXbTJv0dPaQio+rlcyDC5FAXeBCKUwtwI+ZZg/ukLQESAJskwii49hQMSucir44P
         mDNNwj0IPoxc9+5av3lGLo/MxHk00rpjxAAmrbD/iSF3hCCYEkGNAESG0CMNgF0aPoYA
         Whk7q+UYvg3lGOv6fqnsfIkO6DGhhb+tECuQ+Z78YaBb1RLAUVQqPyoBpHHgi3ycG58b
         y2goawgpwMQWxwi8hDshE1vw/E9TsWoHRvnOxin5mJMI5aKMRxl2N+k+d/r9FvTdv2ZO
         e1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780370255; x=1780975055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SdAegEf5u3em8MUzB4xyEunyt/xoJrJRQD9FIOINoRs=;
        b=iViv8aMYcnGAyq6OkceglVy5hlSTyIAlPcrENLuUJ4y9KnHbRwUeqaLM/ea+aHRzPS
         H9u7kTuIIXP8/+KM0/XFO1R5hy2j+XLy8NxOGu96POZIZszV/k9Rx2yhsn151FZ73bf7
         uFOynuAM9ex/tQoGCBXLDyGeFcJKedw3d3j7vGxqaqIdtviGvX2tWOPKr36RJrbZNSLJ
         rQbBidwJCmPvpc3UvyoVQuJ9uaWkmvub1hAy8GuroAIxQ07qSZusBi7wg1wVd2/2FUPq
         LKqKDoGUUQw5p+ksMvR8vUkPT6bx6hAlYCiym06lhbchssNJ44dCsFvBgVi3drpYL9bL
         ldVg==
X-Forwarded-Encrypted: i=1; AFNElJ/86xQltvWq8UcIUtuPZS90jLzi+VKzX4JIhL1ZvLjonQ8gSNG0yS4zTZQnpwdwlSY+93SeKg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy54P/AVbuois2oYyOzgaMbvEimWz4vLWIK3XwVrXx6Gs5cLCtp
	IEsNWTRodOJdUZrziq/kj7jtlG701MQoVtImgIqzVJyVdYYG17I1KzneBkbS6xlHapc=
X-Gm-Gg: Acq92OH1MGFjcZt+l1Cw0TRIrcfct1vX5hk58rGM3nLrXbZ5Rh2z4EbjUEwwkqqLe0m
	23i3nhRHbNEFPY9+8uSkKpbAqnKX67Salb2lnuwE/akdmup5kdB/+BideZBrncC/ixua0i7bOPx
	B+iXm0qLnP8wl4prbSAL9MxklHFHCSzMLolcN+qQguTFxAH1Q15/TRj/ckEOBllwRn239hrej2N
	wilSmSRR/OBxbdUQsFqu+kD98a0tqh1QZoo9dsjd+NR7H+72nwvdDFUc5PWj2a2oGmzaGP6Zxuf
	IK9eYSv4L/dYBgr82/NIg9TLO7sgk72ygRnxKp06CgKLSCjE30/U0/kE9TNDJ70UvQhLlCBJDh6
	bLOnaA2MShWRFxzr7G2Jg7EN2ZHE81FsYjcu/+hTZJnFd3EYu7dEUMOksDCKTVRomEwllzWa7Qe
	wvprmFdIvOMD9p2l0UoWiLPxssrFRgGFQr3c63VogQN+51g6qaCzkH9ETsrH8bug==
X-Received: by 2002:a05:622a:4d44:b0:516:d971:1cb1 with SMTP id d75a77b69052e-5173a7b5766mr182980701cf.39.1780370255021;
        Mon, 01 Jun 2026 20:17:35 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51741b29745sm71219081cf.8.2026.06.01.20.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 20:17:34 -0700 (PDT)
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
Subject: [PATCH v5 11/13] selftests/liveupdate: Test session and file limit removal
Date: Tue,  2 Jun 2026 03:17:15 +0000
Message-ID: <20260602031717.197696-12-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602031717.197696-1-pasha.tatashin@soleen.com>
References: <20260602031717.197696-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_201736_975300_A4676E74 
X-CRM114-Status: GOOD (  17.16  )
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


