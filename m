Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1750FD8777
	for <kexec@archiver.kernel.org>; Tue, 17 Mar 2026 14:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=20jDT7vbb/pcwg3RWwDlyXHU14Ovqo1gDrXuULw2Qtw=; b=o1LScpQoggLCOvpoQGfA72Nf9A
	umaxISe4P8TbPdtTvheNTTRbpzzPsGqwpo6UDiNKZ1g548VY89WdfAfhcDZtEA6NuHecuPGsNgbY4
	fN7+XQ2KxLLiyIelGTVSfMDefUm+vrYB6D0+iMc1+PrU+bPn6eX8cQCG2dCMHIpoFjwHTF0lbXoSE
	BFzFDBNWvPM1pp84UKu7LUdLVo/QMcgQQXPDfk2ffezpzWHbqvUR2XvMbZcy3nZoh1kUMMEABhWLC
	CobrKJUE3OhpHWouelJZekH/z4cZHJVXRMJJU/SqkamQF5FnZgbEBEFaFNHo6xHu19u6Mq7mRMMqp
	c4OyZA0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2VD9-00000006Y2Z-3292;
	Tue, 17 Mar 2026 14:15:55 +0000
Received: from mail-wr1-x449.google.com ([2a00:1450:4864:20::449])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2VD6-00000006XzZ-3wqi
	for kexec@lists.infradead.org;
	Tue, 17 Mar 2026 14:15:54 +0000
Received: by mail-wr1-x449.google.com with SMTP id ffacd0b85a97d-43b3a41c62bso3066365f8f.1
        for <kexec@lists.infradead.org>; Tue, 17 Mar 2026 07:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773756950; x=1774361750; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=20jDT7vbb/pcwg3RWwDlyXHU14Ovqo1gDrXuULw2Qtw=;
        b=Vxp9onwC2ufohcCS/gtQFCNXEoNDXZjGKbY+oIJIs1J7bv5LQqKlWBg9m3WDLjcvuP
         ULqF2vmfPkLumJJdQ8HygXXhveSju4nBtCS82VRJqZNPSYNNdxq0bDNZOTrVQhMAxJP7
         onjaye+SlMwNrhUDfcd+LjWNXUpNGz+L4aGK4QzhesTBDAJHBJIJ8sX7SnPk9JfcskNM
         UYlNILYd5pUI78T1Z+NMDX/ox6aiceB2jwoD7Y8gGGqit2gDXALlrUpxmxR78w3+m2fc
         NNSl5j2fZvVo0oVCkhYsgLx8lBWwZ6dUEgeUaq4hK5PBIEEwaGiquiD6uYLmDrD9p5Sf
         RQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773756950; x=1774361750;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=20jDT7vbb/pcwg3RWwDlyXHU14Ovqo1gDrXuULw2Qtw=;
        b=RXRt3un/jo9+dyObxCF7O9qidWb3VksNYU3FhrsGBTrkhD3KCKWVgLzX0gLvYbAfwY
         FN7VCLe0osQZimnXFrL+sam6yNDnQ/pzYdL+DRMifFDwQDu/JEdgCxnuUWFDGkFlCg0p
         EMLjiWeMB11kcABUJOWTIzB/MKrVXwQZ8Fe3oeTD10mYcchF4erP3/D9HKfttgYwCRLd
         EyQK1JC2eqsBREBtrvxvfiV3d1tKL6pKOuIatP8wO5JANlhSO+wzq2Y8oN9f57CMFPbl
         bagg4hdQLoLu2RmsWh/6LoV2Yr98inwSBonWFG5ZUTTKRP0Dns0mp0/xLfbNvZzBJWIm
         PLDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvZZSI055uLvvm5tTtStOdwh/CzEj6RopwSZJlZg9SOuTQhcdtJ372pSpak+Yd3Meogtn6dA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyBNuidK4LX+xtwr3iIeajC0etUKrulONouwJ3m6axbk07lW6K0
	jlTId6f2EWrvBvnQqJMb0esBDYuB2BfuDobk31jhglaHz03i2dF4joXLrhokVth3duTZpCUDQ3k
	T72h79kAxX0Y9wGt8I0oGuA==
X-Received: from wmpj20.prod.google.com ([2002:a05:600c:4894:b0:485:3c21:d5f0])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b45:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-48556702853mr281166825e9.21.1773756950287;
 Tue, 17 Mar 2026 07:15:50 -0700 (PDT)
Date: Tue, 17 Mar 2026 15:15:34 +0100
In-Reply-To: <20260317141534.815634-1-mclapinski@google.com>
Mime-Version: 1.0
References: <20260317141534.815634-1-mclapinski@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260317141534.815634-4-mclapinski@google.com>
Subject: [PATCH v7 3/3] kho: make preserved pages compatible with deferred
 struct page init
