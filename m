Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E3FF99C82
	for <kexec@archiver.kernel.org>; Sat, 18 Apr 2026 14:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F0uV/ApidjU/+Ww0veY0spsvhyr4hvLh1zUt4FfzGYE=; b=N8LSNy4es4VyxLKQcRT7HNL0pe
	7ojsiFEM9KhmpMQH+F9oZqwWaedqHFteoU8ztYjNucbp3lS3NyYekDLwVd4AEHjxHTnfi0kFtMoNm
	plQD8c6WYEAgNAf9mSIjhBdBM1y7hu3a6NvpMFLNigh+EUNLVn6NwtfuefcpAUuCok9oU4D0wBR+u
	NSxMpR6HC94NFcyCt/5JOdKh6wKx3uzYuMlvkGRcIGvDbU5YtIdMcwxhvfg8UOPf1GnnQ8olM3w3s
	JIXbR1kJb7SsVBXpmsDQ7cFQzv5dZ81o5I8aIjhU6jfpW+ceUcWnuQojDwxtPWtfhl89f7dCEm4/D
	wK9Ktq/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE6OV-0000000518s-11DO;
	Sat, 18 Apr 2026 14:11:35 +0000
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE6OS-00000005172-0CDi
	for kexec@lists.infradead.org;
	Sat, 18 Apr 2026 14:11:33 +0000
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso14853935e9.3
        for <kexec@lists.infradead.org>; Sat, 18 Apr 2026 07:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776521490; x=1777126290; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0uV/ApidjU/+Ww0veY0spsvhyr4hvLh1zUt4FfzGYE=;
        b=apsr9C67Zpl+LwiU5kzO+ZudBLAZjT00uzp9MDY9eJciFj/+gUKhQeBzHMuUckPjwq
         n1UMPQybY0/R6PlVjGWYnQsPDcLoXznImsYkUP0hYEHzJADAacWMMsXtf1VXV9MBOB5H
         i3sJi8AVXFb8PX0cW4YYqg7MM3hDOSzfnBLBtCf6uaRTmMP+NoFwPkcx2uKK/HIIXPUE
         +hZYt6wdrwpoBhccjY8IgaJlkkWYs5ILOqKSdXmPv8B4rJ3/C5VLzp5jw1IPEP6xVhd3
         lKDQj+UMxSB6vWgbt4gGpOvkAp91FbZEFjheLDs+pYgMIpoZ0QtOe2ItJR7QtkmOtBd5
         qpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776521490; x=1777126290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F0uV/ApidjU/+Ww0veY0spsvhyr4hvLh1zUt4FfzGYE=;
        b=jfS5f3EwN06HIFi5plTDm9DDoDThGltXDtRZxw1BgQvcwdAKzdahxNw2MXOR1ppdCH
         gWUOlEmzh213pQFHij0E/exmVSlsc/qGB1kED5Iclibyr9XS+ILmh1TMKZPvzHld3241
         SAkyxIHGd3hMx0ZMF6H852iL/q3o/oTdxSc9SnhoBbc6SDBGdJ7B3MRwRl5QroE3dwlr
         vxfKN+Y6nfQTqV81EhKNJfGXpvLPyEg6HpZbyxhZXXoLYZFMQ7nRrdV9KoL3K8nRfqFJ
         yFxenhD2LhW4W8pULsxPO11wobQVeOHARzFo2nIjMC86WV17wDTzx0/YT4CdWJcTX3LQ
         8BEQ==
X-Gm-Message-State: AOJu0Yy/j5UYgpViIWKl76qUEHlCF/jelg90RU3N69mU2WVUNgkzAC3L
	crhm82GLn9HTNGlqYyBj09j9ewt2czpjHk8NRHJjkuiqzb2fumKkfmnsbUL8LA==
X-Gm-Gg: AeBDietKZdidVHmvd9GFVCIwtSn3wMcAw/xR4mrrH7AlbJXQgyFsmtMWy0STnNmr6Ur
	IF95WP8XJp2TedoF74yvSQJTb6FDklVrUllu8vQyHcsI2C0POlQ43E1J/05aC0C1KxwPvB56uWd
	eHhD/s2qELW0she1kph5xuku4V1NQfSKPbS4aPBSUgtpsjy2f+gqYRsM4FJ4a81F3wtqvXpdBZ/
	5grgaERK7slx5GVl5Kndg9mY2OEBHVXJ5/Hh5kkJfBx0tlwizapsSEOfUn2hpnhpEeEks07SagU
	rVJgAxSjX0qa/EBO9xaP94ppx214HWP2SluDXbh6U/a/OamEksxABRd6i2acTPaBimmsuzx+8Iq
	r08Ak7f8KJqi41sGwiKVDi97u6PelUE9J03xIe74twxRbNjQOKGU6RVQ0YRld8MgEAaeuGmlaQR
	B4if4C20hiGbD6hd8M+r34WYmnHn+QtS/wAKOWNIc=
