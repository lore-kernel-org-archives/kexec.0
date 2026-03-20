Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8071B10987AB
	for <kexec@archiver.kernel.org>; Fri, 20 Mar 2026 16:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OFWl7Ej0DLfHR3zQ1Wnf1cKYYmYa0BNVU+VFNYEBse8=; b=FGJd/skfveLlkAQQpSSESPEjXQ
	SFyqcdtSwkWgKdb5AZvRhsvqR6/HkWL5S8SgNuDGWbiwZuckllCQH3ac1wJum0yJXfwKrCXp4niGN
	rgpgrAZ8Dv7jL8Mi+nRzLP7sr/ORCapuZKSIDOvVMGKIk2IL8bC61Xanf6g0aoAZq+5BhBgLr9/V2
	SdE6RU4TXGSuTixlRvFbiypqmvcgA1vWnezgT9zR/Qr6fkpLx/RvRqmW6xKLMJ+PEpqLws2/MdrDT
	qtRgat6DdoYsmcKRZvMagSi9sOPO5sfBRGdY1UQBqEzonDvM1lo37UkeJMaxPvRuVPWFOUturZZvN
	+sXijzzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3ct6-0000000DAK5-2P9j;
	Fri, 20 Mar 2026 16:39:52 +0000
Received: from hillsboro-edge.smtp.mymangomail.com ([5.78.130.219])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3ct0-0000000DAIe-2CLc
	for kexec@lists.infradead.org;
	Fri, 20 Mar 2026 16:39:48 +0000
Received: from smtp.mymangomail.com (localhost [127.0.0.1])
	by smtp.mymangomail.com (Mango Mail) with ESMTP id C45144089D;
	Fri, 20 Mar 2026 12:39:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gerlicz.space;
	s=mango-1; t=1774024773;
	bh=d0ek7AVQMvweJcV8KF6oPuPSOtLVpNAVzgGT5RI8EcU=;
	h=From:To:Cc:Subject:Date:From;
	b=DSL9oMa38kQD7wIQawTgMO0RV9QMPigjVMbhXOFBzgog5IuDWtY7Rv57NTZRuVbuI
	 4HCJSWwK1CfT/nDEoJ/owhoqupk13oUBSh5z69FSSxfm0FnQl+Nl7BdviOJYPGZaQw
	 OoTDqrIbtyEIF2Xsxz7zDvL7WluNYc2EWKrjIf04=
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
	by smtp.mymangomail.com (Mango Mail) with ESMTPSA id 7038A40440;
	Fri, 20 Mar 2026 12:38:30 -0400 (EDT)
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
Subject: [PATCH 1/5] liveupdate: block outgoing session updates during reboot
Date: Fri, 20 Mar 2026 17:37:16 +0100
Message-ID: <20260320163720.100456-1-oskar@gerlicz.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260320_093946_895264_726A4295 
X-CRM114-Status: GOOD (  15.76  )
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

When kernel_kexec() starts a live update handover, LUO serializes
outgoing sessions before the reboot path freezes tasks or shuts
devices down. That leaves a window where close() and
LIVEUPDATE_SESSION_PRESERVE_FD can still mutate an existing outgoing
session after luo_session_serialize() has already captured it.

The race is dangerous because the next kernel may inherit stale file
metadata or references to memory that userspace has already
unpreserved. That breaks handover consistency and can later trigger
restore failures on already torn down state.

Mark the outgoing session set as rebooting while serialization is in
progress, reject new mutations with -EBUSY, and make release wait
until rebooting finishes before unpreserving files. Reset the flag and
wake waiters when serialization rolls back, and use READ_ONCE() and
WRITE_ONCE() so the state is visible across CPUs.

Signed-off-by: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
---
 kernel/liveupdate/luo_session.c | 58 ++++++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 5 deletions(-)

diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 783677295640..ee5ea2a8ed3f 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -66,6 +66,7 @@
 #include <linux/rwsem.h>
 #include <linux/slab.h>
 #include <linux/unaligned.h>
+#include <linux/wait.h>
 #include <uapi/linux/liveupdate.h>
 #include "luo_internal.h"
 
@@ -91,8 +92,10 @@ struct luo_session_header {
 	long count;
 	struct list_head list;
 	struct rw_semaphore rwsem;
+	wait_queue_head_t reboot_waitq;
 	struct luo_session_header_ser *header_ser;
 	struct luo_session_ser *ser;
+	bool rebooting;
 	bool active;
 };
 
@@ -110,13 +113,23 @@ static struct luo_session_global luo_session_global = {
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
@@ -152,6 +165,9 @@ static int luo_session_insert(struct luo_session_header *sh,
 	 * for new session.
 	 */
 	if (sh == &luo_session_global.outgoing) {
+		if (READ_ONCE(sh->rebooting))
+			return -EBUSY;
+
 		if (sh->count == LUO_SESSION_MAX)
 			return -ENOMEM;
 	}
@@ -216,9 +232,22 @@ static int luo_session_release(struct inode *inodep, struct file *filep)
 		}
 		sh = &luo_session_global.incoming;
 	} else {
-		scoped_guard(mutex, &session->mutex)
-			luo_file_unpreserve_files(&session->file_set);
 		sh = &luo_session_global.outgoing;
+
+		for (;;) {
+			down_read(&sh->rwsem);
+			if (READ_ONCE(sh->rebooting)) {
+				up_read(&sh->rwsem);
+				wait_event(sh->reboot_waitq,
+					   !READ_ONCE(sh->rebooting));
+				continue;
+			}
+
+			scoped_guard(mutex, &session->mutex)
+				luo_file_unpreserve_files(&session->file_set);
+			up_read(&sh->rwsem);
+			break;
+		}
 	}
 
 	luo_session_remove(sh, session);
@@ -231,10 +260,22 @@ static int luo_session_preserve_fd(struct luo_session *session,
 				   struct luo_ucmd *ucmd)
 {
 	struct liveupdate_session_preserve_fd *argp = ucmd->cmd;
+	struct luo_session_header *sh = NULL;
 	int err;
 
-	guard(mutex)(&session->mutex);
-	err = luo_preserve_file(&session->file_set, argp->token, argp->fd);
+	if (!session->retrieved) {
+		sh = &luo_session_global.outgoing;
+		down_read(&sh->rwsem);
+		if (READ_ONCE(sh->rebooting)) {
+			up_read(&sh->rwsem);
+			return -EBUSY;
+		}
+	}
+
+	scoped_guard(mutex, &session->mutex)
+		err = luo_preserve_file(&session->file_set, argp->token, argp->fd);
+	if (sh)
+		up_read(&sh->rwsem);
 	if (err)
 		return err;
 
@@ -578,6 +619,10 @@ int luo_session_serialize(void)
 	int err;
 
 	guard(rwsem_write)(&sh->rwsem);
+	if (READ_ONCE(sh->rebooting))
+		return -EBUSY;
+
+	WRITE_ONCE(sh->rebooting, true);
 	list_for_each_entry(session, &sh->list, list) {
 		err = luo_session_freeze_one(session, &sh->ser[i]);
 		if (err)
@@ -595,8 +640,11 @@ int luo_session_serialize(void)
 	list_for_each_entry_continue_reverse(session, &sh->list, list) {
 		i--;
 		luo_session_unfreeze_one(session, &sh->ser[i]);
-		memset(sh->ser[i].name, 0, sizeof(sh->ser[i].name));
+		memset(&sh->ser[i], 0, sizeof(sh->ser[i]));
 	}
+	sh->header_ser->count = 0;
+	/* Reset rebooting flag on serialization failure. */
+	luo_session_reboot_done(sh);
 
 	return err;
 }
-- 
2.53.0


