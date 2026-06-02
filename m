Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97ECDCD6E5D
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 03:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QdKgJAMVKXqPuW+WtYwvlJP92RZZBzScgK8DeOU2nzc=; b=Fwb5l0mZRuvZQJYOgvvgUFVelK
	BgaxBpvS9EYOWv/56EjDx3h0w/5cmJ9xr38WDkF+m/i8IPah9dB+dbwZr/862WEgU7MSzTj0D3sz2
	Eu4eomw04cwjzoaI6ujdIPvJS1O0quwVzP3rrUullPKf7KcYeZ69lDQ07SInoNCiJ5zsM093wxOSk
	ISCb1vPN5ZGW7A37kDuWFLTfa2naGRFkLJOQHEoDI4z7mjyyCwRihTEl16s5VlhDG3ZVNbrhZbpnT
	it0NPyNwZoIgBa+X9a6RJqg1wASgSEgP0MhiFNiKln+7c3T4HZUxLTMCQixqNV12yUdLNEqwU1HEd
	cpcZtQfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUFdK-0000000CDMl-1fNI;
	Tue, 02 Jun 2026 03:17:38 +0000
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUFdD-0000000CDGH-2oJs
	for kexec@lists.infradead.org;
	Tue, 02 Jun 2026 03:17:34 +0000
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-8ccef25789fso23428936d6.3
        for <kexec@lists.infradead.org>; Mon, 01 Jun 2026 20:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780370250; x=1780975050; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QdKgJAMVKXqPuW+WtYwvlJP92RZZBzScgK8DeOU2nzc=;
        b=QvWQXzlyn3pG1EgVtSR7a6O3nAoenTh848Q+Y+UuLh3D1q/FEOGLkfLdM1gwnYNI5S
         bmEir7j0gxJBj0R1lmmoGtFSu4CwJP8f6qZ3OC6gcIXTtrvBa9g0v++KVHknz0fXdTrh
         0MnKnR+r/eKkq0S3yY2kZlbVuE0CyQJw4KCoKow9CNeqrEu8PtqR26/8CaRdB16TEJMd
         AW6osOMbQRDIW8qW60pn9Kfb7f89pu3DIIDIhF6ZVePkBxTjHgeScRtxV3kOCr4l2nq+
         gQgTegTvr/GQhte+nIVi5ZzcskVAXZxYlrw+FIZtiVF48qKc4gt45PSHBDakZRfXR5hv
         LyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780370250; x=1780975050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QdKgJAMVKXqPuW+WtYwvlJP92RZZBzScgK8DeOU2nzc=;
        b=IE90vjGA86PJ9lgjXEKIeiEnDksniaoLmhefv/Rq/JBN/1YDkzFLKkwvMarkTbCOk1
         dr2ndm+pEv/bT3PeOgyTLvhsz5nH3NFMt6jETptLJlVTexLatscER0YMQ3dM7ajMqlCS
         7VNd9I2qGu525BmnkKD5j5y0XTbTNGU0VKln7IetXRDza3R5pv5YFq1Qu5ZxvYDIwqod
         ZDRdXK6+0xWK0eBoZKaYT8kQeHsVjjTjQ3fFlAexbJv3cwYHX0IQJqEe5PXwZ5N+EbTe
         TCLMyAjxY3JIofiFf4thkxiWphIPOjlrkxHSLj0aHBMVywtRdDVwMHy5EFbsqIVT/dW8
         tyeQ==
X-Forwarded-Encrypted: i=1; AFNElJ9KhMvinYefieHnx5P4EbHprLzTIrJS7IroLqXcctoM7NY6bHlH+IDI4BNTP8XIlEvPzeK6nQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxf6J+rd2h4yI33d8Uk6fKGhb21H6iSVSttA4oGEKFmgbq7XN8Q
	+FjnP8+O57BXJ9ncKqkokAff4UpzYZKolK2KlSGkIFNTg8jSkD4lJLxu7peBh1US8lw=
X-Gm-Gg: Acq92OGQIUPIiy5B0Gs67xBqksoYwREgIRr62BOBzvJkV4kxDAx44fJ8bvqmYkC+Ouv
	wUYIxM2UP/OrnjaJBt6lwxWL418cnyt4pnA3MBUBe9qKF6wf413e4Omz8lZlEXOqiE3aQjWFkNQ
	3+ktSMfwN0NzI/bb9PKx1Nkfw0F6k4zUF3cBlH8j8EfGqd2ikXI+3swSkxk01ZNrL7aIR6pT23l
	wzX4tbASHMt9LmB4XeK1LSBoFUgPD15xM+aPFXPpBifw/c+9wT1uf+L1t1ji7OCREXww/EjGJ3u
	brAOhG13ehqnOA/634THIwp8B/oBkDBVD0Mb/n2FAWYEIMnPC6k5M7Km7bPkYTSa3+lN1gxDZ6+
	GK5pzdSsU/YwvFsUX1U6gOkKfUFpKFRJEZIfoJCRZnEAWx2GyOg+fFkrm+h/KSdadRaqFwS6OLJ
	FjMhyEqQyWOfTosU3dke0KCKy1No6OcULZF8JBULZQFILu7hBzjBg0wuDf2IFrTuobxjvjEqOw
