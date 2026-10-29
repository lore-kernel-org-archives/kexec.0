Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A1B606A338
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 20:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rqrR80Sc;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EiymOOf1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=5LChJhAJsDDfexlAYHKUAVHUVDc3GJJuoMEB5JjLFT0=; b=rqrR80ScByyqFZ
	V0P9yMieGrELvJhwFrVy5Uxl/pnV+QzzB1a6JctgcuJSs1WvUIMiLywLrvfRMDmcpXUYxNIDdtzq+
	6BaHRddgKl8EkJEKqdUSz/asCTIvUGmeHU9gJHtEvw0zCyMrihyg6NXuxSljwe+8MhrYfcroyHmXt
	2EzlPssc5Fg1Lt6w8XcHsy/JD2bj523u1t5zKY2eS6O2YsrQs97KsYHp1QBzofpAEcFHvz+1Y+paH
	5ETb2pxhCUgJBo5NUd87n3Y2IVtPYMTLCFcGcCS8kiUeuwHlbjN3KASMRnSDnLjYPmJnFTxJio+AX
	P+yDhuH9kpdnnTm7YW2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMWtH-0000000ALIU-1TkV;
	Thu, 29 Oct 2026 20:38:27 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMWtF-0000000ALIM-2zkf
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 20:38:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 755C5402EE;
	Thu, 29 Oct 2026 20:38:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB90B1F031E1;
	Thu, 29 Oct 2026 20:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793306305;
	bh=5LChJhAJsDDfexlAYHKUAVHUVDc3GJJuoMEB5JjLFT0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EiymOOf1SFIZR07XNBmBtHsUG0/cxXyG65vmryJObOllY9qU0p8fGOUCf9T0+Blo4
	 iuWy5eRyHj0IegzchsZXQD5nozYmCXJ5q1tsWQ0Pc/FYEqnMkThdZp+/zgPF7cbvsw
	 4fT9qHtqSTab/Az1DiexmECSM1KXraeGktomLCs5OoqCWztAfj2WpEt+lSYnm9DMEc
	 kaWnMTeNameuxW6FWQesNXBe1C5PlKeVObJRyok+DLAT6FKviiUGSnCw8Kf7bALfL/
	 R4xYIxQLXDB/0dNyiXHgI14izBnV0Cj3NTEMEO6yOvFAYKUjGO1r6sZe2UYAavVeFq
	 3n5M6kwtAAStw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 21:33:15 +0100
Subject: [PATCH v2 20/47] mm/gup: fix clearing folios in memfd_pin_folios()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-fixes_core-v2-20-a64ce7f83abb@kernel.org>
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
In-Reply-To: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
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
 Samiullah Khawaja <skhawaja@google.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1672; i=david@kernel.org;
 h=from:subject:message-id; bh=a21vFMarzFqHDX4BmPSywjRcawxjg3B/znX9a9fmuWg=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIer21b4iudU8XlwJNx/Lt78dXMqeZrmIou3DJ7uVzhx
 wTzd0U8HaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAExkxUZGhsOfD82yeXHR80KQ
 up/Hmckh/E+sHj0KWM/QuapkQcoXNj1GhhvSVyfdzJlY0VR7+vnOucwCMvL2SZ9a07fNPzllOps
 DIzMA
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chris Mason <mason@kernel.org>

memfd_pin_folios() pins folios obtained directly from the page cache
without checking whether they are uptodate. However, shmem fallocate()
can leave newly allocated folios uncleared and not uptodate. Callers
such as udmabuf can then expose uninitialized memory to userspace.

Clear non-uptodate folios and mark them uptodate under the folio lock
before returning them to the caller.

Fix generated by an LLM and sent by Chris Mason in private.

Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning memfd folios")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[ david: simplify description and comment ]
Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Tested-by: Samiullah Khawaja <skhawaja@google.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/gup.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index f809361227e7..cc4fa18783ce 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3527,6 +3527,20 @@ long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
 					goto err;
 				}
 
+				/*
+				 * fallocate() can leave folios in the
+				 * page cache that were never cleared.
+				 */
+				if (!folio_test_uptodate(folio)) {
+					folio_lock(folio);
+					if (!folio_test_uptodate(folio)) {
+						folio_zero_range(folio, 0, folio_size(folio));
+						flush_dcache_folio(folio);
+						folio_mark_uptodate(folio);
+					}
+					folio_unlock(folio);
+				}
+
 				if (nr_folios == 0)
 					*offset = offset_in_folio(folio, start);
 

-- 
2.43.0


