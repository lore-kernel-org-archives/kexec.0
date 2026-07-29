Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78773C54F55
	for <kexec@archiver.kernel.org>; Wed, 29 Jul 2026 14:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eB8c193KoCNkyC5Nboc/hf64d3uhVb8xp38FM/W9Qug=; b=sxsURMsykUJ0hMfkYfGAdyYH57
	XeSkkyEWXfsZOpoT1c3YLxLsG3EOH4D0pU4WqQbZfG2uOt34ikXB/Lo2AerC0+Zo8XWk/PMCFYxXA
	hDK3ZrhPp/sraK6CkQESP9zgHGH9pma4K4aoKnXdWd9DdpbTWA3196bSnD3vqWfqMJO/ENsWvA3By
	H8E8nQDqfUL+p1kmdk/s7hh0GPLbx3xCAyNj2q15SLEm+SA3cgC6ANQYtsWbbqyzJZ8XLK0/M621u
	WOQG+N0lCWUfvoii5RsZo5ZeZurmuzuuvr48ayK2WmVXfliH1B8Ph3rW/LukEctb+T1LTgY1pD8Nb
	ZecVzu5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp5iH-00000008JEy-1K2B;
	Wed, 29 Jul 2026 14:56:53 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp5iF-00000008JDJ-17Hy
	for kexec@lists.infradead.org;
	Wed, 29 Jul 2026 14:56:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0B0A940DB7;
	Wed, 29 Jul 2026 14:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B837A1F00A3D;
	Wed, 29 Jul 2026 14:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785337010;
	bh=eB8c193KoCNkyC5Nboc/hf64d3uhVb8xp38FM/W9Qug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cmcDkLrd/1MzkczVxXfn8+N7BEZgaGnoK2Qul8jd38HbrcPnqqNA2scwqgczjzfqP
	 n2B3FvU1/BUI9Ng5WsXvZw58vm2gZf0aUM5+yHts+hJvDl47TZbDONnf0r0wXopNDF
	 kve/+Nk99KMzpl42bjjygebEvlKfnZ4inHN2Q/t25n2BEClogWCUT3caAa0gIhBZFU
	 T0hMFANNLSdB61yH98EOw0SVcnqGKuv9M/MgEdJAfp9xJnnulqeOgJ4oF9YjTh1swA
	 YZG0MOy/oYa354qkSNLXnCG8vHcFrFzUuM/qZ8u7ZRGWi7SRxNZ3BtWeeKKPyYR12g
	 LvEfCJvOqpC0w==
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
Subject: [PATCH v5 11/22] kho: allow destroying KHO radix tree
Date: Wed, 29 Jul 2026 16:55:56 +0200
Message-ID: <20260729145610.2827231-12-pratyush@kernel.org>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
In-Reply-To: <20260729145610.2827231-1-pratyush@kernel.org>
References: <20260729145610.2827231-1-pratyush@kernel.org>
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

Add kho_radix_destroy_tree() which allows destroying the radix tree and
freeing all its pages.

This is will be used by the upcoming scratch extension mechanism. It
creates a radix tree to track free blocks and then frees them after
telling memblock about them.

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 include/linux/kho_radix_tree.h     |  3 +++
 kernel/liveupdate/kexec_handover.c | 35 ++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/linux/kho_radix_tree.h b/include/linux/kho_radix_tree.h
index 4138621e0e87..66ca936b3f06 100644
--- a/include/linux/kho_radix_tree.h
+++ b/include/linux/kho_radix_tree.h
@@ -54,6 +54,7 @@ int kho_radix_add_key(struct kho_radix_tree *tree, unsigned long key);
 void kho_radix_del_key(struct kho_radix_tree *tree, unsigned long key);
 int kho_radix_walk_tree(struct kho_radix_tree *tree,
 			const struct kho_radix_walk_cb *cb, void *data);
+void kho_radix_destroy_tree(struct kho_radix_tree *tree);
 
 #else  /* #ifdef CONFIG_KEXEC_HANDOVER */
 
@@ -71,6 +72,8 @@ static inline int kho_radix_walk_tree(struct kho_radix_tree *tree,
 	return -EOPNOTSUPP;
 }
 
+static inline void kho_radix_destroy_tree(struct kho_radix_tree *tree) { }
+
 #endif /* #ifdef CONFIG_KEXEC_HANDOVER */
 
 #endif	/* _LINUX_KHO_RADIX_TREE_H */
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index a5800b960cf6..105dc0f3e691 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -301,6 +301,41 @@ void kho_radix_del_key(struct kho_radix_tree *tree, unsigned long key)
 }
 EXPORT_SYMBOL_GPL(kho_radix_del_key);
 
+static void __kho_radix_destroy_tree(struct kho_radix_node *root,
+				     unsigned int level)
+{
+	unsigned long i;
+
+	if (level == 0) {
+		kho_radix_free_node(root);
+		return;
+	}
+
+	for (i = 0; i < PAGE_SIZE / sizeof(phys_addr_t); i++) {
+		if (root->table[i])
+			__kho_radix_destroy_tree(phys_to_virt(root->table[i]),
+						 level - 1);
+	}
+
+	kho_radix_free_node(root);
+}
+
+/**
+ * kho_radix_destroy_tree - Destroy the radix tree
+ * @tree: The radix tree to destroy
+ *
+ * Walk @tree and free all its nodes.
+ */
+void kho_radix_destroy_tree(struct kho_radix_tree *tree)
+{
+	if (!tree->root)
+		return;
+
+	__kho_radix_destroy_tree(tree->root, KHO_TREE_MAX_DEPTH - 1);
+	tree->root = NULL;
+}
+EXPORT_SYMBOL_GPL(kho_radix_destroy_tree);
+
 static int kho_radix_walk_leaf(struct kho_radix_leaf *leaf, unsigned long key,
 			       const struct kho_radix_walk_cb *cb, void *data)
 {
-- 
2.55.0.508.g3f0d502094-goog