X-Received: by 2002:a05:622a:a6c2:b0:516:dcbd:aaae with SMTP id d75a77b69052e-5173a89dda5mr159389971cf.52.1780370250181;
        Mon, 01 Jun 2026 20:17:30 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51741b29745sm71219081cf.8.2026.06.01.20.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 20:17:29 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	shuah@kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	pasha.tatashin@soleen.com,
	dmatlack@google.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	skhawaja@google.com,
	graf@amazon.com
Subject: [PATCH v5 08/13] liveupdate: defer session block allocation and PA setting
Date: Tue,  2 Jun 2026 03:17:12 +0000
Message-ID: <20260602031717.197696-9-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602031717.197696-1-pasha.tatashin@soleen.com>
References: <20260602031717.197696-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_201731_755383_F7550F62 
X-CRM114-Status: GOOD (  19.31  )
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

Currently, luo_session_setup_outgoing() allocates the session block and
sets its physical address in the header immediately. With upcoming
dynamic block-based session management, this makes the first block
different from the rest. Move the allocation to where it is first needed.

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/kho_block.h        | 22 +++++++++++
 kernel/liveupdate/luo_core.c     |  4 +-
 kernel/liveupdate/luo_internal.h |  2 +-
 kernel/liveupdate/luo_session.c  | 68 ++++++++++++++++++++------------
 4 files changed, 67 insertions(+), 29 deletions(-)

diff --git a/include/linux/kho_block.h b/include/linux/kho_block.h
index 505bf78409f2..0a8cda2cbfb5 100644
--- a/include/linux/kho_block.h
+++ b/include/linux/kho_block.h
@@ -70,6 +70,28 @@ int kho_block_set_restore(struct kho_block_set *bs, u64 head_pa);
 void kho_block_set_destroy(struct kho_block_set *bs);
 void kho_block_set_clear(struct kho_block_set *bs);
 
+/**
+ * kho_block_set_head_pa - Get the physical address of the first block header.
+ * @bs: The block set.
+ *
+ * Return: The physical address of the first block header, or 0 if empty.
+ */
+static inline u64 kho_block_set_head_pa(struct kho_block_set *bs)
+{
+	return bs->head_pa;
+}
+
+/**
+ * kho_block_set_is_empty - Check if the block set has no allocated blocks.
+ * @bs: The block set.
+ *
+ * Return: True if there are no blocks in the set, false otherwise.
+ */
+static inline bool kho_block_set_is_empty(struct kho_block_set *bs)
+{
+	return list_empty(&bs->blocks);
+}
+
 void kho_block_it_init(struct kho_block_it *it, struct kho_block_set *bs);
 void *kho_block_it_reserve_entry(struct kho_block_it *it);
 void *kho_block_it_read_entry(struct kho_block_it *it);
diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index 69b00e7d0f8f..1b2bda22902d 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -165,9 +165,7 @@ static int __init luo_state_setup(void)
 	strscpy(luo_ser->compatible, LUO_ABI_COMPATIBLE, sizeof(luo_ser->compatible));
 	luo_ser->liveupdate_num = luo_global.liveupdate_num + 1;
 
-	err = luo_session_setup_outgoing(&luo_ser->sessions_pa);
-	if (err)
-		goto exit_free_luo_ser;
+	luo_session_setup_outgoing(&luo_ser->sessions_pa);
 
 	err = luo_flb_setup_outgoing(&luo_ser->flbs_pa);
 	if (err)
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index fe22086bfbeb..ee18f9a11b91 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -79,7 +79,7 @@ extern struct rw_semaphore luo_register_rwlock;
 
 int luo_session_create(const char *name, struct file **filep);
 int luo_session_retrieve(const char *name, struct file **filep);
