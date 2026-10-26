Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77067606A325
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 01:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wo9nlwOV;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=bq5B+11S
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Gj50Wyl35b8FQCs8zNwzAdmPqWzyuGVVyabxqbOdDKA=; b=wo9nlwOVgP9BH5
	CsN7Rayi9lG1l6gx4/KsFWhbzF/MvAmD2gw7SwJgHfaI6RiZ91PsctzCVU3YCGW5aF///e5FBVZ6i
	l/TE7PxjZd6xPFtIy59emzXxeO+JrOWh9wOL586ppREqgCwfY4szTrM6FjpGwmKM9zoIihLX1KJJj
	UhQI+rj/Gfdup3Ddc/he43ZEuLQaCGXRNxam+zdHOl2GJRFf793ljC6epqD5sio3FJkLvPVmWamRb
	oNnuJBGBbXt37zlwthepcdtXxBNafoblRkmmGG8Eo7B8oINdIBFjeNYN2NQltulMozE2nRBlcvM6z
	gRocnRmAjMy+yTBECOpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL9qX-00000001a6n-0lUi;
	Mon, 26 Oct 2026 01:49:57 +0000
Received: from mail-vs1-xe31.google.com ([2607:f8b0:4864:20::e31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xL9qT-00000001a59-0HVD
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 01:49:54 +0000
Received: by mail-vs1-xe31.google.com with SMTP id ada2fe7eead31-745497ac8fcso1046964137.0
        for <kexec@lists.infradead.org>; Sun, 25 Oct 2026 18:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792979392; x=1793584192; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gj50Wyl35b8FQCs8zNwzAdmPqWzyuGVVyabxqbOdDKA=;
        b=bq5B+11SL8OjLYfCayktzCzQ4mK+pDh6tk35iEpfTyNuQR6OBcVJZF1AikiOI6MWpq
         tt+trek6d7NjztDKwxqqMCOPO4BPSw9Gr1D9QKbFK6CmeT/3GCmZgVpPh6uSmfB7xcZ+
         yNy0jf2/YvlK8q7TXZtVpAAdrmWE5O0q0a3MkVu7RitkEtMbBfgUqXxAHk6hOLfrxMVD
         pOmIRK+gLUUeMj5sIeA4po+cmyPTrNaiTVnBU1dazTn1SW9boZLqx1QtMWfZqiTI1PuM
         OkxiElyq40vy6jrFEaVcN3C5wR8GhFxbk0klE1QL3Nr7JQmOVHPXl6ri7XJxnApuG6BC
         s3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792979392; x=1793584192;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gj50Wyl35b8FQCs8zNwzAdmPqWzyuGVVyabxqbOdDKA=;
        b=z1hKJzgURBP6QRdNBD4ORzu532ODWLij5e/FW+wmE7CWam8pIlkP4DoDQuRa/wqKN+
         IUkNO+l7GPBikKq9t8R+uERrOT7Lx4qi9PoswtApzoSr7LU82sLXDGaTuCc/DHIgeigQ
         g5WFCn9zprZRQjKZsmeai4yAlXR6rOWUL20xLqgfbAZT5BJDaJCnkaPIxg4lobFhy0GC
         EHCVZzl1m8CwXjqe4X2cpIb24SvwPYW10LCt/iqYEie7ZBI68Y8i3lQytAjjMQLAtJMd
         c//I6QjUhDHy1ZdW4QEUP/BhASf5aoNrd/8Q2XC1LbCZ0X0ymB29i2CGrl+qj9ich4Wk
         xjPw==
X-Forwarded-Encrypted: i=1; AKwUvByB+s442hFozzSvp0il1QEeeOGFH9z8208vtLnP4DBeHZd0VI0uLy4P+tFTGqr+P04vh9IxkQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYL+FGc9ld2/Bi5n53yH39GBMVOBFZ0ASet16REk7VO7aNrgxyu8
	VU+54u7EOygKwIkSltLg69bLTngL/2UCjBZ/AFLWGtYxDP6ticnLYvOW0GPiwhah2XU=
X-Gm-Gg: AYBFou1q4WbtYWKm+bJRcKiwCjXoBSxQ+SCEv9gtD6BLS8qtVQmsKPS7pGIO6BoMEFc
	t7tphkNx69vy6NgzqdCy4Va/Rtbr9I5a2e6vb54/ETNj9PM8xFXKUTsKDvngRYKlbMueo/vZw1G
	8/ODlQVz5VC1busip9PqOEtAj4U2C5SswzCfW2nPzShf8+LkBk34aY3gJyfCUYBoZXntIasvMBR
	f1UtBUDb0i/89aM6a1CQZO8Qn1SPwURwzFxMnTNiMFOxr98U5ZVSp+xJDcpLQOyxa1NojlNtgQs
	LUFkiGByuvBvp7zlzSK/BJXdxhjbPYBLAZCxjLaZbGwEihWWtRHoFwetWVRXDEkfvTjpUI/CNhY
	v7pKoNOEjLoFmZmA73JA+Ne3fLQlbwBuQWiyJM5N7gHsPWuW9yyNwnrGRozbytbupVHa+bOPP0j
	jrhQBrrVTcjzXm/T63B4LYDD0dRYSfwwPg148St/qb8GzOmhe/E6wUG3jRCnUHxHDqshvvOtCxu
	vC5FRJUY4tRo8ezpXFGlGw6mfENdvYqw8BeH545Yyc+Z+6m8e1BS0VoXzrFYj2ihv/xYkBLZJnd
	ctAa43xRUJPMGx1KWBNU/BgBa5ahEM2yZyCNoNR3Fgl61468Qd5TPZuQEHQM+fb/4OZnE/Lv1Zs
	I
X-Received: by 2002:a05:6102:38ce:b0:7a6:b8fe:e834 with SMTP id ada2fe7eead31-7ce5cd91472mr1215927137.27.1792979391619;
        Sun, 25 Oct 2026 18:49:51 -0700 (PDT)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7ce5df73970sm6099917137.1.2026.10.25.18.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 18:49:51 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	shuah@kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	vipinsh@google.com,
	linux-kernel@vger.kernel.org,
	pasha.tatashin@soleen.com,
	dmatlack@google.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	graf@amazon.com
Subject: [PATCH v4 1/3] liveupdate: Move file_set_ser handling to session serialization helpers
Date: Sun, 25 Oct 2026 21:49:44 -0400
Message-ID: <20261026014948.162559-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
In-Reply-To: <20261026014948.162559-1-pasha.tatashin@soleen.com>
References: <20261026014948.162559-1-pasha.tatashin@soleen.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261025_184953_128591_CE559EBD 
X-CRM114-Status: GOOD (  17.20  )
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
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently, struct luo_session_ser is populated and cleared across two
layers: luo_session_serialize() writes and clears ser->name, while
luo_file_freeze() and luo_file_unfreeze() write and clear
ser->file_set_ser.

In preparation for allowing userspace to freeze a session explicitly
before kexec reboot, luo_file_freeze() and luo_file_unfreeze() need to
be called on session->file_set before any struct luo_session_ser entry
is reserved in luo_session_serialize().

Drop the struct luo_file_set_ser pointer parameter from
luo_file_freeze() and luo_file_unfreeze(), and rename
luo_session_freeze_one() and luo_session_unfreeze_one() to
luo_session_serialize_one() and luo_session_unserialize_one() so that
all fields of struct luo_session_ser are populated and cleared in one
place.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_file.c     | 24 ++++++++----------------
 kernel/liveupdate/luo_internal.h |  6 ++----
 kernel/liveupdate/luo_session.c  | 31 ++++++++++++++++++++-----------
 3 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
index a39992da504f..988eb313a135 100644
--- a/kernel/liveupdate/luo_file.c
+++ b/kernel/liveupdate/luo_file.c
@@ -440,8 +440,7 @@ static void __luo_file_unfreeze(struct luo_file_set *file_set,
 
 /**
  * luo_file_freeze - Freezes all preserved files and serializes their metadata.
- * @file_set:     The file_set whose files are to be frozen.
- * @file_set_ser: Where to put the serialized file_set.
+ * @file_set: The file_set whose files are to be frozen.
  *
  * This function is called from the reboot() syscall path, just before the
  * kernel transitions to the new image via kexec. Its purpose is to perform the
@@ -457,8 +456,8 @@ static void __luo_file_unfreeze(struct luo_file_set *file_set,
  *
  * 2. Serializes Metadata: After a successful freeze, it copies the final file
  *    metadata—the handler's compatible string, the user token, and the final
- *    private data handle—into the pre-allocated contiguous memory buffer
- *    (file_set->files) that will be handed over to the next kernel via KHO.
+ *    private data handle—into the pre-allocated serialization blocks
+ *    (file_set->block_set) that will be handed over to the next kernel via KHO.
  *
  * Error Handling (Rollback):
  * This function is atomic. If any handler's .freeze() operation fails, the
@@ -471,8 +470,7 @@ static void __luo_file_unfreeze(struct luo_file_set *file_set,
  * Context: Called only from the liveupdate_reboot() path.
  * Return: 0 on success, or a negative errno on failure.
  */
-int luo_file_freeze(struct luo_file_set *file_set,
-		    struct luo_file_set_ser *file_set_ser)
+int luo_file_freeze(struct luo_file_set *file_set)
 {
 	struct luo_file *luo_file;
 	struct kho_block_set_it it;
@@ -506,9 +504,6 @@ int luo_file_freeze(struct luo_file_set *file_set,
 		file_ser->token = luo_file->token;
 	}
 
-	file_set_ser->count = file_set->count;
-	file_set_ser->files = kho_block_set_head_pa(&file_set->block_set);
-
 	return 0;
 
 err_unfreeze:
@@ -519,28 +514,25 @@ int luo_file_freeze(struct luo_file_set *file_set,
 
 /**
  * luo_file_unfreeze - Unfreezes all files in a file_set and clear serialization
- * @file_set:     The file_set whose files are to be unfrozen.
- * @file_set_ser: Serialized file_set.
+ * @file_set: The file_set whose files are to be unfrozen.
  *
  * This function rolls back the state of all files in a file_set after the
  * freeze phase has begun but must be aborted. It is the counterpart to
  * luo_file_freeze().
  *
  * It invokes the __luo_file_unfreeze() helper with a NULL argument, which
- * signals the helper to iterate through all files in the file_set and call
- * their respective .unfreeze() handler callbacks.
+ * signals the helper to iterate through all files in the file_set, call their
+ * respective .unfreeze() handler callbacks, and clear the serialized blocks.
  *
  * Context: This is called when the live update is aborted during
  *          the reboot() syscall, after luo_file_freeze() has been called.
  */
-void luo_file_unfreeze(struct luo_file_set *file_set,
-		       struct luo_file_set_ser *file_set_ser)
+void luo_file_unfreeze(struct luo_file_set *file_set)
 {
 	if (!file_set->count)
 		return;
 
 	__luo_file_unfreeze(file_set, NULL);
-	memset(file_set_ser, 0, sizeof(*file_set_ser));
 }
 
 /**
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index dac6644bfb18..01a172cd9d7a 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -103,10 +103,8 @@ int luo_session_deserialize(void);
 
 int luo_preserve_file(struct luo_file_set *file_set, u64 token, int fd);
 void luo_file_unpreserve_files(struct luo_file_set *file_set);
-int luo_file_freeze(struct luo_file_set *file_set,
-		    struct luo_file_set_ser *file_set_ser);
-void luo_file_unfreeze(struct luo_file_set *file_set,
-		       struct luo_file_set_ser *file_set_ser);
+int luo_file_freeze(struct luo_file_set *file_set);
+void luo_file_unfreeze(struct luo_file_set *file_set);
 int luo_retrieve_file(struct luo_file_set *file_set, u64 token,
 		      struct file **filep);
 int luo_file_finish(struct luo_file_set *file_set);
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index f48e9a4185f9..827f9ad1938f 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -218,18 +218,30 @@ static int luo_session_finish_one(struct luo_session *session)
 	return luo_file_finish(&session->file_set);
 }
 
-static void luo_session_unfreeze_one(struct luo_session *session,
-				     struct luo_session_ser *ser)
+static void luo_session_unserialize_one(struct luo_session *session,
+					struct luo_session_ser *ser)
 {
 	guard(mutex)(&session->mutex);
-	luo_file_unfreeze(&session->file_set, &ser->file_set_ser);
+	luo_file_unfreeze(&session->file_set);
+	memset(ser, 0, sizeof(*ser));
 }
 
-static int luo_session_freeze_one(struct luo_session *session,
-				  struct luo_session_ser *ser)
+static int luo_session_serialize_one(struct luo_session *session,
+				     struct luo_session_ser *ser)
 {
+	int err;
+
 	guard(mutex)(&session->mutex);
-	return luo_file_freeze(&session->file_set, &ser->file_set_ser);
+	err = luo_file_freeze(&session->file_set);
+	if (err)
+		return err;
+
+	strscpy(ser->name, session->name, sizeof(ser->name));
+	ser->file_set_ser.count = session->file_set.count;
+	ser->file_set_ser.files =
+		kho_block_set_head_pa(&session->file_set.block_set);
+
+	return 0;
 }
 
 static int luo_session_release(struct inode *inodep, struct file *filep)
@@ -656,13 +668,11 @@ int luo_session_serialize(void)
 			goto err_undo;
 		}
 
-		err = luo_session_freeze_one(session, ser);
+		err = luo_session_serialize_one(session, ser);
 		if (err) {
 			kho_block_set_it_prev(&it);
 			goto err_undo;
 		}
-
-		strscpy(ser->name, session->name, sizeof(ser->name));
 	}
 
 	if (sh->count > 0)
@@ -675,8 +685,7 @@ int luo_session_serialize(void)
 	list_for_each_entry_continue_reverse(session, &sh->list, list) {
 		struct luo_session_ser *ser = kho_block_set_it_prev(&it);
 
-		luo_session_unfreeze_one(session, ser);
-		memset(ser->name, 0, sizeof(ser->name));
+		luo_session_unserialize_one(session, ser);
 	}
 	up_write(&sh->rwsem);
 	up_write(&luo_session_serialize_rwsem);
-- 
2.56.0.307.g5fe7bd680c-goog


