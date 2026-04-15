Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54713F4213B
	for <kexec@archiver.kernel.org>; Wed, 15 Apr 2026 18:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BphYppqYDh7wB5j90/jJR2V0IBmnVZp6cAEOzQX6UH8=; b=00Slyw9vWm4pGg+nU4RFXrAHVB
	KK6sPEFfyaL3yxh6a1gFec8oELiBeElEtzlJ90le7bd+tL9wnoDPFNn7EmJwr6AYYDnD9JPAVzegY
	4dp1Kr1x8g3GOWDfLgXQXcZBd3ApVHd/4NXAxjAx+ZqeoEjC5sX9w0pTr5e1rmAGgAeusAftqcpgE
	RIgW7SxA/Ghl9KSWFzYTHJ0/RrTBCDZD+vhGpwEGnv/9c9eE0YoTIPEzGTDernWF/bHwiO3xc4U/j
	sIb3NpmpjoMSEGLt2jLXUNix/dPgkmJ6YnviPbptHVwMsvWsyRQNmg/1jrJDm4m3/+GK57yKcdidE
	1ZsNOh4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wD5GK-00000001W7K-1xNb;
	Wed, 15 Apr 2026 18:46:56 +0000
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wD5GI-00000001W6m-124l
	for kexec@lists.infradead.org;
	Wed, 15 Apr 2026 18:46:55 +0000
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-43d64313c39so4173892f8f.3
        for <kexec@lists.infradead.org>; Wed, 15 Apr 2026 11:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776278812; x=1776883612; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BphYppqYDh7wB5j90/jJR2V0IBmnVZp6cAEOzQX6UH8=;
        b=IEVk37jRoL7aM4Wxyw+3YIPg0x6G88wqgoPXAjLrWHPr6EF0WVBiqacvInETSqDReP
         VSQ/dJIbdmv9KWURqzPHWmDgjlCnJLIV90TZWssHimsgSdAkjEWaXS/d6vJZ/BFtCWeM
         izXm125mn9IUuvCV+MgZFKp6u6Ns7wGAzAPZIU7hBEgxGB+zxvrsUJBGIrG/QKB4Bp4G
         mH7sO0NKXTNBfbOu5STibcqYB902AeDaWdFiPHZzHfDOiC1i+QW3K2pbPgIk3ksK9OHE
         QfNaZEG7DoSrw9odsiKemqAflrOOvbb641uhUateZxwdFyE8RAjyay2k+WDBNquzMPyc
         SYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776278812; x=1776883612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BphYppqYDh7wB5j90/jJR2V0IBmnVZp6cAEOzQX6UH8=;
        b=RIh2GZMQ/Uy8K6wJzSLVdg3DaMw84O0wEDNUZzqpUnY0s7WO5Hi7l69hWZDEwta1qk
         +pxNMQWvDO2ERNoZuQ+fQuo5LeI+YC/sdKNNM4z38sqWWh2xcRX22cpexKkcSSn3AcEo
         mItsRtEuqtMOjy2SRf6PnYDM4sJRDnPfJWKlKXG6IbrM+ldMsMOXcU93dacByjetudig
         infqtg8gyUst6/qU0BtDRkl3ciO+7r+9MzYr6Y22Q7YBIIIkqL/m/S1VW8erxRI4oNud
         47na1oWelnXHIGFKKohkLRt1BxpF01QuiJgJ6uAQx9ldXLBXzF6lUXhpq2g3qW2YhQVw
         4Tvg==
X-Gm-Message-State: AOJu0YztzFGygfRG2zMhiOgB2xvWZOTciX8puLjhHsXfBjj3pPO2Btf3
	mQGpO0flcF/Q6i9KaeWin4VUaS05gCGcpHhgAHrFWWdtePgnG9f+wN8kiblvPs8j
X-Gm-Gg: AeBDiet0mWVNSzVZdZjRAtOf8RD8EWrNyruZ7YupMqmRpEuUz3qScTK4RmFjpktmUvK
	DhVQtisKwm7+e776mbao/GUxneR1QCHekAFRf462UF79GIBEXGd0ZjMXUmVGniAoVlXqF7e52H6
	ABZPR8j31Ay2g6h7TX0RUnGAxOWUlowb19471Ne2wzeB2QvEJDK0MatbkYxmJchkJoiOdeGLUPS
	0XO/NWSRSpdEZNc6QoQ/kDrvuWvTEPwSmGKR7nQOSEK4HKTrmsAgIBi7vjwGOFXggaVHnkQ2Tfo
	0ByowUw6IL0r5mBC+P3GIzVvjFyMjt9ebvYGb4q7MVTALx4L+BoUqglFyI9v6hyCIEtX5+L8Lz0
	Fsfi+EXqY0HD2nrcBvSyKNgaVHTwbz0DiXJtlTx3PQVUFYEIAURXugi2MbyUbtnpnE5Qn3rgqJg
	/+Bje3SuDwatzZl3lkJUigxB46TtU3
X-Received: by 2002:a05:6000:1a8b:b0:43d:7e6f:37fa with SMTP id ffacd0b85a97d-43d7e6f38cemr14920036f8f.19.1776278811888;
        Wed, 15 Apr 2026 11:46:51 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:1648:8c4d:e867:9ebb])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43ead356616sm7204165f8f.13.2026.04.15.11.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 11:46:51 -0700 (PDT)
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
Date: Wed, 15 Apr 2026 19:46:14 +0100
Message-ID: <20260415184644.1155360-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260415_114654_315539_9E0633CC 
X-CRM114-Status: GOOD (  19.95  )
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
v2: adjusted the commit message a bit and rebased on liveupdate/next

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


