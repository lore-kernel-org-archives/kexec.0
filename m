Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2133CCA463
	for <kexec@archiver.kernel.org>; Fri, 16 Oct 2026 03:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s7Fb6KtcWAXnUfcecLaSQ1H6J8YKvEJFUWN8A6hcpOc=; b=VO0PQM9eYv3m8m5SRJDjAr8GIk
	xnkCoLLiPtaFCdTSxoqalxEEJ0pnvwHMF35XFQuEarD1Q1Z+wblWHGvTRzgsAodx6ph9HEa+J+qD0
	r9k0X8h1HL1b8AqPbg3I7stRmjKOoPqhzWadA2yrDeakbfLEE04lUU1xgXcvDXHjLzwqX+rhu/6LS
	+XZdcDfLIMBKjSF+y5hcvjQNHrod8VEsrhds5EY+hU1qe00UGIHdaosQMUxUQqiuCasOuW7qz4hKP
	HnnzGu0EwqjyvE1tUsvgLwIrCtswruzDvGSzznjd8qeEzVdANclx2YB3y6b/nE+xnPtOMThNcZ95V
	Gv3mrgwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHYKm-00000001np3-2AAS;
	Fri, 16 Oct 2026 03:10:16 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHYKk-00000001nnD-36Ar
	for kexec@bombadil.infradead.org;
	Fri, 16 Oct 2026 03:10:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=s7Fb6KtcWAXnUfcecLaSQ1H6J8YKvEJFUWN8A6hcpOc=; b=lnaPs8jf40GiM7nJk5XX99Cl5A
	j5x53p447ADjzbphULSRyDLpc7HM6ZPLvPqy6YEFADAMhY1N0CDEhCPqCaA/96/1iE4hTLORMlHkf
	ZlusZlRfKD6Ic2OvnvI+UiL+SnJax/7nG2/SvCGdOwbQQgthT3Wkucgvj3t5zeTXjsJum0Cmj3xkf
	dnFaiFBRMxnZr7de2OT/MfdVn7RUQfd327dNrHzdJ1or8DqN2k1p9ZrmwQ+A2nroF/Xm7tgiwnL16
	hU/aPFw9i8easXN95EZT6jeLPSZ1ij0nLob9/AQDrJmQZjJZeOe2IxgLA5JNxypGZWLofUhDt9TsP
	DYlM9N0A==;
Received: from mail-pj2-x0b.google.com ([2607:f8b0:4864:39::b])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xHYKc-000000011yz-1CN4
	for kexec@lists.infradead.org;
	Fri, 16 Oct 2026 03:10:13 +0000
Received: by mail-pj2-x0b.google.com with SMTP id 98e67ed59e1d1-398a0a87595so1267848a91.1
        for <kexec@lists.infradead.org>; Thu, 15 Oct 2026 20:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792120203; x=1792725003; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s7Fb6KtcWAXnUfcecLaSQ1H6J8YKvEJFUWN8A6hcpOc=;
        b=DByHZ0sQlqs+nOXWfNusvAxmOLHRSou5oJ/YKW/xS4lcZEwvtgK4r23EoNAKZbId9s
         EUiJS/ZAa3IGxY7kOxHV9/AJdW4DxTjW0w1ehbS7XHbWksG5cqsl9Bmu8A90t8qxMDnl
         ZVlOY1hpx8UUUoK/l9+ywqc3hr9PDZJ4ZrzuozoEQutw+gUM7Q4JVbrQu4OMFn5VPCUw
         9tLNMuF5sI+5m9GvMPlhCVGhSf+alAN78xf0tpRgpsHRyIQtonClVZxMvPw4JICGXPgw
         ygLhs4rLVgG7lIEC9+H2f2aAzjXX9vFs7QJgw7rFsofoJyF8bVaVA2xR1uRXoQrQXmUy
         vVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792120203; x=1792725003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s7Fb6KtcWAXnUfcecLaSQ1H6J8YKvEJFUWN8A6hcpOc=;
        b=ZBho/MC+Pmr5lT7uOl8jjw0DOeA71lC5cMRTT7GmE8YcGCItlKPueQTLVJ51Tjwm3n
         HW3SWJ6OMFCoid1SGqoq7KMehXNIsuKuRe9+72ofgG8jdDMtdQLRrtwhY1vWNl7J5bZC
         GjPXz4L0ZOc92hltZeCx/TmV1JCmX9wawjhPkKte5lehFvT7wWXogAzfREM9ULr3o1TW
         GEjVgkmGSiAkMqE+9lZ+qBiWGgZyYcA/cbho6Tp5DWg5v3dkjM9j2NbJDkpSAs7hJUvU
         Yc1QCOPerpKebDs64Ndp+siLUKn8FcktLeAPjL88KZdYx69OWpFwHhCVIckqX+RY2bMC
         q8fQ==
