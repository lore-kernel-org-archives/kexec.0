Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BF6606A31A
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 20:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=sh6YDJP9;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oVdw61b8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=hUEcnN9ydaxDMlr7FSPNgc2BgiAcB7rSVu3xqMV261g=; b=sh6YDJP9IAb7PU
	a2Lx+CWtd8Xc66jFJeHpNUTpur56nrMFWEgj81fyvpPwE4fAu7jDYxpc3Y83EsGeddqIRJNBqPCe+
	BgGcbdvt5llbPJMrrL4yN+ugy0wzm9+QCTkchxtSPxmideuf2tgIw5WNHODUBCfFQXkjoDZGeWQNo
	z5SqWj8jGsHN1Kd2nwBdu7yZkDCaNlz/AC9ZvTfxiSZ/uqp2CtReXpRBqDf0s90A0WaTWlsXtRPJZ
	O4hhCN5JCCZJ5Q+aJlH+MpPRNBQmF86bM9Pcl2cPKGnlS34k7NztJXpNpO04+upqCSLFqbg5dWHsJ
	4mivyVUZQHgJr9cDA6tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMWtW-0000000ALL2-1oIV;
	Thu, 29 Oct 2026 20:38:42 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMWtU-0000000ALKu-1hGS
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 20:38:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1EBB140730;
	Thu, 29 Oct 2026 20:38:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF331F01825;
	Thu, 29 Oct 2026 20:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793306320;
	bh=hUEcnN9ydaxDMlr7FSPNgc2BgiAcB7rSVu3xqMV261g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oVdw61b8fprlozgBHncc41LpdVLG5SLHt1W2WOHHdwpmEHY1UxuvvBPOvqfUxJ6TE
	 ypj1G/DGtqCz4M/Mncb0zLIyJD7YZU5Q9CwKBWyL9J9dnBrvu/xczhapnmY6bqMauH
	 cFW+yKoFtTCsaGgX0DaGpv7jF2hxRsfJnJ0YRpK3Cjo5KggitCplBM2+XWYS/AUOMh
	 5Qtft9UTttmKosFmaVLBtNXQus22sqElhihxeqFdjS/65EW05g7NDzHOAN3aITVvcf
	 pDVlw7VhPB6Fkbvk3twLQO4Jx+uPVK41BSLLOJJbyUqRT/3NwuiE1YXtG+OOAUcs+j
	 AEGV44bySO/jQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 21:33:16 +0100
Subject: [PATCH v2 21/47] mm/gup: fix out-of-bounds write for nr_pages == 0
 in GUP-fast
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-fixes_core-v2-21-a64ce7f83abb@kernel.org>
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
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1263; i=david@kernel.org;
 h=from:subject:message-id; bh=nCaomD0R1GmRaMbC4ikA/oDPAe1RZtNKP6V5LWq8bsk=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIer227ZSqbsjfo/PkOsbOhrnde/K8U2hdmLqwoELi84
 uqRtBdJHaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAEzk8WlGhuutW1yb5HykeVbc
 c+eWPREaIBpb4SyWKbC8rZtNv2v1F0aGKVM/LJjuEBViqMyy/c3RD1erLQu2rvZ/6eWeIbAgyci
 XEwA=
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

With nr_pages == 0, GUP-fast still enters its page table walk and can
write past the caller's page array. The old end <= start check caught
empty ranges, but was replaced with an overflow check.

Users such as OrangeFS can pass a zero page count derived from a
userspace-supplied length. So let's return zero for nr_pages == 0 before
starting the walk, just like GUP-slow.

Fix generated by an LLM and sent by Chris Mason in private.

Fixes: c28b1fc70390 ("mm/gup: reorganize internal_get_user_pages_fast()")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[ david: simplify description ]
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: Muchun Song <muchun.song@linux.dev>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/gup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index cc4fa18783ce..1c2ac7c66c30 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3215,6 +3215,9 @@ static int gup_fast_fallback(unsigned long start, unsigned long nr_pages,
 				       FOLL_PCI_P2PDMA | FOLL_HONOR_NUMA_FAULT)))
 		return -EINVAL;
 
+	if (unlikely(!nr_pages))
+		return 0;
+
 	if (gup_flags & FOLL_PIN)
 		mm_set_has_pinned_flag(current->mm);
 

-- 
2.43.0


