Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFCBCD6E7C
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 18:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZkWvf8Em4F4xpQ20Sn9ei7Pk/pLFMxxTuWJ2jy/x258=; b=z1ayc/20Oh2K+xg8Csf8wUcXSn
	kA5UHLewyM7lbJ2xyCLS4dvcwINX9saymNnbN975I6z/tnn/XUrBOEQgPmCaD8foAogc54edO32TV
	1ziSpwZZFk2w69IhbY9wxbD62/USr96q06POyQ03C3/O50BMyj8uHjh7Xk8aKRaa4uOeESxCFqi3f
	/wM3cTtXoJqsPesg/Mc6L4E3vF3ZBs9J3CpGJ7DnV9joaqqj2dsPM3zC4fi7ErDmF0+UhPbW8/Umy
	XXimBF/72hnMfe9nM7Ony4MN2nDK5Qz6LDaFQlWfM6g3WUkp6FHB6dr2kytCLprLBYBeGo5UD6V6N
	NAqMsVeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVZOP-000000013K5-0I6m;
	Fri, 05 Jun 2026 18:35:41 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVZOO-000000013JM-1V2n
	for kexec@lists.infradead.org;
	Fri, 05 Jun 2026 18:35:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C9D2A601F2;
	Fri,  5 Jun 2026 18:35:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9811F00893;
	Fri,  5 Jun 2026 18:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780684539;
	bh=ZkWvf8Em4F4xpQ20Sn9ei7Pk/pLFMxxTuWJ2jy/x258=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TXKNcMEK8ZHWObM629hgW5Sx/MnPTwMvjNI5ep5QCLxUwosJq3IHU+PK8DMXF0K+X
	 nZ5jVgzl1ww8zJaj5c/HwyY1iOrlm8X6ygGSsszb/sqBbYLsABo9zI/r4nR6JN1+O6
	 AcYhdl4OvZw+wwDBZQ3t8kZPD3ro8dMdpuh0M50mSFJIpf43lAhtxxnfwXTf58U5N5
	 TRtIu0qUUY2HBJiekh/uJo0gNTV8bbDOiDOvc/NGbCBrOuLNWz1V/lbZnw57RrLB3L
	 YAXVcnYpOB39Dz4G/t0GD38KXJ3JC22B7GiOkDPSPHRJxH4YApZddskdrzbZD2YRwt
	 oTOz7+fqNCcew==
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
Subject: [PATCH v2 11/18] kho: add kho_radix_init_tree()
Date: Fri,  5 Jun 2026 20:34:44 +0200
Message-ID: <20260605183501.3884950-12-pratyush@kernel.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <20260605183501.3884950-1-pratyush@kernel.org>
References: <20260605183501.3884950-1-pratyush@kernel.org>
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

Move the initialization logic of the radix tree into
kho_radix_init_tree() instead of having users open-code it. Makes the
boundaries cleaner and reduces code duplication when a new user of the
radix tree will be added in a future commit.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 include/linux/kho_radix_tree.h     |  7 ++++
 kernel/liveupdate/kexec_handover.c | 66 ++++++++++++++++++++++--------
 2 files changed, 55 insertions(+), 18 deletions(-)

diff --git a/include/linux/kho_radix_tree.h b/include/linux/kho_radix_tree.h
index 66ca936b3f06..5d6ae2893684 100644
--- a/include/linux/kho_radix_tree.h
+++ b/include/linux/kho_radix_tree.h
@@ -54,6 +54,7 @@ int kho_radix_add_key(struct kho_radix_tree *tree, unsigned long key);
 void kho_radix_del_key(struct kho_radix_tree *tree, unsigned long key);
 int kho_radix_walk_tree(struct kho_radix_tree *tree,
 			const struct kho_radix_walk_cb *cb, void *data);
+int kho_radix_init_tree(struct kho_radix_tree *tree, struct kho_radix_node *root);
 void kho_radix_destroy_tree(struct kho_radix_tree *tree);
 
 #else  /* #ifdef CONFIG_KEXEC_HANDOVER */
