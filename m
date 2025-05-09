Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349ABC3ABC9
	for <kexec@archiver.kernel.org>; Fri,  9 May 2025 08:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4JV2egkEexGC2KVdW3wwgddRMOlB2ZWufNhl8IHgg18=; b=DWvDP+Eo6WYWWoM0HArnx5Sz/7
	U8B0ygCAUbTLnic4E/02ptzB6r8DNqAfXtgU+UgJ6URSVaN128fOQYPvIVpZc/g6AAungYTm9pfY9
	o9HCcZz33/0NAuu69W/UGWyUSKsjwQ7+Z/tHB8XwtO2GtuUxqR8yc9k4wJ0vFrKY19x035XH6kQXL
	0jp01Ua8lL5E/lvnMjjoD7W6v091KivyuFGLNg+/JI9YCh7tys4qAd/gjXALu0cC5nSg5bGEnZNev
	F5QihRhKCExzyE95n8mVQr5xJJyD3dPdvpCBH8n5IU8BSItIVNbmxbWSM4GVkWwbI3Iq96LnPUs3W
	b136r2vA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDIna-00000002sAf-3yXL;
	Fri, 09 May 2025 08:09:38 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDIS7-00000002nrO-2wIT
	for kexec@bombadil.infradead.org;
	Fri, 09 May 2025 07:47:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4JV2egkEexGC2KVdW3wwgddRMOlB2ZWufNhl8IHgg18=; b=HRMMStgOFAsnPu536c6hn4ecLq
	++TCzHvLor3eDnWxO/yC5W6q3VZrMu5csFpN7LC67FERy8DwvEIV5bfzAg1WePXWERs1msn/mgfPq
	yPc+PFYpmVnbIBMUb75Vva2z93qqsMq175PzvaT7Mywbsyq65suP48gbA7rcGLW8U5nH6IRLsouTF
	Ox64Bf6tnuMmrAxLYk8VB3fQoqjQqlifpSE8sxv4sptsOCh4ap4lAagJqI2xpOub+U01cWDj+Orol
	tQF80/1Piyh7j82M9kMZedxarg8gXYcXex3K1VNjr5E5v8/KxlHAlciwEyYw39vGNkoj0veLvnQSJ
	abUINtsQ==;
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uDIRj-0000000GEeo-0MJP
	for kexec@lists.infradead.org;
	Fri, 09 May 2025 07:47:15 +0000
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-b2002bcaa55so871519a12.1
        for <kexec@lists.infradead.org>; Fri, 09 May 2025 00:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746776818; x=1747381618; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4JV2egkEexGC2KVdW3wwgddRMOlB2ZWufNhl8IHgg18=;
        b=e1GU8KTRBCY4Oc0yFRpAPaPaYrlPOWsKbTjzIxJUVSEoHBOTuhoOQiPJGebJl1o7vN
         1Ud6c5GIfq794Ha5HI8r0O+NdR+cjW1R4BSFtGcXnew3p6jeXgt4DHz0+CPoDBxzuUPP
         qn1Lrn5RKf1vsadiI9pUeW0NuS8mGuUBnN2LPOr4oeit1f0AQcIL9g6aUNnLQlIZ6+3G
         sd+OMfkCCxYKtYPYSYj/J8xk5bc4FaZH4w5P4ASpK0H8lgUWaH2hDY16j9XdYSQEMFQ0
         4imNbmgJtynpfKQX9Nhz4SHh1eNOjMgN5QI8rs1kNo2CP0/Ss4ZBOK+O1jA6jUJHdiQ9
         cGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746776818; x=1747381618;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4JV2egkEexGC2KVdW3wwgddRMOlB2ZWufNhl8IHgg18=;
        b=jvTANT/usaKNw+AElZcQDOfC5nlvtcTcSQ0RNlKKVv1q9NMNLsg1YrDDBM6tTmuzsV
         NzqEx/vey9NDlzWzDCp+Jwsp4KAdXNuLN0txHT9qkjSej+od5szu2WdDpsdbjjUQd3X5
         0po4BTqY/l5F1rCZrmlyIaFuOwsHOBZN5cELUKnvMhFm02z8/br8pbV5F+9llxNiRtLQ
         fw1InyEbJxm6aPIFgL1MzaF6YCurHPT2bjw8V0ZtrkZYGxAC5dqxFJRHcYsz14cMbD91
         AvBUsqjQ/RDqf98KWqIbI3J+J1h3ZFzY6CjpkPoZTPcZ5kwWIvpdVIWRIwcCP/OTzbqS
         7LjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVR6TEiGTmftUoMYz2NFzvImbYjLFArYxNsHrxTQbcokcbRTDYbzCLp+yAya/yHPrBETszrw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzDtiEfIFw9igIZzvI5Az696iflLB2HscULsH0JTFZ3w5Z5P14M
	0fcc2+/WTtjX+IlLWSF7OQQ0dSAcftP2oqmDKTPnJicC58HWqgYDaheO4wZuBtnBkQhlSk6AWdA
	FhA/lqGP3YSvxfhBDrg==
