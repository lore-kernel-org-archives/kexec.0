Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C395CD6E7C
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 18:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qTphUicBGxw+ljeZ1ORDyDZbANnd1GB5XieWEaaUYI4=; b=wZhgi/5S6v6TtcnptKoEDEkjxo
	Bh+W56W3VJYkPx3lIVdU3JOSnK7c8OcxrQ1F6QntR0U3I0JOmjEFwPBbHdLyI62tIiro/hO2mneQr
	02hrFl5NpRLEnFcEmtXLT+TdRtjzPLfwtm7Lil0mlHHZczdzMUd10pS5mHl6Imx3eaphvEMgYVQH3
	zM0v6fVHO0YS07Yf6eP0A/11G20KCnZmL8ksILtqs9FnSYX3oEru6ldMikTyteQFEdDz7NfgOiFkb
	5oV3805b6KCzyr+IeQuxvHnWh+LvOnfpmSM9erPNxlpMIHj17kSPq4D2iMgEtSmsraC4vB8KfXUcE
	i0q6YqVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVZOK-000000013Gp-3f0Z;
	Fri, 05 Jun 2026 18:35:36 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVZOJ-000000013F0-1Gv8
	for kexec@lists.infradead.org;
	Fri, 05 Jun 2026 18:35:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id AD13A4436E;
	Fri,  5 Jun 2026 18:35:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1E61F00893;
	Fri,  5 Jun 2026 18:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780684534;
	bh=qTphUicBGxw+ljeZ1ORDyDZbANnd1GB5XieWEaaUYI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CsY8nuFvQ+DgMmh65ei90bv2MYJd/hBWXIrE9XLIGEI3BzPrS55ccke1KugAEMr2q
	 fsdWabsyi+i/ee4Z8u2T9dKUwYd58AyFTYmr8UnT42taM0KChOZBTjJOdeQQi6jlFC
	 3EsQ31i+xm4ZWUiNYAUZfxIQ9gGyeaX3srtIp1duNND4yxhs38ecdPxADjb0OQ53iW
	 jqRJKAnYn9hBvxXyDSO7OaF5gChGb97hTvdJLZq8vTswF3ve9ZfWZpDjeyMBalUmEq
	 P+h7YcomJuRpKPQ/Np5eVsDVoF2nrAmnq1Wvqelv8Fas9UhoJi+Xw/UPi/z1DMoFtZ
	 ABTaW9NCd4zXQ==
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
Subject: [PATCH v2 09/18] kho: allow early-boot usage of the KHO radix tree
Date: Fri,  5 Jun 2026 20:34:42 +0200
Message-ID: <20260605183501.3884950-10-pratyush@kernel.org>
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

The KHO radix tree allocates memory for table pages from the buddy
allocator using get_zeroed_page(). This is not available in early boot
when memblock is still active.

Using the radix tree in early boot is useful for KHO to track metadata
about its memory. One such example is for tracking free blocks for
memory allocation when scratch runs out of space. This feature will be
added in the following commits.

Add kho_radix_{alloc,free}_node() which allocate and free the table
pages. They use slab_is_available() to decide which allocator to use.
While slab_is_available() indicates availability of the slab allocator,
it gets initialized right after buddy so it serves the same practical
purpose.

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index b890a69bddd5..452b4dcdf2d2 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -143,6 +143,26 @@ static unsigned long kho_radix_get_table_index(unsigned long key,
 	return (key >> s) % (1 << KHO_TABLE_SIZE_LOG2);
 }
 
+static void __ref *kho_radix_alloc_node(void)
+{
+	struct kho_radix_node *node;
+
+	if (slab_is_available())
+		node = (struct kho_radix_node *)get_zeroed_page(GFP_KERNEL);
+	else
+		node = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
+
+	return node;
+}
+
+static void __ref kho_radix_free_node(struct kho_radix_node *node)
+{
+	if (slab_is_available())
+		free_page((unsigned long)node);
+	else
+		memblock_free(node, PAGE_SIZE);
+}
+
 /**
  * kho_radix_add_key - Add a key to the radix tree.
  * @tree: The KHO radix tree.
@@ -191,7 +211,7 @@ int kho_radix_add_key(struct kho_radix_tree *tree, unsigned long key)
 		}
 
 		/* Next node is empty, create a new node for it */
-		new_node = (struct kho_radix_node *)get_zeroed_page(GFP_KERNEL);
+		new_node = kho_radix_alloc_node();
 		if (!new_node) {
 			err = -ENOMEM;
 			goto err_free_nodes;
@@ -222,7 +242,7 @@ int kho_radix_add_key(struct kho_radix_tree *tree, unsigned long key)
 err_free_nodes:
 	for (i = KHO_TREE_MAX_DEPTH - 1; i > 0; i--) {
 		if (intermediate_nodes[i])
-			free_page((unsigned long)intermediate_nodes[i]);
+			kho_radix_free_node(intermediate_nodes[i]);
 	}
 	if (anchor_node)
 		anchor_node->table[anchor_idx] = 0;
-- 
2.54.0.1032.g2f8565e1d1-goog


