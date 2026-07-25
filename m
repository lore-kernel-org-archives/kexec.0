Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4EFEC531D0
	for <kexec@archiver.kernel.org>; Sat, 25 Jul 2026 17:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wZ0f3zzDp/LQ46aQcmeTItf+xyrvDOtmTEeK5N5Eqi4=; b=zoyQQLsLv68GxW+tbjiOr7Mz0+
	94GLvWgiAecvbkHZgiDatxWdbYgzKbtwAvoLjQdJQACIysjQzW4Iwc6ICcEHBD8V65UgHCUDW8o2/
	vOfTbz6OvBUrRV/iibFkZ+7gPRq3dGXE5HtnxBb2KD/MYdyqGfDROAH28MlkZMbu2UhUzKbzFCXEA
	PiC8Hdq18vdsBMtg9wIeBP1NEKrxT63MArkPxM5v+jqNERgGBTFAXKRT25K4cbGI021qsp/rLHu1h
	RkZHCr5jc/481R53Uw+PcheDNiw3ibSt9bp48zOkZ8bWcAnfdpmZBrFofW5vT1d4Vjnqa0R4VFd5n
	dPtW5ABg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wng5A-00000000ayk-45u0;
	Sat, 25 Jul 2026 17:22:40 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wng59-00000000axB-3udP
	for kexec@lists.infradead.org;
	Sat, 25 Jul 2026 17:22:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id AEEB643D66;
	Sat, 25 Jul 2026 17:22:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A821F000E9;
	Sat, 25 Jul 2026 17:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785000159;
	bh=wZ0f3zzDp/LQ46aQcmeTItf+xyrvDOtmTEeK5N5Eqi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RTVZKU93XLuef/FPziOCK1SLynmjuq2VnSb6EOKmXdOrLeUGAruKnssIkEH9FR3gW
	 9gJ03CDqbnSr5tRJ9BhIJ49Mpr3+5HlGcO1dbMeKpQ0zRcvRCG9Fwhj+qkOmpCeuJU
	 CX3hyEH2p+20pFyrbX14XFRufgs3ALEvDeFbobVfPrV0gPyxHIjR/STDFMZWX54P9b
	 Cvh8dQuS8FwF3O4hDeFAIn11cA3PhHeq6LGCdi5wl1huGzgVHsQHuy7KtBS7uqgMBZ
	 6rY5wSyhj84wU3YLWAT1wfYkTynvLt7id0gwyxSkzsGdOaHpUxnbwvkclI1Oqb5rq6
	 ZQd4sqATNdMCQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jason Miu <jasonmiu@google.com>,
	Jork Loeser <jloeser@linux.microsoft.com>
Cc: kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 21/21] kho: exclude hugetlb memory from scratch size calculation
Date: Sat, 25 Jul 2026 19:21:21 +0200
Message-ID: <20260725172133.4018491-22-pratyush@kernel.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260725172133.4018491-1-pratyush@kernel.org>
References: <20260725172133.4018491-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

HugeTLB pages can be preserved memory. So they are never allocated from
scratch. Instead, they are allocated from the memory blocks with no
preserved memory. These areas are detected at runtime on each boot.

But since they are allocated via memblock, they show up as RSRV_KERN,
and blow up the scratch size when scratch scale is in use.

All hugetlb pages are marked RSRV_HUGETLB. Subtract their size from
RSRV_KERN when calculating scratch sizes.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 kernel/liveupdate/kexec_handover.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 4c0756993b1f..1ccd7b7c59a1 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -742,19 +742,24 @@ early_param("kho_scratch", kho_parse_scratch_size);
 static void __init scratch_size_update(void)
 {
 	/*
-	 * If fixed sizes are not provided via command line, calculate them
-	 * now.
+	 * If fixed sizes are not provided via command line, calculate them now.
+	 * Remove HugeTLB allocations from it because they never get allocated
+	 * from scratch.
 	 */
 	if (scratch_scale) {
 		phys_addr_t size;
 
 		size = memblock_reserved_kern_size(ARCH_LOW_ADDRESS_LIMIT,
 						   NUMA_NO_NODE);
+		size -= memblock_reserved_hugetlb_size(ARCH_LOW_ADDRESS_LIMIT,
+						       NUMA_NO_NODE);
 		size = size * scratch_scale / 100;
 		scratch_size_lowmem = size;
 
 		size = memblock_reserved_kern_size(MEMBLOCK_ALLOC_ANYWHERE,
 						   NUMA_NO_NODE);
+		size -= memblock_reserved_hugetlb_size(MEMBLOCK_ALLOC_ANYWHERE,
+						       NUMA_NO_NODE);
 		size = size * scratch_scale / 100 - scratch_size_lowmem;
 		scratch_size_global = size;
 	}
@@ -774,6 +779,9 @@ static phys_addr_t __init scratch_size_node(int nid)
 	if (scratch_scale) {
 		size = memblock_reserved_kern_size(MEMBLOCK_ALLOC_ANYWHERE,
 						   nid);
+		/* Do not count HugeTLB pages. */
+		size -= memblock_reserved_hugetlb_size(MEMBLOCK_ALLOC_ANYWHERE,
+						       nid);
 		size = size * scratch_scale / 100;
 	} else {
 		size = scratch_size_pernode;
-- 
2.55.0.229.g6434b31f56-goog


