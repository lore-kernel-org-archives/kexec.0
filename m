Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E15FFEC116
	for <kexec@archiver.kernel.org>; Tue, 24 Mar 2026 21:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oiVHAfU2cuumMxDfOsMQJO2cCd2bhMjQlOuzxfdQlCY=; b=2V88PGywJ1zWjPxb5KXH8c7UZD
	LeNiONwIgkfBR5O3VqfA42xY7EHzPYnXZADZFTqqD76nfD5Q6JsoSrDsP5jbd/LYMRtcBEKJWIqql
	UXAn1dBiIWui/cBQLqDSvAC5CuBdvmLnv5Bxi/h18VYq6v0M2hCT+iIS4JlxRUBAPShJEEbLVfubg
	hZooi2RuCGjaUM9t/X71LlL9v8OyfKZbScZtDp5kZW+dB1jsBKU6wVwA93xZr+mABATdYku+Sf/tB
	vngYOuFcJWVvk3XlW6xmQkCHMRvVmWasCRXd0ktwyEhWlVD9v2kGfoQhVLGUa+1Cy7vUSH01h1FC/
	GsYRmjzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w59Kv-00000002G6s-2VcQ;
	Tue, 24 Mar 2026 21:30:53 +0000
Received: from [209.141.44.239] (helo=smtp3.mymangomail.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w59Kt-00000002G6M-1ahq
	for kexec@lists.infradead.org;
	Tue, 24 Mar 2026 21:30:52 +0000
Received: from [127.0.1.1] (localhost [127.0.0.1])
	by hillsboro.smtp.mymangomail.com (Mango Mail) with ESMTP id 582075D9B6;
	Tue, 24 Mar 2026 17:30:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gerlicz.space;
	s=mango-1; t=1774387846;
	bh=L7uXEUA/d4BNBAHzLe+JqRbfltbKpjcnFFUj/dBxk7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KCIaZAsx196BMSBvyFO4r8k0Yy34I9hkfUIiC88LJHGkNLKNNSqbHyahkQLTUseUW
	 aO2/y0TiMKPiUXMTXdAj0OReR42kyOA52/BXPI07Chx4khQAoBDLET6CcXoj3wuAJu
	 V03N4sSGahJIy5/fkPDIyP0CbyV5Zg4qM6ZOoHvo=
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
	by hillsboro.smtp.mymangomail.com (Mango Mail) with ESMTPSA id F18B65D9B4;
	Tue, 24 Mar 2026 17:28:57 -0400 (EDT)
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
Subject: [PATCH v4 1/5] liveupdate: block outgoing session updates during
 reboot
Date: Tue, 24 Mar 2026 22:27:26 +0100
Message-ID: <20260324212730.65290-2-oskar@gerlicz.space>
In-Reply-To: <20260324212730.65290-1-oskar@gerlicz.space>
References: <20260324212730.65290-1-oskar@gerlicz.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260324_143051_502564_8751A29C 
X-CRM114-Status: GOOD (  22.61  )
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

Block new outgoing session mutations with the rebooting gate and serialize
in-flight operations with session->mutex. During serialization, pin the
outgoing sessions with temporary references instead of relying on an
auxiliary in-flight counter.

Also make incoming session origin immutable and use retrieved only as the
"checked out by userspace" bit. This keeps FINISH, close(), and
retrieve-by-name on a single lifetime model without reintroducing a larger
session state machine.

Signed-off-by: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
---
 kernel/liveupdate/luo_internal.h |   9 +-
 kernel/liveupdate/luo_session.c  | 308 +++++++++++++++++++++++++------
 2 files changed, 259 insertions(+), 58 deletions(-)

diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index 8083d8739b09..e29e1a46b491 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -9,6 +9,7 @@
 #define _LINUX_LUO_INTERNAL_H
 
 #include <linux/liveupdate.h>
+#include <linux/refcount.h>
 #include <linux/uaccess.h>
 
 struct luo_ucmd {
@@ -63,8 +64,10 @@ struct luo_file_set {
  * @list:       A list_head member used to link this session into a global list
  *              of either outgoing (to be preserved) or incoming (restored from
  *              previous kernel) sessions.
- * @retrieved:  A boolean flag indicating whether this session has been
- *              retrieved by a consumer in the new kernel.
+ * @incoming:   True for sessions restored from the previous kernel. This is
+ *              immutable after publication and distinguishes incoming sessions
+ *              from outgoing ones.
+ * @retrieved:  True while an incoming session is checked out by userspace.
  * @file_set:   A set of files that belong to this session.
  * @mutex:      protects fields in the luo_session.
  */
@@ -72,8 +75,10 @@ struct luo_session {
 	char name[LIVEUPDATE_SESSION_NAME_LENGTH];
 	struct luo_session_ser *ser;
 	struct list_head list;
+	bool incoming;
 	bool retrieved;
 	struct luo_file_set file_set;
+	refcount_t refs;
 	struct mutex mutex;
 };
 
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 783677295640..63aee9cc881d 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -66,6 +66,7 @@
 #include <linux/rwsem.h>
 #include <linux/slab.h>
 #include <linux/unaligned.h>
+#include <linux/wait.h>
 #include <uapi/linux/liveupdate.h>
 #include "luo_internal.h"
 
@@ -81,9 +82,12 @@
  * @list:       The head of the linked list of `struct luo_session` instances.
  * @rwsem:      A read-write semaphore providing synchronized access to the
  *              session list and other fields in this structure.
+ * @reboot_waitq: Wait queue used by close() and serialize() to wait for
+ *              rebooting transitions.
  * @header_ser: The header data of serialization array.
  * @ser:        The serialized session data (an array of
  *              `struct luo_session_ser`).
+ * @rebooting:  True while outgoing sessions are frozen for kexec handover.
  * @active:     Set to true when first initialized. If previous kernel did not
  *              send session data, active stays false for incoming.
  */
@@ -91,8 +95,10 @@ struct luo_session_header {
 	long count;
 	struct list_head list;
 	struct rw_semaphore rwsem;
+	wait_queue_head_t reboot_waitq;
 	struct luo_session_header_ser *header_ser;
 	struct luo_session_ser *ser;
+	bool rebooting;
 	bool active;
 };
 
@@ -110,13 +116,23 @@ static struct luo_session_global luo_session_global = {
 	.incoming = {
 		.list = LIST_HEAD_INIT(luo_session_global.incoming.list),
 		.rwsem = __RWSEM_INITIALIZER(luo_session_global.incoming.rwsem),
+		.reboot_waitq =
+			__WAIT_QUEUE_HEAD_INITIALIZER(luo_session_global.incoming.reboot_waitq),
 	},
 	.outgoing = {
 		.list = LIST_HEAD_INIT(luo_session_global.outgoing.list),
 		.rwsem = __RWSEM_INITIALIZER(luo_session_global.outgoing.rwsem),
+		.reboot_waitq =
+			__WAIT_QUEUE_HEAD_INITIALIZER(luo_session_global.outgoing.reboot_waitq),
 	},
 };
 
+static void luo_session_reboot_done(struct luo_session_header *sh)
+{
+	WRITE_ONCE(sh->rebooting, false);
+	wake_up_all(&sh->reboot_waitq);
+}
+
 static struct luo_session *luo_session_alloc(const char *name)
 {
 	struct luo_session *session = kzalloc_obj(*session);
@@ -128,6 +144,7 @@ static struct luo_session *luo_session_alloc(const char *name)
 	INIT_LIST_HEAD(&session->file_set.files_list);
 	luo_file_set_init(&session->file_set);
 	INIT_LIST_HEAD(&session->list);
+	refcount_set(&session->refs, 1);
 	mutex_init(&session->mutex);
 
 	return session;
@@ -140,6 +157,17 @@ static void luo_session_free(struct luo_session *session)
 	kfree(session);
 }
 
+static void luo_session_get(struct luo_session *session)
+{
+	refcount_inc(&session->refs);
+}
+
+static void luo_session_put(struct luo_session *session)
+{
+	if (refcount_dec_and_test(&session->refs))
+		luo_session_free(session);
+}
+
 static int luo_session_insert(struct luo_session_header *sh,
 			      struct luo_session *session)
 {
@@ -152,6 +180,9 @@ static int luo_session_insert(struct luo_session_header *sh,
 	 * for new session.
 	 */
 	if (sh == &luo_session_global.outgoing) {
+		if (READ_ONCE(sh->rebooting))
+			return -EBUSY;
+
 		if (sh->count == LUO_SESSION_MAX)
 			return -ENOMEM;
 	}
@@ -172,58 +203,157 @@ static int luo_session_insert(struct luo_session_header *sh,
 	return 0;
 }
 
+static void __luo_session_remove(struct luo_session_header *sh,
+				 struct luo_session *session)
+{
+	list_del_init(&session->list);
+	sh->count--;
+}
+
 static void luo_session_remove(struct luo_session_header *sh,
 			       struct luo_session *session)
 {
 	guard(rwsem_write)(&sh->rwsem);
-	list_del(&session->list);
-	sh->count--;
+	__luo_session_remove(sh, session);
 }
 
-static int luo_session_finish_one(struct luo_session *session)
+static int luo_session_outgoing_begin(struct luo_session *session,
+				      struct luo_session_header **shp)
 {
-	guard(mutex)(&session->mutex);
-	return luo_file_finish(&session->file_set);
+	struct luo_session_header *sh;
+
+	if (session->incoming)
+		return -EINVAL;
+
+	sh = &luo_session_global.outgoing;
+	down_read(&sh->rwsem);
+	if (READ_ONCE(sh->rebooting)) {
+		up_read(&sh->rwsem);
+		return -EBUSY;
+	}
+
+	*shp = sh;
+	return 0;
 }
 
-static void luo_session_unfreeze_one(struct luo_session *session,
-				     struct luo_session_ser *ser)
+static void luo_session_outgoing_end(struct luo_session_header *sh)
 {
-	guard(mutex)(&session->mutex);
-	luo_file_unfreeze(&session->file_set, &ser->file_set_ser);
+	if (sh)
+		up_read(&sh->rwsem);
 }
 
-static int luo_session_freeze_one(struct luo_session *session,
-				  struct luo_session_ser *ser)
+static int luo_session_get_all_outgoing(struct luo_session **sessions)
 {
-	guard(mutex)(&session->mutex);
-	return luo_file_freeze(&session->file_set, &ser->file_set_ser);
+	struct luo_session_header *sh = &luo_session_global.outgoing;
+	struct luo_session *session;
+	u64 nr = 0;
+
+	down_write(&sh->rwsem);
+	if (READ_ONCE(sh->rebooting)) {
+		up_write(&sh->rwsem);
+		return -EBUSY;
+	}
+
+	WRITE_ONCE(sh->rebooting, true);
+	list_for_each_entry(session, &sh->list, list) {
+		luo_session_get(session);
+		sessions[nr++] = session;
+	}
+	up_write(&sh->rwsem);
+
+	return nr;
+}
+
+static void luo_session_put_all(struct luo_session **sessions, u64 nr)
+{
+	while (nr)
+		luo_session_put(sessions[--nr]);
+}
+
+static void luo_session_wait_reboot(struct luo_session_header *sh)
+{
+	DEFINE_WAIT(wait);
+
+	for (;;) {
+		prepare_to_wait(&sh->reboot_waitq, &wait,
+				TASK_UNINTERRUPTIBLE | TASK_FREEZABLE);
+		if (!READ_ONCE(sh->rebooting))
+			break;
+		schedule();
+	}
+
+	finish_wait(&sh->reboot_waitq, &wait);
+}
+
+static int luo_session_finish_retrieved(struct luo_session *session)
+{
+	lockdep_assert_held(&session->mutex);
+	if (!session->retrieved)
+		return -EINVAL;
+
+	return luo_file_finish(&session->file_set);
 }
 
 static int luo_session_release(struct inode *inodep, struct file *filep)
 {
 	struct luo_session *session = filep->private_data;
-	struct luo_session_header *sh;
+	struct luo_session_header *sh = &luo_session_global.incoming;
+	int ret = 0;
+	bool removed = false;
 
-	/* If retrieved is set, it means this session is from incoming list */
-	if (session->retrieved) {
-		int err = luo_session_finish_one(session);
+	if (session->incoming) {
+		scoped_guard(mutex, &session->mutex) {
+			if (session->retrieved) {
+				ret = luo_session_finish_retrieved(session);
+				if (!ret) {
+					down_write(&sh->rwsem);
+					if (!list_empty(&session->list)) {
+						__luo_session_remove(sh, session);
+						removed = true;
+					}
+					up_write(&sh->rwsem);
+				}
+				WRITE_ONCE(session->retrieved, false);
+			}
+		}
 
-		if (err) {
+		if (ret) {
 			pr_warn("Unable to finish session [%s] on release\n",
 				session->name);
-			return err;
+			luo_session_put(session);
+			return ret;
+		}
+
+		if (removed)
+			luo_session_put(session);
+		luo_session_put(session);
+		return 0;
+	}
+
+	sh = &luo_session_global.outgoing;
+
+	for (;;) {
+		down_read(&sh->rwsem);
+		if (READ_ONCE(sh->rebooting)) {
+			up_read(&sh->rwsem);
+			luo_session_wait_reboot(sh);
+			continue;
 		}
-		sh = &luo_session_global.incoming;
-	} else {
-		scoped_guard(mutex, &session->mutex)
-			luo_file_unpreserve_files(&session->file_set);
-		sh = &luo_session_global.outgoing;
+
+		mutex_lock(&session->mutex);
+		up_read(&sh->rwsem);
+		break;
 	}
 
-	luo_session_remove(sh, session);
-	luo_session_free(session);
+	luo_file_unpreserve_files(&session->file_set);
 
+	down_write(&sh->rwsem);
+	__luo_session_remove(sh, session);
+	up_write(&sh->rwsem);
+	mutex_unlock(&session->mutex);
+
+	luo_session_put(session);
+	luo_session_put(session);
 	return 0;
 }
 
@@ -231,10 +361,16 @@ static int luo_session_preserve_fd(struct luo_session *session,
 				   struct luo_ucmd *ucmd)
 {
 	struct liveupdate_session_preserve_fd *argp = ucmd->cmd;
+	struct luo_session_header *sh = NULL;
 	int err;
 
-	guard(mutex)(&session->mutex);
-	err = luo_preserve_file(&session->file_set, argp->token, argp->fd);
+	err = luo_session_outgoing_begin(session, &sh);
+	if (err)
+		return err;
+
+	scoped_guard(mutex, &session->mutex)
+		err = luo_preserve_file(&session->file_set, argp->token, argp->fd);
+	luo_session_outgoing_end(sh);
 	if (err)
 		return err;
 
@@ -256,8 +392,13 @@ static int luo_session_retrieve_fd(struct luo_session *session,
 	if (argp->fd < 0)
 		return argp->fd;
 
-	guard(mutex)(&session->mutex);
-	err = luo_retrieve_file(&session->file_set, argp->token, &file);
+	scoped_guard(mutex, &session->mutex) {
+		if (!session->retrieved)
+			err = -EINVAL;
+		else
+			err = luo_retrieve_file(&session->file_set,
+						argp->token, &file);
+	}
 	if (err < 0)
 		goto  err_put_fd;
 
@@ -281,11 +422,28 @@ static int luo_session_finish(struct luo_session *session,
 			      struct luo_ucmd *ucmd)
 {
 	struct liveupdate_session_finish *argp = ucmd->cmd;
-	int err = luo_session_finish_one(session);
+	struct luo_session_header *sh = &luo_session_global.incoming;
+	bool removed = false;
+	int err;
 
+	scoped_guard(mutex, &session->mutex) {
+		err = luo_session_finish_retrieved(session);
+		if (!err) {
+			down_write(&sh->rwsem);
+			if (!list_empty(&session->list)) {
+				__luo_session_remove(sh, session);
+				removed = true;
+			}
+			up_write(&sh->rwsem);
+			WRITE_ONCE(session->retrieved, false);
+		}
+	}
 	if (err)
 		return err;
 
+	if (removed)
+		luo_session_put(session);
+
 	return luo_ucmd_respond(ucmd, sizeof(*argp));
 }
 
@@ -371,9 +529,12 @@ static int luo_session_getfile(struct luo_session *session, struct file **filep)
 
 	lockdep_assert_held(&session->mutex);
 	snprintf(name_buf, sizeof(name_buf), "[luo_session] %s", session->name);
+	luo_session_get(session);
 	file = anon_inode_getfile(name_buf, &luo_session_fops, session, O_RDWR);
-	if (IS_ERR(file))
+	if (IS_ERR(file)) {
+		luo_session_put(session);
 		return PTR_ERR(file);
+	}
 
 	*filep = file;
 
@@ -401,9 +562,10 @@ int luo_session_create(const char *name, struct file **filep)
 	return 0;
 
 err_remove:
-	luo_session_remove(&luo_session_global.outgoing, session);
+	scoped_guard(mutex, &session->mutex)
+		luo_session_remove(&luo_session_global.outgoing, session);
 err_free:
-	luo_session_free(session);
+	luo_session_put(session);
 
 	return err;
 }
@@ -418,6 +580,8 @@ int luo_session_retrieve(const char *name, struct file **filep)
 	scoped_guard(rwsem_read, &sh->rwsem) {
 		list_for_each_entry(it, &sh->list, list) {
 			if (!strncmp(it->name, name, sizeof(it->name))) {
+				/* Keep the session alive after dropping rwsem. */
+				luo_session_get(it);
 				session = it;
 				break;
 			}
@@ -428,12 +592,14 @@ int luo_session_retrieve(const char *name, struct file **filep)
 		return -ENOENT;
 
 	guard(mutex)(&session->mutex);
-	if (session->retrieved)
-		return -EINVAL;
+	if (session->retrieved || list_empty(&session->list))
+		err = -EINVAL;
+	else
+		err = luo_session_getfile(session, filep);
 
-	err = luo_session_getfile(session, filep);
 	if (!err)
-		session->retrieved = true;
+		WRITE_ONCE(session->retrieved, true);
+	luo_session_put(session);
 
 	return err;
 }
@@ -548,6 +714,7 @@ int luo_session_deserialize(void)
 				sh->ser[i].name, session);
 			return PTR_ERR(session);
 		}
+		session->incoming = true;
 
 		err = luo_session_insert(sh, session);
 		if (err) {
@@ -573,32 +740,61 @@ int luo_session_deserialize(void)
 int luo_session_serialize(void)
 {
 	struct luo_session_header *sh = &luo_session_global.outgoing;
-	struct luo_session *session;
-	int i = 0;
+	struct luo_session **sessions;
+	u64 nr;
+	u64 i;
+	u64 frozen_nr = 0;
 	int err;
 
-	guard(rwsem_write)(&sh->rwsem);
-	list_for_each_entry(session, &sh->list, list) {
-		err = luo_session_freeze_one(session, &sh->ser[i]);
-		if (err)
-			goto err_undo;
+	sessions = kcalloc(LUO_SESSION_MAX, sizeof(*sessions), GFP_KERNEL);
+	if (!sessions)
+		return -ENOMEM;
 
-		strscpy(sh->ser[i].name, session->name,
-			sizeof(sh->ser[i].name));
-		i++;
-	}
-	sh->header_ser->count = sh->count;
+	err = luo_session_get_all_outgoing(sessions);
+	if (err < 0)
+		goto out_free_sessions;
 
-	return 0;
+	nr = err;
+	for (i = 0; i < nr; i++) {
+		struct luo_session *session = sessions[i];
 
-err_undo:
-	list_for_each_entry_continue_reverse(session, &sh->list, list) {
-		i--;
-		luo_session_unfreeze_one(session, &sh->ser[i]);
-		memset(sh->ser[i].name, 0, sizeof(sh->ser[i].name));
+		scoped_guard(mutex, &session->mutex) {
+			if (list_empty(&session->list))
+				continue;
+
+			err = luo_file_freeze(&session->file_set,
+					      &sh->ser[frozen_nr].file_set_ser);
+			if (err)
+				goto err_undo;
+
+			strscpy(sh->ser[frozen_nr].name, session->name,
+				sizeof(sh->ser[frozen_nr].name));
+			swap(sessions[frozen_nr], sessions[i]);
+			frozen_nr++;
+		}
 	}
+	sh->header_ser->count = frozen_nr;
+	err = 0;
 
+out_put_sessions:
+	luo_session_put_all(sessions, nr);
+out_free_sessions:
+	kfree(sessions);
 	return err;
+
+err_undo:
+	while (frozen_nr) {
+		struct luo_session *session = sessions[--frozen_nr];
+
+		scoped_guard(mutex, &session->mutex) {
+			luo_file_unfreeze(&session->file_set,
+					  &sh->ser[frozen_nr].file_set_ser);
+			memset(&sh->ser[frozen_nr], 0, sizeof(sh->ser[frozen_nr]));
+		}
+	}
+	sh->header_ser->count = 0;
+	luo_session_reboot_done(sh);
+	goto out_put_sessions;
 }
 
 /**
-- 
2.53.0


