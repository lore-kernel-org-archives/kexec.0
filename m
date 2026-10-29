Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF28606A33A
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 20:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=igIlpLUa;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YlKsdyMX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=93rB4MhysMhGYbksem4hKuOQyLx77syArI3hVZIrAK4=; b=igIlpLUawa5izx
	naZ/upJq4TR0qPusSyoPo+vU1xaFQlb7zmO5nMYJLmlAknh6D8Wd2LNA/kVyyrxYyIXnHjnj1fSQ5
	l/4q0OneMAR92dIQeZGJPKckcDv1tRa8Heb8vVk/z1mNxCMUT4IEr02m8gsAIwEWLeTnYbymjImrM
	0gFfQ6jKxZEqPIMzXyAoEXAUra9kihmimX2ruDRy/VUWaO6BvNQbftRf5jUbvGSKP2dykayT8MWgE
	CrfjsO9vOQCUspWBliraahgDSlBtRTgJz9e6TDXkcWpmgI5PeGHIOve/Aoh39QId4mlYBPHC/LX2y
	a9ntKpFL1PlohZTWZFng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMWuE-0000000ALVq-2vQ3;
	Thu, 29 Oct 2026 20:39:26 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMWuE-0000000ALVg-0tG3
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 20:39:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5A4836060F;
	Thu, 29 Oct 2026 20:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46BD1F01816;
	Thu, 29 Oct 2026 20:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793306365;
	bh=93rB4MhysMhGYbksem4hKuOQyLx77syArI3hVZIrAK4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YlKsdyMXMe5uYCu83iB8MjgJNBo9ihA41CeTCek8Yphz+cIivFiF1PQxyAHfKlko2
	 0QD32dcJV7Ck4q1Js/ZOHyaLk5WAydTF1kdrarTAi71AJ2YwjxMAGMNmEnCtnAQv2X
	 /S+Ch98lQzbrbvWpHx+QzNZiP2EkyoOo6wYgdlvQ6g5ScFZPceMS3op53bXt/B+Enq
	 BED4rLyLLGRwSKp0Qq4/93GOyLtpiPv7fa0DrCe1bq0HxIbRnbojjtmW2X4vwKwoCA
	 6slZ9Mrrp4KHRhq1orGCO3BkyyXd1JC+utuS4SS3T8j4nbPnctubqyoD23R0oW24tJ
	 liZ86yXMtu6FQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 21:33:19 +0100
Subject: [PATCH v2 24/47] mm/userfaultfd: wake all waiters on unregister
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-fixes_core-v2-24-a64ce7f83abb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2376; i=david@kernel.org;
 h=from:subject:message-id; bh=IeP32edqUnfVhMXgZn9k/7GJXHBVF4YDItB/FrA9iCo=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIer21fZssROqlhS+ofnxNzpMU1gq+eX5g3y+T4lOjXX
 xuvrzmU2FHKwiDGwSArpsgSFHzf4OXLdbXVbnzMMHNYmUCGMHBxCsBEbh9m+Kd00U3ugNZCHgbl
 956f3Nxt3+u73ZzEdEiM7/CD6oz54b8YGbZURRyZ7WzlLbfCpOulgpFegap5/aGGTfnfm7o63Vr
 msQMA
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

UFFDIO_UNREGISTER only wakes pending faults if VM_UFFD_MISSING is set.
Threads waiting on write-protect, minor or RWP faults can therefore remain
asleep after unregistering a range that does not track missing faults.

Wake pending faults regardless of the registration mode so they can retry
without an explicit UFFDIO_WAKE or closing the userfaultfd. This matches
the existing behavior for missing faults, including removing unread fault
messages for the woken waiters.

Fix generated by an LLM and sent by Josef Bacik in private.

Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
Cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[ david: rebase; simplify description ]
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/userfaultfd.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 3ca04b582329..be630674fda9 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -3977,6 +3977,8 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 
 	ret = 0;
 	for_each_vma_range(vmi, vma, end) {
+		struct userfaultfd_wake_range range;
+
 		cond_resched();
 
 		/* VMA not registered with userfaultfd. */
@@ -3994,18 +3996,14 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 		/* Prevent new userfaults from being queued after the wakeup. */
 		vma_start_write(vma);
 
-		if (userfaultfd_missing(vma)) {
-			/*
-			 * Wake any concurrent pending userfault while
-			 * we unregister, so they will not hang
-			 * permanently and it avoids userland to call
-			 * UFFDIO_WAKE explicitly.
-			 */
-			struct userfaultfd_wake_range range;
-			range.start = start;
-			range.len = vma_end - start;
-			wake_userfault(vma->vm_userfaultfd_ctx.ctx, &range);
-		}
+		/*
+		 * Wake any concurrent pending userfault while we unregister,
+		 * so they will not hang permanently and it avoids userland to
+		 * call UFFDIO_WAKE explicitly.
+		 */
+		range.start = start;
+		range.len = vma_end - start;
+		wake_userfault(ctx, &range);
 
 		vma = userfaultfd_clear_vma(&vmi, prev, vma,
 					    start, vma_end);

-- 
2.43.0


