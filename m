Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2269CA0FED
	for <kexec@archiver.kernel.org>; Wed, 10 Sep 2025 15:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nRhvh92md5YLQu0jiJRzH2Mud3pm9hiYLYtMu8GjEyE=; b=OT/EMKVLHW/CO2k6uj0nRMVA8y
	SSCVjhClEMrp4swWhQrfLobbQZUrhbdFNA83rkhRam2P9w60lHRWgy15xyzaQRxMOg9rAX+gqJVka
	Dr4Buuo7WK5ym1MghMem4aBfRHH9GgeEOktlQ2jaJP5uQqwP2RUI1o/Bbv2D1Jr3KeorGo6Hl8qE8
	POPMWHdhXpK3Qsk1LDwXHNO1ZZXqDfjd8KT3U3djMXUeaZ5fvV1IA59BPwKCEWJr9KCGa/RmxVk+Z
	LMPd2JmpeiAuKkCfZmb1QJ7AHu+OQyFEUmII07e4vM3yLgTk3j0JGU8bMhB8Q0Zy3forUQmGr9hhY
	2whxRliQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwMqY-0000000F99l-3NQt;
	Wed, 10 Sep 2025 15:34:58 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwMqX-0000000F98Y-0TdZ
	for kexec@lists.infradead.org;
	Wed, 10 Sep 2025 15:34:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3EF35440B1;
	Wed, 10 Sep 2025 15:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557A1C4CEEB;
	Wed, 10 Sep 2025 15:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757518496;
	bh=ylywEWdpuWY9ksOD7npdckXIkyDG0CoNTtEKj9xRWlw=;
	h=From:To:Cc:Subject:Date:From;
	b=rhQLMmvm6dRoXeNpFCfCLVpoY7KvfC8BQX1DDVQqPnV+bvyH28j+DR3zV5mNbG15k
	 qII2i91velnS0+nJmr0iQjTnd1tzaXScjDorFCIqvs0rH/xxjofCBUdJWiHvW4F+G6
	 ugswwcbJzFRZGRl2CqG1tCXrMAenb8EFyarnsSanweQl1BsoXWnzlZ/+Pac0y+5Kdl
	 wHduKm9o9OU3V/y5/Cuv7Wh1LpDiBF7l3vJPhld6lR4lX2gTvzJhWWoTcgnVQr3dD/
	 SpRiF5H8Shzux16IcqivEpu60ih9iK6IJKRCPO/N1gpPtAz/wIT8YFOZ01/9O4SnXb
	 F5ocWTAWcmZKw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Chris Li <chrisl@kernel.org>,
	Jason Miu <jasonmiu@google.com>
Cc: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [PATCH] kho: make sure folio being restored is actually from KHO
Date: Wed, 10 Sep 2025 17:34:40 +0200
Message-ID: <20250910153443.95049-1-pratyush@kernel.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250910_083457_193980_478B4A6B 
X-CRM114-Status: GOOD (  15.77  )
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

When restoring a folio using kho_restore_folio(), no sanity checks are
done to make sure the folio actually came from a kexec handover. The
caller is trusted to pass in the right address. If the caller has a bug
and passes in a wrong address, an in-use folio might be "restored" and
returned, causing all sorts of memory corruption.

Harden the folio restore logic by stashing in a magic number in
page->private along with the folio order. If the magic number does not
match, the folio won't be touched. page->private is an unsigned long.
The union kho_page_info splits it into two parts, with one holding the
order and the other holding the magic number.

Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
---
 kernel/kexec_handover.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index ecd1ac210dbd7..68eb3c28abe41 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -32,6 +32,22 @@
 #define PROP_PRESERVED_MEMORY_MAP "preserved-memory-map"
 #define PROP_SUB_FDT "fdt"
 
+#define KHO_PAGE_MAGIC 0x4b484f50U /* ASCII for 'KHOP' */
+
+/*
+ * KHO uses page->private, which is an unsigned long, to store page metadata.
+ * Use it to store both the magic and the order.
+ */
+union kho_page_info {
+	unsigned long page_private;
+	struct {
+		unsigned int order;
+		unsigned int magic;
+	};
+};
+
+static_assert(sizeof(union kho_page_info) == sizeof(((struct page *)0)->private));
+
 static bool kho_enable __ro_after_init;
 
 bool kho_is_enabled(void)
@@ -210,16 +226,16 @@ static void kho_restore_page(struct page *page, unsigned int order)
 struct folio *kho_restore_folio(phys_addr_t phys)
 {
 	struct page *page = pfn_to_online_page(PHYS_PFN(phys));
-	unsigned long order;
+	union kho_page_info info;
 
 	if (!page)
 		return NULL;
 
-	order = page->private;
-	if (order > MAX_PAGE_ORDER)
+	info.page_private = page->private;
+	if (info.magic != KHO_PAGE_MAGIC || info.order > MAX_PAGE_ORDER)
 		return NULL;
 
-	kho_restore_page(page, order);
+	kho_restore_page(page, info.order);
 	return page_folio(page);
 }
 EXPORT_SYMBOL_GPL(kho_restore_folio);
@@ -341,10 +357,13 @@ static void __init deserialize_bitmap(unsigned int order,
 		phys_addr_t phys =
 			elm->phys_start + (bit << (order + PAGE_SHIFT));
 		struct page *page = phys_to_page(phys);
+		union kho_page_info info;
 
 		memblock_reserve(phys, sz);
 		memblock_reserved_mark_noinit(phys, sz);
-		page->private = order;
+		info.magic = KHO_PAGE_MAGIC;
+		info.order = order;
+		page->private = info.page_private;
 	}
 }
 

base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
-- 
2.47.3


