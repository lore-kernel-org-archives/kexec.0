Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04866C3ABC3
	for <kexec@archiver.kernel.org>; Fri,  9 May 2025 07:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UQleSYKHX+gNmlKmlKO75ZDJI9Hk7h4ANgbFHNrq/5A=; b=btH8muSv3T06wv1DzdVkP4pF+v
	hY+nREWz3xUJ9r3J1Q0SCwdwkxZBk/Rg/LohazwTuvOeLId+tbAbJE7PEAu05ntd9XCHQroZ29lub
	VYOz7bOfDvaiwO6TblGj3UX9Q/TKfA1eyQaVQIIA11ot15cVoXdb4ZBqDEueVk4WSDHElMG3wVecb
	ZXiX0iV9aZDuFgejEHbCuMpb82hEQarkNF0YKmPLMrILexBvm0Egt3yTwDvmHcdnauVVf1kA3IaAl
	acAKWKmhVMTZCz84UGo/Sy5M8s9DdnuOjZ8PoGNlF30a6tZ4e74WGsGDOYJVIX2wLeaALQQUZ7VOZ
	xOvzDizg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDIU6-00000002oY5-2qXy;
	Fri, 09 May 2025 07:49:30 +0000
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDIRb-00000002nPQ-2IDv
	for kexec@lists.infradead.org;
	Fri, 09 May 2025 07:46:56 +0000
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-22e4c94ed70so17254705ad.0
        for <kexec@lists.infradead.org>; Fri, 09 May 2025 00:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746776814; x=1747381614; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UQleSYKHX+gNmlKmlKO75ZDJI9Hk7h4ANgbFHNrq/5A=;
        b=15lBfV0woWvTGsM21nzRZepddEzP1cmmksLyLDj17OXHuiE1coSJBWb4c2WPpSpFBm
         nqpFXx48rtuyp7jgUfdsqpnQX1rfVU6QvANvaOvhkKgOdTgB5UoNant8BAxZdOGSsIth
         NAX+LarX0ehJ3pWwFxm8aTAufJNFun6wBcwR7x3J4SRE+mHUPJf69TCqqrQAN+RCLYUd
         Q0ZIQEYYKaZBTtoqLfF1T6TS++kC3XFGClRHp4gUzTp3Hjmliu0AoEUeKinq05Z3fpxY
         wO/bS84KvGmaVcGz/RhzD9WO+0pJ73p+3ygKSBzRF0A3I0pgeGgUAfwwwYRPOTRtNolA
         HqFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746776814; x=1747381614;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UQleSYKHX+gNmlKmlKO75ZDJI9Hk7h4ANgbFHNrq/5A=;
        b=Qqq27Q/uOp1KzzJxEBqu0QHK1FjRjF5v4zjCkVUJUAKqmYk+w72bic37YLbIPw6G66
         MUpF5EAL+zPglK6tl89mr8YsetC8TXwKhUkGIDc1RBxSIJpwmUDS48WBUSG0nhSY0QTt
         +tuic+lxlyvT9h1bRG+qJnHseSOM1zNBDbzQ29rkKl4Aoh098snhrBbNui1TQJljzO93
         0IW3xg7CJNdWNABRRAuJL/NCET7dCHAg7JS9BJEEASVKaRnGb5IDmhYhG15oBi4oYS5n
         VQRlJKlNc8zj9nG9mR0jUcSuHvHuxsL877QYV7IlydHtg0wexcItm1zKjtwhE93FtNmE
         beuA==
X-Forwarded-Encrypted: i=1; AJvYcCXV841AuNSRO71svxIanvpJ7R0fpWC/cj7Rkcx35qASgx71EqObsafzi1q9wHSjp3q5kzfVSA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxIU/l6OOFW9JKIUhUodG6y3JzC8ik5X4Q0WWVC6KK12lvMcdg8
	I/Jlt+n21fvfM9o6DgHO9/KgGqOAhooLMK6QnPNABrnoqCFgnyD/gk0gQmjpSYelbpNIWi1Hb94
	LNHKbJbHjTo+ng/yEjg==
