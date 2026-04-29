Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30379CCFA13
	for <kexec@archiver.kernel.org>; Wed, 29 Apr 2026 13:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w43KFUkArY6lknz9gNrxkbJ9jhP+SRfZ6SXj91A9It8=; b=2Pv/IYUJ1TLKisgh3mvGdIA7Fa
	o7xUjRyiirmGPeCnljEt64oZUrIjclF0c467QT84OqZlycY2q7H/HLOyQ9+eGKNq8ZK8aja8v/NiI
	mdA9rfUa6QOqgiuzanSiIOCpmAu0+yrteUp1/xVO2SHMoswCZJYEXPkx0ZtbawDJBiAcOaubG0r4r
	y0PuiFe+hdQN0DlQuK3G6v12fsF1ON2dLLGCIO/OnmJE+r7XWCTuJIew3AjoJLJ/woNxiUSOfmJhX
	4sj4KxbCuoEN3y1QQzrV/EJBXPQbV8olN+4qSEMS/GHweUy2aebRkGY2pvldU6SF5f34qYKuu3lKZ
	kDmBUUEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI58s-00000003gUP-3m3x;
	Wed, 29 Apr 2026 13:39:54 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI58q-00000003gSR-27JG
	for kexec@lists.infradead.org;
	Wed, 29 Apr 2026 13:39:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D972860582;
	Wed, 29 Apr 2026 13:39:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F97AC2BCC4;
	Wed, 29 Apr 2026 13:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777469991;
	bh=tnjp4B+bCIr0sG99AF+rCD8R2O3pqFA0kGLY1BJsYzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=np2Qg1OgEt3WN2MkvhLzhwY8UbvPQFLhzjnwDrKCU8Kn62aAROgNpcfLruLLIFqp9
	 IAUL+1FxC8YHK1/fZzgVsHelhu/opytSHJgcIN+O8CD7IktoVyTXP8Gi7/xIp/S1q3
	 zGORtXd+I/acbf57qO5HQLDXDcvIvXKCf9FZKX45ThMjKe9XBNb3PiuDrRNAMuu710
	 8zu86r369RHIlhs8R0B+730jKoHmVkdqOKD+Q4dbNv3Xt1bALxSzLY0+rz2TgwMVNz
	 zoISlzkM3+pyKFBoEkeT5wnTdQ0mNdSLGezpn9lPGnEvXgMld3rJogD2+dF+fFRlaC
	 DTtiFvTKOBU+A==
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
Subject: [PATCH 03/12] kho: add a struct for radix callbacks
Date: Wed, 29 Apr 2026 15:39:05 +0200
Message-ID: <20260429133928.850721-4-pratyush@kernel.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260429133928.850721-1-pratyush@kernel.org>
References: <20260429133928.850721-1-pratyush@kernel.org>
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

A future commit will add more callbacks for the KHO radix tree. Add a
struct for collecting the callbacks.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 include/linux/kho_radix_tree.h     | 15 ++++++++++++---
 kernel/liveupdate/kexec_handover.c | 29 ++++++++++++++++-------------
 2 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/include/linux/kho_radix_tree.h b/include/linux/kho_radix_tree.h
index f368f3b9f923..030da6399d28 100644
--- a/include/linux/kho_radix_tree.h
+++ b/include/linux/kho_radix_tree.h
@@ -34,14 +34,23 @@ struct kho_radix_tree {
 	struct mutex lock; /* protects the tree's structure and root pointer */
 };
 
-typedef int (*kho_radix_tree_walk_callback_t)(unsigned long key);
+/**
+ * struct kho_radix_walk_cb - Callbacks for KHO radix tree walk.
+ * @key:      Called on each present key in the radix tree.
+ *
+ * For each callback, a return value of 0 continues the walk and a non-zero
+ * return value is directly returned to the caller.
+ */
+struct kho_radix_walk_cb {
+	int (*key)(unsigned long key);
+};
 
 #ifdef CONFIG_KEXEC_HANDOVER
 
 int kho_radix_add_key(struct kho_radix_tree *tree, unsigned long key);
 void kho_radix_del_key(struct kho_radix_tree *tree, unsigned long key);
 int kho_radix_walk_tree(struct kho_radix_tree *tree,
-			kho_radix_tree_walk_callback_t cb);
+			const struct kho_radix_walk_cb *cb);
 
 #else  /* #ifdef CONFIG_KEXEC_HANDOVER */
 
