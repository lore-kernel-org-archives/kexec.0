Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8009606A31B
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 05:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NkkebIo0;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=T7t7Q4R5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=x15wonZx4YKLKAV2h6RvhaJYvivDTh63oWX01b1gV+8=; b=NkkebIo0mGC4tI
	zfgFMRJ2TXK6nGd3whL3mmZKhT/E5MY6CL/4WcxU6NIss43xo8t7elLXJ0RmKCNNSYuOSuG/GqGoM
	ttqrumcegx8rhonpZzsighORRFshTqXMeb0w/GihFG6J/eU+kM4DSBIOfQ+DR2VH4hrJwsyWhj3To
	mKSrdNESPg2bjX53L+STCHx3p2e1kKJzrunnh/RuorflQYjKEZqmSs8rDaZ05kH2KpIvHb9FQnIq5
	uHVTy6bVueSFV2MMPm+LJM7ysWfhwGmMTBTbVV9VL89kTE4FVpFqa9hVVJFiIgDFlG7ICSC6DEv1f
	MSgbpwLavGXygmslt8wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOpb1-00000007puM-1kFj;
	Thu, 05 Nov 2026 05:01:07 +0000
Received: from mail-vs1-xe34.google.com ([2607:f8b0:4864:20::e34])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOpay-00000007pqA-0Qr0
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 05:01:05 +0000
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-7ce6cb4c6faso668254137.0
        for <kexec@lists.infradead.org>; Wed, 04 Nov 2026 21:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793854863; x=1794459663; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=x15wonZx4YKLKAV2h6RvhaJYvivDTh63oWX01b1gV+8=;
        b=T7t7Q4R5Nb9ubVEZU6Mwa8BXjggjGpeePc9BcaNk6f1DTY+YV6MSzrmr79sGF3Qiqm
         E1htIKTYlhGqnJpvhGHdoIeVvg/Rsv4yAxiBtD0L9cqVWh8KYWAPqLiEjgS6pdySNX9p
         vlFc2jpE6zWExWbAdCGdDe8JoFdBjsOLFn16YwoWshlZoVOlQbbqm0Ti06O8Z93y2yG2
         Zhp6LmN+fMXoTiQlKiNXkLPjjKYxjpkVKgUqItsLXZBCtVL+iVKbJ+f7Irqq+wnbA3Q7
         aNEsNbdwS54V4H+n7pWV7s9oyQ/d7aQNLJzawKqIMpTAYXTyonW5sNNfLes1n0TkmsDQ
         Joyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793854863; x=1794459663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=x15wonZx4YKLKAV2h6RvhaJYvivDTh63oWX01b1gV+8=;
        b=23zPmHmWngBy0OJsDSMMKcwtnw+OFlFlpqtHI7CJQ1cXcUTHpUFno4T+VA5nMRw2vp
         1jVXCNp0fqlsPaaNWCIFsuXLV1O0UdgUkWBxhaF76p9k+SjgFf6pgsvlzD6ITIOwziqj
         OcwftHx1mvxqTw7e2vdifKjsj1KUN4qBURcPfzZUFzsB0z0R3MmHi5UuqL1k6eg/KChL
         CTAly9JHZ44f0czi9t6P8Li3HtgXBLgyVv4aQIOQAI8FYEFD5EyGaI/1FsDRE8lc14LU
         0ca4wgmX7AOP3+LpCxkC3uSqL2nWL5HLF+HAM4WMojMaFRnL7OmliUgevLpjLQPmP3v7
         W0ow==
X-Forwarded-Encrypted: i=1; AKwUvByX8zcgHcDHiOlMDDyjMAvcGTl3KoX0GxLfocWJ1f7sooqGG1BZYi2zJfu++qXtPZAlEP5HiA==@lists.infradead.org
X-Gm-Message-State: APuU4Z8ztMgrNdat6BTfjA9XHUzmbeGvzDSZWreIHLMpduBjZ4rxb4lC
	wNG+z4/+WDpMC2mNmY044ulWSHH9woIAsg2k/sPLj9+I5EQbJcygXnGs8Q1V/Sti/lg=
