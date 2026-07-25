Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A74C53200
	for <kexec@archiver.kernel.org>; Sat, 25 Jul 2026 17:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yd2bfieu1qcZhsxx8oAIMmihW8bKAfo662I7j55iy3s=; b=2SvNtu3/teYg4Uu+d+jFvCxMXU
	zg4D1cKmXLWlN+EK6bTt0F45YEZlc86mTX9uFsTraRMJN/mj8WYBW+tXE6/GdRrOhZFxK3iKtNpaD
	GzYBajkvHMFakKwQ+FtEJN71+0v8qTbuV66mj2zhXMMdTXfFMbA5Rdwwhdv8tTSMEcg2r2uiZktzF
	8tzbdSMDUEO/jyDDsAcQz/Z2PTyT17jLENhXDvDkIC+r0d6pxWgyOJuyf53xjoWOpZGIjJLFOsDmh
	KlHkqx5zTNS5e4rV11c2knMPDHj0kFIXzTQMUY/uIsW9Cr87hcKjhsGRrj9QmoNiVPhO0YpkRBY6J
	6psP/rMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wng58-00000000aw9-3Z4E;
	Sat, 25 Jul 2026 17:22:38 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wng57-00000000aul-3iac
	for kexec@lists.infradead.org;
	Sat, 25 Jul 2026 17:22:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 547FE60A6E;
	Sat, 25 Jul 2026 17:22:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D637A1F00A3D;
	Sat, 25 Jul 2026 17:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785000157;
	bh=yd2bfieu1qcZhsxx8oAIMmihW8bKAfo662I7j55iy3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lrWixHpoWWqPvVE3Pd3ZKkwcMWzSEeQqjYEmmAxcXZuu0rVkQSqIh/sc8q+owTShG
	 LmBxn01+3aGedwidsFQNnmc9d2OHST/6zBcNnOnNmtWFB0hPDauVvOGCsAFDe4ov/D
	 FTd7Wa0oIB1Pw3lg/Jd0y5qSBR2vZwkkmzJTAVTHXqTfvcCVoQ/62F8YadS0krMINQ
	 idr37+7irSZ7l3QR/FXvC4ibk2gZVScfn6t8cYJi9ke7POigz9Uwuw5NEU3Tt1pbKd
	 tscuS5w7lmF2X27Q8DABS97Pc4/yVhVRjlB59sG9sWj87C9FZA4Vevcq1gchKzVOVX
	 viWXi/4fhPv2Q==
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
Subject: [PATCH v4 20/21] memblock: add memblock_reserved_hugetlb_size()
Date: Sat, 25 Jul 2026 19:21:20 +0200
Message-ID: <20260725172133.4018491-21-pratyush@kernel.org>
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
index ff470fd0fd10..78112b3f00d0 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1891,6 +1891,28 @@ phys_addr_t __init_memblock memblock_reserved_size(void)
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
2.55.0.229.g6434b31f56-goog


