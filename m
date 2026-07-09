Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254F6C43458
	for <kexec@archiver.kernel.org>; Thu,  9 Jul 2026 17:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GIKLTijiKnBgrZXcLoBE8VlZLtn/daTEtdVuzKJ4kpE=; b=aZGk3xFfCda4BQKce715C0u0+d
	2u/IUjVHGkd1XyFNi+u5Zf5WtAwoU8BcKPXfhOP05BduOhbMe51QBGPXzVBxEy/5+velUAnXIQNV+
	wfet0pvbIfpo3F/SPcIxPyb9+fD3GYMqsIeb7ZY9/VaTnutqyL+IXaxZxRLovRABQ/D1nbG49l3fp
	zR5qILYYQjBKTxUnQP+6/HqBE4oIIi6P5/tgxg8w+G/2rkaJrcMw+gIs18vJtvUwPbJv7KFz+ULr8
	1bnK9MG7jHVUwbMm7YUOnO/dgY94+mrCzoI5XkC1i9PzCzRPfksrcSVy6a3I3+F4AgAdPczDLdNbh
	1EqIxvHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whsib-000000038do-1ZZQ;
	Thu, 09 Jul 2026 17:39:25 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whsia-000000038c5-0X0O
	for kexec@lists.infradead.org;
	Thu, 09 Jul 2026 17:39:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8F83561381;
	Thu,  9 Jul 2026 17:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22EA91F00A3A;
	Thu,  9 Jul 2026 17:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783618763;
	bh=GIKLTijiKnBgrZXcLoBE8VlZLtn/daTEtdVuzKJ4kpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a+g1M1oDufFBFZydVBdmxrJjcJaTrBCkRDeT/XIBd08gpl1wEoGlOx3f13NjoUa+p
	 wz1WAATyzMrRkjhi+H64P2b6Bzm83+JmjSoyqq1LWfsOI76/LkKfRC7DG69mlPIv8C
	 tkjd7rX6MvY6qfRw2mP3UoERGmt27c201PhOHzc/tgA5jlTaH6HQQproNWA9K3dT23
	 sWMjZ34E+MFNA4NmEVtItaSSytuQQNYhNbh63AB7+CWuLCogtgGuI+eO25fU1/s9bl
	 dsjc4ZcnKzfO3y3E5gHiFsAhhspI8y9QvbfVeO6I1/SL/7jnP1yjS/dQnLYUszCTZy
	 EpVxJLH7hSQpQ==
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
Subject: [PATCH v3 20/21] memblock: add memblock_reserved_hugetlb_size()
Date: Thu,  9 Jul 2026 19:38:09 +0200
Message-ID: <20260709173821.429921-21-pratyush@kernel.org>
X-Mailer: git-send-email 2.55.0.141.g00534a21ce-goog
In-Reply-To: <20260709173821.429921-1-pratyush@kernel.org>
References: <20260709173821.429921-1-pratyush@kernel.org>
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
index ba6d887ea18e..c10dfb054806 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1893,6 +1893,28 @@ phys_addr_t __init_memblock memblock_reserved_size(void)
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
2.55.0.141.g00534a21ce-goog