X-Received: by 2002:a05:600c:1385:b0:485:4eaf:eb54 with SMTP id 5b1f17b1804b1-488fb78260bmr95376265e9.20.1776521490069;
        Sat, 18 Apr 2026 07:11:30 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:4429:3762:47dc:91a3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-488fb7a0c13sm43557365e9.21.2026.04.18.07.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 07:11:29 -0700 (PDT)
From: luca.boccassi@gmail.com
To: kexec@lists.infradead.org
Cc: linux-mm@kvack.org,
	graf@amazon.com,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	brauner@kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Boccassi <luca.boccassi@gmail.com>
Subject: [PATCH v7 4/4] selftests/liveupdate: add test cases for LIVEUPDATE_SESSION_GET_NAME
Date: Sat, 18 Apr 2026 15:09:40 +0100
Message-ID: <20260418141123.2193917-4-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260418141123.2193917-1-luca.boccassi@gmail.com>
References: <20260418141123.2193917-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260418_071132_108307_357D1D87 
X-CRM114-Status: GOOD (  13.88  )
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

Verify that the new LIVEUPDATE_SESSION_GET_NAME ioctl works
as expected via new test cases in the existing liveupdate selftest.

Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
---
v5: merge with LUO_SESSION_MAGIC series as they both change the same
    unit test file, to avoid merge conflicts
    split into separate patch
v6: add more test cases as suggested
    more verbose commit message

 .../testing/selftests/liveupdate/liveupdate.c | 138 ++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
index d132b4685f76..ffbcbd465c9b 100644
--- a/tools/testing/selftests/liveupdate/liveupdate.c
+++ b/tools/testing/selftests/liveupdate/liveupdate.c
@@ -105,6 +105,22 @@ static int create_session(int lu_fd, const char *name)
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
@@ -385,4 +401,126 @@ TEST_F(liveupdate_device, session_fstat)
 	ASSERT_EQ(close(session_fd2), 0);
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
+/*
+ * Test Case: Create Session with No Null Termination
+ *
+ * Verifies that filling the entire 64-byte name field with non-null characters
+ * (no '\0' terminator) is handled safely by the kernel. The kernel's strscpy
+ * truncates to 63 characters, which we verify via get_session_name.
+ */
+TEST_F(liveupdate_device, create_session_no_null_termination)
+{
+	struct liveupdate_ioctl_create_session args = {};
+	char expected_name[LIVEUPDATE_SESSION_NAME_LENGTH];
+	char name_buf[LIVEUPDATE_SESSION_NAME_LENGTH] = {};
+	int session_fd;
+
+	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
+	if (self->fd1 < 0 && errno == ENOENT)
+		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
+	ASSERT_GE(self->fd1, 0);
+
+	/* Fill entire name field with 'X', no null terminator */
+	args.size = sizeof(args);
+	memset(args.name, 'X', sizeof(args.name));
+
+	ASSERT_EQ(ioctl(self->fd1, LIVEUPDATE_IOCTL_CREATE_SESSION, &args), 0);
+	session_fd = args.fd;
+	ASSERT_GE(session_fd, 0);
+
+	/* Kernel should have truncated to 63 chars + '\0' */
+	memset(expected_name, 'X', sizeof(expected_name) - 1);
+	expected_name[sizeof(expected_name) - 1] = '\0';
+
+	ASSERT_EQ(get_session_name(session_fd, name_buf, sizeof(name_buf)), 0);
+	ASSERT_STREQ(name_buf, expected_name);
+
+	ASSERT_EQ(close(session_fd), 0);
+}
+
+/*
+ * Test Case: Create Session with Empty Name
+ *
+ * Verifies that creating a session with an empty string name succeeds,
+ * and that creating a second session with the same empty name fails
+ * with EEXIST.
+ */
+TEST_F(liveupdate_device, create_session_empty_name)
+{
+	char name_buf[LIVEUPDATE_SESSION_NAME_LENGTH] = {};
+	int session_fd1, session_fd2;
+
+	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
+	if (self->fd1 < 0 && errno == ENOENT)
+		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
+	ASSERT_GE(self->fd1, 0);
+
+	session_fd1 = create_session(self->fd1, "");
+	ASSERT_GE(session_fd1, 0);
+
+	ASSERT_EQ(get_session_name(session_fd1, name_buf, sizeof(name_buf)), 0);
+	ASSERT_STREQ(name_buf, "");
+
+	/* A second empty-name session must fail as duplicate */
+	session_fd2 = create_session(self->fd1, "");
+	EXPECT_EQ(session_fd2, -EEXIST);
+
+	ASSERT_EQ(close(session_fd1), 0);
+}
+
 TEST_HARNESS_MAIN
-- 
2.47.3


