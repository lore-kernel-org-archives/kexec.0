Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E91CEC982FF
	for <kexec@archiver.kernel.org>; Tue, 22 Sep 2026 08:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XrAQfB99bFPUaNh0c5d2OUhMy2tKXocwdCbeEYRe5yE=; b=Pvi4VbeQYftAljuSKHT2XZPP63
	bXiwnX8jrcoxg1yf2e49NTzrkQGBca2PF58T0obAb57Xugj/X7irGz2OLChrkrwo9MNHFx9HC9FZW
	UbDn+V3SqPjTeWImy7JOS7aBuRzbycNrQQN/1dJL8OQbMwnz0hR0piGj1z8Z+q4JQSymebk1BpejS
	sr8EAbAU6hT4ondCNxaqe0bNZGFJswiGscTV8q84h81PneR7vbnVAcdqB0pFEE8TRBiI0RPJ3m/G5
	2zPKEfXlHzJ0Mw1qR/M1/ClJgatmxKFE8ZbdrWHC5OIKj6c3aSsFiDsEiU1uzdSJU7tR52aIoOFTY
	owHfx9Eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8w6q-00000004j5v-14m6;
	Tue, 22 Sep 2026 08:44:16 +0000
Received: from mail-pj2-x07.google.com ([2607:f8b0:4864:39::7])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8w6l-00000004izv-2Rwv
	for kexec@lists.infradead.org;
	Tue, 22 Sep 2026 08:44:12 +0000
Received: by mail-pj2-x07.google.com with SMTP id d9443c01a7336-2d9181b7e1bso5398115ad.1
        for <kexec@lists.infradead.org>; Tue, 22 Sep 2026 01:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790066650; x=1790671450; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XrAQfB99bFPUaNh0c5d2OUhMy2tKXocwdCbeEYRe5yE=;
        b=kkambdrwrpDURtAdnZPDERzgutwyEG40m9fAUkwjI81FnM3N+iJGu8t0qRZjki+L/z
         gOowxgGJAqQG4FPIVs6euaoEs/NH2TV8Xnc6Ln61vZWL9KrbqhpUfc0xm46WOjeCKJMw
         IYYas7fVKlfRTU54AVAGUvmk0BeEdhzgJ0WuVXzLwt/gDd90aOUPL3QZosXXgEca5Pec
         sQVYFCWDCzlBwG1GbcddBZBKCxCX/lbN9tcGmVwMp2jXeAsxef0eiCJakPJnmbcQdsec
         Etn2S6yhyLOcyZr2pKbPm/8Ljml1XmFrjj0Tkym1mZHlS1dME6xenO++PeZU3+hmTzpf
         Wjgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790066650; x=1790671450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XrAQfB99bFPUaNh0c5d2OUhMy2tKXocwdCbeEYRe5yE=;
        b=ETA/CopZ5ELOXwyaAC4goAEpFn3t9vKxHcc4txiYtm1AJ1yX2HyxV/37ujR/yRperW
         ayTZAq98llof447yvajM7TJjB5T1/DRLT635uhmQqCmKE7fIEo9EMISr2rPDgSF78+J6
         SMgDTcXaFe5TgR5pSl5+bLbUft7N1OyWxDiUqGVAX/19nuT5wFj4R8x/JFPRs/DwuyE4
         HHVg14rJFVMqThnZgoQCuagJpgqc5oZRiGG0Cp+XvVvfz2FhUPueHF3VRaHHknGSoobK
         IwqiXhtWRfq0ts3v6Wu8MFMv6wdqXyIrmP3WRZV/kPowR8PlAUuYbk3PukPwTe14eWzL
         alhQ==
X-Forwarded-Encrypted: i=1; AKwUvBzG5lA1axuBqc2SspMbniYF6iUyua1fX7mEzLfSx8k7rti7hfD+QIutv7z8u5Ewbc4w+aw2/g==@lists.infradead.org
X-Gm-Message-State: AFuF++ky0FgNQ4McIs5huAn67HX9zSFFrh41fi9jvAS2Au+NIK4eIH+6
	4An8xBskQoADrjdc9nBrrjn0Z70WFMpzSGqkND1EF/1jPRx1Clbb4vIZ