@@ -72,6 +73,12 @@ static inline int kho_radix_walk_tree(struct kho_radix_tree *tree,
 	return -EOPNOTSUPP;
 }
 
+static inline int kho_radix_init_tree(struct kho_radix_tree *tree,
+				      struct kho_radix_node *root)
+{
+	return 0;
+}
+
 static inline void kho_radix_destroy_tree(struct kho_radix_tree *tree) { }
 
 #endif /* #ifdef CONFIG_KEXEC_HANDOVER */
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index df3f5eb01bf1..8ab2c7e234e1 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -317,6 +317,34 @@ static void __kho_radix_destroy_tree(struct kho_radix_node *root,
 	kho_radix_free_node(root);
 }
 
+/**
+ * kho_radix_init_tree - initialize the radix tree.
+ * @tree:   the tree to initialize.
+ * @root:   root table of the radix tree.
+ *
+ * Initialize the radix tree with the given root node. If root is %NULL, an
+ * empty root table is allocated. If root is not %NULL, it is the caller's
+ * responsibility to make sure the root is valid and in the correct format.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int kho_radix_init_tree(struct kho_radix_tree *tree, struct kho_radix_node *root)
+{
+	/* Already initialized. */
+	if (tree->root)
+		return 0;
+
+	if (!root)
+		root = kho_radix_alloc_node();
+	if (!root)
+		return -ENOMEM;
+
+	tree->root = root;
+	mutex_init(&tree->lock);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kho_radix_init_tree);
+
 /**
  * kho_radix_destroy_tree - Destroy the radix tree
  * @tree: The radix tree to destroy
@@ -1496,18 +1524,23 @@ static void __init kho_mem_retrieve(void)
 	 * catches that and never sets kho_in.scratch_phys, which stops memory
 	 * retrieval.
 	 */
-	kho_in.radix_tree.root = kho_get_mem_map(fdt);
-	mutex_init(&kho_in.radix_tree.lock);
+	err = kho_radix_init_tree(&kho_in.radix_tree, kho_get_mem_map(fdt));
+	if (err)
+		goto err;
 
 	err = kho_radix_walk_tree(&kho_in.radix_tree, &cb, NULL);
-	if (err) {
-		/*
-		 * Failed to initialize preserved memory. Clear FDT and radix
-		 * so KHO users don't treat it as a KHO boot.
-		 */
-		kho_in.fdt_phys = 0;
-		kho_in.radix_tree.root = NULL;
-	}
+	if (err)
+		goto err;
+
+	return;
+
+err:
+	/*
+	 * Failed to initialize preserved memory. Clear FDT and radix so KHO
+	 * users don't treat it as a KHO boot.
+	 */
+	kho_in.fdt_phys = 0;
+	kho_in.radix_tree.root = NULL;
 }
 
 static __init int kho_out_fdt_setup(void)
@@ -1633,16 +1666,14 @@ static __init int kho_init(void)
 	if (!kho_enable)
 		return 0;
 
-	tree->root = kzalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!tree->root) {
-		err = -ENOMEM;
+	err = kho_radix_init_tree(tree, NULL);
+	if (err)
 		goto err_free_scratch;
-	}
 
 	kho_out.fdt = kho_alloc_preserve(PAGE_SIZE);
 	if (IS_ERR(kho_out.fdt)) {
 		err = PTR_ERR(kho_out.fdt);
-		goto err_free_kho_radix_tree_root;
+		goto err_free_kho_radix_tree;
 	}
 
 	err = kho_debugfs_init();
@@ -1693,9 +1724,8 @@ static __init int kho_init(void)
 
 err_free_fdt:
 	kho_unpreserve_free(kho_out.fdt);
-err_free_kho_radix_tree_root:
-	kfree(tree->root);
-	tree->root = NULL;
+err_free_kho_radix_tree:
+	kho_radix_destroy_tree(tree);
 err_free_scratch:
 	kho_out.fdt = NULL;
 	for (int i = 0; i < kho_scratch_cnt; i++) {
-- 
2.54.0.1032.g2f8565e1d1-goog


