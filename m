Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C67C28B30
	for <kexec@archiver.kernel.org>; Thu, 20 Mar 2025 15:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yN4bzpkkVfQ/uH0w0E99LDF9bPjq6B3vGfE1Jc/6gP4=; b=gYKEq3wdPuRfGwT9ho5e4lzCcI
	EZV9m5Cbld4QBJ0jRlZL6fC+h0GPf8OMfYQY4CY9T49L0n0H2qdTI8yN29UCTFMEoAxt+hfxnYAjw
	o05mFd2om0WpwRMyvDKlwSpGfCii7fk3rDI/pBm0GmNdEgLjYiQiHXryQbfM2nylHudwI/vNLlmYh
	/lXv794R/rSdSjQFsZaP1v18IQxLNckL2sqwk+wBH1GMLhZlnaPsJamGXrcnWJp6KxlPYKUEI4rfG
	bFdRMh0k3rLHblYzCSF2mWsdpbcxSGZ1Q83WpS2IAPJD1YWFjejIsuC35cQyi/74MNgkXtskvk3cl
	HpkYYlpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvHRu-0000000CTvd-22H0;
	Thu, 20 Mar 2025 15:04:46 +0000
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tv58g-0000000AkLQ-1dbJ
	for kexec@lists.infradead.org;
	Thu, 20 Mar 2025 01:56:07 +0000
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-2ff78dd28ecso643804a91.1
        for <kexec@lists.infradead.org>; Wed, 19 Mar 2025 18:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742435765; x=1743040565; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yN4bzpkkVfQ/uH0w0E99LDF9bPjq6B3vGfE1Jc/6gP4=;
        b=RV5qdShqWGMxntTCd3lGsLscNTkMKGs+DC/h18lCvwp92Zn9oIZmEhOvj4xTDGfyND
         mp8bIXdTnA87OQK11zxrwvpFt2c76eIWkj/+tMzP7eFOOVeaYMXRea3uiTIRiJtY4+om
         g/FSeTBKi9KI+/615e0hzkIwOsEHumT6qal8WDCfORNWq+3wuXR7N5cxaUzar5o0U9jn
         lw2jFXG1k7PM9b/af7FKaX0cwB1FDdpfjPf5U+2IDs3+w50WuzoaB35fyPXGsXOeLOty
         Fv0IfDD1Du/pBI5jvCIN0dn9rBsUfUsSxRQ1VLBYGgOiY4atotRjTZaCjskzS06a3D2T
         gYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742435765; x=1743040565;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yN4bzpkkVfQ/uH0w0E99LDF9bPjq6B3vGfE1Jc/6gP4=;
        b=kgm/IpHMefyJaiCabDg+F/VphowRSc483XZkjzZxAPw1273MoEWVv5+MbVzqBvXDv4
         1w5S1NwtLKBGHxqLhgjDldR6lV3QBCSFW0OWrmRxd9EX3J2m2ylHXILVjmiBqfy/a9D8
         NISjZ2Ig436BKPDf0xfnpjM35G1ShGkgfF+NDLF5dt0ttS9cYxqNkV23wTVagG8Z/PIl
         9E8MlqGLxGgiQzbdHv/r5Oi47hvbu1aKRSB1cGTf9ZZ4sRHsq+ip+qaoeqAw6cvnLPUS
         vEAlnAtxFJaqKTyO4u5vAFtA+Ita2VUQaKQXyWYsONepA/nBl+PEO0j6kN+wDQANkKnQ
         /qJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjZ2q88qxBuzrMDY6S5sZMeDERnBo0HsoOo2gTjHriwz06DntbJLEqK24mqJshVhHkwNP80w==@lists.infradead.org
X-Gm-Message-State: AOJu0YyZb16Lg83cpvXABCISA2C6L1PO1SGGtIi4qLA9ZK+S3JkQjihC
	OfegzsYR9Wo6T9H+eE4WpBqkFGtfGpF0IdFg0mKDNJf6HAbqXi7MRZDwvmOI4HUwJaDCeoEOWuu
	hIqAZUPt6Cgqp4i2DGA==
