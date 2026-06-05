Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D553CD6E7E
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 18:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WPKtkl44aSyXLvNV0tx53TGY2duqMQJ5kATLVHTv48Q=; b=fOtdKMomICkvGqfjsvi7UNPFiB
	2eK1uF/IwiRfYMq3nvrMaShAWqz7q/2i9aUge3YBkaE5+dxlkRFC+HJgYQjytz8iYJiNqA8VFDYz0
	e38DLMpt70ppCUhApeuBRp7+2UGdrLrkwrRlei+nR4FDqdU+KhbbbIxtHAhxkBtcpgIw2h7GfKAJp
	3MbsOYiHt/2dQ00SGmBMBFtJftGay3UAKksCGjYpZdzj8VH7MWmZAYCQ7r0TRFVngGRla7Eb3U0R+
	WFDvOFWYVtMiGBTnzeKOLRCCvVbv409wVrnaZ6pCfR4ta23K6zXXcePoQILSEw5N4Mtu4/4FmTgbu
	fSHSmBZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVZOd-000000013ZM-3mKt;
	Fri, 05 Jun 2026 18:35:55 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVZOc-000000013YG-2e3Z
	for kexec@lists.infradead.org;
	Fri, 05 Jun 2026 18:35:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6622C40E28;
	Fri,  5 Jun 2026 18:35:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37AC11F00893;
	Fri,  5 Jun 2026 18:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780684554;
	bh=WPKtkl44aSyXLvNV0tx53TGY2duqMQJ5kATLVHTv48Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RDp1KNMzreXggo/k5UN4yM2Vg2nlZmZX0Wh5BFATiEUCiYt/OzIlMXhoid/ZuvPyN
	 o4JRp+ybptcE3KR0SR3U/GQFA/Br52X8PwyfyCE4K3xKLiNjlhROn0yP1az6fS50Wn
	 bckAsmKkXRIqSnpu1yJiHqNZVyowEnPJ10728SdPQGvjnMmzM9y1joufJMK910774F
	 lRXdWbT6mcNbofW9uEe0x5g2GSQFs7sdkzA/1xaMKVz39RhPwDt8/omJg0HDymZ245
	 xuO+UITtPc5kwdHIQEnEVE5tMo1s3yjeCbPEqych8hP8XehChB+QxjwGezXjXy/QBP
	 zU6rKaEGZ2Wig==
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
Subject: [PATCH v2 17/18] memblock: allow calculating reserved size by flags
Date: Fri,  5 Jun 2026 20:34:50 +0200
Message-ID: <20260605183501.3884950-18-pratyush@kernel.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <20260605183501.3884950-1-pratyush@kernel.org>
References: <20260605183501.3884950-1-pratyush@kernel.org>
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

memblock_reserved_kern_size() returns the total size of all reserved
areas flagged RSRV_KERN. KHO also needs total size of all reserved areas
flagged HUGETLB to correctly size its scratch areas.

Refactor memblock_reserved_kern_size() into
memblock_reserved_size_flags(). The new function returns total size of
all reserved areas which match _any_ of the flags.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 include/linux/memblock.h           |  3 ++-
 kernel/liveupdate/kexec_handover.c | 14 ++++++++------
 mm/memblock.c                      |  8 +++++---
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index b3b4a6145fad..a3b57066611d 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -487,7 +487,8 @@ static inline __init_memblock bool memblock_bottom_up(void)
 
 phys_addr_t memblock_phys_mem_size(void);
 phys_addr_t memblock_reserved_size(void);
-phys_addr_t memblock_reserved_kern_size(phys_addr_t limit, int nid);
+phys_addr_t memblock_reserved_size_flags(phys_addr_t limit, int nid,
+					 enum memblock_flags flags);
 unsigned long memblock_estimated_nr_free_pages(void);
 phys_addr_t memblock_start_of_DRAM(void);
 phys_addr_t memblock_end_of_DRAM(void);
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 8540608b8602..b3c33f150e85 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -749,13 +749,15 @@ static void __init scratch_size_update(void)
 	if (scratch_scale) {
 		phys_addr_t size;
 
-		size = memblock_reserved_kern_size(ARCH_LOW_ADDRESS_LIMIT,
-						   NUMA_NO_NODE);
+		size = memblock_reserved_size_flags(ARCH_LOW_ADDRESS_LIMIT,
+						    NUMA_NO_NODE,
+						    MEMBLOCK_RSRV_KERN);
 		size = size * scratch_scale / 100;
 		scratch_size_lowmem = size;
 
-		size = memblock_reserved_kern_size(MEMBLOCK_ALLOC_ANYWHERE,
-						   NUMA_NO_NODE);
+		size = memblock_reserved_size_flags(MEMBLOCK_ALLOC_ANYWHERE,
+						    NUMA_NO_NODE,
+						    MEMBLOCK_RSRV_KERN);
 		size = size * scratch_scale / 100 - scratch_size_lowmem;
 		scratch_size_global = size;
 	}
@@ -773,8 +775,8 @@ static phys_addr_t __init scratch_size_node(int nid)
 	phys_addr_t size;
 
 	if (scratch_scale) {
-		size = memblock_reserved_kern_size(MEMBLOCK_ALLOC_ANYWHERE,
-						   nid);
+		size = memblock_reserved_size_flags(MEMBLOCK_ALLOC_ANYWHERE,
+						    nid, MEMBLOCK_RSRV_KERN);
 		size = size * scratch_scale / 100;
 	} else {
 		size = scratch_size_pernode;
diff --git a/mm/memblock.c b/mm/memblock.c
index 131e54dd5d8d..cc21f877cb67 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1893,7 +1893,8 @@ phys_addr_t __init_memblock memblock_reserved_size(void)
 	return memblock.reserved.total_size;
 }
 
-phys_addr_t __init_memblock memblock_reserved_kern_size(phys_addr_t limit, int nid)
+phys_addr_t __init_memblock memblock_reserved_size_flags(phys_addr_t limit, int nid,
+							 enum memblock_flags flags)
 {
 	struct memblock_region *r;
 	phys_addr_t total = 0;
@@ -1908,7 +1909,7 @@ phys_addr_t __init_memblock memblock_reserved_kern_size(phys_addr_t limit, int n
 			size = limit - r->base;
 
 		if (nid == memblock_get_region_node(r) || !numa_valid_node(nid))
-			if (r->flags & MEMBLOCK_RSRV_KERN)
+			if (r->flags & flags)
 				total += size;
 	}
 
@@ -1930,7 +1931,8 @@ phys_addr_t __init_memblock memblock_reserved_kern_size(phys_addr_t limit, int n
 unsigned long __init memblock_estimated_nr_free_pages(void)
 {
 	return PHYS_PFN(memblock_phys_mem_size() -
-			memblock_reserved_kern_size(MEMBLOCK_ALLOC_ANYWHERE, NUMA_NO_NODE));
+			memblock_reserved_size_flags(MEMBLOCK_ALLOC_ANYWHERE, NUMA_NO_NODE,
+						     MEMBLOCK_RSRV_KERN));
 }
 
 /* lowest address */
-- 
2.54.0.1032.g2f8565e1d1-goog