X-Gm-Gg: AYBFou32/2+PCznlduZhlunYFOyuMNgJ/LeMDMa6lgUPMgp3GaHx32NPJNrNVjqsZ9w
	epFb+W9DgKsZk1TNphbRP+dySdpbTcBQa5lUQ0ytA66arKB7HTXRkLOmxHnAKTqQJ2ZGkGWxzQr
	GRiciRkN3QKl9NyHeLvGZbMsG9HRvoFGbb9WksCJr/G2UkFFFP6rIo1KOyF9xIA2XWcV6meWB3z
	pVBAVqXzX2THFMGrAuF7EiGlOLmaimRjairFGT7zHhrCau4wfcKHrp1nGK6ycmkHLCWT4i/hU+I
	rK3iSxLDpT/Rl4Vzg1/Oq1L7C57N8/fJFmJurSMe5ezJEiMRC+l7LO4GUPoFDOFLnPw7cGGxW7s
	sAIoCxSmgFGdG4EmueeqGQPIKxRd9payGxZU3YTZc2hehRLDmSsNe5uf/uXXtoJrPowtrwYh3Uq
	pzH7EnXF+YrYQ8cykXPuqAdVDAI0WKHmeL+XTbgZwKgIhxVBCVpywzNtwtQAVvWdBX6boC1UVoL
	Vk2ozFhopVGyp+9TMKTiFlYV6kRd696pEUqkaOG/sox5+oKqsLNZReOwKmcu6bWkXS/JxIpITuw
	rYMggojhrl33ciouq8kLuxkQPMMs56fJXy6HlpB2Jlo4u+QMAwN11Z0OIEcvbWqQZSKIYyhwP7F
	DhARF+saflxUrAz/ZExGwSmzPnkgmURTxgmWmGME7g3A/wIWXEQ==
X-Received: by 2002:a05:6102:2d0e:b0:7cc:174b:f7d8 with SMTP id ada2fe7eead31-7d072247ab2mr8278473137.1.1793854862693;
        Wed, 04 Nov 2026 21:01:02 -0800 (PST)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca8d9d62bsm3305282e0c.8.2026.11.04.21.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 21:01:02 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	shuah@kernel.org,
	linux-mm@kvack.org,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	vipinsh@google.com,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	pasha.tatashin@soleen.com,
	dmatlack@google.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	graf@amazon.com
Subject: [PATCH v5 4/6] liveupdate: luo_flb: support incremental outgoing FLB publication
Date: Thu,  5 Nov 2026 00:00:50 -0500
Message-ID: <20261105050053.3063001-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
In-Reply-To: <20261105050053.3063001-1-pasha.tatashin@soleen.com>
References: <20261105050053.3063001-1-pasha.tatashin@soleen.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_210104_201226_AA218165 
X-CRM114-Status: GOOD (  27.85  )
X-Spam-Score: -2.1 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When a session is published to KHO via luo_session_publish_one() ahead
of reboot, any FLBs that its preserved files depend on must already be
present in the outgoing KHO FLB array so the KHO tree remains
self-consistent.

Currently, outgoing FLB metadata in luo_ser->flbs_pa is populated only
during reboot by luo_flb_serialize(), leaving luo_ser->flbs_pa empty
when sessions are published earlier.

Publish outgoing FLBs from luo_session_publish_one() via
luo_file_publish_flbs() -> luo_flb_file_publish() ->
luo_flb_ser_publish_one(), and drop the now-redundant
luo_flb_serialize() pass from liveupdate_reboot(). For each published
file, luo_flb_ser_publish_one() either appends a new luo_flb_ser entry
with count = 1 using smp_store_release() on header_ser->count or
increments the existing entry's count in place, keeping the serialized
count equal to the exact number of published files in KHO without
including uncommitted sessions or transient
liveupdate_flb_get_outgoing() references.

FLB publication is one-way and never needs to unpublish: before reboot
it runs only when a session is committed, and a committed session never
unpreserves its files, keeping private->outgoing.count >= 1 until
reboot so flb->ops->unpreserve() is never called on a published FLB.
If more FDs using an already-published FLB are preserved later,
flb->ops->preserve() is not called again; file handlers update the
shared live object via liveupdate_flb_get_outgoing(). Consequently, FLB
handlers must:
- return a stable root KHO handle in argp->data from .preserve() whose
  address does not change as FDs are added later;
- synchronize concurrent mutations to outgoing.obj with their own lock;
- support per-FD rollback when uncommitted sessions close without
  disturbing already-committed entries.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_core.c     |  10 +--
 kernel/liveupdate/luo_file.c     |  16 +++++
 kernel/liveupdate/luo_flb.c      | 111 ++++++++++++++++++++-----------
 kernel/liveupdate/luo_internal.h |   3 +-
 kernel/liveupdate/luo_session.c  |   2 +
 5 files changed, 95 insertions(+), 47 deletions(-)

diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index 1b2bda22902d..9fef5161a1f3 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -219,18 +219,10 @@ late_initcall(luo_late_startup);
  */
 int liveupdate_reboot(void)
 {
-	int err;
-
 	if (!liveupdate_enabled())
 		return 0;
 
-	err = luo_session_serialize();
-	if (err)
-		return err;
-
-	luo_flb_serialize();
-
-	return 0;
+	return luo_session_serialize();
 }
 
 /**
diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index 988eb313a135..611b9967a3a9 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -380,6 +380,22 @@ void luo_file_unpreserve_files(struct luo_file_set *file_set)
 	kho_block_set_destroy(&file_set->block_set);
 }
 
+/**
+ * luo_file_publish_flbs - Publish FLBs for all preserved files in a file_set.
+ * @file_set: The file_set being published to the outgoing KHO subtree.
+ *
+ * Iterates through all preserved files in @file_set and ensures their
+ * associated FLB metadata is published in the outgoing KHO FLB array before
+ * the session itself becomes visible in KHO.
+ */
+void luo_file_publish_flbs(struct luo_file_set *file_set)
+{
+	struct luo_file *luo_file;
+
+	list_for_each_entry(luo_file, &file_set->files_list, list)
+		luo_flb_file_publish(luo_file->fh);
+}
+
 static int luo_file_freeze_one(struct luo_file_set *file_set,
 			       struct luo_file *luo_file)
 {
diff --git a/kernel/liveupdate/luo_flb.c b/kernel/liveupdate/luo_flb.c
index cd715a7c1d99..6cd87a9f8307 100644
--- a/kernel/liveupdate/luo_flb.c
+++ b/kernel/liveupdate/luo_flb.c
@@ -34,6 +34,15 @@
  * This reference-counted approach ensures that shared state is saved exactly
  * once and restored exactly once, regardless of how many files depend on it,
  * and that its lifecycle is correctly managed across the kexec transition.
+ *
+ * Serialization: Outgoing FLB metadata is published into the KHO FLB array
+ * incrementally as sessions are published to KHO (when committed early via
+ * LIVEUPDATE_SESSION_FREEZE_COMMIT or during reboot). Because a committed
+ * session never unpreserves its files, FLB publication is one-way: once
+ * published, the FLB's .unpreserve() callback is never invoked and its root
+ * KHO handle from .preserve() remains immutable in KHO, while later sessions
+ * may still add or remove per-FD state in the shared live object under the FLB
+ * handler's own synchronization.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -72,6 +81,13 @@ static struct luo_flb_global luo_flb_global = {
 	.list = LIST_HEAD_INIT(luo_flb_global.list),
 };
 
+/*
+ * Serializes updates to luo_flb_global.outgoing.header_ser and .ser[].
+ * Lock hierarchy:
+ *   luo_register_rwlock -> private->outgoing.lock -> luo_flb_ser_lock
+ */
+static DEFINE_MUTEX(luo_flb_ser_lock);
+
 /*
  * struct luo_flb_link - Links an FLB definition to a file handler's internal
  * list of dependencies.
@@ -104,6 +120,36 @@ static struct luo_flb_private *luo_flb_get_private(struct liveupdate_flb *flb)
 	return private;
 }
 
+static void luo_flb_ser_publish_one(const struct liveupdate_flb *flb, u64 data)
+{
+	struct luo_flb_header *fh = &luo_flb_global.outgoing;
+	u64 nr;
+
+	guard(mutex)(&luo_flb_ser_lock);
+	if (!fh->active)
+		return;
+
+	nr = fh->header_ser->count;
+	for (u64 i = 0; i < nr; i++) {
+		if (!strcmp(fh->ser[i].name, flb->compatible)) {
+			WRITE_ONCE(fh->ser[i].count, fh->ser[i].count + 1);
+			return;
+		}
+	}
+
+	if (WARN_ON_ONCE(nr >= LUO_FLB_MAX))
+		return;
+
+	strscpy(fh->ser[nr].name, flb->compatible, sizeof(fh->ser[nr].name));
+	fh->ser[nr].data = data;
+	fh->ser[nr].count = 1;
+	/*
+	 * Ensure the serialized FLB entry is visible before exposing the
+	 * incremented count to concurrent KHO readers.
+	 */
+	smp_store_release(&fh->header_ser->count, nr + 1);
+}
+
 static int luo_flb_file_preserve_one(struct liveupdate_flb *flb)
 {
 	struct luo_flb_private *private = luo_flb_get_private(flb);
@@ -296,6 +342,34 @@ void luo_flb_file_unpreserve(struct liveupdate_file_handler *fh)
 		liveupdate_flb_put_outgoing(iter->flb);
 }
 