X-Google-Smtp-Source: AGHT+IEsdt/zCxXN1IHqiLuLR1iz8KpffEW0rcwgNYsBwKcCWy7uT/QglIx/zEe+p2m6KToDSLlcFSwk6G8J4CvU
X-Received: from pgkk67.prod.google.com ([2002:a63:2446:0:b0:af5:6108:71e4])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:9188:b0:1f5:60ce:6cc6 with SMTP id adf61e73a8af0-1fbebd7cea6mr8202773637.21.1742435765048;
 Wed, 19 Mar 2025 18:56:05 -0700 (PDT)
Date: Wed, 19 Mar 2025 18:55:38 -0700
In-Reply-To: <20250320015551.2157511-1-changyuanl@google.com>
Mime-Version: 1.0
References: <20250320015551.2157511-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250320015551.2157511-4-changyuanl@google.com>
Subject: [PATCH v5 03/16] memblock: add MEMBLOCK_RSRV_KERN flag
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
	linux-mm@kvack.org, x86@kernel.org, Changyuan Lyu <changyuanl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250319_185606_444550_19CC9C67 
X-CRM114-Status: GOOD (  17.02  )
X-Mailman-Approved-At: Thu, 20 Mar 2025 08:04:44 -0700
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

to denote areas that were reserved for kernel use either directly with
memblock_reserve_kern() or via memblock allocations.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Co-developed-by: Changyuan Lyu <changyuanl@google.com>
Signed-off-by: Changyuan Lyu <changyuanl@google.com>
---
 include/linux/memblock.h                      | 19 ++++++++-
 mm/memblock.c                                 | 40 +++++++++++++++----
 tools/testing/memblock/tests/alloc_api.c      | 22 +++++-----
 .../memblock/tests/alloc_helpers_api.c        |  4 +-
 tools/testing/memblock/tests/alloc_nid_api.c  | 20 +++++-----
 5 files changed, 73 insertions(+), 32 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index e79eb6ac516f..1037fd7aabf4 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -42,6 +42,9 @@ extern unsigned long long max_possible_pfn;
  * kernel resource tree.
  * @MEMBLOCK_RSRV_NOINIT: memory region for which struct pages are
  * not initialized (only for reserved regions).
+ * @MEMBLOCK_RSRV_KERN: memory region that is reserved for kernel use,
+ * either explictitly with memblock_reserve_kern() or via memblock
+ * allocation APIs. All memblock allocations set this flag.
  */
 enum memblock_flags {
 	MEMBLOCK_NONE		= 0x0,	/* No special request */
@@ -50,6 +53,7 @@ enum memblock_flags {
 	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
 	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
 	MEMBLOCK_RSRV_NOINIT	= 0x10,	/* don't initialize struct pages */
+	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */
 };
 
 /**
@@ -116,7 +120,19 @@ int memblock_add_node(phys_addr_t base, phys_addr_t size, int nid,
 int memblock_add(phys_addr_t base, phys_addr_t size);
 int memblock_remove(phys_addr_t base, phys_addr_t size);
 int memblock_phys_free(phys_addr_t base, phys_addr_t size);
-int memblock_reserve(phys_addr_t base, phys_addr_t size);
+int __memblock_reserve(phys_addr_t base, phys_addr_t size, int nid,
+		       enum memblock_flags flags);
+
+static __always_inline int memblock_reserve(phys_addr_t base, phys_addr_t size)
+{
+	return __memblock_reserve(base, size, NUMA_NO_NODE, 0);
+}
+
+static __always_inline int memblock_reserve_kern(phys_addr_t base, phys_addr_t size)
+{
+	return __memblock_reserve(base, size, NUMA_NO_NODE, MEMBLOCK_RSRV_KERN);
+}
+
 #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
 int memblock_physmem_add(phys_addr_t base, phys_addr_t size);
 #endif
@@ -477,6 +493,7 @@ static inline __init_memblock bool memblock_bottom_up(void)
 
 phys_addr_t memblock_phys_mem_size(void);
 phys_addr_t memblock_reserved_size(void);
+phys_addr_t memblock_reserved_kern_size(phys_addr_t limit, int nid);
 unsigned long memblock_estimated_nr_free_pages(void);
 phys_addr_t memblock_start_of_DRAM(void);
 phys_addr_t memblock_end_of_DRAM(void);
diff --git a/mm/memblock.c b/mm/memblock.c
index 95af35fd1389..e704e3270b32 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -491,7 +491,7 @@ static int __init_memblock memblock_double_array(struct memblock_type *type,
 	 * needn't do it
 	 */
 	if (!use_slab)
-		BUG_ON(memblock_reserve(addr, new_alloc_size));
+		BUG_ON(memblock_reserve_kern(addr, new_alloc_size));
 
 	/* Update slab flag */
 	*in_slab = use_slab;
@@ -641,7 +641,7 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 #ifdef CONFIG_NUMA
 			WARN_ON(nid != memblock_get_region_node(rgn));
 #endif
-			WARN_ON(flags != rgn->flags);
+			WARN_ON(flags != MEMBLOCK_NONE && flags != rgn->flags);
 			nr_new++;
 			if (insert) {
 				if (start_rgn == -1)
@@ -901,14 +901,15 @@ int __init_memblock memblock_phys_free(phys_addr_t base, phys_addr_t size)
 	return memblock_remove_range(&memblock.reserved, base, size);
 }
 
-int __init_memblock memblock_reserve(phys_addr_t base, phys_addr_t size)
+int __init_memblock __memblock_reserve(phys_addr_t base, phys_addr_t size,
+				       int nid, enum memblock_flags flags)
 {
 	phys_addr_t end = base + size - 1;
 
-	memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
-		     &base, &end, (void *)_RET_IP_);
+	memblock_dbg("%s: [%pa-%pa] nid=%d flags=%x %pS\n", __func__,
+		     &base, &end, nid, flags, (void *)_RET_IP_);
 
-	return memblock_add_range(&memblock.reserved, base, size, MAX_NUMNODES, 0);
+	return memblock_add_range(&memblock.reserved, base, size, nid, flags);
 }
 
 #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
