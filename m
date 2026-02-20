Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EC18C5AD05
	for <kexec@archiver.kernel.org>; Fri, 20 Feb 2026 16:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PT6A/oALwI3aAl9sXp0IZoMRZ6ospSVkKGQtoOfj3Zc=; b=Vp1bFin5j2jHeeUbTvUODVkGzu
	W50eylgtzopQenDN4mBBxbSSZx72gbEKq7uieDdpkewhALMQEMOwIFCbA1rlRwNgQK01sat4errm7
	Ax9NHWQpN+/sKUmvS+rYwMfhSashW0qjhR3OLEc/BZ73XcBKeC8c+24ICBy+s72zWcOZtxoF5a5ud
	bbPyivkgtMUKUidZ7g1hcQ6GROD1Ofohq18hQVSNvysdk56FKC+OljK6wEjlEMYkqsMxJiZBHzPuI
	eO1ZFulTNPJUk7M8po29tcKHkoo+GMRa8g/X1IiIflQzeoj0zqy1w342ffhtujJMFWdciMenpKnK9
	8SgPXwsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtTjn-0000000FKgu-2SUS;
	Fri, 20 Feb 2026 16:52:19 +0000
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtTjl-0000000FKf7-2iKR
	for kexec@lists.infradead.org;
	Fri, 20 Feb 2026 16:52:18 +0000
Received: by mail-wm1-x349.google.com with SMTP id 5b1f17b1804b1-483a24db6ecso20610025e9.1
        for <kexec@lists.infradead.org>; Fri, 20 Feb 2026 08:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771606335; x=1772211135; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PT6A/oALwI3aAl9sXp0IZoMRZ6ospSVkKGQtoOfj3Zc=;
        b=rnL97ZpcHEK9q5/66nFIpQP2YyKOfJ66nMJZL+2ctYPuNWT9PwQWLVC6e4dr3TWBfR
         qoUM4d4P8wnztTm5fe7pjhHgdkhrhhiCjPTr4ISQEb/tm46ze1We3zo10q/miH+FBtr/
         /0g61mWyK9F1NQji/SpFazhh2h/UTIPgEw+PD8r21WlFxkYqYU8L/6kKABy5oRkrqLJR
         ZvtjCGbKJE49s2oSZ0j3oR+AZGlPGn6ppSU6Hgv389QwiIDjWBbFTmSQvwtbjSGDqHR9
         c93vwtx4I9jbmQb3Z8pb/mKADfvxEVpkJx7EwyIrcfhD7Sb7+FolFVMwJJp+UQW/TExC
         NVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771606335; x=1772211135;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PT6A/oALwI3aAl9sXp0IZoMRZ6ospSVkKGQtoOfj3Zc=;
        b=eBEAEVIoK4mBpo/hXlPdfyBeqOXA2S0qghSypCreel6mtbuc/17vYMZ6IVTN7H5CpO
         UOEDd0VZH+fwRgCPeSDYanIbyb46zPT3umqb5px0wecJSYxLCJdHSpzL4i7Y7PzXjoEG
         ALAPte/BtoUOaLiHCBAuo2GCESZgDfUMiu95b+Wf8dRlDqPuw0AyKS+7KGpcx2S3JlTU
         hL65ZPz5hS0sujsPtU3neHV2xL0xuchC6R2Ypa1UOMm/z1gGyL5kQjOTlowgKMZ6n24V
         j/IiWbMtTn2pOgl/gwmMa7lfbzRWwtJKXievBrQVlVitp/vOpyxvIwHIC0ihGQAJ485G
         h/mA==
X-Forwarded-Encrypted: i=1; AJvYcCUqDtpdCpu8KVjbgQDRTxsEwLDvW5wxscMyWttY8jNOtNjI4EBhI+7OLfMpsBxQ2h/3x2N8Dw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxcHcOO97vwlvpqBKoZ5gNQxKaw3TeZtHus7ZYqCur446udnNUW
	S53sjvGFLFBDACTHqPAv2bPJxGMhOQM1j+paO4/3vEXJewwKIsE9Y1cwDcLdKcBf3XD90XNEafJ
	mMhKhkeoz3aLoiNAB4BOdEQ==
X-Received: from wmpu13.prod.google.com ([2002:a05:600c:4d0d:b0:483:a1ee:5eb8])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b03:b0:477:54cd:200e with SMTP id 5b1f17b1804b1-483a95eb622mr2764805e9.1.1771606335280;
 Fri, 20 Feb 2026 08:52:15 -0800 (PST)
Date: Fri, 20 Feb 2026 17:52:03 +0100
In-Reply-To: <20260220165203.3213375-1-mclapinski@google.com>
Mime-Version: 1.0
References: <20260220165203.3213375-1-mclapinski@google.com>
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Message-ID: <20260220165203.3213375-3-mclapinski@google.com>
Subject: [PATCH v4 2/2] kho: make preserved pages compatible with deferred
 struct page init
From: Michal Clapinski <mclapinski@google.com>
To: Evangelos Petrongonas <epetron@amazon.de>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	kexec@lists.infradead.org, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_085217_718347_C5FF238E 
X-CRM114-Status: GOOD (  20.84  )
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
index de167bfa2c8d..fe9c88fd2541 100644
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
+	for (unsigned long i = 0; i < (1UL << order); i++)
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
2.53.0.345.g96ddfc5eaa-goog


