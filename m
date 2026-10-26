Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6FE606A322
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 23:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HFfOVAHp;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eh+x/TWR
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=+MnAvX+qI+mYQxA2fVfQg376k8J/xzQVFinnmk0GIyE=; b=HFfOVAHp2/O1ht
	vjKg3oddSGtc2ePgD3iJunpDP20hWyaWzuC/9AQ53mbZuQnK0hZLBta7tG5tpCZOQBhWuCtWRf6Hi
	s1fb0wY/niqTiMBtjHRR5YTy8N5w3VZ/JK5QBH1YXnY46F01QNzZCJNEK/8jxNVemO/1NzGqw3h0E
	F9hkyIytubdIJGxI+7jkGmS8489IfRo67syVCUe6YIzIxfmJrFY+G/DxlaqrB1k3S1km3HqI31I+C
	Rmo+MrwLtDvCeaTitu9vxxjaklY0EHGpm6dhKhtcYGpaSAWhuqjmjLmanQ+ZL/wglBfSR7SGjPCAI
	P0P2wM1Tynwohs60h0iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLU0u-00000003PkX-2rnY;
	Mon, 26 Oct 2026 23:22:00 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLU0t-00000003PkP-1Z3U
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 23:21:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C88DA601F9;
	Mon, 26 Oct 2026 23:21:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C2A1F031E0;
	Mon, 26 Oct 2026 23:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793056918;
	bh=+MnAvX+qI+mYQxA2fVfQg376k8J/xzQVFinnmk0GIyE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eh+x/TWRFS/iJ1o5pPJTPgSPhjIqgQS3EpnhiXcdC9m89yLc/rPs+Ad+DvKTl1fG9
	 NRD+KHiMvg3Fzyf/Biyf6XapfStao2hkfGuVGecEOmPxP8jclyVfkwrKJruvRdUs+b
	 jgvMBNz+MQPmFzhlPEUeSLiIlV1kPYlpWFUelDXGXk0JoUAD6JwZqJlTU62Nccn1oR
	 Ish/vEaxWz1T3FoN8J0XkU0rKmk3p37d0dFOsvpnab3UoD9KeVrVEvHAMpSewlf2oV
	 k4+XinYlqn4Ci8QY+xQlfrqejBbu4gtWkoxgMIe7o06wca6Os8beRZYY8j96gLJLvQ
	 h/YnvNHUxuzcw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 27 Oct 2026 00:17:33 +0100
Subject: [PATCH 13/46] mm/huge_memory: fix truncate racing with PMD zapping
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-fixes_core-v1-13-6f74bec9a5bb@kernel.org>
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
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2193; i=david@kernel.org;
 h=from:subject:message-id; bh=lNkOF7790rj6TmUsBd+4scX6XFv84q64jJb19qNwUOE=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLu35/yUmPX2heKb2tWBnBHR7/sl4lR76kT65hrKpod8
 jbVfk5yRykLgxgHg6yYIktQ8H2Dly/X1Va78THDzGFlAhnCwMUpABNx8mb4H170dtHjpOPPY/IK
 t/y9WbzDQ3XOugP26i8L/Wec3XLw5QVGhgv5CutulWXVTX7GdSZnmW4UC+tXA8OLM+w6eS23l7s
 EsQAA
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

From: Chris Mason <mason@kernel.org>

zap_huge_pmd_folio() removes the rmap before calling folio_mark_dirty().
If this was the last mapping, truncation can skip unmapping the folio
and proceed without waiting for the PMD lock, racing with dirtying.

ifs_set_range_dirty() can oops if MADV_DONTNEED races with
ftruncate() on XFS, when we get the folio set dirty after it was found
to not be mapped anymore.

Move folio_mark_dirty() and folio_mark_accessed() before rmap removal,
matching the PTE zap path. This keeps the folio mapped while updating
its state, so truncation must wait for the page table lock.

Fix generated by an LLM and sent by Chris Mason in private.

Fixes: fe6cf984939d ("mm/huge_memory: transfer the pmd dirty bit to the folio on zap")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[ david: simplify comment and description ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/huge_memory.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2b31a425c7a32..eda020dd6e33f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2495,6 +2495,14 @@ static void zap_huge_pmd_folio(struct mm_struct *mm, struct vm_area_struct *vma,
 {
 	const bool is_device_private = folio_is_device_private(folio);
 
+	/* Transfer young+dirty while the folio is still mapped. */
+	if (is_present && !folio_test_anon(folio)) {
+		if (pmd_dirty(pmdval))
+			folio_mark_dirty(folio);
+		if (pmd_young(pmdval) && likely(vma_has_recency(vma)))
+			folio_mark_accessed(folio);
+	}
+
 	/* Present and device private folios are rmappable. */
 	if (is_present || is_device_private)
 		folio_remove_rmap_pmd(folio, &folio->page, vma);
@@ -2504,12 +2512,6 @@ static void zap_huge_pmd_folio(struct mm_struct *mm, struct vm_area_struct *vma,
 	} else {
 		add_mm_counter(mm, mm_counter_file(folio),
 			       -HPAGE_PMD_NR);
-
-		if (is_present && pmd_dirty(pmdval))
-			folio_mark_dirty(folio);
-		if (is_present && pmd_young(pmdval) &&
-		    likely(vma_has_recency(vma)))
-			folio_mark_accessed(folio);
 	}
 
 	/* Device private folios are pinned. */

-- 
2.43.0


