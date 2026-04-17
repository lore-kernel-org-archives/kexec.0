Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC7C2F99C6E
	for <kexec@archiver.kernel.org>; Fri, 17 Apr 2026 22:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rfVXq5XnN78PoGksRH9ezngJ4gBemo0ZzDaOi04WyAo=; b=qh88W2DzjGkwYE3jHFkwTIWd6X
	lIX6CwluJnTtLtRBTpvm2YgkA0JaoFwVu/4MVVoNsUsDXRk5Rk4Ntu2X1U2po56gjDWDmQzVYhh+7
	/JmDMNZsnB+SqeQqAzJ+nuEpmwSjum61SzCi+C14izpch1ElWBPTCd0MLiqIXpopCiTMnRKdANBP8
	JtS+RqvOjgVrjq5CxI3bAl5srBoPqcNTBEMZkU1Xh5fWN1pqQGOM6j/JWFefdyLnfPpXnid2Jj5Dd
	8mG5JvbUwaBD+kp7ygNGcw6WEv8gY07yAvnK3uc/XEaNvr7g53Z5VFSzHhijWRETqaj7peiG29jvA
	LAd+dDeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDrMi-00000004Vmw-3vPZ;
	Fri, 17 Apr 2026 22:08:44 +0000
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDrMg-00000004VlF-1pMp
	for kexec@lists.infradead.org;
	Fri, 17 Apr 2026 22:08:43 +0000
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-488afb0427eso14104935e9.1
        for <kexec@lists.infradead.org>; Fri, 17 Apr 2026 15:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776463720; x=1777068520; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfVXq5XnN78PoGksRH9ezngJ4gBemo0ZzDaOi04WyAo=;
        b=tFOzyhUk9w7f52Lrh1c/d4aL98K2M0ZxTZ0ajvxdYZzq82LneVN5dHYyYem3VUUd/f
         nybeVonoahQ3UF6cOneR6gVvYwKeNah43LOsexZrkLGQyoEYW333VKNwidwmDr/gjqA9
         vC1/vtUo3B1cqJO2XOKyulEayHsRwS8ax/wdA9AIGUzPuQ0dKakifN1LXydLmvdWteQo
         j7BgbcTsEFK2MpkbhWqxLXIJuyk5nGBAI2zZbgMSqJj3/9opFe5R9sSZUDvAzPmO8Kse
         GdhtFzXpWqWcI12SX9KF2CxwXEJ5X508vMs960QO11pj8An/CYW8mazQstTc7yePCuM9
         I2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776463720; x=1777068520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rfVXq5XnN78PoGksRH9ezngJ4gBemo0ZzDaOi04WyAo=;
        b=aHw55XCDb59uNuTJeck56HckG0nhPqSaJWgqtM+zQ56xJMajuBw0DbKZ1I9oNIYcp+
         8AIhFRGW+jC+6y69KGhuql9YHJaHjZHvghgpkGZK6ifBCni+sp33SzBCsO4rLL4l1PAc
         Cbscp20Q4aVbm6ObqI4AliC8qebItfCc9xLAfO1kxjM09cEMjq4Cqny+QL8yQljQEddr
         k7+9A83UtursYTlXLKYMOk9xFxqSnsuG77rNef+VK+GDODy77kY4WLNYMs35cmnFoKj1
         2a79GI2X170Ilgw7QWM3Un6ghxj4IPTWouPW7p4tGoOhVWwEDsOxb9MXQTQI/l966jA5
         ttAQ==
X-Gm-Message-State: AOJu0YxxCzoYYPTnwG5lbuHXCCOvZna8pGotSIcPl/tOjch4/aqebfJi
	JLQN1SC9t8t3pS0tMeNtqppLsi1FMfbsjRS+8RSU8/ZuFjpH6NPU75YYmc2vdg==
X-Gm-Gg: AeBDieuajSOsZWHgimONYY/tTHY7YEt4OckRStR6jqesteBt/OKUcIVxkvnYPgP3SSM
	SgcXUu3D9YoN2N6mYaHO4pE9oSL7xAm1mvTA2rUTzP3FR0c6i7HA6pVq34EXHejx5W7EXWOFB+6
	Vffy/gMPCbq1XbWoTeijIySGG3vgSsHz76LdzmKPe4gKV3yaj1i0b6ihdP5MQgVqbyRa3X+QAr+
	MCKGlRfzMUDcyec0zekkbsxBJY4omBNSFfOQkxc1p1Qy1deuazNIgjV0Uf7J+Z7FsVwjzVXVjTw
	aMp+8825OLuC1P8etm/okrzS8dkQf7A1fkp+gJW2dFpBlW06hGd7Vfjtj/mIfGc8vpFzwD+FZrU
	H2vQCD5Ml7dL2gcyH+TwMSM9TW8V2sjdfatTfdQaYYQYwoLb5DAOAhCTdM8S83AgQK1y+gN2LFY
	mQi3RByvRSy+dROVzKAtxVS6hcKRdEqH9sFJ65Hdc=
X-Received: by 2002:a05:600c:3483:b0:486:fba7:b150 with SMTP id 5b1f17b1804b1-488fb7787d7mr59688365e9.15.1776463720169;
        Fri, 17 Apr 2026 15:08:40 -0700 (PDT)
Received: from localhost ([2a01:4b00:d036:ae00:9586:30a1:a0a6:f076])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-488fb75c695sm25728145e9.14.2026.04.17.15.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 15:08:39 -0700 (PDT)
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
Subject: [PATCH v5 3/4] liveupdate: add LIVEUPDATE_SESSION_GET_NAME ioctl
Date: Fri, 17 Apr 2026 23:05:44 +0100
Message-ID: <20260417220831.1934945-3-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260417220831.1934945-1-luca.boccassi@gmail.com>
References: <20260417220831.1934945-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260417_150842_616435_B5B6147A 
X-CRM114-Status: GOOD (  17.02  )
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

 include/uapi/linux/liveupdate.h | 20 ++++++++++++++++++++
 kernel/liveupdate/luo_session.c | 13 +++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveupdate.h
index 30bc66ee9436a..079ee6afb15a7 100644
--- a/include/uapi/linux/liveupdate.h
+++ b/include/uapi/linux/liveupdate.h
@@ -59,6 +59,7 @@ enum {
 	LIVEUPDATE_CMD_SESSION_PRESERVE_FD = LIVEUPDATE_CMD_SESSION_BASE,
 	LIVEUPDATE_CMD_SESSION_RETRIEVE_FD = 0x41,
 	LIVEUPDATE_CMD_SESSION_FINISH = 0x42,
+	LIVEUPDATE_CMD_SESSION_GET_NAME = 0x43,
 };
 
 /**
@@ -213,4 +214,23 @@ struct liveupdate_session_finish {
 #define LIVEUPDATE_SESSION_FINISH					\
 	_IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_SESSION_FINISH)
 
+/**
+ * struct liveupdate_session_get_name - ioctl(LIVEUPDATE_SESSION_GET_NAME)
+ * @size:  Input; sizeof(struct liveupdate_session_get_name)
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
index 5e315cc0dfd52..f30151c37bd43 100644
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


