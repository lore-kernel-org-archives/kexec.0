Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A62C531D0
	for <kexec@archiver.kernel.org>; Thu, 23 Jul 2026 20:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jKy1+xh3t540cHOpDayVgEdD7bHubSTIw9MAGeaiEnQ=; b=oaHFBUb0COyHUvD2Ft6ZWMEJSI
	IVDzplCyHKoPn64FuLDhhuVtIvIY/WXt2smgJ6uS4SZtgxgwWGAFfWZDJk48tOtl2GfhdOjciBZmW
	B4bjh6ShZkkLkZwbkxDWxm7lc5lJFffdeltTNhIkTnCWjfpm656JvU5ttCX1H150yL2gD5R1YVgGR
	yH7IJ6TA9X57ImsaATshib6Nj9J7wiDmQ9sbMQyLoKnnys2rXjLqJRu2EVqNQMxP0Z7Am0VjP+726
	VhzgCyXfj6dt/EL9gXcUNlm1/M+2SYyjCD8r/Z+VpxIo5zT+JBjrDayaTxKr+6YPqhJApf65nm0EU
	09Z5Pm8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn02v-0000000F2e5-0QWj;
	Thu, 23 Jul 2026 20:29:33 +0000
Received: from mail-pl1-x647.google.com ([2607:f8b0:4864:20::647])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn02r-0000000F2cy-2Typ
	for kexec@lists.infradead.org;
	Thu, 23 Jul 2026 20:29:30 +0000
Received: by mail-pl1-x647.google.com with SMTP id d9443c01a7336-2ce7dff6253so8349345ad.1
        for <kexec@lists.infradead.org>; Thu, 23 Jul 2026 13:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784838567; x=1785443367; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jKy1+xh3t540cHOpDayVgEdD7bHubSTIw9MAGeaiEnQ=;
        b=PMqXozfF6S23au1NbDpBgAo6nzBq5VlT3h+txh+03BWkC7vsY4NamKGQUMWXkbX8Dp
         BZYEWPvSk3CUutwMx0ZVLp8xjjg62FU65gISCJrtkwMUKoQA78ERt1DpUFN7BTDIAo1r
         MlfPcAtdk8VPlicFpPZhVKnRzrkvmzNh2x3HaOwCciLQm0SjEMlqkfb6PR0LvlhAKJUw
         yG5WeXy1aUycTKhsxbbyjzEfi7y0c1BlUrh//7YqHHKwuVUm4oJNWSbD8BeDZL/InIaP
         oy/fXcbFGEGoWfuYLJffVFFoqWQKdEaTX7k9eW58wF0OQccXUB/jrsyQYguc0W4nfZUq
         dxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784838567; x=1785443367;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jKy1+xh3t540cHOpDayVgEdD7bHubSTIw9MAGeaiEnQ=;
        b=j4T2Nd8UK5ttsGhPLqY2wiNDonsq4NLULYeSHuuc0wRqw3PlAQY/C7qR7W6PwNEkfA
         xXRkjpaVuLi51QyUSxxlRnw7DHPmPtrRNFHIHfrudSeANejxh8uQBGag7XX/bkZJIrr/
         P+DB3Zg790JlYEktyccmNUMP91Gwjw2647lsc7NxQbbdBeWaVqJai22OSClwCSnT1KXB
         t3cExjXy8xTxr84mHOiHfGmo+QLPONsn7x13yjbX5SjIojaJDS1xLxdkflESwRtBErq4
         MLNwvNY/6C/BgwVNCJ4Vmh/cNMAB72IsXlE1AUWdpx9bCyY6n8jjIzMnRgf5YDEhdqx9
         eKzA==
X-Forwarded-Encrypted: i=1; AHgh+RrLy6S6lzCeAB+qQ2vokMUpIB1y0R44EgOHdqwsXlFquB3y+c7ZmP4Pkb9K28gETbQqlYy1Mw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzv3Bck4mq+eY+5fwPq0MldSOQ7UtV6IY5kh9r40zbl+xsh0xLT
	8fKEXO9VbnElL+SOPbom9vqtCEX2vPpNJg+01cY8AeU88r5txvY1CpqePjdK5iQ6qdOGzhRuSeI
	onhpTEMk+KxOxjA==
X-Received: from plbka16.prod.google.com ([2002:a17:903:3350:b0:2cb:ea2b:5286])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e84f:b0:2ca:c847:8e41 with SMTP id d9443c01a7336-2cfa94b7aadmr48476855ad.11.1784838567356;
 Thu, 23 Jul 2026 13:29:27 -0700 (PDT)
