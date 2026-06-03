Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E26ECD6E70
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 03:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/+goXyLuH/FqZHKbCrnKG3Jp0DPoER679XEYr9/CPoc=; b=Ws+afki3F9iT4As/9lkRlX3O7A
	/lU6f5luPz3IIZGMQDBP6pit0XS59mzXt14h/uzsfnmYAksZN/W7FOdbvzuvhOJjrL5YhMqvFuPGO
	OznyP2pX5Nc5wBwPHkbuxbOLbWlSK0mgxat5x7n64Lc5p045IY1jIo8UOHDCpVkT1hLS8HDQaKYzW
	BaIGGmvTemHNexapHEiArt9xntcExfsLOXADUN72bIWhLxMv+deBCjGmE6WVzLXXttWJI1nfR+UbU
	8ZD3nKj4zvzPOEQqdfE4mkhSy+XN0Cj1Upb0IpgrpZoMk4AcVHAkrDg/Q3VbpP/VkkXQt5+CsP7WP
	0/pV5LAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUcIC-0000000EB0O-2Ph9;
	Wed, 03 Jun 2026 03:29:20 +0000
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUcIA-0000000EAxV-1N0N
	for kexec@lists.infradead.org;
	Wed, 03 Jun 2026 03:29:19 +0000
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-8cceb2ecc03so33459616d6.3
        for <kexec@lists.infradead.org>; Tue, 02 Jun 2026 20:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780457357; x=1781062157; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/+goXyLuH/FqZHKbCrnKG3Jp0DPoER679XEYr9/CPoc=;
        b=j3sr0StPZIjpEzvuz1fVI5ePcpWldKwCGEQcWhi9sDhoNPo5Fs3xOL7kf2jjicZ4Zv
         hj1uBCrDaTa7OPnlZU2f2xlW83gbIEpxbt3dXwLhX2Z0F41HK5zJwg4BCx4+TfJPR/K/
         3F1HFiiJS+NBGDJe0DmszSiG7Dh4uQvhFcpa/iryJzx8ZgI/VRyfAEjBXjYPC2J9Xdwq
         SeI3yolPNn1HEWb7XJlSH3wMx2zuNinUPlBCLe8ysWNzxTLAJSqnUYiJ14grfwt36KnK
         D1E7dePDPLcY+sJrG0HcqSzyjV3KeWaubLoZxcUOhYIbReJNCh+uCO2KcQZ1IFh6qdqF
         4BDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780457357; x=1781062157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/+goXyLuH/FqZHKbCrnKG3Jp0DPoER679XEYr9/CPoc=;
        b=lR7tiLEP0X5IIFK3/ONx/iWhmgZmYeYgNq2QeUZX+B4RQzE/n/jUVHnfJLaaHOlS+0
         JJCZ5u/poV0Bv0lnyRpU34rzYJjTiK4OQL7bW5mxBTiYeYg5HozN9epZvHfvKgQyYF6Y
         /5QTj5PUJDPqURcJuIss8Z9q4l0TkkXn9jJZCySEANZRMnpkmqzQqHqUXr0CEl3FUKsa
         rFWH0kHGGRuLUqwvP5uhNwmSXR1Xkdyof49tPEgotAmwz5xKeJqqklqIJja8T6T22fWU
         h8vMzt0M5W0je1Vk2mMb9QhNalqUNlCHpOe+ZlrkoGdlxcrNw2rYySdsmKegT4Uk13cD
         IR1w==
X-Forwarded-Encrypted: i=1; AFNElJ/RFaEbGIw5tH9sAXmxKIQdSY0cCZ/rX12MCNi7j73gLobdseSevhlNzFkMtPZMMMW/GH5I9A==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyzd9pl+hpeHvi8/MKQKgvO9TJFyC3rgq9NfReNEufdrRG28ZVg
	AdrbCBCZXMpuZOt5Gq93x5Phellx9CHxVENUNjXP/OeD9EsG5SgnXTHQJAAQIKqUqKE=
