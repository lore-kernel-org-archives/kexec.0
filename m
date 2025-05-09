Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7823C3ABBC
	for <kexec@archiver.kernel.org>; Fri,  9 May 2025 07:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wqZ/LMVUIexBccat841AMmJztq2TGQ9rs5gX6EhC3VY=; b=xIx09RKwvELOQBNrVaUHxo9czH
	yXPYaH7qekf1F6z2pf6bamDjTm8ZTAhjHIYA7OZ6jePomYQcVpJs4nq/bqvPG8LRcd3g6cbjOcgz/
	fKMpSq7mAp+p8aFm1OYwAkCDwDetftG91MlHjAPH3cFVjkdEgDOJseapaHctEqnjl1ysa3+s+lmv4
	YyH4HQOGrUzWkiTiA78YKSjHSBBkNKZpUDykMTeg6lDAsLXvjSm2p6hB8yBzWWd+P5qmwzC1l1mdO
	JOib/DsxiI83TPfevJNADOzfvmqp9A1zJiK3QOy/HeF9thZY1Pgu6QsKBoBVbKyENqFlzcYqZqeKv
	V1ZwL9/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDIZy-00000002q0g-1iB8;
	Fri, 09 May 2025 07:55:34 +0000
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDIRk-00000002nXC-0dZY
	for kexec@lists.infradead.org;
	Fri, 09 May 2025 07:47:05 +0000
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-b0f807421c9so1137894a12.0
        for <kexec@lists.infradead.org>; Fri, 09 May 2025 00:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746776823; x=1747381623; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wqZ/LMVUIexBccat841AMmJztq2TGQ9rs5gX6EhC3VY=;
        b=MR/n5Kq8Fij8PtcjOr0N+HS8h9ElrJ6HcpRI4Nm+1GPA1+RkUxR0YgVRMlTmGcSc+G
         p/VROGzDhX9avtreOrH1k/SWt0uO3aBkCBTrFJxyal1AxUVLfr1bs4ge6Ay3TsuPE0dr
         Hp1LhtwTYtDvBRaFEldboO/GtYoAGfBnI/Z6VYmH465jP8jx5P/1nXFvIoDTKBHOyKtW
         pY1/txUXWLDOpELJXT/msPozovSydOV0tmYw8C5jMWmJItx5nGlP+ZaPXBBLtiiguwx3
         NWM2fVKIbjBdDpvyyjIV5eqg8XldRYnGj3IFeBDiQMtGsAcLrriXZ/NbnMAlnk4bUshw
         vwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746776823; x=1747381623;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wqZ/LMVUIexBccat841AMmJztq2TGQ9rs5gX6EhC3VY=;
        b=PzACf7OxRwbTWQTUIhRtdO+9NmiGhwSXnHP9mmWWIVxDoOapO8zfZhwIEXytLlkn/Z
         8y00hMAxvJWcXzcIug3PdLCESYbD8UJ/cmMgpRV+G49vHx/9TdU7Ox4QKn+b4XEDemAx
         ZKlZQmtU3ktAPSlFBB+kyr/fmi+AD2xIk4U6w0nTGGg34DJYDvlTYpcdHlOOyLqFxDLl
         dKe4KPeRtPZd5kf+yx1Oa+eku/FrrGoueK3OMXs/Ouet6GwHvSt4iDk+oTmC2J+zdLOY
         azXm/d3ELj+3sn0SWjb23IiLUfR4DgNEz27rnpYzztLWZbGnP1kdXFRRMpKFOW2+bIgi
         WIig==
X-Forwarded-Encrypted: i=1; AJvYcCWczNeBk/8wSOvxslM+5A+dkQ4XAplAVTgqwGDQKRWEMxDFN4PQNKA2DI3/wP0IkjfLSZasuw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yw74VTmFfZE3ApmHMDPUlPHNnbCPcl2pX09V90xxlGI191Lwnmp
	sy4aWbotkaGmQwgpHhswvp22C4+eubzqAUa2/uu9PJ+anEr3GU6VjK3dptvOlcwhqXLLYcC+Ivr
	gihgmgZ92xbhLP6lsSQ==
