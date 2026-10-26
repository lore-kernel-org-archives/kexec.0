Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC329606A31B
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 23:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hTLvx1GG;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OenGcW7s
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=pd6OfqmpOChanyaBg9muCovOqLNLeBHLddsioXEL2d8=; b=hTLvx1GGrz3y+h
	l4MqaEwMepzJOMBOMxHpp936vXrjL+11NPlWVBsPcwhKF7ibDG0fojn0XINB1vkeQ89P6ldHRTIDo
	92CpcESMZVHXuQuRZT3eLIyytqn1G8ph0Pi1NTpAx9aqTXejMRwI6W4s5SQOo0vLTuo7YaaoNwwDA
	pVOJ28uLhNGFJsjACusjmJwUi7SjdFlavR6pWezSkYuEOyTl3j0YaLE/p3tH6oj7nn1JXKRUtOUtb
	msvVk8xOvs5T/H4hSklZkZXEl6T7iSbALTGdmWAVMS2Gm2pzH/ftVcbq9eZr9uj6OP36xU2IEEEur
	oGfG5VpQf+9K4lT6s6sA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLU4p-00000003Qh8-2ajS;
	Mon, 26 Oct 2026 23:26:03 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLU4o-00000003Qgj-1tKg
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 23:26:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DBC5F60546;
	Mon, 26 Oct 2026 23:26:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82AA1F01828;
	Mon, 26 Oct 2026 23:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793057161;
	bh=pd6OfqmpOChanyaBg9muCovOqLNLeBHLddsioXEL2d8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OenGcW7sFoZGtv1gaXQpArBMVVnJOhx+l+0ykN84+ptoXAervg2MfMkka6s9HSVYt
	 tgcVqLUGEeLeqEoFYRQ9jzW6NyFKFNuyEYv4ZWrG0aKe85MpelQ3jS81Hv84bvTKJ/
	 jwAyd5xVDT1L5VfHo4kHUml4LJ4183wu2xwgQzh/EgzXIIFIajoE5bBmtTlNWt7JWp
	 gCu64lDRoEk2GNJoKmSfar44UgKDAIq/GF3c/idb4eUGQgJVmbOoDavw0xuvlJ+xx4
	 xw62M57+bReRfFtktYO4uLFMd7NCesCYhsca/BQIPApEutsj01S4PN9uTgwYKPFOjH
	 75BU22gCY+JxA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 27 Oct 2026 00:17:46 +0100
Subject: [PATCH 26/46] mm/mmu_gather: fix flushing ranges with 4 GiB or
 larger
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-fixes_core-v1-26-6f74bec9a5bb@kernel.org>
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
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1683; i=david@kernel.org;
 h=from:subject:message-id; bh=vZJ6VSoQXMdFgpkoHzKAC0N6aJn0tSkxLvHpOmbVOwQ=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLu35/2tcJn9u2pedVh2kaKzXubJ26ytvuerLI1/PZTd
 5aXS3U/dpSyMIhxMMiKKbIEBd83ePlyXW21Gx8zzBxWJpAhDFycAjCRgnZGho98yTLy/Kv6Anbt
 tX6T+fSrkcfObflNKQvkEm0CRKusnzMyPN/TNOFSidoD7sC7deuShCurFjokHp1+fqsd09ZXLCf
 amQE=
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

From: Josef Bacik <josef@toxicpanda.com>

__tlb_adjust_range() takes the size of the range which has to be flushed
as an unsigned int. Its callers, tlb_flush_{pte,pmd,pud,p4d}_range(), get
and pass an unsigned long. Consequently, a range that is 4 GiB or larger
gets truncated, possibly to 0.

On arm64 with hugetlb, a 64k kernel can flush 16 GiB hugetlb PMDs, and a
16k kernel can flush 64 GiB PUDs through tlb_unshare_pmd_ptdesc(). So
at least these two scenarios are affected.

Fix it by flushing the proper range instead of the truncated one.

Fix generated by an LLM and sent by Josef Bacik in private.

Fixes: b528e4b6405b ("mm/hugetlb: add tlb_remove_hugetlb_entry for handling hugetlb pages")
Fixes: 8ce720d5bd91 ("mm/hugetlb: fix excessive IPI broadcasts when unsharing PMD tables using mmu_gather")
Cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
[ david: use two-tab indent, simplify description ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/asm-generic/tlb.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index fbe1114e9a443..3f4a180b48f3c 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -350,8 +350,7 @@ struct mmu_gather {
 void tlb_flush_mmu(struct mmu_gather *tlb);
 
 static inline void __tlb_adjust_range(struct mmu_gather *tlb,
-				      unsigned long address,
-				      unsigned int range_size)
+		unsigned long address, unsigned long range_size)
 {
 	tlb->start = min(tlb->start, address);
 	tlb->end = max(tlb->end, address + range_size);

-- 
2.43.0


