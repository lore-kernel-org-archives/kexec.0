Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CEAECC6B3B
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 09:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZWkatgtkqZBCSGS/DoNd/wVrCRwtNmgFeYJzwykKUrU=; b=FPLCnITi+QXursKsN32UoBb0PN
	xF65iHFxzY2xYJUvcKimQAEFpUQPXrrCYy5rsLyll6kqaerwc23G6nwId5iCZrd0ZFY3ef0RiE+uO
	FkBSPxstWnIJvzL+YshAuh4RkE/g+2+ss7dptv7/lzb56Ts+DqGUymwU9RVhuW8fdxt2Hp+AsDFKB
	LPVdDpFrfumKeZoXCerSziHO2VR9pD2XUdM1sZ1DvvYZesqi7kGCErpUD2StznwdNlzskVS40wvIM
	T7xhv5tqCUjPhhuVtVeTzswHoCNMp1z1HjFUpibevdyzEwUec5T+8eEqiFcrq9EaKg9OofjjrCPXL
	X4rr6uDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHHv2-0000000HI3L-2a9l;
	Thu, 15 Oct 2026 09:38:36 +0000
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHHv0-0000000HI1U-0Mmw
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 09:38:35 +0000
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-9906c3fc88cso421805241.2
        for <kexec@lists.infradead.org>; Thu, 15 Oct 2026 02:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792057113; x=1792661913; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZWkatgtkqZBCSGS/DoNd/wVrCRwtNmgFeYJzwykKUrU=;
        b=Hh8SmohAbQdFa1jzeEcalZm4EukV+6CID1WkU2A2jTacvCOSJ4ytYa9WdFMrSi1OhD
         ggSKjPWIxlOl+s60ynaB8HZyOuPw46ZiHAhgVFmPgUQcVIjV/E4ZlnRsT8onTesaOpOa
         XcEmAwswnHB/60QtM19j3OhH36ye5JEcPe9mStgtofUxPhNFa4ElSAMncGliKb6y9zh/
         nJSGgc/t3GLOlMFo2muFzaW3Q9+BkIEdVpZaOzqCWVh08/s3SNOTXNrSXxdKNrWSbPsO
         qyl6mFQfKbZs43l0Wh2aDZYavDpityHbOVSGiOj3gT4s0Lx4K580A7zebdvHFYRd8YzK
         jkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792057113; x=1792661913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZWkatgtkqZBCSGS/DoNd/wVrCRwtNmgFeYJzwykKUrU=;
        b=zhb5gsqTzVAW7KMM4y7uP2fGTWMw74JK0k4E8gaaS/RI6DVrUPUWYqW6vv0/za5m/z
         RAwTgXFAJCi3WHo2H8peZIoMaVpUQHtBux5kpY7hnVb2paPbzihtHLEkGTRUNRf0hDTH
         5Z4irEt8BGqEJotCzp8CO5rxuJ/NJBMbtN0fml5Kok5eiyZ2yQsQDz/5c4GZspa0Vo+J
         F6FbfcVc3I5twMT54ZPe2kBEZUiOLlspW+RkQcu1xuiib0S9cRURyaEN19OG9fZVCFDI
         0l7KDtlKSeDQ01TTrWx6XD2GuHI495Hsxhylvi2wixqIrwI6jd66wMAUs0nAy535LdOh
         Sexg==
X-Forwarded-Encrypted: i=1; AKwUvBzIGZiqKQz48igwYAQUmNFZTqp8XgFjRJ7A5ObWGDYgx80PLg20KdRnJAryQdNuFj1E0FKcWA==@lists.infradead.org
X-Gm-Message-State: AFq9FYIOTOTYuLZZG4buR7BEIwc7zbKO+/G+dbzmNf3d8QYoFVPK0PBh
	4sH8yfdLoScOIkcI077dRXQit4C4Am4XZ1Qd5vR64KJi51yP3c7ftCpi+BaW508tBxc=
