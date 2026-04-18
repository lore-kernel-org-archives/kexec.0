Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33749F99C8D
	for <kexec@archiver.kernel.org>; Sat, 18 Apr 2026 16:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zt+aOMHTeqB+B7ZTmsYzA3/qbdPzt+krJWN0gXu7/9s=; b=1X9bWwyHF+sG9hGRXvNdIxdkKF
	ILvujzb1wtZQc7aQJJA1xXh5S4FbYxhjMZrA6ATJK9sO2j7htgsTS+0Z8J40ShbK7gNvhymvM1m7T
	48JnCmNes65/q+a4d1TayGbxyiNyuSiIW+s6aJ5fmH8tTOPZYSkYdqKttD4sx/M6GtMiWEWFJAYS8
	WdoTmx+EVJiWN96kMxMdiWxgWKuXdqA9bfz90VXr4nH7phBIcMZHBYA0TfesEaEMIo5GTnozdOaDg
	jBxRcIPWZbd/Dxf2ly5D7EoBjtYH9iPq7o7y822hcM0/Mj4TLkboADYOZ8ctq+F8vgfw9uiOY7Kg8
	jONAkLCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE8cd-000000055kD-0mLY;
	Sat, 18 Apr 2026 16:34:19 +0000
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE8cW-000000055iB-33q9
	for kexec@lists.infradead.org;
	Sat, 18 Apr 2026 16:34:16 +0000
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-43cff5dafc3so1258408f8f.1
        for <kexec@lists.infradead.org>; Sat, 18 Apr 2026 09:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776530050; x=1777134850; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zt+aOMHTeqB+B7ZTmsYzA3/qbdPzt+krJWN0gXu7/9s=;
        b=ewySyqwRpfaxo98UxREyWbVbFIvQ51F+4hpJrkEvEQapsp9D37knTWH798dsv/R2sI
         LsuPj910q6UWTWucjs6ZLgMVTAJYuZa0kPZXaTB8SZ7VD3eNKTTLWpc0/anlzd6Gkv8+
         uiF5QNLWTk9wb5vmU2q9pvwxtGUCdF/0AV9W9q/nb65mMJsKFn9AKHmXfWRXhlYFHCHN
         73KyxXJrQPW3/QhZkZlYSYrPvd+DeH+fzgY0smI2hpLctC8L9kFmEpKJ5RF7SKSf011e
         7iJQf3TAzog/czPe1cLAavfDvxn9sliI+If7q2fWeey3RkubrGzl03q4UhLTEH7Srpsh
         1etg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776530050; x=1777134850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zt+aOMHTeqB+B7ZTmsYzA3/qbdPzt+krJWN0gXu7/9s=;
        b=N61i5SVjdLZ1IDX3GgDsTowtv1iZBOv/W7Zr7lCjLzuiUkcGTkIUdjNTYg/Fzl23DA
         C7Th9BQ1OeWfAVT2/yIFLrGoTe+q2veLdz/CgFDYNNwjaeewBTSOoov9uGVN5ho8A7qK
         /W/dzCSaD8A91FqOJiw2nSNUcJJvgpGyG4ck6xXBgBUP8jDUDVceNjb9i+eNSGMFrBdS
         FJ2QydPdkVI3pXy2CRdRnrp6HR9p7PUDUqztYRAbIFYVtVOh2cPUbpkfjFfJzvxcW8Li
         /kxm139MVkl9xuCZCrNmX4JRwUdg6+8Vi/G7+KkBeXjbvEAcapsbef0DMcM08opGYtNd
         EhGQ==
X-Gm-Message-State: AOJu0YwdqqaF3LPmK6/FQ+GtVSLqZMzGiIT9Dj+KmqUGWRBYg6GToDpV
	KuuM0NLp378Rms3PgBJh7qpMCb1/59dR4sIo60zLNQqwM2x47U1WSFK2JZ4hHw==
