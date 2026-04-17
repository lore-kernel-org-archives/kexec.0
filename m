Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2E5F8E498
	for <kexec@archiver.kernel.org>; Fri, 17 Apr 2026 00:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wonoc5490QuGHhln27veolm76wdYSRsus2wubp5nw+8=; b=YxSbk6zUlUIfBb9jKS2zOcwFpw
	ts6Skr3MWScTxgwH0I0NENFwqmkTfqGJoJQHeSo1QSUj1ELlxhKREcz7JAkQ/056jCwFJ2ftND9Bf
	SmbXGLHeHhmaQwD+O2E0xWvojUskWemaXDobKprru7B1Vd3N4LDv9Clfw+2NKhucRl1+NIhFhUEo+
	zTWMqQLzHxbViOiKFluGmfmTsrwfStx3IpSCG7bwTDHh974v28Bi0kkSZlAg27mmRrLIU3pqSYXzl
	7rm9RQ/BHrWROvOPqXNFaaXfD/MDZVDpCKS6idrGworX7TAx/65zQCmAg3sFfcriuNptgqweZiqrD
	fRdNJk8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDXEh-00000003EtF-3vFS;
	Fri, 17 Apr 2026 00:39:07 +0000
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDXEc-00000003EsU-1Y8C
	for kexec@lists.infradead.org;
	Fri, 17 Apr 2026 00:39:03 +0000
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-482f454be5bso12065075e9.0
        for <kexec@lists.infradead.org>; Thu, 16 Apr 2026 17:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776386340; x=1776991140; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wonoc5490QuGHhln27veolm76wdYSRsus2wubp5nw+8=;
        b=L0JF6GHtNk2DLwaDAwFOJJ5HQi5kynP8jpLpoOczutMsu7x5vBPCftj4fNR98VDq+P
         O28y5qNk9Ugy/Z0rxChDZgAEMCYyRVmZAaJHlGLRhNjD8/U6g64JX3RY9VBprxqBdyPp
         GH516lTi2REPvcuxkPz2CmIj3x2xVAHumgqSUBbrYEyaz6JASaje1quP61RQdFKIgnyJ
         1904OxPKsk5Ej7pKdQk2/DOM/07P0mlpOq20JZy9kgv/4qwTy8w7uTCoANAp2ri0OETs
         vaeAi2hJgBe7Q9poGBqCPu1ZDc6dC/Q0WhMtgRxxTPFXlYGffRtJ9iekXCFJXmsbCrgd
         Nd9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776386340; x=1776991140;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wonoc5490QuGHhln27veolm76wdYSRsus2wubp5nw+8=;
        b=godIW1zU7Xn94gmwLapQqsPFDHfMvZ6Bcui6B/JztO/YFvHEHCcrsZhp1t7SYTaXDU
         ofETJ5a62465WdDF/j0AFlAw6pai0vhSAe7MNnSpxahJ7qfpqKoZypfdEKDLgzXMVCwk
         cgChnndbLAJylp/tturnCYBOC6gsM7u9RMtDnA7eVmcYAZM1SlQz8dmnksWu3edhRyMg
         eFgiYXFOme8f5KVdfDH//rJFtAL1YI/dgY1C2suMr6r+pmo3U9nfM0PfG0zXpn+uaYwp
         JOGKP8lypt8SNVpQYIbc5l8WZzDdNrG5FCvKInlhoAXcnFIDImI2h1IX8T2sVxRPQTuW
         +HoA==
X-Gm-Message-State: AOJu0YyAe/ZReoLfwYApGq+8C8VuuHdGy6Yu/SGZd6UW95p/ANTw52l7
	l500trPHxRtp21xDfhIEt0Pa5fsOQwEAkhcH/MNa4U6pw1tqZd+emnHJXSazEpM1
X-Gm-Gg: AeBDiev2675xeRgRb9W3am7NrGF8rs+GBo3UBAFbdzdVnVhJCbkV0y8rmY6+exMFPzk
	kkuM6GlhP7SUB/yRbqz1/923KgQcZKcnT8U3HnoD5QFRw1wQauVJixKssAQKNXedeSrkPNGrBrU
	UC5MeF13mJp95KavB7jqRvlS1ok5ldqkwl5UO1UK9PDkV86vr3oB/e+XQYrwybl8GonbaEHUFtw
	DJsEFyUKwHTswWgrcEpiDLAot2HCTfkeZlLOuAjyD9u8RGW1vLYPDMq/aG2d+rcKfcygiDUxOjI
	LUe0HubDD+0VsZEdhT8nMlr8/5IXAeq/FvlI1+2tLyNctf4yQGRwGJ0wmQVJ1nSAKoNL6R3AC0k
	v4m8IizFyYgk0Ltu3gOvEdXoZaOVo9u1FlBXoswQUok0d8XMT+wf5oRx86b61nGhd1GK+LQiZXb
	LkdQsjES2Gu+jZbcWG8YtrPf+33SAZu7qApXK4/9E=