X-Google-Smtp-Source: AGHT+IHKqSVutKeNYLWyP6sC5tlz+ty21eEvwjrDNs3QbU+OREsI4XiHb8dFNRZwPZweJP8k4l3lRdHa5KS1De4J
X-Received: from pgmn24.prod.google.com ([2002:a63:5c58:0:b0:b1f:9534:4f55])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:6f07:b0:203:addb:5a29 with SMTP id adf61e73a8af0-215abc78929mr3789624637.40.1746776822730;
 Fri, 09 May 2025 00:47:02 -0700 (PDT)
Date: Fri,  9 May 2025 00:46:23 -0700
In-Reply-To: <20250509074635.3187114-1-changyuanl@google.com>
Mime-Version: 1.0
References: <20250509074635.3187114-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.1015.ga840276032-goog
Message-ID: <20250509074635.3187114-6-changyuanl@google.com>
Subject: [PATCH v8 05/17] kexec: add KHO parsing support
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
X-CRM114-CacheID: sfid-20250509_004704_290711_A46E4D46 
X-CRM114-Status: GOOD (  29.83  )
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

When we have a KHO kexec, we get an FDT blob and scratch region to
populate the state of the system. Provide helper functions that allow
architecture code to easily handle memory reservations based on them and
give device drivers visibility into the KHO FDT and memory reservations
so they can recover their own state.

Include a fix from Arnd Bergmann <arnd@arndb.de>
https://lore.kernel.org/lkml/20250424093302.3894961-1-arnd@kernel.org/.

