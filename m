Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3348606A321
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 23:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=a1SAmhI7;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a2oBtA1M
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=MsPh/eggStrjiHwP9EayEEqNGoFUTjhuNZcTRbaJqvA=; b=a1SAmhI7oOKAyC
	A6MT6hnKbXiKpiy1oAe8ml6bEqynEP/1OvwzEeQ4udoEU1A5qYHfAkY4Zy/HMTFYclVSPNubaWLTO
	6vH5S8p4W5B88SC6y2VAIzdMqkMkV+o6i9M5hAKJ1ByCSXT4l7tq3iVs6e9Xc1i0HAZGZkzPekaNp
	2x47dsQaRBbcsvZA+EhsIBgjGcgker9YZ0c60RzOAWYizP2MIQNecmQfn4BGggFGXt9WMWOqOHnAN
	HwafZuYprYrmKocohvaxAPW79Avr0uuNB0OM3H5fD2z5AU4jPwv6Zv3pIw4HjC041oOk+/vbiLMwl
	9Sn5PqaGk3BvB1cujHqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLU6x-00000003RE4-2LeS;
	Mon, 26 Oct 2026 23:28:15 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLU6w-00000003RDx-1yYG
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 23:28:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1FE2041FF9;
	Mon, 26 Oct 2026 23:28:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B5F1F031E8;
	Mon, 26 Oct 2026 23:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793057294;
	bh=MsPh/eggStrjiHwP9EayEEqNGoFUTjhuNZcTRbaJqvA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=a2oBtA1MZUa66kHRki/kVGEs4Zx8bYN/Yl5uKbWs9K/ii8a0kAHkMnSDLIdapPOWX
	 tT9/m5gFYOUnJ0bxIPU3CBuADzf8viUbnqgkZg+qgxV89v2GUDN4AHW0Z1wAHkcduk
	 PIxQdnRdZJHbXvgTH5eaPIsMoZPvrYBYhtl/jAi8ljDXzIVG1kAItasz/VnHm/ks1x
	 Iuz1X6uJ7GLX4jmLwHxR9GyQb3CUrqzCsMYq+8T3s2R5uK7EIuMRjtCCGsaXSkwqoJ
	 fIyFLJR3wL5Y6vXz+2Okd6zBZ1WqzzuUzJB6PvOkZKTgLrcpSfx84MZ2uDvQrjryH6
	 7UK0jOt7OUuWw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 27 Oct 2026 00:17:53 +0100
Subject: [PATCH 33/46] mm/madvise: fix data loss from MADV_FREE on a KSM
 page
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-fixes_core-v1-33-6f74bec9a5bb@kernel.org>
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
 stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1695; i=david@kernel.org;
 h=from:subject:message-id; bh=qp+B7fki+e2EPAcFDpqxiM3FT4Otm8jPFLB5fTfcqqc=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLu35++XlaKOa1L9OCCE0uzuD4K1eSJ2TXlGKhMad/5+
 7MYb/7rjlIWBjEOBlkxRZag4PsGL1+uq61242OGmcPKBDKEgYtTACYS9Z3hf4lNQMf/pQy/qw6c
 fx1krnTVIfBoMcfe/NDGiKW8PNPauRgZLuTsfCHh5j9fZiH/fc/r4R9ag06c/lFl0HhBN2Pn7x3
 2/AA=
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

MADV_FREE can clear the dirty flag of a singly mapped KSM folio. The
folio remains in the stable tree and can gain new mappings without being
dirtied again. Once marked lazyfree, reclaim can discard data that those
mappings still need.

KSM always marks a folio dirty when converting it to a KSM folio in
try_to_merge_one_page(). Marking a folio lazyfree clears PG_swapbacked
but leaves PG_dirty unchanged. Preserving PG_dirty makes reclaim restore
PG_swapbacked instead of discarding the folio. This also protects folios
that were already lazyfree when KSM converted them.

Skip KSM folios before clearing their dirty flag, checking under the
folio lock to serialize with KSM conversion.

Fixes: 854e9ed09ded ("mm: support madvise(MADV_FREE)")
Cc: stable@vger.kernel.org
Reported-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/madvise.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index 75b409e97dbf2..a16e3cb256b7b 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -756,6 +756,15 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
 		if (folio_test_swapcache(folio) || folio_test_dirty(folio)) {
 			if (!folio_trylock(folio))
 				continue;
+			/*
+			 * KSM folios can gain new mappings at any time, so we must
+			 * not clear their dirty flag.
+			 */
+			if (folio_test_ksm(folio)) {
+				folio_unlock(folio);
+				continue;
+			}
+
 			/*
 			 * If we have a large folio at this point, we know it is
 			 * fully mapped so if its mapcount is the same as its

-- 
2.43.0


