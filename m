Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB9FF99C73
	for <kexec@archiver.kernel.org>; Sat, 18 Apr 2026 11:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F0uV/ApidjU/+Ww0veY0spsvhyr4hvLh1zUt4FfzGYE=; b=OQqCy5LtUzyiWVjFSXMD2SxrWU
	mXRcD3v/33t58ogl5isBPkl+KEqZVhdZv2W/DZNvwQtWaDr7nWFqbEscJ1qhEb3us4aDxKPBO7AYd
	gBIBDNrN2yfsxYmMDb3NKCYYb6lNbs0ovcQKWeWgYfZWjXOHzMu6RVs57nAlbhoHzyZuXLkC3FY3/
	/0jNn8oGpXcKbkcjtj3CI6lLGUjCAt7XPkC1wx4e8GsB+ZUkTCxyvMu63Q5U1SsGq2NfwyHXLShor
	rK6BdiUVo+vE+3jia2NYmAscMa+oJREtTZiu3dAUxmNVtv9KHzgcZ8/uk3eMe2rmE9xNiYtbuq0Jr
	NEMyDMeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE41w-00000004wzj-0AKQ;
	Sat, 18 Apr 2026 11:40:08 +0000
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE41t-00000004wyK-1uY4
	for kexec@lists.infradead.org;
	Sat, 18 Apr 2026 11:40:06 +0000
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-43d7213b6ebso966999f8f.3
        for <kexec@lists.infradead.org>; Sat, 18 Apr 2026 04:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776512403; x=1777117203; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0uV/ApidjU/+Ww0veY0spsvhyr4hvLh1zUt4FfzGYE=;
        b=YSh0SwAIFLSu6qObsb6q4k/MP4AqhNpA2rYkOnbQkWsPrWz0/Kcdg8G4Txi2jpdhdV
         3YbSbYD0HuJNZawdsXa4Cklftse4r/tMVKHuHvMSiDzTyIfWjTOU5lHPmgvCH4+VgE/c
         Tu8j33evKfU8jL3I6jNBug3Hnp8mhAfRwDgCsI3qzjt3tCsZfpzS6DtaYYOv1C2EE/B0
         LTTjPFIo0Z/qzIpNeQvJ4R4lHbkU6ulXViE+zjN7H7vjhb4MDdHzA+9VrQcw1ILVP0yA
         JWBxVYknFmAyVgBhPfGO9l4fqV2hLGtsqlYMOlZLIchxy/JuurCEPDrbJiFCe4F/x5Tr
         5tGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776512403; x=1777117203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F0uV/ApidjU/+Ww0veY0spsvhyr4hvLh1zUt4FfzGYE=;
        b=pFzx5/QYhJwSogeahqOjAmTXdwl28v+mK6NbUZyL7b6/1H18VR42mrrVRlXgEDL83r
         pUTEVuiLNxzk4tOnAywTH+9GuHv2AlwH90IhgpZaeu7a5n0maysoS30VK1k34+oNwUAu
         8xmecrP5IlDQDZjIwdTE0+lLmgbXaxf5KTtfjPjNfOd/k0fNymgC/nzcu+e89cUrRozX
         KyHB63DmhN45Ew63kFm7V3sylIUJlVeHFclUsJetoMDbgpeoAex4xJq30J9dL9Do5FfK
         iE3pOpUAVE0M4a6OUsNTX999J4OOWainsF7RgI1At5GThqFG1/FVI7WxXlfM/k+4N94p
         i4DQ==
X-Gm-Message-State: AOJu0YwYQhVBf0H0olyq9jlYDGh9bYU+u5wpQIknfM8BURHyKpvHxJXu
	V2GpBhmvOC8d2G16UnrVhh9KkWoO1yCuDRR4XPVbUny9wbxU/MvjKetMYC96SA==
X-Gm-Gg: AeBDievD/SwkGA3YlNqwTbp+1XhJxY1s6aJPDHki4y4yL69WgiY2aKx2hWjRLo0OlWx
	vbTHCLQSFRNS7y/FBz5jjxFwP7y3cz3c1cJu3ZF8jwu50bY6F5pKVkEsjQUkPx5m+RBF7VCSCu4
	1/HwdhMKtQ9JSCaJ1SsYJaH6Hcj/NtQwFIKeQS0n3drZa0bzgvrKRpLvdD/QN3EjIcxNjTBdf61
	mLAe6ePptfyg+peq4nRYjz/iY5Vg+MQxvdO0ogu48yToeoWcacdNIm1LTuzqtp636inu4xGp5dm
	uIHhQrXJmi2lh1fJJB29IUPxlPS63/bIv2SQa6L0/5IaUy9nTNzUJ90PHms/EXsXT/coWEfiQnT
	j6B9n4MVe6dGNySkqxRTqHOKoPrxj8Sj9YP3kXSjLw61vNOPzI6X1wbObFwHxVzweaDpljUKbBC
	Oo6A8TvcM+w9SAjI7AFJcKxlHgqGQyzr2lxOFlYLE=
X-Received: by 2002:a05:6000:2013:b0:43d:c95c:4259 with SMTP id ffacd0b85a97d-43fe3e07216mr9801586f8f.30.1776512403027;
        Sat, 18 Apr 2026 04:40:03 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:3ab1:89ce:8d93:ae6c])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43fe4cc0d51sm12284449f8f.10.2026.04.18.04.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 04:40:02 -0700 (PDT)
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
Subject: [PATCH v6 4/4] selftests/liveupdate: add test cases for LIVEUPDATE_SESSION_GET_NAME
Date: Sat, 18 Apr 2026 12:38:41 +0100
Message-ID: <20260418113956.2146648-4-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260418113956.2146648-1-luca.boccassi@gmail.com>
References: <20260418113956.2146648-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260418_044005_524596_3F1CA47D 
X-CRM114-Status: GOOD (  13.98  )
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


