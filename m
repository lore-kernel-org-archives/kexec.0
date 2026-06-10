Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC67CD98CC
	for <kexec@archiver.kernel.org>; Wed, 10 Jun 2026 23:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xiUkUKbbG5deAylPZ6LVrWFSOhIO30paK4vC1S4mCjU=; b=aG3MUEl2tB3qL5Mkh3wJ3z3oqg
	lQCQUTQxrZyevgZJl3wr1BThbg+n7E+j+ESpBsLtbVAjD/y9wHAZThEB4OD3xxi4EcZxQB6/0pUW3
	ilXMPzZkLSUBh4GYB02+YJ8nneEhQdV/mKDrDdDCv/bbUDTp+eRHItKfQ7UvZDoNM2/EvvLctiBSB
	pODNB3q/AydlS/F4xsFyzNmFKIupf9vh9CxA+IQFdY461YKJocfMciYKhYgTi9u+R8vQCdTSff5b1
	lblLhTR7ByCVEDDakOlqksO6j5XwvDw+kJzhoTw3D8HdZAStpO96Hx3QM/9cHczlrh9Da9A+/DhHo
	fymDzR/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXS2y-00000008S8W-1VW2;
	Wed, 10 Jun 2026 23:09:20 +0000
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXS2w-00000008S6k-122g
	for kexec@lists.infradead.org;
	Wed, 10 Jun 2026 23:09:19 +0000
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-2bf3636d6c0so75989845ad.2
        for <kexec@lists.infradead.org>; Wed, 10 Jun 2026 16:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781132957; x=1781737757; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xiUkUKbbG5deAylPZ6LVrWFSOhIO30paK4vC1S4mCjU=;
        b=oRYzo9M4qDtnY/TXUzcC8dfH0PoIDPRRVQRttHLvdFGv08ggm8RRADi2ysSHmdck4I
         Rj87u9tHoH3nSdqO3fjOh/2MJ4tznCkRzgPANWyzLYer/MQsGlXPt7ZngvZgUN3zVAdB
         f9vcAJLT/k2N8PS2L4V2u3RGX8RHcfuSMabr9PXcFUl3i7bxAJ1AGCdKGxAO0k9DjNoi
         LPecmXPy+ykJVUlbNZQdF/zCHhxB9LIqJWQWpW8sMg2Q42+1/WZtyaSG1PvLYgKHk1eS
         DKW3FhY4Im+JcppRCHC6fc3/BJDIx1QHSv86K7/MK0rXrRxdk3fhAzC/pn5baGn6vPbB
         dFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781132957; x=1781737757;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xiUkUKbbG5deAylPZ6LVrWFSOhIO30paK4vC1S4mCjU=;
        b=AdGY58fX+6GzIKt4GxPQ8ZNKqYtgHtdkBPCUxS4ieBmbVcvwg6iNl4YXT57dXhwLR6
         0GXz5UsTThMUcl7daFmK1GlaiZ+u22yEWykOMAb/BZMBPhArhuAWdc7SW1vDM5Ao6/Vn
         5VLxmScbXIkV50pWGODuV6hdmolRfljew+PhmQwmF4HuNffIPyVANQzBZfggOHXsTqxT
         9QGWGxUC5m3GkEHKSeY5l2WArCHffVwJ99sJfGAQCJN7SeMSuPYPLe39DLEI116ESdtN
         CHB9A7pWJJ9p5iwqo55quqtShUyYFKgA3w0996U4OgCV7cGPbnIq5KnxWb/QrnIdIMxm
         lUcQ==
X-Forwarded-Encrypted: i=1; AFNElJ8onSJMerVkUTbjVltbhuWpLAOsX2F1IsN5SaHX6GL3nMD56Bz9DGthx3RbmDemxdFeCuZwlw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzVZbYq1MXpNFAtz2rEuk47bpgp3KiW6j0xxJVKHNX1szWbCI8V
	QFnp/sLpD1oUE3RhJDbyxEXT/5k+kitjoiM5lvgnvP1SpAUKcE9dnTzdp48tRSYY7P7PjYl25+3
	ZMwpMXyw4kQ==