X-Gm-Gg: AYBFou2CPiVyuIqSdx5PttjNhstHAI1ofrQIRM04yPWj5QMotplyyrRpFhFRaJ9fMuI
	XMdhgi47Rv0RIiCtL4BpzODVKLMDKdgnwpalnpPkX3ksZfZAckvsmtJPSdiFfohWyT7EZ/db+gn
	w5lJAbvUtWhcgsCZst/2Es8aq7RU+2dtt1Y5Cs3LlcV2txUoySxHLDOzPfa6vOo/nceWaxngUyV
	YnXS7IvB1AggWZhGvv9JkDMDYkItawno97v2RPoEVI5TP5XlLEp4OJFSdPoNtrpC6v4Fiv882j2
	61Z+lHCZiWuLrVAcBIVtdJicHJY/MCFMkgdRHIX1yHIqyYMG+5PvUIgBWL3wRkJDR2yBvU8XfEM
	MjGgeqjOYM/2cpTgprboXNhYLOevG/l31gOFwvyRZvtuJY/E6AwiY8cMZ+Kt/maA/Unofluvlzu
	/MTd1A2VIf2ywSbERnOJBPJJkAK+zrqaplYFmljiTLFV/Nqlakt9YKHaPTPQwmCdfepK44sXb3o
	wik6yiq/5wNlTWqClqRx+bGn8aB4NudLxxyDMUWh1yQ4Q3LxEpRnKvtdjDj2P/v+7yvrCFWWXrc
	e3U5TuQSowdsD0zJNlA=
X-Received: by 2002:a05:6102:2c85:b0:7cb:288a:b678 with SMTP id ada2fe7eead31-7cb372a8aa2mr5907427137.19.1792057112741;
        Thu, 15 Oct 2026 02:38:32 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99003d37009sm12275672241.2.2026.10.15.02.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 02:38:31 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	shuah@kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	vipinsh@google.com,
	linux-kernel@vger.kernel.org,
	pasha.tatashin@soleen.com,
	dmatlack@google.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	graf@amazon.com
Subject: [PATCH v1 4/7] selftests: liveupdate: Add tests for preserve and retrieve user argument
Date: Thu, 15 Oct 2026 05:38:13 -0400
Message-ID: <20261015093816.2438942-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261015093816.2438942-1-pasha.tatashin@soleen.com>
References: <20261015093816.2438942-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261015_023834_141675_203F74EB 
X-CRM114-Status: GOOD (  15.65  )
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

Verify the user argument support in LIVEUPDATE_SESSION_PRESERVE_FD and
LIVEUPDATE_SESSION_RETRIEVE_FD. Add luo_session_preserve_fd_arg() and
luo_session_retrieve_fd_arg() helpers to libliveupdate so tests can pass
a handler-specific argument.

Add a preserve_memfd_with_arg test case to verify that memfd
preservation rejects a non-zero argument with -EOPNOTSUPP, accepts an
explicit zero argument, and remains compatible with callers passing the
legacy struct size up to the token field.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 .../liveupdate/lib/include/libliveupdate.h    |  3 ++
 .../selftests/liveupdate/lib/lu_utils.c       | 17 ++++++-
 .../testing/selftests/liveupdate/liveupdate.c | 44 +++++++++++++++++++
 3 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h b/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h
index 15a7db3a6b3e8..8a38268e89dee 100644
--- a/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h
+++ b/tools/testing/selftests/liveupdate/lib/include/libliveupdate.h
@@ -30,7 +30,10 @@ int luo_session_freeze(int session_fd);
 
 int luo_ensure_nofile_limit(long min_limit);
 int luo_session_preserve_fd(int session_fd, int fd, __u64 token);
+int luo_session_preserve_fd_arg(int session_fd, int fd, __u64 token,
+				__u64 user_arg);
 int luo_session_retrieve_fd(int session_fd, __u64 token);
+int luo_session_retrieve_fd_arg(int session_fd, __u64 token, __u64 user_arg);
 
 int create_and_preserve_memfd(int session_fd, int token, const char *data);
 int restore_and_verify_memfd(int session_fd, int token, const char *expected_data);
diff --git a/tools/testing/selftests/liveupdate/lib/lu_utils.c b/tools/testing/selftests/liveupdate/lib/lu_utils.c
index 6315746ff08f8..5c6f8bf80b297 100644
--- a/tools/testing/selftests/liveupdate/lib/lu_utils.c
+++ b/tools/testing/selftests/liveupdate/lib/lu_utils.c
@@ -79,12 +79,14 @@ int luo_retrieve_session(int luo_fd, const char *name)
 	return arg.fd;
 }
 
