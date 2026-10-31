Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D619606A32A
	for <kexec@archiver.kernel.org>; Sat, 31 Oct 2026 09:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3bDZcWnB;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WDvrQdG5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=IukBtRcm5JcTGqbT6M2HPOb7HGng0HF2onbt6cV1NiQ=; b=3bDZcWnB7e7JdU
	X2hwLMQnJX7dclZ7bZ4QzBpJ+loVbjkhzMfyCsHQL2waXZFfUXKgcAe41KRNBClEGNY/+OV10UFAH
	85+6+OFbAhhXdxznAicKLzE3mdRLjettqsYTYkNp5aoaciRjdq69KkL1beLFNNgmaWkb2W5xOfdGs
	LJ0txMpED2FR1K9Q9Dm+7Y2/hDlw5ogN7/7zEnHnOTnsSbmhWmmT+MfW49R4QSpOBrtHpVnM267cu
	oEbuJIhl0XsTBghX74hcAOzADXVVIqj5iDR+e2s+6PH4QGykW07UDlNVs8Bm2nbyJcCzMYk0otOGC
	UbCo+0ItILO1edB94rQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xN5bC-0000000D9D8-1YYV;
	Sat, 31 Oct 2026 09:42:06 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xN5bB-0000000D9D0-0rWa
	for kexec@lists.infradead.org;
	Sat, 31 Oct 2026 09:42:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A236C600C8;
	Sat, 31 Oct 2026 09:42:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61251F000C1;
	Sat, 31 Oct 2026 09:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793439724;
	bh=IukBtRcm5JcTGqbT6M2HPOb7HGng0HF2onbt6cV1NiQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WDvrQdG5hCiqqzMhtB/MzrVC9SfHJYmvsM+QeuMFIgZMDQPmyuobhUnHZ9+7hPQzi
	 gVUJkZSIqfjU8K+snzcvUC7FhtT2BFPz5C0P5yt9u69tkrGqKiIu1uNXN9a3O/j54k
	 bf8E1hUtM4jsYNl/HSzb0ag/8FNx8IkAabUZyF5mVVisr5bbYqhOGyFb9grd/xUASI
	 +NL1vfWv5AjvaVU7Nof6g7QBNIZ1Uh0fOgswY9WBSfabF8TDyRD7azLgDW3fCSDgvf
	 HIqjgwkJ0gsCYzWjXY6pntuKMlzjqSwb5WGm4jXkF8aCN2VCxTfPNUKpLLPVVKDUTW
	 +dII6PS0SeO5g==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:39:36 +0100
Subject: [PATCH v3 07/47] mm/filemap: don't lose a folio lock wakeup to a
 signal
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261031-fixes_core-v3-7-d6437171ecc3@kernel.org>
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
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org, 
 Muhammad Usama Anjum <usama.anjum@arm.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2320; i=david@kernel.org;
 h=from:subject:message-id; bh=vb6IUsg7QbXcDgoe07H04DrJ083jgsIHjnvhmRFBkeo=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLKebk+VKpvXtEtgjfSyFg7bb8v4+ResXt4Z45c9Z0e5C
 ouLac2VjlIWBjEOBlkxRZag4PsGL1+uq61242OGmcPKBDKEgYtTACYy/zsjw6tDMrHnJM9UGV58
 27n4dF/5p226k2zXNjWKmfuVvY+b6Mnw31dyyZeEPUvLCkrS7r5lEBBXl1c7N5HvJwsTX7vOlim
 f+QE=
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

An exclusive waiter in folio_wait_bit_common() can leave the wait loop
because of a fatal signal, then be woken by folio_unlock() before
finish_wait(). If the waker did not hand over the lock, the waiter returns
-EINTR without trying to acquire it.

folio_wake_bit() stops after waking the first exclusive waiter, so this
loses the wakeup and can leave other waiters asleep indefinitely on an
unlocked folio.

After finish_wait(), let a waiter woken without a lock handoff try once
more to acquire the lock. If successful, return success so the caller's
eventual unlock wakes the next waiter. Otherwise, the current lock owner
will do so.

Fix generated by an LLM and sent by Josef Bacik in private.

Fixes: 5ef64cc8987a ("mm: allow a controlled amount of unfairness in the page lock")
Cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[ david: clarify and simplify comment + description ]
Reviewed-by: Rik van Riel <riel@surriel.com>
Acked-by: Pedro Falcato <pfalcato@suse.de>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/filemap.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 906b013c11eb3..6b5e1d866a9e0 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1373,10 +1373,22 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 	 * return value based on that state without races.
 	 *
 	 * Also note that WQ_FLAG_WOKEN is sufficient for a non-exclusive
-	 * waiter, but an exclusive one requires WQ_FLAG_DONE.
+	 * waiter, but an exclusive one must also acquire the bit.
 	 */
-	if (behavior == EXCLUSIVE)
-		return wait->flags & WQ_FLAG_DONE ? 0 : -EINTR;
+	if (behavior == EXCLUSIVE) {
+		if (wait->flags & WQ_FLAG_DONE)
+			return 0;
+		/*
+		 * We might have just been woken up and the waker will not
+		 * wake up anybody else. If we ignore that now, the remaining
+		 * waiters may not get woken up: take the bit now if it is
+		 * still free.
+		 */
+		if ((wait->flags & WQ_FLAG_WOKEN) &&
+		    !test_and_set_bit(bit_nr, folio_flags(folio, 0)))
+			return 0;
+		return -EINTR;
+	}
 
 	return wait->flags & WQ_FLAG_WOKEN ? 0 : -EINTR;
 }

-- 
2.43.0


