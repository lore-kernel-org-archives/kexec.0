Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B6ACD5BD0
	for <kexec@archiver.kernel.org>; Wed, 27 May 2026 20:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AT71iKwUwI8whWewLCYQhrlw3tPdCBLewAlZei6IHqM=; b=ixpPsoY/AbcTaTZa7i2w+zfGJ6
	fkXm7MNkGh1YcRcoCQWlyaIYIUW2qzxsz8Q3Msd0/kxnNIfkbyGBLDKsWxpeUNCV9q9iPtMyT/6cg
	tMJdEwvd0DEFSHgirIzeoTrGvaFQ2dn5lbOU7xEErbc7mWBOTuwzwCaxdraRx+rnkds+e99ENyYJ+
	AeXfY7lyFHnKlL7zEM1O74eUPcTN6rJC8YjSrki9IT6o62WDjwnh5AGxb3eABwvuoduI2dfPPv12n
	z2EpaGVeE9GJ+dgsgsAxEn8ZWHMbC6jtbr5rtBjSkF+yh1Nj8+vlYWgCD6MzKiA5zWlpVxfQiPse/
	214h1ULQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSKqz-00000004idO-1Cnb;
	Wed, 27 May 2026 20:27:49 +0000
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSKqw-00000004iaC-1EFO
	for kexec@lists.infradead.org;
	Wed, 27 May 2026 20:27:47 +0000
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-516d634956fso65999491cf.2
        for <kexec@lists.infradead.org>; Wed, 27 May 2026 13:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779913665; x=1780518465; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AT71iKwUwI8whWewLCYQhrlw3tPdCBLewAlZei6IHqM=;
        b=ey62OP/4g3X4ybIvCfEL8VZjoTUrgdCqlQ5RT11FRq3U9h0VCfhiSI9RUSW7tPOIoj
         AyblvyIazvjL/KlKejy/cYQSnU+8E3YDgNhH1Gy2aSBFs3BPzY6dODUSUgY6sumiG9po
         abf8SrKNr3xft3Fl/K9iNDYmKjazed+abBMZtYG84qwym8EtFicNP5YE3pO2WNPNUlWC
         w4sc5LSkRMps5WXlFJnrtnKtxmT6eCHZNsWoMnhzLZa5s/J4zvP2FF007pxUBMuSIC8w
         ACHaB+MR70oBPEsP9L4kMaaYkiWuzde9iH6p50M/PlYB1cHYjijNjjTSU1s2OHH7pTJ5
         czmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779913665; x=1780518465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AT71iKwUwI8whWewLCYQhrlw3tPdCBLewAlZei6IHqM=;
        b=GOfaFwehkQRw8iCglFS1Lq4/lTsuJkSRQhKf7pZWjZq/UfwWLawHSZki8HXg2uVter
         g3fhBRofGM9lG54Cg8sVKIS6PDRLMRjGgQHYXPvv+DSfNhpCWAyuhEe8YSeCVHFR2iK/
         RkoUNyq5molY47Fvyy40Xcs5V58cj0qv+Nouh9nzncK0qDhsh5kRJ8IWhkzGjXPcPvEt
         kVpaOwJ2c8Rnlj8tnPfJ1ofooJhSnldC6jfk+LxuLquQrQuP2Ynx6AEZWfwTNeCuN0qk
         5EEdrb54SDirfWBeYsHbe5MMj0l0VnHJuBAQGi2OlK7Rx2u2L9D3cisJ5oVrUGpnHvi7
         YMXg==
X-Forwarded-Encrypted: i=1; AFNElJ8fGXnjzfZfCSAQKE3IhyMsZRunFoS5yYCpSYvBN+1SDLSZ67bDPPypfi/vjj8jCLIWbq8vVA==@lists.infradead.org
X-Gm-Message-State: AOJu0YywFXmcUzfViRohAkR6Podlpi9J5BEqZgdJ1NKV73bZ/gnpJtDy
	+mQqF2jbEZYUPWK6weih9Q51mncASH+OKZXRxseyPHFp+wgaHD9Q9/4eAZxHajUBJxA=
