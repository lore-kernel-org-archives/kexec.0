Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB79C624D3
	for <kexec@archiver.kernel.org>; Tue,  1 Sep 2026 18:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=falXxVt1CqmyncILPaUG22UQuDMsfEGdQdvwDGt8XFI=; b=at6cnoUFhNLko657u+9B6Dbd0+
	OZQPK80RMZvp9/2sGxjOO0wDlM15gnTAyB9KlHN0Svld4RoGQu3iE9QRPmwxo/NTc7MsKMC0xESJZ
	fiKBOojLMVeGFpVabztNjO06x2En9SmHpObi6jgJLLTr3umbWZlBfzFCDS+IUeMPFxDQK7fn0QMaP
	jW6d5kzzCHXuE4T2InSAEXrjNWF5YJKTQsxw3N9KIGCW3cMjQhRgsXq/XvN67sBB6y+DUKHdBPor+
	vcimFkalM7CnYeYJ1tRQGPeIAby1pRcSxaUUpJ0l6nbq7ws8J2a5hKmJR4V0j55SwC00wR+vBuk0M
	QbkhCbDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1StS-0000000CuwZ-2F9h;
	Tue, 01 Sep 2026 18:07:34 +0000
Received: from mail-pl1-x648.google.com ([2607:f8b0:4864:20::648])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1StO-0000000CutI-1H0Q
	for kexec@lists.infradead.org;
	Tue, 01 Sep 2026 18:07:31 +0000
Received: by mail-pl1-x648.google.com with SMTP id d9443c01a7336-2d94a158dc8so1098275ad.2
        for <kexec@lists.infradead.org>; Tue, 01 Sep 2026 11:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788286046; x=1788890846; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=falXxVt1CqmyncILPaUG22UQuDMsfEGdQdvwDGt8XFI=;
        b=shLD7t06H6j562CuYin8YLWj0Ha6hrdDnb2MeaUBksgMQv+Ii3GL8lyTauDHJubjzr
         O85QouedA//ZvIVfMkBLyTO83rg1AxIZQJK0Az8TEqqpTtF9/qM9H+aY4uSoZLD7doXm
         lzxzW0S51N8bzMxlevST8bxJR77w6OxAMTqZb7+PxJsdD8OoXsejDg4t+/cd+g7wDfYJ
         Fr+0BUiikUcWBAMLskOivSvNhc3Enxmq47DGhyxcMLeajqO3PyYg22IPBp4AxSJVEGQ3
         P8Jw9DVQu/yBLsVVb++eX7M/HTKuXRDM7Jqe1rnRi7mmI9nDyhthxm21DSPjKRU6fghJ
         mrNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788286046; x=1788890846;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=falXxVt1CqmyncILPaUG22UQuDMsfEGdQdvwDGt8XFI=;
        b=jvqxkEi7zFkJzL9rCkzMafRPSlAOqENypDGh9XFcsQ/IYlqW0Ts8wF8ReJBziXTftk
         vEu3LCwGaOsMVQnEs6xNSCGANgTLOkD1noyaQzjdsQ282s6twMULEY46x+Qmqcqqcj0V
         vWnAxV6XUKRX1ms35TfzWZ7Oq7d0dGLV0bZMyWqbJARxHja6H+2PIgKGjnYLJe9w7ML8
         wlTyV8h46sDb2Z9BkwTHUlhzYmhugrM5qENkn7y0l9QQewImS5+AowFySxmZ1iil8nSP
         Fnvo7mLArJQHbFDz6Z1OoFuDZ0OIs0p97vSVx0JRk/OTT8qu5/tkMgC2hZaXZOCU5NG5
         PMtQ==
X-Gm-Message-State: AFuF++lnsw1r7rCxFqfzi0/gsg/nSqmrt0F2/1vb8UG/YQPPeczsKeQg
	ZokrueK4m0grYxhh9YdPcOcQ9k0UefS2H+gocR7tlYv5gmt81OHvjiFScqSbDsrVZPzpcT83a/C
	rvLXruKxDCNZttPTNVPdN9OaIFspaOqUr7K8DqVvr3NJjfJ+M1W2We/ZSE9EVn6IF/QNo1RWfsD
	J6rEaNB6BkbrHCc6vVo0LMmS6PxgoogTjvez1I5UHJIlaVdMcjJCc=