X-Received: by 2002:a05:600c:8884:b0:477:9890:9ab8 with SMTP id 5b1f17b1804b1-488fb88380amr4504715e9.3.1776386339675;
        Thu, 16 Apr 2026 17:38:59 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:f478:3ca4:c1b8:70d5])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-488fc189f2esm2442535e9.7.2026.04.16.17.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 17:38:59 -0700 (PDT)
From: luca.boccassi@gmail.com
To: kexec@lists.infradead.org
Cc: linux-mm@kvack.org,
	graf@amazon.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	brauner@kernel.org,
	Luca Boccassi <luca.boccassi@gmail.com>
Subject: [PATCH v2] liveupdate: add LIVEUPDATE_SESSION_GET_NAME ioctl
Date: Fri, 17 Apr 2026 01:36:58 +0100
Message-ID: <20260417003856.1525287-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260416_173902_497794_14F9E7FA 
X-CRM114-Status: GOOD (  20.04  )
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

From: Luca Boccassi <luca.boccassi@gmail.com>

Userspace when requesting a session via the ioctl specifies a name and
gets a FD, but then there is no ioctl to go back the other way and get
the name given a LUO session FD. This is problematic especially when
there is a userspace orchestrator that wants to check what FDs it is
handling for clients without having to do manual string scraping of
procfs, or without procfs at all.

Add a ioctl to simply get the name from an FD.

Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
---
This was requested by Lennart and Christian when discussing integration
with systemd for LUO management.

v2: apply one fix from bot review about cleanup on error path:
    https://sashiko.dev/#/patchset/20260415184536.1155220-1-luca.boccassi%40gmail.com
    the other comments are invalid: luo is not a kmod, and the write hooks are not set up

 include/uapi/linux/liveupdate.h               | 19 +++++
 kernel/liveupdate/luo_session.c               | 13 ++++
 .../testing/selftests/liveupdate/liveupdate.c | 71 +++++++++++++++++++
 3 files changed, 103 insertions(+)

diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveupdate.h
index 30bc66ee9436a..41dc44d239dde 100644
--- a/include/uapi/linux/liveupdate.h
+++ b/include/uapi/linux/liveupdate.h
@@ -59,6 +59,7 @@ enum {
 	LIVEUPDATE_CMD_SESSION_PRESERVE_FD = LIVEUPDATE_CMD_SESSION_BASE,
 	LIVEUPDATE_CMD_SESSION_RETRIEVE_FD = 0x41,
 	LIVEUPDATE_CMD_SESSION_FINISH = 0x42,
+	LIVEUPDATE_CMD_SESSION_GET_NAME = 0x43,
 };
 
 /**
@@ -213,4 +214,22 @@ struct liveupdate_session_finish {
 #define LIVEUPDATE_SESSION_FINISH					\
 	_IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_SESSION_FINISH)
 
+/**
+ * struct liveupdate_session_get_name - ioctl(LIVEUPDATE_SESSION_GET_NAME)
+ * @size:  Input; sizeof(struct liveupdate_session_get_name)
+ * @name:  Output; A null-terminated string with the full session name.
+ *
+ * Retrieves the full name of the session associated with this file descriptor.
+ * This is useful because the kernel may truncate the name shown in /proc.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+struct liveupdate_session_get_name {
+	__u32		size;
+	__u8		name[LIVEUPDATE_SESSION_NAME_LENGTH];
+};
+
+#define LIVEUPDATE_SESSION_GET_NAME					\
+	_IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_SESSION_GET_NAME)
+
 #endif /* _UAPI_LIVEUPDATE_H */
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 25ae704d77873..af9e498206d24 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -289,10 +289,21 @@ static int luo_session_finish(struct luo_session *session,
 	return luo_ucmd_respond(ucmd, sizeof(*argp));
 }
 