@@ -1459,14 +1460,14 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
 again:
 	found = memblock_find_in_range_node(size, align, start, end, nid,
 					    flags);
-	if (found && !memblock_reserve(found, size))
+	if (found && !__memblock_reserve(found, size, nid, MEMBLOCK_RSRV_KERN))
 		goto done;
 
 	if (numa_valid_node(nid) && !exact_nid) {
 		found = memblock_find_in_range_node(size, align, start,
 						    end, NUMA_NO_NODE,
 						    flags);
-		if (found && !memblock_reserve(found, size))
+		if (found && !memblock_reserve_kern(found, size))
 			goto done;
 	}
 
@@ -1751,6 +1752,28 @@ phys_addr_t __init_memblock memblock_reserved_size(void)
 	return memblock.reserved.total_size;
 }
 
+phys_addr_t __init_memblock memblock_reserved_kern_size(phys_addr_t limit, int nid)
+{
+	struct memblock_region *r;
+	phys_addr_t total = 0;
+
+	for_each_reserved_mem_region(r) {
+		phys_addr_t size = r->size;
+
+		if (r->base > limit)
+			break;
+
+		if (r->base + r->size > limit)
+			size = limit - r->base;
+
+		if (nid == memblock_get_region_node(r) || !numa_valid_node(nid))
+			if (r->flags & MEMBLOCK_RSRV_KERN)
+				total += size;
+	}
+
+	return total;
+}
+
 /**
  * memblock_estimated_nr_free_pages - return estimated number of free pages
  * from memblock point of view
@@ -2397,6 +2420,7 @@ static const char * const flagname[] = {
 	[ilog2(MEMBLOCK_NOMAP)] = "NOMAP",
 	[ilog2(MEMBLOCK_DRIVER_MANAGED)] = "DRV_MNG",
 	[ilog2(MEMBLOCK_RSRV_NOINIT)] = "RSV_NIT",
+	[ilog2(MEMBLOCK_RSRV_KERN)] = "RSV_KERN",
 };
 
 static int memblock_debug_show(struct seq_file *m, void *private)
diff --git a/tools/testing/memblock/tests/alloc_api.c b/tools/testing/memblock/tests/alloc_api.c
index 68f1a75cd72c..c55f67dd367d 100644
--- a/tools/testing/memblock/tests/alloc_api.c
+++ b/tools/testing/memblock/tests/alloc_api.c
@@ -134,7 +134,7 @@ static int alloc_top_down_before_check(void)
 	PREFIX_PUSH();
 	setup_memblock();
 
-	memblock_reserve(memblock_end_of_DRAM() - total_size, r1_size);
+	memblock_reserve_kern(memblock_end_of_DRAM() - total_size, r1_size);
 
 	allocated_ptr = run_memblock_alloc(r2_size, SMP_CACHE_BYTES);
 
@@ -182,7 +182,7 @@ static int alloc_top_down_after_check(void)
 
 	total_size = r1.size + r2_size;
 
-	memblock_reserve(r1.base, r1.size);
+	memblock_reserve_kern(r1.base, r1.size);
 
 	allocated_ptr = run_memblock_alloc(r2_size, SMP_CACHE_BYTES);
 
@@ -231,8 +231,8 @@ static int alloc_top_down_second_fit_check(void)
 
 	total_size = r1.size + r2.size + r3_size;
 
-	memblock_reserve(r1.base, r1.size);
-	memblock_reserve(r2.base, r2.size);
+	memblock_reserve_kern(r1.base, r1.size);
+	memblock_reserve_kern(r2.base, r2.size);
 
 	allocated_ptr = run_memblock_alloc(r3_size, SMP_CACHE_BYTES);
 
@@ -285,8 +285,8 @@ static int alloc_in_between_generic_check(void)
 
 	total_size = r1.size + r2.size + r3_size;
 
-	memblock_reserve(r1.base, r1.size);
-	memblock_reserve(r2.base, r2.size);
+	memblock_reserve_kern(r1.base, r1.size);
+	memblock_reserve_kern(r2.base, r2.size);
 
 	allocated_ptr = run_memblock_alloc(r3_size, SMP_CACHE_BYTES);
 
@@ -422,7 +422,7 @@ static int alloc_limited_space_generic_check(void)
 	setup_memblock();
 
 	/* Simulate almost-full memory */
