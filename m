Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED52E606A332
	for <kexec@archiver.kernel.org>; Mon,  2 Nov 2026 06:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=sMgBSz3A;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mnLeKo3J
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=+yuFDhrhf3kM/PO/AnTTpZJjMtV5tAkK8200L66uGl8=; b=sMgBSz3ArufL6L
	dyUHS5MoJ5Dt3hRxqmQlgGjsNI/EH7NUrenAJNnfOsBvLnSsGCaCxhz5U7zZmQU6H3qmsQ2M3Y+Xs
	TxVIOAtOuv5sfaLcTHiLVK3NBOnJxc1qHUJDAlymhnBHqlrwNmJHYt2WqdLrXRng2vDr7VXR2OJE4
	z1/RYiREcyTCMLJdfe3gaxI0ctOc/bQCo6RvCLXlFMhIANvDAIhzkukynohilM4QXLZugOKPvRH9z
	4thWeximkqCGv/jCGhLiNtTcY0QD7PFCJrl8/r4ZMimKI1NwiM4Ua7hAZzAPlFZwSq48rbmjBe7ch
	fIW/fDPQb/FviHtRnOUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNlBD-0000000FcoD-2oTy;
	Mon, 02 Nov 2026 06:06:03 +0000
Received: from out-156.mta0.migadu.com ([2001:41d0:1004:224b::9c] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNlBA-0000000FcnZ-1FOv
	for kexec@lists.infradead.org;
	Mon, 02 Nov 2026 06:06:02 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=ex0bR+wqY48y7Ys0l1lS/C4xyqfg/lqStx93s8K9wXI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793599557; v=1; x=1794204357;
 b=mnLeKo3JIlrjZ0v8csYIXQvs0MqjNYBAaha6FI+GsXgzsTBscKhu47xfdxei1GstkYX55TtU
 s7+ijDrBsSQikbWr4RhQIABec//XfnZQfXcLKbZqgwK2XEUTDJ36HqPkKEIRh6O+ifRMQgl5bW3
 ABiUUGhU4PsBaXEJa27dL80Y=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 85932c5ab249e449;
	Mon, 02 Nov 2026 06:05:56 +0000
X-Mizu-Trace-ID: 85932c5ab249e449
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	ljs@kernel.org,
	kasong@tencent.com,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	kees@kernel.org,
	peterz@infradead.org,
	jannh@google.com,
	pfalcato@suse.de,
	hughd@google.com,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	willy@infradead.org,
	jack@suse.cz,
	ziy@nvidia.com,
	lance.yang@linux.dev,
	riel@surriel.com,
	harry@kernel.org,
	apopple@nvidia.com,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	usama.arif@linux.dev,
	kas@kernel.org,
	matthew.brost@intel.com,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	osalvador@suse.de,
	minchan@kernel.org,
	muchun.song@linux.dev,
	xu.xin@linux.dev,
	chengming.zhou@linux.dev,
	chrisl@kernel.org,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	youngjun.park@lge.com,
	gourry@gourry.net,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	jgg@ziepe.ca,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	mason@kernel.org,
	stable@vger.kernel.org,
	usama.anjum@arm.com
Subject: Re: [PATCH v3 17/47] mm/khugepaged: preserve dirty bits when collapsing PTE-mapped THPs
Date: Mon,  2 Nov 2026 14:05:47 +0800
Message-ID: <20261102060547.39942-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20261031-fixes_core-v3-17-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-17-d6437171ecc3@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261101_220600_659313_E48E31C6 
X-CRM114-Status: GOOD (  13.07  )
X-Spam-Score: -2.1 (--)
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On Sat, Oct 31, 2026 at 10:39:46AM +0100, David Hildenbrand (Arm) wrote:
>From: Chris Mason <mason@kernel.org>
>
>try_collapse_pte_mapped_thp() clears PTEs without transferring their dirty
>bits to the folio. A shmem read fault can map a clean folio writable, so
>a later store only dirties the PTE. Losing that dirty bit allows reclaim
>to discard modified data.
>
>The assumption that regular files are read-only is also obsolete since
>commit 1b6444331bebb ("mm/khugepaged: enable clean pagecache folio collapse
>for writable files"). In any case, transferring PTE dirty bits to the folio
>when removing mappings (and while the folio is still mapped) is the right
>thing to do.
>
>Use get_and_clear_ptes() to collect the dirty bits and mark the folio
>dirty before unmapping it. Update the comment.
>
>This was reproduced with shmem using MADV_COLLAPSE followed by
>MADV_PAGEOUT.
>
>Fix generated by an LLM and sent by Chris Mason in private.
>
>Fixes: 27e1f8273113 ("khugepaged: enable collapse pmd for pte-mapped THP")
>Fixes: 1b6444331bebb ("mm/khugepaged: enable clean pagecache folio collapse for writable files")
>Cc: stable@vger.kernel.org
>Signed-off-by: Chris Mason <mason@kernel.org>
>[ david: adjust comment; simplify description; cover file-thp as well ]
>Reviewed-by: Pedro Falcato <pfalcato@suse.de>
>Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
>Tested-by: Gregory Price (Meta) <gourry@gourry.net>
>Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---
> mm/khugepaged.c | 5 +++--
> 1 file changed, 3 insertions(+), 2 deletions(-)
>
>diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>index 34ebb37c862c0..ce794d9760a87 100644
>--- a/mm/khugepaged.c
>+++ b/mm/khugepaged.c
>@@ -1995,9 +1995,10 @@ static enum scan_result try_collapse_pte_mapped_thp(struct mm_struct *mm, unsign
> 		/*
> 		 * Must clear entry, or a racing truncate may re-remove it.
> 		 * TLB flush can be left until pmdp_collapse_flush() does it.
>-		 * PTE dirty? Shmem page is already dirty; file is read-only.
> 		 */
>-		clear_ptes(mm, addr, pte, nr_batch_ptes);
>+		ptent = get_and_clear_ptes(mm, addr, pte, nr_batch_ptes);

I went through get_and_clear_ptes() as well. It merges dirty bits across
the batch, so we're covered even when the first PTE is clean and a later
one is dirty.

LGTM!

Reviewed-by: Lance Yang <lance.yang@linux.dev>

>+		if (pte_dirty(ptent))
>+			folio_mark_dirty(folio);
> 		folio_remove_rmap_ptes(folio, page, nr_batch_ptes, vma);
> 		nr_mapped_ptes += nr_batch_ptes;
> 	}
>
>-- 
>2.43.0
>
>

