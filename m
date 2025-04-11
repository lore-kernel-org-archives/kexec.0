Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D678C36010
	for <kexec@archiver.kernel.org>; Fri, 11 Apr 2025 05:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HQ8M8ey1Gl2HMhesfO/gX2yR3JwZ2sRCN/VQXFdpiJQ=; b=rXVCpIStfEVCsp0X2F9SAcjd9Q
	X/i0Cq/Rz6n6kLf+qMQe37d2cugAwqNsIFkF6oHYgqBkx1I0F/mp1zQIIE238QlD0rd5GZTzuTpD2
	MJ0cJAZKoAqhAvPijSlMphTUUjALOVY3dDC6YDg/gZNUCZK4DPThQdCB5YmeImUFwWC6dTZCi+bGB
	dRrSwYmNPS6PUiuPNFEvpie5T/BOgsVEqn78nsi9xIyxinghk9vkirPscXZEyYfGNIBZQuXn7u8NH
	QlCQs05rgQ0dBTOCr2+FfkITGJuOrggcu9dLWrkSCIBQYFn9f/YAsR6EkMjlwTiuAur7X1BW/qyzk
	u1LB9fEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u37BG-0000000CaD3-1glr;
	Fri, 11 Apr 2025 05:43:58 +0000
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u375s-0000000CYM5-2PQG
	for kexec@lists.infradead.org;
	Fri, 11 Apr 2025 05:38:26 +0000
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-2ff8a2c7912so1357467a91.1
        for <kexec@lists.infradead.org>; Thu, 10 Apr 2025 22:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744349903; x=1744954703; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HQ8M8ey1Gl2HMhesfO/gX2yR3JwZ2sRCN/VQXFdpiJQ=;
        b=Z5ID56RnsOcrSZmpD0BjHKDyfUhEknE60AyTG8QF271TO5SzGMnSj9397iSEUXeH0k
         Ult7LGm2/j3AvgSXNsCQK9x9qUuG+tUk4fuTk4PlUc0drs2HMadV8NOoFc8V4D9k/hlJ
         CIqBvRrrtpqEWERfMRdgu0cgMRft425koh5fpZvAYlC3YuGdSrqmwbHmHMS25fWU9Y6Y
         ekN5j/HaR5pvXz1P4miomGSSeIyO4q68yWS1py9AE9bCV3OmaqgLxE107Oa6yw4sTjIv
         6Vsk40fRk0VRKNj8LdWxnr7DuvYvdCjpsF8nw5M0ibpxejEud53Zo/XN+AQn2HucYPMJ
         L0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744349903; x=1744954703;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HQ8M8ey1Gl2HMhesfO/gX2yR3JwZ2sRCN/VQXFdpiJQ=;
        b=BCpMsvUUEMrLnHu01lqBh53CXdKzBq0otasGvsU8djsE4lv8vQevHplWdcSDU2AiGF
         EE6wwbaNqsaIjSvSqnvVr5Rq2mZFVxhpo37rNsDHfpsSsmLGZswzKfipqB9QMXSdWY3R
         X5Y1IkqG+DnCPWe8LEQ9dSVMnk2U05Q/2/HZGzvX8J3oOyDcFbbRy/j6bLK3/IjzotlT
         RX58iV0yj7Ng/O9qXJAMnXrJDCsCXiphVbdOUfDaPsfAfWaeWXc7+nwqmiwMVesUos1o
         FZsDmW7bWqldOfgaUp2cauybFCh2HRQpXOfJLPPYEqleRI5+XcwiR1lQeWleKXkQYrh+
         sogg==
X-Forwarded-Encrypted: i=1; AJvYcCX5XuFbdZY5uPE90WBwu00/yrONyVtulXfmu4V6RM+8coMwnUqAfROamXV3aPNk5oZM2+Zk1A==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyqp4XX+O3Q2GC/TI8eSgXsXbUSrfNTuawI4VL1L2gn51Yd7XUt
	bevVzoCEvegblOOqqzj7cdAuJS0re6F+PMNsjikVjuH0IfPbuCn3NRgPefjsvQp+RecLDl8OaPv
	DYq2uAxHOHkD3YO/DNg==
X-Google-Smtp-Source: AGHT+IEQLxxV+9EOL9iBdjttC+lt0gaa754ZypvrGgSETMYeFa4LebcqyNIPVN8012BWASehCUTqTktaMea5N6/C
X-Received: from pjbsg2.prod.google.com ([2002:a17:90b:5202:b0:2ee:3128:390f])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:58cf:b0:2fc:aaf:74d3 with SMTP id 98e67ed59e1d1-307730fecb0mr7763347a91.4.1744349903054;
 Thu, 10 Apr 2025 22:38:23 -0700 (PDT)
Date: Thu, 10 Apr 2025 22:37:34 -0700
In-Reply-To: <20250411053745.1817356-1-changyuanl@google.com>
Mime-Version: 1.0
References: <20250411053745.1817356-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250411053745.1817356-4-changyuanl@google.com>
Subject: [PATCH v6 03/14] memblock: introduce memmap_init_kho_scratch()
From: Changyuan Lyu <changyuanl@google.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, anthony.yznaga@oracle.com, arnd@arndb.de, 
	ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de, 
	catalin.marinas@arm.com, corbet@lwn.net, dave.hansen@linux.intel.com, 
	devicetree@vger.kernel.org, dwmw2@infradead.org, ebiederm@xmission.com, 
	graf@amazon.com, hpa@zytor.com, jgowans@amazon.com, kexec@lists.infradead.org, 
	krzk@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, pasha.tatashin@soleen.com, 
	pbonzini@redhat.com, peterz@infradead.org, ptyadav@amazon.de, robh@kernel.org, 
	rostedt@goodmis.org, rppt@kernel.org, saravanak@google.com, 
	skinsburskii@linux.microsoft.com, tglx@linutronix.de, thomas.lendacky@amd.com, 
	will@kernel.org, x86@kernel.org, Changyuan Lyu <changyuanl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_223824_641760_256EF9DB 
X-CRM114-Status: GOOD (  13.37  )
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
index 50c2f590b2d04..a47e5539321b4 100644
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
index 3a213e2a485bc..c2633003ed8ea 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -946,6 +946,28 @@ __init_memblock void memblock_clear_kho_scratch_only(void)
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
index 84f14fa12d0dd..1451cb250fd3f 100644
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
2.49.0.604.gff1f9ca942-goog