X-Google-Smtp-Source: AGHT+IE8BHG0gIhtKMP95nkOnFyM8l48yB2kt14KYWpJX66kgx1Q1oJi29flkDnsQNF/jOCJx+09Qacohn+DYiah
X-Received: from pge26.prod.google.com ([2002:a05:6a02:2d1a:b0:b1b:caa8:2ec9])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:158d:b0:1f5:64a4:aeac with SMTP id adf61e73a8af0-215abd23d71mr3064222637.33.1746776818314;
 Fri, 09 May 2025 00:46:58 -0700 (PDT)
Date: Fri,  9 May 2025 00:46:21 -0700
In-Reply-To: <20250509074635.3187114-1-changyuanl@google.com>
Mime-Version: 1.0
References: <20250509074635.3187114-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.1015.ga840276032-goog
Message-ID: <20250509074635.3187114-4-changyuanl@google.com>
Subject: [PATCH v8 03/17] memblock: introduce memmap_init_kho_scratch()
From: Changyuan Lyu <changyuanl@google.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Cc: anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com, 
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com, 
	corbet@lwn.net, dave.hansen@linux.intel.com, devicetree@vger.kernel.org, 
	dwmw2@infradead.org, ebiederm@xmission.com, graf@amazon.com, hpa@zytor.com, 
	jgowans@amazon.com, kexec@lists.infradead.org, krzk@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, luto@kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	pasha.tatashin@soleen.com, pbonzini@redhat.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh@kernel.org, rostedt@goodmis.org, rppt@kernel.org, 
	saravanak@google.com, skinsburskii@linux.microsoft.com, tglx@linutronix.de, 
	thomas.lendacky@amd.com, will@kernel.org, x86@kernel.org, 
	Changyuan Lyu <changyuanl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250509_084709_840728_888ECA67 
X-CRM114-Status: GOOD (  13.80  )
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

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

With deferred initialization of struct page it will be necessary to
initialize memory map for KHO scratch regions early.

Add memmap_init_kho_scratch() method that will allow such initialization
in upcoming patches.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Changyuan Lyu <changyuanl@google.com>
---
 include/linux/memblock.h |  2 ++
 mm/internal.h            |  2 ++
 mm/memblock.c            | 22 ++++++++++++++++++++++
 mm/mm_init.c             | 11 ++++++++---
 4 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 993937a6b9620..bb19a25342246 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -635,9 +635,11 @@ static inline void memtest_report_meminfo(struct seq_file *m) { }
 #ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
 void memblock_set_kho_scratch_only(void);
 void memblock_clear_kho_scratch_only(void);
+void memmap_init_kho_scratch_pages(void);
 #else
 static inline void memblock_set_kho_scratch_only(void) { }
 static inline void memblock_clear_kho_scratch_only(void) { }
+static inline void memmap_init_kho_scratch_pages(void) {}
 #endif
 
 #endif /* _LINUX_MEMBLOCK_H */
diff --git a/mm/internal.h b/mm/internal.h
index e9695baa59226..acfcefcbb6c03 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1121,6 +1121,8 @@ DECLARE_STATIC_KEY_TRUE(deferred_pages);
 bool __init deferred_grow_zone(struct zone *zone, unsigned int order);
 #endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
 
+void init_deferred_page(unsigned long pfn, int nid);
+
 enum mminit_level {
 	MMINIT_WARNING,
 	MMINIT_VERIFY,
diff --git a/mm/memblock.c b/mm/memblock.c
index 6eba0dfe87155..b9148822db7aa 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -946,6 +946,28 @@ __init void memblock_clear_kho_scratch_only(void)
 {
 	kho_scratch_only = false;
 }
+
+__init void memmap_init_kho_scratch_pages(void)
+{
+	phys_addr_t start, end;
+	unsigned long pfn;
+	int nid;
+	u64 i;
+
+	if (!IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT))
+		return;
+
+	/*
+	 * Initialize struct pages for free scratch memory.
+	 * The struct pages for reserved scratch memory will be set up in
+	 * reserve_bootmem_region()
+	 */
+	__for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
+			     MEMBLOCK_KHO_SCRATCH, &start, &end, &nid) {
+		for (pfn = PFN_UP(start); pfn < PFN_DOWN(end); pfn++)
+			init_deferred_page(pfn, nid);
+	}
+}
 #endif
 
 /**
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 9659689b8ace0..128c100fdb977 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -743,7 +743,7 @@ defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
 	return false;
 }
 
-static void __meminit init_deferred_page(unsigned long pfn, int nid)
+static void __meminit __init_deferred_page(unsigned long pfn, int nid)
 {
 	if (early_page_initialised(pfn, nid))
 		return;
@@ -763,11 +763,16 @@ static inline bool defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
 	return false;
 }
 
-static inline void init_deferred_page(unsigned long pfn, int nid)
+static inline void __init_deferred_page(unsigned long pfn, int nid)
 {
 }
 #endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
 
+void __meminit init_deferred_page(unsigned long pfn, int nid)
+{
+	__init_deferred_page(pfn, nid);
+}
+
 /*
  * Initialised pages do not have PageReserved set. This function is
  * called for each range allocated by the bootmem allocator and
@@ -784,7 +789,7 @@ void __meminit reserve_bootmem_region(phys_addr_t start,
 		if (pfn_valid(start_pfn)) {
 			struct page *page = pfn_to_page(start_pfn);
 
-			init_deferred_page(start_pfn, nid);
+			__init_deferred_page(start_pfn, nid);
 
 			/*
 			 * no need for atomic set_bit because the struct
-- 
2.49.0.1015.ga840276032-goog


