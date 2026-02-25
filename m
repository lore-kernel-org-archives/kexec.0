Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAAA7FD376B
	for <kexec@archiver.kernel.org>; Wed, 25 Feb 2026 15:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ipTaz++qTtdDCBjKXU7vNcSleKIn31kyDo4+ZfAiimU=; b=zV16M/0ziLXhF8/27zcYcdtP65
	WOiqMhtsvK7uB1unjQYqu3FsuBvMS4Q+/kfOy5sk5b2qCNfNoas6vRkvhwnQ0jpOugtpauQxz9J3i
	Zxr84oEsuUAW0coaC9Jem/MupASoYWWzthZt2dyXyhbWmOS4cZ1VGs2MPKMansMdxzqUmZNKZbYlU
	2Roq6PewS7YaSggzxJj6G+7qiVJZqN/2Wvm/09R46AeGH142mr1iM6MI/IH4D3CQkUBhMjwiHp2eh
	fJqHHZG78/NBCgVOnVS21t4v/kF8xP5jWBGAwaFhTNBu49uip2g41KG70JzTD7w8RtAdNWzpRXPLn
	Bxcv5/iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvGzi-00000004MnO-01e8;
	Wed, 25 Feb 2026 15:40:10 +0000
Received: from mail-ed1-x549.google.com ([2a00:1450:4864:20::549])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvGzf-00000004MmL-3k9x
	for kexec@lists.infradead.org;
	Wed, 25 Feb 2026 15:40:08 +0000
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-65be780131aso8687740a12.2
        for <kexec@lists.infradead.org>; Wed, 25 Feb 2026 07:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772034005; x=1772638805; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ipTaz++qTtdDCBjKXU7vNcSleKIn31kyDo4+ZfAiimU=;
        b=tKUc+fAy9fstN9MTjooxn8qxI7FYBwuoCbTObhQWt9sRxgOfkB4FM7ZDMsRBpp5C7t
         9YOREDA0J0rzYShwPzs4nCDMrm4oUWeNYlXXy9aFMV61VzxlsIFC+QBDi1k2C62ZsPGi
         FpsLnKiM9CgG+EPwIa3kkKwZW+UbqlblLsmztsLMUVCXG9MK4PwWVFh6++GOL9mr9DU1
         SkjX8UMsAjgpSxnanOzt2vgpQUKHrP5gqWmckAOWIb7EmN9BLlyIrUghrtVjt47jfset
         FOyIiu2UotssAx5CqMr9rtLB+pZAjph3b31pbju9sqa5+mNiAyjRDtRhqac5479hoCTx
         CnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772034005; x=1772638805;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ipTaz++qTtdDCBjKXU7vNcSleKIn31kyDo4+ZfAiimU=;
        b=UU8yXj+uKavjX2jGsHnNihCIlK3Bx02bYApwuA7ZuA/n/AEQHcAytB3UV56K3HHhQL
         mjyuxEqU9UqVi1WxH06Jozpl+3ATF55BhEOwn/sfdP1/8KsuyKx5rLsHELl2Oprje+qI
         k5LuKfMWxBmliD+5OwPtgtoTdUmoLnV45wYQNMTyGZ2sJlu7mfpVn5hZQAWY7UCxzVMc
         OLUHB+FP2A5Hx/lehmbbMiCxY6vehqx02d3CaYnFy5Vx1+A595qRtlAB5FujdNzYrKAZ
         jZr2x8JdN/goptqIa9x1AnyIy0nStcm6hC0/j8VYcQpSW29yB9sLqczRc6hvHCP4mr/H
         EbYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5/wF0v7aEYfU/gtlmAJ0uWrBQEXiIUdtvEgmRc4hTBLBqUct+ZUHsbYiZ2KIKLlcd6f1ntg==@lists.infradead.org
X-Gm-Message-State: AOJu0YzOsvAAYo1L9BPslbobCbefP6GQ5oEt97y3onI2OImTdto6Fco8
	urDrYrKQ85WlTtJ9woFNfzjo+jf5cvkWu74Bp7OKvTcv87b+xzk+C5dwNiWI1LwzBYSIIoj7q29
	r6l0cY1EyEarQlZs61sw/wA==
X-Received: from edsu1.prod.google.com ([2002:aa7:d981:0:b0:65a:1eb4:60db])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:360e:b0:65f:7000:928f with SMTP id 4fb4d7f45d1cf-65f700095a8mr3689412a12.0.1772034005339;
 Wed, 25 Feb 2026 07:40:05 -0800 (PST)
Date: Wed, 25 Feb 2026 16:39:54 +0100
In-Reply-To: <20260225153955.1006649-1-mclapinski@google.com>
Mime-Version: 1.0
References: <20260225153955.1006649-1-mclapinski@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260225153955.1006649-2-mclapinski@google.com>
Subject: [PATCH v5 1/2] kho: fix deferred init of kho scratch
From: Michal Clapinski <mclapinski@google.com>
To: Evangelos Petrongonas <epetron@amazon.de>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	kexec@lists.infradead.org, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_074007_957192_9C073C20 
X-CRM114-Status: GOOD (  16.73  )
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
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/memblock.h           |  2 --
 kernel/liveupdate/kexec_handover.c | 43 ++++++++----------------------
 mm/memblock.c                      | 22 ---------------
 3 files changed, 11 insertions(+), 56 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 6ec5e9ac0699..3e217414e12d 100644
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
index 410098bae0bf..1e1f69b10457 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1388,11 +1388,6 @@ static __init int kho_init(void)
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
@@ -1408,8 +1403,17 @@ static __init int kho_init(void)
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
@@ -1435,35 +1439,10 @@ static __init int kho_init(void)
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
 	if (kho_in.scratch_phys) {
 		kho_scratch = phys_to_virt(kho_in.scratch_phys);
-		kho_release_scratch();
 
 		if (kho_mem_retrieve(kho_get_fdt()))
 			kho_in.fdt_phys = 0;
diff --git a/mm/memblock.c b/mm/memblock.c
index b3ddfdec7a80..ae6a5af46bd7 100644
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
2.53.0.414.gf7e9f6c205-goog


