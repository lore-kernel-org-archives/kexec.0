Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1600CD6E6B
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 03:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nDO8BVEQ+LamNUz1+nh7qBThLycTY6eROvRfwZKn/hY=; b=uWBsQPTkUHolMf0+6SHg0R9kIc
	Gf6g0Dt4aO+WOf0x0ymKiK3/NX87SmqFZPFzTjIazjUnPU03wUoEs+uljuy2FldT40klLfIqI72Ki
	wcRcmMcZAzmrSLL4Uivx2VIU93wLcBaeT+ut4TwKNyut8u9mDlaMo2nmdSfzMO5s7Qyo/HSN6A+Ru
	eknecu8v4Ysc2ngHeTfNRn94TYyDcRO+K9mMmn0phu7jYG18yultTJ6ssj1gPneuRJdXx+FilU0Fa
	ue7HzMoHnp22zU+CEdoxK8vBehWJNgUjvQF9PU/f0ToXdh9GdEhSm3E8+nACLiZbDt/PJenj7q7h2
	1dtedUgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVLIi-000000001wO-3mDr;
	Fri, 05 Jun 2026 03:32:52 +0000
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVLIg-000000001vd-1wNo
	for kexec@lists.infradead.org;
	Fri, 05 Jun 2026 03:32:51 +0000
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-8ccd1f57b32so13873696d6.2
        for <kexec@lists.infradead.org>; Thu, 04 Jun 2026 20:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780630369; x=1781235169; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nDO8BVEQ+LamNUz1+nh7qBThLycTY6eROvRfwZKn/hY=;
        b=LKyOg6J32cFLVwb8dygfIjlv8YTWFBBKopacWmztmw1oBZOQjBuQqljTBlFhs9fUJM
         4g5CMT2Risn7o7339/9+P+JXYJn4DvIDqpg5ceSjz74YEO3Xn301dsq2MJj+CioLLt27
         I+sn0fm+vvjpSVgfHh1UITOsvAWLgdpQghmFpCfAepoRz8UmoOAndrqPoz3GOF6bV005
         ZrfjEwgE6wfFfv2yBaZXhanQmx4aEPxC8ZJe29PseawpUhsULjD7FwGpCRmCmVFvssqo
         Yym4tzlh0urPAhP5lBUTp++78i22FKWcJCHqylSB5fYA/vX0MukVAt9rky0sRw5sk3RA
         M7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780630369; x=1781235169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nDO8BVEQ+LamNUz1+nh7qBThLycTY6eROvRfwZKn/hY=;
        b=cumvgb47lJa/3Gj2Kd4ZMIXxYiHVR+si9cPem090C4EetUT3hATNFVYNPPdboVnz+X
         QFBwij3xnDvgf/JZDePEiSxPSg41oDrQZLDdRdAAqYUTRpSFQTIEJsNOajUjYzQM3Wmy
         GNwy5+LKb8nHHA7V94JULl4lnhwt2Q3MPmpa5wvVYc9TUbs1NaPu89AIBNZ2ppOmdeNH
         6nP22XNvhF9RCLNtsu8Gj0dOJmm4+X9KqhT/MXKHkVOnIH4ulluKhjmv0KMxKGa1wJ+k
         jPy8iBwtbgITg/HgeAyVH4igQcqqKhd2ND3OytbI+Ddpl7Bnoey1PjlvlI0QnCcgdwYE
         geUQ==
X-Forwarded-Encrypted: i=1; AFNElJ8OurTH9x4lfF2Y3q1zmF8myJppSHlCqoms1LkqKks8W/l+N7xh/2ARuB3vWya7GSvwNHTeGA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx1hwxqatv6x1e3YGFV3QdIQeo/hc8/ZDzsGCwN0M8fYtY8Nz3B
	dwzqaFL1IGshtx2MtVF8ArlDNr2mSzw4YUN5Zl7EGt1v2c+zOWATLnCLpjHep4MR5gA=
