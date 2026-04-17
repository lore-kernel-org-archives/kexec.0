Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3775BF99C69
	for <kexec@archiver.kernel.org>; Fri, 17 Apr 2026 22:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rthk+NSBRFXE+6mJljKG6U0ydJhpN840inxjjbjxMqs=; b=WZAjUn6rP3VCHW5y6UyyOYulp1
	VzWu3MF7w0teAXkSzQGRdMwWjawHroFw3MlN+vGF6Rtv8Xr/EswigpykYOJkXqKhkHxStl8+FNUAQ
	lNHXr9gtPwu/4/dOh0D0OQwK/lb0kN6q4fbOBT+stMc3QH88C78avSB5EYYK7vZH5NrRt5XxmF9iL
	Fl4CO000mXPaZV133C4V39M5Y8OZufLHW5u7tkPEoymVsQSSBqmdb7m1G6joT7s/8+Xq79ruvUwgy
	NlqiJW44qdU3d0tNG47zm0JxO3CUJZVtr5NHMtzrwnxr+1nG/h8YzFGdUW9/WVI669zEu7EbkugVo
	O9VnVkbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDrMk-00000004Vnb-0rbu;
	Fri, 17 Apr 2026 22:08:46 +0000
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDrMh-00000004VlP-2AYV
	for kexec@lists.infradead.org;
	Fri, 17 Apr 2026 22:08:44 +0000
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-43cfd1f9fd1so708976f8f.3
        for <kexec@lists.infradead.org>; Fri, 17 Apr 2026 15:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776463721; x=1777068521; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rthk+NSBRFXE+6mJljKG6U0ydJhpN840inxjjbjxMqs=;
        b=KrTUJHTBIHUhZhw3lVzmyn2A7vLYH90YvhrAqYynxIzRQDXLWo0ozZ75LJDShJnbmF
         KA4nrnaCAMENDg6CY6FNqfxroyOd91sjCYuD5CvDEEbb1P+efTR8vlWkTGaX5AmfxMkD
         iKqH/zh6BP7/StOlZS9QQq+ml6Xzj3r7KGX23FYbVsNdcn2J+Qh/TiR8gQPMjuhzVRGX
         onsgAKtCwQSnyeDJXXkBk38+qHD/k/AgMetdA66NCSRrKzhGUEYHCX5JdQ0Si4uZJ2DK
         DlOeEUUoK49a2sCewYl5cL08Y5F5FAz1gzkXuwiUyizMq3lGxcJ6dLWFIK4xUIOYRKai
         CqMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776463721; x=1777068521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rthk+NSBRFXE+6mJljKG6U0ydJhpN840inxjjbjxMqs=;
        b=M7MpIptxGTPiYxjCe3DTqXiyktkMX1aPALg7mbhBTnJFFxTjGUnqQdDMQ2hXwPdkPn
         wWhaZpwEsoIqwU398+mvgVGaYeSXNN4bLl96pXauo346jonvXUEkVOKr6Jy2gKTjGJHW
         gHX+uBmeMfeOYaCQMNF5/oyeWw1zJ6FqVren3v0x4TVNTwZIE2SyDFhOcckmb2+6OxVL
         /pXvBmfgnnNK+IMPPUWU9lAgnaeMJ1J0qWeuGhbsX5tZbWuOUNFkUouLMFNhX9Ge505z
         j++eWMm+vDh4+9osG1y6T0QHLVI0sBUpwAZTusqlXGi7J+kSt5Mqjz+aeNWLh/iHjjGP
         rQ+A==
X-Gm-Message-State: AOJu0YyBcbenMOr1cIAaDWSj0bB8d19da77PQAXhc38w9ojf1MALaETM
	iSZwG1wSfLjo/KSiXObwbZH3YYx6BqyJK+BD5opr0sVw+YeqtcU6Z3yEtu0itg==
X-Gm-Gg: AeBDiesJEhXhMkyi2UQRnxjJgVo5tEz3e4PjB4Y3tX6zCHW75kjKe6OgV3eHK+OGHSY
	BXeuMBwZU2oJPsi9n9zN8JqMA05mVLDhYRXlzNMJAmOklMCri9ykWXqEta+ENeSO+xN3IiSA99J
	Gen8hZRLESfmJefdcsVFarZuj7oqE680xJEv6myLMvQKciUslnRbEpANsGLJTrpDRhqpnAqWNYh
	XnqoAtRYmMIYhqAXIir1zd4efqtJPTfFAOaTpQTWFq6Zz1yrzZ5rFPmEKzDl0N/t3ORGW9MqKLV
	ULbPfRUXqiwt/gsWEmd5VIrx7RJjvRdzCDGpWWefeXabLI1hwOxPwNIJVZeSKFTuAUbm7EMRysD
	VT9D3GcOvd3Hay8xexA2B35iur/a07hTAG7+/hmpz1jkPR76BXtL7i6Ixl8CyvSJ5O/n3oPKZIS
	y2LWxNoEpXHMFT+6zsYNbQfA2CN9aHJT1m1SapFuA=
X-Received: by 2002:a05:6000:2dc6:b0:43f:dc54:9493 with SMTP id ffacd0b85a97d-43fe3ddcc21mr7224667f8f.21.1776463721326;
        Fri, 17 Apr 2026 15:08:41 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:9586:30a1:a0a6:f076])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43fe4dc26a3sm8270944f8f.15.2026.04.17.15.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 15:08:40 -0700 (PDT)
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
Subject: [PATCH v5 4/4] selftests/liveupdate: add test cases for LIVEUPDATE_SESSION_GET_NAME
Date: Fri, 17 Apr 2026 23:05:45 +0100
Message-ID: <20260417220831.1934945-4-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260417220831.1934945-1-luca.boccassi@gmail.com>
References: <20260417220831.1934945-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260417_150843_570492_7B448D46 
X-CRM114-Status: GOOD (  11.60  )
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

Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
---
v5: merge with LUO_SESSION_MAGIC series as they both change the same
    unit test file, to avoid merge conflicts
    split into separate patch

 .../testing/selftests/liveupdate/liveupdate.c | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
index d132b4685f767..f81201b363cc1 100644
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
@@ -385,4 +401,59 @@ TEST_F(liveupdate_device, session_fstat)
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


