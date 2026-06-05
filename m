Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8767ECD8C83
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 18:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=//G582QmL83eTkSHOXL243u6P2jYvjAZreKxz5CziEA=; b=XAbxGijnxq8tXjD82rUXvrjuKG
	DZpzEf9Nj8yZWTrbzwQT+aen0zC7Hv7nEhfvpIPDj1frVb/m8UgaTuWhKuKEvg5yphp3IUflFFQEN
	Zhvm4+qMK97vrOFzNNDkA1kPF07c6SiUdqeLN71tkJ9xvkY/pw8b3WJvsL1zbyowfUcGdAiZ/JHAY
	hBzXoSnYTYABviYGY3Lr4qG/Ji6U75H6q9kupLtQnmsaqioiGQfAtVCZ/KRcf9xhGiOcXG1ZPxCbq
	a5pOGzyNG0tM2ET81JtxNAskcaSfGWhwYKNIKVqS0UbJ+RXz+5rlgYPV6ijXehaABPUwnEsm0xV/e
	lZsgpa0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVZOG-000000013D4-2deV;
	Fri, 05 Jun 2026 18:35:32 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVZOE-000000013BG-3Y1Y
	for kexec@lists.infradead.org;
	Fri, 05 Jun 2026 18:35:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EB93960204;
	Fri,  5 Jun 2026 18:35:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7C21F00899;
	Fri,  5 Jun 2026 18:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780684529;
	bh=//G582QmL83eTkSHOXL243u6P2jYvjAZreKxz5CziEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CgCduHIBqIPIikUteN8s7UcrkafZ328qitJTMRx9Gja3CtmQtqozZSz1Zo1cI3Q4a
	 0mf/tCWCSTcijpLqHNl9TEhAutmrsCk9GRJ+SYcGitEs482y4PCrL1BVdLCOEG9Nw4
	 5czURS+nx7/D/QTH4gdNW3LVBzzZLdXwdHsDgxSUn2+44JmtFlaUo9q6aiDvBG+Lgb
	 qPA/1r89XudaEhwvOQFP0XGpFLG7C2ZCEeP6SmQ0AYVC9gh3MrgQoPi/Kr2z+gUrHP
	 JdsoPk7nqhko/8Pvm3dp/u6IoE848ykhluss6wPDk/Al0xWHheka8i27MJ4VZZAOi3
	 LRjysH+vsMxAA==
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
Subject: [PATCH v2 07/18] kho: add callback for table pages
Date: Fri,  5 Jun 2026 20:34:40 +0200
Message-ID: <20260605183501.3884950-8-pratyush@kernel.org>
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

The KHO memory preservation radix tree does not mark the table pages
themselves as preserved. This is done to avoid a circular dependency
where preserving a page can lead of allocating other preserved pages.
This means any walker looking for free ranges of memory outside of
scratch areas will ignore the table

Add a table callback that is invoked for each table page. The callback
is given the physical address of the table page.

This is useful for the upcoming mechanism that discovers blocks of
memory with no preserved pages and lets them be used for boot memory.

Another use case is for users of the radix tree other than KHO itself.
The radix tree does not preserve its own pages due to the circular
dependency described above. But external users of the radix tree would
need to preserve and restore their pages for the radix tree to survive
past early boot. They can use this callback to do so.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 include/linux/kho_radix_tree.h     |  3 +++
 kernel/liveupdate/kexec_handover.c | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/kho_radix_tree.h b/include/linux/kho_radix_tree.h
index 426a9cc9bcde..ac7ba7e567e1 100644
--- a/include/linux/kho_radix_tree.h
+++ b/include/linux/kho_radix_tree.h
@@ -37,12 +37,15 @@ struct kho_radix_tree {
 /**
  * struct kho_radix_walk_cb - Callbacks for KHO radix tree walk.
  * @leaf:      Called on each present key in the radix tree.
+ * @node:      Called on each node of the radix tree itself. Receives the
+ *             physical address of the page containing the node.
  *
  * For each callback, a return value of 0 continues the walk and a non-zero
  * return value is directly returned to the caller.
  */
 struct kho_radix_walk_cb {
 	int (*leaf)(unsigned long key);
+	int (*node)(phys_addr_t phys);
 };
 
 #ifdef CONFIG_KEXEC_HANDOVER
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index dbe075348ce4..94f18fe42c4b 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -285,6 +285,12 @@ static int kho_radix_walk_leaf(struct kho_radix_leaf *leaf, unsigned long key,
 	unsigned int i;
 	int err;
 
+	if (cb->node) {
+		err = cb->node(virt_to_phys(leaf));
+		if (err)
+			return err;
+	}
+
 	if (!cb->leaf)
 		return 0;
 
@@ -307,6 +313,12 @@ static int __kho_radix_walk_tree(struct kho_radix_node *root,
 	unsigned int shift;
 	int err;
 
+	if (cb->node) {
+		err = cb->node(virt_to_phys(root));
+		if (err)
+			return err;
+	}
+
 	for (i = 0; i < PAGE_SIZE / sizeof(phys_addr_t); i++) {
 		if (!root->table[i])
 			continue;
-- 
2.54.0.1032.g2f8565e1d1-goog


