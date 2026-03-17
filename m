Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55CC4FD8770
	for <kexec@archiver.kernel.org>; Tue, 17 Mar 2026 14:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ENui0Js8tkhd80bmpMrXzJoFIzd5GZKUFokCk0GUoAI=; b=HYHJWxlaNqi/9LzmIS9eIYXPYC
	LIECC645UpsMdZJS8KUyltGTWO8FQVlVSO7wAEN9/cZQb8lAtdDUaZuhXZ0QQ6zxVkmF1H6UVO4+A
	kqYuXgY+5BvxGrN7AlYqewYiyI95P4lGcZmppFMgaKLU932UvZSDt+A5d9b3+URs0MLDvr2spNn/m
	0whaHA1pY7IZX2tKrgF0Imi/kIsRhfEH53KoWHltNmzGEAght8UgEs262gNcOnuhrrnpJAXOgO3bs
	B0mcVfm1WIyNimIF6qBttuhOSUC/7kixnr9+ZcJEUQmWVuvgRaSQ5GRcLGUiIgwWcCt/bPHx6evlC
	rtwxPUxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2VD6-00000006Y0R-1h4D;
	Tue, 17 Mar 2026 14:15:52 +0000
Received: from mail-ed1-x549.google.com ([2a00:1450:4864:20::549])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2VD4-00000006Xx5-1IaV
	for kexec@lists.infradead.org;
	Tue, 17 Mar 2026 14:15:51 +0000
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-6673de2e0a6so802475a12.2
        for <kexec@lists.infradead.org>; Tue, 17 Mar 2026 07:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773756947; x=1774361747; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ENui0Js8tkhd80bmpMrXzJoFIzd5GZKUFokCk0GUoAI=;
        b=EcmzwCrmdU6gx91tCwF+HTF2eDoKX8KCLy7ph/kUDwlURe88dEsyEA0yBaK6ruBkFP
         rYfyi7D5004byxST2TSyYa48yUngvXMO3M23w7TdqM0ACocTQGjOl8LddkcoTqxO8EGe
         v8BWoGGKC1eP2w6043Z5I+7b7sQkja2hYWUpdT9lIc24ymNP0BfXcBzfnK1gmwqBubm/
         onVOOVz0d9YwobmxZWpeQq3wbeY6qXiCa4Mz5WvuTFR7mVg+lFF31CeDvwATx5G/6QTt
         wHyH5C6qhkeOwvvbNuOpDh67kYyD+5dLgvdu0+55SKY0e+vA+/BOq9nBmQ6RmD45e8dO
         1oaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773756947; x=1774361747;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ENui0Js8tkhd80bmpMrXzJoFIzd5GZKUFokCk0GUoAI=;
        b=sBezUtU4S7zRGIF5deRcferg4hf73kaj7kl8b27e1lUDtG3+NdTeeTp0Q4OMFplfvy
         tVggXUPksTVdfbsC9iqUWpKNkBif5yP8boqEmtgMtqeCYD5IHTy0cHUyY8HJGyXKeGwF
         vsUoDuWBcxQ4GYXajGwb3Xj2fufauqU3VcChjR+faJgiVJuM9U7FD3VrX3GVS4jxbCwE
         IO7Zi+T3hGrJToNxeY+63qFcidgYKek7izyEmMSfv0fM/bjl15HNtkhJmWyP9XxlscK7
         xHqh1Yg6Ql/jEQLCkaJb2aDlGfZl7Qrh976xh4XdwlmNfrWzZ6dF5mcU9xPJCQ0JwAsK
         83Ew==
X-Forwarded-Encrypted: i=1; AJvYcCWYBb9aW6U7JoGo90rFZBB3uh2X9mVle5G3NujwaB7Do/VdP9XipO4O6hdJnW1udGIk7pbg5g==@lists.infradead.org
X-Gm-Message-State: AOJu0YxuTh9qb7OV/f/KqURrZo0gY/uL/CjA2GppEBqzTmt2f6Z14ujY
	Gf2M1MQC0WUy1VFtJvWtxP79VqAvLhlhvykjaljr2Bnm8hOiE+kaVm+Lc1+YqwfV8NH0Dd/hpKd
	mOL8m7bqHp5WE/uBFA/kEfA==
