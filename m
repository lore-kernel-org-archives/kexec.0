Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77646F9D0F6
	for <kexec@archiver.kernel.org>; Tue, 14 Apr 2026 20:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LCjDlIp8tcNOYvfHKmC0ZdWTLeU0ejjgXIXAdGPq7KQ=; b=KlnVC0Y3TRxsNRY1US3NlNVh9s
	uS7LMnrBqW3k+LGEzkWp8/SUaRH7/4rz0mpo45JfY5LZM1OTs9kElEVqt7LM6QmfWnSQvbQNQcUSS
	ErywjYJO4ifht8ZC/1YnjQ6VJw5soytoS7iSDTKiGgMls1twXE234q9OcALrcEM0WKvBm/wMh0rZP
	TWo91UX89G+ZY43XiVwFUaeE2dOhFEqwAWiG8X1qU3+zd0PdhW5e6V7fwv494VstR1w40Uh8Z1uzY
	SlSKtm3PsmfEwUnZbUpBVUxW6iETRFZcloSNbYKdXsMktaLmrVvZFD1UqrXIAfdABqoY9DFcDVYKH
	mFaopGtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCjy8-00000000B2H-2b5I;
	Tue, 14 Apr 2026 20:02:44 +0000
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCjy6-00000000B1W-34OD
	for kexec@lists.infradead.org;
	Tue, 14 Apr 2026 20:02:44 +0000
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-8a0323830beso49772486d6.0
        for <kexec@lists.infradead.org>; Tue, 14 Apr 2026 13:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1776196961; x=1776801761; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LCjDlIp8tcNOYvfHKmC0ZdWTLeU0ejjgXIXAdGPq7KQ=;
        b=UiTgibDJGZMAP+F0oAo/dYFmjezcxmZCkOb6gphMdM9EtPS/wO8Lw4Bnw+OWgggdeg
         qGP9OVbgELDB2XdX0Ec2LdS5WcFfWleCqzW06toC2uMbjgZx/+k7N6aqsZizhUU+VBlQ
         8XzLGZy/oZ7F/fgHGKjwZMhFYo7sqycWVOOkS9OXq+RHvXujCQOKiCJDCfeEogfy0hHT
         3+xwhlojpSv5h5Mhq6ktopJvDax5FaaD9GKjP+DAdYjvPGaC1pHsYW52HMsZRVfyeWaF
         lop4AxpIcMHr69DzL43A+KGW8IgXeV3idu9as7acDY2539wNpWwDM3xh+M4fC5gYmkFm
         bl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776196961; x=1776801761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LCjDlIp8tcNOYvfHKmC0ZdWTLeU0ejjgXIXAdGPq7KQ=;
        b=o0tpkbXtEEMKKakrK9DKOXsMs0+Qb38hHs52jPI4cURHxMC2ZkrDmKb88a4KUZ5YyI
         2ePiqiQCoFxvZu/GAXCkFzH1B+wAYebLk52MKPCrhnkkXpjTzm7Xk0oHASRnXcRIUnzM
         L96PHGTUfojGGx+X4apnJMkZOHepyL2wYteAv2X+DKPGj6ZGdGEDXzHu2RqIAuoy+h7n
         ggD3dr+5Bmgh/3ZjhiQrZySJbIiWJ2sUdYH/7P5u3gI/prlR0K738PUGF/iehsXDsIbz
         kLtOJ1piCg51WdsmCAXaD4i+Mk0sf6nFAaqy2d+j4W3hv6YgGaSl6L4FFhVAACJhrWwt
         Ni2Q==
X-Forwarded-Encrypted: i=1; AFNElJ8Gm2qZcjEHRrX0TecVd4/I4yqtvBippdTpXJF6fXz1rP0/pUcotTNV1NXYhOnWqAxQOGY4WQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzVb0HXq6Jy+yCFIwG/A6KtsLI0/KDhvKJf5xFSfCzW1GwEzK97
	jpypNK+XeJ6bf4Kw7TzJDlyFTRVZmrdMugBKejnzMvN8ZJwTj4cdXNOaHDZj4R5Mpno=
