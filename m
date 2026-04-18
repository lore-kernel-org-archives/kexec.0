Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F05F99C88
	for <kexec@archiver.kernel.org>; Sat, 18 Apr 2026 14:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nU6HvtcNtHHWFQt+EraQcL0A++PbqBB9SJ1Rgi6YBJE=; b=k2MqUpjAg+MyE7s38ENxF0Zj60
	6BuM5TU2o26mKeXOADhMma7bQg8K3KvJmFHy4tCxyn6VbBZCqNZkhPbPWOIFYvXKtc3CT8tvSo7VC
	0B68WRkyU4emR0H9aPOvXfxq/G6ucl6G1phSUs7yzB12SXVovNz2dZjc7PYsI2pVgk1yAWxFaxTd4
	05UmXc4VSnxK8J9Ixr01SZG/z++9bCeZdU/hNd9DkxEHJZ7PwAkudFPlgm3J4vOaZA/OxZ/OPc/CV
	ibXOj20FC8abuPOBBv9Ay5G1j7bR6yXKiyyZWFiY1kNctiHMYsYnaMUOhqXt4UFEEB2VVVSZIOybO
	u4aDKu9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE6OS-0000000517j-1F2Y;
	Sat, 18 Apr 2026 14:11:32 +0000
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE6OP-0000000516O-4BzL
	for kexec@lists.infradead.org;
	Sat, 18 Apr 2026 14:11:31 +0000
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so7667165e9.2
        for <kexec@lists.infradead.org>; Sat, 18 Apr 2026 07:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776521488; x=1777126288; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nU6HvtcNtHHWFQt+EraQcL0A++PbqBB9SJ1Rgi6YBJE=;
        b=BCqIEkjJu7oNMojeOQdOUeOB1aQshd0YkwalebBuRc6ExbABh1tOR7urR1BRNdrc1a
         WjqOn2xlSl0yBu5QRS3Ylynh/8dgiA+al5kWS4eofPpX0Kehr3Kclq2ROsRRcna5Ug5h
         cbPxA92AkbPQdzSRoHG0FOF5dOFQhQKp0tYyPQAofNyvK6HYnHBF9uxaAgD3LsmR+Gem
         ZfrqmiIKkY37nOpUpeAkMOLjPViQto8dyLAMAtzPyj6FwU5NfXZRiOGuI/Cx4Wkk02BR
         RkZ1GtjHMUnW9Kxm+841ASjl+pMOEK9Q+wQGXIimHxNNtt+cE6Fjhg8igUx0Aif87bzq
         mfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776521488; x=1777126288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nU6HvtcNtHHWFQt+EraQcL0A++PbqBB9SJ1Rgi6YBJE=;
        b=WPKEa3jQrzNmDsR6SxaSmOXNMq/SjSCxHjp9wbtOcG+bwirv4ytQXVvx7v4zVI1gCn
         eJWaPEoYHv7E34BMuPpZKBlYOHTL26IYBi3I6tE6db3A9q0XQTW6MKBy+iu8DLvTslmA
         cCYSEwP0RqaXh3MWhaRRAe8dU989ubaOXNygiLsWp31grN5nyjFmdOMKYSvSbBwKCWIX
         CInJG+Uls8bbKQCz/Cf2qtzDUYpbiMMw0A4F9PqjObb0+7XQ5rQ+gSHvbwL/Hkc0qdcJ
         0zGEWWtajdeSkWJa7+SZmktv7qESchaezSB9vyRYr2sewf5zjzISxxqGHaZ8YRG8e4iA
         c8Ww==
X-Gm-Message-State: AOJu0YxqXJT/wdj6sH2GcnD9zB/x9CdloLBS9t0wzJuhe1PielaPj0z9
	/8ihOUH778MF0sH7k5pvah03NHE/93eFdqgoOPrjKodeTWBqwn1gxO1Jc8V4gQ==
X-Gm-Gg: AeBDiesk3uvxalpHZfiKcVPrzu9TrK0wGxaSNkKmZO32stkkEs3UWNsCTzdBp6EjyVw
	57TvlTT4rldwAcqsONzio93ntoN2KaZ506uLwfWIZ1HLaIMRKcOyUPXd52veiH4+meXqvD+GwM0
	H2him06LgT++cg7GiHLwRUBgsI4owI/4fMTQWa2tAa7xm9LjfRbXssci6hj6utnzYuiObti7to0
	g6UAcLhPtl101SC4syZi5gKtEyag0AFJ+NnWntZUBS7r/RtP8fIvug3q+u0ATSLCIDWVzvbTbUz
	9lkeNSl1Z4O5rJeNN8lF2RoAnaAsKrVJpRXUSaPIvKknVjaoeb0CF9O1QyvjTdMyCWaXZ9fmTkB
	9YotVj/K9nujyijFDGbhPZqmX/O6S/SPkomLfTw+Nc9pFqRLIwvvthMsRWb6M9a2FTsGw5nHS5d
	8IT0EXW8XNYNKINz1kn5TGy24GuOyM20PHegyEt3c=
X-Received: by 2002:a05:600c:c082:b0:488:b043:5efd with SMTP id 5b1f17b1804b1-488fb75f7a6mr76884295e9.13.1776521487683;
        Sat, 18 Apr 2026 07:11:27 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:4429:3762:47dc:91a3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-488fb74c7dcsm43152365e9.4.2026.04.18.07.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 07:11:27 -0700 (PDT)
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
Subject: [PATCH v7 2/4] selftests/liveupdate: add test case for LUO_SESSION_MAGIC
Date: Sat, 18 Apr 2026 15:09:38 +0100
Message-ID: <20260418141123.2193917-2-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260418141123.2193917-1-luca.boccassi@gmail.com>
References: <20260418141123.2193917-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260418_071130_064309_15EB6933 
X-CRM114-Status: GOOD (  11.26  )
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