X-Received: from plom12.prod.google.com ([2002:a17:903:3c0c:b0:2bf:1486:2669])
 (user=vipinsh job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3d10:b0:2c2:2a8a:af69
 with SMTP id d9443c01a7336-2c2f0f1f8a2mr906585ad.9.1781132956533; Wed, 10 Jun
 2026 16:09:16 -0700 (PDT)
Date: Wed, 10 Jun 2026 16:09:08 -0700
In-Reply-To: <20260610230909.876546-1-vipinsh@google.com>
Mime-Version: 1.0
References: <20260610230909.876546-1-vipinsh@google.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <20260610230909.876546-3-vipinsh@google.com>
Subject: [PATCH v2 2/2] selftests/liveupdate: Add helpers to preserve/retrieve FDs
From: Vipin Sharma <vipinsh@google.com>
To: pasha.tatashin@soleen.com, rppt@kernel.org, pratyush@kernel.org
Cc: tarunsahu@google.com, skhawaja@google.com, shuah@kernel.org, 
	dmatlack@google.com, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-kselftest@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_160918_308502_562F94DE 
X-CRM114-Status: GOOD (  14.12  )
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

Add helper functions to preserve and retrieve file descriptors from an
LUO session. This allows library users to work with FD preservation.

Now that there are helpers, use them instead of direct ioctl calls
in liveupdate.c

No functional change intended.

Co-developed-by: David Matlack <dmatlack@google.com>
Signed-off-by: David Matlack <dmatlack@google.com>
Signed-off-by: Vipin Sharma <vipinsh@google.com>
---
 .../liveupdate/lib/include/libliveupdate.h    |  2 +
 .../selftests/liveupdate/lib/liveupdate.c     | 41 +++++++++++++++----
 .../testing/selftests/liveupdate/liveupdate.c | 38 ++++++-----------
 3 files changed, 46 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h b/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h
index 6ff71d7c3d9c..2c6a6f6a2733 100644
--- a/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h
+++ b/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h
@@ -27,6 +27,8 @@ int luo_retrieve_session(int luo_fd, const char *name);
 int luo_session_finish(int session_fd);
 
 int luo_ensure_nofile_limit(long min_limit);
+int luo_session_preserve_fd(int session_fd, int fd, __u64 token);
+int luo_session_retrieve_fd(int session_fd, __u64 token);
 
 int create_and_preserve_memfd(int session_fd, int token, const char *data);
 int restore_and_verify_memfd(int session_fd, int token, const char *expected_data);
diff --git a/tools/testing/selftests/liveupdate/lib/liveupdate.c b/tools/testing/selftests/liveupdate/lib/liveupdate.c
index 897c200f3845..961a732b541d 100644
--- a/tools/testing/selftests/liveupdate/lib/liveupdate.c
+++ b/tools/testing/selftests/liveupdate/lib/liveupdate.c
@@ -78,9 +78,35 @@ int luo_retrieve_session(int luo_fd, const char *name)
 	return arg.fd;
 }
 
