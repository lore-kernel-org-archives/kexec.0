Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13053F99C7D
	for <kexec@archiver.kernel.org>; Sat, 18 Apr 2026 11:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nU6HvtcNtHHWFQt+EraQcL0A++PbqBB9SJ1Rgi6YBJE=; b=CIBT6YSxpY7Ty9LDjUD2zBAdZu
	0RRyIISXsdX7E3ys1d3VcwbuUWlNdkrTu33WlAuArWbwt0EiQNEu71nxlp0lfwSAoGlibxScAW+Kh
	BZeWaDyQN8kfmrbLZfMHoLsZT3azEGllMscOLXrZ0sWSmsRHAmgoXOzYtE3zDiP9CG0l5qkpm5pLV
	r1yV4x68ndKHl15jsQKnXrlakpfaDJSyacPNKdLf7/Qr4lDjffa1cw/6egApgORqkIiTFlhTbnTEl
	kFXbx3LckcOAK79xSlQvg6PUgJncPw/r68t7tptaFBvotY8d9jNKudxYsTfSbSDsU972zPlgvc2QB
	rhTLBMqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE41u-00000004wz8-0fH7;
	Sat, 18 Apr 2026 11:40:06 +0000
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE41r-00000004wxc-1qRD
	for kexec@lists.infradead.org;
	Sat, 18 Apr 2026 11:40:04 +0000
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-43d70c30767so1446842f8f.0
        for <kexec@lists.infradead.org>; Sat, 18 Apr 2026 04:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776512401; x=1777117201; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nU6HvtcNtHHWFQt+EraQcL0A++PbqBB9SJ1Rgi6YBJE=;
        b=rSpwZ1aqeikz7hOQr4y6qr8kqfQsModMt7Osp4MJ+CGUhvfjAzeGU0+571/xBqQAy4
         9M6/AxXgmp0RQv15gyG7M/EWUP9vjaaYYIA3eeNiiuWxl+yqmJaX9MCtAiS6L5Jk5dp5
         uJ2jnf9oOYxUL5AmyxY8FzuXbRjnJ7Ld71MFnaaZ68QXKab6aPE8MT694m1OAvSNafq6
         0Jr3lySlKk8hxTM/nF4Vdznzc1lPVJZofr7R0LvxCUMSG6LXNVu1mY+OY4sj1hyqpGC8
         1xTAP3mO0wQaHCkx8R5i094stlcW369gyRfECYxSoXf2nhnaHIXocPetIPeE/Z2Xi1Dk
         f9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776512401; x=1777117201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nU6HvtcNtHHWFQt+EraQcL0A++PbqBB9SJ1Rgi6YBJE=;
        b=H1deadGKIW+hzxGM+YoY8iALy8QTC4GZBxwn55oAVuM+B1bKVvqrhBXrMxd+uoYz0V
         pkkXvs9w7ReeBi0qW+c+VtiLKSWbopN5JOJO8Bkn4T/hQzob7eKuuBawRWWOnJ3sUIBP
         h2YrfUg9r8IzPsONBYoZ/VpwIUU/sk0nOi9gSG3AIg5Zy7lCjT3ykrhvF3x5Q78e+Q7t
         NMZOkW1VlBn57Rw4uXgAyjoUZK955d5GedfjcM0WMoxh60pSzY+agrtxHpOojVpQtz4h
         a3gFOWoVtTE8oaHmh+eSaB6Joas+rKOikFijij1XzEDDbqKtqGkqM8+Zytl59fp5Oy5j
         mAdQ==
X-Gm-Message-State: AOJu0YzeD0c29J82OtsYJziBE2tCHWlMFRHtMABTjEnO/R3hLXqGAnwK
	OI7OI5TVoRcLR+1U/F5ibmGdBUd2KC98az5056YQGW9uH1rC1TX1bzQJGvX5KA==
X-Gm-Gg: AeBDietCGAOAbH1nzC+py4c9EyLRBUgmQHuf5bvrg4BygtvRAScOMfR9Zn0LU6xlu+N
	YU7v0YatFWz7t/tvpDv2EL/ZWWuNUBwS721tvT6h40QCLOpwcRO2LidQsTa19VM8DjCdvfnzP7W
	Dl4dH7a2mlLpg8RONuTFBEYu3N6+gUfg8tz3kM2ls5kjmivxYdcHf5NnYHBRwyohlMTVw0uu7FP
	OYMbiYI7pOTxbQiJoRCsXpfwWdwfSkaPrAMNtYL+VOakCYiLm2Rv3fSSZoy3X1+tdl+E278zrQl
	1gwx741fck3h4RPFyXCHtVD0PUAZnZg9IsXuRbg2P5ItFssMIVNW1fVxxmdXBsJv3iyujXdRTuR
	RrS4ViN3moQRAzQ+3r3oUGrcr0qQ12vvcxXLiMoCcx2YteWMB+qBmb0sWKgizCoeHv5hJbnKuoG
	H/UGfbH/BLIVcF5+2n9mArwlb+jY47wn/8Cb3tEUk=
X-Received: by 2002:a5d:6f14:0:b0:43d:7086:b03 with SMTP id ffacd0b85a97d-43fe4032b76mr8292587f8f.1.1776512400771;
        Sat, 18 Apr 2026 04:40:00 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:3ab1:89ce:8d93:ae6c])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43fe4e59f97sm13278846f8f.37.2026.04.18.04.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 04:40:00 -0700 (PDT)
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
Subject: [PATCH v6 2/4] selftests/liveupdate: add test case for LUO_SESSION_MAGIC
Date: Sat, 18 Apr 2026 12:38:39 +0100
Message-ID: <20260418113956.2146648-2-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260418113956.2146648-1-luca.boccassi@gmail.com>
References: <20260418113956.2146648-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260418_044003_517586_6482AA39 
X-CRM114-Status: GOOD (  11.36  )
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
index c2878e3d5ef9..d132b4685f76 100644
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


