Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CE4F588E0
	for <kexec@archiver.kernel.org>; Mon, 20 Apr 2026 14:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vjAX0smE41BTNjnnRZCLx7DL1jbmxY9+auerdTALqsI=; b=TCuFO3SEXENOKmll7eByWS2el5
	MX+gic8dm7+OvEEv6YJ+mx1VQkrwpdFX7zzENYXbzwi/R+4KzBVJjKf10Sgwt4D4aYL6czlDl0+HO
	bLNyNFe89hwywSSMbjJEq9iAuOqByYcuYDcoS1E/TnL+f/b3zhVFZMeVOU+sA0y1U9BHAYCTp4PW+
	e5dNN/XcXxnPfS4f93cKajYSfFuqa5TJNOHzFd4fq5kuGvpHFgJG0ObrDxLY6ZjuX25yMewZsXZoK
	/9ykITm6lu8NKGthKKd8eWMJ/KHFY2Ym33gGffYw1V33VbzJSsrn/g+DfpaxrnAy0CwIV2QGEuJir
	VqoC2Phw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEpRj-000000079vE-2I8s;
	Mon, 20 Apr 2026 14:17:55 +0000
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEpRg-000000079rL-1PWy
	for kexec@lists.infradead.org;
	Mon, 20 Apr 2026 14:17:53 +0000
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so48092415e9.2
        for <kexec@lists.infradead.org>; Mon, 20 Apr 2026 07:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776694670; x=1777299470; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjAX0smE41BTNjnnRZCLx7DL1jbmxY9+auerdTALqsI=;
        b=EqGSQ1svvjnGYvWvnXlka8HjihOqiTDTbXGo8t8U7HSMQ8ATCfCKJnlJHXPHqF3lg9
         XGwEKxiRNEL983R6rlZL8NWpJM5uI8BqA7ZyMxDy0qBb+r1VWRhQ5g1yrR01+bU7o331
         J7wMr9oqJJhAnOc7q9fMB8rhmxC664T7QbaNpHGMGf7Xm03PI88JPwPAFA4Cvqkg/pqc
         /Y0k9kusebAG8MSopDnEcjr20Y7d3O5XSt3OORmy1G5fkmX1/AxNhle+LroMrXbpJWiW
         sSDADmNsmaBKPNBE0B+5UodT2oUtHhq3quLl9J4/Hq/8osQNOjJE88d0Es1qDMhxDfqB
         Sk/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776694670; x=1777299470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vjAX0smE41BTNjnnRZCLx7DL1jbmxY9+auerdTALqsI=;
        b=b6WJxcsObT/ctIGIWnDHpLphdpBILcGK4axGf1n8SFDQGk8MoM7sKOcDxWy26Cp3SK
         YelQ1b2fk08g80MHt6VJbnaTWJbmSeSdsaWMtbGHua0SClGCpZNxLLREvMc2iue0Vpao
         /OJFGt2pvfoupY1StdKSyCG4YWUzR0NsO94D+IDM9Wo7sLvgozMf8TIkdEMg/fhqnJwZ
         Ut/H/+z4QAyvQUcyZNgl1U8FANGr7VsXAIcUFTy3TVvIxk0e2LMwgkPuOER4DEZJpRRg
         u6nI3Do7K5/xv18R6wACILFHba/EwsXAEOyw1+gZjjfnMMkNcMZUkwXgUH0W2K6IhVpT
         gzGw==
X-Gm-Message-State: AOJu0YwZcbCv9KVLW3LQ6Kqax37tcTjzQbE+AQCM49Ncd5Jr2ra7TDYo
	cqdQiB9bxuYs3uqv8eacXrzSmRSPXimApdYlQciXVJfMV3CcpoW4rlPBeidzeA==
X-Gm-Gg: AeBDiesaFiWMFZQM/kZIFEXdfHETsYbMLNbId37WzdMaJ+ut+XphT0z/ruScbhQjAcd
	H9exupMEpL970Rv/HKh3+DVZKgE0M/DokK0CubaeF73yL1+J5MTQTiYDe9zuK/mR0ZDd7duPTC3
	a0hnOR1B3SCpyDMiI0w7mj9JMSs4ZOMjCJzr4VpEs5VygaLj8Tu2bo0qivV8y7AIpSzOOVWNl2B
	ucaWG3SY2MxCTQRRzJ/hSG39bicKR1Ez9Vd0ivspBE+UswNPNwBZyTlrM2fwOmLlvyiU4N5PC6J
	CE6rFMyHooVoxvDPUJl34Qf2fHa0uaT6L2843mqq9RCIGz2qQYa6RYxaOMYGTfCzrpqfjq1jh9k
	EqwlEj/aqb7EK7MeRk1T6HJAyFuaVh1rxX3+NmpBdqJ5yQbDWCnUrc5X4FidDZcSdAiqKcGiOkX
	mCC5/LI/A/OBwMyjrDUVSOaui5tcYpQ0aWjMPoaH8=
X-Received: by 2002:a05:600c:8b38:b0:488:b14f:b8ed with SMTP id 5b1f17b1804b1-488fb6e815amr205856885e9.0.1776694669910;
        Mon, 20 Apr 2026 07:17:49 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:355d:3be4:308b:c943])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-489207ebd3asm23410595e9.6.2026.04.20.07.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 07:17:49 -0700 (PDT)
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
Subject: [PATCH v9 4/6] selftests/liveupdate: add test case for LUO_SESSION_MAGIC
Date: Mon, 20 Apr 2026 15:15:12 +0100
Message-ID: <20260420141741.2688371-5-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260420141741.2688371-1-luca.boccassi@gmail.com>
References: <20260420141741.2688371-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260420_071752_394481_66E738E3 
X-CRM114-Status: GOOD (  11.27  )
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