X-Gm-Gg: AYBFou3sP+M8EUXogfe0QVmGN4CFfKWga64XopCphVF5UFOTmYMKIJ8n3o3jUdxoFyC
	PDQQlYD98cWOpPUZQcXld9tgwRMzZbEQyJ3Wp4KVbUDGMaEDMHxM3UunPG1jCN3pKuj39JslgLr
	jxXPfbYblc7aIpLcGc0MKfUWKncnJHNlP+fhf/8DFTsN7E6j2MVngcQBCQj7eCToWUHcDxuBg0h
	Am4FSNFhBZubxIo9bbXqodJxOmRP5MhYE8V12EWVpcEGKbLBgY5gJLCYQgK6I+OBMjJ38bDAXXP
	EYZ0M2y1dH5Gpi/eBcLFW3rPDeZqozpqA9xiPS8ScUUzkmmmRn/6ECSiiv96Y6aOJOh1uULccZg
	lG0wEo/yOrM6SwAVNqNOL9OnNo/NuG3DuIzSRbQZCC9Rx6qsz+kLKu0NWhN0M4wigwKCvziUpXN
	rc7chi+SL9jSrOtCrFtCXA8PlM1wdd+LYyjgvqeF0pfV9asLF6pzT3PenQsrCln2hRpFvPiOsVX
	nkC3uSKVj0=
X-Received: by 2002:a17:90b:1e4a:b0:39e:4c7e:bc6 with SMTP id 98e67ed59e1d1-3a073666c4dmr246498a91.20.1790066650350;
        Tue, 22 Sep 2026 01:44:10 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0674a5ae4sm3670016a91.12.2026.09.22.01.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 01:44:09 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: robh@kernel.org,
	baoquan.he@linux.dev,
	rppt@kernel.org,
	m.szyprowski@samsung.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	saravanak@kernel.org,
	akpm@linux-foundation.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	ruirui.yang@linux.dev,
	robin.murphy@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	iommu@lists.linux.dev
Subject: [PATCH v7 5/9] memblock: introduce MEMBLOCK_NODUMP flag
Date: Tue, 22 Sep 2026 16:42:52 +0800
Message-ID: <20260922084256.1515554-6-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922084256.1515554-1-chenwandun1@gmail.com>
References: <20260922084256.1515554-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_014411_643076_A91D1A22 
X-CRM114-Status: GOOD (  18.32  )
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

From: Wandun Chen <chenwandun@lixiang.com>

Add MEMBLOCK_NODUMP to mark regions that should be excluded from
kdump vmcores.

The flag is meant for reserved memory that carries no data useful for
crash analysis. Reusable reserved regions such as CMA may hold useful
data, so these regions must not be marked MEMBLOCK_NODUMP. Subsequent
patches wire this up for /reserved-memory and /memreserve/ entries.

Regions in /memreserve/ (such as the initrd) may be reserved at the
beginning and freed later, so we also need to clear the flag when
freeing reserved memory.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
---
 include/linux/memblock.h |  9 +++++++++
 mm/memblock.c            | 43 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index aa845f488327..0126b47bc3c4 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -52,6 +52,8 @@ extern unsigned long long max_possible_pfn;
  * kernel that we know is good to use. It is the only memory that
  * allocations may happen from in this phase.
  * @MEMBLOCK_RSRV_HUGETLB: memory is reserved for hugetlb pages
