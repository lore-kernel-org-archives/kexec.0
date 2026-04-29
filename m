Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36085CD1297
	for <kexec@archiver.kernel.org>; Wed, 29 Apr 2026 13:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wT8SHT65Xp8jPRIDHQJpTLiE6G4RyE+OJV6LG666YIw=; b=aqj17KM0bwr2jBqgYJGIzqVQ0Y
	ANqGgujdAy8RPMogmZ6cfoG5t26ztxIMQmjyptGeRnUj050UlQGBmNOmuxjjdGBy05FEUJ2IMXPQb
	zxuQVVSlLGSJj0NhukijXGyTAkYwiKEgPKot7CCAoCo0jB/YNx8S+5EQZWK7JvbjCIgZpgo2dp1WR
	UJME/I6tSdCGLEDj0TcTaX+9X/mdpbmL3MZlpt9LROUq6BLwdtFiD2YiIaIYurzYB/Q+y8hY/Xkhx
	jHsDg9mmLJrkPfzvUam2fJTgn8h89CoGc4EuEehqOAAYY+e6bb3UH5E+pHxzcEJbjuLnODkCmVczs
	Stj3GbKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI58v-00000003gVn-0u2c;
	Wed, 29 Apr 2026 13:39:57 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI58s-00000003gTc-2yFf
	for kexec@lists.infradead.org;
	Wed, 29 Apr 2026 13:39:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0112744500;
	Wed, 29 Apr 2026 13:39:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B84C2BCF5;
	Wed, 29 Apr 2026 13:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777469993;
	bh=sDZpiRzsQemL+9DqGDzdUHvJ8tPGWBEbveTIR7Y1hd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pJMgz7rANvW3gltIkCoxOmN4OeT/8No7Cp1LNZNgfeI0ERfnTBJV7X5VA9FsFlsBQ
	 AkoG4qksc3arluR9/BXwUeN2v8vDomDJR4s/cIZa61IvEufufumwfXANLiu0VTO9Ar
	 4/rks236tYY0G6/gif4nwLOVloLD0TccVWymjdpcOWyoEe4YaiOykti2NUgoYASke7
	 MhRh3K1y4/v+UR4paeYbNAfM3yinnlpo3/1VnW3jG/w+lW2cbiU+7I3kPHDGNCLOgj
	 IAN0zzX3m1ic3nirBkZDMHk++ARwWtCfZT1pisHHN79hfyYM3M01Lkc2epsT+rhWtK
	 /2IZuGHxw9WIg==
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
Subject: [PATCH 04/12] kho: add callback for table pages
Date: Wed, 29 Apr 2026 15:39:06 +0200
Message-ID: <20260429133928.850721-5-pratyush@kernel.org>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260429133928.850721-1-pratyush@kernel.org>
References: <20260429133928.850721-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_063954_792900_4249899D 
X-CRM114-Status: GOOD (  14.19  )
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
themselves as scratch. This is done to avoid a circular dependency where
preserving a page can lead of allocating other preserved pages. This
means any walker looking for free ranges of memory outside of scratch
areas will ignore the table

Add a table callback that is invoked for each table page. The callback
is given the physical address of the table page.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 include/linux/kho_radix_tree.h     |  3 +++
 kernel/liveupdate/kexec_handover.c | 12 ++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/linux/kho_radix_tree.h b/include/linux/kho_radix_tree.h
index 030da6399d28..fe7151d89361 100644
--- a/include/linux/kho_radix_tree.h
+++ b/include/linux/kho_radix_tree.h
@@ -37,12 +37,15 @@ struct kho_radix_tree {
 /**
  * struct kho_radix_walk_cb - Callbacks for KHO radix tree walk.
  * @key:      Called on each present key in the radix tree.
+ * @table:    Called on each table of the radix tree itself. Receives the
+ *            physical address of the page containing the table.
  *
  * For each callback, a return value of 0 continues the walk and a non-zero
  * return value is directly returned to the caller.
  */
 struct kho_radix_walk_cb {
 	int (*key)(unsigned long key);
+	int (*table)(phys_addr_t phys);
 };
 
 #ifdef CONFIG_KEXEC_HANDOVER
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 4a5d1b47799c..94ca831b41c9 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -273,6 +273,12 @@ static int kho_radix_walk_leaf(struct kho_radix_leaf *leaf, unsigned long key,
 	unsigned int i;
 	int err;
 
+	if (cb->table) {
+		err = cb->table(virt_to_phys(leaf));
+		if (err)
+			return err;
+	}
+
 	if (!cb->key)
 		return 0;
 
@@ -295,6 +301,12 @@ static int __kho_radix_walk_tree(struct kho_radix_node *root,
 	unsigned int shift;
 	int err;
 
+	if (cb->table) {
+		err = cb->table(virt_to_phys(root));
+		if (err)
+			return err;
+	}
+
 	for (i = 0; i < PAGE_SIZE / sizeof(phys_addr_t); i++) {
 		if (!root->table[i])
 			continue;
-- 
2.54.0.545.g6539524ca2-goog


