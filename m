Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57BA0C44506
	for <kexec@archiver.kernel.org>; Thu,  9 Jul 2026 17:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XRWHX7zMVtBNXHZRqDliEz73l607WKYgb2CCZt52nTM=; b=ObcInvo2Ype/8GwUjW30h97jYp
	vbAGbXhrt89ZK5XjASIM9L3wcib4hn85rIS9atUKOwWK1nzQr9x2omSAzKWVoDvSW8q+KUPK1VStI
	wuGY0r1COhFqyBFawMGpfdywqnl1fFAjSF3EcZgqEFm2TBUwdK4fz1kKGa0kDOKcJEp00/gY1n67D
	Iv53UUD3Xnrq1qasV0Es9c+7mDjzgNZndLPswx/bBoCq+78wJcdviptOq9c+t75yoKfZM94dxEkeY
	xLFmHx2NDbVkV0+Zyf1jSKTZ5j77P5XmrJ24VbqW5GtuwrurdNIOlgWYEvynPAjjQKfPiCH2sQypN
	MqJDsAtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whsiM-000000038P1-2xh2;
	Thu, 09 Jul 2026 17:39:10 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whsiK-000000038NB-3dfe
	for kexec@lists.infradead.org;
	Thu, 09 Jul 2026 17:39:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5272361836;
	Thu,  9 Jul 2026 17:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E181F00A3A;
	Thu,  9 Jul 2026 17:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783618748;
	bh=XRWHX7zMVtBNXHZRqDliEz73l607WKYgb2CCZt52nTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NP7n7JZ9Rsq1UO8wAMpyzD3u7hK4XgRdKJqYMf3NGmnjFDasuqjeoZBnMCWUoF6GB
	 f1ci5JPw4rwRrGPTvwjC/dTnPw1s4Mh6ye2rrl9Y6YuMjGIL7NQGIQvtrkrEKz8gtK
	 EK8kmQgMLm6sgLnfpRjJ5bME6hQrtCrg6ZCYyXX/l0T8PStyNZ9/w+FstjBK+NxU/W
	 RuBck4m0VsEySc92EWwrojZeHbI+WgQGyRsbY5RGT66kNe4377F/QDerVTGDHXtDHb
	 n1s1omuYv14J7fgIi4wf4bCdSiICgQEKHmpBB1xOIukRhMjCt4MzgFDKwM5UtpgfhO
	 aqnx/ryim+bTg==
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
Subject: [PATCH v3 14/21] kho: initialize kho_scratch pointer earlier in boot
Date: Thu,  9 Jul 2026 19:38:03 +0200
Message-ID: <20260709173821.429921-15-pratyush@kernel.org>
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
 kernel/liveupdate/kexec_handover.c | 15 +++++++++++++--
 mm/mm_init.c                       |  1 +
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 40cb95a80981..18ba417f1ada 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -33,6 +33,7 @@ void kho_remove_subtree(void *blob);
 int kho_retrieve_subtree(const char *name, phys_addr_t *phys, size_t *size);
 
 void kho_memory_init(void);
+void kho_memory_init_early(void);
 
 void kho_populate(phys_addr_t fdt_phys, u64 fdt_len, phys_addr_t scratch_phys,
 		  u64 scratch_len);
@@ -110,6 +111,8 @@ static inline int kho_retrieve_subtree(const char *name, phys_addr_t *phys,
 
 static inline void kho_memory_init(void) { }
 
+static inline void kho_memory_init_early(void) { }
+
 static inline void kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
 				phys_addr_t scratch_phys, u64 scratch_len)
 {
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index b3b97a6ff9c8..2ddfc804cdf7 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1534,8 +1534,6 @@ static void __init kho_mem_retrieve(void)
 	const void *fdt = kho_get_fdt();
 	int err;
 
-	kho_scratch = phys_to_virt(kho_in.scratch_phys);
-
 	/*
 	 * kho_get_mem_map() should always succeed. If it fails, kho_populate()
 	 * catches that and never sets kho_in.scratch_phys, which stops memory
@@ -1756,6 +1754,19 @@ static __init int kho_init(void)
 }
 fs_initcall(kho_init);
 
+void __init kho_memory_init_early(void)
+{
+	if (!is_kho_boot())
+		return;
+
+	/*
+	 * kho_scratch_overlap() needs kho_scratch to be initialized. It
+	 * is used by free_area_init() on KHO boots, so initialize it
+	 * early.
+	 */
+	kho_scratch = phys_to_virt(kho_in.scratch_phys);
+}
+
 void __init kho_memory_init(void)
 {
 	if (kho_in.scratch_phys)
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 0f64909e8d20..84d4b1c997bc 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2687,6 +2687,7 @@ void __init __weak mem_init(void)
 
 void __init mm_core_init_early(void)
 {
+	kho_memory_init_early();
 	hugetlb_cma_reserve();
 	hugetlb_bootmem_alloc();
 
-- 
2.55.0.141.g00534a21ce-goog