+ * @MEMBLOCK_NODUMP: exclude from kdump vmcore. It carries no data useful
+ * for crash analysis (e.g. firmware carveouts).
  */
 enum memblock_flags {
 	MEMBLOCK_NONE		= 0x0,	/* No special request */
@@ -63,6 +65,7 @@ enum memblock_flags {
 	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */
 	MEMBLOCK_KHO_SCRATCH	= 0x40,	/* scratch memory for kexec handover */
 	MEMBLOCK_RSRV_HUGETLB	= 0x80, /* memory reserved for hugetlb pages */
+	MEMBLOCK_NODUMP		= 0x100,/* exclude from kdump vmcore */
 };
 
 /**
@@ -160,6 +163,7 @@ int memblock_reserved_mark_noinit(phys_addr_t base, phys_addr_t size);
 int memblock_reserved_mark_kern(phys_addr_t base, phys_addr_t size);
 int memblock_mark_kho_scratch(phys_addr_t base, phys_addr_t size);
 int memblock_clear_kho_scratch(phys_addr_t base, phys_addr_t size);
+int memblock_mark_nodump(phys_addr_t base, phys_addr_t size);
 
 void memblock_free(void *ptr, size_t size);
 
@@ -305,6 +309,11 @@ static inline bool memblock_is_kho_scratch(struct memblock_region *m)
 	return m->flags & MEMBLOCK_KHO_SCRATCH;
 }
 
+static inline bool memblock_is_nodump(struct memblock_region *m)
+{
+	return m->flags & MEMBLOCK_NODUMP;
+}
+
 int memblock_search_pfn_nid(unsigned long pfn, unsigned long *start_pfn,
 			    unsigned long  *end_pfn);
 void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
diff --git a/mm/memblock.c b/mm/memblock.c
index ea0de4b5f356..48cabfe5cdf1 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -929,6 +929,8 @@ static unsigned long __free_reserved_area(phys_addr_t start, phys_addr_t end,
 	return pages;
 }
 
+static int memblock_clear_nodump(phys_addr_t base, phys_addr_t size);
+
 unsigned long free_reserved_area(void *start, void *end, int poison, const char *s)
 {
 	phys_addr_t start_pa, end_pa;
@@ -949,9 +951,13 @@ unsigned long free_reserved_area(void *start, void *end, int poison, const char
 	}
 
 	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
-		if (start_pa < end_pa)
+		if (start_pa < end_pa) {
 			memblock_remove_range(&memblock.reserved,
 					      start_pa, end_pa - start_pa);
+
+			if (IS_ENABLED(CONFIG_CRASH_DUMP))
+				memblock_clear_nodump(start_pa, end_pa - start_pa);
+		}
 	}
 
 	pages = __free_reserved_area(start_pa, end_pa, poison);
@@ -995,8 +1001,11 @@ int __init_memblock memblock_phys_free(phys_addr_t base, phys_addr_t size)
 
 	kmemleak_free_part_phys(base, size);
 
-	if (!slab_is_available() || IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
+	if (!slab_is_available() || IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
 		ret = memblock_remove_range(&memblock.reserved, base, size);
+		if (IS_ENABLED(CONFIG_CRASH_DUMP))
+			memblock_clear_nodump(base, size);
+	}
 
 	if (slab_is_available())
 		__free_reserved_area(base, base + size, -1);
@@ -1204,6 +1213,35 @@ __init int memblock_clear_kho_scratch(phys_addr_t base, phys_addr_t size)
 				    MEMBLOCK_KHO_SCRATCH);
 }
 
+/**
+ * memblock_mark_nodump - Mark a memory region with flag MEMBLOCK_NODUMP.
+ * @base: the base phys addr of the region
+ * @size: the size of the region
+ *
+ * Mark the region as not to be included in crash dumps.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int __init_memblock memblock_mark_nodump(phys_addr_t base, phys_addr_t size)
+{
+	return memblock_setclr_flag(&memblock.memory, base, size, 1,
+				    MEMBLOCK_NODUMP);
+}
+
+/**
+ * memblock_clear_nodump - Clear a memory region with flag MEMBLOCK_NODUMP.
+ * @base: the base phys addr of the region
+ * @size: the size of the region
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+static int __init_memblock memblock_clear_nodump(phys_addr_t base,
+						 phys_addr_t size)
+{
+	return memblock_setclr_flag(&memblock.memory, base, size, 0,
+				    MEMBLOCK_NODUMP);
+}
+
 static bool should_skip_region(struct memblock_type *type,
 			       struct memblock_region *m,
 			       int nid, int flags)
@@ -2880,6 +2918,7 @@ static const char * const flagname[] = {
 	[ilog2(MEMBLOCK_RSRV_KERN)] = "RSV_KERN",
 	[ilog2(MEMBLOCK_KHO_SCRATCH)] = "KHO_SCRATCH",
 	[ilog2(MEMBLOCK_RSRV_HUGETLB)] = "RSV_HUGETLB",
+	[ilog2(MEMBLOCK_NODUMP)] = "NODUMP",
 };
 
 static int memblock_debug_show(struct seq_file *m, void *private)
-- 
2.43.0