-	memblock_reserve(memblock_start_of_DRAM(), reserved_size);
+	memblock_reserve_kern(memblock_start_of_DRAM(), reserved_size);
 
 	allocated_ptr = run_memblock_alloc(available_size, SMP_CACHE_BYTES);
 
@@ -608,7 +608,7 @@ static int alloc_bottom_up_before_check(void)
 	PREFIX_PUSH();
 	setup_memblock();
 
-	memblock_reserve(memblock_start_of_DRAM() + r1_size, r2_size);
+	memblock_reserve_kern(memblock_start_of_DRAM() + r1_size, r2_size);
 
 	allocated_ptr = run_memblock_alloc(r1_size, SMP_CACHE_BYTES);
 
@@ -655,7 +655,7 @@ static int alloc_bottom_up_after_check(void)
 
 	total_size = r1.size + r2_size;
 
-	memblock_reserve(r1.base, r1.size);
+	memblock_reserve_kern(r1.base, r1.size);
 
 	allocated_ptr = run_memblock_alloc(r2_size, SMP_CACHE_BYTES);
 
@@ -705,8 +705,8 @@ static int alloc_bottom_up_second_fit_check(void)
 
 	total_size = r1.size + r2.size + r3_size;
 
-	memblock_reserve(r1.base, r1.size);
-	memblock_reserve(r2.base, r2.size);
+	memblock_reserve_kern(r1.base, r1.size);
+	memblock_reserve_kern(r2.base, r2.size);
 
 	allocated_ptr = run_memblock_alloc(r3_size, SMP_CACHE_BYTES);
 
diff --git a/tools/testing/memblock/tests/alloc_helpers_api.c b/tools/testing/memblock/tests/alloc_helpers_api.c
index 3ef9486da8a0..e5362cfd2ff3 100644
--- a/tools/testing/memblock/tests/alloc_helpers_api.c
+++ b/tools/testing/memblock/tests/alloc_helpers_api.c
@@ -163,7 +163,7 @@ static int alloc_from_top_down_no_space_above_check(void)
 	min_addr = memblock_end_of_DRAM() - SMP_CACHE_BYTES * 2;
 
 	/* No space above this address */
-	memblock_reserve(min_addr, r2_size);
+	memblock_reserve_kern(min_addr, r2_size);
 
 	allocated_ptr = memblock_alloc_from(r1_size, SMP_CACHE_BYTES, min_addr);
 
