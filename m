Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1109B606A324
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 23:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=M5wRWVKA;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A/EO6/mr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ord/cNP4CRsRT4Xvi9c7rgpbK1vGRFp0LVhUmuKhqjI=; b=M5wRWVKAQ15Wz9
	8hXddEykq73+gaAXtc8YmfwTtLIyKYU5cIOE72xpzBNKq7xo5lTrdCfbVcQoypclCjq4/hyVK4VOT
	NlfKQmBMqzugHwItj1itzVMFJOh7BnwsqWwknN2DYf4yFXshF/2jyBF7IGeScdklNzDVA+B9nP3uX
	WHdLQ4qdFjoTzcyMyX+PSYcCk4vYfe8sXUwepaYh0SD4Kqmmx8e+uBskWjTBDgcWYbW36vP1aYMwQ
	9Vz94cEAs51etz+MeXlJ0y8efCxBDfgYHdxxzoql0cj+stKUrTOhheDIDqyd2sWunE6iN8tRDrOpn
	2bsLKB/zDRxZD2HZZm6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLU1C-00000003Poa-3FZS;
	Mon, 26 Oct 2026 23:22:18 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLU1B-00000003PoI-3z57
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 23:22:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id A3F0541460;
	Mon, 26 Oct 2026 23:22:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B94E1F01825;
	Mon, 26 Oct 2026 23:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793056937;
	bh=ord/cNP4CRsRT4Xvi9c7rgpbK1vGRFp0LVhUmuKhqjI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=A/EO6/mrzkD/mg3LADo0kMno6NcudvbnDZM8+tP9DZDoU8h9co0wU4clyW6YZLGFl
	 ez77QV1LIY6IfUQBxzaqwM2+Y8X4xFpLbUPyaBW70KMfkz7RLbSPEpjilPcUHcVlaz
	 Nc9VIAX3oxSv0TtODqmK33x8Gw+Djny92ATTXKcaqlSN630jZjUPuTr//5PNs6+tUj
	 Bv42ssVm1ha1+CGtMl3ZCTjR1Vr36giZAnOD4Sa1XOnawJ5sMZ9PD0aJQeKTO0fxuS
	 lWZTZeTL6k/4c+Sx5wtd160zyY8s+XW3ZtFGyroIsKFMK3n51Km+Sv+lIi+J0jrgRR
	 77f61FFUxGTOQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 27 Oct 2026 00:17:34 +0100
Subject: [PATCH 14/46] mm/huge_memory: fix zapping migration entries for
 device-private THPs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-fixes_core-v1-14-6f74bec9a5bb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1559; i=david@kernel.org;
 h=from:subject:message-id; bh=0T8y59LcTWa+97MvrqvLjbP/3maGmTKua0tBD9F4/0I=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLu35+ia/cvPpk1zX/O+d5dB20O/XTZps6+dGX6/C/Wn
 32/e/6/1FHKwiDGwSArpsgSFHzf4OXLdbXVbnzMMHNYmUCGMHBxCsBEdq5m+J++r4l1Vdemiaxr
 97IsOrB126Hm5Fs1z7zO++7NmFr9v2YlI8MSV+slVydHMX/KX/44/mLh7Gc8sTxTlc/N5lTMr6r
 ZxMMDAA==
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

A PMD migration entry can refer to a device-private folio.
zap_huge_pmd_folio() checks the folio type instead of the entry type,
so it treats such a migration entry as a device-private entry.

Installing the migration entry already removed the reverse mapping and
dropped the mapping reference. Zapping it must not repeat those
operations. Concurrent MADV_DONTNEED during migration back to system
memory can trigger this.

Check the PMD entry type using pmd_is_device_private_entry().

Fix generated by an LLM and sent by Chris Mason in private.

Fixes: 368076f52ebe ("mm/huge_memory: add device-private THP support to PMD operations")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[ david: simplify description ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/huge_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index eda020dd6e33f..1b50cc2b35351 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2493,7 +2493,7 @@ static inline void zap_deposited_table(struct mm_struct *mm, pmd_t *pmd)
 static void zap_huge_pmd_folio(struct mm_struct *mm, struct vm_area_struct *vma,
 		pmd_t pmdval, struct folio *folio, bool is_present)
 {
-	const bool is_device_private = folio_is_device_private(folio);
+	const bool is_device_private = !is_present && pmd_is_device_private_entry(pmdval);
 
 	/* Transfer young+dirty while the folio is still mapped. */
 	if (is_present && !folio_test_anon(folio)) {

-- 
2.43.0


