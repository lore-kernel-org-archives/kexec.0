Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A55E8F99C8C
	for <kexec@archiver.kernel.org>; Sat, 18 Apr 2026 16:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vjAX0smE41BTNjnnRZCLx7DL1jbmxY9+auerdTALqsI=; b=w8WC57zj3gx2DoLJS5fK067Lrg
	zJg+S42DQdjX53O5UMQ+40X/JAo7FU3lgShZymZfaUK5zroaEXqLakXZLBJCfnw+A/S5FDoJsT7QT
	U7NkSzS4RKg7IWbeKQ12DvLNv6+GhL7vw0qYbyVX8QZ0uxfuWp0bAHPWQH+9meB+7QaX42XFGcmWS
	O4oKdkVlldVLDpoEmFDn9o6BIdtstW53BH894cqpqZNrD/W+8tMY0joZg5g8WqA+yYbdw6uw5E0IC
	3njiiaS8OG00nQdineVfl1cHYDoerwX9A8ylTREwkTpSDY1+DcR82FE6T/Z7qG3jyKHroLgG3BHvC
	jaN3zicA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE8cd-000000055kj-2M3b;
	Sat, 18 Apr 2026 16:34:19 +0000
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE8cY-000000055im-49Iq
	for kexec@lists.infradead.org;
	Sat, 18 Apr 2026 16:34:17 +0000
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-43d74086e5bso1535925f8f.0
        for <kexec@lists.infradead.org>; Sat, 18 Apr 2026 09:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776530053; x=1777134853; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjAX0smE41BTNjnnRZCLx7DL1jbmxY9+auerdTALqsI=;
        b=i+yhjiKC8DJHs5EcyucwEWImkllBAwha1ndrIFq8PtkvWTuxV0/cfaD+KwmTD/aE7P
         wHOdqPVW8jr6R063xRfvdmmF9JZKPaItTOTYw2SypDnmA/QJPPSfHZ0k8q/VrMUiU8Pq
         GWCQjxhdU/dOMLsYdXxfaFVy3y3nSkYJa7PAHyTpECSowlrRhRwGv/wb32iKdsXIaM5J
         giOCygo0Cn+C9vsp/n2j/w6+pr/oqfUXFiYLNJsEgfdTQn61n3UF7TTtcI+EbdJ6dauu
         kp0Kb0Jqre3UJ6aK6P3cXPj60CTX8NBiEe2gNzL8Z+NiLTZ1gH9wBieZdodXDgPkHQxL
         v9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776530053; x=1777134853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vjAX0smE41BTNjnnRZCLx7DL1jbmxY9+auerdTALqsI=;
        b=YSJ1mieoZNRYQa4UHzPt34Jdjcd0CBEaNhZEF6urYrdGywgud2iRywVaMac2UZR+Cl
         icQunaDec2CBwLanLTuO89k2AiF/iRZEQq/xzBHjwN7tZ9fppe8BsaoXMVLHse5QYYHO
         pUH73QNDRwqy2ZlxX+whShATWL4N6YrYHpElYFCBuUwn3tlD1CxomxHuo4QM8ofEO2xz
         UhHXL8xPC4bGywD6SEYy/9S03d/PZW+rhAya0kZ6OjR75dsGWt8Tds7wDfKs6agDXX31
         mvfZptXuEQNzK86+788YdIh9G7Nlk3/cJkCvsJhMGyNdrX6Z11H0YmeHLMP7gl8TUxGh
         a1Nw==
X-Gm-Message-State: AOJu0Yz8mbZYsSPMe6YytLcFc0nifeKgOYOCHjihmXG2yoTlSMS77lZb
	pgRW4oTSAMJS42IHVd07QTFEPkFzwIGi6NtFtnW5CQZhW34hZrLy/I8MWI95Tg==