X-Gm-Gg: Acq92OEeqe2DZTIwSic3aRivzsfauwbE8V1draAv9MvlhEZH2+PJGXf04/Okp8giSEq
	O0ywQZW0c3mpGIULEfFR37pAjYK4sxnT/fWoSKaeVFQGs02fyU/u3BBg8H8I7mTJyOaQrJ3pAZX
	v8zs+Mrkt1cadJgJzAZCLmNZ21J9BqCHSDDULLJt49IQauqSFbDT3EouerlWEor+Z8IDLqErh7M
	aW/aJeL3BNyVkhFo/WNUUP3S8VsqrW3huYVciWL4hvBUOewkZ/KVAIk2lj/lWvCLT7GNHJPl2CL
	A0ZmaVe/YTnRftZ0aLz54zoFHwkLlTVrzBaz0gYC4KN1+yOEobrCEcyzSm/UPKvLmRNT5/Tueng
	cqhi+30cVVKt7zsnKrqJoLKUygRWPECQ5D2TXYeahz/IF7la7cdu2gCNKaL3lSx6qt/fLVW6/pp
	BfcsRSANyWniiHwavdkdcpwhv2OXPJucOKQi+7J+OtClraFuEebqLrVYyetbj7lQ==
X-Received: by 2002:a05:6214:6017:b0:8cc:cf1e:1fde with SMTP id 6a1803df08f44-8cee611fb96mr32665706d6.26.1780630369028;
        Thu, 04 Jun 2026 20:32:49 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccdb9fc0sm70805926d6.17.2026.06.04.20.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 20:32:48 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org,
	rppt@kernel.org,
	shuah@kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	jasonmiu@google.com,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	ran.xiaokai@zte.com.cn,
	pasha.tatashin@soleen.com,
	kexec@lists.infradead.org,
	pratyush@kernel.org,
	graf@amazon.com
Subject: [RFC v1 1/9] kho: split out radix tree tracker into kho_radix.c
Date: Fri,  5 Jun 2026 03:32:27 +0000
Message-ID: <20260605033235.717351-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605033235.717351-1-pasha.tatashin@soleen.com>
References: <20260605033235.717351-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260604_203250_579335_5E043FCD 
X-CRM114-Status: GOOD (  30.93  )
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

Move the radix tree tracker implementation from the core KHO code
into its own dedicated file (kho_radix.c).

This is a pure code movement patch; no logic or functional changes are
introduced.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 Documentation/core-api/kho/index.rst |   3 +
 kernel/liveupdate/Makefile           |   6 +-
 kernel/liveupdate/kexec_handover.c   | 273 -------------------------
 kernel/liveupdate/kho_radix.c        | 290 +++++++++++++++++++++++++++
 4 files changed, 298 insertions(+), 274 deletions(-)
 create mode 100644 kernel/liveupdate/kho_radix.c

diff --git a/Documentation/core-api/kho/index.rst b/Documentation/core-api/kho/index.rst
index 320914a42178..a9892c671ec3 100644
--- a/Documentation/core-api/kho/index.rst
+++ b/Documentation/core-api/kho/index.rst
@@ -83,6 +83,9 @@ Public API
 .. kernel-doc:: kernel/liveupdate/kexec_handover.c
   :export:
 
+.. kernel-doc:: kernel/liveupdate/kho_radix.c
+  :export:
+
 KHO Serialization Blocks API
 ============================
 
diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
index eec9d3ae07eb..a3ee8a5c27a2 100644
--- a/kernel/liveupdate/Makefile
+++ b/kernel/liveupdate/Makefile
@@ -7,7 +7,11 @@ luo-y :=								\
 		luo_flb.o						\
 		luo_session.o
 
-obj-$(CONFIG_KEXEC_HANDOVER)		+= kexec_handover.o
+kho-y :=								\
+		kexec_handover.o					\
+		kho_radix.o
+
+obj-$(CONFIG_KEXEC_HANDOVER)		+= kho.o
 obj-$(CONFIG_KEXEC_HANDOVER_DEBUG)	+= kexec_handover_debug.o
 obj-$(CONFIG_KEXEC_HANDOVER_DEBUGFS)	+= kexec_handover_debugfs.o
 
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 4834a809985a..041efff7ca11 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2025 Microsoft Corporation, Mike Rapoport <rppt@kernel.org>
  * Copyright (C) 2025 Google LLC, Changyuan Lyu <changyuanl@google.com>
  * Copyright (C) 2025 Pasha Tatashin <pasha.tatashin@soleen.com>
