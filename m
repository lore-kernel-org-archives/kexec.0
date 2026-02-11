Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A48ECD6C1
	for <kexec@archiver.kernel.org>; Wed, 11 Feb 2026 17:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dlNHJZ4DB/YIFPcTP8iAwpEYyWUng6cE6zKvxjI6tZ8=; b=4KhNpYFWJW7LBt7xC2Z4yYITZa
	CGp08sLHb2NJgJoQwhoYDFpO6Tuc5zhm850iwy5U6LJ55Kof+satTwTwpKS2hV/aMheqzW+MHgYKE
	Rrlno5O55FELPUF+RzzejuxHiCQus4PJ1LJkLemNg4qUSIgVP7ox+k7/ihXJnhcBIQHOIlJ69ZC/H
	0Duccuywgioaeeuc7YGpnd9aQolV4qswmfDORpDfq88VxZwNrkfQwpBybXksyqQVQv64vMaUMBdI3
	q9y6bX1x/d4UusMmdJK9gYVrTJjyb27nUsR209SOzmO86EAS8y35Enf+JFqQvflguOS7I3bGtcLh5
	d7m0XrPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqEC5-00000000uey-1d2p;
	Wed, 11 Feb 2026 17:40:05 +0000
Received: from mail-ej1-x64a.google.com ([2a00:1450:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqEC2-00000000ueI-2gd9
	for kexec@lists.infradead.org;
	Wed, 11 Feb 2026 17:40:04 +0000
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-b8722f32507so740756466b.2
        for <kexec@lists.infradead.org>; Wed, 11 Feb 2026 09:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770831600; x=1771436400; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dlNHJZ4DB/YIFPcTP8iAwpEYyWUng6cE6zKvxjI6tZ8=;
        b=z/yN4gXtQ0zCHai+Ab89Em6AapZXbJQ358WPBWa3IfhNWkE30RYFoboOoxio2LjRZi
         T9yWEDiQhhbVxFpl/4FFBbg2HUBlXLOkSogfQ8aItcuZMAWPlFaSzFOmQbHEX/O0oIOu
         RFmj2HYSQKTsCJlNJJdv8PkPcztYwqFeLFudehlxNKAdwFWCl8O0QGwwUSQsmfIXdM1x
         cHy52Q4qcCXf6jpLnRYkH+py8Uvzs941H9MaTRTvSFHMBppxrCqUFtPJ9yOkw80SMWXz
         TsYqXc0wRpnnzbzlNpAlXOWUz7uZQ924ov/fS6NLuADZCNXTEHDi21XI40SroQH4E7C0
         RQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770831600; x=1771436400;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dlNHJZ4DB/YIFPcTP8iAwpEYyWUng6cE6zKvxjI6tZ8=;
        b=JgQULVXxP5Xsgn6mdzbhEEVWpE1+xDiWte7FxSYuSk2REciWcWi4ks5V7yR+mwY2OF
         XlBznD3s7xidRL/Au1H5+ZFoWWSWyNNc77JEPHCPhNr/x8LmxGfcGgZYcuoHBo2puLP1
         t9K6eHLwuCqrCeHk/eEv+JJNOy1w1I2HwC/w7ccEcIkH7XpJyVL4FH7a6k+IlAxOByXk
         gb2lV8K76RT02PZeuMFccn6SCIqVCTX04vOatby8xVDLFruMl1gchs4az7N8PZLgdvlW
         +qnDwJTucJ7DepR091PO+rSqrsej7BSvaF77MUynxkbH26IBdy2VIA72nL7GJT/DXO2e
         i4TQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa+b87XfGm0yZ8koGBAA4FvIMmU6AQj8PGflBMJq1CXHXFPKXNCsVU3OXxkGitVzLZ38yz5Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YxSXFtXecEPmsJ+5VxL2BDlgbPmadBzmZj1epOeX+WS0md7tC+T
	Q5DuBmTlslb5c76Qu8Q60fQLqM/a/42JdvFbIKVFIOTr3PA+A89Zjm0WaOw8yZy/Ay4LxZUcAjk
	O72V0wDD6UAY2nJj18F45wg==
X-Received: from edvj14.prod.google.com ([2002:aa7:de8e:0:b0:64b:aad7:d741])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:930a:b0:b88:463e:b55f with SMTP id a640c23a62f3a-b8f6a8e08c2mr193618466b.6.1770831599663;
 Wed, 11 Feb 2026 09:39:59 -0800 (PST)
Date: Wed, 11 Feb 2026 18:39:54 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260211173954.2091119-1-mclapinski@google.com>
Subject: [PATCH v3] kho: add support for deferred struct page init
From: Michal Clapinski <mclapinski@google.com>
To: Evangelos Petrongonas <epetron@amazon.de>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	kexec@lists.infradead.org, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260211_094002_765656_FD70F379 
X-CRM114-Status: GOOD (  22.81  )
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

During KHO restoration, deserialize_bitmap() writes metadata for
each preserved memory region. However, if the struct page has not been
initialized, this write targets uninitialized memory, potentially
leading to errors like:
BUG: unable to handle page fault for address: ...

Fix this by introducing kho_get_preserved_page(),  which ensures
all struct pages in a preserved region are initialized by calling
init_deferred_page() which is a no-op when deferred init is disabled
or when the struct page is already initialized.

Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
Signed-off-by: Michal Clapinski <mclapinski@google.com>
Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>
---
v3:
- changed commit msg
- don't invoke early_pfn_to_nid if CONFIG_DEFERRED_STRUCT_PAGE_INIT=n
v2:
- updated a comment

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

I repeated Evangelos's testing:
In order to test the fix, I modified the KHO selftest, to allocate more
memory and do so from higher memory to trigger the incompatibility. The
branch with those changes can be found in:
https://git.infradead.org/?p=users/vpetrog/linux.git;a=shortlog;h=refs/heads/kho-deferred-struct-page-init
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
index b851b09a8e99..3bc14f3d7690 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -457,6 +457,31 @@ static int kho_mem_serialize(struct kho_out *kho_out)
 	return err;
 }
 
+/*
+ * With CONFIG_DEFERRED_STRUCT_PAGE_INIT, struct pages in higher memory regions
+ * may not be initialized yet at the time KHO deserializes preserved memory.
+ * KHO uses the struct page to store metadata and a later initialization would
+ * overwrite it.
+ * Ensure all the struct pages in the preservation are
+ * initialized. deserialize_bitmap() marks the reservation as noinit to make
+ * sure they don't get re-initialized later.
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
+	for (int i = 0; i < (1 << order); i++)
+		init_deferred_page(pfn + i, nid);
+
+	return pfn_to_page(pfn);
+}
+
 static void __init deserialize_bitmap(unsigned int order,
 				      struct khoser_mem_bitmap_ptr *elm)
 {
@@ -467,7 +492,7 @@ static void __init deserialize_bitmap(unsigned int order,
 		int sz = 1 << (order + PAGE_SHIFT);
 		phys_addr_t phys =
 			elm->phys_start + (bit << (order + PAGE_SHIFT));
-		struct page *page = phys_to_page(phys);
+		struct page *page = kho_get_preserved_page(phys, order);
 		union kho_page_info info;
 
 		memblock_reserve(phys, sz);
-- 
2.53.0.239.g8d8fc8a987-goog


