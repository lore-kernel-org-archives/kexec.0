Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302C9C02194
	for <kexec@archiver.kernel.org>; Thu,  6 Feb 2025 13:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=45SYQSp9p7qqqIC8zBgRI8ji8Hid3qXXZnPvMdKywQY=; b=Kltk9wrSYj2tAcomCX0LSwydrN
	+ytgIHOA2y8tEaDTt45PwUjVodUQFQbl2bvecn6G46ARX76F18acLhjyvC45RyNYAqhmIr4bkUN20
	Wzfq8dAw10EXRTJ9lP0065UVN+m8Gd+Uo3Nk0WEI00qOAZ+HguVKKmTwlsJ9KR7+7Bc7IdmCfYXUU
	Q0D+4BafqCxFaDFgBhAG3a/35AcpV9pc1yd0701Ln7DxqNMbZ92jUjw0w52e5ZJ320AHhPAEK5nGp
	LTLFGF3+ZPT+u7quzYPDjzqVwXP6rSUy3/iShv3YDXQmLOJUB6kKK2rN5QZ8x5NO48DsOyYLAyyah
	07tDA3Cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tg295-00000006T7O-25b0;
	Thu, 06 Feb 2025 13:42:19 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tg1wJ-00000006QpJ-1MjI;
	Thu, 06 Feb 2025 13:29:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 9056FA4427C;
	Thu,  6 Feb 2025 13:27:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB2AC4CEE3;
	Thu,  6 Feb 2025 13:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738848546;
	bh=zScMayK3cWD1mMJXYYmDK7F4kfedIYXeuYTj7qJBVlI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=biZ9QFQP+P7B9drawcug/6K/P8DFFCsk//HfEbfYsoUfNZ3KoiE1keLRcg6i4Si9i
	 SFnd6QSpv4kaH/s/tNra2R6B1LEoVRmYFHbLsuo/Dpp53LqixKCoIuYxAcfD+NXn+o
	 Wop7PZUdYVaVuwQz6apo9DnV/M499hgqSZEgaNNyRalFsGyJ9e1SIUEa+xW10DWZxF
	 updAIiyE6b6QCGI7vinf4fYe3iox/lPFfK6mDAgnErUeIJlJbnj7K34pEH+MZNjzMI
	 vQG3LYdoH6lxxShXDdMfepS9xYsoSj5gmB2PkkP1/qU2mBs082Z4E77uaT3jU8sg0y
	 sIM51EF+xVong==
From: Mike Rapoport <rppt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Gowans <jgowans@amazon.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mike Rapoport <rppt@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pratyush Yadav <ptyadav@amazon.de>,
	Rob Herring <robh+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Usama Arif <usama.arif@bytedance.com>,
	Will Deacon <will@kernel.org>,
	devicetree@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	x86@kernel.org
Subject: [PATCH v4 06/14] kexec: Add KHO parsing support
Date: Thu,  6 Feb 2025 15:27:46 +0200
Message-ID: <20250206132754.2596694-7-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250206132754.2596694-1-rppt@kernel.org>
References: <20250206132754.2596694-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250206_052907_499527_92A2F829 
X-CRM114-Status: GOOD (  42.49  )
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

When we have a KHO kexec, we get a device tree and scratch region to
populate the state of the system. Provide helper functions that allow
architecture code to easily handle memory reservations based on them and
give device drivers visibility into the KHO DT and memory reservations
so they can recover their own state.

Signed-off-by: Alexander Graf <graf@amazon.com>
Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 Documentation/ABI/testing/sysfs-firmware-kho |   9 +
 MAINTAINERS                                  |   1 +
 include/linux/kexec.h                        |  12 +
 kernel/kexec_handover.c                      | 268 ++++++++++++++++++-
 mm/memblock.c                                |   1 +
 5 files changed, 290 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-firmware-kho

