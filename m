Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0638F606A332
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 20:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ifrz5Flm;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XzOcSZ0/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=kFAjWqVlFrIH7aRNsfEXW0cTwDAw9D8sfuZWY6alCX0=; b=ifrz5FlmgKbHA7
	4OqhvQD51vxiPywhnOWJeGYAl7LzmNzEwC/2Vi0roN3Z+CJeVXsKh1YzNz9aGMWZz1Ycq7ZW/PQ/d
	2Qn4L4ucMFnz4qZJXVkoGHKtptImRr8Rivv4yfyIFiKx5ERLTlPo7JBVRHMnE5HuYK/Epmzzwxh55
	5RGNV7Tf2fA2egODDoC4RzTYaj1jlLtQYzyk+uDUISIjrDl7Z0+XPoN1X8JQRMCo9y352qsSuHoph
	kLAgo3enIk18kMFIA//b4W+KK1kUujugG/bYtNtGdHJbHfvLUvya7GUsImoce1xeM7JIz7yBbWaLk
	X1gJOe8ezXfaQctfOnAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMWqC-0000000AKZ0-34m5;
	Thu, 29 Oct 2026 20:35:16 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMWqA-0000000AKYg-32R6
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 20:35:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2B0B3605CA;
	Thu, 29 Oct 2026 20:35:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A761F01828;
	Thu, 29 Oct 2026 20:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793306113;
	bh=kFAjWqVlFrIH7aRNsfEXW0cTwDAw9D8sfuZWY6alCX0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XzOcSZ0/8EjfLSpO8K/HcuZSOJbmmXQkIY53mzRn59GBRxsAtfiTFEDVrcM1yLKl3
	 oBTrNqK7TdiI9gM7WJtE7zLxyjhZPpzV0WsUkCfYL/Zq7ZgrFgNEGdSxyxupO/nLIR
	 Fs81prGpuyNkh4h18yqjW9N0cMlbxwMV3ALHT/84WBDoVJ05WlcrWo0o5AIcoX8Ql7
	 0AhvnXbjkE3P/WuPhUNmmNp4c7S4pWbHzyrQPQDz0y4hQDrEGq2WCt9sVPsDVsy6e6
	 zuX6cUOkjI5zZKKMpRFrRsGcZ9emk6B2GcItEG2PBmoGgzccnuLwaPMBL3pmdnj64+
	 bnSOphJYGh87A==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 21:33:02 +0100
Subject: [PATCH v2 07/47] mm/filemap: don't lose a folio lock wakeup to a
 signal
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-fixes_core-v2-7-a64ce7f83abb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2263; i=david@kernel.org;
 h=from:subject:message-id; bh=7u0AsrX18I9QfeKreay7tXsWSgpaxn4U+CWR4qcEsEM=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIer2291MuXbnXaLNMw/uX1tOZXcYnK+9aeVL/nlaF4h
 qdaO96jo5SFQYyDQVZMkSUo+L7By5fraqvd+Jhh5rAygQxh4OIUgIkcF2P4X16RdGbNIbGQ9tV/
 VrRe9lk932Zp6z6/K2/elLFvtlF9HcjIcMTwqNbp+EmRTVN1f3YYHTcs7L35TMld5fmhDd/PyCm
 e4gcA
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
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/filemap.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 906b013c11eb..6b5e1d866a9e 100644
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


