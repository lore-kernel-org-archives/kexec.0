Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DF660A2612
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 21:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ci9WBb7b;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=RRVbYw/3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=N1YtoeDwdmtEaztn3lsHUvSs0nnXrghWj9Y62uQyguw=; b=ci9WBb7bIj8q5j
	lTV36TldCdaxWyRW4x8sTyI6S99yH2v+d4bGHCoPWG+xrGrSSOxJ+8SaVEuqz3Je7QGfhqIbQwfLy
	qgbWBJfRRMND618JH0arPSH88OcgVFpTqYttdg/fYngsBK785/T5b2iRce3NA6ICDAe5HFb6toMyK
	UNWX3x0S+SDeOdIC/dXGDRLlUXjNOJG6OftCC27bD8wRter+aGQBzQEfxMdS7UHLyi2QB+udyIlST
	eM+1iPQKdZU8zWwk2YWY+j7zeCPulDvXZCfHaRh4C+AVNmBNSDgSE4mcUwwjhi3UuMddZKhaIuWMj
	HljW0EhDx6Trg66ToxPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTnDA-0000000AJgB-3SLk;
	Wed, 18 Nov 2026 21:29:00 +0000
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTnD3-0000000AJbY-3XWr
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 21:28:54 +0000
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-5eaaa9b1591so1135890e0c.3
        for <kexec@lists.infradead.org>; Wed, 18 Nov 2026 13:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1795037333; x=1795642133; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=N1YtoeDwdmtEaztn3lsHUvSs0nnXrghWj9Y62uQyguw=;
        b=RRVbYw/3oMlV18ADCdIt9bewvovvlHSc7SJW1yjWoDGP7UIqbBzAcwtElmuUhbtC7x
         JSyhHewDeVG++xlfqgb96/M6FvgDp36ph6hVVweha+Zz7uL8JHyU/BycKLJUFkDELhUy
         t4dTRrRGLbimH0hVGpSwB0+2khhrttXDGK0GVerFA1ogIVJWh0E6baWSE1g+CXUyKWOq
         dj0Osl6riBZvk2NZ26sljWS8UwcFAhfn7vxyz0hLJCzJtRfB1ydKJoQmmnFU6gYuN6hg
         thFuZPlr3rjbTIlfzgDLce23VRHoXQ1OkKPe3+qoFjm93lRrG8Eouo20CWyVltLiez3t
         XwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795037333; x=1795642133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=N1YtoeDwdmtEaztn3lsHUvSs0nnXrghWj9Y62uQyguw=;
        b=L+KC96Km09CLie0fFQreS1z0QAgdAGU8XKJ0mpZIsShm5EzMQEO8G1bbJgXvSpHtEX
         W8UjgQl7S6FsLN1mX4WshqoVaVjLdQxKpI+fzfsGiU6HTbQq6dfOKAect2sUUODpu2tC
         gl7PCt6sMrJXmAcn+8aI83li54THV4/eJnyUqAGtfdzrHWat5wTunOI85r6BK2GgdSbf
         skaAW9VnN34h3FCTry3db93ih07J+TEUccVZMtm2O3eduXaZmD/ijn3WJSBOmm/ckEEo
         qlYfVsUyqYhFibverG+WHCRadAy55TqJX2iRoaSFdNYxli2ZVhkLfUPbsSS1NORyTShI
         Odjw==
X-Forwarded-Encrypted: i=1; AL+hErF4EOTxR+306x3uIL84VcTyh7+BVMsieIKNLn+6AiB9UHtyacZs659wIMZLWWRp2hQROUz9qw==@lists.infradead.org
X-Gm-Message-State: APuU4Z9TxYVa6jS6LZv1Qxi26pkRImxYKzAWXuwCs8eH6mVLuHmSfmYe
	wt5nBtWZiauwbwk7pOs7Etwg/crSeCKYS65oy5qI0TK52JmqQGZ1ryb2o9/1JPJFYKo=
