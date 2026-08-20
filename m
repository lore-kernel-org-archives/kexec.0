Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D2FDC5DF8F
	for <kexec@archiver.kernel.org>; Thu, 20 Aug 2026 19:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fQ+SSW2xYaWYPCjZNKHlYzGG7Cn/26PBkUG+IbsFEFI=; b=O9JC2FfdD0wPBPpYlZOsRJr+BJ
	3YL+eX3UXllAWtRWGkxYY+LpLJMdovL+dwk6OkllTWwof2obcSu4/N0mal6GY0IXkw+eygK0fQGCe
	T6UKUfKvHH0rveBroAoQBRdDvGhBk3AZuQkjRI5VEboHzfsFlryAqJU/LHlSkgXnyvoUZxURqe354
	dZ8KTba3oEyfiYaA6feMcZ8FaOKHRLRICREAwf6nianDy0hw3vciWroGc6xHrGgPjuIlmQUIVN9vK
	QkkDkdyxWEb+YV3B6V/hmiRnOy+CTPh4E2TXrbOizHzHY/SRSo6kxy/IV+jvUf0jKNywTeQsVmm4y
	6vq1MT/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wx8I9-0000000C6TZ-3gQB;
	Thu, 20 Aug 2026 19:19:09 +0000
Received: from mail-pg1-x546.google.com ([2607:f8b0:4864:20::546])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wx8I7-0000000C6Sq-0qWT
	for kexec@lists.infradead.org;
	Thu, 20 Aug 2026 19:19:08 +0000
Received: by mail-pg1-x546.google.com with SMTP id 41be03b00d2f7-cc12e8e22b7so478420a12.0
        for <kexec@lists.infradead.org>; Thu, 20 Aug 2026 12:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787253545; x=1787858345; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fQ+SSW2xYaWYPCjZNKHlYzGG7Cn/26PBkUG+IbsFEFI=;
        b=sFhToUWoVlKBSraDYuqBUHQjJo8H7fwHKa90Y+57EZdmwcBYUGlpH4fOxCHERe971e
         V9B4wbRfibFydvacbMsH1tC3VU7WQzZPxDz2ca9HEdpNEEXalL2ll9OVl+wJFU1ji8H6
         Suz0arlMblQhBV21YJfDsSIn5CU1l+jRsSLHa9wGf/53jm6x6l2OKZzRawWxdJ6dsEMV
         S+99+5LHt9kQ0Qgs6dSIKEfzbcjVyCUcDLUd2p9fKaI4OGz2NB1+p4uXTxpBZXtLxvzj
         +ZKl2Rd96SyRN3iYUVu4lRX3cvS3mvPAnGw2SInJc+au2+ZAN2MKTPwptKugHVOmU96J
         ohIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787253545; x=1787858345;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fQ+SSW2xYaWYPCjZNKHlYzGG7Cn/26PBkUG+IbsFEFI=;
        b=EcAvzBL4azAQSvn5bau2OExaE2c64XL+dKf7abHTarHBBMkBdR3sfKvmNess2Txv/X
         npCLitFUufBvUQLbWJZX+NXMU2CqwtkAy8SwFavjUUvGHfzqyY8uVgs0UZ6Cnnt80w2D
         v0pydbcOaZeb62104MCdaotpiNCjw6HscMTxneWMkQ8PrAbVliTeWUL1th9uIPTwd4Ql
         ncgOu6u9fZ5Fg6JBsQPy7o4KudOC54NThL0tYdb/ojj/TnFpbEUc4lbK0CrDDT9ZSBau
         viNMeFWN0vonC7B9eGRl2PCbTxe1Gh0AUXi7sjuLYC8GLZU1veg3Qfy4M2edH+BNHXBZ
         ekEA==
X-Forwarded-Encrypted: i=1; AHgh+RqO0dXmLxtW7FTBEvrAHUgKilBCfL+bevuQjQ+oyJ8JZ6RIvcRMliGQqjU8hU0Dnzdu8kcscA==@lists.infradead.org
X-Gm-Message-State: AOJu0YywXNqlBmX88K8+hrGsy48u0cMNWUVgfAcAil3fiFSN6dGxTjcK
	NwdoyJUib5rtDC10BCB+NiZjByYsWlHaVPC9dQnqM9wP3niDG0eEf5yYgI1mjh5g9A0l3LwegFw
	SUk+ehv6C8JHnyA==
