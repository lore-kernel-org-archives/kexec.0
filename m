Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3FF606A32D
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 20:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dEXu2ROg;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TBb3ZJbC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=t7RYg5h2D7p8QXMl+okHSyCLmxQpieD4Ay9U30Ul4Os=; b=dEXu2ROgaWbQdn
	HP0jy1zNUBuoNz1B2xLg8OZpoQTMJUHGW2D44fJkCKGtjBmbje7sdrpvkDKHsP2PVPsXpKy9W4bDr
	lelmQbU7wLuMMmCnd+sglKwbIsqf8//HJt+vAStx1IKV/LBDiBPbtTJcExDdRmTIn6qWr1h4T/yQT
	DW0x0s08pm5xkej+pilQ8Y45w3PUdLnE4r1w1eRIGQCFHJP4BhjKcu0uCwM1vsjA2FUy24pllgD70
	XZM/jC9vnYmc09t1wi1d5eCnK73zCJgA4MXI3WsFLt5aH7V8vfExondxiGTLL+YEDAabODmeRXjZC
	aV5I/5dXwO10sxTN1wDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMWx3-0000000AMC7-0dq9;
	Thu, 29 Oct 2026 20:42:21 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMWx2-0000000AMBv-3ix8
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 20:42:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 94E9941A18;
	Thu, 29 Oct 2026 20:42:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6521F01828;
	Thu, 29 Oct 2026 20:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793306540;
	bh=t7RYg5h2D7p8QXMl+okHSyCLmxQpieD4Ay9U30Ul4Os=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TBb3ZJbCQasNHJ9vehOgkMBuvVuxUnA36Qy5qE1aq+MkrIUVvYyQfmLsrZ1G2wl5K
	 W5zLXmeYPlK7j17PamK961yty+mZimw5UxdunC19gNXpSQa7Y3AOY6CLlkyWTzMdY2
	 /DGe1y8MXhbxfngyG9fv1FgTQlIRX3eZ2Uw3wrT1zLXNkniVWoDNppVY6YrZPhrZg+
	 A70Q5xhY7fkYbNjOrJDkXHi+fsXT7YNtPJBP34l7R3IRZCbZYvQcGPxX34mHcmnyUM
	 hNyc6ue5xF4ZnbzL/QAg0anhjNIk5nrHjfAz1cy6iVu0/+Vo2b6vVi5shq5xWSv29r
	 yqF7fhnnFVDLw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 21:33:31 +0100
Subject: [PATCH v2 36/47] mm: fix unmap_mapping_range() beyond 4 GiB on
 32-bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-fixes_core-v2-36-a64ce7f83abb@kernel.org>
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
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2239; i=david@kernel.org;
 h=from:subject:message-id; bh=FaMGvBz2T3vWhwVxRPgiVx8avhRKMEtK+bszIc5YQPg=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIer+3UYBdOdc4OsRe4dcYm/IWlRsLr4/8u6jRYlmQKs
 m76JWLbUcrCIMbBICumyBIUfN/g5ct1tdVufMwwc1iZQIYwcHEKwETmuzAyXCj+uuyi290tD3zU
 dPIsJ7toCFryWsZe4PSNseAPXraEkeGfouF9z1zh1MDXleEbpm8V5fqXbFjDdG+fl/L0BTF6S7c
 wAAA=
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

From: Josef Bacik <josef@toxicpanda.com>

Commit 9eab0421fa94 ("mm: fix unmap_mapping_range high bits shift bug")
made holebegin and holelen unsigned before they are shifted, by casting
them to pgoff_t. That is an unsigned long: on a 32-bit kernel the cast
cuts off the upper half of the two loff_t values, so a hole which begins
at 4 GiB or beyond is taken for one in the first 4 GiB of the file.

truncate_pagecache() passes the new size of the file and asks for private
COWed pages to be unmapped as well. If a file of 6 GiB is truncated to
5 GiB, everything from 1 GiB on is unmapped, and what a process has
written to a private mapping of the range between 1 GiB and 5 GiB is
lost: it reads the contents of the file again.

Where the range has an end, the wrong range is unmapped instead of the
right one. The page cache copes with that, as it unmaps every folio that
it removes. The callers which only have unmap_mapping_range() to get
rid of user mappings do not, for example drm_vma_node_unmap(), whose fake
offsets reach beyond 4 GiB on 32-bit, and revoke_iomem() with physical
addresses of more than 32 bits.

Cast to u64 instead. Nothing changes for 64-bit kernels.

Fix generated by an LLM and sent by Josef Bacik in private.

Fixes: 9eab0421fa94 ("mm: fix unmap_mapping_range high bits shift bug")
Cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index ae8d567bc6ba..732b8f926de6 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4649,8 +4649,8 @@ EXPORT_SYMBOL_GPL(unmap_mapping_pages);
 void unmap_mapping_range(struct address_space *mapping,
 		loff_t const holebegin, loff_t const holelen, int even_cows)
 {
-	pgoff_t hba = (pgoff_t)(holebegin) >> PAGE_SHIFT;
-	pgoff_t hlen = ((pgoff_t)(holelen) + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	pgoff_t hba = (u64)holebegin >> PAGE_SHIFT;
+	pgoff_t hlen = ((u64)holelen + PAGE_SIZE - 1) >> PAGE_SHIFT;
 
 	/* Check for overflow. */
 	if (sizeof(holelen) > sizeof(hlen)) {

-- 
2.43.0


