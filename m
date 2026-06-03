Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E04CD6E6E
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 03:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tz2WlgQShBzc08rHE8f9hPH77UCMh/X7xv20EWPP2Uw=; b=VHCvVwhmt+AzQSKlbg/rHW8D0Y
	dCdno1q8yqmjZNy8/2unj2XVoGRHZai+kYuJeQ22vi8tsVkyNXeWwxpFKUxCV8cGcumXxwXlatVjW
	HVUAdKaehdfJWhYKv2kH+NGHQT3r469HHqPhcdLWOu86s6QnFjoO6rXVKnhObHLCu+0WyObkllLib
	9LwoJ1VAI3kStAdeU6BbxNAdIQCJh2/CVgSJd/DSfWWbBGv0Nnkhj8dKGyYwwlSKYqgDGr3ED6c8x
	CvKhXzIYDEPK/0q0vCAzoWBuoA2Ukde0+Y5PasixZp7OW6SKPVXc5jMGqy4aA0/Qnpec31FZKRihs
	ftwPnXYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUcIF-0000000EB4N-3Mca;
	Wed, 03 Jun 2026 03:29:23 +0000
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUcID-0000000EB0r-2GUO
	for kexec@lists.infradead.org;
	Wed, 03 Jun 2026 03:29:22 +0000
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-8ce9df48e1bso31845166d6.1
        for <kexec@lists.infradead.org>; Tue, 02 Jun 2026 20:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780457360; x=1781062160; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tz2WlgQShBzc08rHE8f9hPH77UCMh/X7xv20EWPP2Uw=;
        b=bY/ZxxNPTNwLUtdE1Am28M7zVS5QS27vd8PwEwoo6Q6r0ZYjcd9TQZSHLR0AmS6V+t
         MmnHFW4rOH91ikVKqw6BvWUzyjmkzIsQykv924LSrNu2pPJ6NMJ15wa0+gry5bUTNTQt
         6CLFM7jcavsKZfTjpVr65sLIjygXurARzHfJ+KHC6Rb0cTxjoYeC00hIE5XPKSIQReZ4
         rnNPYkY9S2sUdIyQZMhCdee7tlWdIgkHKD1O5vQdoAaSioyIVL1+6/H8Kyi5oyTYBAw8
         ykvc6yRCof9Ku/NLKe9TriCAlneGXxOEB1rM8PJbBGKlh9g6/q0W1MB86QmQIb1ENt7R
         Ezkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780457360; x=1781062160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tz2WlgQShBzc08rHE8f9hPH77UCMh/X7xv20EWPP2Uw=;
        b=D41lVDcsXGBtpscEj2wnzECNuY8k1EVrYa1pV3ptYlJR0IvLJCQMhTGhblb3jS9Srn
         5IXlouvOPnK2Wd5tXjRzOPIp57rJo4NTMzbkXF1bdKlQoMjErj0MQv8GXA3DcBdbYWkS
         4uXIo51yxUYbrPDPAAZ6ofSUWa16xdMSoZHpeC8ihzqjkEiF4FmJcMIZT8rY7ULOJCiU
         1+4m7rKEjw4cQOJg9n7xtpBfSMK5ITbT48z/sxPgWAQx1I2qy6aO3hfD+WnqjzJovvrZ
         yRMDRQiyBp3LX1vvi0cvpRio6rhlJw05L6izxdP97K/iUv/iqaXL1fFJM3JhHzNvlPAz
         dl5g==
X-Forwarded-Encrypted: i=1; AFNElJ+Gtix1YNjphOBBV+KQBtUFp96Kd/HcCXQAwl56MSpWWim7cM67KLDIhsYU1qTZpDm7meXkKQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwncrgDk4xYRlx+R/+1MplgUheiqJ6CkAhlpAwCGFRqAKtT4qMp
	obgghoFrmG10KICnbkyCE/iBuAi3QPIy7HM4rTe1w+WwRhIalL70BY+6tclI+TCYEnY=
X-Gm-Gg: Acq92OE2lG43rI2CQXik6I1kVkTiaWFGV/W0rHAkYytyF/qLIzk8fPfvArkocU0Vhm6
	80otoSNK1RvQGRAUB/7h3Bf/+QA08Z7B6E7HUhmrRp7Xbckx0NlSEs3Hozaw5xI6S8lP7IfxChw
	7TJe3DBCgVbgZqY4h6uYDW+iGBECFCn16MxU+SL9sa/SpDpSKaCDrBIDXIjHtt3IEGIrQwnTPAy
	J80KIU5gTxmRU8n6vv1G/xz4pFK6gJWSkKD1NGfPWa2quHawFISaweXL4ZkfV0JVyLaQz1X3mmi
	qiHkx8OL/qtadDeBNnRWCu9MeC+agnQ+CePKBYKewj+s8xSmojxazbAF3xyJONuPXdW6Wn72IE+
	oYwX9HrktzNIrjcn6h+zUA2z2Rmdf9jYVOuTEtk+kNKTpYns4lisLEdaGIoTIbTwSsrY5CpqgkG
	6s7fTLIJYRNVTqAJKGhS8oDW18hPVtV3YdyVoVYtZ/UxntO3M24Yi/M/mFdIC0uw==