X-Received: from pgsb12.prod.google.com ([2002:a65:67cc:0:b0:cc1:4df5:5acb])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:4516:b0:3b2:a809:ffe with SMTP id adf61e73a8af0-3cd300901e1mr1395552637.14.1787253545341;
 Thu, 20 Aug 2026 12:19:05 -0700 (PDT)
Date: Thu, 20 Aug 2026 19:18:54 +0000
In-Reply-To: <20260820191854.1642931-1-skhawaja@google.com>
Mime-Version: 1.0
References: <20260820191854.1642931-1-skhawaja@google.com>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260820191854.1642931-2-skhawaja@google.com>
Subject: [PATCH v3 1/1] liveupdate: luo_file: Add internal APIs for file preservation
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
X-CRM114-CacheID: sfid-20260820_121907_253145_C0667B99 
X-CRM114-Status: GOOD (  27.35  )
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
 include/linux/liveupdate.h       | 22 +++++++++
 kernel/liveupdate/luo_file.c     | 84 ++++++++++++++++++++++++++++++++
 kernel/liveupdate/luo_internal.h | 17 +++++++
 3 files changed, 123 insertions(+)

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
index c39f96961a85..0a4994377c98 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -91,6 +91,21 @@
  *    again later. If the issue cannot be resolved, these resources will be held
  *    by LUO until the next live update cycle, at which point they will be
  *    discarded.
+ *
+ * Dependencies:
+ *
+ * Preserved files may have dependencies on other files that also need to be
+ * preserved during a live update. A file handler can resolve these dependencies
+ * by querying the token of the dependency. That token can then be serialized
+ * and used to fetch the dependency during the retrieve() callback in the next
+ * kernel.
+ *
+ * Some of these dependencies can be resolved late during File Handler freeze()
+ * callback, but some of these might need resolution during File Handler
+ * preserve() callback based on the constraints such as immutability and
+ * performance. This introduces an order of preservation. Note that the order of
+ * preservation of dependencies can be safely relaxed later, but it cannot be
+ * enforced later.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -284,6 +299,7 @@ int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd)
 	mutex_init(&luo_file->mutex);
 
 	args.handler = fh;
+	args.session = luo_session_from_file_set(file_set);
 	args.file = file;
 	err = fh->ops->preserve(&args);
 	if (err)
@@ -341,6 +357,7 @@ void luo_file_unpreserve_files(struct luo_file_set *file_set)
 					   struct luo_file, list);
 
 		args.handler = luo_file->fh;
+		args.session = luo_session_from_file_set(file_set);
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
 		args.private_data = luo_file->private_data;
@@ -374,6 +391,7 @@ static int luo_file_freeze_one(struct luo_file_set *file_set,
 		struct liveupdate_file_op_args args = {0};
 
 		args.handler = luo_file->fh;
+		args.session = luo_session_from_file_set(file_set);
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
 		args.private_data = luo_file->private_data;
@@ -395,6 +413,7 @@ static void luo_file_unfreeze_one(struct luo_file_set *file_set,
 		struct liveupdate_file_op_args args = {0};
 
 		args.handler = luo_file->fh;
+		args.session = luo_session_from_file_set(file_set);
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
 		args.private_data = luo_file->private_data;
@@ -587,6 +606,7 @@ int luo_retrieve_file(struct luo_file_set *file_set, u64 token,
 	}
 
 	args.handler = luo_file->fh;
+	args.session = luo_session_from_file_set(file_set);
 	args.serialized_data = luo_file->serialized_data;
 	err = luo_file->fh->ops->retrieve(&args);
 	if (err) {
@@ -620,6 +640,7 @@ static int luo_file_can_finish_one(struct luo_file_set *file_set,
 		struct liveupdate_file_op_args args = {0};
 
 		args.handler = luo_file->fh;
+		args.session = luo_session_from_file_set(file_set);
 		args.file = luo_file->file;
 		args.serialized_data = luo_file->serialized_data;
 		args.retrieve_status = luo_file->retrieve_status;
@@ -637,6 +658,7 @@ static void luo_file_finish_one(struct luo_file_set *file_set,
 	guard(mutex)(&luo_file->mutex);
 
 	args.handler = luo_file->fh;
+	args.session = luo_session_from_file_set(file_set);
 	args.file = luo_file->file;
 	args.serialized_data = luo_file->serialized_data;
 	args.retrieve_status = luo_file->retrieve_status;
@@ -926,3 +948,65 @@ void liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh)
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
2.55.0.766.g2966f0265a-goog


