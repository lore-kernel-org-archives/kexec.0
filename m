Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BD2606D83F
	for <kexec@archiver.kernel.org>; Thu,  5 Nov 2026 05:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hkS0GNsm;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=LBRf4xhp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=v098YBuIdrKaWG/f26OqsK+m7fEKJ39NQmIhL+jm86Q=; b=hkS0GNsma++oHU
	UDx8X53me9JI1fahoO3IrKN2DOULHowqvAaDyLG2akEHh7kBmm1lh+GFEjZlqr7/+JCnle7bhQub8
	QkFu+riyAW7nG/5cJl2dOsQo3DyfoQIWvBYv5rW4pEa/dkac69C8GPWexoRm00jHzz/QHLu2qwZyW
	GlKWzt4galqGkVlODRBerqioUivygDNQwgE2p/OK0jAi9EYUBqujdyDWc7YdDaduqxqBnNcbHgPOu
	g+g/n4EGeuLSVMF19ByEVcEqRMSnYvQ0FHWG1834TZT4mn4JHXykUz73bixGPyYg7/C9ARXt7bsnZ
	sG4ICZFliOWHOwGDT9mA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOpb1-00000007puA-1LEr;
	Thu, 05 Nov 2026 05:01:07 +0000
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOpax-00000007ppb-0VJo
	for kexec@lists.infradead.org;
	Thu, 05 Nov 2026 05:01:04 +0000
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-5eac6c5f927so603140e0c.0
        for <kexec@lists.infradead.org>; Wed, 04 Nov 2026 21:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793854862; x=1794459662; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=v098YBuIdrKaWG/f26OqsK+m7fEKJ39NQmIhL+jm86Q=;
        b=LBRf4xhpG8rVLMOBunxRaSdtdRFdHo+2rI8jADCtUaC3ZgLOMTmELa+9AbyXW6oT//
         mMiZLmQKc5q/caoV7YED4Id8J4I5U3sfg7QD4d4Q4P5XZmKnNuF74dQZSzvjGRiQzWT0
         MC0hrEhkeOQL8AC63XiUm1bDo8uCxGuYX5NcSXRuNciYytzlQSW5v6CYL7zWjzdBqTWK
         yXBZ8uLGV87oxIUonYmJJrVi/+PlrgSe1b4y+DASZKxozvzeoRV/aJxS+f/NnyRSF3H5
         QHPhoHvQe704csjpF/Hj/A/jFrh8jU5TI2CFUDVClQAouEvy02dnCOFcIp9OKGjkz1XC
         KV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793854862; x=1794459662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=v098YBuIdrKaWG/f26OqsK+m7fEKJ39NQmIhL+jm86Q=;
        b=AaCcYA5tllBpFs/qknZ8pxcnqDzC84DEZZCQqkg9Q8DhGAN1tQUlFPUiCprOmQRHti
         IjnCKAF4Y3E/LkS3e2UdmPsXa9oE0B34HKF933DSxKb9Cl18p/4jwVeTlzR+uFCoJ5Sc
         qZnA4HHg/Zp9nd6e8ABReoIVN+uwwMdgc+0XWIiiwWgv/Rf9IYoxiZ57djJDTGSIt6Jv
         9EwWxqSj4YFYjLjto3rp2AbI6K8SdZSgffA9eF8nv0KjpF8GrlXZg2U3MVK5Q+duEEGs
         JG9NpXza5htebYfQLohcYjDBR8qyM5ak4n5i+do2KX4+y+21QSEO445xYt2OUzmsp4Dp
         CcOQ==
X-Forwarded-Encrypted: i=1; AKwUvBz8xVa6YSTy6L4XZ+w0XG5LT1Cg8uDy7m8hGiWUryqGhrNTDtY+IZlHYBNsBuJLL3KHkKYJKg==@lists.infradead.org
X-Gm-Message-State: APuU4Z/Yfe+oQtI3UezDcdPG0oo9O1MctU04jg5n//OsbVFYvbz+6nHY
	4dJjVMpHnlcg7MWBgKDxr4AXySiPs3xygNkSS6P4LZywLxwrfr9xAPB9UBpxU28TKEA=
