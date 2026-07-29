Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B952CC54F55
	for <kexec@archiver.kernel.org>; Wed, 29 Jul 2026 14:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lzc973wrpBvl2rlA3xdelaF9rXhGdCJv6jnQryQfQag=; b=gagbYIVZTRmQe38GKdlcAfwqg7
	g0wQWohcuaSRT8JJMi9rwcj5TIFWIewikH2Vfmgds/DZx+9NfX0inEZr6q/BXxM6gJBN5yVDs4jtv
	Dbj5KiF8dXKa0waqp0fJp3nMkHny653WH6Y1s+QWZgFTFT/p3uBfJNGYxdutSVEorWphQD3CqrAeM
	DJGqWgoV33SVgs8GBl/Kf0QPBvBfOvSEM8iyXGjb78lt8J0BoAg2CNvF0hHCUdZlyHu8byPkkxfPA
	e0kYf42QcPP4cqDFYzDexTFov6ijBen6GwYedVeX2a7HaEW6hue9BXcRIOrclcVZsA5TBWCyOaqdI
	Wt1Ic/9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp5ih-00000008Jek-2ZEy;
	Wed, 29 Jul 2026 14:57:19 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp5if-00000008JcX-2MAw
	for kexec@lists.infradead.org;
	Wed, 29 Jul 2026 14:57:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 04851600BC;
	Wed, 29 Jul 2026 14:57:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861861F00A3A;
	Wed, 29 Jul 2026 14:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785337036;
	bh=Lzc973wrpBvl2rlA3xdelaF9rXhGdCJv6jnQryQfQag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EIlg5X7DHxSwfw45OQMrO1e+tdKJl3H5HoRQn7bw1lvRhCT/1qTvoruee3GbsKFaZ
	 Dx4FKZJoNEifrcSBreQ7rWPhXIu2KBIOnUV8alkolgAkvh2tkjkAEDDLTAMeZgnmT/
	 zEdtk3uEyZaptDOZtHpYw/2Y9Zt23OKLRso60zx3Ph5PXXjUAG2ZYfTTtBvJjbAsAD
	 rBNT2dkLTAhh0hNa9Goqw2acttyw/0YzyLZ5PKZcp+5W7Ng2PHGiIxDJ/9el0hnBC/
	 AJblsf0WWsO4h0vNlU0KRdjI5gaFWMg9xm7JUj7+Fao6Nitnoju2BtH01qvXP0oQ0u
	 vuDP+8MOxQIaQ==
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
Subject: [PATCH v5 21/22] memblock: add memblock_reserved_hugetlb_size()
Date: Wed, 29 Jul 2026 16:56:06 +0200
Message-ID: <20260729145610.2827231-22-pratyush@kernel.org>
X-Mailer: git-send-email 2.55.0.508.g3f0d502094-goog
In-Reply-To: <20260729145610.2827231-1-pratyush@kernel.org>
References: <20260729145610.2827231-1-pratyush@kernel.org>
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

Similar to memblock_reserved_kern_size(), but calculates only the memory
reserved for hugetlb pages. This is needed in an upcoming commit that
subtracts hugetlb reservation size when computing the size of KHO
scratch areas.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 include/linux/memblock.h |  1 +
 mm/memblock.c            | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 678fe466529a..d62db9e776cf 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -487,6 +487,7 @@ static inline __init_memblock bool memblock_bottom_up(void)
 phys_addr_t memblock_phys_mem_size(void);
 phys_addr_t memblock_reserved_size(void);
 phys_addr_t memblock_reserved_kern_size(phys_addr_t limit, int nid);
+phys_addr_t memblock_reserved_hugetlb_size(phys_addr_t limit, int nid);
 unsigned long memblock_estimated_nr_free_pages(void);
 phys_addr_t memblock_start_of_DRAM(void);
 phys_addr_t memblock_end_of_DRAM(void);
diff --git a/mm/memblock.c b/mm/memblock.c
index 77c6540e7528..37e06e70c1d0 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1899,6 +1899,28 @@ phys_addr_t __init_memblock memblock_reserved_size(void)
 	return memblock.reserved.total_size;
 }
 
+phys_addr_t __init_memblock memblock_reserved_hugetlb_size(phys_addr_t limit, int nid)
+{
+	struct memblock_region *r;
+	phys_addr_t total = 0;
+
+	for_each_reserved_mem_region(r) {
+		phys_addr_t size = r->size;
+
+		if (r->base > limit)
+			break;
+
+		if (r->base + r->size > limit)
+			size = limit - r->base;
+
+		if (nid == memblock_get_region_node(r) || !numa_valid_node(nid))
+			if (r->flags & MEMBLOCK_RSRV_HUGETLB)
+				total += size;
+	}
+
+	return total;
+}
+
 phys_addr_t __init_memblock memblock_reserved_kern_size(phys_addr_t limit, int nid)
 {
 	struct memblock_region *r;
-- 
2.55.0.508.g3f0d502094-goog


