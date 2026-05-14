Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293D0CD4F47
	for <kexec@archiver.kernel.org>; Thu, 14 May 2026 22:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2T3oA7tkx4rspjASSft4V+bRK2GXucIgM1nPm7xvZEk=; b=0VGxPcVectrRTCSBsETpOi5qr3
	1BdHNbDsXbjjvDthSAz92dA+ZurHNmkCRIjZNvsCn7BmSToi8lWardlMq1bVARHhfXXbZGkQM/+Cr
	4GwTz6gUhWA9CjLIYUh84QNzcgzI8UJXw60gRquSTquj2IRrvrbBpPkraFfr6WXQU7K0iQoognbwV
	+PCj1RUTLX+/FXcez7uCtLHCQUNC5Q6hmfnC8W/4eGGTE4I02q92B+jC2XCDyfIHgIZaPZ8jnS+p2
	+mzLqVwHreZpfHPldsMaDv166GvbR/VMwa4mFwdVtOWP9/LvovOdZUACM3KgY9i/dS2efSPjE2n/P
	rgLWTKTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNeVy-00000006iMf-1XqU;
	Thu, 14 May 2026 22:26:46 +0000
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNeVu-00000006iJ9-4B4r
	for kexec@lists.infradead.org;
	Thu, 14 May 2026 22:26:44 +0000
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-50faf8ed9c5so45563401cf.2
        for <kexec@lists.infradead.org>; Thu, 14 May 2026 15:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1778797602; x=1779402402; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2T3oA7tkx4rspjASSft4V+bRK2GXucIgM1nPm7xvZEk=;
        b=KNEXs4lSuTRJ5ZKC+/OPYHap1LOHdxw/SeeY02uvvvrXSOAoVsZPm6rjabbOkegY85
         tBBF22Rn7EyC9BURrsatIloMAfdfwT4k/kKYzjIQSqxrOixOTE9vJ5nhdQKU0MIX4tFp
         z0ERjJLVen+/DEBAsChRIXblv153qjZ+82QhM/I1lkWklkykWFBly1Oei1C02zsPXezq
         MJvzfkjz0IUDJ1Oz/3T4cq3c2+9+YkDUIxQ7M9v5nv33+o7aw0ySSyi3MFyL+dJ/iGME
         pHxDlLuxrRmT68dxEAPPdW/6DDMEFOmvMwPJD00ztu1rKN2illPSQATvwGr4Oro0tBcD
         o1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778797602; x=1779402402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2T3oA7tkx4rspjASSft4V+bRK2GXucIgM1nPm7xvZEk=;
        b=reU8MjUR//CWbbtbR0UNIYIuoh8zrLMF+G5Rk/g0T8QcNNN9fKl4lV+6y2v4p6gBbn
         AndWu5XJTA20AzfL1GBF2QrkLfnMmhEXkHXbdkgIwOrGNuj1hSQsA/wRSK4X9A0Ih9Ii
         kI1gG0osRqAWjg/9eq+p3rUZtuxf4nh92uXoMt6IPgJzJ4Zc7Dlkruh4OSpenkaO++k+
         MJWBE7LZp7JHh9Ftfl7PdYrT4fj/vOIu+EiuY/LrUMrh5KHQo0wtTj/zGS3AQDbf1mH5
         s8ucu/eqZ4g2/8wUj/69Y0wNqE9U9qN6irOuzn23fVe/ya9rsC9ldz3o7vUBk0WJzDoP
         yNtQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ayOdVsmTyrXe6AMEl5yxoOX22tNrUCUXq/EUJuUxJPjPZCf9ruTs8/E1pItN5eRqtYXwWdw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyTYyqcrv7tN8GjuGc+++hEARnpZ62dJhERRKrkh3pZWi6d4tV4
	RFKYM8jIiWwKVqUL4UBQoxxp68jkrjYDsdXVI03wZUV1sntchWanYYXKrIECjNMgo2s=
