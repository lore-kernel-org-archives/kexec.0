Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDE8DC35FFC
	for <kexec@archiver.kernel.org>; Thu, 20 Mar 2025 02:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PiwjRVxMAh+aRSJQzROvUDuvUP7bfHphETD8QOGYAo8=; b=G76lHaXtDHNGBEIPu66QG6/x5W
	jyzTrIt1tFsgEvNCzF3yjGCYdr7lPRjVrvvmcaPYSodkUeuYJphDyJSjzYD0gBDl4v0fU4rL15h3Z
	TkmITr7nZve6zWwF9Cp2kWThgkAqZ7VUi2aKNEAuI1RPKttXqKkupu+dxw2g5ZZCMiNquzn7ovr9S
	ij2nD0vm4kDwShp2bJt06g3cyD2f93LuOvHbLvEQln7y5BkCRnKkuciDWaZVec5WTQCiSFoznI2Z0
	dyb7d5OwpWgtgg7c0BU6HdNIzL0VbmXAP2CfJp7WBrLjzaW9878/anw/m3JCnbHdqEhcyPpQpgcVU
	BVtoif8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tv5H6-0000000AnV2-1v0y;
	Thu, 20 Mar 2025 02:04:48 +0000
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tv58j-0000000AkPJ-0WtD
	for kexec@lists.infradead.org;
	Thu, 20 Mar 2025 01:56:11 +0000
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-2ff78bd3026so447169a91.1
        for <kexec@lists.infradead.org>; Wed, 19 Mar 2025 18:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742435768; x=1743040568; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PiwjRVxMAh+aRSJQzROvUDuvUP7bfHphETD8QOGYAo8=;
        b=RN9NBzYXSqbk5T/lJdmEzb43eApU61hu3hmHEoS9ryAjTrh59MAlol0ZHcppLIGY9h
         GVVZRzMdPB9ZBWnsOIaoUATQmGTQheeybNX+gyxqcT8aeI4q+79PH80ke/ALQHpdJ/7e
         OZa7aKxezCsL9XjlCjcIfpKjlN62ltMm53z4ZBgy5PxElAoblnCb84r4tJl0zC1jiHpY
         cTT6vVdaOpC3kBzaGsL0zvd1Wq9gYrsj/tskPaU8bBVTKNQmoWey9dSYn2ui2wxFJ51A
         1wmTL7k+vM8OsUVO+yjXqA1Xy1bu+nBF6SV2Aan41QeroVDnFJ/EVGmvLje5gXNPyt5j
         zDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742435768; x=1743040568;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PiwjRVxMAh+aRSJQzROvUDuvUP7bfHphETD8QOGYAo8=;
        b=BUCkveNIUThSUu7sAQSNrYEpndqXKE2NOjrvmbClKx9BAV+B2HBVNNIn+wILRk+VyI
         vi9lWIK+J8lp/t8ZCV+o14navEBGz9gwYVYi+XqW2MIgjxpA6gLuDQ8duB99A7KqFbiu
         QRQ5ovcEVJpsJQhgz2iduaT3qWbySdfBq5X9Mn/qZFfQQZ8bFYbTZ3Tw/iBJM6monydC
         BULmrntDYCjbX+/85J7Ia4a2muoBvaFcL2XUqFPDYPGwGbiPGV5asewNoUBgl6G85kjU
         zxMEwJ25/LsWCWF6V8dYtP8YQmQXqnYA7WUKNVHHuMHH+xq88Wi268F4dLGiU3Ia2uqL
         AbJw==
X-Forwarded-Encrypted: i=1; AJvYcCVp+a89BNsEV2D3Hp48LuEMP63/FXTCwkcjyxiVMkO42ttwFUpqKoWFlIhHKBMFY/mCsPHv6g==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz//VTj0LICDIElJap8J68ZEFm9AjJhytQIlRfSBwxC6RPypL+t
	rtZJZB9qBaXCh8YRn1dBjZsajVyQ86Y2Dgrz9j+emsPhWWDRqKPACiIozo/Z77OW+wtH2VoHJZ2
	byDF+WzzycFcaRkfs4A==
