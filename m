Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0812BF99C6D
	for <kexec@archiver.kernel.org>; Fri, 17 Apr 2026 22:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2i4D/SGjYjFaWAJjDug3MPpVtGFnh3UTQlFTWuy5SY8=; b=EiTm4biHvCpOEXtHfX61qbgx/8
	yWYSJV+PiX97+FkxOusMLth04C70xkTrfIyYUa7g8yNEoVj6PgLJMhPvWXc75K55x8I7Qhgsa+X3t
	GKuD18S1rIOggO9wcfC1I1h7ffrhjEOHkRP95MJr8+ZvlbEyGpOCIUBYfyRmPOPAZDNRGR+8z8Hit
	pwBJx5RsvjYSiL4he+kD55IpHNX+8beX7ulTCJBoANMYdjgO21QenNzueW+qmxWXoFUApAczEWLIU
	u83jhzXda1PAot01CqOT6Hu0D6qSKX7dyAFhX3AiE22vSs7C5zW7yLShVg2cJ9cqkVBWNTGW/GBag
	f5tMgnXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDrMh-00000004Vm1-2jUZ;
	Fri, 17 Apr 2026 22:08:43 +0000
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDrMf-00000004Vkp-0t8E
	for kexec@lists.infradead.org;
	Fri, 17 Apr 2026 22:08:42 +0000
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-488b150559bso8913465e9.1
        for <kexec@lists.infradead.org>; Fri, 17 Apr 2026 15:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776463719; x=1777068519; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2i4D/SGjYjFaWAJjDug3MPpVtGFnh3UTQlFTWuy5SY8=;
        b=nFRV3so4eecCWGRoiTKVT42CXYCzknSdra4V8IOLUFZ2Ao2ytMkWcpNnbC7sR21Jvy
         4dretRKWDNfo1xRSC8IR7BMfqMwsSHZuwA4zkXe15iTC1MCRkixBGAwwSlFSNfTxn14J
         9OG5BQNOrOwS5yURhiVZ+2K3vVXQWOS1Om80f+OnPASH48OIdNoQsubc/weKX7fyB23c
         GdzJFGRn6GvNB7lB0sZVAXUKXDLrCq+zsVrkUSo6F4q761NR2Ofu3JUv6/01k0zZDNOw
         gTPnPwcgQ1MU+ZcsaD13cFv6tebiZac8luNgjV9/pTlmjm2+Lz7sFHOQHKnP/mZ+p/WN
         W29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776463719; x=1777068519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2i4D/SGjYjFaWAJjDug3MPpVtGFnh3UTQlFTWuy5SY8=;
        b=GDnnnXk42kKbCsQXQABSJ8NoJlFnbgavj8kjgN9azEOHVlwI4TWA2uo6hNI77ICqWn
         OTLlBfCaVjTUQ06LP8yyYblewKLRUCUoh5B8RKRXjvt5Fnz7f+YemBfg0mGn9CvR/wFt
         E9UMowizUxY3w4al6deaQTl9rC9prf2R+E5wX5KLmWu3rlLC/OfJke9OCE7yYiddG1Iq
         UwDfpwuW7xIMZbHRZOTPyJv5cI1dpPceQjXEG6qIpE4cYJuxrqMKLXWMQaycwkaBlr2k
         peHooWHXRoLFfC9jdhG5ybMdbAuTXX3oHJun+L25T1MhcoIr11rAMomr9jod8ZXdTumr
         J/Jg==
X-Gm-Message-State: AOJu0YyRhYwSb1+gEEpaiEp2ztJmxzjtfEdW/dg3CoB+U/nt0m0TB0cq
	kqdnFdktWKIB2p0UX4o1tOWoEtqmeEYUezKumYyD6W547D3OfexqlfFjYDerlA==
X-Gm-Gg: AeBDietyQ7Y7YGhRe2Ix01xjidAo7KHHJQkeD3BTNbR5UuO4ZiCbI8lsYRAPJqnaO0B
	GluUS8nAhhbynVm0ZHF4ocEgPGzICTy6rmLndAHXkhrgTwWTYvnXdh0Y7UrL31/7+xhUptRocpg
	ZeMqj+v+dW22xSDoPVqK7wsbpBe+cHy2LCFVKhRh0k85oKtRmQZwJHgOlKIWW1s/Ptt3ALdxiBA
	fiKCajW7b7f9SJhb5ZsvQnNf3d/vugP6dhhNHT8CLjRmACHSlk5ZQJOEgRvzV1TqsddKorA4Vca
	kJzFNwJFx4Xx9ebfHQy45n/0pEQ6iUcHV+p6gEZLPOXlLFPfkLKj7pUHUD+vkCHVG3XtvcjtrN/
	h1lM2F5uBYu6MkmkFhvuqOJ2iycbeOLdGe5x9sJ677el4k2YFmSZ5wSNT4bjcQuXozgG9q5yJpg
	9aomXqgrrEAz7KiB5sRMW5v3zEBrc//scLnnueIbg=
X-Received: by 2002:a05:600c:3546:b0:488:81b1:ae36 with SMTP id 5b1f17b1804b1-488fb7880camr68489975e9.23.1776463718984;
        Fri, 17 Apr 2026 15:08:38 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:9586:30a1:a0a6:f076])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-488fc1c01c4sm142428545e9.9.2026.04.17.15.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 15:08:38 -0700 (PDT)
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
Subject: [PATCH v5 2/4] selftests/liveupdate: add test case for LUO_SESSION_MAGIC
Date: Fri, 17 Apr 2026 23:05:43 +0100
Message-ID: <20260417220831.1934945-2-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260417220831.1934945-1-luca.boccassi@gmail.com>
References: <20260417220831.1934945-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260417_150841_266316_97B0AC8F 
X-CRM114-Status: GOOD (  10.91  )
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
v4: split test case in separate patch, reorder variable declarations
v5: add r-b tag, merge series with LIVEUPDATE_SESSION_GET_NAME ioctl
    as they both change the same unit test source file, to avoid merge conflicts

 .../testing/selftests/liveupdate/liveupdate.c | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
index c2878e3d5ef90..d132b4685f767 100644
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
@@ -345,4 +348,41 @@ TEST_F(liveupdate_device, preserve_unsupported_fd)
 	ASSERT_EQ(close(session_fd), 0);
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