diff --git a/Documentation/ABI/testing/sysfs-firmware-kho b/Documentation/ABI/testing/sysfs-firmware-kho
new file mode 100644
index 000000000000..e4ed2cb7c810
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-firmware-kho
@@ -0,0 +1,9 @@
+What:		/sys/firmware/kho/dt
+Date:		December 2023
+Contact:	Alexander Graf <graf@amazon.com>
+Description:
+		When the kernel was booted with Kexec HandOver (KHO),
+		the device tree that carries metadata about the previous
+		kernel's state is in this file. This file may disappear
+		when all consumers of it finished to interpret their
+		metadata.
diff --git a/MAINTAINERS b/MAINTAINERS
index 8327795e8899..e1e01b2a3727 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12826,6 +12826,7 @@ M:	Eric Biederman <ebiederm@xmission.com>
 L:	kexec@lists.infradead.org
 S:	Maintained
 W:	http://kernel.org/pub/linux/utils/kernel/kexec/
+F:	Documentation/ABI/testing/sysfs-firmware-kho
 F:	Documentation/ABI/testing/sysfs-kernel-kho
 F:	include/linux/kexec.h
 F:	include/uapi/linux/kexec.h
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index ef5c90abafd1..4fdf5ee27144 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -490,12 +490,24 @@ enum kho_event {
 };
 
 struct notifier_block;
+struct kho_mem;
 
 #ifdef CONFIG_KEXEC_HANDOVER
+void kho_populate(phys_addr_t dt_phys, phys_addr_t scratch_phys,
+		  u64 scratch_len);
+const void *kho_get_fdt(void);
+void kho_return_mem(const struct kho_mem *mem);
+void *kho_claim_mem(const struct kho_mem *mem);
 int register_kho_notifier(struct notifier_block *nb);
 int unregister_kho_notifier(struct notifier_block *nb);
 void kho_memory_init(void);
 #else
+static inline void kho_populate(phys_addr_t dt_phys, phys_addr_t scratch_phys,
+				u64 scratch_len) {}
+static inline void *kho_get_fdt(void) { return NULL; }
+static inline void kho_return_mem(const struct kho_mem *mem) { }
+static inline void *kho_claim_mem(const struct kho_mem *mem) { return NULL; }
+
 static inline int register_kho_notifier(struct notifier_block *nb) { return 0; }
 static inline int unregister_kho_notifier(struct notifier_block *nb) { return 0; }
 static inline void kho_memory_init(void) {}
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index eccfe3a25798..3b360e3a6057 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -51,6 +51,15 @@ static struct kho_out kho_out = {
 	.dt_max = 10 * SZ_1M,
 };
 