@@ -54,7 +63,7 @@ static inline void kho_radix_del_key(struct kho_radix_tree *tree,
 				     unsigned long key) { }
 
 static inline int kho_radix_walk_tree(struct kho_radix_tree *tree,
-				      kho_radix_tree_walk_callback_t cb)
+				      const struct kho_radix_walk_cb *cb)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 5758dc6fab5d..4a5d1b47799c 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -266,16 +266,18 @@ void kho_radix_del_key(struct kho_radix_tree *tree, unsigned long key)
 }
 EXPORT_SYMBOL_GPL(kho_radix_del_key);
 
-static int kho_radix_walk_leaf(struct kho_radix_leaf *leaf,
-			       unsigned long key,
-			       kho_radix_tree_walk_callback_t cb)
+static int kho_radix_walk_leaf(struct kho_radix_leaf *leaf, unsigned long key,
+			       const struct kho_radix_walk_cb *cb)
 {
 	unsigned long *bitmap = (unsigned long *)leaf;
 	unsigned int i;
 	int err;
 
+	if (!cb->key)
+		return 0;
+
 	for_each_set_bit(i, bitmap, PAGE_SIZE * BITS_PER_BYTE) {
-		err = cb(key | i);
+		err = cb->key(key | i);
 		if (err)
 			return err;
 	}
@@ -285,7 +287,7 @@ static int kho_radix_walk_leaf(struct kho_radix_leaf *leaf,
 
 static int __kho_radix_walk_tree(struct kho_radix_node *root,
 				 unsigned int level, unsigned long start,
-				 kho_radix_tree_walk_callback_t cb)
+				 const struct kho_radix_walk_cb *cb)
 {
 	struct kho_radix_node *node;
 	struct kho_radix_leaf *leaf;
@@ -325,18 +327,16 @@ static int __kho_radix_walk_tree(struct kho_radix_node *root,
 /**
  * kho_radix_walk_tree - Traverses the radix tree and calls a callback for each key.
  * @tree: A pointer to the KHO radix tree to walk.
- * @cb: A callback function of type kho_radix_tree_walk_callback_t that will be
- *      invoked for each key in the tree.
+ * @cb:   Set of callbacks to be invoked during the tree walk.
  *
- * This function walks the radix tree, searching from the specified top level
- * down to the lowest level (level 0). For each key found, it invokes the
- * provided callback.
+ * This function walks the radix tree, searching from the top level down to the
+ * lowest level (level 0), invoking the appropriate callbacks.
  *
  * Return: 0 if the walk completed the specified tree, or the non-zero return
  *         value from the callback that stopped the walk.
  */
 int kho_radix_walk_tree(struct kho_radix_tree *tree,
-			kho_radix_tree_walk_callback_t cb)
+			const struct kho_radix_walk_cb *cb)
 {
 	if (WARN_ON_ONCE(!tree->root))
 		return -EINVAL;
@@ -1374,10 +1374,13 @@ EXPORT_SYMBOL_GPL(kho_retrieve_subtree);
 
 static int __init kho_mem_retrieve(const void *fdt)
 {
+	const struct kho_radix_walk_cb cb = {
+		.key = kho_preserved_memory_reserve,
+	};
+
 	kho_in.radix_tree.root = phys_to_virt(kho_get_mem_map_phys(fdt));
 	mutex_init(&kho_in.radix_tree.lock);
-	return kho_radix_walk_tree(&kho_in.radix_tree,
-				   kho_preserved_memory_reserve);
+	return kho_radix_walk_tree(&kho_in.radix_tree, &cb);
 }
 
 static __init int kho_out_fdt_setup(void)
-- 
2.54.0.545.g6539524ca2-goog