X-Gm-Gg: AeBDievjjmbE8Ayn5rnOgSJ/rdR76pl7+0dATtqUv37V8MT0qSmAvQtc4zAjle9tKIz
	FHZYkGsIJ9OfqWrVlVVz+jYRpTmoQCcROv4OEt+S/ZY+LlVFHMxCvHZ90ZQagEwI+49iZpdULtS
	YiWXUysLxntyi2bkP6//dOVMzlxJWNvtRpS2XtlhkPZiaD71xxE22B3T+xrCDkJ0C1b1UmNO4w2
	KiW7VkS8WHqaMCHLMOdKQ6Xj00yh6/UPxrNUX8Ebr4xf8PH5OG+EQhalvEGoFw9ngdpkqpW8YqU
	LV5yLBYQkVebgPp2THCyvvNHnk8ACqSOECzH0cr0Bo5URkYZiIYDzQUCkNGKT5g7g14glAvn/iE
	9bJxfpsKHiLr/lxw6AxpagkCa4EEUw1eafRahYCNofLLTAYsdywp/Hl9DlupzO9zmqV/Mpyq8tD
	5QKHnzPKpyQmo5DlRC0hGikzb3D63uG8aiVpe2qWPaOxa2+jso8CW2P3G1d/mhALuXsA==
X-Received: by 2002:ad4:5966:0:b0:8ac:b738:45dd with SMTP id 6a1803df08f44-8acb7384f03mr120301296d6.34.1776196961105;
        Tue, 14 Apr 2026 13:02:41 -0700 (PDT)
Received: from plex.localdomain ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84a180a2sm132213656d6.15.2026.04.14.13.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 13:02:40 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	shuah@kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	pasha.tatashin@soleen.com,
	dmatlack@google.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	skhawaja@google.com,
	graf@amazon.com
Subject: [PATCH 1/5] liveupdate: Remove limit on the number of sessions
Date: Tue, 14 Apr 2026 20:02:33 +0000
Message-ID: <20260414200237.444170-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260414200237.444170-1-pasha.tatashin@soleen.com>
References: <20260414200237.444170-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_130242_873645_4EF513D8 
X-CRM114-Status: GOOD (  31.02  )
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

- Bump session ABI version to v3.
- Update struct luo_session_header_ser to include a 'next' pointer.
- Implement dynamic block allocation in luo_session_insert().
- Update setup, serialization, and deserialization logic to traverse
  the block chain.
- Remove LUO_SESSION_MAX limit.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/kho/abi/luo.h      |  19 +--
 kernel/liveupdate/luo_internal.h |  12 +-
 kernel/liveupdate/luo_session.c  | 237 +++++++++++++++++++++++--------
 3 files changed, 197 insertions(+), 71 deletions(-)

diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
index 46750a0ddf88..f5732958545e 100644
--- a/include/linux/kho/abi/luo.h
+++ b/include/linux/kho/abi/luo.h
@@ -57,9 +57,10 @@
  *   - compatible: "luo-session-v1"
  *     Identifies the session ABI version.
  *   - luo-session-header: u64
- *     The physical address of a `struct luo_session_header_ser`. This structure
- *     is the header for a contiguous block of memory containing an array of
- *     `struct luo_session_ser`, one for each preserved session.
+ *     The physical address of the first `struct luo_session_header_ser`.
+ *     This structure is the header for a block of memory containing an array
+ *     of `struct luo_session_ser` entries. Multiple blocks are linked via
+ *     the `next` field in the header.
  *
  * File-Lifecycle-Bound Node (luo-flb):
  *   This node describes all preserved global objects whose lifecycle is bound
@@ -77,9 +78,9 @@
  *   `__packed` structures. These structures contain the actual preserved state.
  *
  *   - struct luo_session_header_ser:
- *     Header for the session array. Contains the total page count of the
- *     preserved memory block and the number of `struct luo_session_ser`
- *     entries that follow.
+ *     Header for the session data block. Contains the physical address of the
+ *     next session data block and the number of `struct luo_session_ser`
+ *     entries that follow this header in the current block.
  *
  *   - struct luo_session_ser:
  *     Metadata for a single session, including its name and a physical pointer
