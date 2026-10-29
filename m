Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2100606A333
	for <kexec@archiver.kernel.org>; Thu, 29 Oct 2026 20:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GNtRlMA5;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TE1y0ZbL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=zTwOe2rhygBTqbimADjsD30DCMGB2E0StBtyrsEknSA=; b=GNtRlMA5Ob7Gyr
	qilXo5hDptS3cOb+J7e9w0NpR2R0WJFWXoeTo6ZueRZp7dU52eUueqEjAliPLdILeX22sjlYRqLfr
	nFayRjJDpy5bEPhRxplxPwcULeR93kYPBUB36r00FArGuAFr0l4rOWPAlRpamqLhN748jbtLAKuaS
	DPZQGmPyRcNTs7/sb8X+Vr44QXHJMVh2UjHOV+PMd+it0jP7bm1x1FuSv3VurGoXdIgmXECGpfzUP
	xAh9C0TlBMIH8YrPxHW8qzl5aofU1alwrqR1xcVdCKtcEelXJNBd4RHxFIsgvaSfh5TeAl6/tMcUM
	dkc1sQQFAFN5beqs4y6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMWvt-0000000ALuS-2kMi;
	Thu, 29 Oct 2026 20:41:09 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMWvs-0000000ALuA-0Gsd
	for kexec@lists.infradead.org;
	Thu, 29 Oct 2026 20:41:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7B3516062C;
	Thu, 29 Oct 2026 20:41:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265891F01816;
	Thu, 29 Oct 2026 20:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793306467;
	bh=zTwOe2rhygBTqbimADjsD30DCMGB2E0StBtyrsEknSA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TE1y0ZbL3VVf4eb0u189422pKiAjJR66N2I9oRbQQKW9568wfoomQtdaN6haewvQ/
	 QvLKMTWJGEIpLmu872vicnNj8EMylIE6cimSkE7cVVxhve4jg0GGIRmlhdB4EW+Rfs
	 bx4v2727E0rc3ijNbosG45F77CfN2c9fJw31CpRuioX3BtcKRyuofi5KCM412z8Yis
	 b+xHStb8Zv+yfOsQ8t+1K8J/VWSvKbzlyPs3a1VrzphHv9cZ7fI88mgneYvJjxzOHJ
	 v8ViB9WkGVew7svI82MfmrAzh9Hrk1i0lS0t6SRranladPVqdFUN08fQx4ZQ8MBeuv
	 AEoxd+/ch8j5g==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 21:33:26 +0100
Subject: [PATCH v2 31/47] mm/mremap: recheck PUDs under the page table lock
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-fixes_core-v2-31-a64ce7f83abb@kernel.org>
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
 stable@vger.kernel.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2380; i=david@kernel.org;
 h=from:subject:message-id; bh=+B9w/NrDyjyp/nHRZsfFIxa7vmKtKobl06e6HnkArmM=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIer+24/V3GfMO74vTaKbNNWy5eXLrUfJ6mT+ijWK8PH
 W4s/RsTO0pZGMQ4GGTFFFmCgu8bvHy5rrbajY8ZZg4rE8gQBi5OAZiIXx3D/zzBwL2X6+arx9qJ
 nJHpi56T+PWSp2qJUN7ShvrtW9ett2H4HzPRY6fWRadVIoXiKeVO3i4zbr8QeZnw4P6WpzOSJZS
 leQA=
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

Once get_old_pud() is fixed to accept PUD leaves, unmap_mapping_range() can
clear a leaf between the lookup and the move. Holding mmap_lock in write
mode does not prevent this.

If the zap happens before move_page_tables() tests the entry, an empty
PUD can reach move_normal_pud(), where pud_populate() turns it into a
present page table entry. If it happens after the test, move_huge_pud()
can instead try to move an empty entry, triggering CONFIG_DEBUG_VM
warnings on powerpc.

Recheck the source under the page table lock in both helpers. Treat an
empty source in move_normal_pud() as a completed move, and use
__pud_trans_huge_lock() in move_huge_pud().

In the future we should likely have the code lookup a PUD/PMD lockless
once, instead of multiple times, because one of the problematic bits
here is the:

	pud_trans_huge(*old_pud)

Fixes: 0881ace292b6 ("mm/mremap: use pmd/pud_poplulate to update page table entries")
Cc: stable@vger.kernel.org
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/mremap.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 16e736c72d9c..91f0865f6aee 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -461,14 +461,18 @@ static bool move_normal_pud(struct pagetable_move_control *pmc,
 	if (new_ptl != old_ptl)
 		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
 
-	/* Clear the pud */
 	pud = *old_pud;
+	if (unlikely(pud_none(pud)))
+		goto out_unlock;
+
+	/* Clear the pud */
 	pud_clear(old_pud);
 
 	VM_BUG_ON(!pud_none(*new_pud));
 
 	pud_populate(mm, new_pud, pud_pgtable(pud));
 	flush_tlb_range(vma, pmc->old_addr, pmc->old_addr + PUD_SIZE);
+out_unlock:
 	if (new_ptl != old_ptl)
 		spin_unlock(new_ptl);
 	spin_unlock(old_ptl);
@@ -503,7 +507,9 @@ static bool move_huge_pud(struct pagetable_move_control *pmc,
 	 * We don't have to worry about the ordering of src and dst
 	 * ptlocks because exclusive mmap_lock prevents deadlock.
 	 */
-	old_ptl = pud_lock(mm, old_pud);
+	old_ptl = __pud_trans_huge_lock(old_pud, vma);
+	if (unlikely(!old_ptl))
+		return false;
 	new_ptl = pud_lockptr(mm, new_pud);
 	if (new_ptl != old_ptl)
 		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);

-- 
2.43.0


