Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF126606A31B
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 23:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fAOrjRQq;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oDfG8JRC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=yrWRwWI1TX1mcUZCYDX7YGV/LWEOTto0e1Zbca5EuMo=; b=fAOrjRQqGKTZHf
	0cGyBDlW3O/XcfkwtaDF15m2zthtTo2aUcZQzv4MpPP8JoIL5UEDBkHDfalSmm5UQnYR4l3hRkGI0
	yQkONVm5XI9l4jYAVNqx8mFazK4HRe+RpJI4knUly8g8HEjbQNTEYMWyTX0jo6bGQTaSSkkLEwCVn
	UJVbEbkdABAOPrtFF+pzlhzNRCf0ip/kt8rMI1i4fbvntfWb/jZifSzfX4/sh6gUSgiIXgr7x4+GE
	DFsTy578IcVKlBDfd9lN34+uFEeTUmGkQ7R0RHBCPpAK6VcVXW3pb/ogO4rdlyF1gj0NJ5rl3kTrA
	h5toBhW7+eYRAgp/0J4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLU2j-00000003QA4-25oL;
	Mon, 26 Oct 2026 23:23:53 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLU2i-00000003Q9j-0bo6
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 23:23:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A570E40C2A;
	Mon, 26 Oct 2026 23:23:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167181F01829;
	Mon, 26 Oct 2026 23:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793057031;
	bh=yrWRwWI1TX1mcUZCYDX7YGV/LWEOTto0e1Zbca5EuMo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oDfG8JRCj/HnI05JYJpdQeNsDVitwtOPsqwFt+Y3DiM5wFzRClDxE6A11o1/HZEfq
	 h14PPV5dH6x2rp1uZyFJOu841a10mxF/gCFopjhJg0X8cKhgjQFXxAMV+QRg5lD4V2
	 H9cn6S0rxc+ey7SCMwJe6uHugFTfTIZon+3EBRBaAQhBh+BZivcerCauhQJPkOFwq5
	 E8UaueuP28d3TSNTE4s0mf+KsJgxtw1fQ3t77075G5E1QAx7rIVJR0W1igJSkKKfOj
	 x9kkm86s2G0a5xY6JVZdpqPt7JLURP7bhcdXnG4ab/tq3//Tx9cB7jFElNIecScCS/
	 D3pNbzACczyFQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 27 Oct 2026 00:17:39 +0100
Subject: [PATCH 19/46] mm/gup: recheck the PUD under PTL in
 follow_pud_mask()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-fixes_core-v1-19-6f74bec9a5bb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3797; i=david@kernel.org;
 h=from:subject:message-id; bh=fBfRL/hNgbZlBR9ozQBVYIeZUTHsd1pHD95a8NK5vT4=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLu358qaqN8TWk+X4z5G7PV95qeTBPYdKVqHs+8GVlSn
 Zs3Z/+M6ChlYRDjYJAVU2QJCr5v8PLlutpqNz5mmDmsTCBDGLg4BWAiLK8ZGVa90jZ9XaiRe6wx
 UIDvpS/zseWK071r3z9OWBMnUfRSyp/hf6pW8DKR59oeHRuNv/kx/XzHZGF/3eTr79k1uXvqY1Z
 +5gQA
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

follow_pud_mask() reads the PUD without a lock. If it is a leaf, it takes
the lock and calls follow_huge_pud(), which reads the entry again, but
only tests whether it is present.

A leaf can be zapped concurrently and a page fault can fill the empty
entry with a page table.

This currently only applies when device-dax makes use of PUD entries,
and the fault after e.g., MADV_DONTNEED would find THPs to be disabled.

That requires a sequence like

1) Fault in the PUD
2) Disable THP
3) Have GUP race against concurrent MADV_DONTNEED + refault

Which is rather unlikely to happen in practice, which is why we never
received a report about such a problem.

Before commit 1b1676180246 ("mm/gup: handle huge pud for
follow_pud_mask()"), we performed that check in follow_devmap_pud() by
testing for pud_devmap().

Let's fix it by just structuring follow_pud_mask() similar to
follow_pmd_mask(), minus protnone stuff that does not apply and minus
FOLL_SPLIT_PMD handling. That makes it much easier to spot any such
inconsistencies.

Perform the pud_bad() check early in follow_pmd_mask() and just forward
the PUD value. We can drop the pud_present() check in follow_huge_pud(),
just like we have in follow_huge_pmd().

Even though we are performing more changes than strictly necessary, the
fix should be easy to backport.

Fixes: 1b1676180246 ("mm/gup: handle huge pud for follow_pud_mask()")
Cc: stable@vger.kernel.org
Reported-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/gup.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index f166acf794e30..efc9aa2654625 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -658,9 +658,6 @@ static struct page *follow_huge_pud(struct vm_area_struct *vma,
 
 	assert_spin_locked(pud_lockptr(mm, pudp));
 
-	if (!pud_present(pud))
-		return NULL;
-
 	if ((flags & FOLL_WRITE) &&
 	    !can_follow_write_pud(pud, pfn_to_page(pfn), vma, flags))
 		return NULL;
@@ -896,15 +893,17 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 }
 
 static struct page *follow_pmd_mask(struct vm_area_struct *vma,
-				    unsigned long address, pud_t *pudp,
-				    unsigned int flags,
-				    unsigned long *page_mask)
+		unsigned long address, pud_t *pudp, pud_t pud,
+		unsigned int flags, unsigned long *page_mask)
 {
 	pmd_t *pmd, pmdval;
 	spinlock_t *ptl;
 	struct page *page;
 	struct mm_struct *mm = vma->vm_mm;
 
+	if (unlikely(pud_bad(pud)))
+		return no_page_table(vma, flags, address);
+
 	pmd = pmd_offset(pudp, address);
 	pmdval = pmdp_get_lockless(pmd);
 	if (pmd_none(pmdval))
@@ -953,18 +952,23 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
 	pud = pudp_get(pudp);
 	if (!pud_present(pud))
 		return no_page_table(vma, flags, address);
-	if (pud_leaf(pud)) {
-		ptl = pud_lock(mm, pudp);
-		page = follow_huge_pud(vma, address, pudp, flags, page_mask);
+	if (!pud_leaf(pud))
+		return follow_pmd_mask(vma, address, pudp, pud, flags, page_mask);
+
+	ptl = pud_lock(mm, pudp);
+	pud = *pudp;
+	if (unlikely(!pud_present(pud))) {
 		spin_unlock(ptl);
-		if (page)
-			return page;
 		return no_page_table(vma, flags, address);
 	}
-	if (unlikely(pud_bad(pud)))
-		return no_page_table(vma, flags, address);
+	if (unlikely(!pud_leaf(pud))) {
+		spin_unlock(ptl);
+		return follow_pmd_mask(vma, address, pudp, pud, flags, page_mask);
+	}
 
-	return follow_pmd_mask(vma, address, pudp, flags, page_mask);
+	page = follow_huge_pud(vma, address, pudp, flags, page_mask);
+	spin_unlock(ptl);
+	return page;
 }
 
 static struct page *follow_p4d_mask(struct vm_area_struct *vma,

-- 
2.43.0