From: Michal Clapinski <mclapinski@google.com>
To: Evangelos Petrongonas <epetron@amazon.de>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_071553_069566_90724BB5 
X-CRM114-Status: GOOD (  20.81  )
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

From: Evangelos Petrongonas <epetron@amazon.de>

When CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, struct page
initialization is deferred to parallel kthreads that run later
in the boot process.

During KHO restoration, kho_preserved_memory_reserve() writes metadata
for each preserved memory region. However, if the struct page has not
been initialized, this write targets uninitialized memory, potentially
leading to errors like:
BUG: unable to handle page fault for address: ...

Fix this by introducing kho_get_preserved_page(),  which ensures
all struct pages in a preserved region are initialized by calling
init_deferred_page() which is a no-op when the struct page is already
initialized.

Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
Co-developed-by: Michal Clapinski <mclapinski@google.com>
Signed-off-by: Michal Clapinski <mclapinski@google.com>
Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
I think we can't initialize those struct pages in kho_restore_page.
I encountered this stack:
  page_zone(start_page)
  __pageblock_pfn_to_page
  set_zone_contiguous
  page_alloc_init_late

So, at the end of page_alloc_init_late struct pages are expected to be
already initialized. set_zone_contiguous() looks at the first and last
struct page of each pageblock in each populated zone to figure out if
the zone is contiguous. If a kho page lands on a pageblock boundary,
this will lead to access of an uninitialized struct page.
There is also page_ext_init that invokes pfn_to_nid, which calls
page_to_nid for each section-aligned page.
There might be other places that do something similar. Therefore, it's
a good idea to initialize all struct pages by the end of deferred
struct page init. That's why I'm resending Evangelos's patch.

I also tried to implement Pratyush's idea, i.e. iterate over zones,
then get node from zone. I didn't notice any performance difference
even with 8GB of kho.
---
 kernel/liveupdate/Kconfig          |  2 --
 kernel/liveupdate/kexec_handover.c | 27 ++++++++++++++++++++++++++-
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
index 1a8513f16ef7..c13af38ba23a 100644
--- a/kernel/liveupdate/Kconfig
+++ b/kernel/liveupdate/Kconfig
@@ -1,12 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 menu "Live Update and Kexec HandOver"
-	depends on !DEFERRED_STRUCT_PAGE_INIT
 
 config KEXEC_HANDOVER
 	bool "kexec handover"
 	depends on ARCH_SUPPORTS_KEXEC_HANDOVER && ARCH_SUPPORTS_KEXEC_FILE
-	depends on !DEFERRED_STRUCT_PAGE_INIT
 	select MEMBLOCK_KHO_SCRATCH
 	select KEXEC_FILE
 	select LIBFDT
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index e511a50fab9c..b49ebcd0b946 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -471,6 +471,31 @@ struct page *kho_restore_pages(phys_addr_t phys, unsigned long nr_pages)
 }
 EXPORT_SYMBOL_GPL(kho_restore_pages);
 
+/*
+ * With CONFIG_DEFERRED_STRUCT_PAGE_INIT, struct pages in higher memory regions
+ * may not be initialized yet at the time KHO deserializes preserved memory.
+ * KHO uses the struct page to store metadata and a later initialization would
+ * overwrite it.
+ * Ensure all the struct pages in the preservation are
+ * initialized. kho_preserved_memory_reserve() marks the reservation as noinit
+ * to make sure they don't get re-initialized later.
+ */
+static struct page *__init kho_get_preserved_page(phys_addr_t phys,
+						  unsigned int order)
+{
+	unsigned long pfn = PHYS_PFN(phys);
+	int nid;
+
+	if (!IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT))
+		return pfn_to_page(pfn);
+
+	nid = early_pfn_to_nid(pfn);
+	for (unsigned long i = 0; i < (1UL << order); i++)
+		init_deferred_page(pfn + i, nid);
+
+	return pfn_to_page(pfn);
+}
+
 static int __init kho_preserved_memory_reserve(phys_addr_t phys,
 					       unsigned int order)
 {
@@ -479,7 +504,7 @@ static int __init kho_preserved_memory_reserve(phys_addr_t phys,
 	u64 sz;
 
 	sz = 1 << (order + PAGE_SHIFT);
-	page = phys_to_page(phys);
+	page = kho_get_preserved_page(phys, order);
 
 	/* Reserve the memory preserved in KHO in memblock */
 	memblock_reserve(phys, sz);
-- 
2.53.0.851.ga537e3e6e9-goog


