Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B53C36006
	for <kexec@archiver.kernel.org>; Thu, 20 Mar 2025 15:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uzt28YGX83ujtBiUFsJhvG1AtvyLncXc8B9iuS5ri6U=; b=2Am+Ct2DwfMiwBbqAFviVWTdR0
	Lq/cSTQC5usP84yqrVt3xaoYiNIjpF7eln+FEikqY5Qc4fjMJ0DWNkQ7qL/B4JdFpPKzVM8msntAP
	C0TcDDf2h1PNWC3GzIFx/XjcAwlKE9dW7IdJK3y51NnwLdkp0A/I3gBAmIpZ6sVyag3OXNtzi73Ma
	MZNTGzV+6iErk6YJ2JbiqHlVN4LhScuVGJs31dCZtiS785BH5Tehuz/xOujVLWVux7Ayb7er+cREd
	yDmKKenBAw+79Nnrg4lR0Ao2ixKJ0L7gq8a5xLfhuvA31PLTlQcRzUqzRIPVyGpwEsH3LDDRHQo4B
	Ijv7jVEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvHRv-0000000CTwU-3CdO;
	Thu, 20 Mar 2025 15:04:47 +0000
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tv58o-0000000AkWV-1sq1
	for kexec@lists.infradead.org;
	Thu, 20 Mar 2025 01:56:19 +0000
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-2ff53a4754aso857675a91.2
        for <kexec@lists.infradead.org>; Wed, 19 Mar 2025 18:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742435773; x=1743040573; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uzt28YGX83ujtBiUFsJhvG1AtvyLncXc8B9iuS5ri6U=;
        b=zNytb+Y1foWqQ4GfX9/Pkr5CAPqQ12/t0S4C+cf5htYKNnQXBk4/QZZP5oVvk3LBWM
         EwJENYj9jZB1vETY+esIPgUiIS+SEWaiJh7esp7RsGtKNQyUcErxTsCwyRQtpYdOkXmb
         k2i9l3g4nGQL2iTAFVDmcyfX0eT4Y2CUIhi1klG60IxRKjaElxF7ZhhcTKJPVu3HrhAD
         ySizQI1Vw8EegrwX9pKT/2z7xOwb4/pRV/b1PhzHEXEq/6ZdBPgG077Qx9dh+Uaseya6
         23o1qEmmy2BK0BkXxgnEsNHghMT2rvYCw5zSHWS7cLjHKG09MNv/o0fBZwMHAJ20SUjL
         tkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742435773; x=1743040573;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uzt28YGX83ujtBiUFsJhvG1AtvyLncXc8B9iuS5ri6U=;
        b=RmLP+Wp8Xp/34ZKhpRuQb9q9QrWpEjiy/wBqnTVpWERxWK92krqG1/0Zd4uWPjKd/L
         PqQLfKCjTvPE71ueSWYOM4rrSvsPmls853QI6K6NWqvy+HO4OJNyzc1+Tw0AqQrSkgqa
         2vbLQfX+AJOCRUE5K6Ap3mXj8dfqZiXQYgh5Z2JcblH0yXM8/5lc/U58xphuuU8jWrrQ
         cgeHcuAb3t/4E3mYgpWj7SIv0CAjYOLYL+LAwZA0o6mziangpXQYLZUiGFF0bEtWwDWk
         1jOMy7KYCEZf9DPIoOukCHn5DGHKuetX8CR9DYQ2l76e0gUV09/cLqKF470jWRPxT6JJ
         VR+g==
X-Forwarded-Encrypted: i=1; AJvYcCVghQ+FH/E4aPQLIWjpV1XCPaVMJwLwAK0sTl26a8eV+pBzcOX94uBGVHR677XTgKAfpVEWAw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyRnz2SuuJ9z51Gqqs0Lk+NbW7IXgEZARPjyyeNES2us39mLaFR
	LeYLRnppvebZdzFXVUdBYhL0/FqUepAZLqZFIG3H4l5HHY008zxM/vhCDGjJiVAO6ub3hzsXRL7
	adWOlLL0+LU+76gFn6w==
X-Google-Smtp-Source: AGHT+IETZEnQ1fnebG+EPXz8EIs4aUlnfPIGCh4puq8YWTGEpiNjSNK1+MOm9oAvMrmsXQRIpafhM24FzfM8r9f8
X-Received: from pgct9.prod.google.com ([2002:a05:6a02:5289:b0:aef:faff:6861])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:c901:b0:1f5:7f45:7f8a with SMTP id adf61e73a8af0-1fd13ed2b9fmr2759978637.38.1742435773077;
 Wed, 19 Mar 2025 18:56:13 -0700 (PDT)
