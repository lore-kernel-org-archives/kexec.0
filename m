Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF82C5AD2B
	for <kexec@archiver.kernel.org>; Fri, 20 Feb 2026 16:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/cSTzAkt5CK3RH1LCsoiWKzafA/Onxi/2uJ8AKZyka0=; b=f5KCsyIgUB6GuJQjp+PHhRuy64
	Np8UmfOLckXhs2j7QJbjac92g2XXxC/dvvH98TkA94iagec5lBB1HU4+v/J3bT+9lakEniVgvlYwc
	hrxHx3DH79iJBGxxgfm63FZe8oB/iM23uUxI4j8yz9ciJ3SiVOkAfNZT7Sw/lOkjGyVHi/7fd0Bai
	q8mYiehHeyB7Yafd0ucaSYd9OFqyVTOsWySkO5PwNHF6c5T7kNlt/IaR8elr3FaAt+dvCW3kYkEKu
	SAYAeYYuZQmmfijJKkA3G4HoMg20Zoz4BnbFrBjLkF0AnEUkUOWEppm8k0pTkT4eNncO/xMEBy8ZO
	uyw8d9nA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtTjk-0000000FKfG-1Iwj;
	Fri, 20 Feb 2026 16:52:16 +0000
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtTji-0000000FKdz-2zXL
	for kexec@lists.infradead.org;
	Fri, 20 Feb 2026 16:52:15 +0000
Received: by mail-wm1-x349.google.com with SMTP id 5b1f17b1804b1-4836e35292cso21200685e9.1
        for <kexec@lists.infradead.org>; Fri, 20 Feb 2026 08:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771606332; x=1772211132; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/cSTzAkt5CK3RH1LCsoiWKzafA/Onxi/2uJ8AKZyka0=;
        b=QOndTj+GV3L8hJJVDtvIxtPX9TTvEbiAL5GYkz/Q/39vIcj1LZBJuv113B6r8hwp34
         sCdCeb/DwYwvzBa1W/o61FXVZYmkDr99Goa6Bg6tbPMcy1d3b4ouPPvaBiX0xkorB6Lt
         m7PgetNuA2X2doXhIR2xqo9fRCUPTBA0m6DwwYmr6QP07lVvl9BPj7FlppxovFFCUGNV
         au3v0r1iBzU3hzW1YGVJGkzN4DBl7muBnTlweV9vYDm2xAGzhCmWgWd0igDFoz9DIWSt
         DoGKM1wm+ChnHuo6Rdynf+Dq/C7N2xghOsU53ElqRDTsKvainO4BhkhHnZm18PpH8VrD
         N+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771606332; x=1772211132;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/cSTzAkt5CK3RH1LCsoiWKzafA/Onxi/2uJ8AKZyka0=;
        b=ek+49pRvW57y4/MfuuRtGK8nI+RFg2lYwCXo4kPYqSNMOd/r3IzJEMBXjsjg+E8ZP4
         +olAqTUdc7z5e357hlU+EtdGfASmv39dHyL0Mc8fiypv+CNCjrogBFEiq7EKuMO7WR0Y
         pLtbtsETrQclImFdCo3WUGQ55vRw7mf62CJPUEjHLOMfXgA8FBcTAPva5X51GKgt4ugn
         OiKach6eWyFPnGkDltsk5NxaNDPNUeuKAYHp9bI2dnmV6Oskc7uS7qU8oyRo+95o2uDf
         vLPF9CA9VZYK90VJc71Nw8UAH6nhIisyywe6y/+Ud6TOWjtBLu08kWL067Pd0rR9JKyO
         b5Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVrT2pmixMcc1GDB0s1xkPFfFzzF+W8plDPsdEUQ2DWzHLhuPddmuyEvlP5IOkEUwPvKCzr8g==@lists.infradead.org
X-Gm-Message-State: AOJu0YxDsoFoVRJyhyVpreEc5ZL0hu4jKkJY6pbJ1ZS5hZLVBz2l4zAl
	uzrhSG+li+wqnOx6HmolYEOM5ni+v6CKU3jNlLUutjFLFLw41q2XxxJl0UlsX/V+QO8mANnv8zC
	ScuD4Uchu1ZUFmQU3KXz2TQ==
X-Received: from wmhn17.prod.google.com ([2002:a05:600c:3051:b0:480:4a03:7b79])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3153:b0:480:3b4e:41b8 with SMTP id 5b1f17b1804b1-483a9603c07mr2950695e9.33.1771606332067;
 Fri, 20 Feb 2026 08:52:12 -0800 (PST)
Date: Fri, 20 Feb 2026 17:52:02 +0100
In-Reply-To: <20260220165203.3213375-1-mclapinski@google.com>
Mime-Version: 1.0
References: <20260220165203.3213375-1-mclapinski@google.com>
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Message-ID: <20260220165203.3213375-2-mclapinski@google.com>
Subject: [PATCH v4 1/2] kho: fix deferred init of kho scratch
From: Michal Clapinski <mclapinski@google.com>
To: Evangelos Petrongonas <epetron@amazon.de>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	kexec@lists.infradead.org, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_085214_794752_0FCBAFA9 
X-CRM114-Status: GOOD (  16.12  )
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

