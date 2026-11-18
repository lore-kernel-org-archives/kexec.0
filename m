Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4053C60A2612
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 21:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=w4qW9acs;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=TnO9fQM/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=rcOKrKC5VH2EJYd32jje86IEEuy7ivHNpMjvoLy4Pag=; b=w4qW9acsBKoDs+
	ZtNZJ08/8pktAU5vLF5lQWs9fTdSCNjx+qSLsb9fGo0h5YeJFWMB/S2dCuFWd0c/rfARO9tcl8rhp
	lCTmS8n+ZeyU8bs5MF+PPf1Lkt54NSI9bm6KzdKX64Uv/upSOycdtg+c8JD9NCscfv/TRZfh23adW
	zzgnJhLqzXIZFw4DMAtxOghzjpjEaKM03v8KIt8ceO4ChqZpYlFBevpZvByO6BFZL/VOoEMaJ2fDz
	BuQo3Rx/pvLkScizt062UTZEufAaOgFAnIvD6qf1Ldp8qKFmIEHoOUIJuSmIgvuUM+mgcSSdBCRQ3
	rzGJV5/6ONm1q7Z6gPvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTnD8-0000000AJdj-1Wga;
	Wed, 18 Nov 2026 21:28:58 +0000
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTnD1-0000000AJaV-0KNx
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 21:28:52 +0000
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-9851592ada1so448989241.0
        for <kexec@lists.infradead.org>; Wed, 18 Nov 2026 13:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1795037330; x=1795642130; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rcOKrKC5VH2EJYd32jje86IEEuy7ivHNpMjvoLy4Pag=;
        b=TnO9fQM/G0+9wGC73RYhgaSEsZTA4kAjUvgLtbAik06ffqgdVp/aUtBz2aGFDSa2fq
         zJl0Y13U+Swf2ZsvOCyy/B0sxBQ1bEIio7kPC1PcAOxxjZRYFQQ3SJ6QlQKRFuL+rvSx
         d9YHnV4Ag36QaEzR4dH+a6r1Kba4OjxxvE3ZEovZu1rDAvWARO1tQ9v3cNoXZn+0V0Kt
         WikQMBEDoJKCyyGUSiRv4lYAB5sXYovtoF89oboIOTyNELlmeqviWn05hGI3kaoMhzSd
         fb+E44oiIx3YJjR1Ffw5y4TbWvo/z4SqgUuZ3EPDk2/CapVH21yPHNRQ0/snwlkdJ9g1
         VX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795037330; x=1795642130;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rcOKrKC5VH2EJYd32jje86IEEuy7ivHNpMjvoLy4Pag=;
        b=H5KljS4gwZQXGpHL8HXwiMjIls1caAU1MzKBFFTinXTP44/XgtMLPkKsNt3hT4OS+5
         BeJ5Cfb2Arzghpp1s42mRYaqlgaZ9EA/awDqnRW1dHGksJe6uWWilsTJRmIrJR9smVwH
         ehElCYKV1jtsnS67giVrnP3fSOlnzaORdeQ2H9VMyc5rK4gP1BRs7PaDDCYAkilSZ6vP
         4cJ0VYaQXZnG+awUSR2uxMtqnq7f/yS6H4USLe/wGxo4kRLwqMa8TWbfCqjCxrRbNKMB
         Bn9UHSxzNrJfpzyd7n3XmH4B0rVIdE2EyMA3vZekVsGtlXJquUGPVTQ4FoP/lqp0IwC7
         YimA==
X-Forwarded-Encrypted: i=1; AL+hErFRsX9swsjIAOEwLdXaCC9ZlY6/uFpYS5/pkt9MXJmeRhwny7l/N4gaD5H3pu6aPsOrB1TONA==@lists.infradead.org
X-Gm-Message-State: APuU4Z+PSA/puwFNo18jhx7fXtef0haENMEpKLLeLTskSMKZuoukvb1/
	iVHG8MvJwO/gVtntNuSP90H4IwcC7a/JHAb4vsyz1OJc2Vz69zS3EGvf+VfW+VXzwH4=
X-Gm-Gg: AYBFou3mFfxzL56rY4ndlOv1DwNFylqJMEq3/1GgI6WlBeq0oveK5t/6NlzgZu97ZEw
	GWd1Qbs4nAGazhvhY7qnxCqa4R0W2MvKIg5UH+38L0s+eGnyPSzsBYa54Wvry3+8+nnIU3zium3
	wH3SV9PgbhaegxceZJmBapscjztVS8LR8DfkBqV6MSa1WXBxSJMWi6J6Z0izLDNvdDu9xbLRnWe
	z2/ewS+u95nZvlC8QUHXGRWkd7dhuLJrKi1ecawWOJX7kOi4WHfJfpmfhEvoCVu20JZEc4pdZRG
	PAncYXhNty01UbKRatl8YZVYMzI71QgmR+KQzXo6fwy21FwQIonXt5BlF67bx80DFZszbO3SmSz
	QvYiq2xSoUh7+gH7362hftS7/wkmhxaLK61VyJZuE7K3QVk4oP6MCVS+TjhBQaRFj9d8ABC8eEr
	DP6051T4BSMqAjZRPI8huRHG6JjGiILY2XvT6SEqeURQoJrEjBYp254ckMIPxJcU75Tj/7B3xCq
	3X0KTdSBiGtCUxKkGxKQ8+Q0sHkDb9fTYAxFnM+R8urqjvjWdzrPi4SK2vtW9e6JBIJsPneWMZX
	UaojqdwESSXjS0leNiXoMrB7UyLkOCxI/zoUctyDDcEOdnk3bBJeDr/prOpE6/f0mdHodXzLeLG
	n6qu3rpKTUgkRtbXaf9BIH56TpLZXmZ+d8/0bOLTVW5dH+XP5XJMC
X-Received: by 2002:a05:6102:2d03:b0:7a7:196a:84ea with SMTP id ada2fe7eead31-7d6ba480612mr1670329137.34.1795037329535;
        Wed, 18 Nov 2026 13:28:49 -0800 (PST)
Received: from soleen.c.googlers.com.com (57.233.150.34.bc.googleusercontent.com. [34.150.233.57])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b9185bc3sm2724635137.5.2026.11.18.13.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 13:28:49 -0800 (PST)
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
Subject: [PATCH v6 1/7] liveupdate: Move file_set_ser handling to luo_session_serialize()
Date: Wed, 18 Nov 2026 16:28:36 -0500
Message-ID: <20261118212845.2855249-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
In-Reply-To: <20261118212845.2855249-1-pasha.tatashin@soleen.com>
References: <20261118212845.2855249-1-pasha.tatashin@soleen.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_132851_164159_E8CF11C4 
X-CRM114-Status: GOOD (  16.43  )
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

base-commit: 079c138d2b6870bb658b6e638077264aefc03833
-- 
2.56.1.708.g77570a6a1d-goog


