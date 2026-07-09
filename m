Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26173C43458
	for <kexec@archiver.kernel.org>; Thu,  9 Jul 2026 17:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dZrYQiJ29bguTf5G1/05HWK+MxMmFmBLRrxhZmbaDdk=; b=QJYr2rlCDTvx/JoPhxrqdbNrGb
	cc08GHgtBN/VFdeKYFjyD7mg28AJdk9kT/vvnVex9E2LyJYBEaTkESTkTlp1kwbUEddR/cIEvz2Zu
	RnyprP2jMEkVZ2XEOpckHp8Iwap1vp6H4KcMlUgQGI9E8spLm7YWErmcg43RBp/XQhS7pMrufgzr/
	hJ6FachgU9yE7/KPG0ptjQHcHXo7Qxvi7xCfVt1o++GyhlN5wxSI0UVHetJDUPikOJ0KJLLK/pm+b
	mhO416tC2hGWOCoMlb2aUfdM3aJfC9atFatJea4Rwa494LB+CgpTTXYZC2ANwfqOB5NimW4xU9ygB
	CexjE+HQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whsi7-000000038Bn-0euh;
	Thu, 09 Jul 2026 17:38:55 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whsi5-000000038AI-2XV1
	for kexec@lists.infradead.org;
	Thu, 09 Jul 2026 17:38:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 120166138B;
	Thu,  9 Jul 2026 17:38:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997851F00A3D;
	Thu,  9 Jul 2026 17:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783618732;
	bh=dZrYQiJ29bguTf5G1/05HWK+MxMmFmBLRrxhZmbaDdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N3qST223sfLQcdLUCumgNGqT1rNBeaftKWwMFJBNnkQ6p7LobmHP9UQf7gkut5Hwa
	 frQGl78LM7YpDCKcYypaVEg18SV+03j5mSz/q5Ykmo69+kwVKwiUMnBFpnM/5lflL4
	 eyqR00NFqyciItVQkCCbILPtv0KeM27+HBUrafLX8E7HD5CVKSQTnS3vaudkB3cYx1
	 5Au8w6IjYanFpidYYx18d5ewnHKjPe+aPONYHHpGWTovQ1RglaZPwIRMbkytuiaGW8
	 Y8uJknYsgRPfHYpeG6g2oyUkkmbRjI0e003G5vaOPijUv8Tx6+Mckx8p2GAY+PloKp
	 A90q/HySNLLAA==
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
Subject: [PATCH v3 08/21] kho: add callback for table pages
Date: Thu,  9 Jul 2026 19:37:57 +0200
Message-ID: <20260709173821.429921-9-pratyush@kernel.org>
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
2.55.0.141.g00534a21ce-goog


