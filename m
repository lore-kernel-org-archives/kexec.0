Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1715F606A333
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 21:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lCo6AAdF;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=XLTAvN6x
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ePURxFbZRmuaZzBcCX+c1ARIFExZY6rS7Q59wKvUVmQ=; b=lCo6AAdFYo3/ec
	9sRkSpCoe1hDdm5IaEB3UuD2p9cUFTcz8t1PFoTdPz9zp4FkJ0yMTg9448YreW91CosCEKs5ah582
	oERw/L8EBKFAjQVOtlnFkphYn/ZXHRNHZ3KBWNpjqGs8nEg0UafF3yMXbK+33btJnQI9hQrUHrl99
	ifpWnqt/bcsEHqUqvHuamSw6ZZ5YciQc+GmX3NirnqXT5Whjc8Cb29eab+LIdqhhmexomENqXTiVF
	8uoNmG2HgHy7fTWaDTxdBwjE8TUyrbMNgB/ss2ZAOF9u7KjXBf7ob0tdzBPYAx96trgiqzZThC/qB
	3E4tm14j6D+PqsmiF7Rw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTnDA-0000000AJfz-39Lf;
	Wed, 18 Nov 2026 21:29:00 +0000
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTnD2-0000000AJal-37R7
	for kexec@lists.infradead.org;
	Wed, 18 Nov 2026 21:28:54 +0000
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-5eaaa9b1591so1135834e0c.3
        for <kexec@lists.infradead.org>; Wed, 18 Nov 2026 13:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1795037331; x=1795642131; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ePURxFbZRmuaZzBcCX+c1ARIFExZY6rS7Q59wKvUVmQ=;
        b=XLTAvN6x+scPx7wKO1uqSfGgeheW4fP5So0P8EZN8Ykz5EpV3OS5XcoGD/lmNHswRb
         n3SLMtXm5guncqFo6hc/KDkTmSQkzkAlxffJYMEIqjqSUme1hqZU1uEhBcMJcxX+6RTn
         aOr9cZp5F0nB9r0ZNeV59lcnFYE5uZhH3IZPML1uL0kjE9T4Rk/7srnKSIcE71EbgI/f
         KCIGeJ3LDtyOHIIzaRT2m6WDz4tAK/RMzhL7uwKFLe9MU+SFmOv2NyOJCjQ9Nei442iY
         nffCnFjzpNX5lov9W5wmgRzH4+6WFVw3I3dqfO/4FYilf7onvyRvd3ZifB/Go0I6G/B2
         xJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795037331; x=1795642131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ePURxFbZRmuaZzBcCX+c1ARIFExZY6rS7Q59wKvUVmQ=;
        b=nr0QxRE6puKCGNuz7IZmw87etL7EY3UlUaQ1SJA0EyMfobnoEAYauwJw13WcTEkSz3
         yIhLyHnOYlaF8+JU7ae6n8eEWI7uJcDGWoMHB2jBwtP83FgS0B5C0CahztIr+sWqWHQk
         ZH8WukRacIh8db1nM0jXPi4FEXhcWr3247s74J7XTA4yx99d/x9wlWuuEzc9+OHbc8eJ
         4e7XXRn5kK+jVtka7EeRXQQrMUL5wnr0Cp8wR0gFvQOf+8g5A6e3gbFozNitodp4mE7o
         fwRKH8QtBMwewhiLlbXGy27J3WdJlWOBdgq7Jc3zSke7GhSCGkc5Op9fQJmYYmk5DiRO
         9iFw==
X-Forwarded-Encrypted: i=1; AL+hErFDZO8MovjwfbtQxSm1He8ciHg0u51LiO3Zi9wkwF8uohEutqFcajGRC5P5Pfh6i3YRQRB1NQ==@lists.infradead.org
X-Gm-Message-State: APuU4Z9K7Qd90TCNyleKqTad9WxsEuD8GPYgWdkIaGCR5tnQVfSHqjrr
	WYZhQKNciVqzBHarC91hsNvFvU4UNdckicRnNnS3T/tKYbDRLnhP61QNq66nFokQOhI=
