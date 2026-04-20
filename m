Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D253F588DC
	for <kexec@archiver.kernel.org>; Mon, 20 Apr 2026 14:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vfZFpqwj1elMjnLHCUJlwJVYjCsTNOTD+bgkX23g2Wg=; b=Q6/vtm8/gf4iny4JLC2+3PFWDH
	N5YOC9QqDHDhEG2vkxMFbxU3C7JSORfUPH53mnAimPcZE6+0hHJ/DQG4aZVwBEBRA7CN4p32cx+75
	vs+d5wFQpuFKFIyWuJuMPnG14UantbrEAyhQpMFfm10bEQyxKrvkmrPzAPYayEeMjvL7WFymTQmsb
	uCjiNsXI66+VD1cE7BRlq5OO+ugy9aJCkm/f5t25W8yi+n/3MqL685AJslqRfm/ddIxwUVy5B44JP
	eUrsKyysy6QsqYbNJns8okBhwjxMn/u0iqtEbAL3ud9d7cuAWWnT8wLtIjqCKGtsI8TnZK5aAY1Ds
	ZPj7QUGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEpRw-00000007A2b-2oMY;
	Mon, 20 Apr 2026 14:18:08 +0000
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEpRs-000000079zc-3iEx
	for kexec@lists.infradead.org;
	Mon, 20 Apr 2026 14:18:07 +0000
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so41390785e9.2
        for <kexec@lists.infradead.org>; Mon, 20 Apr 2026 07:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776694683; x=1777299483; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfZFpqwj1elMjnLHCUJlwJVYjCsTNOTD+bgkX23g2Wg=;
        b=RfFBHBQ06zR0o/x+A0gFcIeVG4HjuVtL65eVOhuLDna9KGLQLLNbKe/qzEfiNBb89L
         2OKaPulFpa0t+0xV7VDq0ie1GaFMOyLaRC5nvrsJO+VVkz120C2FtgN8l1IdgyuR4y4P
         8k2L7r+CbkWBJML049xTxtGzk94WytS7qU6AubhwnFL1cGBVfHezU0gzCfEOgfTBgNiW
         MOGING5vsJP7zYrSjzdeckmzeyjyFcosgIltBdHXK6TnWqwpWwjQ1UTZqOt3klOUIt6i
         ximOLhFVOTJlZbxCuS7Kz289s5e0h/Tpe1jEQVyMGTpUTmPlx9xdfrrNv+kaeceZx7KO
         zo0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776694683; x=1777299483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vfZFpqwj1elMjnLHCUJlwJVYjCsTNOTD+bgkX23g2Wg=;
        b=cao1Frb8H17IdJqJHUWbOiw89ulgbmbUidBLvcpIwMrKVqwjKSpR6mB4SeR+f0wz9M
         8uV3PdwJzH5lOO64iEdssV5RWhGHHHJx/8DXImKU5jl1i5axzSzlUUzBVcMHs84oCnK4
         nFvT06peNKS1v+nA3lGSUlBEmN+YnF/2v0zXWXx66WGPJJE1uEMcgJuVTHD7giP2Q/X3
         yXJd6CgdPUTewZ0UsYqDXO2ofgeGFLkJeqWGplD0rWaKBL7dKojWzyapaVtgJmqenFy+
         9jTpRNUWaS+ssTlC0Es5Y3zI4686o9EP/qXufJPw25SI11vT20OFAW+e7QD29oPN1zFg
         ehdA==
X-Gm-Message-State: AOJu0YwV+OQCGwldvAD/dtxsFwaQ8zQYbznn1gAi0du2msMKK3McNray
	13PFO7bUt8fMrE2udPiy7RegqAArTC+0Rg/o9DK8Qzc5+3POzs7PLvV3JhVNWQ==
X-Gm-Gg: AeBDievYxxVybNrl87WqSu1SeKj2QKl6zba13GbMUsyqrUhhpoe/o2INSspV1P5FUFi
	mQp+TCKFS/BD/xp8J+V0EaCeCh+bafJGquNXized0iGcljxJqmcrNcHyY5a9IOhCvKQxyM12Pso
	h2yMCnD/pTW8iQwrLzdRcropLrwAbQboM7n9inG8AYM+HCNWmminN4RNumk9sC9urYjo/Fc1N14
	KPUS8W1xqFu3DvoqOzrMM6/e68sE2GiBSusHXW3raDjc+It2HCBurDL+HXbUwAL4Tl2ENEiSOWm
	8stJBWY+tlwLEzCQePFEas5+HIcirKVU3Wz1X70k6yqtPZf2uS2vJvjFjeOX9O18VqdBRLETxXU
	NbmOn/gtzURSQDlmwWkbXo61uRcsOwchowY7jwb6Fk4zYceZA+HOw7aIxrqhr6B/qlU///mD/td
	UltAyuJMi1HJhU00YbBKuqT4GRW93iSIb0vXTlC9ArqVOlp4YaVQ==
X-Received: by 2002:a05:600c:3553:b0:48a:52f2:a0f1 with SMTP id 5b1f17b1804b1-48a52f2a5f0mr17660055e9.18.1776694682523;
        Mon, 20 Apr 2026 07:18:02 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:355d:3be4:308b:c943])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-488fc0f82bbsm474198035e9.3.2026.04.20.07.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 07:18:01 -0700 (PDT)
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
Subject: [PATCH v9 6/6] selftests/liveupdate: add test cases for LIVEUPDATE_SESSION_GET_NAME
Date: Mon, 20 Apr 2026 15:15:14 +0100
Message-ID: <20260420141741.2688371-7-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260420141741.2688371-1-luca.boccassi@gmail.com>
References: <20260420141741.2688371-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260420_071804_958483_EAB387D7 
X-CRM114-Status: GOOD (  12.40  )
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
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 .../testing/selftests/liveupdate/liveupdate.c | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
index 5e99af0cc6e9..c21354dc9b93 100644
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
@@ -427,4 +443,59 @@ TEST_F(liveupdate_device, session_fstat)
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
 TEST_HARNESS_MAIN
-- 
2.47.3


