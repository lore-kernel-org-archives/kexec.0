Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB54106289B
	for <kexec@archiver.kernel.org>; Wed, 11 Mar 2026 12:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QiNhESp4ivptJOpYZbbAOc1dWjPibReMWlebFfT5Yug=; b=Xl5BlULizWzdIwzx/xuugV1TVa
	MPKd7kt/X4F0KzfwgqGh8kydZZI6NuQsa1dpYNw2HJS2pTMAU3jitSrRiroxu54Miy15I88t1mugN
	78s3iCWOuCvGGzXiaMqVdLOa4n4FdZIzqql54gOnE4VKPl1bLlrmZki43It9VfanCudF0yT4LlaF4
	fNhoQkvMUhTdiUgjEQTNjpM4CH5Ec1aaeSqmRUDUw4Xyw4f62LXqwaXM7J3758qkW63y+5JKkYT9M
	ni5CXLRGG92LT07FcDnNkSbijFIghKe0LKfz4NGlYGYjahN7FxB2CQ39bVE+nRawH51R2Y8DtpLFx
	zdizZpVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0J6W-0000000BbNJ-14NT;
	Wed, 11 Mar 2026 12:56:00 +0000
Received: from mail-wr1-x449.google.com ([2a00:1450:4864:20::449])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0J6T-0000000BbMU-2g2Y
	for kexec@lists.infradead.org;
	Wed, 11 Mar 2026 12:55:58 +0000
Received: by mail-wr1-x449.google.com with SMTP id ffacd0b85a97d-439b8bc43aeso8245979f8f.1
        for <kexec@lists.infradead.org>; Wed, 11 Mar 2026 05:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773233755; x=1773838555; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QiNhESp4ivptJOpYZbbAOc1dWjPibReMWlebFfT5Yug=;
        b=C2U7Z8u/3VSN2X0/x8TQpfJJmAmEkfzrt13dfeZ3QLyldYppok/sw97XKeAi9i2i5Q
         y1Zvu91dooNIl3irQZh19WBnYHBfry1G5hpFAI8h4u0MxQubdHQ70IETGo1qVphYmd+W
         nwMtR7iGgPqEBoJfK+z/Ucz/GtqIAebDJvB5YmAR9KQYjJwuueFGSCE/G0oh04kxWCL4
         zf0MBjTsa+Zg8ucBjtxsd+GJPyvJLrPy8ml1AOSPrAfzem8ZByjrNuGncTu7bIkyS1NE
         es80tvmmhmJsD+0IiTuARJ251rRgQLjDPS9SzutykaVcR283LneeCev7uKLcPgtFY0/A
         WGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773233755; x=1773838555;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QiNhESp4ivptJOpYZbbAOc1dWjPibReMWlebFfT5Yug=;
        b=AFFlPqkoDWcupEha0znztehm3shMC4JiTZpbchVx20JlVf0e88907njvFie761blll
         73VH26LqR64SzQn9av4yjerzdvsQDxNr7SLqf4eXk9sEduG6ODWgcl89UawrI5aFUWHX
         WBKePgf3F8TWmD8ChxHuBr9Qk9vEN3dio+Z5Q1hflyFEUya7W5Dy7aDBPzZ2H60UAvtQ
         CVYSV55Z7xFJtkRrDd5/DzRYK87aTvh8xOiQ0RIvZONKi3Y3ikuc8d2hrDjifxzzv0BV
         ZNCjRlhv6r+RtTdB1USATGmuNDqK4Y5DPsb4AL9yPzfZjlwQYTU/K0uiZdCWUCXm4NRS
         k0rQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQCONYusw1yRvoxvgXJdkGdL0lbAvAU7SSh2YWvHDp+oIN6agiKdCY/K21s8Xv7pC+KFcfeA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz7cojffVnURMtx/c52IdwlxhivHFs4wttG6unhlPghv9J1dPSn
	LgT8XO0LzL4MzrOkad0uUC1t4hlIyUPJkZ3vxSlnSGIP5u709Up8BBoQOusE/qcljN4VipS2ByT
	bKI5UL0NqpNcJscZaVrxbbA==
X-Received: from wmby16.prod.google.com ([2002:a05:600c:c050:b0:480:6b05:6b9a])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:458e:b0:485:3ae8:2231 with SMTP id 5b1f17b1804b1-4854b11a321mr35639475e9.30.1773233755110;
 Wed, 11 Mar 2026 05:55:55 -0700 (PDT)
Date: Wed, 11 Mar 2026 13:55:39 +0100
In-Reply-To: <20260311125539.4123672-1-mclapinski@google.com>
Mime-Version: 1.0
References: <20260311125539.4123672-1-mclapinski@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260311125539.4123672-3-mclapinski@google.com>
Subject: [PATCH v6 2/2] kho: make preserved pages compatible with deferred
 struct page init
From: Michal Clapinski <mclapinski@google.com>
To: Evangelos Petrongonas <epetron@amazon.de>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260311_055557_705848_1A837A18 
X-CRM114-Status: GOOD (  20.86  )
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
index 09cb6660ade7..1f9707d11e5f 100644
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
2.53.0.473.g4a7958ca14-goog


