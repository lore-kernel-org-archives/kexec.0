Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6324EA810D
	for <kexec@archiver.kernel.org>; Tue, 10 Feb 2026 13:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=eH6JL7gkCCkK21U6qSqUgOiFfCqEIuZ4GNLMeFzGLJ0=; b=cYOsAffCYrlhRY+rw4pOP707aL
	elXHn50OSnltU85LPNDFvp/cBEjrOFLKaMCbrzcGXit+V1A3TAr5oUPXD0KbcpUQr7769Mn9agB9V
	ute0wv+0K2nPnmAMorKOkwFA0lL4G1WjR/ffAcLkw7NDBmCx5SbxEw7slAhmPPCIPtbwyooczidxE
	SRQQYv4asH/pTCQGCi4HBl8x+MKfjeZgdZWTWX2BogZhDOTUG/ylTp8RGRBw0IO5ANwh8AMkDpt+1
	61HpIsxaibIeaEXph4QoeJ4IC5v3/cVjPzvjrvDaic/IrX+aTfu/8lI+6gLssDlToB+KhMxzE2CIW
	tHc4wVhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpnQ0-0000000GyR3-2TBW;
	Tue, 10 Feb 2026 13:04:40 +0000
Received: from mail-ej1-x64a.google.com ([2a00:1450:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpnPy-0000000GyQZ-01i1
	for kexec@lists.infradead.org;
	Tue, 10 Feb 2026 13:04:39 +0000
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-b8704795d25so366633066b.2
        for <kexec@lists.infradead.org>; Tue, 10 Feb 2026 05:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770728675; x=1771333475; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eH6JL7gkCCkK21U6qSqUgOiFfCqEIuZ4GNLMeFzGLJ0=;
        b=TpGZul0a4OFxgbstxiV+raALt/MHBnMKHlpIjb1u3g6rdFMx6TGHiO0slLM3Xt79b9
         R63Mv2IR7FQf9zYqFOk4kzg51FixbPeHqf7FjrIZ0yKmpeLK886BNXR9QUUEVBGMtPWD
         5WTYPiswM3xpG2tVKSTN2aZFzEFwlomI0mRqPmTWOLghsvjV8SYMgjh+UmAkBC3tOfYU
         H/Ei1EDrKW8R+cwhn/Lzy9Ieg9dpinSWCOFqZ02QIPpXAs8D3QqidISZKmfd2QeQwmWM
         cqwIjOFsp4h7juJkTc2Uf8PgV9b4Bymf7pL8aiJHb43Cuhk7WsEYRhzmVqA8V+lsM1O/
         Nzlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770728675; x=1771333475;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eH6JL7gkCCkK21U6qSqUgOiFfCqEIuZ4GNLMeFzGLJ0=;
        b=YnNi1lzOXLv1yejgKNcOvZpINV/yvvAQvPx+h4Zf/SK6yhCPbbzUOrSy6apsjZ461L
         c0YCH+2/v7JhR9FKlkFZngg28WabusDwrvpMln7mDNSdAXGBEQF//3+09oETV/MlGJ7M
         2+a6u+RF02y3X6rCmczkLvjWZssheoHNhXoyPf5tUNpWeSHmDloG8bOYhCmM9CZV8QAI
         BdQ8wLIWSwxwATaJHHlTwgwe2u/IEAOx2jXVr8l8jGtpmgRRd3Ps8XfSY5597VnlTy0t
         EeymnFjuq2e2MyDeD5mmuheXIvlqgD20l5OXu+j0M16vMiR1gJwImDLfEcRZyB9Qw6ZY
         xRQw==
X-Forwarded-Encrypted: i=1; AJvYcCU59nhGGDkKSlL5L8GKicA2j4z3nVQm3puBwmjahZPTNyX4u1IJWxZN0EiiOfgRxsx+cSpxJg==@lists.infradead.org
X-Gm-Message-State: AOJu0YziAvGktuR2r+NS39eZhxgfR6T5k45eNaBb8lQuZstWpgSRL9j3
	+NlFAgVOVaXbqboY/nxvEDdPnVQAvbXIeCMvMUPIXBzUR+PTFzfi3nIK87igFkB97Io7d1cF7xD
	KohH9hdjGX1S/CUMZIYsIfA==
X-Received: from ejeo7.prod.google.com ([2002:a17:906:8c7:b0:b8d:7cde:ce4d])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:9810:b0:b73:2b08:ac70 with SMTP id a640c23a62f3a-b8edf33e476mr828942066b.49.1770728675354;
 Tue, 10 Feb 2026 05:04:35 -0800 (PST)
Date: Tue, 10 Feb 2026 14:04:18 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260210130418.297153-1-mclapinski@google.com>
Subject: [PATCH v2] kho: add support for deferred struct page init
From: Michal Clapinski <mclapinski@google.com>
To: Evangelos Petrongonas <epetron@amazon.de>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	kexec@lists.infradead.org, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_050438_065595_5DE7020F 
X-CRM114-Status: GOOD (  21.60  )
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

When `CONFIG_DEFERRED_STRUCT_PAGE_INIT` is enabled, struct page
initialization is deferred to parallel kthreads that run later
in the boot process.

During KHO restoration, `deserialize_bitmap()` writes metadata for
each preserved memory region. However, if the struct page has not been
initialized, this write targets uninitialized memory, potentially
leading to errors like:
```
BUG: unable to handle page fault for address: ...
```

Fix this by introducing `kho_get_preserved_page()`,  which ensures
all struct pages in a preserved region are initialized by calling
`init_deferred_page()` which is a no-op when deferred init is disabled
or when the struct page is already initialized.

Signed-off-by: Evangelos Petrongonas <epetron@amazon.de>
Signed-off-by: Michal Clapinski <mclapinski@google.com>
---
v2: updated a comment

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
 kernel/liveupdate/kexec_handover.c | 23 ++++++++++++++++++++++-
 2 files changed, 22 insertions(+), 3 deletions(-)

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
index b851b09a8e99..26bb45b25809 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -457,6 +457,27 @@ static int kho_mem_serialize(struct kho_out *kho_out)
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
+	int nid = early_pfn_to_nid(pfn);
+
+	for (int i = 0; i < (1 << order); i++)
+		init_deferred_page(pfn + i, nid);
+
+	return pfn_to_page(pfn);
+}
+
 static void __init deserialize_bitmap(unsigned int order,
 				      struct khoser_mem_bitmap_ptr *elm)
 {
@@ -467,7 +488,7 @@ static void __init deserialize_bitmap(unsigned int order,
 		int sz = 1 << (order + PAGE_SHIFT);
 		phys_addr_t phys =
 			elm->phys_start + (bit << (order + PAGE_SHIFT));
-		struct page *page = phys_to_page(phys);
+		struct page *page = kho_get_preserved_page(phys, order);
 		union kho_page_info info;
 
 		memblock_reserve(phys, sz);
-- 
2.53.0.rc2.204.g2597b5adb4-goog


