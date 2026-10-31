Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3596B606A329
	for <kexec@archiver.kernel.org>; Sat, 31 Oct 2026 09:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=cocnBgq9;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mz4vjtNh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=nShE2+EwYjVmjC/lA8OKz4kDZ0zHLwWOS1pXqI0CSl4=; b=cocnBgq9hZthx9
	KuYRmeMKjGZNZzWO+w4IXCbIj+sBok0CXNesg8miRPoOMrIXGu3+S1FypjnvROOTK2AJeHI8mJ0Fg
	OD5qNYNHCxy9Xi5Kf+yuWDV8ienHAq6N7/QusI10ueIurKt1pUfQFD+CBlNw4vRSdpVgMpMgRK+bb
	8gGLyrb9bsRAUf2DMfhvcy/0MBZ8AYRLQctx5orxHjKKaPnFJvcdukqSWWCoCB7n98IX+nSyWLxpc
	jY3yrStl/dBpgz49f0RMSIBQ4OZAv1wnuT2HnOEHww/S0E9KHRq08aduJ7uC3zv8rcgMtwdtMraYF
	uCNYpRkndkaY6drkjNZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xN5kk-0000000DByu-3uuu;
	Sat, 31 Oct 2026 09:51:58 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xN5kj-0000000DByh-38m1
	for kexec@lists.infradead.org;
	Sat, 31 Oct 2026 09:51:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 421BB4120C;
	Sat, 31 Oct 2026 09:51:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2DFF1F000C1;
	Sat, 31 Oct 2026 09:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793440317;
	bh=nShE2+EwYjVmjC/lA8OKz4kDZ0zHLwWOS1pXqI0CSl4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Mz4vjtNhUqGbGKHRoGXr9r+sytHCDgRAxGO/amotCyXaOFqxF+1ep6MZmFH4ILyUf
	 W0soiCoF85GTYjDhg/9mZh6VMl80OhnxsHPoL552tTLwh9HXYOi/GiwLwpAiF2B8v6
	 VoRkh84fbkFxfEXDlZvUG5VkZQXlGgjq3C1gM8+TqM+BVpxlZsZuu/LxsBtRUhg95t
	 hLzMpxbrGJVxeFzQgGU10iiSU+q4upIDWG/+xOTiXd2Y8NSFyVFl0CvXr4j6iUn8Id
	 kOl8vDpFjXBoTR1k+RutPsfUG9kpI0vTOMC1dK9G3s83qVgo0bmN2ixPWHRJcO3y/C
	 bSgnjcBQSyl0A==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:40:14 +0100
Subject: [PATCH v3 45/47] mm/cma: don't release CMA pages still in use
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261031-fixes_core-v3-45-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-0-d6437171ecc3@kernel.org>
In-Reply-To: <20261031-fixes_core-v3-0-d6437171ecc3@kernel.org>
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
 stable@vger.kernel.org, Muhammad Usama Anjum <usama.anjum@arm.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2309; i=david@kernel.org;
 h=from:subject:message-id; bh=571srl9637tWygfCtNc98notNFslusDCyOEoBtogIYA=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLKebs+eNiHr9s7IJUETNvCvfhoemf2I7a39qzNyn8o+v
 ZvqujLncUcpC4MYB4OsmCJLUPB9g5cv19VWu/Exw8xhZQIZwsDFKQATMS9nZGi4eqt7tvCEDa/X
 PrzjlHcwpuPD07izPb1PXZduX1S4LjmM4a9s/k2VDpvdc58sUZiqG171ZIX0iqVhd7+pGJmyVm2
 fuZYTAA==
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

From: Rik van Riel <riel@surriel.com>

When a driver calls dma_free_contiguous() before quiescing DMA, the
page might still have a reference from the device.
put_page_testzero() there returns false, WARN fires, but the code proceeds
to free_contig_frozen_range() putting a live page onto buddy and clearing
the bitmap. A subsequent allocation can hand the same PFN to a new
owner while the original holder still references it.

A concurrent put_page() that drops the last reference between the
testzero loop and free_contig_frozen_range() can double-queue the page
via page->lru, corrupting buddy lists.

Avoid the corruption by not freeing a CMA region if any of the
pages inside are still in use.

Make it explicit in the warning that the driver allowed a leak.

While at it, use page_ref_freeze() to make the semantics clearer and
switch to pr_warn_ratelimited().

Fixes: 9bda131c6093 ("mm: cma: add cma_alloc_frozen{_compound}()")
Cc: stable@vger.kernel.org
Signed-off-by: Rik van Riel <riel@surriel.com>
Link: https://patch.msgid.link/20260811132045.5f114772@fangorn
[ david: use page_ref_freeze() + pr_warn_ratelimited() ]
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: Muchun Song <muchun.song@linux.dev>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/cma.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index a10ea37a261da..871f95c9ae9f0 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -1020,7 +1020,7 @@ bool cma_release(struct cma *cma, const struct page *pages,
 		 unsigned long count)
 {
 	struct cma_memrange *cmr;
-	unsigned long ret = 0;
+	unsigned long leaked = 0;
 	unsigned long i, pfn;
 
 	cmr = find_cma_memrange(cma, pages, count);
@@ -1029,9 +1029,13 @@ bool cma_release(struct cma *cma, const struct page *pages,
 
 	pfn = page_to_pfn(pages);
 	for (i = 0; i < count; i++, pfn++)
-		ret += !put_page_testzero(pfn_to_page(pfn));
+		leaked += !page_ref_freeze(pfn_to_page(pfn), 1);
 
-	WARN(ret, "%lu pages are still in use!\n", ret);
+	if (leaked) {
+		pr_warn_ratelimited("%lu pages are still in use, not freeing CMA region!\n",
+				   leaked);
+		return true;
+	}
 
 	__cma_release_frozen(cma, cmr, pages, count);
 

-- 
2.43.0


