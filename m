Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF7CCD6E52
	for <kexec@archiver.kernel.org>; Fri, 29 May 2026 03:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/lzT/uKNjiuJAcCs6ljq32s6d+IXBzBHeWWiRI2fHMI=; b=y7Xmo404TI9M1AzVlX8uTHWEIF
	LG8DhrF456/apvmfbnp2i1JRhesFaKJQaRvhHvm1NnuzVW0xvjY/+MeYT9xfdq7lx6aEp6wqmFKKS
	0xUcwmj5XZE8sG5heLY+x2mLj5l1MD5+7rVZULr5b41eevHnliRi2mekmkfdodyL6TPNkcMq08neB
	ce2Tc11qJRf/LBRamDQG2TzPgBqRK27GSEFzmLBL6RqRVj3I65iN+zCPZ6gsG8SGLIDhlSD2FkN76
	IoN/A2tcDiJBcnASRw1krwnzNm4WUAy91DNM+4CDRjZ3bQIpsLhul7xlqrn2aU1SsV8jSH1XicccI
	1caE/IjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSnmj-00000006gVw-00LQ;
	Fri, 29 May 2026 03:21:21 +0000
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSnmf-00000006gSE-10ZT
	for kexec@lists.infradead.org;
	Fri, 29 May 2026 03:21:19 +0000
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-8cccdea2fbdso16071276d6.1
        for <kexec@lists.infradead.org>; Thu, 28 May 2026 20:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780024876; x=1780629676; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/lzT/uKNjiuJAcCs6ljq32s6d+IXBzBHeWWiRI2fHMI=;
        b=jwu6NfxOG9XTardKKnDPokaLF7U5FWrESzPVNAryJ8/i8FzNwXbr+dntLd88ylelZY
         f43MprQMkAQIlHBZHW9ctpqRCx9OaJyfy4bqDdk38jduJJIBw1sIxw/WPl39D4sAWmrf
         iNz9obgR3qDnBysuup1QLgdL2+sDlD3VWqHuJ1FVLq4T6dPi58/82sf3hKEZQkv7GGkN
         MgtzNscNzY/h2WwLOmo8e9ebdIhoAfTsmlao8QI4/ZLjEVu+Vy7eOhIsYrxoPgKLAoR1
         GIjZsQWAP7E9PUfeew2nh6U7HdtPW7eO9NuLUDXxEWA7NCPS+4JMR4pDt8N+KtQfdarl
         FPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780024876; x=1780629676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/lzT/uKNjiuJAcCs6ljq32s6d+IXBzBHeWWiRI2fHMI=;
        b=TtMbxpTmxtuyMrqNIfajtpoGVm8G40qdyeC29O/MbV3El7tDCeJfaCAcVgcxFFu95j
         U9WV7bg92/Rnu2BwC0MTS7eMLCvK/+23HSqXeW3EOMS97Xh/OSOK63nwjrqvv7usrZJM
         Ts8T0lfvxjSC+5BUuJLZabb++kxuoxt7lAAf3Jk1WNP2bGYg+ytnX5l/DKDgrOlTGCID
         Q0bIqtQskAAv2J/vJALLQV1bKthmHyxppeeeXVdTdVfhIZVlMqx6ysnAZm1nzwdnPgoc
         0ZYGnuG2QAz+bb2m/ZAdxg3g/CkE/jxcaN/bxGd0i4npeoSfdU20nem60TUpenNvWg/g
         Tw8Q==
X-Forwarded-Encrypted: i=1; AFNElJ9BGxeep6+9i6qcLPoHfxFYq1gLh/MIuBBRk2IUki7l69/5irCT31N3R5wkCJNzV2UkTgFTsg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxzfyMSwG6+4LQ2o46MtDgdkvP7F+RP9PIPuZlnoGBx7Ne6Ld4J
	SMk+LitTzsMBM0HKYRaupGR/VgZUOK7QBJNZJL3Vo7mJA8fMWr8yOOqVKxUFc/24Ck8=
X-Gm-Gg: Acq92OE6fMBpB3GWpvOUi3dLcn7RJOXHlbBl2FUZR4CU1cvmEBtxykwS7at3i3cC+Da
	2c5i0gwWr3oEnq0xk8XPq3ola7FeNNxIQ6Pxgvw08Ban2SRlK6KhLltcooziaHspIphg6RlDxFO
	7dWamfR3eCcM7euke41Un9sO9YH7URpNlClE7ne87apKmw+yPAJN80iraSpuWYOj8lPeI3yngae
	dSZyA4sJTXKRyODUwDRUU51Asbt9BVwn8wyFkWGVNQOOx1S4ZLsRaNMQqoxJwttBp1JyH2937LY
	TkgZBCeez93y9Zmm4/24Nekc5NAf5PKOeSLNK1ivoEJTQ7f9+lrMDTS/fGTm6yLqq9gjmonNPQ1
	f9ydDqGK5nt78MV890opqJbfqrOzIPy1jSpJTYz5yjuZtHxgXYjsx6LuyBk2wsaLo4tLStWtarR
	mO3Bv2lgzZdSe9qNuZ0hyjfk8bb5pq70yXHFd1n9lLcIa1A8NnYt1LNome7Ye+zw==
X-Received: by 2002:a05:6214:33c2:b0:8cb:d479:a103 with SMTP id 6a1803df08f44-8cce621c869mr14316046d6.20.1780024875958;
        Thu, 28 May 2026 20:21:15 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea26d286sm1179476d6.48.2026.05.28.20.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 20:21:15 -0700 (PDT)
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
Subject: [PATCH v3 06/11] liveupdate: defer session block allocation and PA setting
Date: Fri, 29 May 2026 03:21:01 +0000
Message-ID: <20260529032106.1505796-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529032106.1505796-1-pasha.tatashin@soleen.com>
References: <20260529032106.1505796-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_202118_699684_3CDD6D30 
X-CRM114-Status: GOOD (  18.18  )
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
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_core.c     |  4 +-
 kernel/liveupdate/luo_internal.h |  2 +-
 kernel/liveupdate/luo_session.c  | 68 ++++++++++++++++++++------------
 3 files changed, 45 insertions(+), 29 deletions(-)

diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
index 5e12c8f8669b..92f8c53c7a73 100644
--- a/kernel/liveupdate/luo_core.c
+++ b/kernel/liveupdate/luo_core.c
@@ -157,9 +157,7 @@ static int __init luo_state_setup(void)
 	strscpy(luo_ser->compatible, LUO_ABI_COMPATIBLE, sizeof(luo_ser->compatible));
 	luo_ser->liveupdate_num = luo_global.liveupdate_num + 1;
 
-	err = luo_session_setup_outgoing(&luo_ser->sessions_pa);
-	if (err)
-		goto exit_free_luo_ser;
+	luo_session_setup_outgoing(&luo_ser->sessions_pa);
 
 	err = luo_flb_setup_outgoing(&luo_ser->flbs_pa);
 	if (err)
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index 9bf26c5b1495..28ebb4f3000b 100644
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
index 5c092c71797e..ec72f16185f3 100644
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
@@ -495,21 +518,10 @@ int luo_session_retrieve(const char *name, struct file **filep)
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
@@ -611,6 +623,8 @@ int luo_session_serialize(void)
 
 	down_write(&luo_session_serialize_rwsem);
 	down_write(&sh->rwsem);
+	*sh->sessions_pa = 0;
+
 	list_for_each_entry(session, &sh->list, list) {
 		err = luo_session_freeze_one(session, &sh->ser[i]);
 		if (err)
@@ -620,7 +634,11 @@ int luo_session_serialize(void)
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