X-Gm-Gg: Acq92OHxoXoSBsDZ3XOIrJE7cFL5m/WFohgfX+8vOXDPVt9AFypQa+OGgBbmy9QOgQt
	yMTG0/bJIU7Hqru89zwiCbd4i7JTXbx0OzaM+AHqezcv57TeVciC+kGmQpP/MWb6iwOAw3alVZK
	/K31eGZV8hmU/UWR1KqaKjQJlEa+jwaP5BMxFBNTI6C2t9uBCvAD4PrwOZLOSVooNY9oNTBrb58
	iXYfI+VjnxZw5+W5OX5rSRr9a4u0c5uIPke91uuiToTuIWdv9wK7H+Glub3oYYA4gqakXhsOyW4
	GGpqclPB4WwmpzZubSsSZqjA3k6FDTD8rtmvOkSJR3n3IgC2TLEs6LWtzo1NO+cKefDMqYHRnqe
	f+bNPlYtFZ0ihdroROeW3+8pY4nmAnRTQp/c0jcRIC/bbPk7jyldfoFdmH8Idi9y2pR2I4p1vV8
	2KOZhFqi0Sr3+B2g/TdwymXTMimlGfiBDTu4DiMPhZYj4Ns0+pK+g=
X-Received: by 2002:ac8:5c92:0:b0:514:6650:eea4 with SMTP id d75a77b69052e-5165a296e10mr18589761cf.57.1778797601967;
        Thu, 14 May 2026 15:26:41 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456ba92fsm28671901cf.9.2026.05.14.15.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 15:26:41 -0700 (PDT)
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
Subject: [PATCH v2 06/10] liveupdate: Remove limit on the number of sessions
Date: Thu, 14 May 2026 22:26:24 +0000
Message-ID: <20260514222628.931312-7-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260514222628.931312-1-pasha.tatashin@soleen.com>
References: <20260514222628.931312-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_152643_058083_2635979B 
X-CRM114-Status: GOOD (  26.11  )
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

Currently, the number of LUO sessions is limited by a fixed number of
pre-allocated pages for serialization (16 pages, allowing for ~819
sessions).

This limitation is problematic if LUO is used to support things such as
systemd file descriptor store, and would be used not just as VM memory
but to save other states on the machine.

Remove this limit by transitioning to a linked-block approach for
session metadata serialization. Instead of a single contiguous block,
session metadata is now stored in a chain of 16-page blocks. Each block
starts with a header containing the physical address of the next block
and the number of session entries in the current block.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/kho/abi/luo.h     |  24 +-------
 kernel/liveupdate/luo_session.c | 105 +++++++++++++++-----------------
 2 files changed, 50 insertions(+), 79 deletions(-)

diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
index 2ba447c0c1ba..a643193a379c 100644
--- a/include/linux/kho/abi/luo.h
+++ b/include/linux/kho/abi/luo.h
@@ -36,7 +36,7 @@
  *
  * Main LUO Node (/):
  *
- *   - compatible: "luo-v2"
+ *   - compatible: "luo-v3"
  *     Identifies the overall LUO ABI version.
  *   - luo-abi-header: u64
  *     The physical address of `struct luo_ser`.
@@ -54,11 +54,6 @@
  *     of the next data block and the number of entries that follow this
  *     header in the current block.
  *
- *   - struct luo_session_header_ser:
- *     Header for the session array. Contains the total page count of the
- *     preserved memory block and the number of `struct luo_session_ser`
- *     entries that follow.
- *
  *   - struct luo_session_ser:
  *     Metadata for a single session, including its name and a physical pointer
  *     to another preserved memory block containing an array of
@@ -90,7 +85,7 @@
  */
 #define LUO_FDT_SIZE		PAGE_SIZE
 #define LUO_FDT_KHO_ENTRY_NAME	"LUO"
