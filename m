Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D84F99C69
	for <kexec@archiver.kernel.org>; Fri, 17 Apr 2026 20:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CRdHBRUkCqIVpBL949m004BbGluf8mLgg8lWb6+KmHA=; b=eoTlep4//tLs26VV/tolmM6s4L
	v3DX6URw/HYDxDFoRmrHAhPcNya5aZQ2YO33zhaDLFmdpUYjbXo0YEpSJO2Y8bkxXJJL7xHJvml7R
	xnbt0BG2u07Q2nborGkgk+1s0ihM9vng5naJVqaNedO/QTVV8FEziRNcA0DSgyN4bS2YNTmNzggVe
	IoZuhoUO9biw2gdRqLuWxObpkwxgjjl5VMNT0ktU8msdhb5FoU9AgAg1wIsFRAi+lMhqTGjec7N8i
	CnUonszFzvTuoFigazdbvdjddm1Qx/SFfdyiFGTZ83jhpGQyzAHsgPHFgyqH65syiGpF3U/IAx62M
	Yizb/Ksw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDqGm-00000004T2k-1jmz;
	Fri, 17 Apr 2026 20:58:32 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDqGi-00000004T1z-3ynn
	for kexec@lists.infradead.org;
	Fri, 17 Apr 2026 20:58:30 +0000
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4887f49ec5aso13974535e9.1
        for <kexec@lists.infradead.org>; Fri, 17 Apr 2026 13:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776459507; x=1777064307; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRdHBRUkCqIVpBL949m004BbGluf8mLgg8lWb6+KmHA=;
        b=AeyZkletYMT6WtK2jbMEFmv5YyjiBpGe9navtsCgx9o5VEMHZPakdyPT3a7cJGPeXt
         m7zDUSH38Zre9eYuoENYbn5b9Pp705M2SPh8kDyPQhPWtPmla+QBK/wRzuNir1yAkjJO
         HR/I7lBIBAx2b13rQtKHqGIUyvTBtfS7SnIkJMhcYWr1C/Ihaww2JzwRj9mQl1Po4MAt
         ItzZHKmyW9n+7atAYxJRIsSFx+pFPEkTWTmjzRQ2pXs4D5Pc8lIFWHSNh+pQXFOclUQB
         hMRfrmkzexi8rYZZnqmCes8s32drigMG/iw4/fGdylcAceeQGwZCvoIphE85jjvv/MBw
         he5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776459507; x=1777064307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CRdHBRUkCqIVpBL949m004BbGluf8mLgg8lWb6+KmHA=;
        b=VS+fxmiRXeyPNRQwcNkv2IQ24ACaOJcWsN1swrWDhwN5U+ur85aZuP6KQS14QTrubQ
         R/Mr+srCPiqpG1m86g+w1mV/AAsiz6hQRZRju8CUs55FY8aJ92NIsW73EM4Hv1+vNoHZ
         0kvElvq6K8Tnlh7Tvj6DQwhZLwzpi/oSOUDsUmz++902NVeCLapXO+y9x9Nfll1eEga4
         TVL067GLd0hYbiW0M7ph+31hgE8atcSE0xj7s0OC4tCf0ZQPMC3BnRAseAFUTK7PwbRy
         7pOswVX05VbiWAa+2XsZvYF6oWFDf64YulUYCaH+8wuH875BJvocBZ72PCaPWhEiHZwC
         jlGA==
X-Gm-Message-State: AOJu0YwVCTZGKMKI5TyLXy3zUbSMN9+8RmK9JOQFYRzb8B/xvYzlhkod
	5WBZrFYKadGK65IT3DKgoy+3TlMGl5jVFLtVfSh5e+EU89XUlNsOPaII+LHgQQ==
X-Gm-Gg: AeBDieuWrHF8YSVJAa2+Jo6DVCA/7t5uZfKQKnpADJcohrAbLg3nGI8Ogw+lWdixXAg
	okib+ibes2ZuCBKTdR5tZsW3K3zDwKl/GjM0bWYIC3Rp4tbHeEFT0pOALg5EIh1Tyrqz+ZNBxK8
	f/o1bM2QZiBUpxH9NrJqwH/LrTUqCPauizmc9m+xoAEGMDNzvwj+MAQDUkOakhEQJRo+eFuhNMU
	BTf59737AUR9BsYKa8iUQs4aSB2XbFJSfda19gmShAHgnEswtsPVlphnVtG156yxtKcH4E12dhz
	7arLK4ZKEN4tOzr1CtFEzVZagpPDv1HA1nrZj9RNTrKAKSJF53oLd0FCta3lz+S2iC9t53MQmp3
	ncMqy/QCD7C8jz7ZsPA+Brb2k6asVbFy66YpyRm1C3kh+TMK3eE5rLYyPVUiCtpUm0KROVu9biL
	i+/h1VQZudxxJp5nHuvrsqM9hgRHV8Tsg2X3oA4LU=
X-Received: by 2002:a05:6000:4201:b0:43e:a72e:ec5a with SMTP id ffacd0b85a97d-43fe3dc62f3mr6566956f8f.20.1776459507049;
        Fri, 17 Apr 2026 13:58:27 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:9586:30a1:a0a6:f076])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-43fe4cb135asm7866514f8f.6.2026.04.17.13.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 13:58:26 -0700 (PDT)
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
Subject: [PATCH v4 2/2] selftests/liveupdate: add test case for LUO_SESSION_MAGIC
Date: Fri, 17 Apr 2026 21:57:21 +0100
Message-ID: <20260417205810.1831923-2-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260417205810.1831923-1-luca.boccassi@gmail.com>
References: <20260417205810.1831923-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260417_135829_021010_BF506CE4 
X-CRM114-Status: GOOD (  10.54  )
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
---
v4: split test case in separate patch, reorder variable declarations

 .../testing/selftests/liveupdate/liveupdate.c | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
index bdc1cedc4f944..3c21352f023a7 100644
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
@@ -416,4 +419,41 @@ TEST_F(liveupdate_device, get_session_name_max_length)
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


