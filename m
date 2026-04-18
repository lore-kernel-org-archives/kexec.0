Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE30F99C8C
	for <kexec@archiver.kernel.org>; Sat, 18 Apr 2026 16:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uguiSA9xVG8SCE4+kERAOLrC3CLUPwMeYK7rWWVQ3nI=; b=2C5aYp4qOMugr4uPEzdooYluZl
	aTgroCF/FVKuhZi/7vrJmVz8uiKyx5VlkEQ5r/ic7IuKwDu2AYjr5nP3qOLjD5bdParhSbZwgXY8V
	f6FkkpLLAAustsDMfKLZWohrkCA3yzfDeQkOsNGO37+xaAqMJe7kS854wrX0pW3ehJVZhyCvRn8Nl
	lMQp1uUG6r6bAsLYVX0VHZUwvg+QiMuGtHeyJ0NfgbagHWc5PkftNZsWdSjFvwEbXzymBRaqvYtXe
	T5MHbKI35aohVH3sYbuGn4e7yOk9KkexmBpzqNubBMlFqqBXnuhX2KVLIK02NBcmf0150GymrY8jG
	1BofwXUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE8cs-000000055ro-3LMu;
	Sat, 18 Apr 2026 16:34:34 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE8cl-000000055p7-2VFO
	for kexec@lists.infradead.org;
	Sat, 18 Apr 2026 16:34:28 +0000
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-48909558b3aso3228585e9.0
        for <kexec@lists.infradead.org>; Sat, 18 Apr 2026 09:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776530065; x=1777134865; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uguiSA9xVG8SCE4+kERAOLrC3CLUPwMeYK7rWWVQ3nI=;
        b=bd872F1wOJONmyOS0JvcHPxWjhftXNwgMwWXTzP/NoHlu9MsSA1Gn59gdSUPQ7noRV
         Q4BZEjlGj4kbRgJwLgPz/usNTDpvZJH2HF1C+Tqv5ucyvHkI/09UFHiwZXblo1HUnEEV
         dUgNQL5l3L0atx+1W1dq1UWybMchrK5PuI+zk07ZFJYhlzu0xLMUryl1BQQ67yGXhGk7
         zOxH0gTFK3dkRvlbebjUb8h8RqDi4DI35kiKoi1gf5uMnkx35XFI43fyZQ6mnkTD9Kod
         2Aelx1RB8Jw5YCY6wANoAgjDRMH07dh8N22RK0PgO+J8emF/aLkWArXprCi40hoJNnja
         adZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776530065; x=1777134865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uguiSA9xVG8SCE4+kERAOLrC3CLUPwMeYK7rWWVQ3nI=;
        b=Mi3YZ7gjdTQF+Ad9+eJBn9HZ2k3xVvICU9OsnjLfBRvKcRFRD6gVZSNI7UNHQQPikM
         SpuTE0QRQyUAGOF0DcdRhDRISDnrnc5M6jdiWCLNGzwtOyl+8KHKH19/JMoQMV+QOODf
         cW/SaOgh1Jb5CRWg9rpUAmWLq+mQH1HDDotegumobHr353q8asTQqDPfwZ0t0NfB18Bb
         YdFNc/eErwwwKzUFFk6ARnauqIHRErlRbXsZMentBy47ZDwwk8Y0WySptgdt6fBhGuBT
         430ZtZAgD2HyLtaKTrqXN8AdNFuntPXn43NxDHNfnX1hNzU8zui2qJ1TdWj4j6e9whOp
         vk7A==
X-Gm-Message-State: AOJu0YyoG/BtNfIm7TohGixji+Vsxkj7WQJtWvleNxp/qBcBIMazLWnf
	iw341eLV3fMLno+N9mvPgBGWQwxRvfYnjiz11XA+7DXLw0c+KllOqKYQbg+/4g==
X-Gm-Gg: AeBDieuLDybsS4IduNZeD1Hbs3JCkoRQicbCNLpfoFRElJ5p/6VOLY0Z7wcTs6Yotf/
	FBb9rlWc+EAEeXkL95HcYIKP71JrBrfFy1XBx/AqAWEV5RUUOuNHvXQonuviMs9mClhcMCZERUt
	mX3+srCDx+wnsW2hBFF0LfwcPJrx1fn6k2euNgdJMrVZOioHOF+5xnxSfdYFs1aY3+1Ba1MmSmp
	QsKKo5x+0l9VesW2k09rM1Qw3cdCR1aVIeYvS2Hq2rRNB0pAJp6tvLyEHwr2GX20oOdJUQRGe3Z
	NAvAiWOxGSoYxcQieK0hvkQL+z0+enYMsabC/dcfkoQ1sXhSiZ6QgeeIybTqni+EJrcuwJf1i+Z
	YA6FVCptKCkhzm5AnWW1pGNOOYScbx0SlyKcX4nwf/42594GYnsZ/yXnc4rsB0hmKN/TMFzcUTP
	EA8fcOuDboU9k7EfeGlaEH8+vGkWV1y6kD+3VaMVw=
X-Received: by 2002:a05:600c:31a9:b0:489:95:3dd2 with SMTP id 5b1f17b1804b1-48900953e9bmr30685445e9.8.1776530065164;
        Sat, 18 Apr 2026 09:34:25 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:e054:93f2:97bf:84c6])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43fe4e4d5b1sm15836381f8f.30.2026.04.18.09.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 09:34:24 -0700 (PDT)
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
Subject: [PATCH v8 6/6] selftests/liveupdate: add test cases for LIVEUPDATE_SESSION_GET_NAME
Date: Sat, 18 Apr 2026 17:28:23 +0100
Message-ID: <20260418163358.2304490-7-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260418163358.2304490-1-luca.boccassi@gmail.com>
References: <20260418163358.2304490-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260418_093427_710676_197F1AA8 
X-CRM114-Status: GOOD (  12.03  )
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


