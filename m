Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEBD3C369DC
	for <kexec@archiver.kernel.org>; Thu,  1 May 2025 22:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KsrtYfKvpGG224Vuugu7gIhtwe4eY04G0mgo4ynGz+o=; b=YGEeRMJFGt8e9vT7PTeAK0A5VL
	t9ViSdbhtSdsbLxaOwDTeN1fpqU+9XSjY7UK3/Q3xaBYI18MT7wkKL2LsQVkbb8hwionSArqqu6EB
	s8BUFcuAzNAy3iwLuK0v/v+KdF7s3F/qCuZ/HVEAzn+tBk42ZkyxVc5LSO5N2hIksEP724Z6SB4aR
	Xt6K7JfWlxt8nlQqJoVAdRnv4i8T5ySq0NcAV3TYwFUYyndvwfDqQfjSqWu/dYs2jCBvM15pibytd
	1mSfr/UwayC28zTB9Wwt4FxI09j9xFjTS4a3bZNzKIHBew2O59QDirNFOZWqKJtwW55MtF7cbLif/
	wOHW+RNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAcs5-00000000906-25rS;
	Thu, 01 May 2025 22:59:13 +0000
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAcoD-0000000072N-0dLP
	for kexec@lists.infradead.org;
	Thu, 01 May 2025 22:55:15 +0000
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-22403329f9eso11430455ad.3
        for <kexec@lists.infradead.org>; Thu, 01 May 2025 15:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746140112; x=1746744912; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KsrtYfKvpGG224Vuugu7gIhtwe4eY04G0mgo4ynGz+o=;
        b=O/LM3G/ovTW1CA8E6vTmZ8Dhigye27T3pxrPn+rWa5i4YqUFGrh9waIVJuHIb9Rm82
         Pekw1d0YesdSLI54VOH1JEO2lFd1vbgslzxQILgFGiiGRpDYIj0I1zS471pGfIQgSP/H
         wiN3UI4kiXIw9j7QiknTjt2JNff6U8yzeLeHzKy32517BiZiIepIUo64ZIIEtBPrGBhn
         87ygr57OMdybu/Dii6WlOeQ/IGSocIBkGNpGUpyEJPaPe4lVxCfnP6jC63E0CLUPtLb4
         8T09dYD7LIo5z4Olc78+FuRl2GFa9o8YCmCu85M/L0zI1OPaPwEz0oIzIVJ1BfMkWYtA
         Sqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746140112; x=1746744912;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KsrtYfKvpGG224Vuugu7gIhtwe4eY04G0mgo4ynGz+o=;
        b=YH0OHYyz6dh/U7hSds62uIQ0lST1WHaO3ueuLc+IDLBFICxhukET/UCjsNNFwMI9F0
         9dmTe52KZNJ4DSurioqk7wCjYEGwhYMXh/ja3ireH2q4vJ//CIZ1wq8QmCVSWPXe8Q9b
         7mOLB4Ah600v7KvWNM6lMDj4dD4KMfe1aW88PVhAM2oEbAtxfQT1WHPd7diD7qxl4+9X
         zusrIxHdf3iO20xosxeyY39VKi1UkuCsLwBagTWorGO0qQK+ExQqGi21mooFK+UJFWyN
         hDaQ7GHhUJFTLeDMApuNyZSCsIIyUsBNfIASYUJpyVS9Yb7OCKYaGtGbgBWsQoS8vtJt
         0RVA==
X-Forwarded-Encrypted: i=1; AJvYcCVbxacPXL7cR5A/QYT4NylGWkC7nDusa162XIA55Si1fOfvzOMFwpxGMKRVrjUHXqOKJ3tL+A==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy9ERSvt+r/vIeCuGUX+2pQ1qQDeINz/ybrAm4dTKUu8Mk6Xg/k
	2VC/fRLbu7YBOJv3kLO96Pau/kyWtsAdZfogWBb6lsLouJ3oqmiDz1vBpc8xFHdieRsVmpenEHN
	giSKtABpfvZLGJ5q0rw==
X-Google-Smtp-Source: AGHT+IFLb0PSdHgpE7Ok3NaDj2F1I/2reklfUyriSmie18M/0zt3atLCcdPUxCKomSzRS6uR7s3ME4uvfN3pXcz1
X-Received: from pgac15.prod.google.com ([2002:a05:6a02:294f:b0:b16:4869:6621])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:dacf:b0:220:df73:b639 with SMTP id d9443c01a7336-22e10393d3dmr10129945ad.36.1746140112204;
 Thu, 01 May 2025 15:55:12 -0700 (PDT)
