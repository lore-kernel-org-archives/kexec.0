Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE5A5C36010
	for <kexec@archiver.kernel.org>; Fri, 11 Apr 2025 06:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kA+rlZCcqa8ZBpJsZPffMW5upf9/jLnF7y6wsXcCijE=; b=nfUYRYjyUGTslc+dFygW061cdZ
	mWNgFIqTR7VRVl8bA4bZbjHA7RWwNpag0Z+7muof55pNC2HCean8q1jc21OQYTbXoZ0ts+1tDj9zY
	SgInhX04emw6nclpN2eplZL8IBOrH9uzuc7XSH/L5FsZne7tz91lyvXKIVKF9sr+dUVs4aNWIgT+A
	1b9VUlpwx3tRjvnWXJyYpJVNnP+VujehXSEF4C1LzNEwOedlAXVfzi4+lJqHd3vjI1NOC1MDlqYD4
	BzKy5mkuVFKXI4O6koalFTVzcOndcIS/Iuqr1JcApgaHS6qBEJ/+GqeiVvDWyoiZqysf26OToPeZj
	EituIT0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u37TB-0000000CejF-3HSb;
	Fri, 11 Apr 2025 06:02:29 +0000
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u376B-0000000CYfU-36nY
	for kexec@lists.infradead.org;
	Fri, 11 Apr 2025 05:38:45 +0000
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-2240a96112fso23110185ad.2
        for <kexec@lists.infradead.org>; Thu, 10 Apr 2025 22:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744349922; x=1744954722; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kA+rlZCcqa8ZBpJsZPffMW5upf9/jLnF7y6wsXcCijE=;
        b=KFPP1/lkCn7sxWRm+/I62n9ZvxX7TXnlgahmi3O2cGo9Aj6vOy7SZj9Ce6VUiHGrad
         5Hj4hhXr+78St8GWMOjPZCSXMN6dqa03jG2+L3eWmDFoWdgJNSAyMH4mqH77UOgmg+FO
         icpN8K4e5PkKMIrjSG322iAphXBOzDPHP/n4pTdzQktocVYX3X3Om2xIdAR+YPT3m693
         po7D3l2QPZjr/+iqK8ceuHgTxskdZFAHNV6DE817O2A8MXWJivp1dXwYlGZefsHkoi2x
         WgCaYNuH9KXdJYOqHSLThvIcNtWpfeO0ZX508bRFxnIJeTLSnRKGco1F40c6rFl7dEE6
         U9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744349922; x=1744954722;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kA+rlZCcqa8ZBpJsZPffMW5upf9/jLnF7y6wsXcCijE=;
        b=uxwOoa0MbHY4hnGExzv6DSYYJcZMdKPfeIODpu6CShOtem1L8UJov+zsqTGEGJuaNx
         9sA0g4BcJUrrNSq2Ec8NioB9TUIcXp7Ua72V1mvMKI8m1Osoq9V36nWzIVfp7TDk+zor
         qceqo5kV9/ALq/v/ruRI+a0bWKK8upnn1TvyK2F7N23TF86jxsjEMMBFVyVXpCkdkdyO
         Uh0Vwvy3XnBMWiF1be/GRv08tlVEhyF9ff3Qv4sXpTGzD36XWQLPHf8Xjv087itofdTO
         NwGHHnA8GTRdeD5FPOVpItoEQ9nUciQCFnG8wUEuenzcUUccjX5CD+l7JGEPfF1Lj/5H
         GnCg==
X-Forwarded-Encrypted: i=1; AJvYcCU1T1anaGReuVR2JhY1T2TK4/ZozHVt4PRufi2n1Q3L2gtyPwhaXt17NJRlduvcUrYxCga8uA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwF3CnzETcwhvvleS4cSY4HTOluQL1I/yThoK4z2EaMJkPQEHry
	4fKgvROYAfVAMEEwyY0peMocWI5m26V/itanZhAt4H5oXgnLDw08NOmy2f/DhYzPwj0Oz6gtGaO
	vO/Oof/pwZsGrupKpjA==