+int luo_session_preserve_fd(int session_fd, int fd, __u64 token)
+{
+	struct liveupdate_session_preserve_fd arg = {
+		.size = sizeof(arg),
+		.fd = fd,
+		.token = token,
+	};
+
+	if (ioctl(session_fd, LIVEUPDATE_SESSION_PRESERVE_FD, &arg) < 0)
+		return -errno;
+
+	return 0;
+}
+
+int luo_session_retrieve_fd(int session_fd, __u64 token)
+{
+	struct liveupdate_session_retrieve_fd arg = {
+		.size = sizeof(arg),
+		.token = token,
+	};
+
+	if (ioctl(session_fd, LIVEUPDATE_SESSION_RETRIEVE_FD, &arg) < 0)
+		return -errno;
+
+	return arg.fd;
+}
+
 int create_and_preserve_memfd(int session_fd, int token, const char *data)
 {
-	struct liveupdate_session_preserve_fd arg = { .size = sizeof(arg) };
 	long page_size = sysconf(_SC_PAGE_SIZE);
 	void *map = MAP_FAILED;
 	int mfd = -1, ret = -1;
@@ -99,9 +125,8 @@ int create_and_preserve_memfd(int session_fd, int token, const char *data)
 	snprintf(map, page_size, "%s", data);
 	munmap(map, page_size);
 
-	arg.fd = mfd;
-	arg.token = token;
-	if (ioctl(session_fd, LIVEUPDATE_SESSION_PRESERVE_FD, &arg) < 0)
+	ret = luo_session_preserve_fd(session_fd, mfd, token);
+	if (ret)
 		goto out;
 
 	ret = 0;
@@ -116,15 +141,13 @@ int create_and_preserve_memfd(int session_fd, int token, const char *data)
 int restore_and_verify_memfd(int session_fd, int token,
 			     const char *expected_data)
 {
-	struct liveupdate_session_retrieve_fd arg = { .size = sizeof(arg) };
 	long page_size = sysconf(_SC_PAGE_SIZE);
 	void *map = MAP_FAILED;
 	int mfd = -1, ret = -1;
 
-	arg.token = token;
-	if (ioctl(session_fd, LIVEUPDATE_SESSION_RETRIEVE_FD, &arg) < 0)
-		return -errno;
-	mfd = arg.fd;
+	mfd = luo_session_retrieve_fd(session_fd, token);
+	if (mfd < 0)
+		return mfd;
 
 	map = mmap(NULL, page_size, PROT_READ, MAP_SHARED, mfd, 0);
 	if (map == MAP_FAILED)
diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
index 6bfd4e53528c..e17a13136330 100644
--- a/tools/testing/selftests/liveupdate/liveupdate.c
+++ b/tools/testing/selftests/liveupdate/liveupdate.c
@@ -170,20 +170,6 @@ TEST_F(liveupdate_device, create_distinct_sessions)
 	ASSERT_EQ(close(session_fd2), 0);
 }
 
-static int preserve_fd(int session_fd, int fd_to_preserve, __u64 token)
-{
-	struct liveupdate_session_preserve_fd args = {};
-
-	args.size = sizeof(args);
-	args.fd = fd_to_preserve;
-	args.token = token;
-
-	if (ioctl(session_fd, LIVEUPDATE_SESSION_PRESERVE_FD, &args))
-		return -errno;
-
-	return 0;
-}
-
 /*
  * Test Case: Preserve MemFD
  *
@@ -208,7 +194,7 @@ TEST_F(liveupdate_device, preserve_memfd)
 	ASSERT_GE(mem_fd, 0);
 
 	ASSERT_EQ(write(mem_fd, test_str, strlen(test_str)), strlen(test_str));
-	ASSERT_EQ(preserve_fd(session_fd, mem_fd, 0x1234), 0);
+	ASSERT_EQ(luo_session_preserve_fd(session_fd, mem_fd, 0x1234), 0);
 	ASSERT_EQ(close(session_fd), 0);
 
 	ASSERT_EQ(lseek(mem_fd, 0, SEEK_SET), 0);
@@ -247,8 +233,8 @@ TEST_F(liveupdate_device, preserve_multiple_memfds)
 	ASSERT_EQ(write(mem_fd1, test_str1, strlen(test_str1)), strlen(test_str1));
 	ASSERT_EQ(write(mem_fd2, test_str2, strlen(test_str2)), strlen(test_str2));
 
-	ASSERT_EQ(preserve_fd(session_fd, mem_fd1, 0xAAAA), 0);
-	ASSERT_EQ(preserve_fd(session_fd, mem_fd2, 0xBBBB), 0);
+	ASSERT_EQ(luo_session_preserve_fd(session_fd, mem_fd1, 0xAAAA), 0);
+	ASSERT_EQ(luo_session_preserve_fd(session_fd, mem_fd2, 0xBBBB), 0);
 
 	memset(read_buf, 0, sizeof(read_buf));
 	ASSERT_EQ(lseek(mem_fd1, 0, SEEK_SET), 0);
@@ -303,10 +289,10 @@ TEST_F(liveupdate_device, preserve_complex_scenario)
 	mem_fd_empty2 = memfd_create("empty2", 0);
 	ASSERT_GE(mem_fd_empty2, 0);
 
-	ASSERT_EQ(preserve_fd(session_fd1, mem_fd_data1, 0x1111), 0);
-	ASSERT_EQ(preserve_fd(session_fd1, mem_fd_empty1, 0x2222), 0);
-	ASSERT_EQ(preserve_fd(session_fd2, mem_fd_data2, 0x3333), 0);
-	ASSERT_EQ(preserve_fd(session_fd2, mem_fd_empty2, 0x4444), 0);
+	ASSERT_EQ(luo_session_preserve_fd(session_fd1, mem_fd_data1, 0x1111), 0);
+	ASSERT_EQ(luo_session_preserve_fd(session_fd1, mem_fd_empty1, 0x2222), 0);
+	ASSERT_EQ(luo_session_preserve_fd(session_fd2, mem_fd_data2, 0x3333), 0);
+	ASSERT_EQ(luo_session_preserve_fd(session_fd2, mem_fd_empty2, 0x4444), 0);
 
 	ASSERT_EQ(lseek(mem_fd_data1, 0, SEEK_SET), 0);
 	ASSERT_EQ(read(mem_fd_data1, read_buf, sizeof(read_buf)), strlen(data1));
@@ -355,7 +341,7 @@ TEST_F(liveupdate_device, preserve_unsupported_fd)
 	unsupported_fd = open("/dev/null", O_RDWR);
 	ASSERT_GE(unsupported_fd, 0);
 
-	ret = preserve_fd(session_fd, unsupported_fd, 0xDEAD);
+	ret = luo_session_preserve_fd(session_fd, unsupported_fd, 0xDEAD);
 	EXPECT_EQ(ret, -ENOENT);
 
 	ASSERT_EQ(close(unsupported_fd), 0);
@@ -388,14 +374,14 @@ TEST_F(liveupdate_device, prevent_double_preservation)
 	ASSERT_GE(mem_fd, 0);
 
 	/* First preservation should succeed */
-	ASSERT_EQ(preserve_fd(session_fd1, mem_fd, 0x1111), 0);
+	ASSERT_EQ(luo_session_preserve_fd(session_fd1, mem_fd, 0x1111), 0);
 
 	/* Second preservation in a different session should fail with EBUSY */
-	ret = preserve_fd(session_fd2, mem_fd, 0x2222);
+	ret = luo_session_preserve_fd(session_fd2, mem_fd, 0x2222);
 	EXPECT_EQ(ret, -EBUSY);
 
 	/* Second preservation in the same session (different token) should fail with EBUSY */
-	ret = preserve_fd(session_fd1, mem_fd, 0x3333);
+	ret = luo_session_preserve_fd(session_fd1, mem_fd, 0x3333);
 	EXPECT_EQ(ret, -EBUSY);
 
 	ASSERT_EQ(close(mem_fd), 0);
@@ -565,7 +551,7 @@ TEST_F(liveupdate_device, preserve_many_files)
 	for (i = 0; i < MANY_FILES; i++) {
 		mem_fds[i] = memfd_create("test-memfd", 0);
 		ASSERT_GE(mem_fds[i], 0);
-		ASSERT_EQ(preserve_fd(session_fd, mem_fds[i], i), 0);
+		ASSERT_EQ(luo_session_preserve_fd(session_fd, mem_fds[i], i), 0);
 	}
 
 	for (i = 0; i < MANY_FILES; i++)
-- 
2.54.0.1099.g489fc7bff1-goog