+struct kho_in {
+	struct kobject *kobj;
+	phys_addr_t kho_scratch_phys;
+	phys_addr_t handover_phys;
+	u32 handover_len;
+};
+
+static struct kho_in kho_in;
+
 int register_kho_notifier(struct notifier_block *nb)
 {
 	return blocking_notifier_chain_register(&kho_out.chain_head, nb);
@@ -63,6 +72,89 @@ int unregister_kho_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(unregister_kho_notifier);
 
+const void *kho_get_fdt(void)
+{
+	if (!kho_in.handover_phys)
+		return NULL;
+
+	return __va(kho_in.handover_phys);
+}
+EXPORT_SYMBOL_GPL(kho_get_fdt);
+
+static void kho_return_pfn(ulong pfn)
+{
+	struct page *page = pfn_to_online_page(pfn);
+
+	if (WARN_ON(!page))
+		return;
+	__free_page(page);
+}
+
+/**
+ * kho_return_mem - Notify the kernel that initially reserved memory is no
+ * longer needed.
+ * @mem: memory range that was preserved during kexec handover
+ *
+ * When the last consumer of a page returns their memory, kho returns the page
+ * to the buddy allocator as free page.
+ */
+void kho_return_mem(const struct kho_mem *mem)
+{
+	unsigned long start_pfn, end_pfn, pfn;
+
+	start_pfn = PFN_DOWN(mem->addr);
+	end_pfn = PFN_UP(mem->addr + mem->size);
+
+	for (pfn = start_pfn; pfn < end_pfn; pfn++)
+		kho_return_pfn(pfn);
+}
+EXPORT_SYMBOL_GPL(kho_return_mem);
+
+static int kho_claim_pfn(ulong pfn)
+{
+	struct page *page = pfn_to_online_page(pfn);
+
+	if (!page)
+		return -ENOMEM;
+
+	/* almost as free_reserved_page(), just don't free the page */
+	ClearPageReserved(page);
+	init_page_count(page);
+	adjust_managed_page_count(page, 1);
+
+	return 0;
+}
+
+/**
+ * kho_claim_mem - Notify the kernel that a handed over memory range is now
+ * in use
+ * @mem: memory range that was preserved during kexec handover
+ *
+ * A kernel subsystem preserved that range during handover and it is going
+ * to reuse this range after kexec. The pages in the range are treated as
+ * allocated, but not %PG_reserved.
+ *
+ * Return: virtual address of the preserved memory range
+ */
+void *kho_claim_mem(const struct kho_mem *mem)
+{
+	unsigned long start_pfn, end_pfn, pfn;
+	void *va = __va(mem->addr);
+
+	start_pfn = PFN_DOWN(mem->addr);
+	end_pfn = PFN_UP(mem->addr + mem->size);
+
+	for (pfn = start_pfn; pfn < end_pfn; pfn++) {
+		int err = kho_claim_pfn(pfn);
+
+		if (err)
+			return NULL;
+	}
+
+	return va;
+}
+EXPORT_SYMBOL_GPL(kho_claim_mem);
+
 static ssize_t dt_read(struct file *file, struct kobject *kobj,
 		       struct bin_attribute *attr, char *buf,
 		       loff_t pos, size_t count)
@@ -273,6 +365,30 @@ static const struct attribute *kho_out_attrs[] = {
 	NULL,
 };
 
+/* Handling for /sys/firmware/kho */
+static BIN_ATTR_SIMPLE_RO(dt_fw);
+
+static __init int kho_in_sysfs_init(const void *fdt)
+{
+	int err;
+
+	kho_in.kobj = kobject_create_and_add("kho", firmware_kobj);
+	if (!kho_in.kobj)
+		return -ENOMEM;
+
+	bin_attr_dt_fw.size = fdt_totalsize(fdt);
+	bin_attr_dt_fw.private = (void *)fdt;
+	err = sysfs_create_bin_file(kho_in.kobj, &bin_attr_dt_fw);
+	if (err)
+		goto err_put_kobj;
+
+	return 0;
+
+err_put_kobj:
+	kobject_put(kho_in.kobj);
+	return err;
+}
+
 static __init int kho_out_sysfs_init(void)
 {
 	int err;
@@ -294,6 +410,7 @@ static __init int kho_out_sysfs_init(void)
 
 static __init int kho_init(void)
 {
+	const void *fdt = kho_get_fdt();
 	int err;
 
 	if (!kho_enable)
@@ -303,6 +420,21 @@ static __init int kho_init(void)
 	if (err)
 		return err;
 
+	if (fdt) {
+		err = kho_in_sysfs_init(fdt);
+		/*
+		 * Failure to create /sys/firmware/kho/dt does not prevent
+		 * reviving state from KHO and setting up KHO for the next
+		 * kexec.
+		 */
+		if (err)
+			pr_err("failed exposing handover FDT in sysfs\n");
+
+		kho_scratch = __va(kho_in.kho_scratch_phys);
+
+		return 0;
+	}
+
 	for (int i = 0; i < kho_scratch_cnt; i++) {
 		unsigned long base_pfn = PHYS_PFN(kho_scratch[i].addr);
 		unsigned long count = kho_scratch[i].size >> PAGE_SHIFT;
@@ -444,7 +576,141 @@ static void kho_reserve_scratch(void)
 	kho_enable = false;
 }
 
+/*
+ * Scan the DT for any memory ranges and make sure they are reserved in
+ * memblock, otherwise they will end up in a weird state on free lists.
+ */
+static void kho_init_reserved_pages(void)
+{
+	const void *fdt = kho_get_fdt();
+	int offset = 0, depth = 0, initial_depth = 0, len;
+
+	if (!fdt)
+		return;
+
+	/* Go through the mem list and add 1 for each reference */
+	for (offset = 0;
+	     offset >= 0 && depth >= initial_depth;
+	     offset = fdt_next_node(fdt, offset, &depth)) {
+		const struct kho_mem *mems;
+		u32 i;
+
+		mems = fdt_getprop(fdt, offset, "mem", &len);
+		if (!mems || len & (sizeof(*mems) - 1))
+			continue;
+
+		for (i = 0; i < len; i += sizeof(*mems)) {
+			const struct kho_mem *mem = &mems[i];
+
+			memblock_reserve(mem->addr, mem->size);
+		}
+	}
+}
+
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
+			set_pageblock_migratetype(pfn_to_page(pfn), MIGRATE_CMA);
+	}
+}
+
 void __init kho_memory_init(void)
 {
-	kho_reserve_scratch();
+	if (!kho_get_fdt()) {
+		kho_reserve_scratch();
+	} else {
+		kho_init_reserved_pages();
+		kho_release_scratch();
+	}
+}
+
+void __init kho_populate(phys_addr_t handover_dt_phys, phys_addr_t scratch_phys,
+			 u64 scratch_len)
+{
+	void *handover_dt;
+	struct kho_mem *scratch;
+
+	/* Determine the real size of the DT */
+	handover_dt = early_memremap(handover_dt_phys, sizeof(struct fdt_header));
+	if (!handover_dt) {
+		pr_warn("setup: failed to memremap kexec FDT (0x%llx)\n", handover_dt_phys);
+		return;
+	}
+
+	if (fdt_check_header(handover_dt)) {
+		pr_warn("setup: kexec handover FDT is invalid (0x%llx)\n", handover_dt_phys);
+		early_memunmap(handover_dt, PAGE_SIZE);
+		return;
+	}
+
+	kho_in.handover_len = fdt_totalsize(handover_dt);
+	kho_in.handover_phys = handover_dt_phys;
+
+	early_memunmap(handover_dt, sizeof(struct fdt_header));
+
+	/* Reserve the DT so we can still access it in late boot */
+	memblock_reserve(kho_in.handover_phys, kho_in.handover_len);
+
+	kho_in.kho_scratch_phys = scratch_phys;
+	kho_scratch_cnt = scratch_len / sizeof(*kho_scratch);
+	scratch = early_memremap(scratch_phys, scratch_len);
+	if (!scratch) {
+		pr_warn("setup: failed to memremap kexec scratch (0x%llx)\n", scratch_phys);
+		return;
+	}
+
+	/*
+	 * We pass a safe contiguous blocks of memory to use for early boot
+	 * purporses from the previous kernel so that we can resize the
+	 * memblock array as needed.
+	 */
+	for (int i = 0; i < kho_scratch_cnt; i++) {
+		struct kho_mem *area = &scratch[i];
+		u64 size = area->size;
+
+		memblock_add(area->addr, size);
+
+		if (WARN_ON(memblock_mark_kho_scratch(area->addr, size))) {
+			pr_err("Kexec failed to mark the scratch region. Disabling KHO revival.");
+			kho_in.handover_len = 0;
+			kho_in.handover_phys = 0;
+			scratch = NULL;
+			break;
+		}
+		pr_debug("Marked 0x%pa+0x%pa as scratch", &area->addr, &size);
+	}
+
+	early_memunmap(scratch, scratch_len);
+
+	if (!scratch)
+		return;
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
+	pr_info("setup: Found kexec handover data. Will skip init for some devices\n");
 }
diff --git a/mm/memblock.c b/mm/memblock.c
index 54bd95745381..84df96efca62 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2366,6 +2366,7 @@ void __init memblock_free_all(void)
 	free_unused_memmap();
 	reset_all_zones_managed_pages();
 
+	memblock_clear_kho_scratch_only();
 	pages = free_low_memory_core_early();
 	totalram_pages_add(pages);
 }
-- 
2.47.2