-#define LUO_FDT_COMPATIBLE	"luo-v2"
+#define LUO_FDT_COMPATIBLE	"luo-v3"
 #define LUO_FDT_ABI_HEADER	"luo-abi-header"
 
 /**
@@ -155,21 +150,6 @@ struct luo_file_set_ser {
 	u64 count;
 } __packed;
 
-/**
- * struct luo_session_header_ser - Header for the serialized session data block.
- * @count: The number of `struct luo_session_ser` entries that immediately
- *         follow this header in the memory block.
- *
- * This structure is located at the beginning of a contiguous block of
- * physical memory preserved across the kexec. It provides the necessary
- * metadata to interpret the array of session entries that follow.
- *
- * If this structure is modified, `LUO_FDT_COMPATIBLE` must be updated.
- */
-struct luo_session_header_ser {
-	u64 count;
-} __packed;
-
 /**
  * struct luo_session_ser - Represents the serialized metadata for a LUO session.
  * @name:         The unique name of the session, provided by the userspace at
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 339514e8122c..064e83fabe62 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -69,21 +69,13 @@
 #include <uapi/linux/liveupdate.h>
 #include "luo_internal.h"
 
-/* 16 4K pages, give space for 744 sessions */
-#define LUO_SESSION_PGCNT	16ul
-#define LUO_SESSION_MAX		(((LUO_SESSION_PGCNT << PAGE_SHIFT) -	\
-		sizeof(struct luo_session_header_ser)) /		\
-		sizeof(struct luo_session_ser))
-
 /**
  * struct luo_session_header - Header struct for managing LUO sessions.
  * @count:       The number of sessions currently tracked in the @list.
  * @list:        The head of the linked list of `struct luo_session` instances.
  * @rwsem:       A read-write semaphore providing synchronized access to the
  *               session list and other fields in this structure.
- * @header_ser:  The header data of serialization array.
- * @ser:         The serialized session data (an array of
- *               `struct luo_session_ser`).
+ * @block_set:   The set of serialization blocks.
  * @sessions_pa: Points to the location of sessions_pa within struct luo_ser.
  * @active:      Set to true when first initialized. If previous kernel did not
  *               send session data, active stays false for incoming.
@@ -92,8 +84,7 @@ struct luo_session_header {
 	long count;
 	struct list_head list;
 	struct rw_semaphore rwsem;
-	struct luo_session_header_ser *header_ser;
-	struct luo_session_ser *ser;
+	struct luo_block_set block_set;
 	u64 *sessions_pa;
 	bool active;
 };
@@ -112,10 +103,14 @@ static struct luo_session_global luo_session_global = {
 	.incoming = {
 		.list = LIST_HEAD_INIT(luo_session_global.incoming.list),
 		.rwsem = __RWSEM_INITIALIZER(luo_session_global.incoming.rwsem),
+		.block_set = LUO_BLOCK_SET_INIT(luo_session_global.incoming.block_set,
+						sizeof(struct luo_session_ser)),
 	},
 	.outgoing = {
 		.list = LIST_HEAD_INIT(luo_session_global.outgoing.list),
 		.rwsem = __RWSEM_INITIALIZER(luo_session_global.outgoing.rwsem),
+		.block_set = LUO_BLOCK_SET_INIT(luo_session_global.outgoing.block_set,
+						sizeof(struct luo_session_ser)),
 	},
 };
 
@@ -142,25 +137,6 @@ static void luo_session_free(struct luo_session *session)
 	kfree(session);
 }
 
-static int luo_session_grow_ser(struct luo_session_header *sh)
-{
-	struct luo_session_header_ser *header_ser;
-
-	if (sh->count == LUO_SESSION_MAX)
-		return -ENOMEM;
-
-	if (sh->header_ser)
-		return 0;
-
-	header_ser = kho_alloc_preserve(LUO_SESSION_PGCNT << PAGE_SHIFT);
-	if (IS_ERR(header_ser))
-		return PTR_ERR(header_ser);
-
-	sh->header_ser = header_ser;
-	sh->ser = (void *)(header_ser + 1);
-	return 0;
-}
-
 static int luo_session_insert(struct luo_session_header *sh,
 			      struct luo_session *session)
 {
@@ -174,7 +150,7 @@ static int luo_session_insert(struct luo_session_header *sh,
 	 * for new session.
 	 */
 	if (sh == &luo_session_global.outgoing) {
-		err = luo_session_grow_ser(sh);
+		err = luo_block_grow(&sh->block_set, sh->count);
 		if (err)
 			return err;
 	}