X-Received: by 2002:a05:6214:260e:b0:8ac:a154:e156 with SMTP id 6a1803df08f44-8cecdca3c5emr23602316d6.29.1780457360528;
        Tue, 02 Jun 2026 20:29:20 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd26b3b9sm9244566d6.45.2026.06.02.20.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 20:29:19 -0700 (PDT)
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
Subject: [PATCH v6 09/13] liveupdate: Remove limit on the number of sessions
Date: Wed,  3 Jun 2026 03:29:00 +0000
Message-ID: <20260603032905.344462-10-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603032905.344462-1-pasha.tatashin@soleen.com>
References: <20260603032905.344462-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_202921_612504_FD323CBE 
X-CRM114-Status: GOOD (  28.56  )
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

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/kho/abi/luo.h     |  24 +------
 kernel/liveupdate/luo_session.c | 113 +++++++++++++++-----------------
 2 files changed, 56 insertions(+), 81 deletions(-)

diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
index 9a4fe491812b..79758d92ed5f 100644
--- a/include/linux/kho/abi/luo.h
+++ b/include/linux/kho/abi/luo.h
@@ -33,11 +33,6 @@
  *     It includes the compatibility string, the liveupdate-number, and pointers
  *     to sessions and FLBs.
  *
- *   - struct luo_session_header_ser:
- *     Header for the session array. Contains the total page count of the
- *     preserved memory block and the number of `struct luo_session_ser`
- *     entries that follow.
- *
  *   - struct luo_session_ser:
  *     Metadata for a single session, including its name and a physical pointer
  *     to another preserved memory block containing an array of
@@ -63,13 +58,15 @@
 #define _LINUX_KHO_ABI_LUO_H
 
 #include <linux/align.h>
+#include <linux/kho/abi/block.h>
 #include <uapi/linux/liveupdate.h>
 
 /*
  * The LUO state is registered under this KHO entry name.
  */
 #define LUO_KHO_ENTRY_NAME	"LUO"
-#define LUO_ABI_COMPATIBLE	"luo-v3"
+#define LUO_COMPAT_BASE		"luo-v3"
+#define LUO_ABI_COMPATIBLE	LUO_COMPAT_BASE "-" KHO_BLOCK_ABI_COMPATIBLE
 #define LUO_ABI_COMPAT_LEN	ALIGN(sizeof(LUO_ABI_COMPATIBLE), 8)
 
 /**
@@ -118,21 +115,6 @@ struct luo_file_set_ser {
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
- * If this structure is modified, `LUO_ABI_COMPATIBLE` must be updated.
- */
-struct luo_session_header_ser {
-	u64 count;
-} __packed;
-
 /**
  * struct luo_session_ser - Represents the serialized metadata for a LUO session.
  * @name:         The unique name of the session, provided by the userspace at
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 2411849a34e3..b79b2a488974 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -24,9 +24,10 @@
  *   ioctls on /dev/liveupdate.
  *
  * - Serialization: Session metadata is preserved using the KHO framework. When
- *   a live update is triggered via kexec, an array of `struct luo_session_ser`
- *   is populated and placed in a preserved memory region. The physical address
- *   of this array is stored in the centralized `struct luo_ser` structure.
+ *   a live update is triggered via kexec, session metadata is serialized into
+ *   a chain of linked-blocks and placed in a preserved memory region. The
+ *   physical address of the first block header is stored in the centralized
+ *   `struct luo_ser` structure.
  *
  * Session Lifecycle:
  *
@@ -89,6 +90,7 @@
 #include <linux/fs.h>
 #include <linux/io.h>
 #include <linux/kexec_handover.h>
+#include <linux/kho_block.h>
 #include <linux/kho/abi/luo.h>
 #include <linux/list.h>
 #include <linux/liveupdate.h>
@@ -98,23 +100,14 @@
 #include <uapi/linux/liveupdate.h>
 #include "luo_internal.h"
 
-/* 16 4K pages, give space for 744 sessions */
-#define LUO_SESSION_PGCNT	16ul
-#define LUO_SESSION_MAX		(((LUO_SESSION_PGCNT << PAGE_SHIFT) -	\
-		sizeof(struct luo_session_header_ser)) /		\
-		sizeof(struct luo_session_ser))
-
 static DECLARE_RWSEM(luo_session_serialize_rwsem);
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
@@ -123,8 +116,7 @@ struct luo_session_header {
 	long count;
 	struct list_head list;
 	struct rw_semaphore rwsem;
-	struct luo_session_header_ser *header_ser;
-	struct luo_session_ser *ser;
+	struct kho_block_set block_set;
 	u64 *sessions_pa;
 	bool active;
 };