X-Google-Smtp-Source: AGHT+IEhVbWDRhW3hPJYHJMT+HzW9sk9EOurakKCEQdD5tgMb9uQ2NYyCFbTRsSUUBpQ3kTf4vM/PmcUJOjFZ+gE
X-Received: from pglu36.prod.google.com ([2002:a63:1424:0:b0:af2:22fe:cfb3])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:4cc7:b0:1ee:e96a:d9ed with SMTP id adf61e73a8af0-1fbeaf88adfmr8896191637.7.1742435768113;
 Wed, 19 Mar 2025 18:56:08 -0700 (PDT)
Date: Wed, 19 Mar 2025 18:55:40 -0700
In-Reply-To: <20250320015551.2157511-1-changyuanl@google.com>
Mime-Version: 1.0
References: <20250320015551.2157511-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250320015551.2157511-6-changyuanl@google.com>
Subject: [PATCH v5 05/16] memblock: introduce memmap_init_kho_scratch()
From: Changyuan Lyu <changyuanl@google.com>
To: linux-kernel@vger.kernel.org
Cc: graf@amazon.com, akpm@linux-foundation.org, luto@kernel.org, 
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com, 
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com, 
	dave.hansen@linux.intel.com, dwmw2@infradead.org, ebiederm@xmission.com, 
	mingo@redhat.com, jgowans@amazon.com, corbet@lwn.net, krzk@kernel.org, 
	rppt@kernel.org, mark.rutland@arm.com, pbonzini@redhat.com, 
	pasha.tatashin@soleen.com, hpa@zytor.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh+dt@kernel.org, robh@kernel.org, saravanak@google.com, 
	skinsburskii@linux.microsoft.com, rostedt@goodmis.org, tglx@linutronix.de, 
	thomas.lendacky@amd.com, usama.arif@bytedance.com, will@kernel.org, 
	devicetree@vger.kernel.org, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250319_185609_199609_7C3E7196 
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
---
 include/linux/memblock.h |  2 ++
 mm/internal.h            |  2 ++
 mm/memblock.c            | 22 ++++++++++++++++++++++
 mm/mm_init.c             | 11 ++++++++---
 4 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index a83738b7218b..497e2c1364a6 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -636,9 +636,11 @@ static inline void memtest_report_meminfo(struct seq_file *m) { }
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
index 20b3535935a3..8e45a2ae961a 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1053,6 +1053,8 @@ DECLARE_STATIC_KEY_TRUE(deferred_pages);
 bool __init deferred_grow_zone(struct zone *zone, unsigned int order);
 #endif /* CONFIG_DEFERRED_STRUCT_PAGE_INIT */
 
+void init_deferred_page(unsigned long pfn, int nid);
+
 enum mminit_level {
 	MMINIT_WARNING,
 	MMINIT_VERIFY,
diff --git a/mm/memblock.c b/mm/memblock.c
index c0f7da7dff47..d5d406a5160a 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -945,6 +945,28 @@ __init_memblock void memblock_clear_kho_scratch_only(void)
 {
 	kho_scratch_only = false;
 }
+
+void __init_memblock memmap_init_kho_scratch_pages(void)
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
index c4b425125bad..04441c258b05 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -705,7 +705,7 @@ defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
 	return false;
 }
 
-static void __meminit init_deferred_page(unsigned long pfn, int nid)
+static void __meminit __init_deferred_page(unsigned long pfn, int nid)
 {
 	pg_data_t *pgdat;
 	int zid;
@@ -739,11 +739,16 @@ static inline bool defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
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
@@ -760,7 +765,7 @@ void __meminit reserve_bootmem_region(phys_addr_t start,
 		if (pfn_valid(start_pfn)) {
 			struct page *page = pfn_to_page(start_pfn);
 
-			init_deferred_page(start_pfn, nid);
+			__init_deferred_page(start_pfn, nid);
 
 			/*
 			 * no need for atomic set_bit because the struct
-- 
2.48.1.711.g2feabab25a-goog


