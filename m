Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71D4F99C8C
	for <kexec@archiver.kernel.org>; Sat, 18 Apr 2026 16:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AT+C0FqKOy41gQ9Txc8mmA2gRVUT/8maFYBa2yrLvwY=; b=EMpcfnj9SaTMcR9XJxz48HOTc/
	Z8LoeDBoRnCli5KKmu+jUzTp7iagrv1Mvx4wdQvSPRBeTp33YoNwYFsPw/pPr3WRoQhGrRxfoRA15
	oqOabsutubVcJuGZy4bRrRZ93wL9q09JPp2wcxaU809jgEEOCuAEiXyslZSlptyk3v58M0kcAF+mJ
	DgbRqKof/pPNtg9BeULZVyNhuf/8cQe1EOM0gwar8y1/t2ZBkuI9o3iE8KnvThIiokByitxUDbyMt
	yNTvi1DKl965a7OhutwGlG9EKtjVLHrKLdh05oes3RAlo5op1p8dQwH7/tUNgSCNlBtqGpJSP1Ptk
	mE+8RcCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE8cl-000000055qI-3p5s;
	Sat, 18 Apr 2026 16:34:27 +0000
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE8ck-000000055oI-0scV
	for kexec@lists.infradead.org;
	Sat, 18 Apr 2026 16:34:27 +0000
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-488a4bc360bso10127225e9.0
        for <kexec@lists.infradead.org>; Sat, 18 Apr 2026 09:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776530064; x=1777134864; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AT+C0FqKOy41gQ9Txc8mmA2gRVUT/8maFYBa2yrLvwY=;
        b=FApA2Qs6h7QDsDuxk+DJuWV6h7Q10g0ZY6QBu5BQNcSN2Jr2LEkR4TF7C8n8xrfkY/
         OKdKo9ghwcewxSumJgOy8Yrc5fOTZTuV/Ro4MV71Yj2NgnXgr/xeACAmLnZPJqHC1zC+
         oN2/SwwsTouPAelD/wGHd0WYFcetr0Xt34IaLzSMZYWUyeIT9NdPGlVXkByStZDi3gjp
         YFRjgVqpBNqSC9gaZEMXaqTbPx5rVzyTdR6MDvHeYIR5FH44rfzXkyup8rBVmdaWLFyP
         vV+zXARwrWxLozYxTpQior/mY0pfPR9KtoyRgaPBCX8XBvHtcxEa4Mv7vVftYAREhhw2
         q9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776530064; x=1777134864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AT+C0FqKOy41gQ9Txc8mmA2gRVUT/8maFYBa2yrLvwY=;
        b=BFa69PakC1An8hfI//oEAd2SoHd8Jwjo63IrIbGOFrVD+RRqLb73wwAQEwUG17DpDR
         EHnPzlL75AcJirvxUFmXnmzhPiJoraxkJcnS1FaN77hsGRlSLRf/wfUUK0byz6LIa6an
         PwMmpdFdGR5AlAS19cflF6pAfvQPSvjszLmx0O/nclSJla/tRh13AYEl2pANkIY20C3z
         9pskfxAQNC8xq/tck/EUvzO/5hoO5DRhVigSP5EuYfCcDIYN91RCGoeKF2u4dZn3cpm3
         tGWEST0RM6NKk38/F2OUqnnAWyTyTJJMusijgqEE5Xe0p6XfJKB7B/n73WT/lW0bQvu2
         lsIQ==
X-Gm-Message-State: AOJu0YxbfScRteZiNpJDiHjYC2BjqFtgna3PQuSQJ8Lk+k5tvJNuCtn6
	5fNdm2WrpCEbwApdjRqilN/fg1u/oHDHP+Fgqegc2BUQ4XEgbq3LmcOWEVNyCA==
X-Gm-Gg: AeBDieuWNKFRv2em69C1HKntl1rcWYKqhQyafyxYNCiFGPWxWtR1VLGijxKn1sBcWz0
	PvQQEv9CO6sCp9GBxS7EV9DmVHmHGwc9lUKys3XEJO8FCWnCmkGtw4Zd5Nxs/1U8fEzGvh67MEp
	Lx+FKY6bQQdMNObx3oFmdZneyC1ACz7tV8Fp46M6POyJG9WWFdka/9LATrcg+/rDHREpvpl5Dvt
	kG4tEBsqsiQJLJLo/9rtiLE6Yy8KDxk6Yp3KGb5Qa1gVdnZGmXOxDEjo/GtI/Tx7FZXWXqPC4e2
	K9BZ44sdMqhzswfRvsxPQrS7H3q6YIY35FEzaB2d4HOch3REy6XVio3HqOSF3zKEDfE24SfJAUy
	I4cwR1FduCSrIJ4/RKGS+1L62zgE+dmUMx4dyQeZKpbXSl2sISg72EdXSXYmCw4xHDz6bGpFe+L
	540woxoFEoqcnt2k8aeRkGgnWGbFKOkbZXI+/RIaI=
X-Received: by 2002:a05:600c:5294:b0:486:fa35:aef2 with SMTP id 5b1f17b1804b1-488fb73d53bmr97024485e9.4.1776530063979;
        Sat, 18 Apr 2026 09:34:23 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:e054:93f2:97bf:84c6])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-488fb7a0b54sm44316065e9.20.2026.04.18.09.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 09:34:23 -0700 (PDT)
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
Subject: [PATCH v8 5/6] liveupdate: add LIVEUPDATE_SESSION_GET_NAME ioctl
Date: Sat, 18 Apr 2026 17:28:22 +0100
Message-ID: <20260418163358.2304490-6-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260418163358.2304490-1-luca.boccassi@gmail.com>
References: <20260418163358.2304490-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260418_093426_289010_04597D7E 
X-CRM114-Status: GOOD (  16.67  )
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
index 21cbe99fc819..ca5e44274dcb 100644
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


