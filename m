Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDF5F99C7F
	for <kexec@archiver.kernel.org>; Sat, 18 Apr 2026 11:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A8MUkPJrjfaH5SQStq4fKwYr2c2K0aYaSEhKyKxHML8=; b=e0TYizaIUcNLIaqjMLjXpOiMC1
	fdV+ES5cyIjb1e+0wWeESSa44XdC/CFjjser0BiMMqX00FXS5xDAAP//Q7cuLEgSQpJWkO7/gMxus
	6H2qR/iy4XLirtTTWTmiqqByltL2mnFx5kJP7AIyh0WDg2FBfS/OVca//xXEMbfxPeB3KKuy8jrww
	4oXwKeMSrIntA1hiCX7Bzxm/n8QlZHhRdImCY7Vpc3sjSEZ2uksyfEsIask0ZpPIYSrcCnDWLwB2r
	pkBF8kvFGYU20obsG+/jQb7S6FD/x3Vf2w07eOJyI5eYzD3fEMdlCPq6A71Od5Z4DQqNKtL8cMj79
	h7hQ2LnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE41v-00000004wza-2t0o;
	Sat, 18 Apr 2026 11:40:07 +0000
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE41s-00000004wxf-0jOv
	for kexec@lists.infradead.org;
	Sat, 18 Apr 2026 11:40:05 +0000
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso14030195e9.3
        for <kexec@lists.infradead.org>; Sat, 18 Apr 2026 04:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776512402; x=1777117202; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8MUkPJrjfaH5SQStq4fKwYr2c2K0aYaSEhKyKxHML8=;
        b=h86aOcPCT18KIIfqh+tstkWVEMji0ibM4v+Q/7NrTH18LA3xu3zZgDpAzutVrKcmPu
         jRto8RWphAw5rZAQJk5B/1CbTub5fAYXIjwnt38Di77WKFWtZwvgk4kV95GezdoEZ7J1
         svbtwa3Cm51RojiRlRXyowmwF0tLaw13E83J8eqrVFdvKeyLcB4dKD2Ir0gupW0M5ON0
         36MLHB2Bu7KPRo9N8iDf3wtIiucMtJoOi8R5a6DFWqcSuX6YGbUpXDE37Cg/+TF9Mu46
         y9A87TDYFRMus0D/fwDUGUeIwPkZShsNv7cRLwZw1qusYDCa/0G7hDuRMW8CPwdbRxeY
         Cxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776512402; x=1777117202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A8MUkPJrjfaH5SQStq4fKwYr2c2K0aYaSEhKyKxHML8=;
        b=fOt7Mqjzr4pyDEeENs45Kig9NahckqLTeZfb31qR3Kycki9xMZIFZLfb+MYxOtoHGp
         Gp6w+/0kGs6mDEVSILsB95h0zaU/+xc8noL3mkFvj6AP1T5thSbDvrJJXyX2liX1k530
         2+8Rbc6nnIa8zjtqBSSZ3+Sy+FqDwP1CoiFsoJ8c7i0pq8sJ48kc+EH+r4o9ez2KF+SP
         KRHKmOj3UNWn56GIroT2soWLbI03EMQylZRq5P3YK8y55Ix4KmFYlO5yz6tzWRYOnjQz
         7wRloOzMO9MbAY3Rv0ILTPHlAnkpDaKwqGJ6H8YyKEXV8CVohU0DtLrSRY22Kj54d4jJ
         XVpg==
X-Gm-Message-State: AOJu0YyI1HD+eM2p7lIJ0CyXo4lyMZ9/nyyLLhq3HE8Cssv0LHEn6LbL
	6XtNoFiImWPHFGUJusArHpv/d31jBcEim++PTfMWvSDeoV2s+yp2djQ6wJkwqA==
X-Gm-Gg: AeBDietkEh3XouJBPfyTS3Lb8R8Y9eAv7ibaME1E3WIa+w10ZOtsZEDCaBMpTEVHDpY
	5YQEPqey10b3NO40yF4CjD6tkVy7YSzgmGXyFMav4PUoYw5lPoGAcICTjwyRQ7US9jKlhgFOmYC
	RdAVh7wKH/dRfTYY55r6MEs+fQyqMF7gzVsItPXf2c6doBPL4oP+EzXdTbINmi4kyg/0l/+0dOE
	EGeMK3m5huQx2+Z6/Uij3miQ+0zn2ATpFvmzv7U97G6fzKxNv8R8f3zS0wTBY0VD3eFozVXDQ2j
	bYxl76R0IOlkerOTaG9whX+Z1qcHnbmhy2ZyYR0dEKY8Kle5gKz8TJRdewU93eFSdgo75OwX9Q0
	s7smMdmF4wJeTc/e2/GYoYMaDo3pg1yV2geVe22ql/rPCZyp6y/GBdzNDqXV03ghzcxwOGX05zI
	pbK8axy8lVA6yYik+70ZEHYcdB43bsuVdbedn3rOE=
