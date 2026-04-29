Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CD3AFF8873
	for <kexec@archiver.kernel.org>; Wed, 29 Apr 2026 21:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ykJFzTkCkC0C2lj+ZZ4uY5vhivTKu7ETItTHYfKS1Gw=; b=1bT1D/poF6PAcp7ha6jem8a4iv
	u/eBBef4dX32ldX+BE9aoOGfvc5qqZvBhGn9AvQl/xxhj/LCzHkNk/HfCCYQFfhR6u1vKJLNhxIne
	KOSLc4mdJyIAOsDzv2XXCRou6MLJvsg4ii2kCnFcTKcJhLNVFYV1FrRSnp8gA7lML2Cp6MgRRIPq9
	4J1OgdeIsbJ6CcYqO1E5IctIZ0KjgBatJfFVq0/m81QnVxYTy2IADooUk25SwhokjJi0K6XWxRwB3
	L6x+q8iz+nvi2Q4hg3+f1nf381s7nghJGmICIXk1DZgjkMocvdYYiiUxNaYI/tHAdA4Lmo1zoE3tn
	8GW6Xt/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wICMc-00000004EO4-0Yph;
	Wed, 29 Apr 2026 21:22:34 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wICMZ-00000004EMQ-2BjU
	for kexec@lists.infradead.org;
	Wed, 29 Apr 2026 21:22:32 +0000
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-488d2079582so2006005e9.2
        for <kexec@lists.infradead.org>; Wed, 29 Apr 2026 14:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777497749; x=1778102549; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ykJFzTkCkC0C2lj+ZZ4uY5vhivTKu7ETItTHYfKS1Gw=;
        b=KZC2iwTf13JN0kQEWO+X9+9PsOhT6uN/5oUQmjziFYmjtwWHMBRa3kXX6bYtNzEuyW
         nCT5Epu6RQH+YI72OdTSeCIAaCt5xdj0ATX+sfSmAOHqqynefilJP4O2LvdBVJ3AacU7
         7bUOPptv3Pavf9gyLNIkiNuxRJq6AwLgtQmCMsi6WJ6MapWF2NMc+F49ti/R+bvbxSvC
         lAsgYcX74G7Ip1k43yiQlKGbwdWwOmJw5FCL0M+RsdPTUu8mCK5Ttk6PmWdXiaRKBpZn
         iqCUOaCaXfKjp0qwSsCBWzhliV0HT474wxobRr8oJMHxuonreMbOTKSxxrSXOI6YUw5U
         L0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777497749; x=1778102549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ykJFzTkCkC0C2lj+ZZ4uY5vhivTKu7ETItTHYfKS1Gw=;
        b=jSUXnA9tDWfHttcZSUU0DDcO26qabTU9u3XxPnHWgYwuF/D4fnyU3yrLAAZ784XoeM
         jGyX4NB9Yr50ZvpZa1Ba8tWagcz3llV8QcdMVjfYV1ao+UBk0l/2rJI1aHOQ+UNqFZ+V
         wjIFyKzKrFaNJCFL0il3d0o9Zvw0B2YkTX36WR+VzPnSHnAjjZ1HZp5mR93gUrXGZmB1
         58sIj4Z9LtjN+wrT4V6pC5vGV8Vy/RV7V+Xc8ngLkwgjZf4aZ34nZBEiHOiU0o9tfRuL
         VZ29BhiPKbUySS2Dv9leAI0XzpZ+LK2s7Th6TKxm3nO/EsqpctKzFCPk2xRUyGLCLatF
         pEdA==
X-Gm-Message-State: AOJu0Yx9KyUTVfrr2xEvNLkMhf23aZ06oEBrhQJgbuCOsEn0FikOCYH9
	kP4vYUw9PWLg6h35bfSI8Vl663UVJWYtyIlZwWs4tcXz7bEgm68Z7XWW6jmOrQ==
X-Gm-Gg: AeBDietX2BaMpqrMqvHUl9YMoOGW7FktWaArB6LKNCgdI1cR0C8mPvxcFsYTLaKa3zL
	PstmORLDB4cO6q0ypfqO2jRO8nEyXUcOO8sLt4BGA5nTtHhIAOEH7fTw65FFuJ3rZ0Gii085erB
	A5WBDm0eCNPAkKGEBBkRrwqYFl8GvcF+jFixgKqztpTPVWY2yZVF9itsMkkhn+06qFQ9NI3YVfL
	pw/hFMXBrkFMt+7fd38cM3dOQr+9wOpfOLfAZCP4dSD/BZ3FyB7vIUCEo0v0QAtHMNS5cPORG0p
	OW+wc4w6VHqbfNbP8ABsnCaFeE/v5ae4FldqgtJ2SzWha8qVecwS5uoxGEGmi+cwlXepiMdcWDg
	XVszzBVDybdj/Qdebu9ueG4HbAwwAkbC/BrWyW1p7btidQEUaiK/lMAVAbpN89kklT+EnGNfkZM
	EjK5Akqx8QXd6mqyMDdDyFJm48Fqb5uiWwHqsbKVw=
X-Received: by 2002:a05:600c:8b22:b0:485:3a03:ceca with SMTP id 5b1f17b1804b1-48a844582c3mr4663845e9.23.1777497749079;
        Wed, 29 Apr 2026 14:22:29 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:8fc7:44bf:8aca:ebae])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48a7c3057f8sm26200425e9.14.2026.04.29.14.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 14:22:27 -0700 (PDT)
From: luca.boccassi@gmail.com
To: kexec@lists.infradead.org
Cc: linux-mm@kvack.org,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Boccassi <luca.boccassi@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v11 2/4] selftests/liveupdate: add test cases for LIVEUPDATE_IOCTL_CREATE_SESSION calls with invalid length
Date: Wed, 29 Apr 2026 22:21:15 +0100
Message-ID: <20260429212221.814107-3-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260429212221.814107-1-luca.boccassi@gmail.com>
References: <20260429212221.814107-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_142231_579641_E1A97E60 
X-CRM114-Status: UNSURE (   9.88  )
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

Cc: stable@vger.kernel.org

Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
---
 .../testing/selftests/liveupdate/liveupdate.c | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
index 37c808fbe1e9..90268d86684f 100644
--- a/tools/testing/selftests/liveupdate/liveupdate.c
+++ b/tools/testing/selftests/liveupdate/liveupdate.c
@@ -386,4 +386,46 @@ TEST_F(liveupdate_device, prevent_double_preservation)
 	ASSERT_EQ(close(session_fd2), 0);
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


