Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0269C44501
	for <kexec@archiver.kernel.org>; Thu,  9 Jul 2026 17:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pcpHltz9li0iTs1WsD5eIIz6ruG9qO5py8BOvyZzad8=; b=AW6IaB4lkas+HdyHSRk4fSxQ/G
	2gQR6lVzzMPqEywxoMOX0XzDTdSirfjkIDGCfiEaiTeUhdt9CVJzKjr4KbO+BFM3XPIz8FKIRn4ri
	k/FrOHpIxxpIvbO3KuBbYBd2e42l0COg8nh/ifnaoe9ST5eVSlrPoLToed1du6PAR4QDXbncmjxES
	RcmKjmYujn5IGr3jud95N26VKuvEMjCt0olth09LLLSHZbxYCV4Abzje5A4gJsmKBgjnKcpEhlVnG
	F4mx/BZls9PFjAg/YHnFi6LApFm8JKer7Yrqr/2CevCDgXy9tzIOGCsSTIMSQ4KSSigeb6IzGVetW
	JhIFEzHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whsi4-0000000389N-0O7U;
	Thu, 09 Jul 2026 17:38:52 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whsi2-0000000387L-2Qyl
	for kexec@lists.infradead.org;
	Thu, 09 Jul 2026 17:38:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 56F2841FC5;
	Thu,  9 Jul 2026 17:38:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152041F00A3A;
	Thu,  9 Jul 2026 17:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783618730;
	bh=pcpHltz9li0iTs1WsD5eIIz6ruG9qO5py8BOvyZzad8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k5z1XPTEJRdBV0HODe/jQ+vpX6f+RThVFgxm6WznsGEnXwv53CwoMVJge+88qVlWp
	 Z1tyoMxl0JrOHUJrBJD4/ApBHDT4H82zBzmkh6/D2A455Y7lumK83pnewWubv2U++U
	 zo/vxYmmRYWx+H6E7d9XqmBMdR2qdDvZuDMkCUwJtW7weia1kg/guXna1KG5QFaw67
	 vOrIxucadXjuDq0Z2C4o0e8XHoBfGe17r+3eZp02lVDCBJPnNLLWNC/LRh02+nBdIJ
	 jegyG6EnJkk0noOLhISOr5a7PN+AfQZxAvqVWGIkKmAGp+PKboyQ6Kv4kKJP9xzLlS
	 xjOPA7oRHLbDg==
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
Subject: [PATCH v3 07/21] kho: add a struct for radix callbacks
Date: Thu,  9 Jul 2026 19:37:56 +0200
Message-ID: <20260709173821.429921-8-pratyush@kernel.org>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
In-Reply-To: <20260709173821.429921-1-pratyush@kernel.org>
References: <20260709173821.429921-1-pratyush@kernel.org>
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
 kernel/liveupdate/kexec_handover.c | 27 +++++++++++++++------------
 2 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/include/linux/kho_radix_tree.h b/include/linux/kho_radix_tree.h
index f368f3b9f923..426a9cc9bcde 100644
--- a/include/linux/kho_radix_tree.h
+++ b/include/linux/kho_radix_tree.h
@@ -34,14 +34,23 @@ struct kho_radix_tree {
 	struct mutex lock; /* protects the tree's structure and root pointer */
 };
 
-typedef int (*kho_radix_tree_walk_callback_t)(unsigned long key);
+/**
+ * struct kho_radix_walk_cb - Callbacks for KHO radix tree walk.
+ * @leaf:      Called on each present key in the radix tree.
+ *
+ * For each callback, a return value of 0 continues the walk and a non-zero
+ * return value is directly returned to the caller.
+ */
+struct kho_radix_walk_cb {
+	int (*leaf)(unsigned long key);
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
index e3408e1844dc..9fb07c0ef18e 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -281,16 +281,18 @@ void kho_radix_del_key(struct kho_radix_tree *tree, unsigned long key)
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
 
+	if (!cb->leaf)
+		return 0;
+
 	for_each_set_bit(i, bitmap, PAGE_SIZE * BITS_PER_BYTE) {
-		err = cb(key | i);
+		err = cb->leaf(key | i);
 		if (err)
 			return err;
 	}
@@ -300,7 +302,7 @@ static int kho_radix_walk_leaf(struct kho_radix_leaf *leaf,
 
 static int __kho_radix_walk_tree(struct kho_radix_node *root,
 				 unsigned int level, unsigned long start,
-				 kho_radix_tree_walk_callback_t cb)
+				 const struct kho_radix_walk_cb *cb)
 {
 	struct kho_radix_node *node;
 	struct kho_radix_leaf *leaf;
@@ -340,18 +342,16 @@ static int __kho_radix_walk_tree(struct kho_radix_node *root,
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
@@ -1417,6 +1417,9 @@ EXPORT_SYMBOL_GPL(kho_retrieve_subtree);
 
 static void __init kho_mem_retrieve(void)
 {
+	const struct kho_radix_walk_cb cb = {
+		.leaf = kho_preserved_memory_reserve,
+	};
 	const void *fdt = kho_get_fdt();
 	int err;
 
@@ -1430,7 +1433,7 @@ static void __init kho_mem_retrieve(void)
 	kho_in.radix_tree.root = kho_get_mem_map(fdt);
 	mutex_init(&kho_in.radix_tree.lock);
 
-	err = kho_radix_walk_tree(&kho_in.radix_tree, kho_preserved_memory_reserve);
+	err = kho_radix_walk_tree(&kho_in.radix_tree, &cb);
 	if (err) {
 		/*
 		 * Failed to initialize preserved memory. Clear FDT and radix
-- 
2.55.0.141.g00534a21ce-goog


