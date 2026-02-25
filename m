Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C33FD376A
	for <kexec@archiver.kernel.org>; Wed, 25 Feb 2026 15:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tQzAMSBymjIc7twUCIwXZitW9lygfMtcVFGOkxE5cgc=; b=FfTeS33jIsSTQ3AtyHhrYCqbO3
	1KrA826Y4/VNbsxj0FaH896FBuHpfU02Gb+xnNpaxH4dLk8JLmo9NvIq1T3y5R111Iw4Kfhzm3Xgg
	BmUk/HhVw74KWtsxqBC8dc0IGSrsQ9hLTO9UQTyNWQyUdZJpu/QpqUx2Ehdk6W0X9WgOp2O4j8s7/
	PKX4jpHtuiCc52aCdCRXV5KI5+YC0R6KkRZXm9PyfOtZOxfCZeye+CZdSslM65FIihbvtphNfrgh3
	dxhIkiC1PpHCumQLvydy+LlJ8DHNQZ06UjKm7qB0AYMN9nJTKK3sgxweM3Euu3s6HLpOJXAFmVjOy
	CQfkfGsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvGzl-00000004MpX-1Gv1;
	Wed, 25 Feb 2026 15:40:13 +0000
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvGzj-00000004MnH-09Ci
	for kexec@lists.infradead.org;
	Wed, 25 Feb 2026 15:40:12 +0000
Received: by mail-wm1-x349.google.com with SMTP id 5b1f17b1804b1-4836e35292cso54832155e9.1
        for <kexec@lists.infradead.org>; Wed, 25 Feb 2026 07:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772034008; x=1772638808; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tQzAMSBymjIc7twUCIwXZitW9lygfMtcVFGOkxE5cgc=;
        b=iXsZHELzudhqbFmT2t2trWO7sDlkre0kXoT8kfqVNXDUbiBqAaquYRYpwzucyL8B5G
         9v4kL7zQyUxglJZUPZfWFD7ytRdsqBRVPGUDjL7W/K1euQ1zpUiJSasH7gvX9vJmfDy4
         JCqwICg/XBtbea53Q075y/+zZh5yPlKaJKo4TLnDASjMuzqJBX6OsipUzyltR8VV4SO1
         1ids40Ei8hh+03Ag1OA42Wgcz2Ywsmaa0P62lJkyJYrgO3cUIb2WW7IPv2sbGoI1lmhe
         JKlNGMOzSdZCQcjXk3CUiRrMdVY8fK39mtwMrVKoBGYXj5BOk+mKl6mawSy17USYWRu1
         eL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772034008; x=1772638808;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tQzAMSBymjIc7twUCIwXZitW9lygfMtcVFGOkxE5cgc=;
        b=masVMlN1436ekKXIzUO/UsE5x05+NaK8IjvhZ8YbjpBQ+fGgcGIGu8Pey5rogf8e2T
         nIXvq65Vt4dWT4PmY28zRt56oGXlgFsDxtzWFwFUPw9hdXt1Nuqp5EvFJSrxrLFAghja
         GZySZFTSKZyeK3hPdnuMz++EiEhPFi/1m6PmLY2b26vLCGXOmB+Hy+YDYlL8EvjbadnF
         Fh+HkAm/f9wQrRCLa7Y2XOvJeDL8H1UUaZEJQhjdw5MeDA7LJTrmHEladhswlXVqLc9U
         wt2P1rnXKx1axO+L5LvWSCLpED/biBZ4bs6kw8ckpNS1b/zu/T/smlslhDhjUEBMmutK
         uTJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLGv+IEEKH31lbUfV29JlfzmHdG/QZ6fCs2nABgZCIo/O89VmHWkDPOQ11j71+lOalJzOUGA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yymxxiv8mf6InrSpfWj7lxULnZJZgEJebySZ7G5INlET9CcHpb3
	fWuzQ5jOYcn2MwJx7Lces30Bb6KhBb0syAFkm7GuOQCtKKmgkUPfXMfUnsU5m3Rhay0zBOFqb3F
	wffgNY9bT+MsqDDuxn3J/gg==
X-Received: from wmjs3.prod.google.com ([2002:a7b:c383:0:b0:47e:e47f:de89])
 (user=mclapinski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8595:b0:483:badb:618a with SMTP id 5b1f17b1804b1-483badb6355mr83029045e9.27.1772034008494;
 Wed, 25 Feb 2026 07:40:08 -0800 (PST)
Date: Wed, 25 Feb 2026 16:39:55 +0100
In-Reply-To: <20260225153955.1006649-1-mclapinski@google.com>
Mime-Version: 1.0
References: <20260225153955.1006649-1-mclapinski@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260225153955.1006649-3-mclapinski@google.com>
Subject: [PATCH v5 2/2] kho: make preserved pages compatible with deferred
 struct page init
From: Michal Clapinski <mclapinski@google.com>
To: Evangelos Petrongonas <epetron@amazon.de>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>, 
	kexec@lists.infradead.org, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Michal Clapinski <mclapinski@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_074011_112524_4B5C3A43 
X-CRM114-Status: GOOD (  21.26  )
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
index 1e1f69b10457..761d7c9c1ed8 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -470,6 +470,31 @@ struct page *kho_restore_pages(phys_addr_t phys, unsigned long nr_pages)
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
@@ -478,7 +503,7 @@ static int __init kho_preserved_memory_reserve(phys_addr_t phys,
 	u64 sz;
 
 	sz = 1 << (order + PAGE_SHIFT);
-	page = phys_to_page(phys);
+	page = kho_get_preserved_page(phys, order);
 
 	/* Reserve the memory preserved in KHO in memblock */
 	memblock_reserve(phys, sz);
-- 
2.53.0.414.gf7e9f6c205-goog