X-Gm-Gg: AYBFou27IjfXI2wMM37vOSAzom2+JihocqXbk21viZaHCWGOyz2d+LocOceG0dLAbdV
	YZ9EuXbuAWdADDChSVUyCn/fxY/9eCQOIwLxgCpyvYbwWwkfL95CtWAyAoYZLk0KNUzdo9m88v3
	M6eErqh8Fbcoc3Ua8x3R/luX36sarORkuv18QjcsNPhtzS5APxmkdqRNLivUKlLrcUvHtGYP5RG
	NQCQRc3T/8iz2+udRgSRInqt9ubSh/vMLcXJpNYYPsOL2NTjuzCCdgrKubY/FYKmU/BWQjAIAAy
	yxe/6hAoH3ejLD47uESO7WnlWfZ34IO6YFvCYxBS03f/+MX2xMq1zflo1z/93e6hzR4vDZm6J3H
	LwiEXosbVpkAetttfvJWm7LmPfGoTMvpE44jpBNuHFobaXsXNKZK11YVsrgv3ofB12un7AqIyl7
	d6ARKPdIHcMWfDHsKSzSXuGiuigIRcCuyHD73fE5okHiX56YqcRqf3RJXb5Uo5GtoEheyc6WBu7
	qLjRCCV1nZOzR8ZgyDHABuGZqyjwxIPL+EknxYGjATspig9LUZdw+DvBwHaoJZIEW0jAVvuvLiT
	UHHhdeKQAYa1vb6HrH0D70cu00s76g2AqPYQQLaXyIR3/3D03O/vVaV7sobks/a6iKBL89FGtJy
	/jXL9qi9PvSSLxoLAaukRmVCFYI/jYHXrufUgnP6kNBYZT6VXUBlwbGdPIL5Q1HyKcvIz94zQ4w
	==
X-Received: by 2002:a05:6102:688d:b0:7cc:2fd1:7122 with SMTP id ada2fe7eead31-7d6ba3ddfe6mr1764777137.18.1795037331333;
        Wed, 18 Nov 2026 13:28:51 -0800 (PST)
Received: from soleen.c.googlers.com.com (57.233.150.34.bc.googleusercontent.com. [34.150.233.57])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b9185bc3sm2724635137.5.2026.11.18.13.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 13:28:50 -0800 (PST)
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
Subject: [PATCH v6 3/7] liveupdate: luo_session: support incremental session serialization
Date: Wed, 18 Nov 2026 16:28:38 -0500
Message-ID: <20261118212845.2855249-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
In-Reply-To: <20261118212845.2855249-1-pasha.tatashin@soleen.com>
References: <20261118212845.2855249-1-pasha.tatashin@soleen.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_132852_827199_634DE1B8 
X-CRM114-Status: GOOD (  18.35  )
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

In preparation for committing frozen sessions ahead of reboot, allow
sessions to be serialized into sh->block_set individually. Introduce
luo_session_serialize_one() to append a single session to sh->block_set
and mark it serialized. Update luo_session_serialize() to freeze all
remaining unserialized sessions first, rolling back on failure, and
then serialize each one via luo_session_serialize_one().

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/luo_internal.h |  3 ++
 kernel/liveupdate/luo_session.c  | 71 ++++++++++++++++++++------------
 2 files changed, 47 insertions(+), 27 deletions(-)

diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index 01a172cd9d7a..77dac2742877 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -64,6 +64,8 @@ struct luo_file_set {
  *              previous kernel) sessions.
  * @retrieved:  A boolean flag indicating whether this session has been
  *              retrieved by a consumer in the new kernel.
+ * @serialized: A boolean flag indicating whether this outgoing session has
+ *              been serialized into KHO.
  * @file_set:   A set of files that belong to this session.
  * @mutex:      protects fields in the luo_session.
  */
