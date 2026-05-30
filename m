Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 914D8CD6E52
	for <kexec@archiver.kernel.org>; Sat, 30 May 2026 22:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9ZjBjxh8DW5cjLIflwRa7qLckFdwcn3zUMIzIhrdvTY=; b=DW6V4OQtoUpJsbVnyJa/EguUhY
	gD08rkeEKRjdnitOIW05UtvKYt+KxGL/Y2YfaHHrP9lXqTM+zdK7lYa379udWPBpHNLrWhqLta0Lx
	XVBp5F8aQo9waXl8QRp5Uxi7sEtdSjuJJZKnLJ96AfqdwaoT93O8Xak36MywriWoqmDKw0TXcCC3c
	PA6lpdnnsJ7OgeJcgwK38daRT+z/QbINSJckt42CcUsByV25CVk5HNkoO5ztA+R7SQg+duVXZkCk6
	vM6UtZ/bRLYrE5wGN/fAG7eLikTcK2pZNXpnt6KHiSrXR+LFt8FbkM5ZiH5iOOCoftRFertkU6ANl
	Z/tI6cPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTS2C-000000095sb-3GIa;
	Sat, 30 May 2026 22:20:00 +0000
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTS2A-000000095pP-1gYL
	for kexec@lists.infradead.org;
	Sat, 30 May 2026 22:19:59 +0000
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-91550c6ea8eso26956985a.0
        for <kexec@lists.infradead.org>; Sat, 30 May 2026 15:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780179597; x=1780784397; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ZjBjxh8DW5cjLIflwRa7qLckFdwcn3zUMIzIhrdvTY=;
        b=Dw5FiGbEYri2JAJYe4rxPPeCjEC+PPx+HFwHBA2yCwLwy2dNcX/AuM+ofIWs+3H+/1
         +UZtLQlsT7mC0gozQUxGavCyP0o9zGGnVZmT/JVrJKx29q/hwxLapnrMcEw2tqQHgxlL
         RR6kONEL1sbRNm85BiCBiEXG1ihg7kMN6eJn1RsQboIhwB1rnuqeucCVEERtG/59Oa+d
         h5tc8nTDMKZgcUP5kBEgAVhdV68ZDx5lpBD71lijs4XMmBIJkQZu4QmHFc1P9Cs9bSxF
         camDDb3bQpqJgJq+3BUx44eptX9afEzm6sDOeBriutAZYRwyxOdyRb/i09CkiA+jiNhX
         PjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780179597; x=1780784397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9ZjBjxh8DW5cjLIflwRa7qLckFdwcn3zUMIzIhrdvTY=;
        b=dqFE/7bAaT2ciL59MBCkkW+tSMeal3AFBW/7sRQHWFBZAovr0pZMTDeRAfIIjGV4CL
         vWHSknryTMvr8zRELgTonqDMs3a6RjVK6ObviSFaixfZg1JKWtJnKsaiOFJ/6kT0fwAI
         eqo24vJ+farqBldc8VD+/1UkrQ3qQFMr2DIK87m6B+i5S5c10D/VHPNytxVg6vEYO4qo
         36T+CQtZLDLNEp+RD2oiOCgCtWiTsv8WF3E8YcEZvBNz55gXWz3GZAZpFfCXEHeiYC5Z
         iEfSKvc2v0SF7GwjTrr+ZUFwa9aw383qnRGjcuet8MtfPRBF7bjMutXuNfhjVReRge9h
         RCzQ==
X-Forwarded-Encrypted: i=1; AFNElJ+p2p9inkJ3bOp/75kcSaQ57u9oljV+fhBGmzdvvRGJRpZKA6GGDYAHI2r3/gRfTaB5NiFjjg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyioLLsthbs9Bmh/ISk0gc3g+d7BWN4hSz+kCAjdmp0SeHObsSb
	gC2mOFOY2qp6LMPTtCUAxnObtOfk+6YVKRaiNt+JcBayFdL1Qy3JHRX486NZ/2VG6Ko=