X-Received: by 2002:a05:600d:8449:b0:485:445a:87d1 with SMTP id 5b1f17b1804b1-488fb74a66cmr79170875e9.8.1776512401940;
        Sat, 18 Apr 2026 04:40:01 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:3ab1:89ce:8d93:ae6c])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-488fb74c789sm39341825e9.5.2026.04.18.04.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 04:40:01 -0700 (PDT)
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
Subject: [PATCH v6 3/4] liveupdate: add LIVEUPDATE_SESSION_GET_NAME ioctl
Date: Sat, 18 Apr 2026 12:38:40 +0100
Message-ID: <20260418113956.2146648-3-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260418113956.2146648-1-luca.boccassi@gmail.com>
References: <20260418113956.2146648-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260418_044004_246919_BA31A6AA 
X-CRM114-Status: GOOD (  17.56  )
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

Userspace when requesting a session via the ioctl specifies a name and
gets a FD, but then there is no ioctl to go back the other way and get
the name given a LUO session FD. This is problematic especially when
there is a userspace orchestrator that wants to check what FDs it is
handling for clients without having to do manual string scraping of
procfs, or without procfs at all.

Add a ioctl to simply get the name from an FD.

Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
---
v5: merge with LUO_SESSION_MAGIC series as they both change the same
    unit test file, to avoid merge conflicts
    add '__u32 reserved' to the UAPI struct
v6: fix docstring

 include/uapi/linux/liveupdate.h | 21 +++++++++++++++++++++
 kernel/liveupdate/luo_session.c | 13 +++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveupdate.h
index 30bc66ee9436..3a9ff53b02e0 100644
--- a/include/uapi/linux/liveupdate.h
+++ b/include/uapi/linux/liveupdate.h
@@ -59,6 +59,7 @@ enum {
 	LIVEUPDATE_CMD_SESSION_PRESERVE_FD = LIVEUPDATE_CMD_SESSION_BASE,
 	LIVEUPDATE_CMD_SESSION_RETRIEVE_FD = 0x41,
 	LIVEUPDATE_CMD_SESSION_FINISH = 0x42,
+	LIVEUPDATE_CMD_SESSION_GET_NAME = 0x43,
 };
 
 /**
@@ -213,4 +214,24 @@ struct liveupdate_session_finish {
 #define LIVEUPDATE_SESSION_FINISH					\
 	_IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_SESSION_FINISH)
 
+/**
+ * struct liveupdate_session_get_name - ioctl(LIVEUPDATE_SESSION_GET_NAME)
+ * @size:  Input; sizeof(struct liveupdate_session_get_name)
+ * @reserved: Input; Must be zero. Reserved for future use.
+ * @name:  Output; A null-terminated string with the full session name.
+ *
+ * Retrieves the full name of the session associated with this file descriptor.
+ * This is useful because the kernel may truncate the name shown in /proc.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+struct liveupdate_session_get_name {
+	__u32		size;
+	__u32		reserved;
+	__u8		name[LIVEUPDATE_SESSION_NAME_LENGTH];
+};
+
+#define LIVEUPDATE_SESSION_GET_NAME					\
+	_IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_SESSION_GET_NAME)
+
 #endif /* _UAPI_LIVEUPDATE_H */
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 5e315cc0dfd5..f30151c37bd4 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -291,10 +291,21 @@ static int luo_session_finish(struct luo_session *session,
 	return luo_ucmd_respond(ucmd, sizeof(*argp));
 }
 
+static int luo_session_get_name(struct luo_session *session,
+				struct luo_ucmd *ucmd)
+{
+	struct liveupdate_session_get_name *argp = ucmd->cmd;
+
+	strscpy((char *)argp->name, session->name, sizeof(argp->name));
+
+	return luo_ucmd_respond(ucmd, sizeof(*argp));
+}
+
 union ucmd_buffer {
 	struct liveupdate_session_finish finish;
 	struct liveupdate_session_preserve_fd preserve;
 	struct liveupdate_session_retrieve_fd retrieve;
+	struct liveupdate_session_get_name get_name;
 };
 
 struct luo_ioctl_op {
@@ -321,6 +332,8 @@ static const struct luo_ioctl_op luo_session_ioctl_ops[] = {
 		 struct liveupdate_session_preserve_fd, token),
 	IOCTL_OP(LIVEUPDATE_SESSION_RETRIEVE_FD, luo_session_retrieve_fd,
 		 struct liveupdate_session_retrieve_fd, token),
+	IOCTL_OP(LIVEUPDATE_SESSION_GET_NAME, luo_session_get_name,
+		 struct liveupdate_session_get_name, name),
 };
 
 static long luo_session_ioctl(struct file *filep, unsigned int cmd,
-- 
2.47.3