Currently, mm_core_init calls kho_memory_init, which calls
kho_release_scratch.

If DEFERRED is enabled, kho_release_scratch will first initialize the
struct pages of kho scratch. This is not needed. We can just let
page_alloc_init_late init it.

Next, kho_release_scratch will mark scratch as MIGRATE_CMA. If DEFERRED
is enabled, this will be overwritten later in deferred_free_pages.

To fix this, I removed the whole kho_release_scratch.
Marking the pageblocks as MIGRATE_CMA now happens in kho_init, which
runs after deferred_free_pages.

Signed-off-by: Michal Clapinski <mclapinski@google.com>
---
 include/linux/memblock.h           |  2 --
 kernel/liveupdate/kexec_handover.c | 43 ++++++++----------------------
 mm/memblock.c                      | 22 ---------------
 3 files changed, 11 insertions(+), 56 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 221118b5a16e..35d9cf6bbf7a 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -614,11 +614,9 @@ static inline void memtest_report_meminfo(struct seq_file *m) { }
 #ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
 void memblock_set_kho_scratch_only(void);
 void memblock_clear_kho_scratch_only(void);
-void memmap_init_kho_scratch_pages(void);
 #else
 static inline void memblock_set_kho_scratch_only(void) { }
 static inline void memblock_clear_kho_scratch_only(void) { }
-static inline void memmap_init_kho_scratch_pages(void) {}
 #endif
 
 #endif /* _LINUX_MEMBLOCK_H */
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index b851b09a8e99..de167bfa2c8d 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1377,11 +1377,6 @@ static __init int kho_init(void)
 	if (err)
 		goto err_free_fdt;
 
-	if (fdt) {
-		kho_in_debugfs_init(&kho_in.dbg, fdt);
-		return 0;
-	}
-
 	for (int i = 0; i < kho_scratch_cnt; i++) {
 		unsigned long base_pfn = PHYS_PFN(kho_scratch[i].addr);
 		unsigned long count = kho_scratch[i].size >> PAGE_SHIFT;
@@ -1397,8 +1392,17 @@ static __init int kho_init(void)
 		 */
 		kmemleak_ignore_phys(kho_scratch[i].addr);
 		for (pfn = base_pfn; pfn < base_pfn + count;
-		     pfn += pageblock_nr_pages)
-			init_cma_reserved_pageblock(pfn_to_page(pfn));
+		     pfn += pageblock_nr_pages) {
+			if (fdt)
+				init_cma_pageblock(pfn_to_page(pfn));
+			else
+				init_cma_reserved_pageblock(pfn_to_page(pfn));
+		}
+	}
+
+	if (fdt) {
+		kho_in_debugfs_init(&kho_in.dbg, fdt);
+		return 0;
 	}
 
 	WARN_ON_ONCE(kho_debugfs_fdt_add(&kho_out.dbg, "fdt",
@@ -1421,35 +1425,10 @@ static __init int kho_init(void)
 }
 fs_initcall(kho_init);
 
-static void __init kho_release_scratch(void)
-{
-	phys_addr_t start, end;
-	u64 i;
-
-	memmap_init_kho_scratch_pages();
-
-	/*
-	 * Mark scratch mem as CMA before we return it. That way we
-	 * ensure that no kernel allocations happen on it. That means
-	 * we can reuse it as scratch memory again later.
-	 */
-	__for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
-			     MEMBLOCK_KHO_SCRATCH, &start, &end, NULL) {
-		ulong start_pfn = pageblock_start_pfn(PFN_DOWN(start));
-		ulong end_pfn = pageblock_align(PFN_UP(end));
-		ulong pfn;
-
-		for (pfn = start_pfn; pfn < end_pfn; pfn += pageblock_nr_pages)
-			init_pageblock_migratetype(pfn_to_page(pfn),
-						   MIGRATE_CMA, false);
-	}
-}
-
 void __init kho_memory_init(void)
 {
 	if (kho_in.mem_map_phys) {
 		kho_scratch = phys_to_virt(kho_in.scratch_phys);
-		kho_release_scratch();
 		kho_mem_deserialize(phys_to_virt(kho_in.mem_map_phys));
 	} else {
 		kho_reserve_scratch();
diff --git a/mm/memblock.c b/mm/memblock.c
index 6cff515d82f4..3eff19124fc0 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -959,28 +959,6 @@ __init void memblock_clear_kho_scratch_only(void)
 {
 	kho_scratch_only = false;
 }
-
-__init void memmap_init_kho_scratch_pages(void)
-{
-	phys_addr_t start, end;
-	unsigned long pfn;
-	int nid;
-	u64 i;
-
-	if (!IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT))
-		return;
-
-	/*
-	 * Initialize struct pages for free scratch memory.
-	 * The struct pages for reserved scratch memory will be set up in
-	 * reserve_bootmem_region()
-	 */
-	__for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
-			     MEMBLOCK_KHO_SCRATCH, &start, &end, &nid) {
-		for (pfn = PFN_UP(start); pfn < PFN_DOWN(end); pfn++)
-			init_deferred_page(pfn, nid);
-	}
-}
 #endif
 
 /**
-- 
2.53.0.345.g96ddfc5eaa-goog


