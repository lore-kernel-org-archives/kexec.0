Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4872EF589AE
	for <kexec@archiver.kernel.org>; Thu, 23 Apr 2026 12:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jpb9j7QMI3LnBirxCYRwTt7/Lt/BiQh7xQw1xaxHQCg=; b=XCujZY8dZg8OG+r6xvFmC92OFe
	frIlmaNWQX2dcva8Qpm4xjm2RZE0370rhW1C/jxNr4R+2YslnfkhQb98kU6/tgLZTMxv+w5n2HZre
	3Vr5ipaFI44DImvL3Ax7sNIKwuDAwLaudPDdIgapged6o8tc2QrSmGWH4rLTJjNzq5ZoKULOKpBtN
	rekpQFEP+3Mkd2et3cSS79+KxENldNmcXIzT3xxGlqLn5IDXHl2GGk5bDKiwFK4meGgAXrJUzLRzE
	hphEPkW4S471YC3O5vQKCRBOmiAeBGB+DEz/D49t3RXV+DWw65Mm0FDRIb+QwHzqMppWvBFSELED8
	f5S4MtNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFt82-0000000Bc1e-2zPh;
	Thu, 23 Apr 2026 12:25:58 +0000
Received: from mail-ej1-x64a.google.com ([2a00:1450:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wFt7w-0000000BbyO-1zaD
	for kexec@lists.infradead.org;
	Thu, 23 Apr 2026 12:25:57 +0000
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-b8ff07df5e4so533152966b.3
        for <kexec@lists.infradead.org>; Thu, 23 Apr 2026 05:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776947150; x=1777551950; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jpb9j7QMI3LnBirxCYRwTt7/Lt/BiQh7xQw1xaxHQCg=;
        b=YNbipn3ygqTr2lSgBuGCpZhijO4lq7VsUde4HBeoRe7i0lpV5RibAXxUO80xwbFNJl
         tCHWEg1JtCKDKzOPPjofuc/NxvwNxp8eKwo1iPxPrqL1O5sQ8nf8BtrgDbESYWRPlYfP
         ysT8iugUFqWUc7z3AhgfSyjzVzIv+ccyUCxAXVPper9EmLWcooGz2yb1z0S4DDu5Tag0
         Otj6meIoB43XTM2yc6t8mOM97ajq0MZmSMG2BmtelTtAEYL26aGg2T5uY6qe0kqR2WVz
         oU/Ld+/SJxcJXEKP0h9+xUnwdRF0HOSUwwahZp5G6m0353OcCNfBcZoAZ0TRGyVmQCQT
         3EEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776947150; x=1777551950;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jpb9j7QMI3LnBirxCYRwTt7/Lt/BiQh7xQw1xaxHQCg=;
        b=X+g9JWjvLanZ4qn7yoUFpRjTDnP90sjOmNXFmWoYrq8zUvixe31gw73wLgNl+TV0Wp
         L36vouoX3+zlSoct6YYmlfvMA9974HPndD/kEQulSMRVd1MDeesG8NMXA+loCj+Zm5JL
         qyQ+qINL/CmIokWCB/nfx5LR6Xjo0LxwTAwEGgta1JhHAaebWWp4FfO12tigiRAt6lzE
         jEjTX1J7Jql4+XYarv9g14Q0y10ev1mDJ1TIQ9o2DP4GfQXAD9inZfW17T/CoVn4vhbM
         D9KnGzZK2iczl00qBSzwq/lJvR3cqWdGdboefHyICZDrtjjM8VXtNZucDL6PVSacCRuR
         f1ug==
X-Forwarded-Encrypted: i=1; AFNElJ+rHDUaPi+UBC3pzU0F7XXK+r2hK7aZ6W+iP4y8gi/zGbXwaOKa8WnrOQYw3mUDCSt2guUFuQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwwJoSndxBrInoiUv7rHeoFfkt4vHfqFx8pRNvqvAtGDn+aMGSe
	jKdtdoz9O+csUf48ptSHk3PWQ/GY7eHqp5f7Eq32xPgv/4DKIN5cE0qJS3IG+cRhQgOWsSQ3FCx
	JRwtU9OZpV1WUbzQDMUtN6w==
X-Received: from edber5.prod.google.com ([2002:a05:6402:4485:b0:660:af38:c618])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:8e0e:b0:b9d:1a1c:a664 with SMTP id a640c23a62f3a-ba41a91e25bmr1360621266b.40.1776947149314;
 Thu, 23 Apr 2026 05:25:49 -0700 (PDT)
Date: Thu, 23 Apr 2026 14:25:37 +0200
In-Reply-To: <20260423122538.140993-1-mclapinski@google.com>
Mime-Version: 1.0
References: <20260423122538.140993-1-mclapinski@google.com>
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260423122538.140993-3-mclapinski@google.com>
Subject: [PATCH v9 2/3] kho: make preserved pages compatible with deferred
 struct page init
From: Michal Clapinski <mclapinski@google.com>
To: Evangelos Petrongonas <epetron@amazon.de>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	Samiullah Khawaja <skhawaja@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260423_052552_537403_AF565E46 
X-CRM114-Status: GOOD (  16.26  )
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
index a507366a2cf9..d5718bef6d4d 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -473,6 +473,31 @@ struct page *kho_restore_pages(phys_addr_t phys, unsigned long nr_pages)
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
@@ -481,7 +506,7 @@ static int __init kho_preserved_memory_reserve(phys_addr_t phys,
 	u64 sz;
 
 	sz = 1 << (order + PAGE_SHIFT);
-	page = phys_to_page(phys);
+	page = kho_get_preserved_page(phys, order);
 
 	/* Reserve the memory preserved in KHO in memblock */
 	memblock_reserve(phys, sz);
-- 
2.54.0.rc2.533.g4f5dca5207-goog