X-Received: from pjyv9.prod.google.com ([2002:a17:90a:e989:b0:396:5ba1:a6dc])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3c44:b0:398:dcef:c040 with SMTP id 98e67ed59e1d1-398dcefc24amr26801689a91.19.1788286045592;
 Tue, 01 Sep 2026 11:07:25 -0700 (PDT)
Date: Tue,  1 Sep 2026 18:07:10 +0000
In-Reply-To: <20260901180713.4185641-1-dmatlack@google.com>
Mime-Version: 1.0
References: <20260901180713.4185641-1-dmatlack@google.com>
X-Mailer: git-send-email 2.55.0.966.g6673acef38-goog
Message-ID: <20260901180713.4185641-3-dmatlack@google.com>
Subject: [RFC PATCH 2/5] liveupdate: Introduce SESSION_RETRIEVE_INTO_FD API
 and core support
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260901_110730_564598_CCFA8A5B 
X-CRM114-Status: GOOD (  20.46  )
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

Define the LIVEUPDATE_CMD_SESSION_RETRIEVE_INTO_FD ioctl in the UAPI and
implement the core support into LUO sessions. Add a new .retrieve_into()
callback definition to struct liveupdate_file_handler but do not yet
implement it for any file types.

Delegating VFS topology recreation to userspace across Live Updates
requires an interface where userspace can provide an empty target file
descriptor, and the kernel can inject preserved memory into it. This API
supplies that missing routing. It uses the new luo_retrieve_into_file()
helper to safely look up tracking structures without duplicating backend
locks.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 include/linux/liveupdate.h       |  1 +
 include/uapi/linux/liveupdate.h  | 21 +++++++++++++++++++
 kernel/liveupdate/luo_file.c     | 36 ++++++++++++++++++++++++++++++++
 kernel/liveupdate/luo_internal.h |  2 ++
 kernel/liveupdate/luo_session.c  | 30 ++++++++++++++++++++++++++
 5 files changed, 90 insertions(+)

diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index 63ea5417de84..7b595e0f53bc 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -79,6 +79,7 @@ struct liveupdate_file_ops {
 	int (*freeze)(struct liveupdate_file_op_args *args);
 	void (*unfreeze)(struct liveupdate_file_op_args *args);
 	int (*retrieve)(struct liveupdate_file_op_args *args);
+	int (*retrieve_into)(struct liveupdate_file_op_args *args, struct file *target_file);
 	bool (*can_finish)(struct liveupdate_file_op_args *args);
 	void (*finish)(struct liveupdate_file_op_args *args);
 	unsigned long (*get_id)(struct file *file);
diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveupdate.h
index 4043d4038712..ed2049529cc0 100644
--- a/include/uapi/linux/liveupdate.h
+++ b/include/uapi/linux/liveupdate.h
@@ -59,7 +59,11 @@ enum {
 	LIVEUPDATE_CMD_SESSION_PRESERVE_FD = LIVEUPDATE_CMD_SESSION_BASE,
 	LIVEUPDATE_CMD_SESSION_RETRIEVE_FD = 0x41,
 	LIVEUPDATE_CMD_SESSION_FINISH = 0x42,
+
 	LIVEUPDATE_CMD_SESSION_GET_NAME = 0x43,
+
+	LIVEUPDATE_CMD_SESSION_RETRIEVE_INTO_FD = 0x44,
+
 };
 
 /**
@@ -184,6 +188,23 @@ struct liveupdate_session_retrieve_fd {
 #define LIVEUPDATE_SESSION_RETRIEVE_FD					\
 	_IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_SESSION_RETRIEVE_FD)
 
+/**
+ * struct liveupdate_session_retrieve_into_fd - ioctl(LIVEUPDATE_SESSION_RETRIEVE_INTO_FD)
+ * @size:  Input; sizeof(struct liveupdate_session_retrieve_into_fd)
+ * @fd:    Input; The open file descriptor (e.g. empty tmpfs file) to inject the resource into.
+ * @token: Input; An opaque, token that was used to preserve the resource.
+ *
+ * Retrieve a previously preserved file descriptor into an existing file descriptor.
+ */
+struct liveupdate_session_retrieve_into_fd {
+	__u32		size;
+	__s32		fd;
+	__aligned_u64	token;
+};
+
+#define LIVEUPDATE_SESSION_RETRIEVE_INTO_FD					\
+	_IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_SESSION_RETRIEVE_INTO_FD)
+
 /**
  * struct liveupdate_session_finish - ioctl(LIVEUPDATE_SESSION_FINISH)
  * @size:     Input; sizeof(struct liveupdate_session_finish)
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index 5e160836a165..c4abfd25e149 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -932,3 +932,39 @@ void liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh)
 	luo_flb_unregister_all(fh);
 	list_del(&ACCESS_PRIVATE(fh, list));
 }
+
+int luo_retrieve_into_file(struct luo_file_set *file_set, u64 token,
+			   struct file *target_file)
+{
+	struct liveupdate_file_op_args args = {0};
+	struct luo_file *luo_file;
+	int err;
+
+	luo_file = luo_find_file_by_token(file_set, token);
+	if (IS_ERR(luo_file))
+		return PTR_ERR(luo_file);
+
+	guard(mutex)(&luo_file->mutex);
+	if (luo_file->retrieve_status < 0)
+		return luo_file->retrieve_status;
+
+	if (luo_file->retrieve_status > 0)
+		return -EBUSY; /* Already retrieved */
+
+	if (!luo_file->fh->ops->retrieve_into)
+		return -EOPNOTSUPP;
+
+	args.handler = luo_file->fh;
+	args.serialized_data = luo_file->serialized_data;
+	err = luo_file->fh->ops->retrieve_into(&args, target_file);
+	if (err) {
+		luo_file->retrieve_status = err;
+		return err;
+	}
+
+	luo_file->file = target_file;
+	get_file(luo_file->file);
+	luo_file->retrieve_status = 1;
+
+	return 0;
+}
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index 64879ffe7378..1af9aebe6623 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -92,6 +92,8 @@ void luo_file_unfreeze(struct luo_file_set *file_set,
 		       struct luo_file_set_ser *file_set_ser);
 int luo_retrieve_file(struct luo_file_set *file_set, u64 token,
 		      struct file **filep);
