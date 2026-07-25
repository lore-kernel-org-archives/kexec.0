Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 546DEC531C9
	for <kexec@archiver.kernel.org>; Sat, 25 Jul 2026 17:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KQKSVACWi2OrYDj0Ki9RD+36Hdol1cs+/9K3uPXgqEM=; b=0JqXj2ld/Z+grL/V/XHYlJo2fy
	w4pcHKj8rpUzNRrslmj1nfkVvJXI3X5/pi4H/U0E+9orKWGLSt9OdgkYOR3LslyYzjR/6JVCu7utI
	uDkRX91/XFlCmdsapo9T6ZuJLhlXMrQqqdfkLphCE/HIUYAqQDe0r6Pr9o2TORcC6S8QDT7MU4pNt
	qRNUOYEnAwPOcf2yypU2Az34ZwBjQOm5lsUR0sGukr61KE5yjeqW+bXvevtQ4uETsl4celWxc1akg
	CjrW4o53DrpXezUw8L6aCEakvi45WTBP4rtF7clScz2coL7HgUQywuZcGZQI+TPwQ42dFE0FK3b7J
	4Q1xWOMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wng4g-00000000aTT-2nM1;
	Sat, 25 Jul 2026 17:22:10 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wng4f-00000000aSR-0YpF
	for kexec@lists.infradead.org;
	Sat, 25 Jul 2026 17:22:09 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DDDD841A04;
	Sat, 25 Jul 2026 17:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C8D1F00A3D;
	Sat, 25 Jul 2026 17:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785000128;
	bh=KQKSVACWi2OrYDj0Ki9RD+36Hdol1cs+/9K3uPXgqEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y3hMSXEEPp3sQZ2xVqiIK+EPwa/mL7WHMbjvdFrrCdKue0+lw80Z3apfMAm3KA+uC
	 LtV/u6MMDJUg5fWVJoG4ndwMJza/xlZ5ZHGJ6/8LuRo4lhYFUSBOUxd7Q2VY7IgfMg
	 5fsgKz3sY9HMgPqOeNjUS6spaDKt/5NixIRNJpE60mumxNG8hrvnKHehj4xejoKy72
	 lyisQWIoDoyos18YwHzvZA2rKnUbGyc9XPRAm3axnKDdN+khilgZWZcpIks87GTq3C
	 dqAuQXsCg5N57pM8IzX2JfPIdu0EAHQcsxoGhqWhMP/VQ3klbCFcJz/rty481Tv89e
	 f213OLxfCv0rg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>,
	Jork Loeser <jloeser@linux.microsoft.com>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/21] kho: add data argument to radix walk callback
Date: Sat, 25 Jul 2026 19:21:09 +0200
Message-ID: <20260725172133.4018491-10-pratyush@kernel.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260725172133.4018491-1-pratyush@kernel.org>
References: <20260725172133.4018491-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
used by callers to pass extra information to the callback.

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 include/linux/kho_radix_tree.h     |  8 ++++----
 kernel/liveupdate/kexec_handover.c | 24 +++++++++++++-----------
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/include/linux/kho_radix_tree.h b/include/linux/kho_radix_tree.h
index ac7ba7e567e1..4138621e0e87 100644
--- a/include/linux/kho_radix_tree.h
+++ b/include/linux/kho_radix_tree.h
@@ -44,8 +44,8 @@ struct kho_radix_tree {
  * return value is directly returned to the caller.
  */
 struct kho_radix_walk_cb {
-	int (*leaf)(unsigned long key);
-	int (*node)(phys_addr_t phys);
+	int (*leaf)(unsigned long key, void *data);
+	int (*node)(phys_addr_t phys, void *data);
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
index 2044f35cf1de..3dd26d5d3c09 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -282,14 +282,14 @@ void kho_radix_del_key(struct kho_radix_tree *tree, unsigned long key)
 EXPORT_SYMBOL_GPL(kho_radix_del_key);
 
 static int kho_radix_walk_leaf(struct kho_radix_leaf *leaf, unsigned long key,
-			       const struct kho_radix_walk_cb *cb)
+			       const struct kho_radix_walk_cb *cb, void *data)
 {
 	unsigned long *bitmap = (unsigned long *)leaf;
 	unsigned int i;
 	int err;
 
 	if (cb->node) {
-		err = cb->node(virt_to_phys(leaf));
+		err = cb->node(virt_to_phys(leaf), data);
 		if (err)
 			return err;
 	}
@@ -298,7 +298,7 @@ static int kho_radix_walk_leaf(struct kho_radix_leaf *leaf, unsigned long key,
 		return 0;
 
 	for_each_set_bit(i, bitmap, PAGE_SIZE * BITS_PER_BYTE) {
-		err = cb->leaf(key | i);
+		err = cb->leaf(key | i, data);
 		if (err)
 			return err;
 	}
@@ -308,7 +308,7 @@ static int kho_radix_walk_leaf(struct kho_radix_leaf *leaf, unsigned long key,
 
 static int __kho_radix_walk_tree(struct kho_radix_node *root,
 				 unsigned int level, unsigned long start,
-				 const struct kho_radix_walk_cb *cb)
+				 const struct kho_radix_walk_cb *cb, void *data)
 {
 	struct kho_radix_node *node;
 	struct kho_radix_leaf *leaf;
@@ -317,7 +317,7 @@ static int __kho_radix_walk_tree(struct kho_radix_node *root,
 	int err;
 
 	if (cb->node) {
-		err = cb->node(virt_to_phys(root));
+		err = cb->node(virt_to_phys(root), data);
 		if (err)
 			return err;
 	}
@@ -338,10 +338,10 @@ static int __kho_radix_walk_tree(struct kho_radix_node *root,
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
@@ -355,6 +355,7 @@ static int __kho_radix_walk_tree(struct kho_radix_node *root,
  * kho_radix_walk_tree - Traverses the radix tree and calls a callback for each key.
  * @tree: A pointer to the KHO radix tree to walk.
  * @cb:   Set of callbacks to be invoked during the tree walk.
+ * @data: Opaque data pointer passed to each callback in @cb.
  *
  * This function walks the radix tree, searching from the top level down to the
  * lowest level (level 0), invoking the appropriate callbacks.
@@ -363,14 +364,15 @@ static int __kho_radix_walk_tree(struct kho_radix_node *root,
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
@@ -1445,7 +1447,7 @@ static void __init kho_mem_retrieve(void)
 	kho_in.radix_tree.root = kho_get_mem_map(fdt);
 	mutex_init(&kho_in.radix_tree.lock);
 
-	err = kho_radix_walk_tree(&kho_in.radix_tree, &cb);
+	err = kho_radix_walk_tree(&kho_in.radix_tree, &cb, NULL);
 	if (err) {
 		/*
 		 * Failed to initialize preserved memory. Clear FDT and radix
-- 
2.55.0.229.g6434b31f56-goog


