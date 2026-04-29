Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103BEFF8867
	for <kexec@archiver.kernel.org>; Wed, 29 Apr 2026 13:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oFI361pCC+MubIMIzirZDVSDvX03Lg5mwijXtqdZWCM=; b=jN1eDhKNF0f3WD9Y3fJMRksByp
	0IEBZ6ALOai3Hi/2Y/N+ZOpbPUYs8QqOb5qfyFTgOhPeRvw1576Nm1zr7MZnOrUzB0MY+nygmSh44
	rXSrpMpFZfmu5c4+xrj2O2Eoc8Vg9rFPyBoTCWw1snt7Pt64UKlbccxEr62YFWW/O8cMXyDWVbysw
	Eguet94etDeTrJAZiIMeT4bVRcy7Vkd9wXnjmstYJ5XlA8nZ4Y3tkpP0pKWiboGXFckmMOJY1r2G/
	UGJdQ/txDvYlScWhUvYhY4zZS7u1f0dp3de67XDlDsR+nNvZpTV/r1amBZ3h6ytwNibW/ieHc1JjX
	7VpTOJ4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI58x-00000003gXY-21ex;
	Wed, 29 Apr 2026 13:39:59 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI58u-00000003gV8-2b6s
	for kexec@lists.infradead.org;
	Wed, 29 Apr 2026 13:39:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 444AC4451E;
	Wed, 29 Apr 2026 13:39:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EEBAC2BCB8;
	Wed, 29 Apr 2026 13:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777469996;
	bh=D7e5tDuPEikjDNzEWBdawY+xK5X311huQBCQe6bYQjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BXwgQPV7TIoFRjGIb97YZI5FqIOmXTkItCH6c9HMLsleuRHsVZS1VZB/8vuxbYop6
	 w/FV6g0BomdhfWgyopnA0m8gbWh+IhyJ3j8EjEX4qVt6SL8/7w/7u9Jz5sK6YxdLC2
	 pdIib0LKc9k5daQsKL031TY1t32wUb70uUNaLzd9M9CEZtbfYZHRdAdZgozjRUBoBD
	 oC/Lmk40lrH/BlPwg+jFJEnvyAvimu5Tp5eIuvIwCoBMQBWAYcQ2k0FgMsL0OD3J+t
	 vgx9c99J+4YXwCXXKWo4MwVF++ZmUPZ1riT7jzORWf8Ns0GFmxdO4kFYRFUUPaU8eO
	 bFRaMmLwwjJEQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] kho: add data argument to radix walk callback
Date: Wed, 29 Apr 2026 15:39:07 +0200
Message-ID: <20260429133928.850721-6-pratyush@kernel.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260429133928.850721-1-pratyush@kernel.org>
References: <20260429133928.850721-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_063956_701598_5CFB312B 
X-CRM114-Status: GOOD (  17.43  )
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

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

