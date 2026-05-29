Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F133CD6E4F
	for <kexec@archiver.kernel.org>; Fri, 29 May 2026 03:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l/PRPWvWF9f7qW0XjjBpwGc/NadY8LWCtXHDn2RYoSI=; b=RSGs45e1qvQZSQPhXphLsQ5mWf
	L5QbgLhsBy04raQXquwbc+gX7Mw1Be0kXj2LAV7ylsEfN2hv0RU4iHsylGsRspkeesHrCpggR7xBC
	bcQT9fciwmGC4DEzmiufw7nLlGFbrQ7BtDSaOI/FyDZLP8Yv500pocHBmS1IFLhJ6IodNjgonCegJ
	U8sfUcWvUrCStiZImU9sWzGWvaYBiX3MxAj6oJfq8pq48mCfoNuxDUAYjIpNoXArDzGyIznBF1UwZ
	VnrlFWT63enAY4HE2nBlYEr4NikJ5RYdD7WXMH9yOWLZK1yHzRlRp3K9tOwSEfsl0wYYR0AfQYfrj
	gYXks3bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSnmq-00000006gcP-0i9P;
	Fri, 29 May 2026 03:21:28 +0000
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSnmj-00000006gWI-3jIK
	for kexec@lists.infradead.org;
	Fri, 29 May 2026 03:21:23 +0000
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-51306c9f2e1so155573201cf.0
        for <kexec@lists.infradead.org>; Thu, 28 May 2026 20:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780024880; x=1780629680; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l/PRPWvWF9f7qW0XjjBpwGc/NadY8LWCtXHDn2RYoSI=;
        b=cS+W7KR8l6bXmeaGDgKLxBTLJxNZ6+pR+HTfJIxg/CN04P5ZWq66/ATEzNUmprm485
         /Ejs9vCe4HPU+21hBKF6Oof9qn8nBJgx0OG8Pibd/CmFnRIMOXAeGSB5TUh4HnDTb/38
         G/U/Zvzo3bHfM8cRiWQ3wU7L93GlAlX6rM1wSx1yWMvnefMUmDjKPN3OQkIAjOCW6RGf
         +LYQCezi4Y1/sAdFM/22g2/P8/WXT6uwg2U0b4AhkbPGa7e3p0zsaRlpan6wULPebcHz
         Jse2wjnIam8ISOYyv+wYEHsGysjNKSOd1UYFU8o7xS9R8RMWNNf3eAhuAXuBDVNGpvmg
         Szmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780024880; x=1780629680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l/PRPWvWF9f7qW0XjjBpwGc/NadY8LWCtXHDn2RYoSI=;
        b=EvEt0yCex7g9mN5oNdstSzN0wc2YNmfqxp2eD8piKpjyyXIb2mIQmwxBGavWE76oIV
         pADl8pnqWll68zXNonbr+Lg7LFu5/9eoqtsAsQcScfkUACfQ3P6MYm9j7s90pD1Aon1D
         cUILyyqsELX4DyYXTCFXqS0WLorcd2caSKz2TZX/oQHqOkqsZbESiLdr5arVwD+5BVcw
         7rvXDqmtiN5rX5PQFMCSiox3uZi3RNqMCyVY3ZY9dBxXft98NZcnzVR0S/2UWXOuQOxs
         Czdo2GxiCXN4ldhCDT3U71PmDa+k7eulFTTl7n7o0FPwjPQziFxEobMqfBe71qaBi4hi
         2ZsQ==
X-Forwarded-Encrypted: i=1; AFNElJ+z6dexeIYJhmdbuQV8tNq7f4Eo6mEk+FCSjYcsYv+wYW8V/pTKVd7eou85f9JSYqco+ZAtTQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyFBQuLImQlkjkWE2msOc4uUeT0WlJlYUJdiJDwTyBRW2xbNLuz
	PdLWXjCsAvbhvOrtEwy99iYrzpyc7pVO2FL3vkKAG9LQwOOGk92XawlOVAVjO4qHq8g=
X-Gm-Gg: Acq92OHWIv3LnvCbGr/aaSPOPIzf/p2YhQgMPhsdHFVqJdR3tlhSqnrHkMpkDsj6aZ1
	9vAQ4OWb2nN70wyAtSHm8Z+C1a4AXoQFXyGR4b+Qdy18T6kAxW1ZErd/omOvYUDUazh15gIIM1L
	53+l8LXk4cHnpRvZ8CQAtoyJFV3joLpan5T9bEq/n1D65QUt3xupiw5r+cEFcTa+plp11T7Fgkw
	B3GR4oBHbmoyhlfE2IHVfTr9wyzYjjoWLGk646EnMJyC6ekGT8xkxxFRmVpqBnHtS2gDrODYyQO
	rANN/yvOarrEQfCwUrKzrsg35Wp9qORwIJ9hePbuxdcCzjkL3AzaQY/b3NUAvO9Fz8ZXTWWG2oP
	0uVnhDfAbRka5iM7s+yB8iMT+qOlH5nZ1RG6IEyNqvis7Uw/LBAn6anZAhbM0WkVl41iXE83rOA
	VR7SgHkDdGdeO4vUTOClgRQ/l9lQejLmY4Eu4r+YQWOG0EySVC7I1rFzd/ZpJkgFxJIWDd8i7X
X-Received: by 2002:a05:622a:5805:b0:516:e722:5ed1 with SMTP id d75a77b69052e-5172dd1e2a1mr15106211cf.29.1780024880588;
        Thu, 28 May 2026 20:21:20 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea26d286sm1179476d6.48.2026.05.28.20.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 20:21:20 -0700 (PDT)
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
Subject: [PATCH v3 09/11] selftests/liveupdate: Test session and file limit removal
Date: Fri, 29 May 2026 03:21:04 +0000
Message-ID: <20260529032106.1505796-10-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529032106.1505796-1-pasha.tatashin@soleen.com>
References: <20260529032106.1505796-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_202121_946059_6F4A6624 
X-CRM114-Status: GOOD (  17.44  )
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