X-Gm-Gg: AYBFou3yD2CiPHLa2Rg9AoTSFO0ayCbDX+4q6558trU/bpZBIdQb3IMp7b16nTBBpe7
	YZ3dxsY5syEvBxGPgccJI4uv04llHeunHTF8dweNoFtIKPX8ADI01zam2inwhm2EK8CmHSONr0U
	vjFfP+qSp4eLRckIZMEkoKRv3CzamFj3T6L+Igsb4BSu7EVCNfb15DeInhAxIOlz8k02TSm79cm
	yS0K0W+ztiyxy+vsn6UtQ2ZOSwUV2XT7GbbmqKSm95GmVY0Y3Mt/MSrEyVyFXMfZSfZCmhyRu4M
	13MfofgRevynOjxiNkuZsI+h6+H72iqPd+tCUbboIurxpDo6T2aG6rhFsgLVhqYruQsSGeRfDei
	EPjeh0ODhwPFtYlnz8HrOb+2hGssdXuzZWujCsOP3bjrTMTIvOVk7Id2hjW/j8P/ewMywtJ2Dcz
	iIQ1a0f19KEKgQ677OY5hFqiPay6DhrKJSxwMvIK7MwySSDMfsyrG+4zXqcL/VIN+Z7q9REj50y
	dkHkjZLW9KdgpFMHgkYp3oNrqFwS/WrtJtqAZLeHRkdMy5Tt1Fl5Ya0DEabNnl6OmFQuX+gkirB
	XWj5ysUMc8xqooAFRQWeilGV221VK/iplcNaYPMGRz5NulOVvGl5d0HUzNBsu41MfNR/OyM43Ry
	EyqMfp1Y/f205ZG5TYOE33NrDHSIou3yTN01Tuf+7/eyeOPqUtg==
X-Received: by 2002:a05:6122:468d:b0:5ec:4a13:8aae with SMTP id 71dfb90a1353d-5ec689801b4mr8447981e0c.17.1793854861885;
        Wed, 04 Nov 2026 21:01:01 -0800 (PST)
Received: from soleen.c.googlers.com.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca8d9d62bsm3305282e0c.8.2026.11.04.21.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 21:01:01 -0800 (PST)
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
Subject: [PATCH v5 3/6] liveupdate: luo: serialize sessions via per-session publish helper
Date: Thu,  5 Nov 2026 00:00:49 -0500
Message-ID: <20261105050053.3063001-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
In-Reply-To: <20261105050053.3063001-1-pasha.tatashin@soleen.com>
References: <20261105050053.3063001-1-pasha.tatashin@soleen.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_210103_207567_7335B9A0 
X-CRM114-Status: GOOD (  19.04  )
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

With incremental kho_block publication in place, LUO sessions can be
published into sh->block_set individually as they are committed, rather
than rebuilding the entire session serialization chain during reboot.

Currently, luo_session_serialize() resets *sh->sessions_pa and
serializes all outgoing sessions from scratch in a single pass at reboot
time.

Introduce luo_session_publish_one() to append a session's
luo_session_ser entry via kho_block_set_it_append() and move the session
onto sh->published_list. Update luo_session_serialize() to freeze all
remaining unpublished sessions first (rolling back via
luo_session_unfreeze_one() on failure) and then publish them in a second
pass.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_session.c | 92 ++++++++++++++++++++++-----------
 1 file changed, 63 insertions(+), 29 deletions(-)

diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 6dea35911181..caf0e85081e8 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -103,20 +103,30 @@
 static DECLARE_RWSEM(luo_session_serialize_rwsem);
 /**
  * struct luo_session_header - Header struct for managing LUO sessions.
- * @count:       The number of sessions currently tracked in the @list.
+ * @count:       The number of sessions currently tracked in the header.
+ * @published_count: The number of outgoing sessions currently published in
+ *                   @block_set.
  * @list:        The head of the linked list of `struct luo_session` instances.
+ * @published_list:  The head of the linked list of published outgoing
+ *                   sessions, ordered identically to their entries in
+ *                   @block_set.
  * @rwsem:       A read-write semaphore providing synchronized access to the
  *               session list and other fields in this structure.
  * @block_set:   The set of serialization blocks.
+ * @it:          Iterator tracking the next slot in @block_set for outgoing
+ *               session serialization.
  * @sessions_pa: Points to the location of sessions_pa within struct luo_ser.
  * @active:      Set to true when first initialized. If previous kernel did not
  *               send session data, active stays false for incoming.
  */
 struct luo_session_header {
 	long count;
+	long published_count;
 	struct list_head list;
+	struct list_head published_list;
 	struct rw_semaphore rwsem;
 	struct kho_block_set block_set;
+	struct kho_block_set_it it;
 	u64 *sessions_pa;
 	bool active;
 };
