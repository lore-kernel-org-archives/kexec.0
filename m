Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA2C9FDEE4D
	for <kexec@archiver.kernel.org>; Thu, 23 Apr 2026 23:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=otwtwCMsuSRZKjyxndrTmRFvCENq1yZJOmlAXqb99W8=; b=Kgnqzvaa1Ta59I1u4Q6yXIPpHX
	448FvuVOIK4DDJRqoDKgB09lFt6cbq1BT3i006wsZbG7YobXiCjdZOnMy/zTPYVEdrKOFtFnKteNb
	iaZ/GDKM0QhyTNhFMZK/fvEo3bP1NlTu/0cF6k5CF3yGmiOH4ROxFzJbwnyqmZfExLVwK1jgrDekM
	htTNJ/E+uv70M9C63uZaHTwvd4d7+TFGcpHAylR2st80JBr4dsMIJx5ulDkOyt0GQHVA4Zlef288g
	QpiraFQ2IuVfUBqQfpTSCxSs4Bs0MJNVYrRy6udFVyqzOP8Ivf6MizSUv8/+f7SiRU3u6qehcErRn
	DiCppZ9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wG3nD-0000000CQDW-3WfG;
	Thu, 23 Apr 2026 23:49:11 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wG3n4-0000000CQ8X-0jB1
	for kexec@lists.infradead.org;
	Thu, 23 Apr 2026 23:49:10 +0000
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4896c22fcbaso44144395e9.0
        for <kexec@lists.infradead.org>; Thu, 23 Apr 2026 16:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776988140; x=1777592940; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otwtwCMsuSRZKjyxndrTmRFvCENq1yZJOmlAXqb99W8=;
        b=lQ/QAoy3ONFfgybGlF0BNiel8c0FyqrSfSCUfrtxtjxx/dRGYVBNdT61jUUSuu2OIl
         GKp8PW/24ql2qC2Bwym3Pge9wkkIqUes+wbrmCZMS7s9GA8EYYVIhz6yvopMQ6vVDELg
         9G2nxXlKH1laF2Qr6MNEDtxqo92ptGVhwqiBjN7dqoBkBtc4jZL72r/oDA8ADmdDjRsq
         YFC2r19N+Kq7YrwS7PPdPV942RfQpAFirY1TTa9cWlREwEtnOIMvlKx3MxuCtV2cz0k9
         cBhBLA3ho+Qlvq1RLsMhSAJUtCfOy1THwYcCEQGxCrh2O+ZtrojIm1N2pfekG6tECLqk
         cg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776988140; x=1777592940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=otwtwCMsuSRZKjyxndrTmRFvCENq1yZJOmlAXqb99W8=;
        b=U26VHn4+K8+8vs89sP9CvlAplu0tFTvrlEPP8e1JL90l3MAOY2tyrqnRpc1mh4tkaE
         MXIvIKooyx6HhjsA0W4i2kHq7iTb+pdTgLwcEVk873Raw02i9KG/EGKO4K435Jq4nEWe
         x7T+HuVF3seVhTfsY3q8N5FXjxh5TUrEIvhgq/SZvZk04UJR8TMymtucxclh6rKvT54q
         JhZb9iEDg3ZccnFjJX0Uljzst3LFvuez/xr/6uoUA5R9+AXKpoqxH9itXpiI6H+BqAj8
         NpWygxvWI/LPsi/ZJ7rdJqNFk6r7BeBsd4FYTSU7/0ADDFSO/YC9OuC2rBZjVySuhZAv
         vVBw==
X-Gm-Message-State: AOJu0Yz0bff94514yXveQkzevLrei6kJ8SJ0M4hOftel4YxJ95moyiu+
	NSoPVYOm0cG2NLvpo2dfEwAqeRGRODU7DM4l9+dJwcyTUz9NCIPZdJzWHo7BMg==
X-Gm-Gg: AeBDiesbgUfjMGTHooM8zd+qKhGsJZfvYEkfNod1XEXKF+qrwpAfiJEJv5n3jtoLY0F
	lJ/W0ijOMcQd+nBjsPsWm4E2GtWwR14yMDqDe0TWRF7iuJK9kTnszvKNgQ9D0Ucs31v2zv1/SWh
	KR6zgDGQk2WQV+xHHXPDoxBOLSY4KmyjI1HGAxNpTrvMj4LxC3ZNmsQWXOF2Na+xX3V9BwfmRAW
	VzXjrtnQR9hpJYj+YaukP51PF8xfGFwR1KB8aPn3DcdYHcJjMB5fJLapOmlPnfHgW55tfxHr5Mh
	DQtxuKrFBBENlEZyC1zNsKHejEis8ZU8LZ62f9ZH23Hhq61MngCsDQNqfPb8y8T1Npb6VJOyA+j
	8OVO1IId97NaJUweies9PAtwDiJ41voAIcdVODD41qLCUL2YX0ww6e/oUuOQhTyERpKTocy/rUW
	+QTkSTGqdqWmKcHnGQZ+O2xP7juONHss5QSTSzNfY=
X-Received: by 2002:a05:600c:8586:b0:489:e49:f766 with SMTP id 5b1f17b1804b1-4890e49f7d8mr213607325e9.17.1776988139971;
        Thu, 23 Apr 2026 16:48:59 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:e8d7:434e:1f34:2cb6])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-488fb7a0b60sm161135075e9.17.2026.04.23.16.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 16:48:59 -0700 (PDT)
From: luca.boccassi@gmail.com
To: kexec@lists.infradead.org
Cc: linux-mm@kvack.org,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Boccassi <luca.boccassi@gmail.com>
Subject: [PATCH v10 3/4] liveupdate: add LIVEUPDATE_SESSION_GET_NAME ioctl
Date: Fri, 24 Apr 2026 00:44:22 +0100
Message-ID: <20260423234753.3873095-4-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260423234753.3873095-1-luca.boccassi@gmail.com>
References: <20260423234753.3873095-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260423_164902_227724_087E110F 
X-CRM114-Status: GOOD (  16.61  )
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
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
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
index 5e316a4c5d71..0bcf2def074e 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -289,10 +289,21 @@ static int luo_session_finish(struct luo_session *session,
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
@@ -319,6 +330,8 @@ static const struct luo_ioctl_op luo_session_ioctl_ops[] = {
 		 struct liveupdate_session_preserve_fd, token),
 	IOCTL_OP(LIVEUPDATE_SESSION_RETRIEVE_FD, luo_session_retrieve_fd,
 		 struct liveupdate_session_retrieve_fd, token),
+	IOCTL_OP(LIVEUPDATE_SESSION_GET_NAME, luo_session_get_name,
+		 struct liveupdate_session_get_name, name),
 };
 
 static long luo_session_ioctl(struct file *filep, unsigned int cmd,
-- 
2.47.3


