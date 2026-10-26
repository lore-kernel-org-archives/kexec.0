Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABCA606A31D
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 23:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JjKiLGE2;
	dkim=temperror header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IQ31o5OD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=A7gX/m+u4UMJmVyrb0f8N/TE7LE/A9ZKgusas0I4Rm4=; b=JjKiLGE2zyYS16
	psmti8qoo4aNtbyXNIrnCdvVerDn1s6HLEgVo89iriBneREYZkAWGmuRSKMP/v5SAjuX1kR+JZ08J
	Q9K67Ig+Txc4jSEal/n0VPf6fH6zp1LZA5dGZGy3yAD/OEDv0zrMTEKcCFliVf5mFbzcLCu6rKBFn
	bkImZKRMsXzWZUY3v4syOnePKzP09DUs6i+3PsZxI8X9dgAcHt5ZWxWLSxE+Vw0Pk4qtrvbjw64BB
	VATZBgYAxXwcTNoMVtjL9HvsUUlc/jAft4MDK+aLlxv2qJxU/Nrbkk0C067jjY5DcM3NcFLFDkmxs
	uvJKRklO7Q4ylVpUtgnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLTzz-00000003PYQ-1SVg;
	Mon, 26 Oct 2026 23:21:03 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLTzy-00000003PYI-204T
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 23:21:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D9C7160213;
	Mon, 26 Oct 2026 23:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787021F01829;
	Mon, 26 Oct 2026 23:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793056861;
	bh=A7gX/m+u4UMJmVyrb0f8N/TE7LE/A9ZKgusas0I4Rm4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=IQ31o5ODFi1TCvdbW/Fvb4z47yUoIHd+cPWP+ynS5r1WhTWrbETdppp6UQPnNBNxh
	 z31WeGR52qpW+2aGvMOZCs5WeWoxLP88gk4YFAygcZc4ACUUX8DD2shjSLjzIEH4ww
	 m1+drTX7t/Pun8PbB7rJzwuns6/ninmkX9gfO2PwPlzwVjxssBxEQSKGnBVGupyQVY
	 /ojkBuUvvCBPKQq4m1tQZnwUwQmb1uRNIn7es3b6LdJo5PDEmJVN+FqgnyDzSBqZfC
	 JwiCAmYGedA2dLQJeDo2dtw5ETmwWJu0F1Chd28YsiHToKFXf9A+np6osHuygNVyd6
	 Ml1ekzN/YzLGw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 27 Oct 2026 00:17:30 +0100
Subject: [PATCH 10/46] mm/huge_memory: fix list corruption when
 deferred_split_scan() races with deferred_split_folio()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-fixes_core-v1-10-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
In-Reply-To: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, 
 stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3458; i=david@kernel.org;
 h=from:subject:message-id; bh=r5BGBHRo9GSa/DI+t01ntFYVkxTFpvO09xLdXSpMdfA=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLu35+idE7fMCKc/77ImbcKCVumnHE/1+sj9KHswaGDn
 hZPGvZc7ihlYRDjYJAVU2QJCr5v8PLlutpqNz5mmDmsTCBDGLg4BWAiHl8Z/octV9g4Uyis7u5F
 jiNybMWLTzh+1J55SfB7xavkONmzCfMYGRaeXdJmm+57kjNUJnZjr+fGhxucxVWlCw78WmCp27T
 wGxMA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since the deferred split queue became a list_lru, the isolate callback
moves the folios it took a reference on to an on-stack list, linked
through folio->_deferred_list, and deferred_split_scan() takes them off
that list with list_del_init() without holding the list_lru lock.

deferred_split_folio() does not know about the on-stack list. It only
holds the list_lru lock when it looks at the same list_head, and it can
run for such a folio: a THP is queued when it is mapped, as a candidate
for the underused check, and is queued "again" when a part of it gets
unmapped:

  CPU0 deferred_split_scan()          CPU1 deferred_split_folio()
  list_del_init(&folio->_deferred_list)
    next->prev = prev
    prev->next = next
    entry->next = entry
                                      list_lru_lock_irqsave()
                                      folio_set_partially_mapped()
                                      __list_lru_add()
                                        list_empty(item)  -> true
                                        list_add_tail(item, &l->list)
                                          item->next = &l->list
                                          item->prev = tail
    entry->prev = entry

The folio now sits on the list_lru with ->prev pointing to itself. The
next removal leaves the neighbours pointing to it, and they still do so
after the folio has been freed. With CONFIG_DEBUG_LIST:

  list_del corruption. prev->next should be ffd4000000270090, but was
  ffd4000000278090. (prev=ffd4000000270090)

Fix it by grabbing the lock around list_del_init() so
deferred_split_folio() cannot race with it.

Fixes: fafaeceb89a5 ("mm: switch deferred split shrinker to list_lru")
Cc: stable@vger.kernel.org
Reported-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/huge_memory.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index bd44d58e86845..4c0194af9016d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4522,8 +4522,7 @@ int split_folio_to_list(struct folio *folio, struct list_head *list)
  *
  * It is unsafe to call folio_unqueue_deferred_split() until folio refcount is
  * zero: because even when the list_lru lock is held, a non-empty
- * _deferred_list might be in use on deferred_split_scan()'s unlocked
- * on-stack list.
+ * _deferred_list might be in use on deferred_split_scan()'s on-stack list.
  *
  * The list_lru sublist is determined by folio's memcg: it is therefore
  * important to unqueue deferred split before changing folio memcg.
@@ -4665,10 +4664,22 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 					    deferred_split_isolate, &dispose);
 
 	list_for_each_entry_safe(folio, next, &dispose, _deferred_list) {
+		struct mem_cgroup *memcg;
+		struct list_lru_one *lru;
 		bool did_split = false;
 		bool underused = false;
 
+		/*
+		 * Sync with deferred_split_folio(), which can requeue the
+		 * folio once list_empty() is true, and sets PG_partially_mapped.
+		 */
+		rcu_read_lock();
+		memcg = folio_memcg(folio);
+		lru = list_lru_lock_irq(&deferred_split_lru, folio_nid(folio),
+					&memcg);
 		list_del_init(&folio->_deferred_list);
+		list_lru_unlock_irq(lru);
+		rcu_read_unlock();
 
 		if (!folio_test_partially_mapped(folio)) {
 			/*

-- 
2.43.0


