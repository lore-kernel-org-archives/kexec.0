Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF00606D82C
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 05:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Lfo6Me0J;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=JEs3p6ND
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=3dC/2UP23mv3BH3OYo6bEH5lmwGOxjF2IHkUty9s/lM=; b=Lfo6Me0JRYNyp2
	50s5pPEw9lXeoi2IaLmVBIDvFLsxUXO2qnT2Fa/ZRMJEYTveMqFXghmk7WEg7rfL4qzTxObke+MoC
	hM6hdSBwG0rFOK9rQIxS0Ai5obZUfzjiSc/XI/qBbFMF8vRETAK/reFxNhhbhM9kWrhyTdVx4QFM2
	NabO7OnKMvNyUs5Ay0JbnWBRoTthmGiWtEsMsjl5Rlp0YJx2DaGy4CW4VQCILbmQf3s4Kt8Qy0uy2
	AE9UKvr+ravVO9IGaUPG+rSHSJwr+3WrkPi8tp99xHCyp5rUYq0th/vTdbW4wqDynziTFuK6F5oBA
	G96hgg3rYa3a5QFYWsjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOpay-00000007prA-36we;
	Thu, 05 Nov 2026 05:01:04 +0000
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOpau-00000007poM-0Q67
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 05:01:01 +0000
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-5eaefe5b523so1062739e0c.0
        for <kexec@lists.infradead.org>; Wed, 04 Nov 2026 21:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793854859; x=1794459659; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3dC/2UP23mv3BH3OYo6bEH5lmwGOxjF2IHkUty9s/lM=;
        b=JEs3p6NDRXqLr2/QE6OPx1EQSzf6pohZcPQrY+b5m6tRswMd5JHIe40+BFb9SVUax2
         eY5k4HQt2FwDZfnaiD/K3CPgzK/TGKfCwGUiHFsp4PWSGydprpW2LBmUAruqP+RUTUFl
         sPrN6frR8CDAqCDW4n2SEIC1sRr4kpBWhpu8OWkJCDBFcW1sNddY16awd3sYNwHxQLKd
         wiJkMHA+dq9xy1V8LsqV08kvEA1T5V1cji8Owl3AHDGajW+Ty7QrQOptQIIEWlKZOkus
         nORU4zcgpDSpI1cgapNBa0bXRZ32yzYNce50G3bt0tVNSy7JKgY8QaEOrtBMTE/AYJyD
         QftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793854859; x=1794459659;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3dC/2UP23mv3BH3OYo6bEH5lmwGOxjF2IHkUty9s/lM=;
        b=lzaovtn6E9jlb0WvLA7ZE5JAutOwgvsbTaGB3JsQcphnFAJX7fC90KHA1txou7kKQc
         KpDnyHnHUcE4TsCU8Bz7t9CKrqcjzm7h70DPVX1fJzNprB5lnY1odVJiJuH5UseNVGjL
         OvvpJ6S67h09YlotRL94QRrqEOix93h8cStXOcjQJjuHhp0TBNVxPh64LBei/wchidZx
         kb1phFwcDY0GyY9G+8HQafqI/gKRgPH186AziofJGNbgmsIK1iCVjoxdX8NoD8KogtsP
         zQUPkdh03Bj2DQSxJZza5J6bhmD7pL98OOwMUC2sAA71yLNwT9Fl8gJpeyrLpO023fNX
         8Csg==
X-Forwarded-Encrypted: i=1; AKwUvBwKZF6BDN+znRCinwA0uVa/2tYP3m5e9budIkl3O6HJD1mAnLd3lMqp7IsOiTNb446+4+8T7Q==@lists.infradead.org
X-Gm-Message-State: APuU4Z/EHs9LWgkDt05/4QsahcYesjQxjmdwtbGubNc7lTnWoinLILBq
	8J5A9mHMx1PNzT6XKtEWsSqp+v9xIxIGdJoxA2oFn2pgwm17KqnTUz1et9P8moW8TmM=
X-Gm-Gg: AYBFou2RhXxcAma1oMBhzOT52EHOLFCnkJc4cullNyfrx/DaiXs+sDoOxQ4KZhgljES
	h+uoi2jzn2uPeodskvAkwSqpcmG8ck9wscxGVKqkumbavLvQGOL6IIyNFKjX/pbzCDmXfWgXGkx
	JHl69+m3Y9WX9liCvb/b8MVREywI05eh6mnTmt3u0creAWoSESKSv/0msmGNQtB2xm5+XzZpcme
	boqIrNcieFPy+5HoZnHSlKxEBE9N5rWVFe7HQVrigutiY6sYrMBUih3D2eMtu2ETfP4Qwps6MHL
	BhZGj4PT+eAzXF4TA/EZ/JHPEWwOwr1fGJiBD8zrucwG4E+T0wv34JRwYmNAaqKi04xkpTO4I/B
	/ImP9ibgMzY9PYlchaEHDqLsSisBAlFCaaRkB2C0EOw+6tfBAvN4GlU7UobC7W3EoLGL1RYqfAX
	vjJTh53lFMYIEWcdu6kiOmXzQBniCTU/9++KMavrStnfJq9TSyHk6SNMvKaJBk40Sd/ruSOYVSg
	u1CKPBufl9n+suLWE3w1PYOYhQGLUmQLIm/nV9QotI3vjfg9dooIMY4jjepVeh1BOM9GmP54ZK0
	EciuwXpqtmMr46JMk0aLi7r0HS+PPpTpLUc2SuiYuVIVaDPvbVy1GYUEw6GUTotHNXNz1s/BD5B
	tpXQDhpSCHgn9AJ/WELIzMuzMfsloqYHwFAFjm/k7+FJFZJAEEQ==