Date: Thu, 23 Jul 2026 20:29:12 +0000
In-Reply-To: <20260723202912.1467112-1-skhawaja@google.com>
Mime-Version: 1.0
References: <20260723202912.1467112-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723202912.1467112-2-skhawaja@google.com>
Subject: [PATCH v2 1/1] liveupdate: luo_file: Add internal APIs for file preservation
From: Samiullah Khawaja <skhawaja@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: Pranjal Shrivastava <praan@google.com>, Samiullah Khawaja <skhawaja@google.com>, 
	David Matlack <dmatlack@google.com>, tarunsahu@google.com, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KEXEC HANDOVER (KHO)" <kexec@lists.infradead.org>, 
	"open list:KEXEC HANDOVER (KHO)" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_132929_653840_6B1CAB44 
X-CRM114-Status: GOOD (  23.71  )
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

From: Pasha Tatashin <pasha.tatashin@soleen.com>

Live update orchestrator file handlers depend on the preservation of
other files. To make sure that the dependency is preserved, the file
handlers needs to fetch the preservation token of the preserved
dependency. Similarly during restore, a file handler wants to fetch the
restored file of the dependency.

Add APIs that allows fetching token of dependency during preservation,
and fetching the restored file dependency during restore.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 include/linux/liveupdate.h       | 22 ++++++++++
 kernel/liveupdate/luo_file.c     | 69 ++++++++++++++++++++++++++++++++
 kernel/liveupdate/luo_internal.h | 17 ++++++++
 3 files changed, 108 insertions(+)

diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index 63ea5417de84..6051abc0612c 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -25,6 +25,7 @@ struct file;
 /**
  * struct liveupdate_file_op_args - Arguments for file operation callbacks.
  * @handler:          The file handler being called.
+ * @session:          The session this file belongs to.
  * @retrieve_status:  The retrieve status for the 'can_finish / finish'
  *                    operation. A value of 0 means the retrieve has not been
  *                    attempted, a positive value means the retrieve was
@@ -45,6 +46,7 @@ struct file;
  */
 struct liveupdate_file_op_args {
 	struct liveupdate_file_handler *handler;
+	struct liveupdate_session *session;
 	int retrieve_status;
 	struct file *file;
 	u64 serialized_data;
@@ -247,6 +249,14 @@ void liveupdate_flb_put_incoming(struct liveupdate_flb *flb);
 int liveupdate_flb_get_outgoing(struct liveupdate_flb *flb, void **objp);
 void liveupdate_flb_put_outgoing(struct liveupdate_flb *flb);
 
+/* kernel can internally retrieve files */
+int liveupdate_get_file_incoming(struct liveupdate_session *s, u64 token,
+				 struct file **filep);
+
+/* Get a token for an outgoing file, or -ENOENT if file is not preserved */
+int liveupdate_get_token_outgoing(struct liveupdate_session *s,
+				  struct file *file, u64 *tokenp);
+
 #else /* CONFIG_LIVEUPDATE */
 
 static inline bool liveupdate_enabled(void)
@@ -299,5 +309,17 @@ static inline void liveupdate_flb_put_outgoing(struct liveupdate_flb *flb)
 {
 }
 
+static inline int liveupdate_get_file_incoming(struct liveupdate_session *s,
+					       u64 token, struct file **filep)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int liveupdate_get_token_outgoing(struct liveupdate_session *s,
+						struct file *file, u64 *tokenp)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif /* CONFIG_LIVEUPDATE */
 #endif /* _LINUX_LIVEUPDATE_H */
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index 72f8bb90b66c..542707e8d8c1 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -293,6 +293,7 @@ int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
 	mutex_init(&luo_file->mutex);
 
 	args.handler = fh;
+	args.session = luo_session_from_file_set(file_set);
 	args.file = file;
 	err = fh->ops->preserve(&args);
 	if (err)
@@ -350,6 +351,7 @@ void luo_file_unpreserve_files(struct luo_file_set *file_set)
 					   struct luo_file, list);
 
 		args.handler = luo_file->fh;
+		args.session = luo_session_from_file_set(file_set);
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
 		args.private_data = luo_file->private_data;