@@ -153,21 +154,23 @@ struct luo_file_set_ser {
  *                          luo_session_header_ser
  */
 #define LUO_FDT_SESSION_NODE_NAME	"luo-session"
-#define LUO_FDT_SESSION_COMPATIBLE	"luo-session-v2"
+#define LUO_FDT_SESSION_COMPATIBLE	"luo-session-v3"
 #define LUO_FDT_SESSION_HEADER		"luo-session-header"
 
 /**
  * struct luo_session_header_ser - Header for the serialized session data block.
+ * @next:  Physical address of the next struct luo_session_header_ser.
  * @count: The number of `struct luo_session_ser` entries that immediately
  *         follow this header in the memory block.
  *
- * This structure is located at the beginning of a contiguous block of
+ * This structure is located at the beginning of a block of
  * physical memory preserved across the kexec. It provides the necessary
  * metadata to interpret the array of session entries that follow.
  *
  * If this structure is modified, `LUO_FDT_SESSION_COMPATIBLE` must be updated.
  */
 struct luo_session_header_ser {
+	u64 next;
 	u64 count;
 } __packed;
 
diff --git a/kernel/liveupdate/luo_internal.h b/kernel/liveupdate/luo_internal.h
index 875844d7a41d..a73f42069301 100644
--- a/kernel/liveupdate/luo_internal.h
+++ b/kernel/liveupdate/luo_internal.h
@@ -11,6 +11,16 @@
 #include <linux/liveupdate.h>
 #include <linux/uaccess.h>
 
+/*
+ * Safeguard limit for the number of serialization blocks. This is used to
+ * prevent infinite loops and excessive memory allocation in case of memory
+ * corruption in the preserved state.
+ *
+ * This limit allows for ~8.1 million sessions and ~1.2 million files per
+ * session, which is more than enough for all realistic use cases.
+ */
+#define LUO_MAX_BLOCKS 10000
+
 struct luo_ucmd {
 	void __user *ubuffer;
 	u32 user_size;
@@ -59,7 +69,6 @@ struct luo_file_set {
  * struct luo_session - Represents an active or incoming Live Update session.
  * @name:       A unique name for this session, used for identification and
  *              retrieval.
- * @ser:        Pointer to the serialized data for this session.
  * @list:       A list_head member used to link this session into a global list
  *              of either outgoing (to be preserved) or incoming (restored from
  *              previous kernel) sessions.
@@ -70,7 +79,6 @@ struct luo_file_set {
  */
 struct luo_session {
 	char name[LIVEUPDATE_SESSION_NAME_LENGTH];
-	struct luo_session_ser *ser;
 	struct list_head list;
 	bool retrieved;
 	struct luo_file_set file_set;
diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
index 92b1af791889..007ca34eba79 100644
--- a/kernel/liveupdate/luo_session.c
+++ b/kernel/liveupdate/luo_session.c
@@ -69,30 +69,39 @@
 #include <uapi/linux/liveupdate.h>
 #include "luo_internal.h"
 
-/* 16 4K pages, give space for 744 sessions */
+/* 16 4K pages, give space for 819 sessions per block */
 #define LUO_SESSION_PGCNT	16ul
-#define LUO_SESSION_MAX		(((LUO_SESSION_PGCNT << PAGE_SHIFT) -	\
+#define LUO_SESSION_BLOCK_MAX		(((LUO_SESSION_PGCNT << PAGE_SHIFT) -	\
 		sizeof(struct luo_session_header_ser)) /		\
 		sizeof(struct luo_session_ser))
 
+/**
+ * struct luo_session_block - Internal representation of a session serialization block.
+ * @list: List head for linking blocks in memory.
+ * @ser:  Pointer to the serialized header in preserved memory.
+ */
+struct luo_session_block {
+	struct list_head list;
+	struct luo_session_header_ser *ser;
+};
+
 /**
  * struct luo_session_header - Header struct for managing LUO sessions.
  * @count:      The number of sessions currently tracked in the @list.
+ * @nblocks:    The number of allocated serialization blocks.
  * @list:       The head of the linked list of `struct luo_session` instances.
  * @rwsem:      A read-write semaphore providing synchronized access to the
  *              session list and other fields in this structure.
- * @header_ser: The header data of serialization array.
- * @ser:        The serialized session data (an array of
- *              `struct luo_session_ser`).
+ * @blocks:     The list of serialization blocks (struct luo_session_block).
  * @active:     Set to true when first initialized. If previous kernel did not
  *              send session data, active stays false for incoming.
  */
 struct luo_session_header {
 	long count;
+	long nblocks;
 	struct list_head list;
 	struct rw_semaphore rwsem;
-	struct luo_session_header_ser *header_ser;
-	struct luo_session_ser *ser;
+	struct list_head blocks;
 	bool active;
 };
 
@@ -110,10 +119,12 @@ static struct luo_session_global luo_session_global = {
 	.incoming = {
 		.list = LIST_HEAD_INIT(luo_session_global.incoming.list),
 		.rwsem = __RWSEM_INITIALIZER(luo_session_global.incoming.rwsem),
+		.blocks = LIST_HEAD_INIT(luo_session_global.incoming.blocks),
 	},
 	.outgoing = {
 		.list = LIST_HEAD_INIT(luo_session_global.outgoing.list),
 		.rwsem = __RWSEM_INITIALIZER(luo_session_global.outgoing.rwsem),
+		.blocks = LIST_HEAD_INIT(luo_session_global.outgoing.blocks),
 	},
 };
 
@@ -140,6 +151,70 @@ static void luo_session_free(struct luo_session *session)
 	kfree(session);
 }
 
+static int luo_session_add_block(struct luo_session_header *sh,
+				 struct luo_session_header_ser *ser)
+{
+	struct luo_session_block *block;
+
+	if (sh->nblocks >= LUO_MAX_BLOCKS)
+		return -ENOSPC;
+
+	block = kzalloc_obj(*block);
+	if (!block)
+		return -ENOMEM;
+
+	block->ser = ser;
+	list_add_tail(&block->list, &sh->blocks);
+	sh->nblocks++;
+
+	return 0;
+}
+
+static int luo_session_create_ser_block(struct luo_session_header *sh)
+{
+	struct luo_session_block *last = NULL;
+	struct luo_session_header_ser *ser;
+	int err;
+
+	ser = kho_alloc_preserve(LUO_SESSION_PGCNT << PAGE_SHIFT);
+	if (IS_ERR(ser))
+		return PTR_ERR(ser);
+
+	if (!list_empty(&sh->blocks))
+		last = list_last_entry(&sh->blocks, struct luo_session_block, list);
+
+	err = luo_session_add_block(sh, ser);
+	if (err)
+		goto err_unpreserve;
+
+	if (last)
+		last->ser->next = virt_to_phys(ser);
+
+	return 0;
+
+err_unpreserve:
+	kho_unpreserve_free(ser);
+	return err;
+}
+
+static void luo_session_destroy_ser_blocks(struct luo_session_header *sh,
+					   bool unpreserve)
+{
+	struct luo_session_block *block, *tmp;
+
+	list_for_each_entry_safe(block, tmp, &sh->blocks, list) {
+		if (block->ser) {
+			if (unpreserve)
+				kho_unpreserve_free(block->ser);
+			else
+				kho_restore_free(block->ser);
+		}
+		list_del(&block->list);
+		kfree(block);
+		sh->nblocks--;
+	}
+}
+
 static int luo_session_insert(struct luo_session_header *sh,
 			      struct luo_session *session)
 {
@@ -147,15 +222,6 @@ static int luo_session_insert(struct luo_session_header *sh,
 
 	guard(rwsem_write)(&sh->rwsem);
 
-	/*
-	 * For outgoing we should make sure there is room in serialization array
-	 * for new session.
-	 */
-	if (sh == &luo_session_global.outgoing) {
-		if (sh->count == LUO_SESSION_MAX)
-			return -ENOMEM;
-	}
-
 	/*
 	 * For small number of sessions this loop won't hurt performance
 	 * but if we ever start using a lot of sessions, this might
@@ -166,6 +232,20 @@ static int luo_session_insert(struct luo_session_header *sh,
 		if (!strncmp(it->name, session->name, sizeof(it->name)))
 			return -EEXIST;
 	}
+
+	/*
+	 * For outgoing we should make sure there is room in serialization array
+	 * for new session. If not, allocate a new block.
+	 */
+	if (sh == &luo_session_global.outgoing) {
+		if (sh->count == sh->nblocks * LUO_SESSION_BLOCK_MAX) {
+			int err = luo_session_create_ser_block(sh);
+
+			if (err)
+				return err;
+		}
+	}
+
 	list_add_tail(&session->list, &sh->list);
 	sh->count++;
 
@@ -444,9 +524,12 @@ int __init luo_session_setup_outgoing(void *fdt_out)
 	u64 header_ser_pa;
 	int err;
 
-	header_ser = kho_alloc_preserve(LUO_SESSION_PGCNT << PAGE_SHIFT);
-	if (IS_ERR(header_ser))
-		return PTR_ERR(header_ser);
+	err = luo_session_create_ser_block(&luo_session_global.outgoing);
+	if (err)
+		return err;
+
+	header_ser = list_first_entry(&luo_session_global.outgoing.blocks,
+				      struct luo_session_block, list)->ser;
 	header_ser_pa = virt_to_phys(header_ser);
 
 	err = fdt_begin_node(fdt_out, LUO_FDT_SESSION_NODE_NAME);
@@ -459,19 +542,18 @@ int __init luo_session_setup_outgoing(void *fdt_out)
 	if (err)
 		goto err_unpreserve;
 
-	luo_session_global.outgoing.header_ser = header_ser;
-	luo_session_global.outgoing.ser = (void *)(header_ser + 1);
 	luo_session_global.outgoing.active = true;
 
 	return 0;
 
 err_unpreserve:
-	kho_unpreserve_free(header_ser);
+	luo_session_destroy_ser_blocks(&luo_session_global.outgoing, true);
 	return err;
 }
 
 int __init luo_session_setup_incoming(void *fdt_in)
 {
+	struct luo_session_header *sh = &luo_session_global.incoming;
 	struct luo_session_header_ser *header_ser;
 	int err, header_size, offset;
 	u64 header_ser_pa;
@@ -501,11 +583,14 @@ int __init luo_session_setup_incoming(void *fdt_in)
 	}
 
 	header_ser_pa = get_unaligned((u64 *)ptr);
-	header_ser = phys_to_virt(header_ser_pa);
-
-	luo_session_global.incoming.header_ser = header_ser;
-	luo_session_global.incoming.ser = (void *)(header_ser + 1);
-	luo_session_global.incoming.active = true;
+	while (header_ser_pa) {
+		header_ser = phys_to_virt(header_ser_pa);
+		err = luo_session_add_block(sh, header_ser);
+		if (err)
+			return err;
+		header_ser_pa = header_ser->next;
+	}
+	sh->active = true;
 
 	return 0;
 }
@@ -513,6 +598,7 @@ int __init luo_session_setup_incoming(void *fdt_in)
 int luo_session_deserialize(void)
 {
 	struct luo_session_header *sh = &luo_session_global.incoming;
+	struct luo_session_block *block;
 	static bool is_deserialized;
 	static int err;
 
@@ -539,40 +625,49 @@ int luo_session_deserialize(void)
 	 * userspace to detect the failure and trigger a reboot, which will
 	 * reliably reset devices and reclaim memory.
 	 */
-	for (int i = 0; i < sh->header_ser->count; i++) {
-		struct luo_session *session;
-
-		session = luo_session_alloc(sh->ser[i].name);
-		if (IS_ERR(session)) {
-			pr_warn("Failed to allocate session [%.*s] during deserialization %pe\n",
-				(int)sizeof(sh->ser[i].name),
-				sh->ser[i].name, session);
-			err = PTR_ERR(session);
-			return err;
-		}
+	list_for_each_entry(block, &sh->blocks, list) {
+		struct luo_session_ser *ser = (void *)(block->ser + 1);
 
-		err = luo_session_insert(sh, session);
-		if (err) {
-			pr_warn("Failed to insert session [%s] %pe\n",
-				session->name, ERR_PTR(err));
-			luo_session_free(session);
+		if (block->ser->count > LUO_SESSION_BLOCK_MAX) {
+			pr_warn("Session block contains too many entries: %llu\n",
+				block->ser->count);
+			err = -EINVAL;
 			return err;
 		}
 
-		scoped_guard(mutex, &session->mutex) {
-			err = luo_file_deserialize(&session->file_set,
-						   &sh->ser[i].file_set_ser);
-		}
-		if (err) {
-			pr_warn("Failed to deserialize files for session [%s] %pe\n",
-				session->name, ERR_PTR(err));
-			return err;
+		for (int i = 0; i < block->ser->count; i++) {
+			struct luo_session *session;
+
+			session = luo_session_alloc(ser[i].name);
+			if (IS_ERR(session)) {
+				pr_warn("Failed to allocate session [%.*s] during deserialization %pe\n",
+					(int)sizeof(ser[i].name),
+					ser[i].name, session);
+				err = PTR_ERR(session);
+				return err;
+			}
+
+			err = luo_session_insert(sh, session);
+			if (err) {
+				pr_warn("Failed to insert session [%s] %pe\n",
+					session->name, ERR_PTR(err));
+				luo_session_free(session);
+				return err;
+			}
+
+			scoped_guard(mutex, &session->mutex) {
+				err = luo_file_deserialize(&session->file_set,
+							   &ser[i].file_set_ser);
+			}
+			if (err) {
+				pr_warn("Failed to deserialize files for session [%s] %pe\n",
+					session->name, ERR_PTR(err));
+				return err;
+			}
 		}
 	}
 
-	kho_restore_free(sh->header_ser);
-	sh->header_ser = NULL;
-	sh->ser = NULL;
+	luo_session_destroy_ser_blocks(sh, false);
 
 	return 0;
 }
@@ -580,31 +675,51 @@ int luo_session_deserialize(void)
 int luo_session_serialize(void)
 {
 	struct luo_session_header *sh = &luo_session_global.outgoing;
+	struct luo_session_block *block;
 	struct luo_session *session;
+	struct luo_session_ser *ser;
 	int i = 0;
 	int err;
 
 	guard(rwsem_write)(&sh->rwsem);
+
+	if (list_empty(&sh->blocks))
+		return 0;
+
+	block = list_first_entry(&sh->blocks, struct luo_session_block, list);
+	ser = (void *)(block->ser + 1);
+
 	list_for_each_entry(session, &sh->list, list) {
-		err = luo_session_freeze_one(session, &sh->ser[i]);
+		if (i == LUO_SESSION_BLOCK_MAX) {
+			block->ser->count = i;
+			block = list_next_entry(block, list);
+			ser = (void *)(block->ser + 1);
+			i = 0;
+		}
+
+		err = luo_session_freeze_one(session, &ser[i]);
 		if (err)
 			goto err_undo;
 
-		strscpy(sh->ser[i].name, session->name,
-			sizeof(sh->ser[i].name));
+		strscpy(ser[i].name, session->name,
+			sizeof(ser[i].name));
 		i++;
 	}
-	sh->header_ser->count = sh->count;
+	block->ser->count = i;
 
 	return 0;
 
 err_undo:
 	list_for_each_entry_continue_reverse(session, &sh->list, list) {
 		i--;
-		luo_session_unfreeze_one(session, &sh->ser[i]);
-		memset(sh->ser[i].name, 0, sizeof(sh->ser[i].name));
+		if (i < 0) {
+			block = list_prev_entry(block, list);
+			ser = (void *)(block->ser + 1);
+			i = LUO_SESSION_BLOCK_MAX - 1;
+		}
+		luo_session_unfreeze_one(session, &ser[i]);
+		memset(ser[i].name, 0, sizeof(ser[i].name));
 	}
 
 	return err;
 }
-
-- 
2.43.0