@@ -143,10 +135,14 @@ static struct luo_session_global luo_session_global = {
 	.incoming = {
 		.list = LIST_HEAD_INIT(luo_session_global.incoming.list),
 		.rwsem = __RWSEM_INITIALIZER(luo_session_global.incoming.rwsem),
+		.block_set = KHO_BLOCK_SET_INIT(luo_session_global.incoming.block_set,
+						sizeof(struct luo_session_ser)),
 	},
 	.outgoing = {
 		.list = LIST_HEAD_INIT(luo_session_global.outgoing.list),
 		.rwsem = __RWSEM_INITIALIZER(luo_session_global.outgoing.rwsem),
+		.block_set = KHO_BLOCK_SET_INIT(luo_session_global.outgoing.block_set,
+						sizeof(struct luo_session_ser)),
 	},
 };
 
@@ -173,25 +169,6 @@ static void luo_session_free(struct luo_session *session)
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
@@ -205,7 +182,7 @@ static int luo_session_insert(struct luo_session_header *sh,
 	 * for new session.
 	 */
 	if (sh == &luo_session_global.outgoing) {
-		err = luo_session_grow_ser(sh);
+		err = kho_block_set_grow(&sh->block_set, sh->count + 1);
 		if (err)
 			return err;
 	}
@@ -232,6 +209,8 @@ static void luo_session_remove(struct luo_session_header *sh,
 	guard(rwsem_write)(&sh->rwsem);
 	list_del(&session->list);
 	sh->count--;
+	if (sh == &luo_session_global.outgoing)
+		kho_block_set_shrink(&sh->block_set, sh->count);
 }
 
 static int luo_session_finish_one(struct luo_session *session)
@@ -555,15 +534,17 @@ void __init luo_session_setup_outgoing(u64 *sessions_pa)
 
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
 
+	err = kho_block_set_restore(&sh->block_set, sessions_pa);
+	if (err)
+		return err;
+
+	sh->active = true;
 	return 0;
 }
 
@@ -605,6 +586,8 @@ int luo_session_deserialize(void)
 {
 	struct luo_session_header *sh = &luo_session_global.incoming;
 	static bool is_deserialized;
+	struct luo_session_ser *ser;
+	struct kho_block_set_it it;
 	static int saved_err;
 	int err;
 
@@ -631,18 +614,19 @@ int luo_session_deserialize(void)
 	 * userspace to detect the failure and trigger a reboot, which will
 	 * reliably reset devices and reclaim memory.
 	 */
-	for (int i = 0; i < sh->header_ser->count; i++) {
-		err = luo_session_deserialize_one(sh, &sh->ser[i]);
+	kho_block_set_it_init(&it, &sh->block_set);
+	while ((ser = kho_block_set_it_read_entry(&it))) {
+		err = luo_session_deserialize_one(sh, ser);
 		if (err)
 			goto save_err;
 	}
 
-	kho_restore_free(sh->header_ser);
-	sh->header_ser = NULL;
-	sh->ser = NULL;
+	kho_block_set_destroy(&sh->block_set);
 
 	return 0;
+
 save_err:
+	kho_block_set_destroy(&sh->block_set);
 	saved_err = err;
 	return err;
 }
@@ -651,36 +635,45 @@ int luo_session_serialize(void)
 {
 	struct luo_session_header *sh = &luo_session_global.outgoing;
 	struct luo_session *session;
-	int i = 0;
+	struct kho_block_set_it it;
 	int err;
 
 	down_write(&luo_session_serialize_rwsem);
 	down_write(&sh->rwsem);
 	*sh->sessions_pa = 0;
 
+	kho_block_set_it_init(&it, &sh->block_set);
+
 	list_for_each_entry(session, &sh->list, list) {
-		err = luo_session_freeze_one(session, &sh->ser[i]);
-		if (err)
+		struct luo_session_ser *ser = kho_block_set_it_reserve_entry(&it);
+
+		/* This should not fail normally as blocks were pre-allocated */
+		if (WARN_ON_ONCE(!ser)) {
+			err = -ENOSPC;
 			goto err_undo;
+		}
 
-		strscpy(sh->ser[i].name, session->name,
-			sizeof(sh->ser[i].name));
-		i++;
-	}
+		err = luo_session_freeze_one(session, ser);
+		if (err) {
+			kho_block_set_it_prev(&it);
+			goto err_undo;
+		}
 
-	if (sh->header_ser && sh->count > 0) {
-		sh->header_ser->count = sh->count;
-		*sh->sessions_pa = virt_to_phys(sh->header_ser);
+		strscpy(ser->name, session->name, sizeof(ser->name));
 	}
+
+	if (sh->count > 0)
+		*sh->sessions_pa = kho_block_set_head_pa(&sh->block_set);
 	up_write(&sh->rwsem);
 
 	return 0;
 
 err_undo:
 	list_for_each_entry_continue_reverse(session, &sh->list, list) {
-		i--;
-		luo_session_unfreeze_one(session, &sh->ser[i]);
-		memset(sh->ser[i].name, 0, sizeof(sh->ser[i].name));
+		struct luo_session_ser *ser = kho_block_set_it_prev(&it);
+
+		luo_session_unfreeze_one(session, ser);
+		memset(ser->name, 0, sizeof(ser->name));
 	}
 	up_write(&sh->rwsem);
 	up_write(&luo_session_serialize_rwsem);
-- 
2.53.0