X-Gm-Gg: Acq92OGersq3pgPcW1p1zFVRyxHGKsi60kbhw+s6fGkRp/YsiMrkvxAgT2QJCXCPdJv
	dssQ07MkJHx0e8/kzPP4SCEPDhawbhbZFpZuRH702LnCA86/4mr0pTl6HAd4FL119A1Pw0D37zr
	vBwE265t80QB0PopIZfdqt1WHVCFduOI80Sd9G/A/XHZw5zwNZ3vSC4f5REdIxK3mjeZ9h1fYPx
	4/3f38ZiIsfeAM1LzgarmJr1+dxwItsBNPc4yGF/li93S80VV5+km6U8LqMlc8czQ8Zo2Gh6Olq
	LIbWbEF4tgPkEISJa16ggu4ufCiSRMiIl5wr6HNABPqUp8gfU6xuYrtErC7rHg7HCFsokvxgoOu
	C673XBbThN6hRVzsSiQpWpih9DocpUHXiEMcB9feNyxL00ruqOzfPwhTHzbPBhyhSAIGpodsYOu
	0Qa+MVl3HWthLuBKT6/RyW1W9FwnaQkJWcUnpwvUSxclTQyTefGn3potxGtljuoi8g0YQL+0V+
X-Received: by 2002:a05:620a:a409:20b0:915:4256:9219 with SMTP id af79cd13be357-915425692c1mr413523785a.36.1780179597003;
        Sat, 30 May 2026 15:19:57 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-915324868a0sm651790085a.18.2026.05.30.15.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 15:19:55 -0700 (PDT)
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
Subject: [PATCH v4 07/13] kho: add support for linked-block serialization
Date: Sat, 30 May 2026 22:19:32 +0000
Message-ID: <20260530221938.115978-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530221938.115978-1-pasha.tatashin@soleen.com>
References: <20260530221938.115978-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260530_151958_515993_644CD30E 
X-CRM114-Status: GOOD (  33.00  )
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

Introduce a linked-block serialization mechanism for state handover.

Previously, LUO used contiguous memory blocks for serializing sessions
and files, which imposed limits on the total number of items that could
be preserved across a live update.

This commit adds the infrastructure for a more flexible, block-based
approach where serialized data is stored in a chain of linked blocks.
This is a generic KHO serialization block infrastructure that can be
used by multiple subsystems.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 Documentation/core-api/kho/abi.rst   |   5 +
 Documentation/core-api/kho/index.rst |  11 +
 MAINTAINERS                          |   1 +
 include/linux/kho/abi/block.h        |  56 ++++
 include/linux/kho_block.h            |  79 ++++++
 kernel/liveupdate/Makefile           |   1 +
 kernel/liveupdate/kho_block.c        | 384 +++++++++++++++++++++++++++
 7 files changed, 537 insertions(+)
 create mode 100644 include/linux/kho/abi/block.h
 create mode 100644 include/linux/kho_block.h
 create mode 100644 kernel/liveupdate/kho_block.c

diff --git a/Documentation/core-api/kho/abi.rst b/Documentation/core-api/kho/abi.rst
index 799d743105a6..edeb5b311963 100644
--- a/Documentation/core-api/kho/abi.rst
+++ b/Documentation/core-api/kho/abi.rst
@@ -28,6 +28,11 @@ KHO persistent memory tracker ABI
 .. kernel-doc:: include/linux/kho/abi/kexec_handover.h
   :doc: KHO persistent memory tracker
 
+KHO serialization block ABI
+===========================
+
+.. kernel-doc:: include/linux/kho/abi/block.h
+
 See Also
 ========
 
diff --git a/Documentation/core-api/kho/index.rst b/Documentation/core-api/kho/index.rst
index 0a2dee4f8e7d..320914a42178 100644
--- a/Documentation/core-api/kho/index.rst
+++ b/Documentation/core-api/kho/index.rst
@@ -83,6 +83,17 @@ Public API
 .. kernel-doc:: kernel/liveupdate/kexec_handover.c
   :export:
 
