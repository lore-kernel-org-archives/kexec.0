Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E417FFF8875
	for <kexec@archiver.kernel.org>; Wed, 29 Apr 2026 21:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xc2oiP7pp0P8+LSVJw9z98TCpWpEve1jI7g9J2HlvNI=; b=HypdYBo/pWeWvTWEU7REzLllmw
	UP7m28sXhuAH+Sk/03wFp77FJVjewlsyyL1soR8h4ysHPlexxQKP+ZZGazFKhcijYMtI365Me4QTX
	m5vO+jFAdLrjftnBp4Pf83SN3gUslHXfhhseL+RYBmtJuD7BwNWAOGFt56fBUQIGx4tbdNtNbsqBo
	2mNvsUs2DHf6GSioqXr4utUbzzexHgbky+8wQp8XM28dCqNstymkMEFcND8km18PfOgnHwfpjK7kB
	prkn0FbB7yfru6d9V5s6UPpXTaqdS9wi8R3ESkxccdmNqYZCTjxATyeI15VS3/72WjAhnmPmiZFwt
	VB9RWv4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wICMe-00000004EPQ-1omE;
	Wed, 29 Apr 2026 21:22:36 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wICMa-00000004EMg-2ftL
	for kexec@lists.infradead.org;
	Wed, 29 Apr 2026 21:22:33 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so2016435e9.2
        for <kexec@lists.infradead.org>; Wed, 29 Apr 2026 14:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777497750; x=1778102550; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xc2oiP7pp0P8+LSVJw9z98TCpWpEve1jI7g9J2HlvNI=;
        b=g4kocMwPzu6Er5pTuvH95CgseWbKT6fQKM44K7ifyPOUAXQmtbTIExHLKK6CbqWVlz
         LayYpKM4KfaQc5ww2736CvCAyXo+iIXmNb0ngP9OzebKC1n56W/TJtGYnLubx8LcAGiC
         HaNMFeqcDuurCt4iosn/SI/xt4/0DWTYVI/FWgKDlR1Kx3ZDriPCyDC5rObsQdO3PEfh
         28UXKZ7POB3BLLTkmfujjLRFI+cF/SvneB4N0yUNn5yjtoR1ASQA9vODP4v+DaRZO+c2
         68X2678cEs890cPMHLDZMqeCshMDBzSLomevKKy+YXQ+e+4T6d/qbBBIhRDIQj4IAHxN
         VyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777497750; x=1778102550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xc2oiP7pp0P8+LSVJw9z98TCpWpEve1jI7g9J2HlvNI=;
        b=YdwjN8lfOVp/9li7q9X/2qqD5A+5KIQG2QOjhpRRlxx0z9tcvxFcZ1/U/qVrn0EGiT
         tC3F/ygiAI1r8Be5Rdt/ub+677d5yG1E5hSqtRoO6wi8vjJPmBsZxtkr8g0pk/DmIw/F
         LB59vWNLi9rF3LNZcpndObB5dW7sZ1p0b6ixMNq+86UVm2l9hcMuEcNdjiUW+PZTFg6Q
         Nf3ahnRxpFZgHXZJmofPDiqaG7C4T2mH+KLr/xos3ZSqFn14I1nKrI8H1t1uKBggT+X5
         p5yqyCwGe/I+krTVRcsB/B77GX87Fjsjy8iEWniAVm8UlaZNuYnLeQvQORnvLU5AUjqv
         HlnA==
X-Gm-Message-State: AOJu0YxWmGUMlm6ZrOcXlyTM5cMK4IF8DgP1ylMTyWAovCGvWickN1Ei
	Up+GDuSTnGLugJvEyP1f+obGJq3GIkup5IipITFtAaZzX1uJ+EQ6fdxKLTtiQA==
X-Gm-Gg: AeBDieth4dyUpv58MX4yYYkZSF3WQiNjFqt4tqcnOJoNDCHGSJ2udywiaYT0h2hNTOG
	qMq+/z+em04BNSxOrScPOKb7bjpqpBQJG23+B4lZ3kB4lbpKrAuIyWeH6wDAIJjfeJRfZOBigHF
	kdV8MgmsldjsCbSSdW8vfIlpS0Fco0OQfX2tu+fVwovMy5oXXGVLY7re2tH1GVfeVJVKgAaV4Aw
	Vwju+KsehpfPtl/DI0YKF+yvTZFH5n10SQvfoJuIqKNUnJaAzvhMsc++JyAWgvhZHj8mblTLi4k
	Eef11ChcLYYAGo/WgAEkIeurPZnx33Cw4bVlmumzXqscDhhSZuoHdEBW/dlZSO9QuXICKkJqz3n
	/5LTVc0547n0gVbALoXu+hdYVMpE2rt71dL2tAriFg42vjBzIO5SIBI0LvSQ0HMLLjXIPx6tY6T
	XWMa0KQoG8MAzDiL7W0BuhNBE8NmzHMeIt3rB+0Ys=
X-Received: by 2002:a05:600c:19c9:b0:48a:7a10:4f17 with SMTP id 5b1f17b1804b1-48a83d66b9emr4530045e9.6.1777497750288;
        Wed, 29 Apr 2026 14:22:30 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:8fc7:44bf:8aca:ebae])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48a822d4b57sm45365325e9.15.2026.04.29.14.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 14:22:29 -0700 (PDT)
From: luca.boccassi@gmail.com
To: kexec@lists.infradead.org
Cc: linux-mm@kvack.org,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Boccassi <luca.boccassi@gmail.com>
Subject: [PATCH v11 3/4] liveupdate: add LIVEUPDATE_SESSION_GET_NAME ioctl
Date: Wed, 29 Apr 2026 22:21:16 +0100
Message-ID: <20260429212221.814107-4-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260429212221.814107-1-luca.boccassi@gmail.com>
References: <20260429212221.814107-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_142232_691382_FEEC08C8 
X-CRM114-Status: GOOD (  17.88  )
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
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
---
 include/uapi/linux/liveupdate.h | 21 +++++++++++++++++++++
 kernel/liveupdate/luo_session.c | 16 ++++++++++++++++
 2 files changed, 37 insertions(+)

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
index 24b4f381d3c8..1caaa7886ec6 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -289,10 +289,24 @@ static int luo_session_finish(struct luo_session *session,
 	return luo_ucmd_respond(ucmd, sizeof(*argp));
 }
 
+static int luo_session_get_name(struct luo_session *session,
+				struct luo_ucmd *ucmd)
+{
+	struct liveupdate_session_get_name *argp = ucmd->cmd;
+
+	if (argp->reserved != 0)
+		return -EINVAL;
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
@@ -319,6 +333,8 @@ static const struct luo_ioctl_op luo_session_ioctl_ops[] = {
 		 struct liveupdate_session_preserve_fd, token),
 	IOCTL_OP(LIVEUPDATE_SESSION_RETRIEVE_FD, luo_session_retrieve_fd,
 		 struct liveupdate_session_retrieve_fd, token),
+	IOCTL_OP(LIVEUPDATE_SESSION_GET_NAME, luo_session_get_name,
+		 struct liveupdate_session_get_name, name),
 };
 
 static long luo_session_ioctl(struct file *filep, unsigned int cmd,
-- 
2.47.3