X-Gm-Gg: AYBFou1zFdt3YHYb7t8u+Hp2qpw9ypKBcYDz3V/RoOKe1KaGyJZkAzcfSoyN4HKaxa9
	APJi+EZPAdPz15CQS34wHbHXD3WsTbNgZBAtjkBxtaDjeZQ/9v29LZSH+U2KXrRB0XAa+M4/SyF
	rNuyBWe3HS8kBC3WJMTy5QZgSIF+etTiVzF5XpkdKmR1hN3GSTBHNdkLTSqfAlBW9taSTshNF42
	0q0LIf4otKNfZrd/sAiyf2telahaZOYhTd1oARDFizZUo1blEE8OFML+OQHJNYoaRWdJwLogBf8
	ow3WQiPZ+Qf/lSjfl6KLaT5aTqB6Qj5wAZKPrEpR7V9TRr9BPYM0KShuacYGpFphFhBd6T+39HO
	spMkuQM8uMdzn7rFdQ1FbK9onP5P87Nf6rmzAtjF+/6GdKIU4ZFPTI3SjE8Sy8Hw+Sp7rFPXdoO
	nouB03rR/JVTQi1DncUAunT9h8+P3DiHriSVBECQD7ruunIQdig8d9BHO66Uqik00JuAnT6g/va
	0tjYFB5CTcrdjViM2BYVFNTEOTCFYL6PoDyUWKR5A/zp08IP6IkYxBFUscjNGtoN45CU+OTqKIf
	PbRuk/df7ZY8T50NlkUOgE/Kh86bxYKFLXdx3ffLsFr58Yb02ixELp3b2hF1zSYh06/KlquipfM
	OMQzAwrMtU84Sb3gDzjV/+9u4P9IsfbsUztTzID+uH2VRxRWb8hqKG6+yvTZrf4MlDrBtl1qXCA
	==
X-Received: by 2002:a05:6102:943:b0:7cc:174b:f7c3 with SMTP id ada2fe7eead31-7d6ba465cadmr1768828137.30.1795037332845;
        Wed, 18 Nov 2026 13:28:52 -0800 (PST)
Received: from soleen.c.googlers.com.com (57.233.150.34.bc.googleusercontent.com. [34.150.233.57])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b9185bc3sm2724635137.5.2026.11.18.13.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 13:28:51 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	shuah@kernel.org,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	vipinsh@google.com,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	linux-api@vger.kernel.org,
	pasha.tatashin@soleen.com,
	dmatlack@google.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	graf@amazon.com
Subject: [PATCH v6 4/7] liveupdate: luo_flb: serialize outgoing FLBs incrementally
Date: Wed, 18 Nov 2026 16:28:39 -0500
Message-ID: <20261118212845.2855249-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
In-Reply-To: <20261118212845.2855249-1-pasha.tatashin@soleen.com>
References: <20261118212845.2855249-1-pasha.tatashin@soleen.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_132853_913906_9B2B2670 
X-CRM114-Status: GOOD (  24.02  )
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

Currently, outgoing FLB metadata is written in a single pass by
luo_flb_serialize() during liveupdate_reboot(). When sessions are
serialized ahead of reboot, any FLBs their files depend on must also
be serialized at that time so the outgoing KHO state stays consistent.

Serialize each file's FLB dependencies from luo_session_serialize_one(),
appending new FLB entries or incrementing the serialized file count in
place. Since every serialized session now updates its FLBs as it is
serialized, drop the separate luo_flb_serialize() pass from
liveupdate_reboot().

Because serialized sessions never unpreserve their files, FLB
serialization is one-way: once an FLB is serialized, its .unpreserve()
callback will not run and its root handle from .preserve() remains
fixed for the rest of the boot.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_core.c     |  10 +--
 kernel/liveupdate/luo_file.c     |  15 +++++
 kernel/liveupdate/luo_flb.c      | 102 ++++++++++++++++++++-----------
 kernel/liveupdate/luo_internal.h |   3 +-
 kernel/liveupdate/luo_session.c  |   2 +
 5 files changed, 85 insertions(+), 47 deletions(-)

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
index 988eb313a135..cdd3c466e5ac 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -380,6 +380,21 @@ void luo_file_unpreserve_files(struct luo_file_set *file_set)
 	kho_block_set_destroy(&file_set->block_set);
 }
 