+KHO Serialization Blocks API
+============================
+
+.. kernel-doc:: kernel/liveupdate/kho_block.c
+  :doc: KHO Serialization Blocks
+
+.. kernel-doc:: include/linux/kho_block.h
+
+.. kernel-doc:: kernel/liveupdate/kho_block.c
+  :internal:
+
 See Also
 ========
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 2fb1c75afd16..fd119b343e99 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14194,6 +14194,7 @@ F:	Documentation/admin-guide/mm/kho.rst
 F:	Documentation/core-api/kho/*
 F:	include/linux/kexec_handover.h
 F:	include/linux/kho/
+F:	include/linux/kho_block.h
 F:	kernel/liveupdate/kexec_handover*
 F:	lib/test_kho.c
 F:	tools/testing/selftests/kho/
diff --git a/include/linux/kho/abi/block.h b/include/linux/kho/abi/block.h
new file mode 100644
index 000000000000..8641c20b379b
--- /dev/null
+++ b/include/linux/kho/abi/block.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+/**
+ * DOC: KHO Serialization Blocks ABI
+ *
+ * Subsystems using the KHO Serialization Blocks framework rely on the stable
+ * Application Binary Interface defined below to pass serialized state from a
+ * pre-update kernel to a post-update kernel.
+ *
+ * This interface is a contract. Any modification to the structure fields,
+ * compatible strings, or the layout of the `__packed` serialization
+ * structures defined here constitutes a breaking change. Such changes require
+ * incrementing the version number in the `KHO_BLOCK_ABI_COMPATIBLE` string to
+ * prevent a new kernel from misinterpreting data from an old kernel.
+ *
+ * Changes are allowed provided the compatibility version is incremented;
+ * however, backward/forward compatibility is only guaranteed for kernels
+ * supporting the same ABI version.
+ */
+
+#ifndef _LINUX_KHO_ABI_BLOCK_H
+#define _LINUX_KHO_ABI_BLOCK_H
+
+#include <asm/page.h>
+#include <linux/types.h>
+
+#define KHO_BLOCK_ABI_COMPATIBLE	"kho-block-v1"
+
+/**
+ * KHO_BLOCK_SIZE - The size of each serialization block.
+ *
+ * This is defined as PAGE_SIZE. PAGE_SIZE is ABI compliant because live
+ * update between kernels with different page sizes is not supported by KHO.
+ */
+#define KHO_BLOCK_SIZE			PAGE_SIZE
+
+/**
+ * struct kho_block_header_ser - Header for the serialized data block.
+ * @next:  Physical address of the next struct kho_block_header_ser.
+ * @count: The number of entries that immediately follow this header in the
+ *         memory block.
+ *
+ * This structure is located at the beginning of a block of physical memory
+ * preserved across a kexec. It provides the necessary metadata to interpret
+ * the array of entries that follow.
+ */
+struct kho_block_header_ser {
+	u64 next;
+	u64 count;
+} __packed;
+
+#endif /* _LINUX_KHO_ABI_BLOCK_H */
diff --git a/include/linux/kho_block.h b/include/linux/kho_block.h
new file mode 100644
index 000000000000..5e6b87b1befa
--- /dev/null
+++ b/include/linux/kho_block.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2026, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+#ifndef _LINUX_KHO_BLOCK_H
+#define _LINUX_KHO_BLOCK_H
+
+#include <linux/list.h>
+#include <linux/types.h>
+#include <linux/kho/abi/block.h>
+
+/**
+ * struct kho_block - Internal representation of a serialization block.
+ * @list: List head for linking blocks in memory.
+ * @ser:  Pointer to the serialized header in preserved memory.
+ */
+struct kho_block {
+	struct list_head list;
+	struct kho_block_header_ser *ser;
+};
+
+/**
+ * struct kho_block_set - A set of blocks that belong to the same object.
+ * @blocks:          The list of serialization blocks (struct kho_block).
+ * @nblocks:         The number of allocated serialization blocks.
+ * @head_pa:         Physical address of the first block header.
+ * @entry_size:      The size of each entry in the blocks.
+ * @count_per_block: The maximum number of entries each block can hold.
+ * @incoming:        True if this block set was restored from the previous kernel.
+ */
+struct kho_block_set {
+	struct list_head blocks;
+	long nblocks;
+	u64 head_pa;
+	size_t entry_size;
+	u64 count_per_block;
+	bool incoming;
+};
+
+/**
+ * struct kho_block_it - Iterator for serializing entries into blocks.
+ * @bs:         The block set being iterated.
+ * @block:      The current block.
+ * @i:          The current entry index within @block.
+ */
+struct kho_block_it {
+	struct kho_block_set *bs;
+	struct kho_block *block;
+	u64 i;
+};
+
+/**
+ * KHO_BLOCK_SET_INIT - Initialize a static kho_block_set.
+ * @_name:       Name of the kho_block_set variable.
+ * @_entry_size: The size of each entry in the block set.
+ */
+#define KHO_BLOCK_SET_INIT(_name, _entry_size) {                        \
+	.blocks = LIST_HEAD_INIT((_name).blocks),                       \
+	.entry_size = _entry_size,                                      \
+}
+
+void kho_block_set_init(struct kho_block_set *bs, size_t entry_size);
+
+int kho_block_grow(struct kho_block_set *bs, u64 count);
+void kho_block_shrink(struct kho_block_set *bs, u64 count);
+
+int kho_block_restore(struct kho_block_set *bs, u64 head_pa);
+void kho_block_destroy(struct kho_block_set *bs);
+void kho_block_set_clear(struct kho_block_set *bs);
+
+void kho_block_it_init(struct kho_block_it *it, struct kho_block_set *bs);
+void *kho_block_it_next(struct kho_block_it *it);
+void *kho_block_it_read(struct kho_block_it *it);
+void *kho_block_it_prev(struct kho_block_it *it);
+void kho_block_it_finalize(struct kho_block_it *it);
+
+#endif /* _LINUX_KHO_BLOCK_H */
diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
index d2f779cbe279..eec9d3ae07eb 100644
--- a/kernel/liveupdate/Makefile
+++ b/kernel/liveupdate/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 luo-y :=								\
+		kho_block.o						\
 		luo_core.o						\
 		luo_file.o						\
 		luo_flb.o						\
