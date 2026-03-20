Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D3D1099B32
	for <kexec@archiver.kernel.org>; Fri, 20 Mar 2026 18:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=12eV5O9XU1QG2j4V22rptbcLrLlRG2N4Np2JBHQuFzY=; b=b0cKPLIhRO4QP32B0nuTfdkvSS
	1TOTbzHU7GO7ooAK6JF7+OFDJlhSTlTjCtZtY7qiRsaVPK3vf2oHBQFrA29xk8qqsiHUYYvNSK4N7
	FqAkiZPQHTm702AmvxpbQgtYo/jR50iNwXWaI6R7kpohg/4XYuCTE35ZKTtJP+ccKA0pBY7ocgK2p
	ISNNuZVWFj4I5RRdqP7ROMghmeSTwWj8zpeZR+D446Z80zluQRUYhI2KZMzwZxn8SgaT5VQaBGGIo
	FeKRzURC90tEO/+6nfAO/Jrjgw+eqT9bt0e8PnBToo/1yIrPZj+5m4O4WqkewRD9vJmcRpGUDL2oH
	sDLCk+HA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3eIx-0000000DM8S-2n4B;
	Fri, 20 Mar 2026 18:10:39 +0000
Received: from [209.141.44.239] (helo=smtp3.mymangomail.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3eIu-0000000DM7C-1dSC
	for kexec@lists.infradead.org;
	Fri, 20 Mar 2026 18:10:38 +0000
Received: from [127.0.1.1] (localhost [127.0.0.1])
	by hillsboro.smtp.mymangomail.com (Mango Mail) with ESMTP id C36FA5D9D7;
	Fri, 20 Mar 2026 12:41:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gerlicz.space;
	s=mango-1; t=1774024918;
	bh=J/1BiQbwlvxBt7cWoacVDZkl2V/E1R2YIIE3+5yf7DA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dVAnV60LpMdbV2dsHvLTbSJOu0JGMLqhSycUN9zBO960h4lvQ7WRi15lZSHl6gbsW
	 7D1IEeCJCiitk/0LoHCgi415L2LrwOvDMholQ8nJsRIj75Y7WPEZa6WScOmsYbCFU8
	 Bv2ID5wYc9JHzMqvNOof7QjR8p6OFsZ7P+1SAtTY=
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
	by hillsboro.smtp.mymangomail.com (Mango Mail) with ESMTPSA id 8CBD65D9B1;
	Fri, 20 Mar 2026 12:40:52 -0400 (EDT)
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
Subject: [PATCH 3/5] liveupdate: fail session restore on file deserialization
 errors
Date: Fri, 20 Mar 2026 17:37:18 +0100
Message-ID: <20260320163720.100456-3-oskar@gerlicz.space>
In-Reply-To: <20260320163720.100456-1-oskar@gerlicz.space>
References: <20260320163720.100456-1-oskar@gerlicz.space>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260320_111037_519281_B7818437 
X-CRM114-Status: GOOD (  16.79  )
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

luo_session_deserialize() calls luo_file_deserialize() but ignores its
return value. If file restore fails part-way through, the incoming
session still gets inserted and the caller still sees success.

Leaving a partially restored session on the incoming list is dangerous
because later retrieve or finish operations can walk half-built file
state and operate on uninitialized or stale entries.

Propagate file deserialization failures back to session restore,
remove the partially restored session, and free any struct luo_file
objects that were already allocated before returning the error.

Signed-off-by: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
---
 kernel/liveupdate/luo_file.c    | 45 ++++++++++++++++++++-------------
 kernel/liveupdate/luo_session.c | 27 +++++++-------------
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index 5acee4174bf0..cc0fd7e9c332 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -717,6 +717,22 @@ int luo_file_finish(struct luo_file_set *file_set)
 	return 0;
 }
 
+static void luo_file_discard_deserialized(struct luo_file_set *file_set)
+{
+	struct luo_file *luo_file;
+
+	while (!list_empty(&file_set->files_list)) {
+		luo_file = list_last_entry(&file_set->files_list,
+					   struct luo_file, list);
+		list_del(&luo_file->list);
+		mutex_destroy(&luo_file->mutex);
+		kfree(luo_file);
+	}
+
+	file_set->count = 0;
+	file_set->files = NULL;
+}
+
 /**
  * luo_file_deserialize - Reconstructs the list of preserved files in the new kernel.
  * @file_set:     The incoming file_set to fill with deserialized data.
@@ -747,6 +763,7 @@ int luo_file_deserialize(struct luo_file_set *file_set,
 {
 	struct luo_file_ser *file_ser;
 	u64 i;
+	int err;
 
 	if (!file_set_ser->files) {
 		WARN_ON(file_set_ser->count);
@@ -756,21 +773,6 @@ int luo_file_deserialize(struct luo_file_set *file_set,
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
@@ -787,12 +789,15 @@ int luo_file_deserialize(struct luo_file_set *file_set,
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
@@ -803,6 +808,10 @@ int luo_file_deserialize(struct luo_file_set *file_set,
 	}
 
 	return 0;
+
+err_discard:
+	luo_file_discard_deserialized(file_set);
+	return err;
 }
 
 void luo_file_set_init(struct luo_file_set *file_set)
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 39215e5eda7a..77afa913d6c7 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -565,21 +565,6 @@ int luo_session_deserialize(void)
 	if (!sh->active)
 		return 0;
 
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
 
@@ -598,9 +583,15 @@ int luo_session_deserialize(void)
 			return err;
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
+			luo_session_remove(sh, session);
+			luo_session_free(session);
+			return err;
 		}
 	}
 
-- 
2.53.0


