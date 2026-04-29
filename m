Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 488CBCD1297
	for <kexec@archiver.kernel.org>; Wed, 29 Apr 2026 13:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m+blxjhrsDzVQ4iNicwy10DCQOi4Qd3nXw1DYWinz3o=; b=h45wnudM7T7NcfCTZSyCEu6e/3
	Xe2M/w0A5BULQnc3LfaXo4HEnc2D4cYl3ILMqnQNBFX65j4fqmauYbpqg+c4YdObvu01tyWAX1jSn
	JI1VBAvvXrfAOTTDEAp48/F+OnGdordTOI/0C8XjyKEUAM7p+Cdf+srcbN+lc9ctAXdb7vzTLEn9e
	DeeFUc+bj/74Qq34M+UCzeXP7hlqEAAthyxudcXCqvi1N4zyrfa8yVYofZC+kgARLuPe0b31/r7pv
	xJg9++FRpjyRexMCTdnUeBT3DpXFLnL2a9rE29BNGUTrC2N2OmbIJAHuPmBH+5QPZiCYvoP31M0Lo
	eZxVkerw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI591-00000003gbL-1LNJ;
	Wed, 29 Apr 2026 13:40:03 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI58z-00000003gZy-2X2F
	for kexec@lists.infradead.org;
	Wed, 29 Apr 2026 13:40:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1042761141;
	Wed, 29 Apr 2026 13:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC26DC4AF0C;
	Wed, 29 Apr 2026 13:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777470000;
	bh=HqMJ+mPvIVL4QAOFwn1zIYXnpFxqWfIvpXCdlh2p4qU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ibdizt7xQYLkjEzH1nGZoM2Q2T4NkpbCLjWvPZ9hNm2X5NsnDPnvpqQBJjTlbT9dL
	 QBe3QjWdKeP2QZTXoyeSAOChz4Ll1VBJkR2KJGURRTLWFjh52CBL46EvTTfoo/5JjE
	 HVRm5PcCxAWD8IelTrmisEN0L6+GjArxEV+FojzkVcdhW2/ufSpz/qsQmv+nFjnIrV
	 IbjcQXh8OhwLfVogeo1Tee4Iq9+WrlFVqFmMgxk+MJrbM1qNrRkLNTUtC8+WK+zFbV
	 ToH5+gctoY9A9KQcAadyk685ODGF7asEt9cK90AvI82wN7ScbyPoPxYTScE9/q41TQ
	 SoUy5n+oPnK6A==
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
Subject: [PATCH 07/12] kho: allow destroying KHO radix tree
Date: Wed, 29 Apr 2026 15:39:09 +0200
Message-ID: <20260429133928.850721-8-pratyush@kernel.org>
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

Add kho_radix_destroy_tree() which allows destroying the radix tree and
freeing all its pages.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 include/linux/kho_radix_tree.h     |  3 +++
 kernel/liveupdate/kexec_handover.c | 34 ++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/linux/kho_radix_tree.h b/include/linux/kho_radix_tree.h
index 6c0f7d82716b..617395a6647a 100644
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
index 47f7c4a2865e..29479534f65d 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -286,6 +286,40 @@ void kho_radix_del_key(struct kho_radix_tree *tree, unsigned long key)
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
+}
+EXPORT_SYMBOL_GPL(kho_radix_destroy_tree);
+
 static int kho_radix_walk_leaf(struct kho_radix_leaf *leaf, unsigned long key,
 			       const struct kho_radix_walk_cb *cb, void *data)
 {
-- 
2.54.0.545.g6539524ca2-goog