diff --git a/kernel/liveupdate/kho_block.c b/kernel/liveupdate/kho_block.c
new file mode 100644
index 000000000000..a4e650af946f
--- /dev/null
+++ b/kernel/liveupdate/kho_block.c
@@ -0,0 +1,384 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2026, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ */
+
+/**
+ * DOC: KHO Serialization Blocks
+ *
+ * KHO provides a mechanism to preserve stateful data across a kexec handover
+ * by serializing it into memory blocks. This file provides the common
+ * infrastructure for managing these blocks.
+ *
+ * Each block consists of a header (struct kho_block_header_ser) followed by an
+ * array of serialized entries. Multiple blocks are linked together via a
+ * physical pointer in the header, forming a linked list that can be easily
+ * traversed in both the current and the next kernel.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/io.h>
+#include <linux/kexec_handover.h>
+#include <linux/kho/abi/block.h>
+#include <linux/kho_block.h>
+#include <linux/slab.h>
+
+/*
+ * Safeguard limit for the number of serialization blocks. This is used to
+ * prevent infinite loops and excessive memory allocation in case of memory
+ * corruption in the preserved state.
+ */
+#define KHO_MAX_BLOCKS 10000
+
+/**
+ * kho_block_set_init - Initialize a block set.
+ * @bs:         The block set to initialize.
+ * @entry_size: The size of each entry in the blocks.
+ */
+void kho_block_set_init(struct kho_block_set *bs, size_t entry_size)
+{
+	*bs = (struct kho_block_set)KHO_BLOCK_SET_INIT(*bs, entry_size);
+}
+
+static inline u64 kho_block_count_per_block(struct kho_block_set *bs)
+{
+	if (unlikely(!bs->count_per_block)) {
+		bs->count_per_block = (KHO_BLOCK_SIZE -
+				       sizeof(struct kho_block_header_ser)) /
+				      bs->entry_size;
+		WARN_ON(!bs->count_per_block);
+	}
+	return bs->count_per_block;
+}
+
+/* Free serialized data */
+static void kho_block_free_ser(struct kho_block_set *bs,
+			       struct kho_block_header_ser *ser)
+{
+	if (bs->incoming)
+		kho_restore_free(ser);
+	else
+		kho_unpreserve_free(ser);
+}
+
+static struct kho_block_header_ser *kho_block_alloc_ser(struct kho_block_set *bs)
+{
+	WARN_ON(bs->incoming);
+	return kho_alloc_preserve(KHO_BLOCK_SIZE);
+}
+
+static int kho_block_add(struct kho_block_set *bs,
+			 struct kho_block_header_ser *ser)
+{
+	struct kho_block *block, *last;
+
+	if (bs->nblocks >= KHO_MAX_BLOCKS)
+		return -ENOSPC;
+
+	block = kzalloc_obj(*block);
+	if (!block)
+		return -ENOMEM;
+
+	block->ser = ser;
+	last = list_last_entry_or_null(&bs->blocks, struct kho_block, list);
+	list_add_tail(&block->list, &bs->blocks);
+	bs->nblocks++;
+
+	if (last)
+		last->ser->next = virt_to_phys(ser);
+	else
+		bs->head_pa = virt_to_phys(ser);
+
+	return 0;
+}
+
+/**
+ * kho_block_grow - Create a new block if the current capacity is reached.
+ * @bs:    The block set.
+ * @count: The current number of entries.
+ *
+ * This function handles the dynamic expansion of a block set. It allocates
+ * and links a new serialization block if the provided entry count matches
+ * the current total capacity of the set.
+ *
+ * Return: 0 on success, or a negative errno on failure.
+ */
+int kho_block_grow(struct kho_block_set *bs, u64 count)
+{
+	struct kho_block_header_ser *ser;
+	int err;
+
+	if (WARN_ON(bs->incoming))
+		return -EINVAL;
+
+	if (count != bs->nblocks * kho_block_count_per_block(bs))
+		return 0;
+
+	ser = kho_block_alloc_ser(bs);
+	if (IS_ERR(ser))
+		return PTR_ERR(ser);
+
+	err = kho_block_add(bs, ser);
+	if (err) {
+		kho_block_free_ser(bs, ser);
+		return err;
+	}
+
+	return 0;
+}
+
+/**
+ * kho_block_shrink - Conditionally destroy the last block in a block set.
+ * @bs:              The block set.
+ * @count:           The current number of entries across all blocks.
+ *
+ * This function checks if the last block in the set is redundant based on the
+ * total entry count and the capacity of the preceding blocks. If the entry
+ * count can be accommodated by the blocks that come before the last one, the
+ * last block is destroyed and removed from the set.
+ */
+void kho_block_shrink(struct kho_block_set *bs, u64 count)
+{
+	struct kho_block *last, *new_last;
+
+	if (count > (bs->nblocks - 1) * kho_block_count_per_block(bs))
+		return;
+
+	if (list_empty(&bs->blocks))
+		return;
+
+	last = list_last_entry(&bs->blocks, struct kho_block, list);
+	list_del(&last->list);
+	bs->nblocks--;
+	kho_block_free_ser(bs, last->ser);
+	kfree(last);
+
+	new_last = list_last_entry_or_null(&bs->blocks, struct kho_block, list);
+	if (new_last)
+		new_last->ser->next = 0;
+	else
+		bs->head_pa = 0;
+}
+
+/*
+ * kho_cyclic_blocks_check - Check for cycles in a linked list of blocks.
+ * Uses Floyd's cycle-finding algorithm to ensure sanity of the incoming list.
+ */
+static bool kho_cyclic_blocks_check(struct kho_block_set *bs)
+{
+	struct kho_block_header_ser *fast;
+	struct kho_block_header_ser *slow;
+	int count = 0;
+
+	fast = phys_to_virt(bs->head_pa);
+	slow = fast;
+
+	while (fast) {
+		if (count++ >= KHO_MAX_BLOCKS) {
+			pr_err("Linked list too long\n");
+			return false;
+		}
+
+		if (!fast->next)
+			break;
+
+		fast = phys_to_virt(fast->next);
+		if (!fast->next)
+			break;
+
+		fast = phys_to_virt(fast->next);
+		slow = phys_to_virt(slow->next);
+
+		if (slow == fast) {
+			pr_err("Cyclic list detected\n");
+			return false;
+		}
+	}
+
+	return true;
+}
+
+/**
+ * kho_block_restore - Restore a block set from a physical address.
+ * @bs:      The block set to restore.
+ * @head_pa: Physical address of the first block header.
+ *
+ * Return: 0 on success, or a negative errno on failure.
+ */
+int kho_block_restore(struct kho_block_set *bs, u64 head_pa)
+{
+	struct kho_block_header_ser *ser;
+	u64 next_pa = head_pa;
+	int err;
+
+	/* Restored block sets use size from the previous kernel */
+	bs->incoming = true;
+	if (!head_pa)
+		return 0;
+
+	bs->head_pa = head_pa;
+	if (!kho_cyclic_blocks_check(bs)) {
+		bs->head_pa = 0;
+		return -EINVAL;
+	}
+
+	while (next_pa) {
+		ser = phys_to_virt(next_pa);
+		if (ser->count > kho_block_count_per_block(bs)) {
+			pr_warn("Block contains too many entries: %llu\n",
+				ser->count);
+			err = -EINVAL;
+			goto err_destroy;
+		}
+		err = kho_block_add(bs, ser);
+		if (err)
+			goto err_destroy;
+		next_pa = ser->next;
+	}
+
+	return 0;
+
+err_destroy:
+	kho_block_destroy(bs);
+	return err;
+}
+
+/**
+ * kho_block_destroy - Destroy all blocks in a block set.
+ * @bs:          The block set.
+ */
+void kho_block_destroy(struct kho_block_set *bs)
+{
+	u64 head_pa = bs->head_pa;
+	struct kho_block *block;
+
+	while (!list_empty(&bs->blocks)) {
+		block = list_first_entry(&bs->blocks, struct kho_block, list);
+		list_del(&block->list);
+		kfree(block);
+	}
+	bs->nblocks = 0;
+	bs->head_pa = 0;
+
+	while (head_pa) {
+		struct kho_block_header_ser *ser = phys_to_virt(head_pa);
+
+		head_pa = ser->next;
+		kho_block_free_ser(bs, ser);
+	}
+}
+
+/**
+ * kho_block_set_clear - Clear all serialized data in a block set.
+ * @bs: The block set to clear.
+ */
+void kho_block_set_clear(struct kho_block_set *bs)
+{
+	struct kho_block *block;
+
+	list_for_each_entry(block, &bs->blocks, list) {
+		block->ser->count = 0;
+		memset(block->ser + 1, 0, KHO_BLOCK_SIZE - sizeof(*block->ser));
+	}
+}
+
+/**
+ * kho_block_it_init - Initialize a block set iterator.
+ * @it:         The iterator to initialize.
+ * @bs:         The block set to iterate over.
+ */
+void kho_block_it_init(struct kho_block_it *it, struct kho_block_set *bs)
+{
+	it->bs = bs;
+	it->block = list_first_entry_or_null(&bs->blocks, struct kho_block, list);
+	it->i = 0;
+}
+
+/**
+ * kho_block_it_next - Return the next entry slot in the block set.
+ * @it: The block iterator.
+ *
+ * If the current block is full, it automatically advances to the next block
+ * in the set.
+ *
+ * Return: A pointer to the next entry slot, or NULL if no more slots are
+ * available.
+ */
+void *kho_block_it_next(struct kho_block_it *it)
+{
+	if (!it->block)
+		return NULL;
+
+	if (it->i == kho_block_count_per_block(it->bs)) {
+		it->block->ser->count = it->i;
+		if (list_is_last(&it->block->list, &it->bs->blocks))
+			return NULL;
+		it->block = list_next_entry(it->block, list);
+		it->i = 0;
+	}
+
+	return (void *)(it->block->ser + 1) + (it->i++ * it->bs->entry_size);
+}
+
+/**
+ * kho_block_it_read - Return the next entry slot for reading.
+ * @it: The block iterator.
+ *
+ * This function iterates through entries that were previously serialized,
+ * respecting the count stored in each block's header.
+ *
+ * Return: A pointer to the next entry slot, or NULL if no more entries are
+ * available.
+ */
+void *kho_block_it_read(struct kho_block_it *it)
+{
+	if (!it->block)
+		return NULL;
+
+	while (it->i == it->block->ser->count) {
+		if (list_is_last(&it->block->list, &it->bs->blocks))
+			return NULL;
+		it->block = list_next_entry(it->block, list);
+		it->i = 0;
+	}
+
+	return (void *)(it->block->ser + 1) + (it->i++ * it->bs->entry_size);
+}
+
+/**
+ * kho_block_it_prev - Return the previous entry slot in the block set.
+ * @it: The block iterator.
+ *
+ * If the current index is at the start of a block, it automatically moves to
+ * the end of the previous block.
+ *
+ * Return: A pointer to the previous entry slot, or NULL if at the very
+ * beginning of the block set.
+ */
+void *kho_block_it_prev(struct kho_block_it *it)
+{
+	if (!it->block)
+		return NULL;
+
+	if (it->i == 0) {
+		if (list_is_first(&it->block->list, &it->bs->blocks))
+			return NULL;
+		it->block = list_prev_entry(it->block, list);
+		it->i = kho_block_count_per_block(it->bs);
+	}
+
+	return (void *)(it->block->ser + 1) + (--it->i * it->bs->entry_size);
+}
+
+/**
+ * kho_block_it_finalize - Finalize the current block by setting its entry count.
+ * @it: The block iterator.
+ */
+void kho_block_it_finalize(struct kho_block_it *it)
+{
+	if (it->block)
+		it->block->ser->count = it->i;
+}
-- 
2.53.0