X-Gm-Gg: AeBDiev3N623y/GNBsHmdbFCQfgH1DzImiGDRNJFFn1SqtikBGE8SmfM56v4eFoHC/r
	RpvUyJNqJvvEkAsZ/kvV1hhW0AMRi/dKxShTy58WSxd2hdUmzemOhFryv2MRKA5STXLk1r9/uEn
	VmUdjx0+B8yIukorSIWoauQ/LyOXP8/bx8aYMiWpDLIxInlwPQ0JLHR3CNLJomCcWSiWGOdAjwj
	KohV5EuDq5JVwXP5ZocplibsWElynONxhmu2IywfI57+Om7jlBFPh9DCV1eWxOllQNhGQTpT7fp
	OaRkeuFmdFS3TeVS7w6wpoXNK+ruynszTBaNBM4tqf7lrqe+aVGIG2LNBWI2NZtilAyrMW7arg1
	cl7Rb0iiOg5wjOaVhpuWqOIx6WYBCEWyRvcfRolAhx0D7BTNA05YaYDMaaXmgspH+QZ5x9Ti3Y2
	7ly+9Id6AaQ+9iHJuMEqHQOF5+6lWNaHeUXEEsndtrBNJ2s7mT7g==
X-Received: by 2002:a05:6000:4283:b0:43d:7ea1:fb53 with SMTP id ffacd0b85a97d-43fe3e15f7emr11405373f8f.33.1776530052685;
        Sat, 18 Apr 2026 09:34:12 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:e054:93f2:97bf:84c6])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43fe4e46898sm14205702f8f.27.2026.04.18.09.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 09:34:12 -0700 (PDT)
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
Subject: [PATCH v8 4/6] selftests/liveupdate: add test case for LUO_SESSION_MAGIC
Date: Sat, 18 Apr 2026 17:28:21 +0100
Message-ID: <20260418163358.2304490-5-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260418163358.2304490-1-luca.boccassi@gmail.com>
References: <20260418163358.2304490-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260418_093416_161495_0D5CDD2D 
X-CRM114-Status: GOOD (  10.79  )
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

Verify that fstat works as expected after the switch from anon_inode
to the new magic number.

Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 .../testing/selftests/liveupdate/liveupdate.c | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
index f0a8e600c154..5e99af0cc6e9 100644
--- a/tools/testing/selftests/liveupdate/liveupdate.c
+++ b/tools/testing/selftests/liveupdate/liveupdate.c
@@ -22,9 +22,12 @@
 #include <fcntl.h>
 #include <string.h>
 #include <sys/ioctl.h>
+#include <sys/stat.h>
+#include <sys/vfs.h>
 #include <unistd.h>
 
 #include <linux/liveupdate.h>
+#include <linux/magic.h>
 
 #include "../kselftest.h"
 #include "../kselftest_harness.h"
@@ -387,4 +390,41 @@ TEST_F(liveupdate_device, create_session_empty_name)
 	EXPECT_EQ(session_fd, -EINVAL);
 }
 
+/*
+ * Test Case: Session fstat
+ *
+ * Verifies that fstatfs() on a session file descriptor reports the
+ * LUO_SESSION_MAGIC filesystem type, and that fstat() returns consistent
+ * inode numbers across different sessions (shared singleton inode).
+ */
+TEST_F(liveupdate_device, session_fstat)
+{
+	int session_fd1, session_fd2;
+	struct stat st1, st2;
+	struct statfs sfs;
+
+	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
+	if (self->fd1 < 0 && errno == ENOENT)
+		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
+	ASSERT_GE(self->fd1, 0);
+
+	session_fd1 = create_session(self->fd1, "fstat-session-1");
+	ASSERT_GE(session_fd1, 0);
+
+	session_fd2 = create_session(self->fd1, "fstat-session-2");
+	ASSERT_GE(session_fd2, 0);
+
+	/* Verify the filesystem type is LUO_SESSION_MAGIC */
+	ASSERT_EQ(fstatfs(session_fd1, &sfs), 0);
+	EXPECT_EQ(sfs.f_type, LUO_SESSION_MAGIC);
+
+	/* Verify both sessions share the same inode number */
+	ASSERT_EQ(fstat(session_fd1, &st1), 0);
+	ASSERT_EQ(fstat(session_fd2, &st2), 0);
+	EXPECT_EQ(st1.st_ino, st2.st_ino);
+
+	ASSERT_EQ(close(session_fd1), 0);
+	ASSERT_EQ(close(session_fd2), 0);
+}
+
 TEST_HARNESS_MAIN
-- 
2.47.3