@@ -383,6 +385,7 @@ static int luo_file_freeze_one(struct luo_file_set *file_set,
 		struct liveupdate_file_op_args args = {0};
 
 		args.handler = luo_file->fh;
+		args.session = luo_session_from_file_set(file_set);
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
 		args.private_data = luo_file->private_data;
@@ -404,6 +407,7 @@ static void luo_file_unfreeze_one(struct luo_file_set *file_set,
 		struct liveupdate_file_op_args args = {0};
 
 		args.handler = luo_file->fh;
+		args.session = luo_session_from_file_set(file_set);
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
 		args.private_data = luo_file->private_data;
@@ -596,6 +600,7 @@ int luo_retrieve_file(struct luo_file_set *file_set, u64 token,
 	}
 
 	args.handler = luo_file->fh;
+	args.session = luo_session_from_file_set(file_set);
 	args.serialized_data = luo_file->serialized_data;
 	err = luo_file->fh->ops->retrieve(&args);
 	if (err) {
@@ -629,6 +634,7 @@ static int luo_file_can_finish_one(struct luo_file_set *file_set,
 		struct liveupdate_file_op_args args = {0};
 
 		args.handler = luo_file->fh;
+		args.session = luo_session_from_file_set(file_set);
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
 		args.retrieve_status = luo_file->retrieve_status;
@@ -646,6 +652,7 @@ static void luo_file_finish_one(struct luo_file_set *file_set,
 	guard(mutex)(&luo_file->mutex);
 
 	args.handler = luo_file->fh;
+	args.session = luo_session_from_file_set(file_set);
 	args.file = luo_file->file;
 	args.serialized_data = luo_file->serialized_data;
 	args.retrieve_status = luo_file->retrieve_status;
@@ -935,3 +942,65 @@ void liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh)
 	luo_flb_unregister_all(fh);
 	list_del(&ACCESS_PRIVATE(fh, list));
 }
+
+/**
+ * liveupdate_get_token_outgoing - Get the token for a preserved file.
+ * @s:      The outgoing liveupdate session.
+ * @file:   The file object to search for.
+ * @tokenp: Output parameter for the found token.
+ *
+ * Searches the list of preserved files in an outgoing session for a matching
+ * file object. If found, the corresponding user-provided token is returned.
+ *
+ * This function is intended for in-kernel callers that need to correlate a
+ * file with its liveupdate token.
+ *
+ * Context: It must be called with session mutex acquired.
+ * Return: 0 on success, -ENOENT if the file is not preserved in this session.
+ */
+int liveupdate_get_token_outgoing(struct liveupdate_session *s,
+				  struct file *file, u64 *tokenp)
+{
+	struct luo_file_set *file_set = luo_file_set_from_session_locked(s);
+	struct luo_file *luo_file;
+	int err = -ENOENT;
+
+	list_for_each_entry(luo_file, &file_set->files_list, list) {
+		if (luo_file->file == file) {
+			if (tokenp)
+				*tokenp = luo_file->token;
+			err = 0;
+			break;
+		}
+	}
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(liveupdate_get_token_outgoing);
+
+/**
+ * liveupdate_get_file_incoming - Retrieves a preserved file for in-kernel use.
+ * @s:      The incoming liveupdate session (restored from the previous kernel).
+ * @token:  The unique token identifying the file to retrieve.
+ * @filep:  On success, this will be populated with a pointer to the retrieved
+ *          'struct file'.
+ *
+ * Provides a kernel-internal API for other subsystems to retrieve their
+ * preserved files after a live update. This function is a simple wrapper
+ * around luo_retrieve_file(), allowing callers to find a file by its token.
+ *
+ * The caller receives a new reference to the file and must call fput() when it
+ * is no longer needed. The file's lifetime is managed by LUO and any userspace
+ * file descriptors.
+ *
+ * Context: It must be called with session mutex acquired of a restored session.
+ * Return: 0 on success. Returns -ENOENT if no file with the matching token is
+ *         found, or any other negative errno on failure.
+ */
+int liveupdate_get_file_incoming(struct liveupdate_session *s, u64 token,
+				 struct file **filep)
+{
+	return luo_retrieve_file(luo_file_set_from_session_locked(s),
+				 token, filep);
+}
+EXPORT_SYMBOL_GPL(liveupdate_get_file_incoming);
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index 64879ffe7378..dac6644bfb18 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -77,6 +77,23 @@ struct luo_session {
 
 extern struct rw_semaphore luo_register_rwlock;
 
+static inline struct liveupdate_session *luo_session_from_file_set(struct luo_file_set *file_set)
+{
+	struct luo_session *session;
+
+	session = container_of(file_set, struct luo_session, file_set);
+
+	return (struct liveupdate_session *)session;
+}
+
+static inline struct luo_file_set *luo_file_set_from_session_locked(struct liveupdate_session *s)
+{
+	struct luo_session *session = (struct luo_session *)s;
+
+	lockdep_assert_held(&session->mutex);
+	return &session->file_set;
+}
+
 int luo_session_create(const char *name, struct file **filep);
 int luo_session_retrieve(const char *name, struct file **filep);
 void __init luo_session_setup_outgoing(u64 *sessions_pa);
-- 
2.55.0.229.g6434b31f56-goog