@@ -201,6 +177,8 @@ static void luo_session_remove(struct luo_session_header *sh,
 	guard(rwsem_write)(&sh->rwsem);
 	list_del(&session->list);
 	sh->count--;
+	if (sh == &luo_session_global.outgoing)
+		luo_block_shrink(&sh->block_set, sh->count);
 }
 
 static int luo_session_finish_one(struct luo_session *session)
@@ -489,15 +467,17 @@ void __init luo_session_setup_outgoing(u64 *sessions_pa)
 
 int __init luo_session_setup_incoming(u64 sessions_pa)
 {
-	struct luo_session_header_ser *header_ser;
+	struct luo_session_header *sh = &luo_session_global.incoming;
+	int err;
 
-	if (sessions_pa) {
-		header_ser = phys_to_virt(sessions_pa);
-		luo_session_global.incoming.header_ser = header_ser;
-		luo_session_global.incoming.ser = (void *)(header_ser + 1);
-		luo_session_global.incoming.active = true;
-	}
+	if (!sessions_pa)
+		return 0;
 
+	err = luo_block_restore(&sh->block_set, sessions_pa);
+	if (err)
+		return err;
+
+	sh->active = true;
 	return 0;
 }
 
@@ -539,6 +519,8 @@ int luo_session_deserialize(void)
 {
 	struct luo_session_header *sh = &luo_session_global.incoming;
 	static bool is_deserialized;
+	struct luo_session_ser *ser;
+	struct luo_block_it it;
 	static int err;
 
 	/* If has been deserialized, always return the same error code */
@@ -564,51 +546,60 @@ int luo_session_deserialize(void)
 	 * userspace to detect the failure and trigger a reboot, which will
 	 * reliably reset devices and reclaim memory.
 	 */
-	for (int i = 0; i < sh->header_ser->count; i++) {
-		err = luo_session_deserialize_one(sh, &sh->ser[i]);
+	luo_block_it_init(&it, &sh->block_set);
+	while ((ser = luo_block_it_read(&it))) {
+		err = luo_session_deserialize_one(sh, ser);
 		if (err)
-			return err;
+			goto err_destroy_blocks;
 	}
 
-	kho_restore_free(sh->header_ser);
-	sh->header_ser = NULL;
-	sh->ser = NULL;
+err_destroy_blocks:
+	luo_block_destroy(&sh->block_set);
 
-	return 0;
+	return err;
 }
 
 int luo_session_serialize(void)
 {
 	struct luo_session_header *sh = &luo_session_global.outgoing;
 	struct luo_session *session;
-	int i = 0;
+	struct luo_block_it it;
 	int err;
 
 	guard(rwsem_write)(&sh->rwsem);
 	*sh->sessions_pa = 0;
 
+	luo_block_it_init(&it, &sh->block_set);
+
 	list_for_each_entry(session, &sh->list, list) {
-		err = luo_session_freeze_one(session, &sh->ser[i]);
+		struct luo_session_ser *ser = luo_block_it_next(&it);
+
+		if (!ser) {
+			err = -ENOSPC;
+			goto err_undo;
+		}
+
+		err = luo_session_freeze_one(session, ser);
 		if (err)
 			goto err_undo;
 
-		strscpy(sh->ser[i].name, session->name,
-			sizeof(sh->ser[i].name));
-		i++;
+		strscpy(ser->name, session->name, sizeof(ser->name));
 	}
 
-	if (sh->header_ser && sh->count > 0) {
-		sh->header_ser->count = sh->count;
-		*sh->sessions_pa = virt_to_phys(sh->header_ser);
-	}
+	luo_block_it_finalize(&it);
+
+	if (sh->sessions_pa && sh->count > 0)
+		*sh->sessions_pa = sh->block_set.head_pa;
 
 	return 0;
 
 err_undo:
+	luo_block_it_prev(&it);
 	list_for_each_entry_continue_reverse(session, &sh->list, list) {
-		i--;
-		luo_session_unfreeze_one(session, &sh->ser[i]);
-		memset(sh->ser[i].name, 0, sizeof(sh->ser[i].name));
+		struct luo_session_ser *ser = luo_block_it_prev(&it);
+
+		luo_session_unfreeze_one(session, ser);
+		memset(ser->name, 0, sizeof(ser->name));
 	}
 
 	return err;
-- 
2.53.0