X-Gm-Gg: Acq92OHoSudSSwT8ca4bMbIV+6w9KYIjT9DXg8aXmseSs6YHd6SpPWrxp1xDNmn1swR
	DF9vbYWXrDLTalSpGFKfvhExxleQeDNKiVq9NrtGwAzlgWRJ5PcaIPqCAbZRHCi72ufLUz2msJq
	jtVhWkSdFtcR6j6cXTzm7QZRfR0IYnWjHRUyeY0Z84bRrlzefI9r/w1im/X4qZteLeqlBeWLIeT
	DFZ2jYDYC1WgEgOTvRngd1XgYh2ameytDFD27T/cSP4NJLQWyx7OMyP46Yd6kt69N+EOhJH0xoD
	jeGDj/lez0B244hd2+qz8Q3tsG+S8VuNL03GTp0EX/3558fp6uABDyBLxAwCjgsP8clkbYj6B4/
	QB0+8f7z4yJfkv4fxaFaSxnaZBbLBFoiJqTVhc5F0hoeKD1Ld3a6NQJiSVabhR0EZ7XDFzbM17h
	OTTKy4HtSFssadGwH1xhyscNg/2GcFNRtUTwmqHQ1go5+8y3QGXa/JJSQq4GLf6A==
X-Received: by 2002:a05:6214:5708:b0:8cc:ed49:bdd0 with SMTP id 6a1803df08f44-8cecdcd11c4mr25000596d6.22.1780457356873;
        Tue, 02 Jun 2026 20:29:16 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd26b3b9sm9244566d6.45.2026.06.02.20.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 20:29:16 -0700 (PDT)
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
Subject: [PATCH v6 07/13] kho: add support for linked-block serialization
Date: Wed,  3 Jun 2026 03:28:58 +0000
Message-ID: <20260603032905.344462-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260603032905.344462-1-pasha.tatashin@soleen.com>
References: <20260603032905.344462-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_202918_450051_1DA4E0E5 
X-CRM114-Status: GOOD (  32.51  )
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
 include/linux/kho_block.h            | 106 +++++++
 kernel/liveupdate/Makefile           |   1 +
 kernel/liveupdate/kho_block.c        | 411 +++++++++++++++++++++++++++
 7 files changed, 591 insertions(+)
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
index 9ec290e38b44..920ba7622afa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14208,6 +14208,7 @@ F:	Documentation/admin-guide/mm/kho.rst
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
index 000000000000..93a7cc2be5f5
--- /dev/null
+++ b/include/linux/kho_block.h
@@ -0,0 +1,106 @@
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
+ * struct kho_block_set - A set of blocks containing serialized entries of the same type.
+ * @blocks:          The list of serialization blocks (struct kho_block).
+ * @nblocks:         The number of allocated serialization blocks.
+ * @head_pa:         Physical address of the first block header.
+ * @entry_size:      The size of each entry in the blocks.
+ * @count_per_block: The maximum number of entries each block can hold.
+ * @incoming:        True if this block set was restored from the previous kernel.
+ *
+ * Note: Synchronization and locking are the responsibility of the caller.
+ * The block set structure itself is not internally synchronized.
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
+ * struct kho_block_set_it - Iterator for serializing entries into blocks.
+ * @bs:         The block set being iterated.
+ * @block:      The current block.
+ * @i:          The current entry index within @block.
+ */
+struct kho_block_set_it {
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
+#define KHO_BLOCK_SET_INIT(_name, _entry_size) {			\
+	.blocks = LIST_HEAD_INIT((_name).blocks),			\
+	.entry_size = _entry_size,					\
+	.count_per_block = (KHO_BLOCK_SIZE -				\
+			    sizeof(struct kho_block_header_ser)) /	\
+			   (_entry_size),				\
+}
+
+void kho_block_set_init(struct kho_block_set *bs, size_t entry_size);
+
+int kho_block_set_grow(struct kho_block_set *bs, u64 count);
+void kho_block_set_shrink(struct kho_block_set *bs, u64 count);
+
+int kho_block_set_restore(struct kho_block_set *bs, u64 head_pa);
+void kho_block_set_destroy(struct kho_block_set *bs);
+void kho_block_set_clear(struct kho_block_set *bs);
+
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
+void kho_block_set_it_init(struct kho_block_set_it *it, struct kho_block_set *bs);
+void *kho_block_set_it_reserve_entry(struct kho_block_set_it *it);
+void *kho_block_set_it_read_entry(struct kho_block_set_it *it);
+void *kho_block_set_it_prev(struct kho_block_set_it *it);
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
index 000000000000..4f147c308e6b
--- /dev/null
+++ b/kernel/liveupdate/kho_block.c
@@ -0,0 +1,411 @@
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
+ * by serializing it into memory blocks, and provides the common
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
+ *
+ * With a 4KB page size, 10k blocks is about 40MB. For 32-byte entries
+ * (e.g. 4 u64s), each block holds up to 127 entries (accounting for the
+ * 16-byte header), allowing the block set to hold up to 1.27M entries.
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
+	WARN_ON_ONCE(!bs->count_per_block);
+}
+
+/* Serialized entries start immediately after the block header */
+static void *kho_block_entries(struct kho_block *block)
+{
+	return (void *)(block->ser + 1);
+}
+
+/* Get the address of the serialized entry at the specified index */
+static void *kho_block_entry(struct kho_block_set_it *it, u64 index)
+{
+	return kho_block_entries(it->block) + (index * it->bs->entry_size);
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
+	WARN_ON_ONCE(bs->incoming);
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
+static int kho_block_set_grow_one(struct kho_block_set *bs)
+{
+	struct kho_block_header_ser *ser;
+	int err;
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
+ * kho_block_set_grow - Expand the block set to accommodate the target count.
+ * @bs:    The block set.
+ * @count: The target number of valid entries to accommodate.
+ *
+ * Acts as a runtime notifier when new resources (such as files or sessions)
+ * are registered. Dynamically preallocates and links preserved memory blocks
+ * if the target entry count exceeds the current total capacity of the set,
+ * ensuring they are available during serialization/deserialization.
+ *
+ * Context: Caller must hold a lock protecting the block set.
+ * Return: 0 on success, or a negative errno on failure.
+ */
+int kho_block_set_grow(struct kho_block_set *bs, u64 count)
+{
+	if (WARN_ON_ONCE(bs->incoming))
+		return -EINVAL;
+
+	while (count > bs->nblocks * bs->count_per_block) {
+		int err = kho_block_set_grow_one(bs);
+
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static void kho_block_set_shrink_one(struct kho_block_set *bs)
+{
+	struct kho_block *last, *new_last;
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
+/**
+ * kho_block_set_shrink - Shrink the block set to accommodate the target count.
+ * @bs:              The block set.
+ * @count:           The target number of valid entries to accommodate.
+ *
+ * Acts as a runtime notifier when resources (such as files or sessions) are
+ * unregistered, allowing the block set to release and unallocate redundant
+ * preserved memory blocks. Checks if the last block in the set can be removed
+ * because the remaining entry count is fully accommodated by the preceding blocks.
+ *
+ * Note: It is the caller's responsibility to ensure that entries are removed
+ * in LIFO (last-in, first-out) order (the reverse order of their insertion).
+ * Because shrinking destroys the last block in the set, removing entries in
+ * any other order would corrupt active data.
+ *
+ * Context: Caller must hold a lock protecting the block set.
+ */
+void kho_block_set_shrink(struct kho_block_set *bs, u64 count)
+{
+	while (bs->nblocks > 0 && count <= (bs->nblocks - 1) * bs->count_per_block)
+		kho_block_set_shrink_one(bs);
+}
+
+/*
+ * kho_block_set_is_cyclic - Check for cycles in a linked list of blocks.
+ * Uses Floyd's cycle-finding algorithm to ensure sanity of the incoming list.
+ *
+ * Return: true if a cycle or corruption is detected, false otherwise.
+ */
+static bool kho_block_set_is_cyclic(struct kho_block_set *bs)
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
+			pr_err("Block set is corrupted\n");
+			return true;
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
+			pr_err("Block set is corrupted\n");
+			return true;
+		}
+	}
+
+	return false;
+}
+
+/**
+ * kho_block_set_restore - Restore a block set from a physical address.
+ * @bs:      The block set to restore.
+ * @head_pa: Physical address of the first block header.
+ *
+ * Restores a serialized block set from a given physical address. The caller is
+ * responsible for ensuring that the block set @bs has been allocated and
+ * initialized prior to calling this function.
+ *
+ * Return: 0 on success, or a negative errno on failure.
+ */
+int kho_block_set_restore(struct kho_block_set *bs, u64 head_pa)
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
+	if (kho_block_set_is_cyclic(bs)) {
+		bs->head_pa = 0;
+		return -EINVAL;
+	}
+
+	while (next_pa) {
+		ser = phys_to_virt(next_pa);
+		if (!ser->count || ser->count > bs->count_per_block) {
+			pr_warn("Block contains invalid entry count: %llu\n",
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
+	kho_block_set_destroy(bs);
+
+	/* Free the remaining un-restored blocks in the physical chain */
+	while (next_pa) {
+		struct kho_block_header_ser *next_ser = phys_to_virt(next_pa);
+
+		next_pa = next_ser->next;
+		kho_block_free_ser(bs, next_ser);
+	}
+	return err;
+}
+
+/**
+ * kho_block_set_destroy - Destroy all blocks in a block set.
+ * @bs:          The block set.
+ */
+void kho_block_set_destroy(struct kho_block_set *bs)
+{
+	struct kho_block *block, *tmp;
+
+	list_for_each_entry_safe(block, tmp, &bs->blocks, list) {
+		list_del(&block->list);
+		kho_block_free_ser(bs, block->ser);
+		kfree(block);
+	}
+	bs->nblocks = 0;
+	bs->head_pa = 0;
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
+ * kho_block_set_it_init - Initialize a block set iterator.
+ * @it:         The iterator to initialize.
+ * @bs:         The block set to iterate over.
+ */
+void kho_block_set_it_init(struct kho_block_set_it *it, struct kho_block_set *bs)
+{
+	it->bs = bs;
+	it->block = list_first_entry_or_null(&bs->blocks, struct kho_block, list);
+	it->i = 0;
+}
+
+/**
+ * kho_block_set_it_reserve_entry - Reserve and return the next available slot for writing.
+ * @it: The block iterator.
+ *
+ * Reserves a slot in the current block during state serialization to add a new
+ * entry, advancing the internal index. If the current block is full, it
+ * automatically moves to the next block in the set.
+ *
+ * Return: A pointer to the reserved entry slot, or NULL if the block set's
+ * capacity is fully exhausted.
+ */
+void *kho_block_set_it_reserve_entry(struct kho_block_set_it *it)
+{
+	void *entry;
+
+	if (!it->block)
+		return NULL;
+
+	if (it->i == it->bs->count_per_block) {
+		if (list_is_last(&it->block->list, &it->bs->blocks))
+			return NULL;
+		it->block = list_next_entry(it->block, list);
+		it->i = 0;
+	}
+
+	entry = kho_block_entry(it, it->i++);
+	it->block->ser->count = it->i;
+	return entry;
+}
+
+/**
+ * kho_block_set_it_read_entry - Read the next serialized entry from the block set.
+ * @it: The block iterator.
+ *
+ * Iterates through previously written entries during state deserialization,
+ * respecting the actual count stored in each block's header.
+ *
+ * Return: A pointer to the next serialized entry, or NULL if all serialized
+ * entries have been read.
+ */
+void *kho_block_set_it_read_entry(struct kho_block_set_it *it)
+{
+	if (!it->block)
+		return NULL;
+
+	if (it->i == it->block->ser->count) {
+		if (list_is_last(&it->block->list, &it->bs->blocks))
+			return NULL;
+		it->block = list_next_entry(it->block, list);
+		it->i = 0;
+	}
+
+	return kho_block_entry(it, it->i++);
+}
+
+/**
+ * kho_block_set_it_prev - Return the previous entry slot in the block set.
+ * @it: The block iterator.
+ *
+ * If the current index is at the start of a block, it automatically moves to
+ * the end of the previous block.
+ *
+ * Return: A pointer to the previous entry slot, or NULL if at the very
+ * beginning of the block set.
+ */
+void *kho_block_set_it_prev(struct kho_block_set_it *it)
+{
+	if (!it->block)
+		return NULL;
+
+	if (it->i == 0) {
+		if (list_is_first(&it->block->list, &it->bs->blocks))
+			return NULL;
+		it->block = list_prev_entry(it->block, list);
+		it->i = it->bs->count_per_block;
+	}
+
+	return kho_block_entry(it, --it->i);
+}
-- 
2.53.0


