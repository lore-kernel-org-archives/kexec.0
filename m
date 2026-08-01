Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DC5C55174
	for <kexec@archiver.kernel.org>; Sat,  1 Aug 2026 08:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8jWUj8mEuI70BURr/iwksxqdZh09vWaLH/yvaQwQxNw=; b=l+kBSAT9Y52toOsqz/VnTswQ7V
	YF98Q5h2e6jIGRr7ApsasBS17RrI761ukrQM61S823dALpSCpzsZnhz200JR5xTmv+l7hIx6/DB9t
	AoClGU7nsZfqQpCNSuJTFo+fkliHLtiNkOBmhh6JLq/wN/RFQtZdFeogk5kMj2XVGdp8nVXBQflcL
	sK+PtaFJKrV6oLj4hXN9FsPbH3DmsyrSebV/OKYIkf+Y8Mh8q8Jj8OTBT2hVEqU+XB42YmuO8oD5m
	yzlk2qTs7FIfk4Pu4aOEO6GlQZHsn8t8RXpuNgWLzLB8K6pj/0miZ+GcUxI6nAqvUahILzqc9tStI
	ElBN7qxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wq5Pf-0000000E5CT-3bhk;
	Sat, 01 Aug 2026 08:49:47 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wq5Pe-0000000E5AI-1vv1
	for kexec@lists.infradead.org;
	Sat, 01 Aug 2026 08:49:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B70564077F;
	Sat,  1 Aug 2026 08:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E071F00ADB;
	Sat,  1 Aug 2026 08:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785574185;
	bh=8jWUj8mEuI70BURr/iwksxqdZh09vWaLH/yvaQwQxNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bzWr+9fMDT40ul//Wh0slIyzzEidBdejxO5cR7NbPRtOVVvAqGyj34Wcjl0GVsVL/
	 e5AAu7R5FuHpcwcl0vT5OxO4mOGW6ILzHpmz1KtFmnmjro7qyVe+AFD+y2/hzuRoeR
	 /Hu3VoM24gw7pmHajQ3lZpvlkeatiCzIECuyvAIw4f7aG4fZf+RCCf3dQv4wsPaSDA
	 Qjh2zuOfvgXZucv5/6fXHsA2A8fVnoSZGc3IFtIq6SHTpqIt6xJv+tlsXY0H6I+VmU
	 IkJQNnthGSgjr3scbIY1IHtNXps73QQ06RmRq9jsU1okpl4j6xT0vNrXsqKoMLoN1R
	 MgEOeKb/B0UXA==
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
Subject: [PATCH v6 21/22] memblock: add memblock_reserved_hugetlb_size()
Date: Sat,  1 Aug 2026 10:48:30 +0200
Message-ID: <20260801084833.1897543-22-pratyush@kernel.org>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
In-Reply-To: <20260801084833.1897543-1-pratyush@kernel.org>
References: <20260801084833.1897543-1-pratyush@kernel.org>
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
2.55.0.571.g244d577d93-goog