X-Google-Smtp-Source: AGHT+IE0ecbHFG5zaMIC4HVa8/XK/kIO72d826eBh5y/vMRu72CI084/gqbKkAhATPz+cmQRUmjqsO3tccHgC5XI
X-Received: from ploh10.prod.google.com ([2002:a17:902:f70a:b0:223:5c97:5c3c])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2309:b0:22e:7f20:52c6 with SMTP id d9443c01a7336-22fc8b5c3dfmr34558255ad.23.1746776814150;
 Fri, 09 May 2025 00:46:54 -0700 (PDT)
Date: Fri,  9 May 2025 00:46:19 -0700
In-Reply-To: <20250509074635.3187114-1-changyuanl@google.com>
Mime-Version: 1.0
References: <20250509074635.3187114-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.1015.ga840276032-goog
Message-ID: <20250509074635.3187114-2-changyuanl@google.com>
Subject: [PATCH v8 01/17] memblock: add MEMBLOCK_RSRV_KERN flag
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
X-CRM114-CacheID: sfid-20250509_004655_594889_D2A73F45 
X-CRM114-Status: GOOD (  16.89  )
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
index ef5a1ecc6e595..6c00fbc085132 100644
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
@@ -476,6 +492,7 @@ static inline __init_memblock bool memblock_bottom_up(void)
 
 phys_addr_t memblock_phys_mem_size(void);
 phys_addr_t memblock_reserved_size(void);
+phys_addr_t memblock_reserved_kern_size(phys_addr_t limit, int nid);
 unsigned long memblock_estimated_nr_free_pages(void);
 phys_addr_t memblock_start_of_DRAM(void);
 phys_addr_t memblock_end_of_DRAM(void);
diff --git a/mm/memblock.c b/mm/memblock.c
index 0a53db4d9f7be..2dc95ecdee5ce 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -492,7 +492,7 @@ static int __init_memblock memblock_double_array(struct memblock_type *type,
 	 * needn't do it
 	 */
 	if (!use_slab)
-		BUG_ON(memblock_reserve(addr, new_alloc_size));
+		BUG_ON(memblock_reserve_kern(addr, new_alloc_size));
 
 	/* Update slab flag */
 	*in_slab = use_slab;
@@ -642,7 +642,7 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 #ifdef CONFIG_NUMA
 			WARN_ON(nid != memblock_get_region_node(rgn));
 #endif
-			WARN_ON(flags != rgn->flags);
+			WARN_ON(flags != MEMBLOCK_NONE && flags != rgn->flags);
 			nr_new++;
 			if (insert) {
 				if (start_rgn == -1)
@@ -902,14 +902,15 @@ int __init_memblock memblock_phys_free(phys_addr_t base, phys_addr_t size)
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
@@ -1460,14 +1461,14 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
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
 
@@ -1752,6 +1753,28 @@ phys_addr_t __init_memblock memblock_reserved_size(void)
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
@@ -2441,6 +2464,7 @@ static const char * const flagname[] = {
 	[ilog2(MEMBLOCK_NOMAP)] = "NOMAP",
 	[ilog2(MEMBLOCK_DRIVER_MANAGED)] = "DRV_MNG",
 	[ilog2(MEMBLOCK_RSRV_NOINIT)] = "RSV_NIT",
+	[ilog2(MEMBLOCK_RSRV_KERN)] = "RSV_KERN",
 };
 
 static int memblock_debug_show(struct seq_file *m, void *private)
diff --git a/tools/testing/memblock/tests/alloc_api.c b/tools/testing/memblock/tests/alloc_api.c
index 68f1a75cd72c4..c55f67dd367d0 100644
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
index 3ef9486da8a09..e5362cfd2ff30 100644
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
index 49bb416d34ffc..562e4701b0e02 100644
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
2.49.0.1015.ga840276032-goog