X-Gm-Gg: Acq92OE0/O6VKw6/zmxzGk9Sd/9e6HCBknsPmuaZK0Itb1LcV6pjAK7Mazu2wCJLHyF
	jplw9i6jxMOjSIbioMio5Gg5ONzESfE62vMK5OlWcFCwD4xEc1S1pIE7sTvNjgD+bLycIZedF54
	CJKZQcLiVUyGkVhpplYCqEf0jdMFeUhepXIR+ubTgWR6ejeW7PvIfUbA0n07GBbuQof9ittvFlt
	jqXk9dHEbAYt9PjGPDHWrSjfB9XvCaEvnedMWwMXh6xxmG0e7jdcWihJ+zXi3U+bT0MOZTcjpKY
	RbEcGppbzfMBQepqKoAX9JjHGRaizSE/4SCFdmc1AmST/IuifmmWleSRaU+MpzRButSqPi2ti4t
	yC3CxQZfsoRya8iSf2W1036WwKDnSAOJjHj4WOqf8wZCmsajwjmYASxZHGyut41b86gVt8vG+91
	XUCgbGa26y1JvPd2SZ4O9/ISWTUDu1vGRmnyfkO7ckKD9dVH038mu6wHmSX2dgSA==
X-Received: by 2002:a05:622a:480f:b0:516:d955:ea6 with SMTP id d75a77b69052e-516d9551436mr335310291cf.14.1779913664822;
        Wed, 27 May 2026 13:27:44 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517069ecb93sm58632971cf.4.2026.05.27.13.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 13:27:44 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: rppt@kernel.org,
	sourabhjain@linux.ibm.com,
	jbouron@amazon.com,
	akpm@linux-foundation.org,
	error27@gmail.com,
	bhe@redhat.com,
	linux-kernel@vger.kernel.org,
	pasha.tatashin@soleen.com,
	rafael.j.wysocki@intel.com,
	piliu@redhat.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	skhawaja@google.com,
	graf@amazon.com,
	mario.limonciello@amd.com
Subject: [PATCH v6 3/5] liveupdate: block session mutations during reboot
Date: Wed, 27 May 2026 20:27:35 +0000
Message-ID: <20260527202737.1345192-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527202737.1345192-1-pasha.tatashin@soleen.com>
References: <20260527202737.1345192-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_132746_356508_FF7D8C53 
X-CRM114-Status: GOOD (  18.05  )
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

During the reboot() syscall, user processes may still be running
concurrently and attempting to mutate sessions (e.g., creating,
retrieving, or releasing sessions). To prevent this, introduce
luo_session_serialize_rwsem to synchronize mutations with the
serialization process.

All session mutation operations (create, retrieve, release, ioctl) take
the read lock. The serialization process (luo_session_serialize) takes
the write lock and holds it indefinitely on success. This effectively
freezes the LUO session subsystem during the transition to the new
kernel. If serialization fails, the lock is released to allow recovery.

Fixes: 0153094d03df ("liveupdate: luo_session: add sessions support")
Reported-by: Oskar Gerlicz Kowalczuk <oskar@gerlicz.space>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_session.c | 56 +++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 169131642939..c9bdad2e5ae7 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -46,6 +46,38 @@
  * 4.  Retrieval: A userspace agent in the new kernel can then call
  *     `luo_session_retrieve()` with a session name to get a new file
  *     descriptor and access the preserved state.
+ *
+ * Locking:
+ *
+ * The LUO session subsystem uses a three-tier locking hierarchy to ensure thread
+ * safety and prevent deadlocks during concurrent session mutations and kexec
+ * serialization:
+ *
+ * 1. `luo_session_serialize_rwsem` (global rwsem):
+ *    Protects session mutations (creation, retrieval, release, and ioctls)
+ *    against the serialization process during reboot.
+ *
+ *    - Readers: Taken by any path modifying or accessing session state (e.g.,
+ *      `luo_session_create()`, `luo_session_retrieve()`, `luo_session_release()`,
+ *      and `luo_session_ioctl()`).
+ *    - Writer: Taken by the serialization process (`luo_session_serialize()`)
+ *      during reboot. On success, the write lock is held indefinitely to freeze
+ *      the subsystem. On failure, it is released to allow recovery.
+ *
+ * 2. `luo_session_header->rwsem` (per-list rwsem):
+ *    Synchronizes list-level operations for the incoming and outgoing session headers.
+ *
+ *    - Writer: Taken during list mutation operations (inserting or removing a
+ *      session from the list).
+ *    - Reader: Taken when traversing the list (e.g., retrieving a session by name).
+ *
+ * 3. `luo_session->mutex` (per-session mutex):
+ *    Protects the internal state and file sets of an individual session. It is
+ *    acquired during per-session operations such as preserving, retrieving,
+ *    or freezing files.
+ *
+ * Lock Hierarchy:
+ *   `luo_session_serialize_rwsem` -> `luo_session_header->rwsem` -> `luo_session->mutex`
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -75,6 +107,13 @@
 		sizeof(struct luo_session_header_ser)) /		\
 		sizeof(struct luo_session_ser))
 