X-Gm-Gg: AeBDiesHzMNSdZr7tOzEaQYFtxyh+xnQsxNs6zfsphMz7LWMm0+OY/8Ev8gWQi/hVtd
	PzOuNhZXiku9Ar1OduYNx68N8PpH08X6KjX/KunfEQJTMy5BLLBx/00eyhjoRMUkU9zOdxCPSTi
	G1KgikRBUpclPl5i/ajZwm5B66o6toWvnu/CwwLH2oiWjusjHNhH014Gg5fxzpJ/TR5iXAEPzEr
	YqPC0fYgs2oO2v5os6QNjQ9ZG0tWUFpD7hmYa7h9K5XCuc+Uuo44S+SNaKHx3vvvGTivcSLuKHn
	W/6MO+Dl0lG2G8rd73beaUqJgqOYrZ+CKBuy7rmmF4LRnRnqi7/D4f2kHo0t0vUawn2PTX75qWD
	fHnS1//ADAfvRE+Fm9BR6eFtp4KXNYRoJ2wCyYp0z6ekuC4N6wk10s/RwnKJuXIIGjP2qIkmh5i
	9AUxyj3Un0gdfERUoqyUDG09N796DeYJSIFu2LDwA=
X-Received: by 2002:a05:6000:2089:b0:439:ccd7:cdb6 with SMTP id ffacd0b85a97d-43fe3dd4f9emr11664614f8f.14.1776530050384;
        Sat, 18 Apr 2026 09:34:10 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:e054:93f2:97bf:84c6])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43fe4cc0d51sm13903755f8f.10.2026.04.18.09.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 09:34:09 -0700 (PDT)
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
Subject: [PATCH v8 2/6] selftests/liveupdate: add test cases for LIVEUPDATE_IOCTL_CREATE_SESSION calls with invalid length
Date: Sat, 18 Apr 2026 17:28:19 +0100
Message-ID: <20260418163358.2304490-3-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260418163358.2304490-1-luca.boccassi@gmail.com>
References: <20260418163358.2304490-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260418_093412_814056_58009D27 
X-CRM114-Status: UNSURE (   9.34  )
X-CRM114-Notice: Please train this message.
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

Verify that LIVEUPDATE_IOCTL_CREATE_SESSION ioctl which provide a name
that is an empty string or too long are not allowed.

Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
---
 .../testing/selftests/liveupdate/liveupdate.c | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
index c2878e3d5ef9..f0a8e600c154 100644
--- a/tools/testing/selftests/liveupdate/liveupdate.c
+++ b/tools/testing/selftests/liveupdate/liveupdate.c
@@ -345,4 +345,46 @@ TEST_F(liveupdate_device, preserve_unsupported_fd)
 	ASSERT_EQ(close(session_fd), 0);
 }
 
+/*
+ * Test Case: Create Session with No Null Termination
+ *
+ * Verifies that filling the entire 64-byte name field with non-null characters
+ * (no '\0' terminator) is rejected by the kernel with EINVAL.
+ */
+TEST_F(liveupdate_device, create_session_no_null_termination)
+{
+	struct liveupdate_ioctl_create_session args = {};
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
+	EXPECT_LT(ioctl(self->fd1, LIVEUPDATE_IOCTL_CREATE_SESSION, &args), 0);
+	EXPECT_EQ(errno, EINVAL);
+}
+
+/*
+ * Test Case: Create Session with Empty Name
+ *
+ * Verifies that creating a session with an empty string name fails
+ * with EINVAL.
+ */
+TEST_F(liveupdate_device, create_session_empty_name)
+{
+	int session_fd;
+
+	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
+	if (self->fd1 < 0 && errno == ENOENT)
+		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
+	ASSERT_GE(self->fd1, 0);
+
+	session_fd = create_session(self->fd1, "");
+	EXPECT_EQ(session_fd, -EINVAL);
+}
+
 TEST_HARNESS_MAIN
-- 
2.47.3