X-Google-Smtp-Source: AGHT+IFMNgH3FeNkL43VcSwOV5hq+5tHGG0G6gtWFb6aZTBEqWyHMIBbsA40BOUPJoyVSd2JH8itZpILADhQmm2q
X-Received: from plbjg10.prod.google.com ([2002:a17:903:26ca:b0:223:f321:1a96])
 (user=changyuanl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:fc4d:b0:224:1ce1:a3f4 with SMTP id d9443c01a7336-22bea4a1e8bmr23409575ad.1.1744349922412;
 Thu, 10 Apr 2025 22:38:42 -0700 (PDT)
Date: Thu, 10 Apr 2025 22:37:43 -0700
In-Reply-To: <20250411053745.1817356-1-changyuanl@google.com>
Mime-Version: 1.0
References: <20250411053745.1817356-1-changyuanl@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250411053745.1817356-13-changyuanl@google.com>
Subject: [PATCH v6 12/14] memblock: add KHO support for reserve_mem
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
X-CRM114-CacheID: sfid-20250410_223843_795148_698FB220 
X-CRM114-Status: GOOD (  19.90  )
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

Linux has recently gained support for "reserve_mem": A mechanism to
allocate a region of memory early enough in boot that we can cross our
fingers and hope it stays at the same location during most boots, so we
can store for example ftrace buffers into it.

Thanks to KASLR, we can never be really sure that "reserve_mem"
allocations are static across kexec. Let's teach it KHO awareness so
that it serializes its reservations on kexec exit and deserializes them
again on boot, preserving the exact same mapping across kexec.

This is an example user for KHO in the KHO patch set to ensure we have
at least one (not very controversial) user in the tree before extending
KHO's use to more subsystems.

Signed-off-by: Alexander Graf <graf@amazon.com>
Co-developed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Co-developed-by: Changyuan Lyu <changyuanl@google.com>
Signed-off-by: Changyuan Lyu <changyuanl@google.com>
---
 mm/memblock.c | 205 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 205 insertions(+)

diff --git a/mm/memblock.c b/mm/memblock.c
index 456689cb73e20..3571a859f2fe1 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -18,6 +18,11 @@
 #include <linux/memblock.h>
 #include <linux/mutex.h>
 
+#ifdef CONFIG_KEXEC_HANDOVER
+#include <linux/libfdt.h>
+#include <linux/kexec_handover.h>
+#endif /* CONFIG_KEXEC_HANDOVER */
+
 #include <asm/sections.h>
 #include <linux/io.h>
 
@@ -2475,6 +2480,201 @@ int reserve_mem_release_by_name(const char *name)
 	return 1;
 }
 
