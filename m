Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B10FF8867
	for <kexec@archiver.kernel.org>; Wed, 29 Apr 2026 13:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/xb8++MFWWbutidJn3V0p20dgH6WcuZ7SlXr7qIYnqo=; b=CQwmvPRvwNxq4HWwe4FJqVtEq/
	MEMb0U27wZaDK295ltwIltbOrNB8w0yKFo3wgwzjcDJNBTTZEu/D0OuU4muwvEJpqSsLJKy/SOAgb
	6CaaPKdUWaX1lREBSyq4QIIB0raH3ty9TWc+Jb3EhQcpNGpSz24MuRmrLb5xBkrbCP/hQQI0X0Uev
	PzEckAb0k9NAPUaRkcNAYu/mQ3c7x5SoMhFqv3gn9kGX+dO8vBmYiqQ24W+7gHLoi8XwWJzfT27Ed
	xCRik54PkWki49tEfPi58xnxgtQ7oU/g8qBTJpvGug3Kymq+NZc4PSrHRY/pbmHP8A0OATJQpqSCT
	zTYcbLYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI594-00000003geO-2aIB;
	Wed, 29 Apr 2026 13:40:06 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI591-00000003gbI-1xPL
	for kexec@lists.infradead.org;
	Wed, 29 Apr 2026 13:40:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2AD74442F9;
	Wed, 29 Apr 2026 13:40:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E45BC2BCB8;
	Wed, 29 Apr 2026 13:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777470003;
	bh=7g0JJiONXBOw45AyCeb07Wo1XFWVqN+yfQgV92Bji6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CVvITovv0rPTsRIckne33fhWAqIvJ6CkT/vfyng+WOTzPKF2ue9p2YU9OD2nkxcFG
	 fth0V8NRUAtRGk8QRFXdp6fCF0L7vLSEBo0jOV3YoKh8HmxQfbxUNlrg1qmzWSRMat
	 4T6MZ03v7IWk6RQx8JLhpmMqvHA8ch14S6AuBok4JO/g0NKI3CacRHxV8AqZwp+160
	 mcyN3E3n4S4kbrcwE9RDz+/Mv0Ia/q2QMomCmePKcGpUTX6omL55T356NyAODrmIry
	 yVR+XcutobkssLARvkmMLlnPWEU7gDkM7fR6AqyiRkvGmHrGhyVX11rqttaKEc6k4Z
	 a07k8GPJUfwjQ==
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
Subject: [PATCH 08/12] kho: add kho_radix_init_tree()
Date: Wed, 29 Apr 2026 15:39:10 +0200
Message-ID: <20260429133928.850721-9-pratyush@kernel.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260429133928.850721-1-pratyush@kernel.org>
References: <20260429133928.850721-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_064003_553093_A382425A 
X-CRM114-Status: GOOD (  16.33  )
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
 include/linux/kho_radix_tree.h     |  7 ++++++
 kernel/liveupdate/kexec_handover.c | 37 ++++++++++++++++++++++++++++--
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/include/linux/kho_radix_tree.h b/include/linux/kho_radix_tree.h
index 617395a6647a..c0840ecb230c 100644
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
index 29479534f65d..1a04e089f779 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -305,6 +305,34 @@ static void __kho_radix_destroy_tree(struct kho_radix_node *root,
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
@@ -1445,9 +1473,14 @@ static int __init kho_mem_retrieve(const void *fdt)
 	const struct kho_radix_walk_cb cb = {
 		.key = kho_preserved_memory_reserve,
 	};
+	phys_addr_t mem_map_phys;
+	int err;
+
+	mem_map_phys = kho_get_mem_map_phys(fdt);
+	err = kho_radix_init_tree(&kho_in.radix_tree, phys_to_virt(mem_map_phys));
+	if (err)
+		return err;
 
-	kho_in.radix_tree.root = phys_to_virt(kho_get_mem_map_phys(fdt));
-	mutex_init(&kho_in.radix_tree.lock);
 	return kho_radix_walk_tree(&kho_in.radix_tree, &cb, NULL);
 }
 
-- 
2.54.0.545.g6539524ca2-goog