X-Received: by 2002:a05:6122:e443:b0:5ea:e197:702e with SMTP id 71dfb90a1353d-5ec6899db99mr8875283e0c.20.1793854858748;
        Wed, 04 Nov 2026 21:00:58 -0800 (PST)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca8d9d62bsm3305282e0c.8.2026.11.04.21.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 21:00:58 -0800 (PST)
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
Subject: [PATCH v5 1/6] liveupdate: Move file_set_ser handling to luo_session_serialize()
Date: Thu,  5 Nov 2026 00:00:47 -0500
Message-ID: <20261105050053.3063001-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
In-Reply-To: <20261105050053.3063001-1-pasha.tatashin@soleen.com>
References: <20261105050053.3063001-1-pasha.tatashin@soleen.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_210100_162011_7A2AAA77 
X-CRM114-Status: GOOD (  16.64  )
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In preparation for allowing userspace to freeze a session explicitly
before kexec reboot, luo_file_freeze() and luo_file_unfreeze() need to
be called on session->file_set before any struct luo_session_ser entry
is reserved in luo_session_serialize().

Currently, struct luo_session_ser is populated and cleared across two
layers: luo_session_serialize() writes and clears ser->name, while
luo_file_freeze() and luo_file_unfreeze() write and clear
ser->file_set_ser.

Drop the struct luo_file_set_ser pointer parameter from
luo_file_freeze() and luo_file_unfreeze() (and struct luo_session_ser
from luo_session_freeze_one() and luo_session_unfreeze_one()), and
populate and clear all fields of struct luo_session_ser in
luo_session_serialize().

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_file.c     | 24 ++++++++----------------
 kernel/liveupdate/luo_internal.h |  6 ++----
 kernel/liveupdate/luo_session.c  | 19 ++++++++++---------
 3 files changed, 20 insertions(+), 29 deletions(-)

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
index 74bc66929f4b..6dea35911181 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -219,18 +219,16 @@ static int luo_session_finish_one(struct luo_session *session)
 	return luo_file_finish(&session->file_set);
 }
 
-static void luo_session_unfreeze_one(struct luo_session *session,
-				     struct luo_session_ser *ser)
+static void luo_session_unfreeze_one(struct luo_session *session)
 {
 	guard(mutex)(&session->mutex);
-	luo_file_unfreeze(&session->file_set, &ser->file_set_ser);
+	luo_file_unfreeze(&session->file_set);
 }
 
-static int luo_session_freeze_one(struct luo_session *session,
-				  struct luo_session_ser *ser)
+static int luo_session_freeze_one(struct luo_session *session)
 {
 	guard(mutex)(&session->mutex);
-	return luo_file_freeze(&session->file_set, &ser->file_set_ser);
+	return luo_file_freeze(&session->file_set);
 }
 
 static int luo_session_release(struct inode *inodep, struct file *filep)
@@ -657,13 +655,16 @@ int luo_session_serialize(void)
 			goto err_undo;
 		}
 
-		err = luo_session_freeze_one(session, ser);
+		err = luo_session_freeze_one(session);
 		if (err) {
 			kho_block_set_it_prev(&it);
 			goto err_undo;
 		}
 
 		strscpy(ser->name, session->name, sizeof(ser->name));
+		ser->file_set_ser.count = session->file_set.count;
+		ser->file_set_ser.files =
+			kho_block_set_head_pa(&session->file_set.block_set);
 	}
 
 	if (sh->count > 0)
@@ -676,8 +677,8 @@ int luo_session_serialize(void)
 	list_for_each_entry_continue_reverse(session, &sh->list, list) {
 		struct luo_session_ser *ser = kho_block_set_it_prev(&it);
 
-		luo_session_unfreeze_one(session, ser);
-		memset(ser->name, 0, sizeof(ser->name));
+		luo_session_unfreeze_one(session);
+		memset(ser, 0, sizeof(*ser));
 	}
 	up_write(&sh->rwsem);
 	up_write(&luo_session_serialize_rwsem);
-- 
2.56.0.398.g882cbad275-goog