+/**
+ * luo_flb_file_publish - Publish FLB metadata for a preserved file's handler.
+ * @fh: The file handler of the preserved file being published into KHO.
+ *
+ * Publishes each FLB associated with @fh into the outgoing KHO FLB array on
+ * first publication, or increments its serialized file reference count by one.
+ *
+ * Context: Called when a session containing preserved files is published into
+ *          the outgoing KHO subtree.
+ */
+void luo_flb_file_publish(struct liveupdate_file_handler *fh)
+{
+	struct list_head *flb_list = &ACCESS_PRIVATE(fh, flb_list);
+	struct luo_flb_link *iter;
+
+	guard(rwsem_read)(&luo_register_rwlock);
+	list_for_each_entry(iter, flb_list, list) {
+		struct luo_flb_private *private = luo_flb_get_private(iter->flb);
+
+		scoped_guard(mutex, &private->outgoing.lock) {
+			if (WARN_ON_ONCE(!refcount_read(&private->outgoing.count)))
+				continue;
+			luo_flb_ser_publish_one(iter->flb,
+						private->outgoing.data);
+		}
+	}
+}
+
 /**
  * luo_flb_file_finish - Notifies FLBs that a dependent file has been finished.
  * @fh: The file handler for the finished file.
@@ -587,40 +661,3 @@ void __init luo_flb_setup_incoming(u64 flbs_pa)
 	luo_flb_global.incoming.ser = (void *)(header_ser + 1);
 	luo_flb_global.incoming.active = true;
 }
-
-/**
- * luo_flb_serialize - Serializes all active FLB objects for KHO.
- *
- * This function is called from the reboot path. It iterates through all
- * registered File-Lifecycle-Bound (FLB) objects. For each FLB that has been
- * preserved (i.e., its reference count is greater than zero), it writes its
- * metadata into the memory region designated for Kexec Handover.
- *
- * The serialized data includes the FLB's compatibility string, its opaque
- * data handle, and the final reference count. This allows the new kernel to
- * find the appropriate handler and reconstruct the FLB's state.
- *
- * Context: Called from liveupdate_reboot() just before kho_finalize().
- */
-void luo_flb_serialize(void)
-{
-	struct luo_flb_header *fh = &luo_flb_global.outgoing;
-	struct liveupdate_flb *gflb;
-	int i = 0;
-
-	guard(rwsem_read)(&luo_register_rwlock);
-	list_private_for_each_entry(gflb, &luo_flb_global.list, private.list) {
-		struct luo_flb_private *private = luo_flb_get_private(gflb);
-		long count = refcount_read(&private->outgoing.count);
-
-		if (count > 0) {
-			strscpy(fh->ser[i].name, gflb->compatible,
-				sizeof(fh->ser[i].name));
-			fh->ser[i].data = private->outgoing.data;
-			fh->ser[i].count = count;
-			i++;
-		}
-	}
-
-	fh->header_ser->count = i;
-}
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index 01a172cd9d7a..a7253b48df80 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -103,6 +103,7 @@ int luo_session_deserialize(void);
 
 int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd);
 void luo_file_unpreserve_files(struct luo_file_set *file_set);
+void luo_file_publish_flbs(struct luo_file_set *file_set);
 int luo_file_freeze(struct luo_file_set *file_set);
 void luo_file_unfreeze(struct luo_file_set *file_set);
 int luo_retrieve_file(struct luo_file_set *file_set, u64 token,
@@ -115,11 +116,11 @@ void luo_file_set_destroy(struct luo_file_set *file_set);
 
 int luo_flb_file_preserve(struct liveupdate_file_handler *fh);
 void luo_flb_file_unpreserve(struct liveupdate_file_handler *fh);
+void luo_flb_file_publish(struct liveupdate_file_handler *fh);
 void luo_flb_file_finish(struct liveupdate_file_handler *fh);
 void luo_flb_unregister_all(struct liveupdate_file_handler *fh);
 int __init luo_flb_setup_outgoing(u64 *flbs_pa);
 void __init luo_flb_setup_incoming(u64 flbs_pa);
-void luo_flb_serialize(void);
 
 #ifdef CONFIG_LIVEUPDATE_TEST
 void liveupdate_test_register(struct liveupdate_file_handler *fh);
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index caf0e85081e8..713b9b400f07 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -233,6 +233,8 @@ static void luo_session_publish_one(struct luo_session *session)
 	if (!sh->published_count)
 		kho_block_set_it_init(&sh->it, &sh->block_set);
 
+	luo_file_publish_flbs(&session->file_set);
+
 	strscpy(entry.name, session->name, sizeof(entry.name));
 	entry.file_set_ser.count = session->file_set.count;
 	entry.file_set_ser.files =
-- 
2.56.0.398.g882cbad275-goog