+/*
+ * Protects session mutations during serialization. All session mutation
+ * operations must hold the read lock. The serialization process holds the write
+ * lock indefinitely on success to block all concurrent and future mutations.
+ */
+static DECLARE_RWSEM(luo_session_serialize_rwsem);
+
 /**
  * struct luo_session_header - Header struct for managing LUO sessions.
  * @count:      The number of sessions currently tracked in the @list.
@@ -205,6 +244,7 @@ static int luo_session_release(struct inode *inodep, struct file *filep)
 	struct luo_session *session = filep->private_data;
 	struct luo_session_header *sh;
 
+	guard(rwsem_read)(&luo_session_serialize_rwsem);
 	/* If retrieved is set, it means this session is from incoming list */
 	if (session->retrieved) {
 		int err = luo_session_finish_one(session);
@@ -382,6 +422,7 @@ static long luo_session_ioctl(struct file *filep, unsigned int cmd,
 	if (ret)
 		return ret;
 
+	guard(rwsem_read)(&luo_session_serialize_rwsem);
 	return op->execute(session, &ucmd);
 }
 
@@ -417,14 +458,17 @@ int luo_session_create(const char *name, struct file **filep)
 	if (IS_ERR(session))
 		return PTR_ERR(session);
 
+	down_read(&luo_session_serialize_rwsem);
 	err = luo_session_insert(&luo_session_global.outgoing, session);
 	if (err)
 		goto err_free;
 
-	scoped_guard(mutex, &session->mutex)
-		err = luo_session_getfile(session, filep);
+	mutex_lock(&session->mutex);
+	err = luo_session_getfile(session, filep);
+	mutex_unlock(&session->mutex);
 	if (err)
 		goto err_remove;
+	up_read(&luo_session_serialize_rwsem);
 
 	return 0;
 
@@ -432,6 +476,7 @@ int luo_session_create(const char *name, struct file **filep)
 	luo_session_remove(&luo_session_global.outgoing, session);
 err_free:
 	luo_session_free(session);
+	up_read(&luo_session_serialize_rwsem);
 
 	return err;
 }
@@ -443,6 +488,7 @@ int luo_session_retrieve(const char *name, struct file **filep)
 	struct luo_session *it;
 	int err;
 
+	guard(rwsem_read)(&luo_session_serialize_rwsem);
 	guard(rwsem_read)(&sh->rwsem);
 	list_for_each_entry(it, &sh->list, list) {
 		if (!strncmp(it->name, name, sizeof(it->name))) {
@@ -615,7 +661,8 @@ int luo_session_serialize(void)
 	int i = 0;
 	int err;
 
-	guard(rwsem_write)(&sh->rwsem);
+	down_write(&luo_session_serialize_rwsem);
+	down_write(&sh->rwsem);
 	list_for_each_entry(session, &sh->list, list) {
 		err = luo_session_freeze_one(session, &sh->ser[i]);
 		if (err)
@@ -626,6 +673,7 @@ int luo_session_serialize(void)
 		i++;
 	}
 	sh->header_ser->count = sh->count;
+	up_write(&sh->rwsem);
 
 	return 0;
 
@@ -635,6 +683,8 @@ int luo_session_serialize(void)
 		luo_session_unfreeze_one(session, &sh->ser[i]);
 		memset(sh->ser[i].name, 0, sizeof(sh->ser[i].name));
 	}
+	up_write(&sh->rwsem);
+	up_write(&luo_session_serialize_rwsem);
 
 	return err;
 }
-- 
2.53.0


