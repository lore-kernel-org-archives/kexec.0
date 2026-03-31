Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E321F10F92E6
	for <kexec@archiver.kernel.org>; Tue, 31 Mar 2026 17:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7XDnsAD1qoPLE/KiYEdvSZ5yyugeEQjf5/y2C5hQru0=; b=c439cpOCciT3vgtFE5QXvGUCS5
	BUov2dH7TMOOf3QV6CVhnvBnPL4Jh+NkChz28VJE6nnFoft8NxkdXSwo5wsoGZVL7YsslJZaTkbf/
	z+ogPhp7DZTSKzR+lu47S6RcvzdhMJ4ypnjOsiz7KvZaNqxtgKfvWTRMashYsaqdFTIwQUhr0idcV
	4HeivRI06qwddw4IvXA/dB2/QDQ5cVafbwr72T+PaFp8nVbt9OgTYsAQxUfhl711j/+NHSpBWL3fY
	ej3PGwD3EOGPojCQKaEziJheyGQMt2Tn7S4OpW+h8QoC06X/CFOT28zT5xYweRwXbC7acJEOilyMv
	+oGxNPsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7dKd-0000000DNKb-0PKp;
	Tue, 31 Mar 2026 17:56:52 +0000
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7dKa-0000000DNJp-2wR9
	for kexec@lists.infradead.org;
	Tue, 31 Mar 2026 17:56:49 +0000
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso50163615e9.3
        for <kexec@lists.infradead.org>; Tue, 31 Mar 2026 10:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774979806; x=1775584606; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7XDnsAD1qoPLE/KiYEdvSZ5yyugeEQjf5/y2C5hQru0=;
        b=C3y3GwqczFSYp6kzScyyzQDFA90M1IdpsBfrD2aCw5tS8cxzpvNcHiaexLgpt0XdTC
         7iLvpmKXphV9477T219xzVOPeCvoata+gUMQFBhoWvumIB7JbBYDLNjBLZf0RZWnyVPQ
         q3hH9/dhlTJKyhFZgNYhZWb8lB474/ZCV742yK1haQnuTxFF4EiVjtg/igTVKs3iJqa4
         +1voV71YFqL00XmenU5IcvDeFho9YrR8wxxiwOrWlW30Lap+aJEknKwHEpLlmmA75GdR
         AE/NNWi8aCu0g8X7yghth2Bg6ayQiT9yKLQ/3fjFRSiZ7v9e4rNKhLb1dm6TgZn2CVVX
         BnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774979806; x=1775584606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XDnsAD1qoPLE/KiYEdvSZ5yyugeEQjf5/y2C5hQru0=;
        b=tRdt57m//KGm6tgV1IarcJktBEOLsgf9PIwblHxHfNXqCUxxKrh4AczCKo8lwD0GFY
         hfm3u3eT9Oahn2dhZY2c58l+vmmJHOhulpaPQ1NHFv7ljRT3woTI+nwk+imaoN2xmm+f
         /xAMqQYYX2u4FBWVY2cmeGHuxva7timC3m084WqQ22ujWgvb1Y9qK9XtKhHM//F0YvIe
         IICXKGu7N1VtlrYJTelS/uEZVAdmLK+JVnBQ5Ft11tVAvnaDCQmkoLJoKGoKJUhyPAMm
         hpoolRsrD7sdYEMjfnF9cvIYLfLMW9t8x8MNDIsAyI3Hajl85N5ynGsujllhtVu2qegm
         M7Tw==
X-Gm-Message-State: AOJu0Yxksx0jFK86Y7hnkqi32nJsdpkt7AaKsYbjwAtr09mN8/Az/znW
	CT+O6nIkLDQ66U0r0Q409rBBiOqHphA6rzvLXeXDua7agBx/NXSaZ89YIXAFkA==
X-Gm-Gg: ATEYQzy7g9RYEJpiexijPrqdpvVOz8qQ0kaB25IuU4vMxWTWYLUNS/VPNNaf/wTZkNU
	SUlQzLFTni5O3jlwpgLVelhb2Hwnfj0XH85jDpeJuthRXy6v04QhD56IQY/JKpYfXc8fahPFGnT
	Wf89j4Rft/fDKOCWX5BUcq/akcIkGYpxIp0ULBW85kycsL8cijNplmVsBIpvKxz/wvp2eNN5qsy
	julpkY2Ww3pLBgghDjsdQWwSHhwDtbv8+rkzuhoTJo0QF2txcvOi4a1ck9Xc8FhsIJQRnCBslhQ
	WNEklypaE21GWhIfLcwO/9jFZlcdqXmn0PCUTwUdH1omhS0Xj4BiFSJuTVc+YkG+vi88VI1RJph
	jvA5bgAJAuBf9CByTD9Ve9gWQRpV190OI+n3ug77Jf6NJ6kJjVoIVhxD4z7clk3yrWg8hyS3B/8
	xegVvjWgKIQrdVxaQwacoo/ntEXet1
X-Received: by 2002:a05:600c:8b85:b0:485:419c:4eba with SMTP id 5b1f17b1804b1-4888355e6bdmr5982895e9.1.1774979806225;
        Tue, 31 Mar 2026 10:56:46 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:5ed5:ec79:be2b:6da8])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4887e952b0bsm46752035e9.12.2026.03.31.10.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 10:56:45 -0700 (PDT)
From: luca.boccassi@gmail.com
To: kexec@lists.infradead.org
Cc: linux-mm@kvack.org,
	graf@amazon.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	Luca Boccassi <luca.boccassi@gmail.com>
Subject: [PATCH] liveupdate: add LIVEUPDATE_SESSION_GET_NAME ioctl
Date: Tue, 31 Mar 2026 18:55:32 +0100
Message-ID: <20260331175639.4066033-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260331_105648_771644_2877F64C 
X-CRM114-Status: GOOD (  21.58  )
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

Userspace when requesting a session specifies a name and gets a FD,
but then there is no way to go back the other way and get the name
given a LUO session FD. This is problematic especially when there
is a userspace orchestrator that wants to check what FDs it is
handling for clients.

Resolving the /proc/self/fd/X is lossy as that has a hard limit
of characters, so names might be truncated. Also requiring going
through procfs and doing manual string mangling is not a nice
pattern.

Add a ioctl to simply get the name from an FD.

Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
---
Need this for integration in systemd, so that I can check what
FDs I get from clients and what they are, and so that I can know
where to hand it back to

 include/uapi/linux/liveupdate.h               | 19 +++++
 kernel/liveupdate/luo_session.c               | 13 ++++
 .../testing/selftests/liveupdate/liveupdate.c | 72 +++++++++++++++++++
 3 files changed, 104 insertions(+)

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
index 4a40c7fdfb44f..819e8864869fd 100644
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
index c2878e3d5ef90..510a583371fac 100644
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
@@ -345,4 +361,60 @@ TEST_F(liveupdate_device, preserve_unsupported_fd)
 	ASSERT_EQ(close(session_fd), 0);
 }
 
+/*
+ * Test Case: Get Session Name
+ *
+ * Verifies that the full session name can be retrieved from a session file
+ * descriptor via ioctl. This is important because /proc may truncate the
+ * anon_inode name.
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


