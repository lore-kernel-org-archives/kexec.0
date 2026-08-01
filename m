Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA3C6C55174
	for <kexec@archiver.kernel.org>; Sat,  1 Aug 2026 08:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JrkBED7KT85yC/ETBmppqUy4I2mZbe+o6Vny+4DxgfI=; b=MJeUHlzo4CB4PWXtZ+IdHzwUzO
	lcULDFFkDnmaU1Q1krJpsR2El6mTMT/gBQ3w8j+GqKkH49E4LtrlUtxXjP49rvVROHyNp/AiuSdd5
	+rngYH0/ZvzvCv2u9YUQxSGgXZ1KWZToS4zpIco+l/NcVHRkaQrj7WyJAwqRRbB77nAG3OAqHNlvC
	ueM4flNu+5yiPDUrNTIMLsEIad94cY37My8gC6OtKJXVqo8zsntzoBgigzN+QyzOoliUd1VjBFylK
	4XNHk/IMrXHhCBR7ezgXU0XeYH6TbzUatnU30lThM39X6VbihmYsje4Nym2wfsxo/tP6YYdBUOIOb
	xcKTYPiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wq5P8-0000000E4g4-3t4x;
	Sat, 01 Aug 2026 08:49:14 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wq5P7-0000000E4eF-0Xpq
	for kexec@lists.infradead.org;
	Sat, 01 Aug 2026 08:49:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9051B600D8;
	Sat,  1 Aug 2026 08:49:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA141F00ADF;
	Sat,  1 Aug 2026 08:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785574152;
	bh=JrkBED7KT85yC/ETBmppqUy4I2mZbe+o6Vny+4DxgfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fH7Q9Co90aLn4pZHLfAZHKWfqeqMxQkiyoH0OPMw0VHVNMpmMphb886dRHxBjKgyk
	 hgCD4TLiEdm/3FbUPTjPzskFtd81SO3AmO5HJEPLc09YD5I7EmU1BvxrUfXG6xluy4
	 d5KTBFzhuXUaKHTUqv94YyJTI9s++Vn6u1v55WZyuMnRZLGvWzNn0o/EVBDGPicrhE
	 FZNmgaehyZ3MDXkbnqxoHPUenEKjq384GWwLMNXI+QYkAfbQ0rSEY/7vlTg6+7V9aM
	 xmv3NYt8uCvxni9qfkiA0qJ2J4SL5uMrQ0OlnN7wRzedD7AjxrJCXBY3R8gOuEgE2g
	 U+X35ATmQq3Dg==
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
Subject: [PATCH v6 08/22] kho: add callback for table pages
Date: Sat,  1 Aug 2026 10:48:17 +0200
Message-ID: <20260801084833.1897543-9-pratyush@kernel.org>
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
index 486e193d58f4..902bbeddcbb7 100644
--- a/include/linux/kho_radix_tree.h
+++ b/include/linux/kho_radix_tree.h
@@ -41,12 +41,15 @@ struct kho_radix_tree {
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
index 9fb07c0ef18e..2044f35cf1de 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -288,6 +288,12 @@ static int kho_radix_walk_leaf(struct kho_radix_leaf *leaf, unsigned long key,
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
 
@@ -310,6 +316,12 @@ static int __kho_radix_walk_tree(struct kho_radix_node *root,
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
2.55.0.571.g244d577d93-goog