- * Copyright (C) 2026 Google LLC, Jason Miu <jasonmiu@google.com>
  */
 
 #define pr_fmt(fmt) "KHO: " fmt
@@ -84,278 +83,6 @@ static struct kho_out kho_out = {
 	},
 };
 
-/**
- * kho_radix_encode_key - Encodes a physical address and order into a radix key.
- * @phys: The physical address of the page.
- * @order: The order of the page.
- *
- * This function combines a page's physical address and its order into a
- * single unsigned long, which is used as a key for all radix tree
- * operations.
- *
- * Return: The encoded unsigned long radix key.
- */
-static unsigned long kho_radix_encode_key(phys_addr_t phys, unsigned int order)
-{
-	/* Order bits part */
-	unsigned long h = 1UL << (KHO_ORDER_0_LOG2 - order);
-	/* Shifted physical address part */
-	unsigned long l = phys >> (PAGE_SHIFT + order);
-
-	return h | l;
-}
-
-/**
- * kho_radix_decode_key - Decodes a radix key back into a physical address and order.
- * @key: The unsigned long key to decode.
- * @order: An output parameter, a pointer to an unsigned int where the decoded
- *         page order will be stored.
- *
- * This function reverses the encoding performed by kho_radix_encode_key(),
- * extracting the original physical address and page order from a given key.
- *
- * Return: The decoded physical address.
- */
-static phys_addr_t kho_radix_decode_key(unsigned long key, unsigned int *order)
-{
-	unsigned int order_bit = fls64(key);
-	phys_addr_t phys;
-
-	/* order_bit is numbered starting at 1 from fls64 */
-	*order = KHO_ORDER_0_LOG2 - order_bit + 1;
-	/* The order is discarded by the shift */
-	phys = key << (PAGE_SHIFT + *order);
-
-	return phys;
-}
-
-static unsigned long kho_radix_get_bitmap_index(unsigned long key)
-{
-	return key % (1 << KHO_BITMAP_SIZE_LOG2);
-}
-
-static unsigned long kho_radix_get_table_index(unsigned long key,
-					       unsigned int level)
-{
-	int s;
-
-	s = ((level - 1) * KHO_TABLE_SIZE_LOG2) + KHO_BITMAP_SIZE_LOG2;
-	return (key >> s) % (1 << KHO_TABLE_SIZE_LOG2);
-}
-
-/**
- * kho_radix_add_page - Marks a page as preserved in the radix tree.
- * @tree: The KHO radix tree.
- * @pfn: The page frame number of the page to preserve.
- * @order: The order of the page.
- *
- * This function traverses the radix tree based on the key derived from @pfn
- * and @order. It sets the corresponding bit in the leaf bitmap to mark the
- * page for preservation. If intermediate nodes do not exist along the path,
- * they are allocated and added to the tree.
- *
- * Return: 0 on success, or a negative error code on failure.
- */
-int kho_radix_add_page(struct kho_radix_tree *tree,
-		       unsigned long pfn, unsigned int order)
-{
-	/* Newly allocated nodes for error cleanup */
-	struct kho_radix_node *intermediate_nodes[KHO_TREE_MAX_DEPTH] = { 0 };
-	unsigned long key = kho_radix_encode_key(PFN_PHYS(pfn), order);
-	struct kho_radix_node *anchor_node = NULL;
-	struct kho_radix_node *node = tree->root;
-	struct kho_radix_node *new_node;
-	unsigned int i, idx, anchor_idx;
-	struct kho_radix_leaf *leaf;
-	int err = 0;
-
-	if (WARN_ON_ONCE(!tree->root))
-		return -EINVAL;
-
-	might_sleep();
-
-	guard(mutex)(&tree->lock);
-
-	/* Go from high levels to low levels */
-	for (i = KHO_TREE_MAX_DEPTH - 1; i > 0; i--) {
-		idx = kho_radix_get_table_index(key, i);
-
-		if (node->table[idx]) {
-			node = phys_to_virt(node->table[idx]);
-			continue;
-		}
-
-		/* Next node is empty, create a new node for it */
-		new_node = (struct kho_radix_node *)get_zeroed_page(GFP_KERNEL);
-		if (!new_node) {
-			err = -ENOMEM;
-			goto err_free_nodes;
-		}
-
-		node->table[idx] = virt_to_phys(new_node);
-
-		/*
-		 * Capture the node where the new branch starts for cleanup
-		 * if allocation fails.
-		 */
-		if (!anchor_node) {
-			anchor_node = node;
-			anchor_idx = idx;
-		}
-		intermediate_nodes[i] = new_node;
-
-		node = new_node;
-	}
-
-	/* Handle the leaf level bitmap (level 0) */
-	idx = kho_radix_get_bitmap_index(key);
-	leaf = (struct kho_radix_leaf *)node;
-	__set_bit(idx, leaf->bitmap);
-
-	return 0;
-
-err_free_nodes:
-	for (i = KHO_TREE_MAX_DEPTH - 1; i > 0; i--) {
-		if (intermediate_nodes[i])
-			free_page((unsigned long)intermediate_nodes[i]);
-	}
-	if (anchor_node)
-		anchor_node->table[anchor_idx] = 0;
-
-	return err;
-}
-EXPORT_SYMBOL_GPL(kho_radix_add_page);
-
-/**
- * kho_radix_del_page - Removes a page's preservation status from the radix tree.
- * @tree: The KHO radix tree.
- * @pfn: The page frame number of the page to unpreserve.
- * @order: The order of the page.
- *
- * This function traverses the radix tree and clears the bit corresponding to
- * the page, effectively removing its "preserved" status. It does not free
- * the tree's intermediate nodes, even if they become empty.
- */
-void kho_radix_del_page(struct kho_radix_tree *tree, unsigned long pfn,
-			unsigned int order)
-{
-	unsigned long key = kho_radix_encode_key(PFN_PHYS(pfn), order);
-	struct kho_radix_node *node = tree->root;
-	struct kho_radix_leaf *leaf;
-	unsigned int i, idx;
-
-	if (WARN_ON_ONCE(!tree->root))
-		return;
-
-	might_sleep();
-
-	guard(mutex)(&tree->lock);
-
-	/* Go from high levels to low levels */
-	for (i = KHO_TREE_MAX_DEPTH - 1; i > 0; i--) {
-		idx = kho_radix_get_table_index(key, i);
-
-		/*
-		 * Attempting to delete a page that has not been preserved,
-		 * return with a warning.
-		 */
-		if (WARN_ON(!node->table[idx]))
-			return;
-
-		node = phys_to_virt(node->table[idx]);
-	}
-
-	/* Handle the leaf level bitmap (level 0) */
-	leaf = (struct kho_radix_leaf *)node;
-	idx = kho_radix_get_bitmap_index(key);
-	__clear_bit(idx, leaf->bitmap);
-}
-EXPORT_SYMBOL_GPL(kho_radix_del_page);
-
-static int kho_radix_walk_leaf(struct kho_radix_leaf *leaf,
-			       unsigned long key,
-			       kho_radix_tree_walk_callback_t cb)
-{
-	unsigned long *bitmap = (unsigned long *)leaf;
-	unsigned int order;
-	phys_addr_t phys;
-	unsigned int i;
-	int err;
-
-	for_each_set_bit(i, bitmap, PAGE_SIZE * BITS_PER_BYTE) {
-		phys = kho_radix_decode_key(key | i, &order);
-		err = cb(phys, order);
-		if (err)
-			return err;
-	}
-
-	return 0;
-}
-
-static int __kho_radix_walk_tree(struct kho_radix_node *root,
-				 unsigned int level, unsigned long start,
-				 kho_radix_tree_walk_callback_t cb)
-{
-	struct kho_radix_node *node;
-	struct kho_radix_leaf *leaf;
-	unsigned long key, i;
-	unsigned int shift;
-	int err;
-
-	for (i = 0; i < PAGE_SIZE / sizeof(phys_addr_t); i++) {
-		if (!root->table[i])
-			continue;
-
-		shift = ((level - 1) * KHO_TABLE_SIZE_LOG2) +
-			KHO_BITMAP_SIZE_LOG2;
-		key = start | (i << shift);
-
-		node = phys_to_virt(root->table[i]);
-
-		if (level == 1) {
-			/*
-			 * we are at level 1,
-			 * node is pointing to the level 0 bitmap.
-			 */
-			leaf = (struct kho_radix_leaf *)node;
-			err = kho_radix_walk_leaf(leaf, key, cb);
-		} else {
-			err  = __kho_radix_walk_tree(node, level - 1,
-						     key, cb);
-		}
-
-		if (err)
-			return err;
-	}
-
-	return 0;
-}
-
-/**
- * kho_radix_walk_tree - Traverses the radix tree and calls a callback for each preserved page.
- * @tree: A pointer to the KHO radix tree to walk.
- * @cb: A callback function of type kho_radix_tree_walk_callback_t that will be
- *      invoked for each preserved page found in the tree. The callback receives
- *      the physical address and order of the preserved page.
- *
- * This function walks the radix tree, searching from the specified top level
- * down to the lowest level (level 0). For each preserved page found, it invokes
- * the provided callback, passing the page's physical address and order.
- *
- * Return: 0 if the walk completed the specified tree, or the non-zero return
- *         value from the callback that stopped the walk.
- */
-int kho_radix_walk_tree(struct kho_radix_tree *tree,
-			kho_radix_tree_walk_callback_t cb)
-{
-	if (WARN_ON_ONCE(!tree->root))
-		return -EINVAL;
-
-	guard(mutex)(&tree->lock);
-
-	return __kho_radix_walk_tree(tree->root, KHO_TREE_MAX_DEPTH - 1, 0, cb);
-}
-EXPORT_SYMBOL_GPL(kho_radix_walk_tree);
 
 /* For physically contiguous 0-order pages. */
 static void kho_init_pages(struct page *page, unsigned long nr_pages)