@@ -71,6 +73,7 @@ struct luo_session {
 	char name[LIVEUPDATE_SESSION_NAME_LENGTH];
 	struct list_head list;
 	bool retrieved;
+	bool serialized;
 	struct luo_file_set file_set;
 	struct mutex mutex;
 };
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 6dea35911181..56d7f76c0282 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -108,6 +108,8 @@ static DECLARE_RWSEM(luo_session_serialize_rwsem);
  * @rwsem:       A read-write semaphore providing synchronized access to the
  *               session list and other fields in this structure.
  * @block_set:   The set of serialization blocks.
+ * @it:          Iterator tracking the next slot in @block_set for outgoing
+ *               session serialization.
  * @sessions_pa: Points to the location of sessions_pa within struct luo_ser.
  * @active:      Set to true when first initialized. If previous kernel did not
  *               send session data, active stays false for incoming.
@@ -117,6 +119,7 @@ struct luo_session_header {
 	struct list_head list;
 	struct rw_semaphore rwsem;
 	struct kho_block_set block_set;
+	struct kho_block_set_it it;
 	u64 *sessions_pa;
 	bool active;
 };
@@ -203,6 +206,33 @@ static int luo_session_insert(struct luo_session_header *sh,
 	return 0;
 }
 
+static void luo_session_serialize_one(struct luo_session *session)
+{
+	struct luo_session_header *sh = &luo_session_global.outgoing;
+	struct luo_session_ser *ser;
+
+	lockdep_assert_held_write(&sh->rwsem);
+	lockdep_assert_held(&session->mutex);
+
+	if (!*sh->sessions_pa)
+		kho_block_set_it_init(&sh->it, &sh->block_set);
+
+	/* This should not fail normally as blocks were pre-allocated */
+	ser = kho_block_set_it_reserve_entry(&sh->it);
+	if (WARN_ON_ONCE(!ser))
+		return;
+
+	strscpy(ser->name, session->name, sizeof(ser->name));
+	ser->file_set_ser.count = session->file_set.count;
+	ser->file_set_ser.files =
+		kho_block_set_head_pa(&session->file_set.block_set);
+
+	if (!*sh->sessions_pa)
+		*sh->sessions_pa = kho_block_set_head_pa(&sh->block_set);
+
+	session->serialized = true;
+}
+
 static void luo_session_remove(struct luo_session_header *sh,
 			       struct luo_session *session)
 {
@@ -637,48 +667,35 @@ int luo_session_serialize(void)
 {
 	struct luo_session_header *sh = &luo_session_global.outgoing;
 	struct luo_session *session;
-	struct kho_block_set_it it;
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
+		if (session->serialized)
+			continue;
 		err = luo_session_freeze_one(session);
-		if (err) {
-			kho_block_set_it_prev(&it);
-			goto err_undo;
-		}
+		if (err)
+			goto err_unfreeze;
+	}
 
-		strscpy(ser->name, session->name, sizeof(ser->name));
-		ser->file_set_ser.count = session->file_set.count;
-		ser->file_set_ser.files =
-			kho_block_set_head_pa(&session->file_set.block_set);
+	list_for_each_entry(session, &sh->list, list) {
+		if (session->serialized)
+			continue;
+		mutex_lock(&session->mutex);
+		luo_session_serialize_one(session);
+		mutex_unlock(&session->mutex);
 	}
 
-	if (sh->count > 0)
-		*sh->sessions_pa = kho_block_set_head_pa(&sh->block_set);
 	up_write(&sh->rwsem);
 
 	return 0;
 
-err_undo:
+err_unfreeze:
 	list_for_each_entry_continue_reverse(session, &sh->list, list) {
-		struct luo_session_ser *ser = kho_block_set_it_prev(&it);
-
-		luo_session_unfreeze_one(session);
-		memset(ser, 0, sizeof(*ser));
+		if (!session->serialized)
+			luo_session_unfreeze_one(session);
 	}
 	up_write(&sh->rwsem);
 	up_write(&luo_session_serialize_rwsem);
-- 
2.56.1.708.g77570a6a1d-goog