+int luo_retrieve_into_file(struct luo_file_set *file_set, u64 token,
+			   struct file *target_file);
 int luo_file_finish(struct luo_file_set *file_set);
 int luo_file_deserialize(struct luo_file_set *file_set,
 			 struct luo_file_set_ser *file_set_ser);
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index f48e9a4185f9..2b967f720ef5 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -278,6 +278,34 @@ static int luo_session_preserve_fd(struct luo_session *session,
 	return err;
 }
 
+static int luo_session_retrieve_into_fd(struct luo_session *session,
+					 struct luo_ucmd *ucmd)
+{
+	struct liveupdate_session_retrieve_into_fd *argp = ucmd->cmd;
+	struct fd target_fd;
+	int err;
+
+	target_fd = fdget(argp->fd);
+	if (fd_empty(target_fd))
+		return -EBADF;
+
+	guard(mutex)(&session->mutex);
+	err = luo_retrieve_into_file(&session->file_set, argp->token, fd_file(target_fd));
+	if (err < 0)
+		goto err_put_fd;
+
+	err = luo_ucmd_respond(ucmd, sizeof(*argp));
+	/*
+	 * If we fail to respond, we cannot easily undo the retrieval. Let the
+	 * normal session cleanup logic handle the file reference eventually.
+	 */
+
+err_put_fd:
+	fdput(target_fd);
+
+	return err;
+}
+
 static int luo_session_retrieve_fd(struct luo_session *session,
 				   struct luo_ucmd *ucmd)
 {
@@ -382,6 +410,8 @@ static const struct luo_ioctl_op luo_session_ioctl_ops[] = {
 		 struct liveupdate_session_retrieve_fd, token, LUO_IOCTL_INCOMING),
 	IOCTL_OP(LIVEUPDATE_SESSION_GET_NAME, luo_session_get_name,
 		 struct liveupdate_session_get_name, name, LUO_IOCTL_ALL),
+	IOCTL_OP(LIVEUPDATE_SESSION_RETRIEVE_INTO_FD, luo_session_retrieve_into_fd,
+		 struct liveupdate_session_retrieve_into_fd, token, LUO_IOCTL_INCOMING),
 };
 
 static bool luo_ioctl_type_valid(struct luo_session *session,
-- 
2.55.0.966.g6673acef38-goog


