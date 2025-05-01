Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E1EC3ABA9
	for <kexec@archiver.kernel.org>; Thu,  1 May 2025 23:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PU6GtX2pwIoZ+oeXsFDcea4JO+KvjjzbgnTTu1rA7Xs=; b=o2e2edvsUFzrLXizci1fSX8fkV
	sjUiCi+UNMWdJ8F42A5lIJwzGmqhlwkJs+pNZFTa1uLCyOScxltpUE1oR0bkh+pj+/QOGmFWhFPtF
	REIKkoWm03NHJaO1VCKMsGxyr+r2hazqFlzzFM6SZLRWsUvASPTx6h5t7v8ix0bkuG48zzyPSPTG8
	gyiN+EiJFP1AvSvWUa2GkS6S7D6dc2YMUVQBebzsKl5ct8y53Xg76O0PjSOzmNKWiqEswRwTtRfGP
	IVg+LijhrkItH4UpzXPo9FfwYyeGIKrTsDn2Gfzpbc3g+WBzAQgVZkxzB7ZskFHh/JByKJfzkrLOr
	kC9+r5eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAdKL-00000000Gtm-3CvC;
	Thu, 01 May 2025 23:28:25 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAcp9-000000007oL-23L4
	for kexec@bombadil.infradead.org;
	Thu, 01 May 2025 22:56:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PU6GtX2pwIoZ+oeXsFDcea4JO+KvjjzbgnTTu1rA7Xs=; b=jVraPLx5gLSoLfn+xlKz9GrLMT
	ROVZXZ9J0c9ahFPhFr6XuKVmqosRnEgg3AiXGWFJJS1LkJ/+CocGph5skyiMFwRYdVfxFAQJDNW44
	xTRiPdWp7XMNExKVVwpBIQ+lx5n3/OsinzvZNTDbTAxgfEREWcHy8Nup40zeJazbzxO32Jjkntlh0
	z3G3nGEW5Vp+MJeX5hOFwusTj9Aua0Bs/R9E1B4AFnjiFrxfXCbfjhMWvPw4BkZ5EZPzM5s4gW77R
	BR9RLJhkr71dbP0LIzK1QsKB9nEa+efq3+byvxrNr1AJ2PAxMroNOO8Ra3Tq1gToYPPcaYBOfjO5c
	RvO2yjtg==;
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uAcoL-0000000EC7C-3IG7
	for kexec@lists.infradead.org;
	Thu, 01 May 2025 22:56:07 +0000
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-22aa75e6653so11505975ad.0
        for <kexec@lists.infradead.org>; Thu, 01 May 2025 15:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746140114; x=1746744914; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PU6GtX2pwIoZ+oeXsFDcea4JO+KvjjzbgnTTu1rA7Xs=;
        b=WJQoOSRcHNRmxLQIMhR8ADJNbtSdZMMjvg4qaASbwgfNXy7zn37Lx3H6NxhggSLlVL
         7gjGdh/c/vQdm9nNaQq0mNTQLKYasy4VX3AarRcuAu1H7xubJhyUlWx/sU3DsSmzBifO
         qP2AEx1rRQ1CGbBO9ExB0qkgre1f4rA5/jzoxjYsBp2m6a1mXULS1+Rc24oqKq6MSc9P
         2e0V7FdHzEh7ar/CB/TTdlhGmIeej4r+naR9BnBEgt2p/e/flYrMNA5RkY0/zduCicWb
         U9CGJbnQVaVWklZRbVURDxHYNfxdCCmyZBL5LO7LPJu8bRSFNnXgxrEA4o09QZPBqJe0
         NDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746140114; x=1746744914;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PU6GtX2pwIoZ+oeXsFDcea4JO+KvjjzbgnTTu1rA7Xs=;
        b=YXn99gmpVl8t10ehT8pPqK+3jbsE4msfdAMF/vmLvhoPh2Sljj+cLvddZe2P0UYgiB
         JePA2f6IW0v2DpW7hDuPTnR327spGRPyRBnCGwBH6WZYWCVxtWbUt1xjgyIeUp+r8B+g
         J9CYnfnFOu2RWBWCoPDx97pikRj+swUzJlipl9shBwxk/4osWfylAohIaB4b2qbQ/4mn
         ikTklQkQ6uwM41o2n04m4DCQSAQAGixT/AFUVXCr2/sDWFKoS6BMhH+lJgQWGkra0+Sv
         GW5LW/qHkoKZicUfOYlbvL1LdCSe1oiGPvVu1tuA1nIeO0d2FrZfZBZVA4a/7Poka1B6
         V11w==
X-Forwarded-Encrypted: i=1; AJvYcCXSyWwgY5zHcN/foQmaAlB0eHG/J+CNZEacktCWj3Adxzr+j5W2nY1hbNlTbotliaAEeoZQlw==@lists.infradead.org
X-Gm-Message-State: AOJu0YxyS2CAGVQoQ46tKyqet8I2HP6GZii/jvrw6nX2GvA04lYMkOEi
	LVzPc577fq+x+Bi/b1cnveUzqsEhS+9PaXq4nrJxkjQe1EGI979LKm6D79g3R7wWzNOi9zL2qPj
	EaysMBuWyyZtqCN1cbA==
X-Google-Smtp-Source: AGHT+IFpAiNl+3FkGzd/ZjF3I8ZI1ZYYyAMk4qubhYhnEjGbgwWF72zcJID/AaxklWlETZc79qrz2DC4EU5jSuqH
X-Received: from pjbqc3.prod.google.com ([2002:a17:90b:2883:b0:2fa:1481:81f5])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2450:b0:224:1935:fb7e with SMTP id d9443c01a7336-22e10342da4mr11671725ad.24.1746140114125;
 Thu, 01 May 2025 15:55:14 -0700 (PDT)
Date: Thu,  1 May 2025 15:54:10 -0700
In-Reply-To: <20250501225425.635167-1-changyuanl@google.com>
Mime-Version: 1.0
References: <20250501225425.635167-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250501225425.635167-4-changyuanl@google.com>
Subject: [PATCH v7 03/18] memblock: introduce memmap_init_kho_scratch()
From: Changyuan Lyu <changyuanl@google.com>
To: linux-kernel@vger.kernel.org
Cc: changyuanl@google.com, akpm@linux-foundation.org, 
	anthony.yznaga@oracle.com, arnd@arndb.de, ashish.kalra@amd.com, 
	benh@kernel.crashing.org, bp@alien8.de, catalin.marinas@arm.com, 
	corbet@lwn.net, dave.hansen@linux.intel.com, devicetree@vger.kernel.org, 
	dwmw2@infradead.org, ebiederm@xmission.com, graf@amazon.com, hpa@zytor.com, 
	jgowans@amazon.com, kexec@lists.infradead.org, krzk@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, luto@kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	pasha.tatashin@soleen.com, pbonzini@redhat.com, peterz@infradead.org, 
	ptyadav@amazon.de, robh@kernel.org, rostedt@goodmis.org, rppt@kernel.org, 
	saravanak@google.com, skinsburskii@linux.microsoft.com, tglx@linutronix.de, 
	thomas.lendacky@amd.com, will@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250501_235556_730011_4D17EA99 
X-CRM114-Status: GOOD (  13.97  )
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
2.49.0.906.g1f30a19c02-goog


