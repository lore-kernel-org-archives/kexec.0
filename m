Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EB43C55175
	for <kexec@archiver.kernel.org>; Sat,  1 Aug 2026 08:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v3kXUz2Z2rDW9BnKcIvM/TL6/lSSMoYpc0koUm//CXU=; b=AxQNNHJBHG0iBG8Rx9QnwNdSGn
	B6mYiugNQY1tdHcmsv2YO4Q0JKjfca50u47N1kOlvjA7w7cGjzqNdB/xvDftTLPyj6Weiy6c91ne4
	DiW3Y9XyaGkmM0yTpKcG9jvqP/sElg0EyE2tMcFY1QH+hPs4OUpm6nlTaQbNPevfsKcZOsaovpG1D
	kKph2VdMFYayAz/dw8l/xpHARWtVpHi4zBEAxsF7Tnm9lHC/bJt9U8kXOZRjkN80+uhq/UNB0VmyF
	PyXWhe9HY6lEDN0pJi4EsjE493E3ZBDX9quaClPxvLetcLHDrpNHeeDgAJzM/sTA8sWjw1+55GNPK
	Ns2ZhvNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wq5PN-0000000E4qh-1k8J;
	Sat, 01 Aug 2026 08:49:29 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wq5PM-0000000E4pG-1tDA
	for kexec@lists.infradead.org;
	Sat, 01 Aug 2026 08:49:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DECF960AA4;
	Sat,  1 Aug 2026 08:49:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5921F00ADE;
	Sat,  1 Aug 2026 08:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785574167;
	bh=v3kXUz2Z2rDW9BnKcIvM/TL6/lSSMoYpc0koUm//CXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IgNuVO3ecZRiZnO66E61fzNWgHjg8+r203fe7t0v1iYhva313WTdnWnUOfZyONHkk
	 i7/aVSiBiapw7W6dmdrvfsnMWFIpglmqg7ccNGjzVDZq1M+t0gGjCwzmkwq7G4n0IB
	 uRthP/MB63J0+6mwIClV4OjKJJeGZ/QWz+BbeiyVcVhpFwRY1lfqRiviRYF9ioQMaL
	 DHGvhIVF0D4n+4ZqebVLqEX9dlL1BgkfkUkZ9Xgf+bW+4T5ACsKlhihPMvlAQ0yjtq
	 YxNnxNwx3tmNjpDLIVGjImpJCP5dLgwFlwPpoZvKvIfkq5UMFk7FQxCngJa5XNs0Vs
	 65dHIVuRteNbA==
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
Subject: [PATCH v6 14/22] kho: initialize kho_scratch pointer earlier in boot
Date: Sat,  1 Aug 2026 10:48:23 +0200
Message-ID: <20260801084833.1897543-15-pratyush@kernel.org>
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
2.55.0.571.g244d577d93-goog