@@ -134,12 +144,14 @@ struct luo_session_global {
 static struct luo_session_global luo_session_global = {
 	.incoming = {
 		.list = LIST_HEAD_INIT(luo_session_global.incoming.list),
+		.published_list = LIST_HEAD_INIT(luo_session_global.incoming.published_list),
 		.rwsem = __RWSEM_INITIALIZER(luo_session_global.incoming.rwsem),
 		.block_set = KHO_BLOCK_SET_INIT(luo_session_global.incoming.block_set,
 						sizeof(struct luo_session_ser)),
 	},
 	.outgoing = {
 		.list = LIST_HEAD_INIT(luo_session_global.outgoing.list),
+		.published_list = LIST_HEAD_INIT(luo_session_global.outgoing.published_list),
 		.rwsem = __RWSEM_INITIALIZER(luo_session_global.outgoing.rwsem),
 		.block_set = KHO_BLOCK_SET_INIT(luo_session_global.outgoing.block_set,
 						sizeof(struct luo_session_ser)),
@@ -186,6 +198,10 @@ static int luo_session_insert(struct luo_session_header *sh,
 		if (!strncmp(it->name, session->name, sizeof(it->name)))
 			return -EEXIST;
 	}
+	list_for_each_entry(it, &sh->published_list, list) {
+		if (!strncmp(it->name, session->name, sizeof(it->name)))
+			return -EEXIST;
+	}
 
 	/*
 	 * For outgoing we should make sure there is room in serialization array
@@ -203,6 +219,42 @@ static int luo_session_insert(struct luo_session_header *sh,
 	return 0;
 }
 
+static void luo_session_publish_one(struct luo_session *session)
+{
+	struct luo_session_header *sh = &luo_session_global.outgoing;
+	struct luo_session_ser entry = {};
+
+	lockdep_assert_held_write(&sh->rwsem);
+	lockdep_assert_held(&session->mutex);
+
+	if (!sh->active || !sh->sessions_pa)
+		return;
+
+	if (!sh->published_count)
+		kho_block_set_it_init(&sh->it, &sh->block_set);
+
+	strscpy(entry.name, session->name, sizeof(entry.name));
+	entry.file_set_ser.count = session->file_set.count;
+	entry.file_set_ser.files =
+		kho_block_set_head_pa(&session->file_set.block_set);
+
+	/* This should not fail normally as blocks were pre-allocated */
+	if (WARN_ON_ONCE(!kho_block_set_it_append(&sh->it, &entry)))
+		return;
+
+	if (!sh->published_count) {
+		/*
+		 * Ensure the first block header and entry are visible before
+		 * publishing sessions_pa to concurrent KHO readers.
+		 */
+		smp_store_release(sh->sessions_pa,
+				  kho_block_set_head_pa(&sh->block_set));
+	}
+
+	list_move_tail(&session->list, &sh->published_list);
+	sh->published_count++;
+}
+
 static void luo_session_remove(struct luo_session_header *sh,
 			       struct luo_session *session)
 {
@@ -636,50 +688,32 @@ int luo_session_deserialize(void)
 int luo_session_serialize(void)
 {
 	struct luo_session_header *sh = &luo_session_global.outgoing;
-	struct luo_session *session;
-	struct kho_block_set_it it;
+	struct luo_session *session, *tmp;
 	int err;
 
 	down_write(&luo_session_serialize_rwsem);
 	down_write(&sh->rwsem);
-	*sh->sessions_pa = 0;
-
-	kho_block_set_it_init(&it, &sh->block_set);
 
 	list_for_each_entry(session, &sh->list, list) {
-		struct luo_session_ser *ser = kho_block_set_it_reserve_entry(&it);
-
-		/* This should not fail normally as blocks were pre-allocated */
-		if (WARN_ON_ONCE(!ser)) {
-			err = -ENOSPC;
-			goto err_undo;
-		}
-
 		err = luo_session_freeze_one(session);
 		if (err) {
-			kho_block_set_it_prev(&it);
-			goto err_undo;
+			list_for_each_entry_continue_reverse(session, &sh->list, list)
+				luo_session_unfreeze_one(session);
+			goto err_unlock;
 		}
+	}
 
-		strscpy(ser->name, session->name, sizeof(ser->name));
-		ser->file_set_ser.count = session->file_set.count;
-		ser->file_set_ser.files =
-			kho_block_set_head_pa(&session->file_set.block_set);
+	list_for_each_entry_safe(session, tmp, &sh->list, list) {
+		mutex_lock(&session->mutex);
+		luo_session_publish_one(session);
+		mutex_unlock(&session->mutex);
 	}
 
-	if (sh->count > 0)
-		*sh->sessions_pa = kho_block_set_head_pa(&sh->block_set);
 	up_write(&sh->rwsem);
 
 	return 0;
 
-err_undo:
-	list_for_each_entry_continue_reverse(session, &sh->list, list) {
-		struct luo_session_ser *ser = kho_block_set_it_prev(&it);
-
-		luo_session_unfreeze_one(session);
-		memset(ser, 0, sizeof(*ser));
-	}
+err_unlock:
 	up_write(&sh->rwsem);
 	up_write(&luo_session_serialize_rwsem);
 
-- 
2.56.0.398.g882cbad275-goog