Signed-off-by: Alexander Graf <graf@amazon.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Co-developed-by: Changyuan Lyu <changyuanl@google.com>
Signed-off-by: Changyuan Lyu <changyuanl@google.com>
---
 include/linux/kexec_handover.h |  14 ++
 kernel/kexec_handover.c        | 233 ++++++++++++++++++++++++++++++++-
 mm/memblock.c                  |   1 +
 3 files changed, 247 insertions(+), 1 deletion(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 2e19004776f6b..02dcfc8c427e3 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -24,11 +24,15 @@ struct kho_serialization;
 bool kho_is_enabled(void);
 
 int kho_add_subtree(struct kho_serialization *ser, const char *name, void *fdt);
+int kho_retrieve_subtree(const char *name, phys_addr_t *phys);
 
 int register_kho_notifier(struct notifier_block *nb);
 int unregister_kho_notifier(struct notifier_block *nb);
 
 void kho_memory_init(void);
+
+void kho_populate(phys_addr_t fdt_phys, u64 fdt_len, phys_addr_t scratch_phys,
+		  u64 scratch_len);
 #else
 static inline bool kho_is_enabled(void)
 {
@@ -41,6 +45,11 @@ static inline int kho_add_subtree(struct kho_serialization *ser,
 	return -EOPNOTSUPP;
 }
 
+static inline int kho_retrieve_subtree(const char *name, phys_addr_t *phys)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int register_kho_notifier(struct notifier_block *nb)
 {
 	return -EOPNOTSUPP;
@@ -54,6 +63,11 @@ static inline int unregister_kho_notifier(struct notifier_block *nb)
 static inline void kho_memory_init(void)
 {
 }
+
+static inline void kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
+				phys_addr_t scratch_phys, u64 scratch_len)
+{
+}
 #endif /* CONFIG_KEXEC_HANDOVER */
 
 #endif /* LINUX_KEXEC_HANDOVER_H */
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index e541d3d5003d1..59f3cf9557f50 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -17,6 +17,9 @@
 #include <linux/memblock.h>
 #include <linux/notifier.h>
 #include <linux/page-isolation.h>
+
+#include <asm/early_ioremap.h>
+
 /*
  * KHO is tightly coupled with mm init and needs access to some of mm
  * internal APIs.
@@ -501,9 +504,112 @@ static __init int kho_out_debugfs_init(void)
 	return -ENOENT;
 }
 
+struct kho_in {
+	struct dentry *dir;
+	phys_addr_t fdt_phys;
+	phys_addr_t scratch_phys;
+	struct list_head fdt_list;
+};
+
+static struct kho_in kho_in = {
+	.fdt_list = LIST_HEAD_INIT(kho_in.fdt_list),
+};
+
+static const void *kho_get_fdt(void)
+{
+	return kho_in.fdt_phys ? phys_to_virt(kho_in.fdt_phys) : NULL;
+}
+
+/**
+ * kho_retrieve_subtree - retrieve a preserved sub FDT by its name.
+ * @name: the name of the sub FDT passed to kho_add_subtree().
+ * @phys: if found, the physical address of the sub FDT is stored in @phys.
+ *
+ * Retrieve a preserved sub FDT named @name and store its physical
+ * address in @phys.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int kho_retrieve_subtree(const char *name, phys_addr_t *phys)
+{
+	const void *fdt = kho_get_fdt();
+	const u64 *val;
+	int offset, len;
+
+	if (!fdt)
+		return -ENOENT;
+
+	if (!phys)
+		return -EINVAL;
+
+	offset = fdt_subnode_offset(fdt, 0, name);
+	if (offset < 0)
+		return -ENOENT;
+
+	val = fdt_getprop(fdt, offset, PROP_SUB_FDT, &len);
+	if (!val || len != sizeof(*val))
+		return -EINVAL;
+
+	*phys = (phys_addr_t)*val;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kho_retrieve_subtree);
+
+/* Handling for debugfs/kho/in */
+
+static __init int kho_in_debugfs_init(const void *fdt)
+{
+	struct dentry *sub_fdt_dir;
+	int err, child;
+
+	kho_in.dir = debugfs_create_dir("in", debugfs_root);
+	if (IS_ERR(kho_in.dir))
+		return PTR_ERR(kho_in.dir);
+
+	sub_fdt_dir = debugfs_create_dir("sub_fdts", kho_in.dir);
+	if (IS_ERR(sub_fdt_dir)) {
+		err = PTR_ERR(sub_fdt_dir);
+		goto err_rmdir;
+	}
+
+	err = kho_debugfs_fdt_add(&kho_in.fdt_list, kho_in.dir, "fdt", fdt);
+	if (err)
+		goto err_rmdir;
+
+	fdt_for_each_subnode(child, fdt, 0) {
+		int len = 0;
+		const char *name = fdt_get_name(fdt, child, NULL);
+		const u64 *fdt_phys;
+
+		fdt_phys = fdt_getprop(fdt, child, "fdt", &len);
+		if (!fdt_phys)
+			continue;
+		if (len != sizeof(*fdt_phys)) {
+			pr_warn("node `%s`'s prop `fdt` has invalid length: %d\n",
+				name, len);
+			continue;
+		}
+		err = kho_debugfs_fdt_add(&kho_in.fdt_list, sub_fdt_dir, name,
+					  phys_to_virt(*fdt_phys));
+		if (err) {
+			pr_warn("failed to add fdt `%s` to debugfs: %d\n", name,
+				err);
+			continue;
+		}
+	}
+
+	return 0;
+
+err_rmdir:
+	debugfs_remove_recursive(kho_in.dir);
+	return err;
+}
+
 static __init int kho_init(void)
 {
 	int err = 0;
+	const void *fdt = kho_get_fdt();
 
 	if (!kho_enable)
 		return 0;
@@ -524,6 +630,20 @@ static __init int kho_init(void)
 	if (err)
 		goto err_free_fdt;
 
+	if (fdt) {
+		err = kho_in_debugfs_init(fdt);
+		/*
+		 * Failure to create /sys/kernel/debug/kho/in does not prevent
+		 * reviving state from KHO and setting up KHO for the next
+		 * kexec.
+		 */
+		if (err)
+			pr_err("failed exposing handover FDT in debugfs: %d\n",
+			       err);
+
+		return 0;
+	}
+
 	for (int i = 0; i < kho_scratch_cnt; i++) {
 		unsigned long base_pfn = PHYS_PFN(kho_scratch[i].addr);
 		unsigned long count = kho_scratch[i].size >> PAGE_SHIFT;
@@ -551,7 +671,118 @@ static __init int kho_init(void)
 }
 late_initcall(kho_init);
 
+static void __init kho_release_scratch(void)
+{
+	phys_addr_t start, end;
+	u64 i;
+
+	memmap_init_kho_scratch_pages();
+
+	/*
+	 * Mark scratch mem as CMA before we return it. That way we
+	 * ensure that no kernel allocations happen on it. That means
+	 * we can reuse it as scratch memory again later.
+	 */
+	__for_each_mem_range(i, &memblock.memory, NULL, NUMA_NO_NODE,
+			     MEMBLOCK_KHO_SCRATCH, &start, &end, NULL) {
+		ulong start_pfn = pageblock_start_pfn(PFN_DOWN(start));
+		ulong end_pfn = pageblock_align(PFN_UP(end));
+		ulong pfn;
+
+		for (pfn = start_pfn; pfn < end_pfn; pfn += pageblock_nr_pages)
+			set_pageblock_migratetype(pfn_to_page(pfn),
+						  MIGRATE_CMA);
+	}
+}
+
 void __init kho_memory_init(void)
 {
-	kho_reserve_scratch();
+	if (kho_in.scratch_phys) {
+		kho_scratch = phys_to_virt(kho_in.scratch_phys);
+		kho_release_scratch();
+	} else {
+		kho_reserve_scratch();
+	}
+}
+
+void __init kho_populate(phys_addr_t fdt_phys, u64 fdt_len,
+			 phys_addr_t scratch_phys, u64 scratch_len)
+{
+	void *fdt = NULL;
+	struct kho_scratch *scratch = NULL;
+	int err = 0;
+	unsigned int scratch_cnt = scratch_len / sizeof(*kho_scratch);
+
+	/* Validate the input FDT */
+	fdt = early_memremap(fdt_phys, fdt_len);
+	if (!fdt) {
+		pr_warn("setup: failed to memremap FDT (0x%llx)\n", fdt_phys);
+		err = -EFAULT;
+		goto out;
+	}
+	err = fdt_check_header(fdt);
+	if (err) {
+		pr_warn("setup: handover FDT (0x%llx) is invalid: %d\n",
+			fdt_phys, err);
+		err = -EINVAL;
+		goto out;
+	}
+	err = fdt_node_check_compatible(fdt, 0, KHO_FDT_COMPATIBLE);
+	if (err) {
+		pr_warn("setup: handover FDT (0x%llx) is incompatible with '%s': %d\n",
+			fdt_phys, KHO_FDT_COMPATIBLE, err);
+		err = -EINVAL;
+		goto out;
+	}
+
+	scratch = early_memremap(scratch_phys, scratch_len);
+	if (!scratch) {
+		pr_warn("setup: failed to memremap scratch (phys=0x%llx, len=%lld)\n",
+			scratch_phys, scratch_len);
+		err = -EFAULT;
+		goto out;
+	}
+
+	/*
+	 * We pass a safe contiguous blocks of memory to use for early boot
+	 * purporses from the previous kernel so that we can resize the
+	 * memblock array as needed.
+	 */
+	for (int i = 0; i < scratch_cnt; i++) {
+		struct kho_scratch *area = &scratch[i];
+		u64 size = area->size;
+
+		memblock_add(area->addr, size);
+		err = memblock_mark_kho_scratch(area->addr, size);
+		if (WARN_ON(err)) {
+			pr_warn("failed to mark the scratch region 0x%pa+0x%pa: %d",
+				&area->addr, &size, err);
+			goto out;
+		}
+		pr_debug("Marked 0x%pa+0x%pa as scratch", &area->addr, &size);
+	}
+
+	memblock_reserve(scratch_phys, scratch_len);
+
+	/*
+	 * Now that we have a viable region of scratch memory, let's tell
+	 * the memblocks allocator to only use that for any allocations.
+	 * That way we ensure that nothing scribbles over in use data while
+	 * we initialize the page tables which we will need to ingest all
+	 * memory reservations from the previous kernel.
+	 */
+	memblock_set_kho_scratch_only();
+
+	kho_in.fdt_phys = fdt_phys;
+	kho_in.scratch_phys = scratch_phys;
+	kho_scratch_cnt = scratch_cnt;
+	pr_info("found kexec handover data. Will skip init for some devices\n");
+
+out:
+	if (fdt)
+		early_memunmap(fdt, fdt_len);
+	if (scratch)
+		early_memunmap(scratch, scratch_len);
+	if (err)
+		pr_warn("disabling KHO revival: %d\n", err);
 }
diff --git a/mm/memblock.c b/mm/memblock.c
index b9148822db7aa..9202c3412bb19 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2377,6 +2377,7 @@ void __init memblock_free_all(void)
 	free_unused_memmap();
 	reset_all_zones_managed_pages();
 
+	memblock_clear_kho_scratch_only();
 	pages = free_low_memory_core_early();
 	totalram_pages_add(pages);
 }
-- 
2.49.0.1015.ga840276032-goog


