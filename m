Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F07FFDEE53
	for <kexec@archiver.kernel.org>; Thu, 23 Apr 2026 23:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zsfZ2qn7mJjDdFBLWj4T8+3T0/zctntZPaRw9g3HzKQ=; b=2ejL7wRlMFJBxHOX3s2VAAfiWT
	cCCrftl16BB/0odprymXOr8YFffJCpcj5J/G+YIWRgnrNyKF4TTNEd90dxgE1NM3CLLr2u4/xtQaK
	JaIVtlojFTHlnMCrUjA/6mWc6ON9LkmEyip1ZxEE5RTyGdLVG/eWSim5b6LcZ3IA5luSwyJgJL27s
	QvV+g3vto2Vm/mXDcPRPYiw6Fse1qZLrWe7Rkpmu9k2PELtmjnfxCB4wBrQC5Z+ryO0NuM+T1cIHC
	p6t1bltJK6N73Gplh5dxkWQwvmlNZ7W6B+UjW6DktOFzRLiIeZL7EwMM7W5IDt+wIi2eSWhM/oYsQ
	zWdApIBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wG3n8-0000000CQAr-2Poo;
	Thu, 23 Apr 2026 23:49:06 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wG3n3-0000000CQ8J-11ef
	for kexec@lists.infradead.org;
	Thu, 23 Apr 2026 23:49:05 +0000
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so88813095e9.2
        for <kexec@lists.infradead.org>; Thu, 23 Apr 2026 16:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776988139; x=1777592939; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsfZ2qn7mJjDdFBLWj4T8+3T0/zctntZPaRw9g3HzKQ=;
        b=mzxnlUjKxweKOqtwPh6HTsOCbfjf5Q27gTp/eAgggyKwOt7a5p2X8RJnfDBE+oCPgx
         BcjIIfUNyNErTUzjVErQv/yIne65dR68Pv66ylehAwpGUghYJuxOp7ZxVYzdVtjCzZoW
         /BpzqO/7Da4a4TOwj07c1pqUW7JX6dy900n5199nflLh6mdSZN3GE8wIhp55RCBuxKWz
         PQoK5VVo24ZhVBRQtxvUybyCxOr0VC4gIneKtz8iz+5b78n1jbOlSyXGLvtsG6lFGWiY
         /1e8L8PkyduvY84fLf7/mbkA52R4trAS67dCe6O8BnkmlRcn9DEC1m2PyDtPDRd/e+sD
         ve5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776988139; x=1777592939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zsfZ2qn7mJjDdFBLWj4T8+3T0/zctntZPaRw9g3HzKQ=;
        b=PT2ex+PLTd+0k00YgZHTD2xQ7xw0iQhyRNkt3D3EENg83LZxp+gQmgtzT/tBuMX39j
         G5l1U/as47VjyRnb0aOa2ZiNbZWXcILXwFbEXkVJ4xJ++lamXUBbvepM6y8wvzRtbzBR
         zrF4CWtHFgKAoLTn/3YQ+CoKHbSM7GHBJx8/RHhOhM3BM30k5y/JVTfs99l+erlMw0vq
         8MCJeRzPuMdV4Ke8HYB/em3vlEuKlN7+ZG3fKTYPF1cpHR5qP/WhIIybRC3vSBFoqZn2
         cEcIMbt4PoVkvzEa/GVyYPwMC100t10MwpIyVf8aedR+q8/NPCNEkYc04zL5UVPKgLLM
         KGCQ==
X-Gm-Message-State: AOJu0Ywl3JTU0Kzm7UsXu+kN1OR3PI0SXVhGunIZLM7a49BLZ7xbKVLW
	TxQGXXlCKRtf7MDIEwwlKc++JS6PS+2EYTKBpqxEmiv2smRm9MtalhWP4zobAA==
X-Gm-Gg: AeBDiev2T3ZWAhtgG6kbuee6UAbb7Qy8Tac4wd3y+d5lPQBMo2swor6CmgFOu4sQleF
	1LvySi3UkzgY0FCWL8PT1yj56uUZQGytrP95W80uhbWUxlF6ARS0hGyU5mzPiVcfnox2zYUpoaz
	dCeEeM5DU6s0CceyPRbtchiFXGpS5SQRtZbZXCDK9109NHrQ3c1afDWvJHaifv0N1cjok92cr9t
	Lpr/1ljZjxZkPu/TbVH6sUFojI3qZKR1yjxCawG+Mn6DuK9xK/0DH71AyRRMkhOu6BS6ct5Pner
	GwMGyjL4fLizjP0fB3168IgQ5cJvZoQAkN/yxYibcjXHSq1Xe46XOJgQVEX7gJyv/X/gPDSKwp/
	INXYKq7IRW+my9yEWMPNH1z2GJnfG8vGnvWPFezXTTLpm8UizdUeIx2CPJIEXSzflWaRw09JMPG
	BKTF1FaafmsnLpHBCMpBEAFYTgAmyibuGtQlDpacI=
X-Received: by 2002:a05:600c:c0cf:b0:489:1f3e:5f6f with SMTP id 5b1f17b1804b1-4891f3e62a7mr201443495e9.12.1776988138726;
        Thu, 23 Apr 2026 16:48:58 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:e8d7:434e:1f34:2cb6])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-488fb72d365sm280596905e9.1.2026.04.23.16.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 16:48:58 -0700 (PDT)
From: luca.boccassi@gmail.com
To: kexec@lists.infradead.org
Cc: linux-mm@kvack.org,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Boccassi <luca.boccassi@gmail.com>
Subject: [PATCH v10 2/4] selftests/liveupdate: add test cases for LIVEUPDATE_IOCTL_CREATE_SESSION calls with invalid length
Date: Fri, 24 Apr 2026 00:44:21 +0100
Message-ID: <20260423234753.3873095-3-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260423234753.3873095-1-luca.boccassi@gmail.com>
References: <20260423234753.3873095-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260423_164901_298453_8C4289A2 
X-CRM114-Status: UNSURE (   9.18  )
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
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
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