X-Forwarded-Encrypted: i=1; AKwUvBwYwcWRkKb9nsOa/sqpVJsKBY6T+aAxqIwLXcYmcYD8RJpq5TtuM/EgygNg1FKpgTgga2ykaQ==@lists.infradead.org
X-Gm-Message-State: AFq9FYKR9ZBJTr4tI8wlxz+Ffn+FKXWBr9v9gwaRtjoXjXaLWDFxS003
	pR8BL9WvG+dl6gBQhMDnwALyyDEUVO4SBxHwCl8olayAsNP0NbtGQhxZ8HWDaaSISlSr5+So
X-Gm-Gg: AYBFou2+Y3znIjEedj/t8xwIbrynxPJAmJeFq8Y716DKuFKemq57IgLfN4fnPf58LYj
	fkMnasqwVsJcipU5otXvUbDLmQOX1X8XyckwWq8etW9+AjKzH8L3DChKMeTe3e76MfdgyDSjEJU
	a5DRFQvTRrDES84qybB/1Ds/ILkxfONnlujHrT7+5Qc9XlTDXR4nR9/mzyAVR0i0QbGOS375J83
	wHNykfWeER+UY7IipYabyQEmt2UkcxoOComtUwFKWAoajncgjAOZ4MhhxcOlTlmKMqsC5GC7kEi
	nXR2+hGmt3H1p23SW8iWkXhv/9moW/sgLgVyIvr4VXbBqksn6dpyX83v80o4DFvfbNiy5aX24cc
	f/L246LnzgX1qJ8sitTcAUI0y4YSYEY9QmdT6TyCy++w+5DoR6uujsseCdikT83M8+fZNIFc5Yu
	YISreZ5cuXLokRAHM6UM90gEM78Z+7ThF0NTwATrJQAfNEK0PbhcV6o4vA2b2UuMREVhorpJSmJ
	xfltq39hXw=
X-Received: by 2002:a17:90b:35c2:b0:3ac:7c52:fae5 with SMTP id 98e67ed59e1d1-3ac7c52fe5amr6152592a91.50.1792120203082;
        Thu, 15 Oct 2026 20:10:03 -0700 (PDT)
Received: from intel.company.local ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd3cc73c7sm370085a91.4.2026.10.15.20.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 20:10:02 -0700 (PDT)
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
Subject: [PATCH v8 4/8] crash_core: replace for_each_mem_range() with for_each_mem_region()
Date: Fri, 16 Oct 2026 11:08:51 +0800
Message-ID: <20261016030855.4062882-5-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016030855.4062882-1-chenwandun1@gmail.com>
References: <20261016030855.4062882-1-chenwandun1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261016_041010_304842_97CB17FC 
X-CRM114-Status: GOOD (  12.52  )
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

for_each_mem_range() skips MEMBLOCK_NOMAP regions implicitly. Switch the
weak defaults to for_each_mem_region(), which exposes struct
memblock_region and per-region flags, and filter NOMAP regions explicitly
via the new crash_should_skip_region() helper. This prepares for a
subsequent patch to extend the skip filter.

No functional change.

Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Tested-by: Meijing Zhao <zhaomeijing@lixiang.com>
Acked-by: Baoquan He <baoquan.he@linux.dev>
---
 kernel/crash_core.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 8a861a946e26..e161c8b65e00 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -283,25 +283,34 @@ static struct crash_mem *alloc_cmem(unsigned int nr_ranges)
 }
 
 #ifdef CONFIG_ARCH_KEEP_MEMBLOCK
+/* Exclude NOMAP regions from the vmcore. */
+static bool crash_should_skip_region(struct memblock_region *reg)
+{
+	return memblock_is_nomap(reg);
+}
+
 unsigned int __weak arch_get_system_nr_ranges(void)
 {
 	unsigned int nr_ranges = 2 + crashk_cma_cnt; /* crashk_res + crashk_low_res, +CMA splits */
-	phys_addr_t start, end;
-	u64 i;
+	struct memblock_region *reg;
 
-	for_each_mem_range(i, &start, &end)
+	for_each_mem_region(reg) {
+		if (crash_should_skip_region(reg))
+			continue;
 		nr_ranges++;
+	}
 	return nr_ranges;
 }
 
 int __weak arch_crash_populate_cmem(struct crash_mem *cmem)
 {
-	phys_addr_t start, end;
-	u64 i;
+	struct memblock_region *reg;
 
-	for_each_mem_range(i, &start, &end) {
-		cmem->ranges[cmem->nr_ranges].start = start;
-		cmem->ranges[cmem->nr_ranges].end = end - 1;
+	for_each_mem_region(reg) {
+		if (crash_should_skip_region(reg))
+			continue;
+		cmem->ranges[cmem->nr_ranges].start = reg->base;
+		cmem->ranges[cmem->nr_ranges].end = reg->base + reg->size - 1;
 		cmem->nr_ranges++;
 	}
 	return 0;
-- 
2.43.0