+#ifdef CONFIG_KEXEC_HANDOVER
+#define MEMBLOCK_KHO_FDT "memblock"
+#define MEMBLOCK_KHO_NODE_COMPATIBLE "memblock-v1"
+#define RESERVE_MEM_KHO_NODE_COMPATIBLE "reserve-mem-v1"
+static struct page *kho_fdt;
+
+static int reserve_mem_kho_finalize(struct kho_serialization *ser)
+{
+	int err = 0, i;
+
+	if (!reserved_mem_count)
+		return NOTIFY_DONE;
+
+	if (IS_ERR(kho_fdt)) {
+		err = PTR_ERR(kho_fdt);
+		pr_err("memblock FDT was not prepared successfully: %d\n", err);
+		return notifier_from_errno(err);
+	}
+
+	for (i = 0; i < reserved_mem_count; i++) {
+		struct reserve_mem_table *map = &reserved_mem_table[i];
+
+		err |= kho_preserve_phys(ser, map->start, map->size);
+	}
+
+	err |= kho_preserve_folio(ser, page_folio(kho_fdt));
+	err |= kho_add_subtree(ser, MEMBLOCK_KHO_FDT, page_to_virt(kho_fdt));
+
+	return notifier_from_errno(err);
+}
+
+static int reserve_mem_kho_notifier(struct notifier_block *self,
+				    unsigned long cmd, void *v)
+{
+	switch (cmd) {
+	case KEXEC_KHO_FINALIZE:
+		return reserve_mem_kho_finalize((struct kho_serialization *)v);
+	case KEXEC_KHO_ABORT:
+		return NOTIFY_DONE;
+	default:
+		return NOTIFY_BAD;
+	}
+}
+
+static struct notifier_block reserve_mem_kho_nb = {
+	.notifier_call = reserve_mem_kho_notifier,
+};
+
+static void __init prepare_kho_fdt(void)
+{
+	int err = 0, i;
+	void *fdt;
+
+	if (!reserved_mem_count)
+		return;
+
+	kho_fdt = alloc_page(GFP_KERNEL);
+	if (!kho_fdt) {
+		kho_fdt = ERR_PTR(-ENOMEM);
+		return;
+	}
+
+	fdt = page_to_virt(kho_fdt);
+
+	err |= fdt_create(fdt, PAGE_SIZE);
+	err |= fdt_finish_reservemap(fdt);
+
+	err |= fdt_begin_node(fdt, "");
+	err |= fdt_property_string(fdt, "compatible", MEMBLOCK_KHO_NODE_COMPATIBLE);
+	for (i = 0; i < reserved_mem_count; i++) {
+		struct reserve_mem_table *map = &reserved_mem_table[i];
+
+		err |= fdt_begin_node(fdt, map->name);
+		err |= fdt_property_string(fdt, "compatible", RESERVE_MEM_KHO_NODE_COMPATIBLE);
+		err |= fdt_property(fdt, "start", &map->start, sizeof(map->start));
+		err |= fdt_property(fdt, "size", &map->size, sizeof(map->size));
+		err |= fdt_end_node(fdt);
+	}
+	err |= fdt_end_node(fdt);
+
+	err |= fdt_finish(fdt);
+
+	if (err) {
+		pr_err("failed to prepare memblock FDT for KHO: %d\n", err);
+		put_page(kho_fdt);
+		kho_fdt = ERR_PTR(-EINVAL);
+	}
+}
+
+static int __init reserve_mem_init(void)
+{
+	if (!kho_is_enabled())
+		return 0;
+
+	prepare_kho_fdt();
+
+	return register_kho_notifier(&reserve_mem_kho_nb);
+}
+late_initcall(reserve_mem_init);
+
+static void *kho_fdt_in __initdata;
+
+static void *__init reserve_mem_kho_retrieve_fdt(void)
+{
+	phys_addr_t fdt_phys;
+	struct folio *fdt_folio;
+	void *fdt;
+	int err;
+
+	err = kho_retrieve_subtree(MEMBLOCK_KHO_FDT, &fdt_phys);
+	if (err) {
+		if (err != -ENOENT)
+			pr_warn("failed to retrieve FDT '%s' from KHO: %d\n",
+				MEMBLOCK_KHO_FDT, err);
+		return ERR_PTR(err);
+	}
+
+	fdt_folio = kho_restore_folio(fdt_phys);
+	if (!fdt_folio) {
+		pr_warn("failed to restore memblock KHO FDT (0x%llx)\n", fdt_phys);
+		return ERR_PTR(-EFAULT);
+	}
+
+	fdt = page_to_virt(folio_page(fdt_folio, 0));
+
+	err = fdt_node_check_compatible(fdt, 0, MEMBLOCK_KHO_NODE_COMPATIBLE);
+	if (err) {
+		pr_warn("FDT '%s' is incompatible with '%s': %d\n",
+			MEMBLOCK_KHO_FDT, MEMBLOCK_KHO_NODE_COMPATIBLE, err);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return fdt;
+}
+
+static bool __init reserve_mem_kho_revive(const char *name, phys_addr_t size,
+					  phys_addr_t align)
+{
+	int err, len_start, len_size, offset;
+	const phys_addr_t *p_start, *p_size;
+	const void *fdt;
+
+	if (!kho_fdt_in)
+		kho_fdt_in = reserve_mem_kho_retrieve_fdt();
+
+	if (IS_ERR(kho_fdt_in))
+		return false;
+
+	fdt = kho_fdt_in;
+
+	offset = fdt_subnode_offset(fdt, 0, name);
+	if (offset < 0) {
+		pr_warn("FDT '%s' has no child '%s': %d\n",
+			MEMBLOCK_KHO_FDT, name, offset);
+		return false;
+	}
+	err = fdt_node_check_compatible(fdt, offset, RESERVE_MEM_KHO_NODE_COMPATIBLE);
+	if (err) {
+		pr_warn("Node '%s' is incompatible with '%s': %d\n",
+			name, RESERVE_MEM_KHO_NODE_COMPATIBLE, err);
+		return false;
+	}
+
+	p_start = fdt_getprop(fdt, offset, "start", &len_start);
+	p_size = fdt_getprop(fdt, offset, "size", &len_size);
+	if (!p_start || len_start != sizeof(*p_start) || !p_size ||
+	    len_size != sizeof(*p_size)) {
+		return false;
+	}
+
+	if (*p_start & (align - 1)) {
+		pr_warn("KHO reserve-mem '%s' has wrong alignment (0x%lx, 0x%lx)\n",
+			name, (long)align, (long)*p_start);
+		return false;
+	}
+
+	if (*p_size != size) {
+		pr_warn("KHO reserve-mem '%s' has wrong size (0x%lx != 0x%lx)\n",
+			name, (long)*p_size, (long)size);
+		return false;
+	}
+
+	reserved_mem_add(*p_start, size, name);
+	pr_info("Revived memory reservation '%s' from KHO\n", name);
+
+	return true;
+}
+#else
+static bool __init reserve_mem_kho_revive(const char *name, phys_addr_t size,
+					  phys_addr_t align)
+{
+	return false;
+}
+#endif /* CONFIG_KEXEC_HANDOVER */
+
 /*
  * Parse reserve_mem=nn:align:name
  */
@@ -2530,6 +2730,11 @@ static int __init reserve_mem(char *p)
 	if (reserve_mem_find_by_name(name, &start, &tmp))
 		return -EBUSY;
 
+	/* Pick previous allocations up from KHO if available */
+	if (reserve_mem_kho_revive(name, size, align))
+		return 1;
+
+	/* TODO: Allocation must be outside of scratch region */
 	start = memblock_phys_alloc(size, align);
 	if (!start)
 		return -ENOMEM;
-- 
2.49.0.604.gff1f9ca942-goog


