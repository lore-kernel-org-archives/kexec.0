Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDC9F99C86
	for <kexec@archiver.kernel.org>; Sat, 18 Apr 2026 14:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6rza78hFhc1kSDmkYveBJcp2jbvxMYnAbG9peR+TlDI=; b=qFV+6y8geCuMh1qUOrTUF0r8DF
	0SoicXBgcHnl4IHdlXB4yMKhTCcppdTn4sZFq4sWRSW8zwo3eFVwOR1rsozIoooIz/F2gQ19k7QvZ
	YOjCFetEsT1MChZpi/W5kg4P0QW/ov7ygUQtLRhm2tqkkCG74OaMDlj9SMPre/KwLOBBp3WiWRTSI
	WI3Xkps3cfNN/+r1a1Tse0sb9HchlBv1idLDbT7043Po2mGoLA332sdEDlCtx5zXyT6HTKxMYbzxx
	FjUHtk+DHwnoTKVzVE8TNQ04l9bvd4TM+QU6ZskPmYiL3vLuGOQTtrE5y9hBQYDCuIiCxhISmWKNw
	DaeuZykw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE6OU-0000000518h-3kiA;
	Sat, 18 Apr 2026 14:11:34 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE6OR-0000000516i-0M1D
	for kexec@lists.infradead.org;
	Sat, 18 Apr 2026 14:11:32 +0000
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-488a29e6110so14181395e9.3
        for <kexec@lists.infradead.org>; Sat, 18 Apr 2026 07:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776521489; x=1777126289; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rza78hFhc1kSDmkYveBJcp2jbvxMYnAbG9peR+TlDI=;
        b=XmMpO5vLPRXG+DFLXF4XHWDvCzWpTeVFYZ/zfAx9ebRMGHZdV+nq6qBK4Jpl9RudO3
         QxQ/RA9vI+HZQjgab0aoopH8XMP9gJWjF6naF8FED2P81HvbQskUY5md2EAG8W72CxD0
         VAwAZh84qLMsC+SNYrTxuaH3YB8u6wRnNfgraDcENT+Bf76J9U+nkhr0poLoAWnlecq0
         h81n37SbFkmF0a4QPP/2bq4ZguuqSNMkVFHuttU+82PP4P9hDtAMjaPfFai6sYzNNs7o
         u3S539alNgWkd5fvrXzsdWXpteocP6B7yyiUAHLcyBsyjUgtIbiagQM0e6rB7S0wTROG
         SGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776521489; x=1777126289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6rza78hFhc1kSDmkYveBJcp2jbvxMYnAbG9peR+TlDI=;
        b=kCIdrREDqQqHfam0Wc0gYj0/w6oR4YpMf4XmQxOrYXxmRTlUl4boNXLUxRuG2p2W/H
         NiD6HEPCTP2vnvk5LbZGAM19CfzAyECVdM1JJcnt2LQhfB4hV3p6tEUU+lbGDJg/FRBH
         C0+CRCYZgtKEEV5C4kBj/b2oDc16uj0kCSGWra6JyAvixVI3C0RPZ9cbr7EVvJkIeZYm
         lTcUS6NB+N/jjPj2+0gsgA8pkaIUOnzJFsW3mGPoTJo+kgeAfdv7/Sb9wANnY3q3S0ii
         C8QskIATULphu0xD6wHqYLKX0l+pv80KV0b+IWJlgqKWpFhocmhznon1VOB5pgdV1J2b
         tmmg==
X-Gm-Message-State: AOJu0YxKZrb1vgWeP8mcbfLcDSawi/ySMCGAxWBCKSfCXA7nySO+9oRd
	pJ4jdGJwEQX7pB9sc00rj/9d73iJuQfUagvK5FNwVggFjrLz8ArKLBj3TwvXpw==
X-Gm-Gg: AeBDiev9sn1cWhUbZbAJHbs3QtzAFlWi9/KJfLvn9Plox7C/m5kB3vosS3L+ZPUANj7
	ZHX0NyMel0EVbsvr0KGVAmDRwGRlBDmQ6PoeaRAy5H6/jd66vUd8g9L9oTXEN5NuJmttXRUTV9d
	Gjhd5glxELzf6OMOk6fT1OuXngg3m+wJ26eLKj0tscTRvM+mXg/zSLFWGJTaJFx+V0wf1950uRn
	BWBiotQVXeg1SdVFQ+FS9bySzU8YLDHnBdzw/YDaFaAU4ImXuHBZ0PG/eEB0E2xW1vZjaArM3aM
	M8+fd+gD2QZqYNKmcW4YxNF7FqVLRse7UqS/PO5qROFwOp0D0VMrvzIHimXzrEUZ0XD/kaSFjZp
	HYIRh40+x5bwi00SiKY1/1YDNfcsWyt9swuYGM93e3E9DGiIiFo32Ff61lGR5qDnFDnAzxR9Id5
	HbTA89Gvy1luXU/VNcstLRyVs+Nj/eHB2xU0zp2Sw=
X-Received: by 2002:a05:600c:6211:b0:488:afb5:6a21 with SMTP id 5b1f17b1804b1-488fb77d0ccmr90612275e9.15.1776521488827;
        Sat, 18 Apr 2026 07:11:28 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:4429:3762:47dc:91a3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-488fc0f8188sm142663545e9.2.2026.04.18.07.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 07:11:28 -0700 (PDT)
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
Subject: [PATCH v7 3/4] liveupdate: add LIVEUPDATE_SESSION_GET_NAME ioctl
Date: Sat, 18 Apr 2026 15:09:39 +0100
Message-ID: <20260418141123.2193917-3-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260418141123.2193917-1-luca.boccassi@gmail.com>
References: <20260418141123.2193917-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260418_071131_148631_5BDB3A86 
X-CRM114-Status: GOOD (  17.45  )
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
index 1d35379e4e52..9b434470982c 100644
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