Date: Wed, 19 Mar 2025 18:55:43 -0700
In-Reply-To: <20250320015551.2157511-1-changyuanl@google.com>
Mime-Version: 1.0
References: <20250320015551.2157511-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250320015551.2157511-9-changyuanl@google.com>
Subject: [PATCH v5 08/16] kexec: add KHO parsing support
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
X-CRM114-CacheID: sfid-20250319_185614_565107_1A38C3BE 
X-CRM114-Status: GOOD (  34.14  )
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

From: Alexander Graf <graf@amazon.com>

When we have a KHO kexec, we get an FDT blob and scratch region to
populate the state of the system. Provide helper functions that allow
architecture code to easily handle memory reservations based on them and
give device drivers visibility into the KHO FDT and memory reservations
so they can recover their own state.

Signed-off-by: Alexander Graf <graf@amazon.com>
Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Co-developed-by: Changyuan Lyu <changyuanl@google.com>
Signed-off-by: Changyuan Lyu <changyuanl@google.com>
---
 include/linux/kexec_handover.h |  48 ++++++
 kernel/kexec_handover.c        | 302 ++++++++++++++++++++++++++++++++-
 mm/memblock.c                  |   1 +
 3 files changed, 350 insertions(+), 1 deletion(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 9cd9ad31e2d1..c665ff6cd728 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -35,6 +35,10 @@ struct kho_node {
 	bool visited;
 };
 
+struct kho_in_node {
+	int offset;
+};
+
 #ifdef CONFIG_KEXEC_HANDOVER
 bool kho_is_enabled(void);
 void kho_init_node(struct kho_node *node);
@@ -51,6 +55,19 @@ int register_kho_notifier(struct notifier_block *nb);
 int unregister_kho_notifier(struct notifier_block *nb);
 
 void kho_memory_init(void);
+
+void kho_populate(phys_addr_t handover_fdt_phys, phys_addr_t scratch_phys,
+		  u64 scratch_len);
+
+int kho_get_node(const struct kho_in_node *parent, const char *name,
+		 struct kho_in_node *child);
+int kho_get_nodes(const struct kho_in_node *parent,
+		  int (*func)(const char *, const struct kho_in_node *, void *),
+		  void *data);
+const void *kho_get_prop(const struct kho_in_node *node, const char *key,
+			 u32 *size);
+int kho_node_check_compatible(const struct kho_in_node *node,
+			      const char *compatible);
 #else
 static inline bool kho_is_enabled(void)
 {
@@ -104,6 +121,37 @@ static inline int unregister_kho_notifier(struct notifier_block *nb)
 static inline void kho_memory_init(void)
 {
 }
+
+static inline void kho_populate(phys_addr_t handover_fdt_phys,
+				phys_addr_t scratch_phys, u64 scratch_len)
+{
+}
+
+static inline int kho_get_node(const struct kho_in_node *parent,
+			       const char *name, struct kho_in_node *child)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int kho_get_nodes(const struct kho_in_node *parent,
+				int (*func)(const char *,
+					    const struct kho_in_node *, void *),
+				void *data)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline const void *kho_get_prop(const struct kho_in_node *node,
+				       const char *key, u32 *size)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static inline int kho_node_check_compatible(const struct kho_in_node *node,
+					    const char *compatible)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_KEXEC_HANDOVER */
 
 #endif /* LINUX_KEXEC_HANDOVER_H */
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index df0d9debbb64..6ebad2f023f9 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -73,6 +73,20 @@ static struct kho_out kho_out = {
 	.fdt_max = 10 * SZ_1M,
 };
 
+struct kho_in {
+	struct debugfs_blob_wrapper fdt_wrapper;
+	struct dentry *dir;
+	phys_addr_t kho_scratch_phys;
+	phys_addr_t fdt_phys;
+};
+
+static struct kho_in kho_in;
+
+static const void *kho_get_fdt(void)
+{
+	return kho_in.fdt_phys ? phys_to_virt(kho_in.fdt_phys) : NULL;
+}
+
 int register_kho_notifier(struct notifier_block *nb)
 {
 	return blocking_notifier_chain_register(&kho_out.chain_head, nb);
@@ -85,6 +99,144 @@ int unregister_kho_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(unregister_kho_notifier);
 
+/**
+ * kho_get_node - retrieve a node saved in KHO FDT.
+ * @parent: the parent node to look up for.
+ * @name: the name of the node to look for.
+ * @child: if a node named @name is found under @parent, it is stored in @child.
+ *
+ * If @parent is NULL, this function looks up for @name under KHO root node.
+ *
+ * Return: 0 on success, and @child is populated, error code on failure.
+ */
+int kho_get_node(const struct kho_in_node *parent, const char *name,
+		 struct kho_in_node *child)
+{
+	int parent_offset = 0;
+	int offset = 0;
+	const void *fdt = kho_get_fdt();
+
+	if (!fdt)
+		return -ENOENT;
+
+	if (!child)
+		return -EINVAL;
+
+	if (parent)
+		parent_offset = parent->offset;
+
+	offset = fdt_subnode_offset(fdt, parent_offset, name);
+	if (offset < 0)
+		return -ENOENT;
+
+	child->offset = offset;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kho_get_node);
+
+/**
+ * kho_get_nodes - iterate over all direct child nodes.
+ * @parent: the parent node to look for child nodes.
+ * @func: a function pointer to be called on each child node.
+ * @data: auxiliary data to be passed to @func.
+ *
+ * For every direct child node of @parent, @func is called with the child node
+ * name, the child node (a struct kho_in_node *), and @data.
+ *
+ * If @parent is NULL, this function iterates over the child nodes of the KHO
+ * root node.
+ *
+ * Return: 0 on success, error code on failure.
+ */
+int kho_get_nodes(const struct kho_in_node *parent,
+		  int (*func)(const char *, const struct kho_in_node *, void *),
+		  void *data)
+{
+	int parent_offset = 0;
+	struct kho_in_node child;
+	const char *name;
+	int ret = 0;
+	const void *fdt = kho_get_fdt();
+
+	if (!fdt)
+		return -ENOENT;
+
+	if (parent)
+		parent_offset = parent->offset;
+
+	fdt_for_each_subnode(child.offset, fdt, parent_offset) {
+		if (child.offset < 0)
+			return -EINVAL;
+
+		name = fdt_get_name(fdt, child.offset, NULL);
+
+		if (!name)
+			return -EINVAL;
+
+		ret = func(name, &child, data);
+
+		if (ret < 0)
+			break;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(kho_get_nodes);
+
+/**
+ * kho_get_prop - retrieve the property data stored in the KHO tree.
+ * @node: the node to look up for.
+ * @key: the key of the property.
+ * @size: a pointer to store the size of the data in bytes.
+ *
+ * Return: pointer to the data, and data size is stored in @size, or NULL on
+ * failure.
+ */
+const void *kho_get_prop(const struct kho_in_node *node, const char *key,
+			 u32 *size)
+{
+	int offset = 0;
+	u32 s;
+	const void *fdt = kho_get_fdt();
+
+	if (!fdt)
+		return NULL;
+
+	if (node)
+		offset = node->offset;
+
+	if (!size)
+		size = &s;
+
+	return fdt_getprop(fdt, offset, key, size);
+}
+EXPORT_SYMBOL_GPL(kho_get_prop);
+
+/**
+ * kho_node_check_compatible - check a node's compatible property.
+ * @node: the node to check.
+ * @compatible: the compatible stirng.
+ *
+ * Wrapper of fdt_node_check_compatible().
+ *
+ * Return: 0 if @compatible is in the node's "compatible" list, or
+ * error code on failure.
+ */
+int kho_node_check_compatible(const struct kho_in_node *node,
+			      const char *compatible)
+{
+	int result = 0;
+	const void *fdt = kho_get_fdt();
+
+	if (!fdt)
+		return -ENOENT;
+
+	result = fdt_node_check_compatible(fdt, node->offset, compatible);
+
+	return result ? -EINVAL : 0;
+}
+EXPORT_SYMBOL_GPL(kho_node_check_compatible);
+
 /* Helper functions for KHO state tree */
 
 struct kho_prop {
@@ -605,6 +757,32 @@ static int scratch_len_show(struct seq_file *m, void *v)
 }
 DEFINE_SHOW_ATTRIBUTE(scratch_len);
 
+/* Handling for debugfs/kho/in */
+static __init int kho_in_debugfs_init(const void *fdt)
+{
+	struct dentry *file;
+	int err;
+
+	kho_in.dir = debugfs_create_dir("in", debugfs_root);
+	if (IS_ERR(kho_in.dir))
+		return PTR_ERR(kho_in.dir);
+
+	kho_in.fdt_wrapper.size = fdt_totalsize(fdt);
+	kho_in.fdt_wrapper.data = (void *)fdt;
+	file = debugfs_create_blob("fdt", 0400, kho_in.dir,
+				   &kho_in.fdt_wrapper);
+	if (IS_ERR(file)) {
+		err = PTR_ERR(file);
+		goto err_rmdir;
+	}
+
+	return 0;
+
+err_rmdir:
+	debugfs_remove(kho_in.dir);
+	return err;
+}
+
 static __init int kho_out_debugfs_init(void)
 {
 	struct dentry *dir, *f;
@@ -644,6 +822,7 @@ static __init int kho_out_debugfs_init(void)
 static __init int kho_init(void)
 {
 	int err;
+	const void *fdt = kho_get_fdt();
 
 	if (!kho_enable)
 		return 0;
@@ -663,6 +842,21 @@ static __init int kho_init(void)
 	if (err)
 		goto err_free_scratch;
 
+	if (fdt) {
+		err = kho_in_debugfs_init(fdt);
+		/*
+		 * Failure to create /sys/kernel/debug/kho/in does not prevent
+		 * reviving state from KHO and setting up KHO for the next
+		 * kexec.
+		 */
+		if (err)
+			pr_err("failed exposing handover FDT in debugfs\n");
+
+		kho_scratch = __va(kho_in.kho_scratch_phys);
+
+		return 0;
+	}
+
 	for (int i = 0; i < kho_scratch_cnt; i++) {
 		unsigned long base_pfn = PHYS_PFN(kho_scratch[i].addr);
 		unsigned long count = kho_scratch[i].size >> PAGE_SHIFT;
@@ -859,7 +1053,113 @@ static void __init kho_reserve_scratch(void)
 	kho_enable = false;
 }
 
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
+	if (!kho_get_fdt())
+		kho_reserve_scratch();
+	else
+		kho_release_scratch();
+}
+
+void __init kho_populate(phys_addr_t handover_fdt_phys,
+			 phys_addr_t scratch_phys, u64 scratch_len)
+{
+	void *handover_fdt;
+	struct kho_scratch *scratch;
+	u32 fdt_size = 0;
+
+	/* Determine the real size of the FDT */
+	handover_fdt =
+		early_memremap(handover_fdt_phys, sizeof(struct fdt_header));
+	if (!handover_fdt) {
+		pr_warn("setup: failed to memremap kexec FDT (0x%llx)\n",
+			handover_fdt_phys);
+		return;
+	}
+
+	if (fdt_check_header(handover_fdt)) {
+		pr_warn("setup: kexec handover FDT is invalid (0x%llx)\n",
+			handover_fdt_phys);
+		early_memunmap(handover_fdt, sizeof(struct fdt_header));
+		return;
+	}
+
+	fdt_size = fdt_totalsize(handover_fdt);
+	kho_in.fdt_phys = handover_fdt_phys;
+
+	early_memunmap(handover_fdt, sizeof(struct fdt_header));
+
+	/* Reserve the DT so we can still access it in late boot */
+	memblock_reserve(handover_fdt_phys, fdt_size);
+
+	kho_in.kho_scratch_phys = scratch_phys;
+	kho_scratch_cnt = scratch_len / sizeof(*kho_scratch);
+	scratch = early_memremap(scratch_phys, scratch_len);
+	if (!scratch) {
+		pr_warn("setup: failed to memremap kexec scratch (0x%llx)\n",
+			scratch_phys);
+		return;
+	}
+
+	/*
+	 * We pass a safe contiguous blocks of memory to use for early boot
+	 * purporses from the previous kernel so that we can resize the
+	 * memblock array as needed.
+	 */
+	for (int i = 0; i < kho_scratch_cnt; i++) {
+		struct kho_scratch *area = &scratch[i];
+		u64 size = area->size;
+
+		memblock_add(area->addr, size);
+
+		if (WARN_ON(memblock_mark_kho_scratch(area->addr, size))) {
+			pr_err("Kexec failed to mark the scratch region. Disabling KHO revival.");
+			kho_in.fdt_phys = 0;
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
index d5d406a5160a..d28abf3def1c 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2374,6 +2374,7 @@ void __init memblock_free_all(void)
 	free_unused_memmap();
 	reset_all_zones_managed_pages();
 
+	memblock_clear_kho_scratch_only();
 	pages = free_low_memory_core_early();
 	totalram_pages_add(pages);
 }
-- 
2.48.1.711.g2feabab25a-goog


