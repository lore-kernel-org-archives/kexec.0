Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF77C54FCD
	for <kexec@archiver.kernel.org>; Sat,  1 Aug 2026 08:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qIP40ogFtBiVnUCuMm5h3Xm4LIuYWOirEQzH1R83Mew=; b=KcXQQkw6u7PJNsbezCz1AZvCHq
	eMBgL2FZZKK79lElnMEMAUm4YADJOUV37iZJnNs6GuPy+Qx6TYOF2dZuS+OMczYGxofoBpw/NPU5J
	fwQOCyijKhLxjevt5IIxlZDSZgSkUxQ5vcQaIA0MP9vY8+y7kyLnX3GQZPmIDjkDSW4qjaRxkzJqn
	1ak/xpuI2Pc59cfb5xg/ixnuDHUPtOiA3b0/AiV6ATEUc7Nxg9AzoAxb8nVu/A4WpaTDO7I7Nywyf
	jFatIvp0qhQQ6by8SKscMQU+0OGopIn04KL6JUeKIf12xmr/7d1ZvyknYi46QSIsA67TtQeQWybVL
	0eMehlxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wq5PP-0000000E4tS-2do0;
	Sat, 01 Aug 2026 08:49:31 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wq5PO-0000000E4sA-2V49
	for kexec@lists.infradead.org;
	Sat, 01 Aug 2026 08:49:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1AEE44529C;
	Sat,  1 Aug 2026 08:49:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09471F00ADF;
	Sat,  1 Aug 2026 08:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785574159;
	bh=qIP40ogFtBiVnUCuMm5h3Xm4LIuYWOirEQzH1R83Mew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JYbcsQdpPGh+2huXVDCcRwMp6Fu5lh3biUI41fTfLPX2V8yV5zvYxlXgf6NjueZzE
	 9T+5zCunRSXGJDmk2z+B61OjrHJ01KT4FZnQwShCshfMRs8wkOXIPPkqjkBcu4Gqsu
	 1WvyQ3G6Ds36kjcZIpzXUmgHVLFRT0e+P7h1EULlUA6aiTwhnmTlgQndsT8O5VVZlU
	 Q6ttTzKP2s5TJfyZTdY91EkOJD/o2SRm/KPqo7dh9WXDEtAEcsdgMKIi7qGPHkv2YY
	 g08jdCwyfxv7e4FhaKKWyfFpnlBCV2UwlaRDuOc0n+lEztHZ6KmPY5V/HfxIPeHOjn
	 l78TX1nEtlHNw==
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
Subject: [PATCH v6 11/22] kho: allow destroying KHO radix tree
Date: Sat,  1 Aug 2026 10:48:20 +0200
Message-ID: <20260801084833.1897543-12-pratyush@kernel.org>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
In-Reply-To: <20260801084833.1897543-1-pratyush@kernel.org>
References: <20260801084833.1897543-1-pratyush@kernel.org>
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
index 60c1246a9101..b7532aff35d8 100644
--- a/include/linux/kho_radix_tree.h
+++ b/include/linux/kho_radix_tree.h
@@ -58,6 +58,7 @@ int kho_radix_add_key(struct kho_radix_tree *tree, unsigned long key);
 void kho_radix_del_key(struct kho_radix_tree *tree, unsigned long key);
 int kho_radix_walk_tree(struct kho_radix_tree *tree,
 			const struct kho_radix_walk_cb *cb, void *data);
+void kho_radix_destroy_tree(struct kho_radix_tree *tree);
 
 #else  /* #ifdef CONFIG_KEXEC_HANDOVER */
 
@@ -75,6 +76,8 @@ static inline int kho_radix_walk_tree(struct kho_radix_tree *tree,
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
2.55.0.571.g244d577d93-goog