Date: Thu,  1 May 2025 15:54:09 -0700
In-Reply-To: <20250501225425.635167-1-changyuanl@google.com>
Mime-Version: 1.0
References: <20250501225425.635167-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
Message-ID: <20250501225425.635167-3-changyuanl@google.com>
Subject: [PATCH v7 02/18] memblock: Add support for scratch memory
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
X-CRM114-CacheID: sfid-20250501_155513_244154_6E2E6C7F 
X-CRM114-Status: GOOD (  26.62  )
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

From: Alexander Graf <graf@amazon.com>

With KHO (Kexec HandOver), we need a way to ensure that the new kernel
does not allocate memory on top of any memory regions that the previous
kernel was handing over. But to know where those are, we need to include
them in the memblock.reserved array which may not be big enough to hold
all ranges that need to be persisted across kexec. To resize the array,
we need to allocate memory. That brings us into a catch 22 situation.

The solution to that is limit memblock allocations to the scratch regions:
safe regions to operate in the case when there is memory that should remain
intact across kexec.

KHO provides several "scratch regions" as part of its metadata. These
scratch regions are contiguous memory blocks that known not to contain any
memory that should be persisted across kexec. These regions should be large
enough to accommodate all memblock allocations done by the kexeced kernel.

We introduce a new memblock_set_scratch_only() function that allows KHO to
indicate that any memblock allocation must happen from the scratch regions.

Later, we may want to perform another KHO kexec. For that, we reuse the
same scratch regions. To ensure that no eventually handed over data gets
allocated inside a scratch region, we flip the semantics of the scratch
region with memblock_clear_scratch_only(): After that call, no allocations
may happen from scratch memblock regions. We will lift that restriction
in the next patch.

Signed-off-by: Alexander Graf <graf@amazon.com>
Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Changyuan Lyu <changyuanl@google.com>
---
 include/linux/memblock.h | 20 +++++++++++++
 mm/Kconfig               |  4 +++
 mm/memblock.c            | 61 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 6c00fbc085132..993937a6b9620 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -45,6 +45,11 @@ extern unsigned long long max_possible_pfn;
  * @MEMBLOCK_RSRV_KERN: memory region that is reserved for kernel use,
  * either explictitly with memblock_reserve_kern() or via memblock
  * allocation APIs. All memblock allocations set this flag.
+ * @MEMBLOCK_KHO_SCRATCH: memory region that kexec can pass to the next
+ * kernel in handover mode. During early boot, we do not know about all
+ * memory reservations yet, so we get scratch memory from the previous
+ * kernel that we know is good to use. It is the only memory that
+ * allocations may happen from in this phase.
  */
 enum memblock_flags {
 	MEMBLOCK_NONE		= 0x0,	/* No special request */
@@ -54,6 +59,7 @@ enum memblock_flags {
 	MEMBLOCK_DRIVER_MANAGED = 0x8,	/* always detected via a driver */
 	MEMBLOCK_RSRV_NOINIT	= 0x10,	/* don't initialize struct pages */
 	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */
+	MEMBLOCK_KHO_SCRATCH	= 0x40,	/* scratch memory for kexec handover */
 };
 
 /**
@@ -148,6 +154,8 @@ int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
 int memblock_mark_nomap(phys_addr_t base, phys_addr_t size);
 int memblock_clear_nomap(phys_addr_t base, phys_addr_t size);
 int memblock_reserved_mark_noinit(phys_addr_t base, phys_addr_t size);
+int memblock_mark_kho_scratch(phys_addr_t base, phys_addr_t size);
+int memblock_clear_kho_scratch(phys_addr_t base, phys_addr_t size);
 
 void memblock_free(void *ptr, size_t size);
 void reset_all_zones_managed_pages(void);
@@ -291,6 +299,11 @@ static inline bool memblock_is_driver_managed(struct memblock_region *m)
 	return m->flags & MEMBLOCK_DRIVER_MANAGED;
 }
 
+static inline bool memblock_is_kho_scratch(struct memblock_region *m)
+{
+	return m->flags & MEMBLOCK_KHO_SCRATCH;
+}
+
 int memblock_search_pfn_nid(unsigned long pfn, unsigned long *start_pfn,
 			    unsigned long  *end_pfn);
 void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
@@ -619,5 +632,12 @@ static inline void early_memtest(phys_addr_t start, phys_addr_t end) { }
 static inline void memtest_report_meminfo(struct seq_file *m) { }
 #endif
 
+#ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
+void memblock_set_kho_scratch_only(void);
+void memblock_clear_kho_scratch_only(void);
+#else
+static inline void memblock_set_kho_scratch_only(void) { }
+static inline void memblock_clear_kho_scratch_only(void) { }
+#endif
 
 #endif /* _LINUX_MEMBLOCK_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index e113f713b4938..60ea9eba48140 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -469,6 +469,10 @@ config HAVE_GUP_FAST
 	depends on MMU
 	bool
 
+# Enable memblock support for scratch memory which is needed for kexec handover
+config MEMBLOCK_KHO_SCRATCH
+	bool
+
 # Don't discard allocated memory used to track "memory" and "reserved" memblocks
 # after early boot, so it can still be used to test for validity of memory.
 # Also, memblocks are updated with memory hot(un)plug.
diff --git a/mm/memblock.c b/mm/memblock.c
index 2dc95ecdee5ce..6eba0dfe87155 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -107,6 +107,13 @@ unsigned long min_low_pfn;
 unsigned long max_pfn;
 unsigned long long max_possible_pfn;
 
+#ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
+/* When set to true, only allocate from MEMBLOCK_KHO_SCRATCH ranges */
+static bool kho_scratch_only;
+#else
+#define kho_scratch_only false
+#endif
+
 static struct memblock_region memblock_memory_init_regions[INIT_MEMBLOCK_MEMORY_REGIONS] __initdata_memblock;
 static struct memblock_region memblock_reserved_init_regions[INIT_MEMBLOCK_RESERVED_REGIONS] __initdata_memblock;
 #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
@@ -166,6 +173,10 @@ bool __init_memblock memblock_has_mirror(void)
 
 static enum memblock_flags __init_memblock choose_memblock_flags(void)
 {
+	/* skip non-scratch memory for kho early boot allocations */
+	if (kho_scratch_only)
+		return MEMBLOCK_KHO_SCRATCH;
+
 	return system_has_some_mirror ? MEMBLOCK_MIRROR : MEMBLOCK_NONE;
 }
 
@@ -925,6 +936,18 @@ int __init_memblock memblock_physmem_add(phys_addr_t base, phys_addr_t size)
 }
 #endif
 