@@ -199,7 +199,7 @@ static int alloc_from_top_down_min_addr_cap_check(void)
 	start_addr = (phys_addr_t)memblock_start_of_DRAM();
 	min_addr = start_addr - SMP_CACHE_BYTES * 3;
 
-	memblock_reserve(start_addr + r1_size, MEM_SIZE - r1_size);
+	memblock_reserve_kern(start_addr + r1_size, MEM_SIZE - r1_size);
 
 	allocated_ptr = memblock_alloc_from(r1_size, SMP_CACHE_BYTES, min_addr);
 
diff --git a/tools/testing/memblock/tests/alloc_nid_api.c b/tools/testing/memblock/tests/alloc_nid_api.c
index 49bb416d34ff..562e4701b0e0 100644
--- a/tools/testing/memblock/tests/alloc_nid_api.c
+++ b/tools/testing/memblock/tests/alloc_nid_api.c
@@ -324,7 +324,7 @@ static int alloc_nid_min_reserved_generic_check(void)
 	min_addr = max_addr - r2_size;
 	reserved_base = min_addr - r1_size;
 
-	memblock_reserve(reserved_base, r1_size);
+	memblock_reserve_kern(reserved_base, r1_size);
 
 	allocated_ptr = run_memblock_alloc_nid(r2_size, SMP_CACHE_BYTES,
 					       min_addr, max_addr,
@@ -374,7 +374,7 @@ static int alloc_nid_max_reserved_generic_check(void)
 	max_addr = memblock_end_of_DRAM() - r1_size;
 	min_addr = max_addr - r2_size;
 
-	memblock_reserve(max_addr, r1_size);
+	memblock_reserve_kern(max_addr, r1_size);
 
 	allocated_ptr = run_memblock_alloc_nid(r2_size, SMP_CACHE_BYTES,
 					       min_addr, max_addr,
@@ -436,8 +436,8 @@ static int alloc_nid_top_down_reserved_with_space_check(void)
 	min_addr = r2.base + r2.size;
 	max_addr = r1.base;
 
-	memblock_reserve(r1.base, r1.size);
-	memblock_reserve(r2.base, r2.size);
+	memblock_reserve_kern(r1.base, r1.size);
+	memblock_reserve_kern(r2.base, r2.size);
 
 	allocated_ptr = run_memblock_alloc_nid(r3_size, SMP_CACHE_BYTES,
 					       min_addr, max_addr,
@@ -499,8 +499,8 @@ static int alloc_nid_reserved_full_merge_generic_check(void)
 	min_addr = r2.base + r2.size;
 	max_addr = r1.base;
 
-	memblock_reserve(r1.base, r1.size);
-	memblock_reserve(r2.base, r2.size);
+	memblock_reserve_kern(r1.base, r1.size);
+	memblock_reserve_kern(r2.base, r2.size);
 
 	allocated_ptr = run_memblock_alloc_nid(r3_size, SMP_CACHE_BYTES,
 					       min_addr, max_addr,
@@ -563,8 +563,8 @@ static int alloc_nid_top_down_reserved_no_space_check(void)
 	min_addr = r2.base + r2.size;
 	max_addr = r1.base;
 
-	memblock_reserve(r1.base, r1.size);
-	memblock_reserve(r2.base, r2.size);
+	memblock_reserve_kern(r1.base, r1.size);
+	memblock_reserve_kern(r2.base, r2.size);
 
 	allocated_ptr = run_memblock_alloc_nid(r3_size, SMP_CACHE_BYTES,
 					       min_addr, max_addr,
@@ -909,8 +909,8 @@ static int alloc_nid_bottom_up_reserved_with_space_check(void)
 	min_addr = r2.base + r2.size;
 	max_addr = r1.base;
 
-	memblock_reserve(r1.base, r1.size);
-	memblock_reserve(r2.base, r2.size);
+	memblock_reserve_kern(r1.base, r1.size);
+	memblock_reserve_kern(r2.base, r2.size);
 
 	allocated_ptr = run_memblock_alloc_nid(r3_size, SMP_CACHE_BYTES,
 					       min_addr, max_addr,
-- 
2.48.1.711.g2feabab25a-goog