X-Received: from edew21-n1.prod.google.com ([2002:a05:6402:a215:10b0:662:4e97:3bc9])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:26c5:b0:667:5318:2bc9 with SMTP id 4fb4d7f45d1cf-66753182f33mr1449370a12.15.1773756947028;
 Tue, 17 Mar 2026 07:15:47 -0700 (PDT)
Date: Tue, 17 Mar 2026 15:15:33 +0100
In-Reply-To: <20260317141534.815634-1-mclapinski@google.com>
Mime-Version: 1.0
References: <20260317141534.815634-1-mclapinski@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260317141534.815634-3-mclapinski@google.com>
Subject: [PATCH v7 2/3] kho: fix deferred init of kho scratch
From: Michal Clapinski <mclapinski@google.com>
To: Evangelos Petrongonas <epetron@amazon.de>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_071550_389170_D56D4758 
X-CRM114-Status: GOOD (  16.47  )
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

Currently, if DEFERRED is enabled, kho_release_scratch will initialize
the struct pages and set migratetype of kho scratch. Unless the whole
scratch fit below first_deferred_pfn, some of that will be overwritten
either by deferred_init_pages or memmap_init_reserved_pages.

To fix it, I modified kho_release_scratch to only set the migratetype
on already initialized pages. Then, modified init_pageblock_migratetype
to set the migratetype to CMA if the page is located inside scratch.

Signed-off-by: Michal Clapinski <mclapinski@google.com>
---
 include/linux/memblock.h           |  2 --
 kernel/liveupdate/kexec_handover.c | 10 ++++++----
 mm/memblock.c                      | 22 ----------------------
 mm/page_alloc.c                    |  7 +++++++
 4 files changed, 13 insertions(+), 28 deletions(-)

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
index c9b982372d6e..e511a50fab9c 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1477,8 +1477,7 @@ static void __init kho_release_scratch(void)
 {
 	phys_addr_t start, end;
 	u64 i;
-
-	memmap_init_kho_scratch_pages();
+	int nid;
 
 	/*
 	 * Mark scratch mem as CMA before we return it. That way we
@@ -1486,10 +1485,13 @@ static void __init kho_release_scratch(void)
 	 * we can reuse it as scratch memory again later.
 	 */
 	__for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
-			     MEMBLOCK_KHO_SCRATCH, &start, &end, NULL) {
+			     MEMBLOCK_KHO_SCRATCH, &start, &end, &nid) {
 		ulong start_pfn = pageblock_start_pfn(PFN_DOWN(start));
 		ulong end_pfn = pageblock_align(PFN_UP(end));
 		ulong pfn;
+#ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
+		end_pfn = min(end_pfn, NODE_DATA(nid)->first_deferred_pfn);
+#endif
 
 		for (pfn = start_pfn; pfn < end_pfn; pfn += pageblock_nr_pages)
 			init_pageblock_migratetype(pfn_to_page(pfn),
@@ -1500,8 +1502,8 @@ static void __init kho_release_scratch(void)
 void __init kho_memory_init(void)
 {
 	if (kho_in.scratch_phys) {
-		kho_scratch = phys_to_virt(kho_in.scratch_phys);
 		kho_release_scratch();
+		kho_scratch = phys_to_virt(kho_in.scratch_phys);
 
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
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ee81f5c67c18..5ca078dde61d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -55,6 +55,7 @@
 #include <linux/cacheinfo.h>
 #include <linux/pgalloc_tag.h>
 #include <linux/mmzone_lock.h>
+#include <linux/kexec_handover.h>
 #include <asm/div64.h>
 #include "internal.h"
 #include "shuffle.h"
@@ -549,6 +550,12 @@ void __meminit init_pageblock_migratetype(struct page *page,
 		     migratetype < MIGRATE_PCPTYPES))
 		migratetype = MIGRATE_UNMOVABLE;
 
+	/*
+	 * Mark KHO scratch as CMA so no unmovable allocations are made there.
+	 */
+	if (unlikely(kho_scratch_overlap(page_to_phys(page), PAGE_SIZE)))
+		migratetype = MIGRATE_CMA;
+
 	flags = migratetype;
 
 #ifdef CONFIG_MEMORY_ISOLATION
-- 
2.53.0.851.ga537e3e6e9-goog