+#ifdef CONFIG_MEMBLOCK_KHO_SCRATCH
+__init void memblock_set_kho_scratch_only(void)
+{
+	kho_scratch_only = true;
+}
+
+__init void memblock_clear_kho_scratch_only(void)
+{
+	kho_scratch_only = false;
+}
+#endif
+
 /**
  * memblock_setclr_flag - set or clear flag for a memory region
  * @type: memblock type to set/clear flag for
@@ -1050,6 +1073,36 @@ int __init_memblock memblock_reserved_mark_noinit(phys_addr_t base, phys_addr_t
 				    MEMBLOCK_RSRV_NOINIT);
 }
 
+/**
+ * memblock_mark_kho_scratch - Mark a memory region as MEMBLOCK_KHO_SCRATCH.
+ * @base: the base phys addr of the region
+ * @size: the size of the region
+ *
+ * Only memory regions marked with %MEMBLOCK_KHO_SCRATCH will be considered
+ * for allocations during early boot with kexec handover.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+__init int memblock_mark_kho_scratch(phys_addr_t base, phys_addr_t size)
+{
+	return memblock_setclr_flag(&memblock.memory, base, size, 1,
+				    MEMBLOCK_KHO_SCRATCH);
+}
+
+/**
+ * memblock_clear_kho_scratch - Clear MEMBLOCK_KHO_SCRATCH flag for a
+ * specified region.
+ * @base: the base phys addr of the region
+ * @size: the size of the region
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+__init int memblock_clear_kho_scratch(phys_addr_t base, phys_addr_t size)
+{
+	return memblock_setclr_flag(&memblock.memory, base, size, 0,
+				    MEMBLOCK_KHO_SCRATCH);
+}
+
 static bool should_skip_region(struct memblock_type *type,
 			       struct memblock_region *m,
 			       int nid, int flags)
@@ -1081,6 +1134,13 @@ static bool should_skip_region(struct memblock_type *type,
 	if (!(flags & MEMBLOCK_DRIVER_MANAGED) && memblock_is_driver_managed(m))
 		return true;
 
+	/*
+	 * In early alloc during kexec handover, we can only consider
+	 * MEMBLOCK_KHO_SCRATCH regions for the allocations
+	 */
+	if ((flags & MEMBLOCK_KHO_SCRATCH) && !memblock_is_kho_scratch(m))
+		return true;
+
 	return false;
 }
 
@@ -2465,6 +2525,7 @@ static const char * const flagname[] = {
 	[ilog2(MEMBLOCK_DRIVER_MANAGED)] = "DRV_MNG",
 	[ilog2(MEMBLOCK_RSRV_NOINIT)] = "RSV_NIT",
 	[ilog2(MEMBLOCK_RSRV_KERN)] = "RSV_KERN",
+	[ilog2(MEMBLOCK_KHO_SCRATCH)] = "KHO_SCRATCH",
 };
 
 static int memblock_debug_show(struct seq_file *m, void *private)
-- 
2.49.0.906.g1f30a19c02-goog