+/**
+ * luo_file_serialize_flbs - Serialize FLBs for all preserved files in a file_set.
+ * @file_set: The file_set being serialized.
+ *
+ * Iterates through all preserved files in @file_set and serializes their
+ * associated FLB metadata into the outgoing KHO FLB array.
+ */
+void luo_file_serialize_flbs(struct luo_file_set *file_set)
+{
+	struct luo_file *luo_file;
+
+	list_for_each_entry(luo_file, &file_set->files_list, list)
+		luo_flb_file_serialize(luo_file->fh);
+}
+
 static int luo_file_freeze_one(struct luo_file_set *file_set,
 			       struct luo_file *luo_file)
 {
diff --git a/kernel/liveupdate/luo_flb.c b/kernel/liveupdate/luo_flb.c
index cd715a7c1d99..4ac534171d42 100644
--- a/kernel/liveupdate/luo_flb.c
+++ b/kernel/liveupdate/luo_flb.c
@@ -34,6 +34,12 @@
  * This reference-counted approach ensures that shared state is saved exactly
  * once and restored exactly once, regardless of how many files depend on it,
  * and that its lifecycle is correctly managed across the kexec transition.
+ *
+ * Serialization: Outgoing FLB metadata is serialized into the KHO FLB array
+ * incrementally as sessions are serialized. Once serialized, the FLB's
+ * .unpreserve() callback is never invoked and its root KHO handle from
+ * .preserve() remains fixed, while later sessions may still update per-FD
+ * state in the shared live object under the FLB handler's own locking.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -72,6 +78,13 @@ static struct luo_flb_global luo_flb_global = {
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
@@ -104,6 +117,32 @@ static struct luo_flb_private *luo_flb_get_private(struct liveupdate_flb *flb)
 	return private;
 }
 
+static void luo_flb_serialize_one(const struct liveupdate_flb *flb, u64 data)
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
+			fh->ser[i].count++;
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
+	fh->header_ser->count = nr + 1;
+}
+
 static int luo_flb_file_preserve_one(struct liveupdate_flb *flb)
 {
 	struct luo_flb_private *private = luo_flb_get_private(flb);
@@ -296,6 +335,32 @@ void luo_flb_file_unpreserve(struct liveupdate_file_handler *fh)
 		liveupdate_flb_put_outgoing(iter->flb);
 }
 
+/**
+ * luo_flb_file_serialize - Serialize FLB metadata for a preserved file's handler.
+ * @fh: The file handler of the preserved file being serialized.
+ *
+ * Adds each FLB associated with @fh to the outgoing KHO FLB array on first
+ * use, or increments its serialized file reference count by one.
+ *
+ * Context: Called when a session containing preserved files is serialized.
+ */
+void luo_flb_file_serialize(struct liveupdate_file_handler *fh)
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
+			luo_flb_serialize_one(iter->flb, private->outgoing.data);
+		}
+	}
+}
+
 /**
  * luo_flb_file_finish - Notifies FLBs that a dependent file has been finished.
  * @fh: The file handler for the finished file.
@@ -587,40 +652,3 @@ void __init luo_flb_setup_incoming(u64 flbs_pa)
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
index 77dac2742877..3d948279f018 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -106,6 +106,7 @@ int luo_session_deserialize(void);
 
 int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd);
 void luo_file_unpreserve_files(struct luo_file_set *file_set);
+void luo_file_serialize_flbs(struct luo_file_set *file_set);
 int luo_file_freeze(struct luo_file_set *file_set);
 void luo_file_unfreeze(struct luo_file_set *file_set);
 int luo_retrieve_file(struct luo_file_set *file_set, u64 token,
@@ -118,11 +119,11 @@ void luo_file_set_destroy(struct luo_file_set *file_set);
 
 int luo_flb_file_preserve(struct liveupdate_file_handler *fh);
 void luo_flb_file_unpreserve(struct liveupdate_file_handler *fh);
+void luo_flb_file_serialize(struct liveupdate_file_handler *fh);
 void luo_flb_file_finish(struct liveupdate_file_handler *fh);
 void luo_flb_unregister_all(struct liveupdate_file_handler *fh);
 int __init luo_flb_setup_outgoing(u64 *flbs_pa);
 void __init luo_flb_setup_incoming(u64 flbs_pa);
-void luo_flb_serialize(void);
 
 #ifdef CONFIG_LIVEUPDATE_TEST
 void liveupdate_test_register(struct liveupdate_file_handler *fh);
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 56d7f76c0282..013386534b69 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -222,6 +222,8 @@ static void luo_session_serialize_one(struct luo_session *session)
 	if (WARN_ON_ONCE(!ser))
 		return;
 
+	luo_file_serialize_flbs(&session->file_set);
+
 	strscpy(ser->name, session->name, sizeof(ser->name));
 	ser->file_set_ser.count = session->file_set.count;
 	ser->file_set_ser.files =
-- 
2.56.1.708.g77570a6a1d-goog