diff --git a/kernel/liveupdate/kho_radix.c b/kernel/liveupdate/kho_radix.c
new file mode 100644
index 000000000000..c836783a1376
--- /dev/null
+++ b/kernel/liveupdate/kho_radix.c
@@ -0,0 +1,290 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * kho_radix.c - KHO radix tree tracker for preserved memory pages
+ * Copyright (C) 2025 Microsoft Corporation, Mike Rapoport <rppt@kernel.org>
+ * Copyright (C) 2025 Pasha Tatashin <pasha.tatashin@soleen.com>
+ * Copyright (C) 2026 Google LLC, Jason Miu <jasonmiu@google.com>
+ */
+
+#include <linux/errno.h>
+#include <linux/gfp.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/kho/abi/kexec_handover.h>
+#include <linux/kho_radix_tree.h>
+#include <linux/mm.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+
+/**
+ * kho_radix_encode_key - Encodes a physical address and order into a radix key.
+ * @phys: The physical address of the page.
+ * @order: The order of the page.
+ *
+ * This function combines a page's physical address and its order into a
+ * single unsigned long, which is used as a key for all radix tree
+ * operations.
+ *
+ * Return: The encoded unsigned long radix key.
+ */
+static unsigned long kho_radix_encode_key(phys_addr_t phys, unsigned int order)
+{
+	/* Order bits part */
+	unsigned long h = 1UL << (KHO_ORDER_0_LOG2 - order);
+	/* Shifted physical address part */
+	unsigned long l = phys >> (PAGE_SHIFT + order);
+
+	return h | l;
+}
+
+/**
+ * kho_radix_decode_key - Decodes a radix key back into a physical address and order.
+ * @key: The unsigned long key to decode.
+ * @order: An output parameter, a pointer to an unsigned int where the decoded
+ *         page order will be stored.
+ *
+ * This function reverses the encoding performed by kho_radix_encode_key(),
+ * extracting the original physical address and page order from a given key.
+ *
+ * Return: The decoded physical address.
+ */
+static phys_addr_t kho_radix_decode_key(unsigned long key, unsigned int *order)
+{
+	unsigned int order_bit = fls64(key);
+	phys_addr_t phys;
+
+	/* order_bit is numbered starting at 1 from fls64 */
+	*order = KHO_ORDER_0_LOG2 - order_bit + 1;
+	/* The order is discarded by the shift */
+	phys = key << (PAGE_SHIFT + *order);
+
+	return phys;
+}
+
+static unsigned long kho_radix_get_bitmap_index(unsigned long key)
+{
+	return key % (1 << KHO_BITMAP_SIZE_LOG2);
+}
+
+static unsigned long kho_radix_get_table_index(unsigned long key,
+					       unsigned int level)
+{
+	int s;
+
+	s = ((level - 1) * KHO_TABLE_SIZE_LOG2) + KHO_BITMAP_SIZE_LOG2;
+	return (key >> s) % (1 << KHO_TABLE_SIZE_LOG2);
+}
+
+/**
+ * kho_radix_add_page - Marks a page as preserved in the radix tree.
+ * @tree: The KHO radix tree.
+ * @pfn: The page frame number of the page to preserve.
+ * @order: The order of the page.
+ *
+ * This function traverses the radix tree based on the key derived from @pfn
+ * and @order. It sets the corresponding bit in the leaf bitmap to mark the
+ * page for preservation. If intermediate nodes do not exist along the path,
+ * they are allocated and added to the tree.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int kho_radix_add_page(struct kho_radix_tree *tree,
+		       unsigned long pfn, unsigned int order)
+{
+	/* Newly allocated nodes for error cleanup */
+	struct kho_radix_node *intermediate_nodes[KHO_TREE_MAX_DEPTH] = { 0 };
+	unsigned long key = kho_radix_encode_key(PFN_PHYS(pfn), order);
+	struct kho_radix_node *anchor_node = NULL;
+	struct kho_radix_node *node = tree->root;
+	struct kho_radix_node *new_node;
+	unsigned int i, idx, anchor_idx;
+	struct kho_radix_leaf *leaf;
+	int err = 0;
+
+	if (WARN_ON_ONCE(!tree->root))
+		return -EINVAL;
+
+	might_sleep();
+
+	guard(mutex)(&tree->lock);
+
+	/* Go from high levels to low levels */
+	for (i = KHO_TREE_MAX_DEPTH - 1; i > 0; i--) {
+		idx = kho_radix_get_table_index(key, i);
+
+		if (node->table[idx]) {
+			node = phys_to_virt(node->table[idx]);
+			continue;
+		}
+
+		/* Next node is empty, create a new node for it */
+		new_node = (struct kho_radix_node *)get_zeroed_page(GFP_KERNEL);
+		if (!new_node) {
+			err = -ENOMEM;
+			goto err_free_nodes;
+		}
+
+		node->table[idx] = virt_to_phys(new_node);
+
+		/*
+		 * Capture the node where the new branch starts for cleanup
+		 * if allocation fails.
+		 */
+		if (!anchor_node) {
+			anchor_node = node;
+			anchor_idx = idx;
+		}
+		intermediate_nodes[i] = new_node;
+
+		node = new_node;
+	}
+
+	/* Handle the leaf level bitmap (level 0) */
+	idx = kho_radix_get_bitmap_index(key);
+	leaf = (struct kho_radix_leaf *)node;
+	__set_bit(idx, leaf->bitmap);
+
+	return 0;
+
+err_free_nodes:
+	for (i = KHO_TREE_MAX_DEPTH - 1; i > 0; i--) {
+		if (intermediate_nodes[i])
+			free_page((unsigned long)intermediate_nodes[i]);
+	}
+	if (anchor_node)
+		anchor_node->table[anchor_idx] = 0;
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(kho_radix_add_page);
+
+/**
+ * kho_radix_del_page - Removes a page's preservation status from the radix tree.
+ * @tree: The KHO radix tree.
+ * @pfn: The page frame number of the page to unpreserve.
+ * @order: The order of the page.
+ *
+ * This function traverses the radix tree and clears the bit corresponding to
+ * the page, effectively removing its "preserved" status. It does not free
+ * the tree's intermediate nodes, even if they become empty.
+ */
+void kho_radix_del_page(struct kho_radix_tree *tree, unsigned long pfn,
+			unsigned int order)
+{
+	unsigned long key = kho_radix_encode_key(PFN_PHYS(pfn), order);
+	struct kho_radix_node *node = tree->root;
+	struct kho_radix_leaf *leaf;
+	unsigned int i, idx;
+
+	if (WARN_ON_ONCE(!tree->root))
+		return;
+
+	might_sleep();
+
+	guard(mutex)(&tree->lock);
+
+	/* Go from high levels to low levels */
+	for (i = KHO_TREE_MAX_DEPTH - 1; i > 0; i--) {
+		idx = kho_radix_get_table_index(key, i);
+
+		/*
+		 * Attempting to delete a page that has not been preserved,
+		 * return with a warning.
+		 */
+		if (WARN_ON(!node->table[idx]))
+			return;
+
+		node = phys_to_virt(node->table[idx]);
+	}
+
+	/* Handle the leaf level bitmap (level 0) */
+	leaf = (struct kho_radix_leaf *)node;
+	idx = kho_radix_get_bitmap_index(key);
+	__clear_bit(idx, leaf->bitmap);
+}
+EXPORT_SYMBOL_GPL(kho_radix_del_page);
+
+static int kho_radix_walk_leaf(struct kho_radix_leaf *leaf,
+			       unsigned long key,
+			       kho_radix_tree_walk_callback_t cb)
+{
+	unsigned long *bitmap = (unsigned long *)leaf;
+	unsigned int order;
+	phys_addr_t phys;
+	unsigned int i;
+	int err;
+
+	for_each_set_bit(i, bitmap, PAGE_SIZE * BITS_PER_BYTE) {
+		phys = kho_radix_decode_key(key | i, &order);
+		err = cb(phys, order);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int __kho_radix_walk_tree(struct kho_radix_node *root,
+				 unsigned int level, unsigned long start,
+				 kho_radix_tree_walk_callback_t cb)
+{
+	struct kho_radix_node *node;
+	struct kho_radix_leaf *leaf;
+	unsigned long key, i;
+	unsigned int shift;
+	int err;
+
+	for (i = 0; i < PAGE_SIZE / sizeof(phys_addr_t); i++) {
+		if (!root->table[i])
+			continue;
+
+		shift = ((level - 1) * KHO_TABLE_SIZE_LOG2) +
+			KHO_BITMAP_SIZE_LOG2;
+		key = start | (i << shift);
+
+		node = phys_to_virt(root->table[i]);
+
+		if (level == 1) {
+			/*
+			 * we are at level 1,
+			 * node is pointing to the level 0 bitmap.
+			 */
+			leaf = (struct kho_radix_leaf *)node;
+			err = kho_radix_walk_leaf(leaf, key, cb);
+		} else {
+			err  = __kho_radix_walk_tree(node, level - 1,
+						     key, cb);
+		}
+
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+/**
+ * kho_radix_walk_tree - Traverses the radix tree and calls a callback for each preserved page.
+ * @tree: A pointer to the KHO radix tree to walk.
+ * @cb: A callback function of type kho_radix_tree_walk_callback_t that will be
+ *      invoked for each preserved page found in the tree. The callback receives
+ *      the physical address and order of the preserved page.
+ *
+ * This function walks the radix tree, searching from the specified top level
+ * down to the lowest level (level 0). For each preserved page found, it invokes
+ * the provided callback, passing the page's physical address and order.
+ *
+ * Return: 0 if the walk completed the specified tree, or the non-zero return
+ *         value from the callback that stopped the walk.
+ */
+int kho_radix_walk_tree(struct kho_radix_tree *tree,
+			kho_radix_tree_walk_callback_t cb)
+{
+	if (WARN_ON_ONCE(!tree->root))
+		return -EINVAL;
+
+	guard(mutex)(&tree->lock);
+
+	return __kho_radix_walk_tree(tree->root, KHO_TREE_MAX_DEPTH - 1, 0, cb);
+}
+EXPORT_SYMBOL_GPL(kho_radix_walk_tree);
-- 
2.53.0