-int luo_session_preserve_fd(int session_fd, int fd, __u64 token)
+int luo_session_preserve_fd_arg(int session_fd, int fd, __u64 token,
+				__u64 user_arg)
 {
 	struct liveupdate_session_preserve_fd arg = {
 		.size = sizeof(arg),
 		.fd = fd,
 		.token = token,
+		.arg = user_arg,
 	};
 
 	if (ioctl(session_fd, LIVEUPDATE_SESSION_PRESERVE_FD, &arg))
@@ -93,11 +95,17 @@ int luo_session_preserve_fd(int session_fd, int fd, __u64 token)
 	return 0;
 }
 
-int luo_session_retrieve_fd(int session_fd, __u64 token)
+int luo_session_preserve_fd(int session_fd, int fd, __u64 token)
+{
+	return luo_session_preserve_fd_arg(session_fd, fd, token, 0);
+}
+
+int luo_session_retrieve_fd_arg(int session_fd, __u64 token, __u64 user_arg)
 {
 	struct liveupdate_session_retrieve_fd arg = {
 		.size = sizeof(arg),
 		.token = token,
+		.arg = user_arg,
 	};
 
 	if (ioctl(session_fd, LIVEUPDATE_SESSION_RETRIEVE_FD, &arg))
@@ -106,6 +114,11 @@ int luo_session_retrieve_fd(int session_fd, __u64 token)
 	return arg.fd;
 }
 
+int luo_session_retrieve_fd(int session_fd, __u64 token)
+{
+	return luo_session_retrieve_fd_arg(session_fd, token, 0);
+}
+
 /* Helper function to get a session name via ioctl. */
 int luo_get_session_name(int session_fd, char *name, size_t name_len)
 {
diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
index 9de068f31c3ec..83e0978f3818d 100644
--- a/tools/testing/selftests/liveupdate/liveupdate.c
+++ b/tools/testing/selftests/liveupdate/liveupdate.c
@@ -20,6 +20,7 @@
 
 #include <errno.h>
 #include <fcntl.h>
+#include <stddef.h>
 #include <string.h>
 #include <sys/ioctl.h>
 #include <unistd.h>
@@ -570,4 +571,47 @@ TEST_F(liveupdate_device, session_freeze)
 	ASSERT_EQ(close(mem_fd2), 0);
 }
 
+/*
+ * Test Case: Preserve MemFD with User Argument
+ *
+ * Verifies that passing a non-zero user argument to memfd preservation fails
+ * with -EOPNOTSUPP, while passing a zero argument or using the minimum struct
+ * size without the arg field succeeds.
+ */
+TEST_F(liveupdate_device, preserve_memfd_with_arg)
+{
+	struct liveupdate_session_preserve_fd min_arg = {};
+	int session_fd, mem_fd1, mem_fd2;
+
+	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
+	if (self->fd1 < 0 && errno == ENOENT)
+		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
+	ASSERT_GE(self->fd1, 0);
+
+	session_fd = luo_create_session(self->fd1, "preserve-arg-test");
+	ASSERT_GE(session_fd, 0);
+
+	mem_fd1 = memfd_create("arg-memfd-1", 0);
+	ASSERT_GE(mem_fd1, 0);
+
+	/* Non-zero arg is not supported by memfd handler */
+	EXPECT_EQ(luo_session_preserve_fd_arg(session_fd, mem_fd1, 0x1111, 1),
+		  -EOPNOTSUPP);
+
+	/* Legacy struct size (up to token) should zero-fill arg and succeed */
+	min_arg.size = offsetof(struct liveupdate_session_preserve_fd, arg);
+	min_arg.fd = mem_fd1;
+	min_arg.token = 0x1111;
+	ASSERT_EQ(ioctl(session_fd, LIVEUPDATE_SESSION_PRESERVE_FD, &min_arg), 0);
+
+	/* Explicit zero arg with full struct size should also succeed */
+	mem_fd2 = memfd_create("arg-memfd-2", 0);
+	ASSERT_GE(mem_fd2, 0);
+	ASSERT_EQ(luo_session_preserve_fd_arg(session_fd, mem_fd2, 0x2222, 0), 0);
+
+	ASSERT_EQ(close(session_fd), 0);
+	ASSERT_EQ(close(mem_fd1), 0);
+	ASSERT_EQ(close(mem_fd2), 0);
+}
+
 TEST_HARNESS_MAIN
-- 
2.56.0.385.gd3acb90ef8-goog