-int __init luo_session_setup_outgoing(u64 *sessions_pa);
+void __init luo_session_setup_outgoing(u64 *sessions_pa);
 int __init luo_session_setup_incoming(u64 sessions_pa);
 int luo_session_serialize(void);
 int luo_session_deserialize(void);
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 9f72a8b0a9a8..43342916d314 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -108,15 +108,16 @@ static DECLARE_RWSEM(luo_session_serialize_rwsem);
 
 /**
  * struct luo_session_header - Header struct for managing LUO sessions.
- * @count:      The number of sessions currently tracked in the @list.
- * @list:       The head of the linked list of `struct luo_session` instances.
- * @rwsem:      A read-write semaphore providing synchronized access to the
- *              session list and other fields in this structure.
- * @header_ser: The header data of serialization array.
- * @ser:        The serialized session data (an array of
- *              `struct luo_session_ser`).
- * @active:     Set to true when first initialized. If previous kernel did not
- *              send session data, active stays false for incoming.
+ * @count:       The number of sessions currently tracked in the @list.
+ * @list:        The head of the linked list of `struct luo_session` instances.
+ * @rwsem:       A read-write semaphore providing synchronized access to the
+ *               session list and other fields in this structure.
+ * @header_ser:  The header data of serialization array.
+ * @ser:         The serialized session data (an array of
+ *               `struct luo_session_ser`).
+ * @sessions_pa: Points to the location of sessions_pa within struct luo_ser.
+ * @active:      Set to true when first initialized. If previous kernel did not
+ *               send session data, active stays false for incoming.
  */
 struct luo_session_header {
 	long count;
@@ -124,6 +125,7 @@ struct luo_session_header {
 	struct rw_semaphore rwsem;
 	struct luo_session_header_ser *header_ser;
 	struct luo_session_ser *ser;
+	u64 *sessions_pa;
 	bool active;
 };
 
@@ -171,10 +173,30 @@ static void luo_session_free(struct luo_session *session)
 	kfree(session);
 }
 
+static int luo_session_grow_ser(struct luo_session_header *sh)
+{
+	struct luo_session_header_ser *header_ser;
+
+	if (sh->count == LUO_SESSION_MAX)
+		return -ENOMEM;
+
+	if (sh->header_ser)
+		return 0;
+
+	header_ser = kho_alloc_preserve(LUO_SESSION_PGCNT << PAGE_SHIFT);
+	if (IS_ERR(header_ser))
+		return PTR_ERR(header_ser);
+
+	sh->header_ser = header_ser;
+	sh->ser = (void *)(header_ser + 1);
+	return 0;
+}
+
 static int luo_session_insert(struct luo_session_header *sh,
 			      struct luo_session *session)
 {
 	struct luo_session *it;
+	int err;
 
 	guard(rwsem_write)(&sh->rwsem);
 
@@ -183,8 +205,9 @@ static int luo_session_insert(struct luo_session_header *sh,
 	 * for new session.
 	 */
 	if (sh == &luo_session_global.outgoing) {
-		if (sh->count == LUO_SESSION_MAX)
-			return -ENOMEM;
+		err = luo_session_grow_ser(sh);
+		if (err)
+			return err;
 	}
 
 	/*
@@ -522,21 +545,10 @@ int luo_session_retrieve(const char *name, struct file **filep)
 	return err;
 }
 
-int __init luo_session_setup_outgoing(u64 *sessions_pa)
+void __init luo_session_setup_outgoing(u64 *sessions_pa)
 {
-	struct luo_session_header_ser *header_ser;
-
-	header_ser = kho_alloc_preserve(LUO_SESSION_PGCNT << PAGE_SHIFT);
-	if (IS_ERR(header_ser))
-		return PTR_ERR(header_ser);
-
-	*sessions_pa = virt_to_phys(header_ser);
-
-	luo_session_global.outgoing.header_ser = header_ser;
-	luo_session_global.outgoing.ser = (void *)(header_ser + 1);
+	luo_session_global.outgoing.sessions_pa = sessions_pa;
 	luo_session_global.outgoing.active = true;
-
-	return 0;
 }
 
 int __init luo_session_setup_incoming(u64 sessions_pa)
@@ -642,6 +654,8 @@ int luo_session_serialize(void)
 
 	down_write(&luo_session_serialize_rwsem);
 	down_write(&sh->rwsem);
+	*sh->sessions_pa = 0;
+
 	list_for_each_entry(session, &sh->list, list) {
 		err = luo_session_freeze_one(session, &sh->ser[i]);
 		if (err)
@@ -651,7 +665,11 @@ int luo_session_serialize(void)
 			sizeof(sh->ser[i].name));
 		i++;
 	}
-	sh->header_ser->count = sh->count;
+
+	if (sh->header_ser && sh->count > 0) {
+		sh->header_ser->count = sh->count;
+		*sh->sessions_pa = virt_to_phys(sh->header_ser);
+	}
 	up_write(&sh->rwsem);
 
 	return 0;
-- 
2.53.0


