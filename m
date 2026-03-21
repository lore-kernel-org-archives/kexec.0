Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BED1094464
	for <kexec@archiver.kernel.org>; Sat, 21 Mar 2026 14:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WnfwNOCz2xGiyg8OXyoF1gapwg8Az9cm20wVsA2MxxQ=; b=fknydiYdvrn4UXLTyKLppS+as0
	dZPZ+DIYiJPhH7MzssDiWsBuKWo/5hV8eudeeg2COKr7C2z5UHNS99MA6AaETcDo9CEZMt8lfXhYF
	Hm/MXy1Z02Qfuac55kxhhV2w3a0K40SWVA7lfIW09UVYFU7ShBREcut6VzV7aJPmnXWtyQMTpsLQL
	p4DQYhFhPrjX9+3QNcg7TY1bb+HXcRSIg7tFmk2KeKHc5frQy9SqKAAj2wyYdKRy3a6MdfZp1xGc+
	SIb+NXqpaN3lHO4TmQmUewd8Gv2hUKMLO1YZjtedlVtEqi4ekJ9O+i8uq0cn2T6a9mNnqpPMX3OQL
	NLY7epGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3xVv-0000000EY2S-1ODw;
	Sat, 21 Mar 2026 14:41:19 +0000
Received: from hillsboro-edge.smtp.mymangomail.com ([5.78.130.219])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3xVr-0000000EY1e-32Ja
	for kexec@lists.infradead.org;
	Sat, 21 Mar 2026 14:41:17 +0000
Received: from smtp.mymangomail.com (localhost [127.0.0.1])
	by smtp.mymangomail.com (Mango Mail) with ESMTP id 163664162F;
	Sat, 21 Mar 2026 10:40:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gerlicz.space;
	s=mango-1; t=1774104053;
	bh=hQW88e3e2eG32gSgZk8S8tu/3o5jt6LYekAYe9l4YJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jSGI9QEHFG39qTc6r35LIgv31M/sfbMoYXB719FkKiHNjHEifwcRqGe0J/Fa9S8gZ
	 ENgB24HxlouDQOitRh89jJ7tB7s1gwA1BZY4iRbSj3ji3U8lU0DnoPSRnF/kkzyqNk
	 OAj1YLBUyziHtkHM2Vu22T46YlqaeWJBwOCpIdqk=
X-Mango-Origin: 1
X-Mango-Origin: 1
X-Mango-Origin: 1
X-Mango-Origin: 1
X-Mango-Origin: 1
X-Mango-Origin: 1
X-Mango-Origin: 1
X-Mango-Origin: 1
X-Mango-Origin: 1
Received: from authenticated-user (smtp.mymangomail.com [205.185.121.143])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits)
 server-digest SHA256)
	(No client certificate requested)
	by smtp.mymangomail.com (Mango Mail) with ESMTPSA id CC86641627;
	Sat, 21 Mar 2026 10:39:39 -0400 (EDT)
From: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>,
	Baoquan He <bhe@redhat.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
Subject: [PATCH v3 3/5] liveupdate: fail session restore on file
 deserialization errors
Date: Sat, 21 Mar 2026 15:36:40 +0100
Message-ID: <20260321143642.166313-3-oskar@gerlicz.space>
In-Reply-To: <20260321143642.166313-2-oskar@gerlicz.space>
References: <20260321143642.166313-1-oskar@gerlicz.space>
 <20260321143642.166313-2-oskar@gerlicz.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260321_074116_857788_09F75C5E 
X-CRM114-Status: GOOD (  23.72  )
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

Session restore can fail after inserting a partially constructed session
into the incoming list. The v2 cleanup also reused finish-style teardown
for that rollback path even though finish is the normal completion path
for a fully restored session.

That can leave stale incoming sessions behind after a deserialize error
and can run completion callbacks against state that was never fully
rebuilt.

Require an explicit abort callback for file handlers, use it to unwind
partially restored files, and route every deserialize failure through a
single cleanup path that drops restored sessions, frees serialized file
metadata and records the cached error code.

Fixes: 077fc48b59fc ("liveupdate: fail session restore on file deserialization errors")
Signed-off-by: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
---
 include/linux/liveupdate.h       |  3 ++
 kernel/liveupdate/luo_file.c     | 67 +++++++++++++++++++++++---------
 kernel/liveupdate/luo_internal.h |  1 +
 kernel/liveupdate/luo_session.c  | 42 +++++++++-----------
 mm/memfd_luo.c                   | 24 +++++++-----
 5 files changed, 86 insertions(+), 51 deletions(-)

diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
index d93b043a0421..611907f57127 100644
--- a/include/linux/liveupdate.h
+++ b/include/linux/liveupdate.h
@@ -63,6 +63,8 @@ struct liveupdate_file_op_args {
  *                finish, in order to do successful finish calls for all
  *                resources in the session.
  * @finish:       Required. Final cleanup in the new kernel.
+ * @abort:        Required. Discard preserved state in the new kernel without
+ *                completing finish().
  * @owner:        Module reference
  *
  * All operations (except can_preserve) receive a pointer to a
@@ -78,6 +80,7 @@ struct liveupdate_file_ops {
 	int (*retrieve)(struct liveupdate_file_op_args *args);
 	bool (*can_finish)(struct liveupdate_file_op_args *args);
 	void (*finish)(struct liveupdate_file_op_args *args);
+	void (*abort)(struct liveupdate_file_op_args *args);
 	struct module *owner;
 };
 
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index 5acee4174bf0..939ef8d762ce 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -648,6 +648,20 @@ static void luo_file_finish_one(struct luo_file_set *file_set,
 	luo_flb_file_finish(luo_file->fh);
 }
 
+static void luo_file_abort_one(struct luo_file *luo_file)
+{
+	struct liveupdate_file_op_args args = {0};
+
+	guard(mutex)(&luo_file->mutex);
+
+	args.handler = luo_file->fh;
+	args.file = luo_file->file;
+	args.serialized_data = luo_file->serialized_data;
+	args.retrieve_status = luo_file->retrieve_status;
+
+	luo_file->fh->ops->abort(&args);
+}
+
 /**
  * luo_file_finish - Completes the lifecycle for all files in a file_set.
  * @file_set: The file_set to be finalized.
@@ -717,6 +731,28 @@ int luo_file_finish(struct luo_file_set *file_set)
 	return 0;
 }
 
+void luo_file_abort_deserialized(struct luo_file_set *file_set)
+{
+	struct luo_file *luo_file;
+
+	while (!list_empty(&file_set->files_list)) {
+		luo_file = list_last_entry(&file_set->files_list,
+					   struct luo_file, list);
+		luo_file_abort_one(luo_file);
+		if (luo_file->file)
+			fput(luo_file->file);
+		list_del(&luo_file->list);
+		file_set->count--;
+		mutex_destroy(&luo_file->mutex);
+		kfree(luo_file);
+	}
+
+	file_set->count = 0;
+	if (file_set->files)
+		kho_restore_free(file_set->files);
+	file_set->files = NULL;
+}
+
 /**
  * luo_file_deserialize - Reconstructs the list of preserved files in the new kernel.
  * @file_set:     The incoming file_set to fill with deserialized data.
@@ -747,6 +783,7 @@ int luo_file_deserialize(struct luo_file_set *file_set,
 {
 	struct luo_file_ser *file_ser;
 	u64 i;
+	int err;
 
 	if (!file_set_ser->files) {
 		WARN_ON(file_set_ser->count);
@@ -756,21 +793,6 @@ int luo_file_deserialize(struct luo_file_set *file_set,
 	file_set->count = file_set_ser->count;
 	file_set->files = phys_to_virt(file_set_ser->files);
 
-	/*
-	 * Note on error handling:
-	 *
-	 * If deserialization fails (e.g., allocation failure or corrupt data),
-	 * we intentionally skip cleanup of files that were already restored.
-	 *
-	 * A partial failure leaves the preserved state inconsistent.
-	 * Implementing a safe "undo" to unwind complex dependencies (sessions,
-	 * files, hardware state) is error-prone and provides little value, as
-	 * the system is effectively in a broken state.
-	 *
-	 * We treat these resources as leaked. The expected recovery path is for
-	 * userspace to detect the failure and trigger a reboot, which will
-	 * reliably reset devices and reclaim memory.
-	 */
 	file_ser = file_set->files;
 	for (i = 0; i < file_set->count; i++) {
 		struct liveupdate_file_handler *fh;
@@ -787,12 +809,15 @@ int luo_file_deserialize(struct luo_file_set *file_set,
 		if (!handler_found) {
 			pr_warn("No registered handler for compatible '%s'\n",
 				file_ser[i].compatible);
-			return -ENOENT;
+			err = -ENOENT;
+			goto err_discard;
 		}
 
 		luo_file = kzalloc_obj(*luo_file);
-		if (!luo_file)
-			return -ENOMEM;
+		if (!luo_file) {
+			err = -ENOMEM;
+			goto err_discard;
+		}
 
 		luo_file->fh = fh;
 		luo_file->file = NULL;
@@ -803,6 +828,10 @@ int luo_file_deserialize(struct luo_file_set *file_set,
 	}
 
 	return 0;
+
+err_discard:
+	luo_file_abort_deserialized(file_set);
+	return err;
 }
 
 void luo_file_set_init(struct luo_file_set *file_set)
@@ -838,7 +867,7 @@ int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
 
 	/* Sanity check that all required callbacks are set */
 	if (!fh->ops->preserve || !fh->ops->unpreserve || !fh->ops->retrieve ||
-	    !fh->ops->finish || !fh->ops->can_preserve) {
+	    !fh->ops->finish || !fh->ops->abort || !fh->ops->can_preserve) {
 		return -EINVAL;
 	}
 
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index 8a6b1f6c9b4f..4842c7dbeb63 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -102,6 +102,7 @@ void luo_file_unfreeze(struct luo_file_set *file_set,
 int luo_retrieve_file(struct luo_file_set *file_set, u64 token,
 		      struct file **filep);
 int luo_file_finish(struct luo_file_set *file_set);
+void luo_file_abort_deserialized(struct luo_file_set *file_set);
 int luo_file_deserialize(struct luo_file_set *file_set,
 			 struct luo_file_set_ser *file_set_ser);
 void luo_file_set_init(struct luo_file_set *file_set);
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 200dd3b8229c..602001327f58 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -693,24 +693,10 @@ int luo_session_deserialize(void)
 		return err;
 
 	is_deserialized = true;
+	err = 0;
 	if (!sh->active)
-		return 0;
+		return err;
 
-	/*
-	 * Note on error handling:
-	 *
-	 * If deserialization fails (e.g., allocation failure or corrupt data),
-	 * we intentionally skip cleanup of sessions that were already restored.
-	 *
-	 * A partial failure leaves the preserved state inconsistent.
-	 * Implementing a safe "undo" to unwind complex dependencies (sessions,
-	 * files, hardware state) is error-prone and provides little value, as
-	 * the system is effectively in a broken state.
-	 *
-	 * We treat these resources as leaked. The expected recovery path is for
-	 * userspace to detect the failure and trigger a reboot, which will
-	 * reliably reset devices and reclaim memory.
-	 */
 	for (int i = 0; i < sh->header_ser->count; i++) {
 		struct luo_session *session;
 
@@ -718,7 +704,8 @@ int luo_session_deserialize(void)
 		if (IS_ERR(session)) {
 			pr_warn("Failed to allocate session [%s] during deserialization %pe\n",
 				sh->ser[i].name, session);
-			return PTR_ERR(session);
+			err = PTR_ERR(session);
+			goto out_discard;
 		}
 		session->state = LUO_SESSION_INCOMING;
 
@@ -726,21 +713,30 @@ int luo_session_deserialize(void)
 		if (err) {
 			pr_warn("Failed to insert session [%s] %pe\n",
 				session->name, ERR_PTR(err));
-			luo_session_free(session);
-			return err;
+			luo_session_put(session);
+			goto out_discard;
 		}
 
-		scoped_guard(mutex, &session->mutex) {
-			luo_file_deserialize(&session->file_set,
-					     &sh->ser[i].file_set_ser);
+		scoped_guard(mutex, &session->mutex)
+			err = luo_file_deserialize(&session->file_set,
+						   &sh->ser[i].file_set_ser);
+		if (err) {
+			pr_warn("Failed to deserialize session [%s] files %pe\n",
+				session->name, ERR_PTR(err));
+			goto out_discard;
 		}
 	}
 
+out_free_header:
 	kho_restore_free(sh->header_ser);
 	sh->header_ser = NULL;
 	sh->ser = NULL;
 
-	return 0;
+	return err;
+
+out_discard:
+	luo_session_discard_deserialized(sh);
+	goto out_free_header;
 }
 
 int luo_session_serialize(void)
diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
index b8edb9f981d7..8a453c8bfdf5 100644
--- a/mm/memfd_luo.c
+++ b/mm/memfd_luo.c
@@ -358,19 +358,11 @@ static void memfd_luo_discard_folios(const struct memfd_luo_folio_ser *folios_se
 	}
 }
 
-static void memfd_luo_finish(struct liveupdate_file_op_args *args)
+static void memfd_luo_abort(struct liveupdate_file_op_args *args)
 {
 	struct memfd_luo_folio_ser *folios_ser;
 	struct memfd_luo_ser *ser;
 
-	/*
-	 * If retrieve was successful, nothing to do. If it failed, retrieve()
-	 * already cleaned up everything it could. So nothing to do there
-	 * either. Only need to clean up when retrieve was not called.
-	 */
-	if (args->retrieve_status)
-		return;
-
 	ser = phys_to_virt(args->serialized_data);
 	if (!ser)
 		return;
@@ -388,6 +380,19 @@ static void memfd_luo_finish(struct liveupdate_file_op_args *args)
 	kho_restore_free(ser);
 }
 
+static void memfd_luo_finish(struct liveupdate_file_op_args *args)
+{
+	/*
+	 * If retrieve was successful, nothing to do. If it failed, retrieve()
+	 * already cleaned up everything it could. So nothing to do there
+	 * either. Only need to clean up when retrieve was not called.
+	 */
+	if (args->retrieve_status)
+		return;
+
+	memfd_luo_abort(args);
+}
+
 static int memfd_luo_retrieve_folios(struct file *file,
 				     struct memfd_luo_folio_ser *folios_ser,
 				     u64 nr_folios)
@@ -532,6 +537,7 @@ static bool memfd_luo_can_preserve(struct liveupdate_file_handler *handler,
 static const struct liveupdate_file_ops memfd_luo_file_ops = {
 	.freeze = memfd_luo_freeze,
 	.finish = memfd_luo_finish,
+	.abort = memfd_luo_abort,
 	.retrieve = memfd_luo_retrieve,
 	.preserve = memfd_luo_preserve,
 	.unpreserve = memfd_luo_unpreserve,
-- 
2.53.0


