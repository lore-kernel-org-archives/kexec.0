Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544C4CD6E7B
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 18:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MPgTzFffYY8+ZzNyhPkuE1ZkvrAANKQQVvr8ndIw9wg=; b=xoo7c3NyrnHHI7sTkvv/jSyYRs
	VUH7kDI+ScN6SUcawflfveh4Y8wbtVgJr6cS1ycegfI6C7Ep5F+Cbo1vBa+0JogNheacZnkSdozj8
	N3m5PODFGB53diA8jt2w49r1zNeooNekXB+oBxf8QPoyrME7pTh8Hb2nA6oMsorg/VUjEQIBi3cbc
	hlD+HQyFxK6B+tOXqzNZwlwZGr6jaexWL6L2cCsxmWUl0YF9hBF7LUrRt6/au9XNjY7PyXm8UKGdb
	f58aFpv8wJAywU5gqr9eqzOStOF4AfH66aM0Mp68Of04R94JdiWBMTXkhYkiXFkxHBMZCDUWzm7i1
	/LHuiD9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVZOT-000000013PF-1Uyo;
	Fri, 05 Jun 2026 18:35:45 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVZOS-000000013Nq-3JXS
	for kexec@lists.infradead.org;
	Fri, 05 Jun 2026 18:35:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8AB0D42B06;
	Fri,  5 Jun 2026 18:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1941F0089B;
	Fri,  5 Jun 2026 18:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780684544;
	bh=MPgTzFffYY8+ZzNyhPkuE1ZkvrAANKQQVvr8ndIw9wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BydKaYKsPPMaQYb1m+R//+fdgzANeeVCNM2zxeJ3Ypk4tYKIYwwCiv9GLWp4ulG1h
	 Hc0purKydXxPZ3b9Mx47+4HFBVaDU+3r7gQGNx/2yAa3EfqD+rQdVRvVDlrHpMsPDW
	 bW5KJdUUu3EF28QEw65ZeOfcTPHx3ZyqRN2Pl8WUd/c8pPfpC41wFOsOqYPfXs7Flb
	 vtRghhCn81f64hN8Gbj0kumucDSXUFDTX5zyeWyDBkFFc30dUcc9meDdHNPc18VGId
	 U5YcKmUUpNpAS/Tl6BvmYi4/U4k/iJw2G0iQX3Y1aSUT/0sF1Cwo+Cv0Bi7hTXg2nV
	 3wRBscIKlW1Bw==
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
Subject: [PATCH v2 13/18] kho: initialize kho_scratch pointer earlier in boot
Date: Fri,  5 Jun 2026 20:34:46 +0200
Message-ID: <20260605183501.3884950-14-pratyush@kernel.org>
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

In a future patch, mm init will use kho_scratch_overlap() for deciding
the migrate type of pageblocks it initializes. The earliest user
currently is free_area_init(). kho_scratch_overlap()
relies on kho_scratch pointer being initialized. Introduce
kho_memory_init_early() to do this.

kho_populate() would normally be a good place to do this, but
unfortunately, phys_to_virt() does not work at that point on ARM64. So
we need yet another initialization function.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
 include/linux/kexec_handover.h     |  3 +++
 kernel/liveupdate/kexec_handover.c | 12 ++++++++++--
 mm/mm_init.c                       |  1 +
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 3740c14d970d..9e961032e06b 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -37,6 +37,7 @@ void kho_remove_subtree(void *blob);
 int kho_retrieve_subtree(const char *name, phys_addr_t *phys, size_t *size);
 
 void kho_memory_init(void);
+void kho_memory_init_early(void);
 
 void kho_populate(phys_addr_t fdt_phys, u64 fdt_len, phys_addr_t scratch_phys,
 		  u64 scratch_len);
@@ -114,6 +115,8 @@ static inline int kho_retrieve_subtree(const char *name, phys_addr_t *phys,
 
 static inline void kho_memory_init(void) { }
 
+static inline void kho_memory_init_early(void) { }
+
 static inline void kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 				phys_addr_t scratch_phys, u64 scratch_len)
 {
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index a66f23a35389..af22086ca2d6 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1535,8 +1535,6 @@ static void __init kho_mem_retrieve(void)
 	const void *fdt = kho_get_fdt();
 	int err;
 
-	kho_scratch = phys_to_virt(kho_in.scratch_phys);
-
 	/*
 	 * kho_get_mem_map() should always succeed. If it fails, kho_populate()
 	 * catches that and never sets kho_in.scratch_phys, which stops memory
@@ -1757,6 +1755,16 @@ static __init int kho_init(void)
 }
 fs_initcall(kho_init);
 
+void __init kho_memory_init_early(void)
+{
+	/*
+	 * kho_scratch_overlap() needs kho_scratch to be initialized. It is used
+	 * by free_area_init() on KHO boots, so initialize it early.
+	 */
+	if (kho_in.scratch_phys)
+		kho_scratch = phys_to_virt(kho_in.scratch_phys);
+}
+
 void __init kho_memory_init(void)
 {
 	if (kho_in.scratch_phys)
diff --git a/mm/mm_init.c b/mm/mm_init.c
index eddc0f03a779..0675837bbfc9 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2688,6 +2688,7 @@ void __init __weak mem_init(void)
 
 void __init mm_core_init_early(void)
 {
+	kho_memory_init_early();
 	hugetlb_cma_reserve();
 	hugetlb_bootmem_alloc();
 
-- 
2.54.0.1032.g2f8565e1d1-goog