+static int luo_session_get_name(struct luo_session *session,
+				struct luo_ucmd *ucmd)
+{
+	struct liveupdate_session_get_name *argp = ucmd->cmd;
+
+	strscpy((char *)argp->name, session->name, sizeof(argp->name));
+
+	return luo_ucmd_respond(ucmd, sizeof(*argp));
+}
+
 union ucmd_buffer {
 	struct liveupdate_session_finish finish;
 	struct liveupdate_session_preserve_fd preserve;
 	struct liveupdate_session_retrieve_fd retrieve;
+	struct liveupdate_session_get_name get_name;
 };
 
 struct luo_ioctl_op {
@@ -319,6 +330,8 @@ static const struct luo_ioctl_op luo_session_ioctl_ops[] = {
 		 struct liveupdate_session_preserve_fd, token),
 	IOCTL_OP(LIVEUPDATE_SESSION_RETRIEVE_FD, luo_session_retrieve_fd,
 		 struct liveupdate_session_retrieve_fd, token),
+	IOCTL_OP(LIVEUPDATE_SESSION_GET_NAME, luo_session_get_name,
+		 struct liveupdate_session_get_name, name),
 };
 
 static long luo_session_ioctl(struct file *filep, unsigned int cmd,
diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
index c2878e3d5ef90..bdc1cedc4f944 100644
--- a/tools/testing/selftests/liveupdate/liveupdate.c
+++ b/tools/testing/selftests/liveupdate/liveupdate.c
@@ -102,6 +102,22 @@ static int create_session(int lu_fd, const char *name)
 	return args.fd;
 }
 
+/* Helper function to get a session name via ioctl. */
+static int get_session_name(int session_fd, char *name, size_t name_len)
+{
+	struct liveupdate_session_get_name args = {};
+
+	args.size = sizeof(args);
+
+	if (ioctl(session_fd, LIVEUPDATE_SESSION_GET_NAME, &args))
+		return -errno;
+
+	strncpy(name, (char *)args.name, name_len - 1);
+	name[name_len - 1] = '\0';
+
+	return 0;
+}
+
 /*
  * Test Case: Create Duplicate Session
  *
@@ -345,4 +361,59 @@ TEST_F(liveupdate_device, preserve_unsupported_fd)
 	ASSERT_EQ(close(session_fd), 0);
 }
 
+/*
+ * Test Case: Get Session Name
+ *
+ * Verifies that the full session name can be retrieved from a session file
+ * descriptor via ioctl.
+ */
+TEST_F(liveupdate_device, get_session_name)
+{
+	char name_buf[LIVEUPDATE_SESSION_NAME_LENGTH] = {};
+	const char *session_name = "get-name-test-session";
+	int session_fd;
+
+	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
+	if (self->fd1 < 0 && errno == ENOENT)
+		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
+	ASSERT_GE(self->fd1, 0);
+
+	session_fd = create_session(self->fd1, session_name);
+	ASSERT_GE(session_fd, 0);
+
+	ASSERT_EQ(get_session_name(session_fd, name_buf, sizeof(name_buf)), 0);
+	ASSERT_STREQ(name_buf, session_name);
+
+	ASSERT_EQ(close(session_fd), 0);
+}
+
+/*
+ * Test Case: Get Session Name at Maximum Length
+ *
+ * Verifies that a session name using the full LIVEUPDATE_SESSION_NAME_LENGTH
+ * (minus the null terminator) can be correctly retrieved.
+ */
+TEST_F(liveupdate_device, get_session_name_max_length)
+{
+	char name_buf[LIVEUPDATE_SESSION_NAME_LENGTH] = {};
+	char long_name[LIVEUPDATE_SESSION_NAME_LENGTH];
+	int session_fd;
+
+	memset(long_name, 'A', sizeof(long_name) - 1);
+	long_name[sizeof(long_name) - 1] = '\0';
+
+	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
+	if (self->fd1 < 0 && errno == ENOENT)
+		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
+	ASSERT_GE(self->fd1, 0);
+
+	session_fd = create_session(self->fd1, long_name);
+	ASSERT_GE(session_fd, 0);
+
+	ASSERT_EQ(get_session_name(session_fd, name_buf, sizeof(name_buf)), 0);
+	ASSERT_STREQ(name_buf, long_name);
+
+	ASSERT_EQ(close(session_fd), 0);
+}
+
 TEST_HARNESS_MAIN
-- 
2.47.3