Add an opaque data pointer argument to kho_radix_walk_cb_t. This can be
used for callers to pass extra information to the callback.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 include/linux/kho_radix_tree.h     |  8 ++++----
 kernel/liveupdate/kexec_handover.c | 24 +++++++++++++-----------
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/include/linux/kho_radix_tree.h b/include/linux/kho_radix_tree.h
index fe7151d89361..6c0f7d82716b 100644
--- a/include/linux/kho_radix_tree.h
+++ b/include/linux/kho_radix_tree.h
@@ -44,8 +44,8 @@ struct kho_radix_tree {
  * return value is directly returned to the caller.
  */
 struct kho_radix_walk_cb {
-	int (*key)(unsigned long key);
-	int (*table)(phys_addr_t phys);
+	int (*key)(unsigned long key, void *data);
+	int (*table)(phys_addr_t phys, void *data);
 };
 
 #ifdef CONFIG_KEXEC_HANDOVER
@@ -53,7 +53,7 @@ struct kho_radix_walk_cb {
 int kho_radix_add_key(struct kho_radix_tree *tree, unsigned long key);
 void kho_radix_del_key(struct kho_radix_tree *tree, unsigned long key);
 int kho_radix_walk_tree(struct kho_radix_tree *tree,
-			const struct kho_radix_walk_cb *cb);
+			const struct kho_radix_walk_cb *cb, void *data);
 
 #else  /* #ifdef CONFIG_KEXEC_HANDOVER */
 
@@ -66,7 +66,7 @@ static inline void kho_radix_del_key(struct kho_radix_tree *tree,
 				     unsigned long key) { }
 
 static inline int kho_radix_walk_tree(struct kho_radix_tree *tree,
-				      const struct kho_radix_walk_cb *cb)
+				      const struct kho_radix_walk_cb *cb, void *data)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 94ca831b41c9..d0a4f78eccfe 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -267,14 +267,14 @@ void kho_radix_del_key(struct kho_radix_tree *tree, unsigned long key)
 EXPORT_SYMBOL_GPL(kho_radix_del_key);
 
 static int kho_radix_walk_leaf(struct kho_radix_leaf *leaf, unsigned long key,
-			       const struct kho_radix_walk_cb *cb)
+			       const struct kho_radix_walk_cb *cb, void *data)
 {
 	unsigned long *bitmap = (unsigned long *)leaf;
 	unsigned int i;
 	int err;
 
 	if (cb->table) {
-		err = cb->table(virt_to_phys(leaf));
+		err = cb->table(virt_to_phys(leaf), data);
 		if (err)
 			return err;
 	}
@@ -283,7 +283,7 @@ static int kho_radix_walk_leaf(struct kho_radix_leaf *leaf, unsigned long key,
 		return 0;
 
 	for_each_set_bit(i, bitmap, PAGE_SIZE * BITS_PER_BYTE) {
-		err = cb->key(key | i);
+		err = cb->key(key | i, data);
 		if (err)
 			return err;
 	}
@@ -293,7 +293,7 @@ static int kho_radix_walk_leaf(struct kho_radix_leaf *leaf, unsigned long key,
 
 static int __kho_radix_walk_tree(struct kho_radix_node *root,
 				 unsigned int level, unsigned long start,
-				 const struct kho_radix_walk_cb *cb)
+				 const struct kho_radix_walk_cb *cb, void *data)
 {
 	struct kho_radix_node *node;
 	struct kho_radix_leaf *leaf;
@@ -302,7 +302,7 @@ static int __kho_radix_walk_tree(struct kho_radix_node *root,
 	int err;
 
 	if (cb->table) {
-		err = cb->table(virt_to_phys(root));
+		err = cb->table(virt_to_phys(root), data);
 		if (err)
 			return err;
 	}
@@ -323,10 +323,10 @@ static int __kho_radix_walk_tree(struct kho_radix_node *root,
 			 * node is pointing to the level 0 bitmap.
 			 */
 			leaf = (struct kho_radix_leaf *)node;
-			err = kho_radix_walk_leaf(leaf, key, cb);
+			err = kho_radix_walk_leaf(leaf, key, cb, data);
 		} else {
 			err  = __kho_radix_walk_tree(node, level - 1,
-						     key, cb);
+						     key, cb, data);
 		}
 
 		if (err)
@@ -340,6 +340,7 @@ static int __kho_radix_walk_tree(struct kho_radix_node *root,
  * kho_radix_walk_tree - Traverses the radix tree and calls a callback for each key.
  * @tree: A pointer to the KHO radix tree to walk.
  * @cb:   Set of callbacks to be invoked during the tree walk.
+ * @data: Opaque data pointer passed to each callback in @cb.
  *
  * This function walks the radix tree, searching from the top level down to the
  * lowest level (level 0), invoking the appropriate callbacks.
@@ -348,14 +349,15 @@ static int __kho_radix_walk_tree(struct kho_radix_node *root,
  *         value from the callback that stopped the walk.
  */
 int kho_radix_walk_tree(struct kho_radix_tree *tree,
-			const struct kho_radix_walk_cb *cb)
+			const struct kho_radix_walk_cb *cb, void *data)
 {
 	if (WARN_ON_ONCE(!tree->root))
 		return -EINVAL;
 
 	guard(mutex)(&tree->lock);
 
-	return __kho_radix_walk_tree(tree->root, KHO_TREE_MAX_DEPTH - 1, 0, cb);
+	return __kho_radix_walk_tree(tree->root, KHO_TREE_MAX_DEPTH - 1, 0, cb,
+				     data);
 }
 EXPORT_SYMBOL_GPL(kho_radix_walk_tree);
 
@@ -501,7 +503,7 @@ static struct page *__init kho_get_preserved_page(phys_addr_t phys,
 	return pfn_to_page(pfn);
 }
 
-static int __init kho_preserved_memory_reserve(unsigned long key)
+static int __init kho_preserved_memory_reserve(unsigned long key, void *data)
 {
 	union kho_page_info info;
 	struct page *page;
@@ -1392,7 +1394,7 @@ static int __init kho_mem_retrieve(const void *fdt)
 
 	kho_in.radix_tree.root = phys_to_virt(kho_get_mem_map_phys(fdt));
 	mutex_init(&kho_in.radix_tree.lock);
-	return kho_radix_walk_tree(&kho_in.radix_tree, &cb);
+	return kho_radix_walk_tree(&kho_in.radix_tree, &cb, NULL);
 }
 
 static __init int kho_out_fdt_setup(void)
-- 
2.54.0.545.g6539524ca2-goog


